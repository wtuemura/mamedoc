.. raw:: latex

	\clearpage

Opções de linha de comando específicos para a versão SDL
========================================================

Nesta seção descreveremos as opções de configuração voltadas
especificamente para qualquer versão compatível com o SDL (incluindo o
Windows caso o MAME tenha sido compilado com o SDL ao invés da sua forma
nativa).

Opções de performance
---------------------

.. _mame-scommandline-sdlvideofps:

**-sdlvideofps**

	Ativa a saída de dados para benchmark no subsistema de vídeo SDL
	incluindo o driver de vídeo do seu sistema, o servidor X (caso seja
	aplicável) e stack Opengl em modo ``-video opengl``.

Opções de vídeo
---------------

.. _mame-scommandline-centerh:

**-[no]centerh**

	Centraliza o eixo horizontal da tela.

		O valor predefinido é **Ligado** (**-centerh**).

.. _mame-scommandline-centerv:

**-[no]centerv**

	Centraliza o eixo vertical da tela.

		O valor predefinido é **Ligado** (**-centerv**).


Opções de software específicos para vídeo
-----------------------------------------

.. _mame-scommandline-scalemode:

**-scalemode**

	Modos de escala da família de espaços de cor: **none**, **async**,
	**yv12**, **yuy2**, **yv12x2**, **yuy2x2** (apenas com **-video
	soft**).

		O valor predefinido é **none** (nenhum).


Mapeamento do teclado SDL
-------------------------

.. _mame-scommandline-keymap:

**-keymap**

	Ativa o mapa de teclado.

		O valor predefinido é **Desligado** (**-nokeymap**).

.. _mame-scommandline-keymapfile:

**-keymap_file** <*file*>
	
	Nome do aquivo de mapa de teclado.
	
	O valor predefinido é **keymap.dat**.

.. raw:: latex

	\clearpage

Mapeamento de joystick SDL
--------------------------

.. _mame-scommandline-joyidx:

::

	-joy_idx1 <name>
	-joy_idx2 <name>
	...
	-joy_idx8 <name>

Nome do controle joystick mapeado para um determinado slot de joystick.

		O valor predefinido é **auto**.

.. _mame-scommandline-sixaxis:

**-sixaxis**

	Usar um tratamento especial para lidar com os controles SixAxis do
	PS3.

		O valor predefinido é **Desligado** (**-nosixaxis**)

Opções de baixo nível para drivers SDL
-------------------------------------- 

.. _mame-scommandline-videodriver:

**-videodriver** <*driver*>

	Define o driver de vídeo SDL a ser usado (**x11**, **directfb** ou
	**auto**).
	
		O valor predefinido é **auto**

.. _mame-scommandline-audiodriver:

**-audiodriver** <*driver*>

	Define o driver de áudio SDL a ser usado (**alsa**, **arts** ou
	**auto**).
	
		O valor predefinido é **auto**

.. _mame-scommandline-gllib:

**-gl_lib** <*driver*>

	Define o **libGL.so** alternativo a ser usado.

		O valor predefinido para o sistema é **auto**

