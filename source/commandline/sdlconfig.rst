.. raw:: latex

	\clearpage

Configurações específicas para o versões SDL
============================================

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


Configurações específicas quando o driver de vídeo for software
---------------------------------------------------------------

.. _mame-scommandline-scalemode:

**-scalemode** <**none|hwblit|hwbest|yv12|yv12x2|yuy2|yuy2x2**>

	Modos de escala da família de espaços de cor, esta opção funciona
	apenas com **-video soft**.

		O valor predefinido é **none** (nenhum).


.. raw:: latex

	\clearpage

Configurações para o mapeamento de teclado
------------------------------------------

.. _mame-scommandline-keymap:

**-keymap**

	Permite que você habilite o uso de um mapa de teclado customizado.

		O valor predefinido é **Desligado** (**-nokeymap**).

.. _mame-scommandline-keymapfile:

**-keymap_file** <*file*>
	
	Use em conjunto com com **-keymap**, permite que você escolha um
	arquivo com um mapa de teclado customizado, atualmente o MAME já vem
	com um mapa de teclado para o teclado ABNT2 chamado
	**km_br_LINUX.map** no diretório **keymaps**. Um mapa é útil para
	que o mapeamento das teclas já predefinidas coincidam com o mapa de
	um teclado ABNT2 por exemplo, assim a tecla **~** (til) que fica
	acima da tecla TAB no teclado ANSI Americano pode ser remapeado para
	a tecla que fica do lado direito da tecla **Ç** (cê-cedilha) em um
	teclado ABNT2.
	
	O valor predefinido é **keymap.dat**.


Configurações para o mapeamento de controle joystick
----------------------------------------------------

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


.. _mame-scommandline-videodriver:

Opções para a configuração dos drivers
--------------------------------------

**-videodriver** <**x11|directfb|...|auto**>

	Define um driver de vídeo SDL a ser usado, a disponibilidade de
	alguns destes drivers depende do sistema operacional.
	
		O valor predefinido é **auto**

.. _mame-scommandline-renderdriver:

**-renderdriver** <**opengl|directfb|...|auto**>

	Define o driver de renderização SDL a ser usado, a disponibilidade
	de alguns destes drivers depende do sistema operacional.
	
		O valor predefinido é **auto**

.. _mame-scommandline-audiodriver:

**-audiodriver** <**pulseaudio|alsa|arts|...|auto**>

	Define o driver de áudio SDL a ser usado, a disponibilidade de
	alguns destes drivers depende do sistema operacional.
	
		O valor predefinido é **auto**

.. _mame-scommandline-gllib:

**-gl_lib** <*driver*>

	Define o **libGL.so** alternativo a ser usado.

		O valor predefinido para o sistema é **auto**

