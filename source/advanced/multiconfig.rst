.. _advanced-multi-CFG:

Múltiplos arquivos de configuração
==================================

.. contents:: :local:

O MAME tem um poderoso sistema de configuração que permite ajustar as
opções de cada jogo, sistema ou até mesmo um tipo de monitor em
específico de maneira individual, porém requer um cuidado especial na
organização das configurações.

.. raw:: latex

	\clearpage

.. _advanced-multi-cfg-ordem-leitura:

A ordem da leitura dos arquivos
-------------------------------

1. A linha de comando é interpretada primeiro e tem prioridade sobre
   qualquer outro arquivo *.ini*.

2. O ``mame.ini`` (ou qualquer outra plataforma que use um *.ini* como o
   ``mess.ini`` por exemplo) são interpretadas duas vezes. Na primeira
   passada pode alterar várias configurações de caminho, a segunda
   passagem é feita para ver se há um arquivo de configuração válido
   nesse novo local (caso haja, altera as configurações com as
   informações desse arquivo).


3. O ``debug.ini`` se estiver no modo de depuração. Este é um arquivo de
   configuração avançado que a maioria das pessoas não precisam sequer
   se preocupar com ele.

4. Arquivos INI de orientação de tela (seja ``horizont.ini`` ou
   ``vertical.ini``).
   O jogo Pac-Man por exemplo usa uma tela vertical, assim o arquivo
   ``vertical.ini`` é lido. Enquanto jogo **Street Fighter Alpha** é um
   jogo com tela horizontal, assim o arquivo ``horizont.ini`` é lido.

   Geralmente o arquivo ``horizont.ini`` será lodo em sistemas sem
   monitores, com monitores diversos com orientações diferentes ou
   monitores conectados em dispositivos de slot.


5. Arquivos INI voltado para diferentes sistemas (``arcade.ini``,
   ``console.ini``, ``computer.ini``, ou ``othersys.ini``).
   Tanto o jogo **Pac-Man** quanto o jogo **Street Fighter Alpha**
   são jogos de arcade, então o arquivo a ser lido seria o
   ``arcade.ini``, enquanto um console como o **Atari 2600** o
   ``console.ini`` será lido.

6. Os arquivos INI voltados para diferentes tipos de tela
   (``vector.ini`` para jogos vetoriais, ``raster.ini`` para jogos
   rasterizados, ``lcd.ini`` para jogos em telas de cristal
   líquido (LCD), EL, Plasma).
   Ambos os jogos **Pac-Man** e **Street Fighter Alpha** são jogos
   rasterizados, então o arquivo a ser lido seria o ``raster.ini``,
   enquanto Tempest é um jogo com tela vetorial, então o arquivo
   a ser lido é o ``vector.ini``.
   
   Para sistemas que tenham mais de um monitor como *House Mannequin*,
   que usa um monitor CRT raster e um um par de telas em cristal
   líquido, são lidos os arquivos ``raster.ini`` e ``lcd.ini`` relevantes
   ao primeiro monitor e as outras respectivas telas.

7. Os arquivos INI voltados para arquivos fonte do driver. O MAME
   tentará ler ``source/``\ *<sourcefile>*\ ``.ini`` onde <*sourcefile*>
   é o nome do arquivo de código fonte onde o driver do sistema for
   definido. O código fonte de um sistema pode ser encontrado usando o
   comando **mame -listsource <pattern>**, exemplo. ::

	mame.exe -listsource sfa
	sfa             cps2.cpp

   O Banpresto **Sailor Moon**, Atlus **Dodonpachi** e Nihon System
   **Dangun Feveron** por exemplo, todos rodam em hardware semelhante e
   estão listados no arquivo de código fonte ``cave.cpp``, assim todos
   eles usarão o arquivo ``source/cave.ini`` neste caso.

8. Arquivos INI para BIOS (caso seja aplicável). O **The Last Soldier**
   por exemplo usa a BIOS do **Neo-Geo MVS**, assim o arquivo
   ``neogeo.ini`` será lido. Nenhum arquivo INI será lido em sistemas
   que não usem uma BIOS.

9. Arquivo INI da mesma família. O **The Last Soldier** é um clone do
   **The Last Blade / Bakumatsu Roman - Gekka no Kenshi**, assim o arquivo
   ``lastblad.ini`` será lido. Nenhum arquivo INI da mesma família será
   lido.

10. Arquivo INI do sistema. Usando o exemplo anterior, o arquivo
    ``lastsold.ini`` será lido para o **The Last Soldier**.

.. raw:: latex

	\clearpage

.. _advanced-multi-cfg-exemplo-seq:

Exemplos da sequência de leitura dos arquivos
---------------------------------------------

* O Brix que é um clone de Zzyzzyxx. (**mame brix**)

  1. Linha de comando
  2. ``mame.ini`` (global)
  3. (caso o depurador não esteja habilitado, nenhum arquivo INI extra será lido)
  4. ``vertical.ini`` (orientação de tela)
  5. ``arcade.ini`` (tipo do sistema)
  6. ``raster.ini`` (tipo do monitor)
  7. ``source/jack.ini`` (configuração específica para o driver)
  8. (nenhuma BIOS definida)
  9. ``zzyzzyxx.ini`` (sistema da mesma família)
  10. ``brix.ini`` (sistema)

* Super Street Fighter 2 Turbo (**mame ssf2t**)

  1. Linha de comando
  2. ``mame.ini`` (global)
  3. (caso o depurador não esteja habilitado, nenhum arquivo INI extra será lido)
  4. ``horizont.ini`` (orientação de tela)
  5. ``arcade.ini`` (tipo do sistema)
  6. ``raster.ini`` (tipo do monitor)
  7. ``source/cps2.ini`` (configuração específica para o driver)
  8. (nenhuma BIOS definida)
  9. (nenhum sistema da mesma família)
  10. ``ssf2t.ini`` (sistema)

* Final Arch (**mame finlarch**)

  1. Command line
  2. ``mame.ini`` (global)
  3. (caso o depurador não esteja habilitado, nenhum arquivo INI extra será lido)
  4. ``horizont.ini`` (orientação de tela)
  5. ``arcade.ini`` (tipo do sistema)
  6. ``raster.ini`` (tipo do monitor)
  7. ``source/stv.ini`` (configuração específica para o driver)
  8. ``stvbios.ini`` (BIOS definida)
  9. ``smleague.ini`` (sistema da mesma família)
  10. ``finlarch.ini`` (sistema)

*Lembre-se que os parâmetros na linha de comando tem preferência sobre
todos os outros arquivos!*

.. _advanced-multi-cfg-usando:

Usando diferentes arquivos de configuração
------------------------------------------

O MAME oferece a possibilidade de criar diferentes tipos de configuração
separada por algumas categorias ou pelo nome dos drivers ao invés de
concentrar todas as configurações em um único arquivo como o
``mame.ini``. E para quê isso?

O MAME possuí dezenas de opções disponíveis para configurar outra
dezena de coisas como áudio, vídeo, controladores diversos, etc. Você já
deve ter se dado conta que dependendo do que você precise configurar, o
tamanho da linha de comando pode ficar bem grande e complexa dependendo
do sistema a ser emulado e variar de sistema para sistema. Criando
diferentes tipos de arquivos de configuração torna possível armazenar as
diferentes opções individuais para cada sistema encurtando também o
tamanho da linha de comando uma vez que as opções agora podem ficar
armazenadas em seus respectivos arquivos de configuração.

Podemos citar como exemplo a opção de vídeo, no Windows o MAME por
predefinição escolhe ``d3d`` como a melhor opção, porém caso seja
necessário o uso de outras opções como ``opengl`` ou até mesmo ``gdi``
se for o caso, ao invés de usar esta opção toda a vez que for iniciar
alguma emulação, é possível definir como um padrão para todos os
sistemas dentro do arquivo ``mame.ini``.

O arquivo ``mame.ini`` afeta a configuração de forma global porém
algumas vezes há a necessidade de customizar apenas alguns sistemas em
específico sem que haja qualquer tipo de configuração cruzada onde a
configuração de um sistema afete o outro e vice versa. Como definir uma
configuração apenas para sistemas que usem vetores e você não quer que
essa configuração afete sistemas que usem pixel (raster) por exemplo.

.. raw:: latex

	\clearpage

.. _advanced-multi-cfg-truques:

Truques para tornar a vida mais fácil
-------------------------------------

.. _advanced-multi-cfg-botões-ordem:

Configurando a ordem dos botões
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O MAME por predefinição já assume uma ordem para os botões de um
controle, porém nem sempre essa ordem estará na ordem dos botões
originais de um determinado sistema, sendo necessário a configuração
manual, os exemplos a seguir mostram como alterar essa ordem.

Veja :ref:`Alterando os valores <mamemenu-alt-valores>` antes de
prosseguir.

O processo é muito simples, inicie uma máquina qualquer como
``mame64 galaxian``, depois que a máquina iniciar pressione **TAB** e
selecione **Entrada (esta máquina)**, no campo **P1 BUTTON 1**
(primeiro botão de disparo/tiro do jogador 1) e defina o botão de tiro,
pressione **TAB** novamente para fechar a interface.

Depois de confirmar o funcionamento do botão, pressione **ESQ** para
encerrar a emulação e criar um arquivo ``galaxian.cfg`` no diretório
**cfg**.

.. _advanced-multi-cfg-mais-de-um-botão:

Configurando mais de um botão
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Usando um controle de **Playstation 2** ligado no PC com um adaptador
USB como exemplo, faremos uma configuração de botões para máquinas
**Neo-Geo** executando o comando ``mame64 kof2000``, pressione **TAB**,
depois selecione **Entrada (esta máquina)** e configure os botões com a
ordem de sua preferência.

Dentro do diretório **cfg** será criado um arquivo chamado
``kof2000.cfg``, abra ele em um editor de texto qualquer, no topo do
arquivo modifique o ``<system name=kof2000>`` para
``<system name=default>`` e salve este arquivo no diretório **ctrlr**
como ``neogeo.cfg``. No nosso exemplo a ordem dos botões ficou assim, o
**quadrado** é **soco fraco**, o **triângulo** é **soco forte**, o
**xis** é **chute fraco** e o **círculo** é **chute forte**:

Baixe uma cópia deste arquivo no link ao lado https://pastebin.com/9Xp97xcd

.. code-block:: xml

	
    <?xml version="1.0"?>
    <!-- This file is autogenerated; comments and unknown tags will be stripped -->
    <mameconfig version="10">
    <system name="default">
        <input>
            <port tag=":edge:joy:JOY1" type="P1_BUTTON1" mask="16" defvalue="16">
                <newseq type="standard">
                    JOYCODE_1_BUTTON4
                </newseq>
            </port>
            <port tag=":edge:joy:JOY1" type="P1_BUTTON2" mask="32" defvalue="32">
                <newseq type="standard">
                    JOYCODE_1_BUTTON3
                </newseq>
            </port>
            <port tag=":edge:joy:JOY1" type="P1_BUTTON3" mask="64" defvalue="64">
                <newseq type="standard">
                    JOYCODE_1_BUTTON1
                </newseq>
            </port>
            <port tag=":edge:joy:JOY1" type="P1_BUTTON4" mask="128" defvalue="128">
                <newseq type="standard">
                    JOYCODE_1_BUTTON2
                </newseq>
            </port>
        </input>
      </system>
    </mameconfig>

Agora sempre que quiser usar essa configuração para os botões, basta
usar a opção :ref:`-ctrlr <mame-commandline-ctrlrpath>`, exemplo
``mame64 kof200 -ctrlr neogeo``, você pode também adicionar essa opção
ao seu **mame.ini** porém note que, essa configuração será aplicada em
todas as máquinas!

Para aplicar essa configuração apenas nas máquinas **Neo-Geo**, veja o
capítulo de :ref:`Configuração individual por sistema
<advanced-multi-cfg-configuração-individual>`.

.. _advanced-multi-cfg-botões-combinação:

Combinação de botões
~~~~~~~~~~~~~~~~~~~~

O personagem Zangief do **Street Fighter II** possui um golpe chamado
`Double Lariat <https://streetfighter.fandom.com/wiki/Double_Lariat>`_
que é ativado ao se pressionar os três botões de soco ao
**mesmo tempo**, é possível criar um arquivo de configuração para que
essa ação aconteça ao toque de um botão apenas.

Inicie o MAME com qualquer jogo da série ``mame64 sf2``, pressione
**TAB**, depois selecione **Entrada (esta máquina)**, ao configurar os
botões para os três socos, pressione **Delete** para apagar o valor,
logo depois escolha o botão que deseja ser soco fraco, pressione
**Enter** e escolha quase será o seu botão de **três socos**. Caso
tenha feito tudo certo, deverá aparecer algo como **Joy 1 button 0 or
Joy 1 button 1**, é muito importante aparecer o **OR** entre os botões.

Usando o mesmo controle de **Playstation 2** a ordem dos botões ficou
dessa forma, o **quadrado** é **soco fraco**, o **triângulo** é **soco
forte**, o **Xis** é **chute médio**, o **círculo** é **chute forte**, o
**L1** é **soco médio**, o **R1** é **chute fraco** e o botão **L2**
identificado como **JOYCODE_1_BUTTON5** faz o papel dos **três botões de
soco**:

Baixe uma cópia deste arquivo no link ao lado https://pastebin.com/p6dB9DMy

.. code-block:: xml

	
    <?xml version="1.0"?>
    <mameconfig version="10">
    <system name="default">
        <input>
            <port tag=":IN1" type="P1_BUTTON1" mask="16" defvalue="16">
                <newseq type="standard">
                    JOYCODE_1_BUTTON4 OR JOYCODE_1_BUTTON5
                </newseq>
            </port>
            <port tag=":IN1" type="P1_BUTTON2" mask="32" defvalue="32">
                <newseq type="standard">
                    JOYCODE_1_BUTTON7 OR JOYCODE_1_BUTTON5
                </newseq>
            </port>
            <port tag=":IN1" type="P1_BUTTON3" mask="64" defvalue="64">
                <newseq type="standard">
                    JOYCODE_1_BUTTON1 OR JOYCODE_1_BUTTON5
                </newseq>
            </port>
            <port tag=":IN2" type="P1_BUTTON4" mask="1" defvalue="1">
                <newseq type="standard">
                    JOYCODE_1_BUTTON8
                </newseq>
            </port>
            <port tag=":IN2" type="P1_BUTTON5" mask="2" defvalue="2">
                <newseq type="standard">
                    JOYCODE_1_BUTTON3
                </newseq>
            </port>
            <port tag=":IN2" type="P1_BUTTON6" mask="4" defvalue="4">
                <newseq type="standard">
                    JOYCODE_1_BUTTON2
                </newseq>
            </port>
        </input>
    </system>
    </mameconfig>

Uma nota quanto a configuração acima, ela foi feita no Linux (SDL) e
pode ser que no Windows a definição para o botão **L1** seja alternada
para o botão **L2**, porém basta redefini-lo no Windows ou alterná-lo
para um outro botão qualquer depois.

O mesmo tipo de configuração também se aplica para qualquer máquina,
cito por exemplo as máquinas rítmicas da série **Guitar Freaks**,
**Dance Dance Revolution**, **Beatmania** e tantas outras que em alguns
momentos, necessitam que mais de um botão seja acionado ao mesmo tempo.

Baixe um exemplo de configuração de controle para `Guitar Freaks
<https://pastebin.com/g1iXAB1E>`_ e `Dance Dance Revolution
<https://pastebin.com/rSc4kd5u>`_.

.. _advanced-multi-cfg-configuração-individual:

Configuração individual por sistema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

No diretório **ini** crie um diretório chamado **source** e dentro dele
crie um arquivo chamado ``neogeo.ini``. Neste arquivo nós configuraremos
os seguintes parâmetros:

*	Que a Bios seja a **UniBios v 3.3**
*	Que a minha configuração de controle chamada **neogeo**.
	seja sempre carregada.
*	Que o áudio tenha uma taxa de amostragem com **32000 Hz** [#]_
*	O filtro esteja ativo.
*	O prescale seja maior que **1**.
*	Que a proporção de tela seja mantida.

Assim temos as seguintes opções para o nosso ``neogeo.ini``:

.. code-block:: kconfig

	bios                      unibios33
	ctrlr                     neogeo
	samplerate                32000
	filter                    1
	prescale                  2
	keepaspect                1

Agora sempre que qualquer máquina **Neo-Geo** for iniciada ela sempre
usará estas configurações, todas as outras máquinas não relacionadas
com **Neo-Geo** usarão as configurações predefinidas pelo MAME sem haver
conflitos de configuração, assim como, não será mais necessário
especificar todas essas opções na linha de comando.

.. [#]	De acordo com `este post
		<https://vgmrips.net/forum/viewtopic.php?f=3&t=155>`_ o YM2610
		trabalha com uma taxa de amostragem de 18.5 kHz (18500 Hz), logo
		a configuração de 22050 Hz até 32000 Hz deva ser suficiente uma
		vez que a taxa de amostragem de áudio do MAME é predefinida em
		48 kHz ou 48000 Hz e essa alta taxa de amostragem não traz
		nenhum benefício para a emulação como já foi descrito em
		:ref:`-samplerate <mame-commandline-samplerate>`.
