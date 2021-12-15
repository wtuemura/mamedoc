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

O MAME faz a interpretação dos arquivos de configuração na ordem abaixo:

1. A linha de comando é interpretada primeiro e tem prioridade sobre
   qualquer outro arquivo **.ini**.

.. raw:: html

	<p></p>

2. O arquivo ``mame.ini`` (ou qualquer outra plataforma que use um
   *.ini* como o ``mess.ini`` por exemplo) são interpretados duas vezes.
   Na primeira passada é feito a leitura de diferentes configurações, a
   segunda é feita para ver se existe outro arquivo de configuração com
   um outro tipo de configuração válida (caso exista, altera as
   configurações com as informações deste segundo arquivo).

.. raw:: html

	<p></p>

3. O arquivo ``debug.ini`` caso esteja em modo de depuração. Este é um
   arquivo de configuração avançada, a maioria das pessoas não precisam
   sequer se preocupar com ele.

.. raw:: html

	<p></p>

4. Os arquivos INI de orientação da tela (seja o ``horizont.ini`` ou o
   ``vertical.ini``).
   Use o arquivo ``vertical.ini`` para aplicar as configurações numa
   máquina com tela vertical como a **Pac-Man** por exemplo. Já para
   máquinas com tela horizontal, use o arquivo ``horizont.ini`` para
   aplicar as configurações nas máquinas como a
   **Street Fighter Alpha**.

   Geralmente o arquivo ``horizont.ini`` será lido nos sistemas sem
   monitor, nos monitores com diversas orientações diferentes ou
   monitores conectados em dispositivos tipo slot.

.. raw:: html

	<p></p>

5. Arquivos INI voltado para diferentes sistemas (``arcade.ini``,
   ``console.ini``, ``computer.ini`` ou ``othersys.ini``).
   Tanto a máquina **Pac-Man** quanto a máquina **Street Fighter Alpha**
   são jogos classificados como **arcade**, logo, o arquivo
   ``arcade.ini`` é lido para obter as configurações para esta
   categoria, já modelos de console que estejam dentro da categoria
   **console** como o **Atari 2600** o aquivo ``console.ini`` é lido
   para obter configurações que sejam específicas para esta categoria.

.. raw:: html

	<p></p>

6. Os arquivos INI voltados para diferentes tipos de tela como
   ``vector.ini`` para jogos vetoriais, ``raster.ini`` para jogos
   rasterizados, ``lcd.ini`` para jogos ou consoles que usem telas de
   cristal líquido (LCD), EL, plasma, etc.
   Ambas as máquinas como a **Pac-Man** e a **Street Fighter Alpha** são
   rasterizadas [#raster]_ [#raster2]_, assim o arquivo ``raster.ini`` é lido para
   obter e aplicar as configurações específicas deste tipo de máquina,
   já a máquina **Tempest** é uma máquina com tela vetorial, assim o
   arquivo ``vector.ini`` é lido e as configurações vetoriais são
   aplicadas apenas nas máquinas desta categoria.
   
   Para sistemas que tenham mais de um monitor como a
   **House Mannequin** (faça o teste com ``mame housemnq -numscreens
   3``) que usa um monitor *CRT raster* e um par de telas de cristal
   líquido, os arquivos ``raster.ini`` e ``lcd.ini`` são lidos e as suas
   respectivas configurações aplicadas nas suas
   respectivas telas.

.. [#raster]	São imagens compostas por pixels.
.. [#raster2]	https://pt.wikipedia.org/wiki/Raster

.. raw:: html

	<p></p>

7. Os arquivos INI voltados para os arquivos de código fonte (driver).
   O MAME tentará ler ``source/``\ *<sourcefile>*\ ``.ini`` onde
   <*sourcefile*> é o nome do arquivo de código fonte onde a máquina
   estiver definida. O código fonte de um sistema pode ser encontrado
   usando o comando ``mame -listsource <nome_da_rom>``, exemplo::

	mame.exe -listsource sfa
	sfa             cps2.cpp

   A Banpresto **Sailor Moon**, a Atlus **Dodonpachi** e a Nihon System
   **Dangun Feveron** por exemplo, todos rodam num hardware semelhante e
   estão listados no arquivo de código fonte chamado ``cave.cpp``, assim
   sendo, todos eles usarão o arquivo ``source/cave.ini`` para obter as
   suas configurações.

.. raw:: html

	<p></p>

8. Os arquivos INI para BIOS (caso seja aplicável). A máquina
   **The Last Soldier** por exemplo, usa a BIOS do **Neo-Geo MVS**,
   então o arquivo ``neogeo.ini`` será lido. Nenhum arquivo INI será
   lido nos sistemas que não usem uma BIOS.

.. raw:: html

	<p></p>

9. Arquivo INI da mesma família. O **The Last Soldier** é um clone do
   **The Last Blade / Bakumatsu Roman - Gekka no Kenshi**, assim o arquivo
   ``lastblad.ini`` será lido. Nenhum arquivo INI da mesma família será
   lido.

.. raw:: html

	<p></p>

10. Arquivo INI do sistema. Usando o exemplo anterior, o arquivo
    ``lastsold.ini`` será lido para o **The Last Soldier**.

.. raw:: latex

	\clearpage

.. _advanced-multi-cfg-exemplo-seq:

Exemplos da sequência de leitura dos arquivos
---------------------------------------------

* O Brix que é um clone de Zzyzzyxx. (``mame brix``)

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

* Super Street Fighter 2 Turbo (``mame ssf2t``)

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

* Final Arch (``mame finlarch``)

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
concentrar todas as configurações num único arquivo como o
``mame.ini``. E para que isso?

O MAME possuí dezenas de opções disponíveis para configurar outra
dezena de coisas como áudio, vídeo, controladores diversos, etc. A linha
de comando pode ficar bem grande e complexa dependendo do sistema a ser
emulado e variar de sistema para sistema. Ao criar diferentes
configurações é possível individualizar diferentes definições criar
diferentes **perfis** para diferentes tipos de máquinas, sistemas,
dispositivos, etc.

Podemos citar como exemplo a opção de vídeo, por predefinição, no
Windows o MAME escolhe ``d3d`` como a melhor opção, contudo, em sistemas
Windows mais recentes como o Windows 10/11, a melhor opção seria
``bgfx`` em conjunto com um :ref:`bgfx_backend <advanced-bgfx-backend>`
apropriado como o ``d3d12`` ou melhor ainda, o ``vulkan`` caso a sua
placa de vídeo seja compatível. É possível definir essa configuração
como um padrão para todos os sistemas dentro do arquivo ``mame.ini``.

O arquivo ``mame.ini`` afeta a configuração de forma global, ou seja,
tudo o que for configurado nele **vale para tudo** e isso pode causar
diversos problemas. Por exemplo, a máquina **Arkanoid** usa um controle
com um disco giratório (chamado de *spinner controller*), no MAME é
possível usar um joystick, um controle tipo *gamepad* e o mouse.

Porém ao definir ``mouse 1`` no ``mame.ini`` a máquina **Arkanoid**
funcionará perfeitamente com o mouse, mas como o ``mame.ini`` serve como
um arquivo de configuração **global**, a opção ``mouse 1`` faz com que
todas as outras máquinas, ainda que não usem o mouse, passem a usá-lo.
Então ao iniciar a máquina **Street Fighter II** por exemplo, o seu
mouse é sequestrado pelo MAME e assim ficará enquanto o MAME estiver
sendo executado ou até que você pressione a tecla :kbd:`P` para pausar a
emulação e reaver o controle do mouse pelo seu sistema operacional.

No seu desktop talvez isso não seja um problema, contudo, imagine a
mesma situação numa máquina arcade rodando o MAME aonde você não tenha
um acesso fácil ao teclado, ficar "sem mouse" no seu sistema e por não
saber deste detalhe ficar quebrando a cabeça sem entender o que está
acontecendo perdendo horas alterando as configurações.

É para casos como este que as configurações individuais são importantes
e é por isso que é preciso personalizar certas definições em alguns
casos. Usando o **Arkanoid** como exemplo, para que apenas esta máquina
use a opção ``mouse 1``, crie o arquivo ``ini\arkanoid.ini`` e nele
coloque a opção desejada, exemplo::

	mouse 1

Ao salvar o arquivo e ao iniciar a máquina, repare que é possível usar o
mouse como controle. Além desta configuração ser aplicada na máquina
**Arkanoid**, ela também será aplicada em todas as máquinas onde as suas
ROMs comecem com **arkanoid**, exemplo:

.. code-block:: shell

    arkanoid          "Arkanoid (World, older)"
    arkanoidj         "Arkanoid (Japan, newer)"
    arkanoidja        "Arkanoid (Japan, newer w/level select)"
    arkanoidjb        "Arkanoid (Japan, older)"
    arkanoidjbl       "Arkanoid (bootleg with MCU, set 1)"
    arkanoidjbl2      "Arkanoid (bootleg with MCU, set 2)"
    arkanoidu         "Arkanoid (US, newer)"
    arkanoiduo        "Arkanoid (US, older)"

Fazendo assim nós também evitamos um conflito de configurações cruzadas
onde a configuração de um sistema afete o outro e vice versa. Assim
podemos ter configurações específicas para sistemas que usem vetores sem
que estas configurações afete sistemas rasterizados ou sistemas que
sequer usem telas por exemplo.

Criando uma configuração arcade
-------------------------------

Aqui uma sugestão de configuração para máquinas **arcade** e **CPS-1**
onde vamos definir diferentes parâmetros, porém, sem alterar nada no
``mame.ini``, tenham certeza que todas as ROMs estejam na pasta
**roms**, para o nosso exemplo usaremos as ROMs ``sf2.zip``,
``ssf2.zip`` e ``qsound_hle.zip``. Na configuração *arcade* por exemplo,
nós definimos apenas os parâmetros que será genérico para todas as
máquinas desta categoria e assim faremos para a todas as máquinas que
estiverem dentro do driver **CPS-1**.

**Arcade**

	* Crie um arquivo texto chamado ``arcade.ini`` dentro do diretório
	  **ini** e cole estas configurações que vão afetar apenas as
	  máquinas que são consideradas **arcade**:

.. code-block:: shell

    video                     bgfx
    bgfx_backend              vulkan
    snapbilinear              0
    refreshspeed              1
    filter                    0


Observe que as opções sugeridas aqui são as mais genéricas possíveis
para que funcionem com a maioria dos computadores mais recentes cobrindo
o mínimo necessário.

Já nesta outra configuração nós definimos, por exemplo, o controle que
queremos usar **apenas com as máquinas CPS-1** e nenhuma outra.

**CPS-1**

	* Crie o arquivo texto ``cps1.ini`` dentro do diretório
	  **ini\\source**, com as seguintes opções:

.. code-block:: shell

    samplerate                44100
    steadykey                 1
    ctrlr                     6-botoes
    window                    1

Para que a opção **6-botoes** funcione é necessário criar uma
configuração para o controle que estiver usando e salvá-la como
**6-botoes.cfg** no diretório **ctrl**, veja mais detalhes em
:ref:`advanced-tricks-mais-de-um-botão`.

Inicie a máquina **Street Fighter II: The World Warrior** (``mame sf2``)
e repare que mesmo sem alterar o ``mame.ini`` ela inicia numa janela em
vez de tela inteira e o mapeamento dos nossos botões está de acordo com
o que configuramos.

Agora se iniciarmos a máquina **Super Street Fighter II: The New
Challengers** (``mame ssf2``) repare que a emulação começa em **tela
inteira** e o mapeamento dos botões está diferente do que foi
configurado.
Isso acontece porque a máquina pertence a um driver diferente da
**CPS-1**, ela usa o driver para **CPS-2**. Para aplicar as mesmas
configurações para as máquinas do driver **CPS-2**, vá até a pasta
**ini**, copie e cole o arquivo ``cps1.ini``, depois renomeie o arquivo
colado como ``cps2.ini``. Agora ao repetir o teste, a máquina começa
numa janela e com os botões configurados.

Aplicando efeitos na tela
-------------------------

Jogos como **Street Fighter** e tantos outros na época utilizavam
**raster graphics**, onde a imagem na tela é formada por pixels,
no Brasil estes gráficos são também conhecidos como mapa de bits ou
bitmap. Diferente de hoje, as imagens eram desenhadas em linhas de
escaneamento para formar uma imagem nas antigas tela de tubo de raios
catódicos ou CRT. Tal efeito assim como seus defeitos, podem ser
reproduzidas. Abordaremos aqui apenas a configuração básica porém o
assunto já foi abordado nos capítulos sobre
:ref:`BGFX <advanced-bgfx>`, :ref:`GLSL <advanced-glsl>` e
:ref:`HLSL <advanced-hlsl>`.

Para aplicar um simples efeito de scanlines em máquinas com **raster
graphics**, crie o arquivo ``raster.ini`` dentro do diretório **ini**:

.. code-block:: shell

	prescale                  3
	effect                    scanlines

Agora ao rodar a máquina **Street Fighter II: The World Warrior**
(``mame sf2``) note que há algumas linhas na tela, outros efeitos podem
ser baixados do `MameWorld <https://www.mameworld.info/ubbthreads/showflat.php?Cat=&Number=92158&page=0>`_.
Apesar dos efeitos de sobreposição darem apenas uma aparência muito
simplificada de uma tela CRT, a sua vantagem é consumir poucos
recursos, porém há muito tempo que não se utiliza mais a opção
``effect`` já que nos dias de hoje há opções mais modernas. Para quem
tem um hardware um pouco mais sofisticado, use a simulação as opções do
BGFX, GLSL e HLSL.

Baixe os shaders GLSL do
`mameau <https://www.mameau.com/linux/mame-glsl-shaders-setup/>`_,
extraia o diretório **osd** no diretório raiz do MAME e experimente esta
configuração no seu arquivo ``ini\raster.ini``:

**raster.ini**

.. code-block:: shell

	filter                  0
	gl_glsl                 1
	gl_glsl_filter          1
	glsl_shader_mame0       osd\shader\glsl_plain
	glsl_shader_mame1       osd\CRT-geom

Rode novamente a máquina **Street Fighter II: The World Warrior** e
repare que a tela já possuí curvatura, linhas de escaneamento,
distorções e outras características semelhantes a uma tela CRT,
incluindo os seus defeitos.

Particularmente prefiro apenas manter as características das linhas de
escaneamento do CRT sem os defeitos, as distorções, a saturação, nada.
Gosto de usar o
`pix <http://www.mediafire.com/file/6o3m5vttxtdh7o8/pix.zip>`_ que é um
filtro que evita distorções de pixels (integer scaling) quando você
aumenta a resolução da tela junto com o efeito
`ApertureMRES <https://www.mameworld.info/ubbthreads/showflat.php?Cat=&Number=92158&page=0>`_:

**Minha Configuração**

.. code-block:: shell

	filter                  1
	gl_glsl                 1
	gl_glsl_filter          1
	glsl_shader_mame0       glsl\pix\pixellate
	effect                  ApertureMRES

Repare que ao usar o arquivo ``raster.ini`` para armazenar as
configurações dos efeitos da tela, ela também será aplicada em qualquer
outra máquina que seja definida como "raster" como consoles de
video-game, computadores pessoais, etc. Então prefira salvar tais
configurações dentro do arquivo ``arcade.ini``.

Criando configurações específicas para consoles
-----------------------------------------------

Da mesma maneira que estas configurações funcionam com arcades é
possível também fazer o mesmo para consoles como o
**Sega Genesis/Mega Drive**, **Super Nintendo** dentre outros, aqui
alguns exemplos.

**Sega Genesis / Mega Drive**

	* Crie um arquivo ``megadriv.ini`` dentro do diretório
	  **ini\\source** com as seguintes opções:

.. code-block:: shell

    romapath                  mame_rom_dir;caminho_completo_roms
    samplerate                32000
    ctrlr                     megadrive

**Super Nintendo**

	* Crie um arquivo ``snes.ini`` dentro do diretório **ini\\source**
	  com as seguintes opções:

.. code-block:: shell

    romapath                  mame_rom_dir;caminho_completo_roms
    samplerate                32000
    ctrlr                     snes

**Neo Geo**

	* Crie o arquivo ``neogeo.ini`` dentro do diretório **ini\\source**
	  com as seguintes opções:

.. code-block:: shell

    romapath                  mame_rom_dir;caminho_completo_roms
    bios                      unibios40
    ctrlr                     neogeo
    filter                    1
    prescale                  2
    keepaspect                1

Criando configurações para consoles em geral
--------------------------------------------

Da mesma maneira que é possível personalizar a configuração individual
de cada console, também é possível usar 1 arquivo para configurar todas
as máquinas classificadas como console.

**Consoles em geral**

	* Crie o arquivo ``consoles.ini`` dentro do diretório **ini** com as
	  seguintes opções:

.. code-block:: shell

	video                   opengl
	snapbilinear            0
	audio_latency           2
	refreshspeed            1
	filter                  1
	gl_glsl                 1
	gl_glsl_filter          1
	glsl_shader_mame0       osd\shader\glsl_plain
	glsl_shader_mame1       osd\CRT-geom

Nesta configuração nós aplicamos os efeitos de tela em qualquer máquina
definida como **console** e ainda mantemos as configurações individuais
criadas anteriormente, assim nós mantemos as configurações do mapeamento
dos botões do controle por exemplo.

O céu é o limite, na internet é possível encontrar muito mais shaders
como o `MAME-PSGS <https://github.com/mgzme/MAME-PSGS>`_,
`crt-easymode-halation <https://www.reddit.com/r/MAME/comments/8budfa/port_of_crteasymodehalation_shader_for_mame/>`_
e assim por diante.

Apesar de não abordar todas as possibilidades de configurações possíveis
esperamos que estes exemplos sejam suficientes para lhe ajudar a
configurar o MAME de maneira mais eficiente para cada sistema sem ficar
limitado apenas ao arquivo ``mame.ini``.
