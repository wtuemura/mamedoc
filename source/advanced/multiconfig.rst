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
separada por algumas categorias ou pelo nome dos drivers em vez de
concentrar todas as configurações em um único arquivo como o
``mame.ini``. E para quê isso?

O MAME possuí dezenas de opções disponíveis para configurar outra
dezena de coisas como áudio, vídeo, controladores diversos, etc. A linha
de comando pode ficar bem grande e complexa dependendo do sistema a ser
emulado e variar de sistema para sistema. Criando diferentes tipos de
arquivos de configuração, é possível armazenar as diferentes opções
individuais para cada sistema encurtando também o tamanho da linha de
comando uma vez que as opções agora podem ficar armazenadas em seus
respectivos arquivos de configuração.

Podemos citar como exemplo a opção de vídeo, no Windows o MAME por
predefinição escolhe ``d3d`` como a melhor opção, porém caso seja
necessário o uso de outras opções como ``opengl`` ou até mesmo ``gdi``
se for o caso, em vez de usar esta opção toda a vez que for iniciar
alguma emulação, é possível definir como um padrão para todos os
sistemas dentro do arquivo ``mame.ini``.

O arquivo ``mame.ini`` afeta a configuração de forma global porém
algumas vezes há a necessidade de customizar apenas alguns sistemas em
específico sem que haja qualquer tipo de configuração cruzada onde a
configuração de um sistema afete o outro e vice versa. Como definir uma
configuração apenas para sistemas que usem vetores sem que essa
configuração afete sistemas que usem pixel (raster) por exemplo.

Aqui uma sugestão de configuração para máquinas **arcade** e **CPS-1**
onde vamos definir diferentes parâmetros porém sem alterar nada em
**mame.ini**.

**Arcade**

	* Crie um arquivo texto chamado ``arcade.ini`` dentro do diretório
	  **ini** e cole estas configurações que vão afetar apenas as
	  máquinas que são consideradas **arcade**:

.. code-block:: kconfig

	video                     opengl
	waitvsync                 0
	snapbilinear              0
	audio_latency             2
	refreshspeed              1
	filter                    0
	window                    1


Note que as opções aqui sugeridas são as mais genéricas possíveis para
que funcionem com a maioria dos computadores, depois que compreender o
conceito utilize as melhores opções que atendam as suas necessidades e
que sejam compatíveis com a sua máquina. Essa configuração cobre o
mínimo necessário e é seguro o suficiente para todas as máquinas na
categoria **arcade**, para mais informações sobre cada opção usada aqui
veja o :ref:`index-commandline`.

Já para configurações específicas voltada para máquinas **CPS-1**
usaremos apenas opções que são relevantes para ela, como quantidade de
botões, taxa de amostragem do áudio, etc.

**CPS-1**

	* Crie o arquivo texto ``cps1.ini`` dentro do diretório
	  **ini\\source**, com as seguintes opções:

.. code-block:: kconfig

	samplerate                32000
	unevenstretch             0
	steadykey                 1
	ctrlr                     6-botoes


Para que a opção **6-botoes** funcione é necessário criar uma
configuração para o controle que estiver usando e salvá-la como
**6-botoes.cfg** no diretório **ctrl**, veja mais detalhes em
:ref:`advanced-tricks-mais-de-um-botão`.

Mesmo sem termos alterado o **mame.ini**, a emulação da máquina **Final
Fight** por exemplo agora roda em uma janela ao invés de tela
inteira, se tentarmos rodar uma outra máquina como a **Super Street
Fighter II: The New Challengers** veremos que ela inicia em tela
inteira e sem qualquer configuração de joystick, isso ocorre porque esta
máquina não roda em hardware **CPS-1** e sim no hardware **CPS-2**.

Então para que as configurações feitas para o sistea **CPS-1** se
apliquem no sistema **CPS-2**, basta copiar e colar o arquivo
``cps1.ini`` e renomear a cópia para ``cps2.ini``. Agora ao rodar
**Super Street Fighter II: The New Challengers** novamente, a emulação
já roda em uma janela e a sua configuração de joystick também já estará
configurada.

Note que em **samplerate** estamos usando **32 kHz** como taxa de
amostragem e por quê não **44.1 kHz** ou **48 kHz** (padrão)?

Como está descrito em :ref:`-samplerate <mame-commandline-samplerate>`,
quanto mais alto a taxa de amostragem mais processamento é exigido e de
contrapartida há uma certa perda de performance dependendo do hardware
que você estiver rodando o MAME, no caso de um computador mediano talvez
a opção não faça a menor diferença, porém caso esteja rodando o MAME em
equipamentos com menos poder de processamento esta opção pode ajudar a
salvar alguns ciclos de processamento que podem ser melhor aproveitados
em outro lugar.

No caso específico do hardware do **CPS-1** segundo mostra o datasheet
do CI responsável pelo som da placa `OKIM6295
<https://vgmrips.net/wiki/Oki_MSM6295>`_ a taxa de amostragem dele fica
entre **25.6 kHz** e **32 kHz**, logo usar **44.1 kHz** e valores mais
altos não vão melhorar a qualidade do som, tanto que se usarmos a taxa
de amostragem mais baixa na máquina **Street Fighter II: The World
Warrior**:

.. code-block:: kconfig

	samplerate                25600

Não há qualquer diferença notável no som e pode ser bem provável que no
hardware original nenhum título talvez chegue a usar o máximo de
**32 kHz**.

O mesmo acontece com o hardware **CPS-2**, segundo mostra o `código
fonte <https://github.com/mamedev/mame/blob/master/src/devices/sound/qsound.cpp>`_
deste driver, a taxa máxima de amostragem é de **24.03846 kHz**. Logo ao
utilizarmos um valor de **32 kHz** estamos dentro de um limite
aceitável.

Jogos como **Final Fight**, **Street Fighter** e tantos outros na época
utilizavam **raster graphics** [#]_, onde a imagem na tela é formada
por pixels, no Brasil estes gráficos são também conhecidos como mapa de
bits ou bitmap. Diferente de hoje, as imagens eram desenhadas em linhas
de escaneamento para formar uma imagem nas antigas tela de tubo de raios
catódicos ou CRT. O efeito era chamado de **scanlines**, tal efeito de
linhas de escaneamento assim como o efeito e os defeitos da telas CRT
podem ser reproduzidas, abordaremos aqui apenas a configuração porém o
assunto já foi abordado nos capítulos sobre :ref:`BGFX <advanced-bgfx>`,
:ref:`GLSL <advanced-glsl>` e :ref:`HLSL <advanced-hlsl>`.

Para aplicar um efeito simples de scanlines em máquinas com **raster
graphics**, crie um arquivo ``raster.ini`` dentro do diretório **ini**:

.. code-block:: kconfig

	prescale                  3
	effect                    scanlines

Agora ao rodar a máquina **Street Fighter II: The World Warrior** você
deve notar algumas linhas de escaneamento na tela, outros efeitos podem
ser baixados do `MameWorld <https://www.mameworld.info/ubbthreads/showflat.php?Cat=&Number=92158&page=0>`_.
Apesar dos efeitos de sobreposição darem apenas um "look" simplificado
de uma tela CRT a sua vantagem é consumir poucos recursos, já para quem
tem um hardware um pouco mais parrudo é aí que entra a simulação da tela
CRT com BGFX, GLSL e HLSL.

.. raw:: latex

	\clearpage

Baixe os shaders GLSL do
`mameau <https://www.mameau.com/linux/mame-glsl-shaders-setup/>`_,
extraia o diretório **osd** no diretório raiz do MAME e experimente esta
configuração no seu arquivo ``ini\\raster.ini``:

**raster.ini**

.. code-block:: kconfig

	filter                  0
	gl_glsl                 1
	gl_glsl_filter          1
	glsl_shader_mame0       osd\shader\glsl_plain
	glsl_shader_mame1       osd\CRT-geom

Rode novamente a máquina **Street Fighter II: The World Warrior** e
repare que a tela já possuí curvatura, linhas de escaneamento,
distorções e outras características semelhantes a uma tela CRT,
incluindo seus defeitos.

Particularmente prefiro apenas manter as características de linhas de
escaneamento sem os defeitos do CRT, sem distorções, saturação, nada.
Gosto de usar o
`pix <http://www.mediafire.com/file/6o3m5vttxtdh7o8/pix.zip>`_ que é um
filtro que evita distorções de pixels (integer scaling) quando você
aumenta a resolução da tela junto com o efeito
`ApertureMRES <https://www.mameworld.info/ubbthreads/showflat.php?Cat=&Number=92158&page=0>`_:

**Minha Configuração**

.. code-block:: kconfig

	filter                  1
	gl_glsl                 1
	gl_glsl_filter          1
	glsl_shader_mame0       glsl\pix\pixellate
	effect                  ApertureMRES

Assim como essas configurações funcionam para arcades é possível
também fazer o mesmo para consoles como o **Sega Genesis/Mega Drive**,
**Super Nintendo** dentre outros.

Lembrando que os consoles também usam **raster graphics!** Tenha certeza
de colocar um **#** na frente de cada opção dentro do arquivo
``raster.ini`` para que o MAME ignore estas opções, troque o nome do
arquivo para ``_raster.ini`` ou apague-o, caso contrário haverá conflito
de configurações gerando alguns efeitos indesejáveis. Para casos como
estes é preferível configurar cada sistema individualmente ou encontrar
uma forma que funcione com todos, faça como preferir.

**Sega Genesis / Mega Drive**

	* Crie um arquivo ``megadriv.ini`` dentro do diretório
	  **ini\\source** com as seguintes opções:

.. code-block:: kconfig

	romapath                  caminho_completo_roms
	samplerate                32000
	steadykey                 1
	ctrlr                     megadrive

**Super Nintendo**

	* Crie um arquivo ``snes.ini`` dentro do diretório **ini\\source**
	  com as seguintes opções:

.. code-block:: kconfig

	romapath                  caminho_completo_roms
	samplerate                32000
	steadykey                 1
	ctrlr                     snes

.. raw:: latex

	\clearpage

**Consoles em geral**

	* Crie o arquivo ``consoles.ini`` dentro do diretório **ini** com as
	  seguintes opções:

.. code-block:: kconfig

	video                   opengl
	snapbilinear            0
	audio_latency           2
	refreshspeed            1
	filter                  1
	gl_glsl                 1
	gl_glsl_filter          1
	glsl_shader_mame0       osd\shader\glsl_plain
	glsl_shader_mame1       osd\CRT-geom

Agora o efeito de tela CRT é aplicado em qualquer máquina definida
**console** pelo MAME assim como ambos os consoles já tem configurado
o caminho para onde está armazenada as suas respectivas ROMs (sim, você
não precisa usar apenas o diretório **roms** para isso, pode ser
qualquer um que desejar) e a configuração de joystick para cada um
deles.

O céu é o limite, na internet é possível encontrar muito mais shaders
como o `MAME-PSGS <https://github.com/mgzme/MAME-PSGS>`_,
`crt-easymode-halation <https://www.reddit.com/r/MAME/comments/8budfa/port_of_crteasymodehalation_shader_for_mame/>`_
e assim por diante.

Apesar de não abordar todas as possibilidades de configurações possíveis
esperamos que estes exemplos tenham lhe ajudado a configurar o MAME de
maneira mais eficiente para cada sistema sem ficar limitado apenas ao
arquivo ``mame.ini``.

.. [#]	https://pt.wikipedia.org/wiki/Raster

.. raw:: latex

	\clearpage
