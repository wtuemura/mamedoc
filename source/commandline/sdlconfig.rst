.. raw:: latex

	\clearpage

Configurações específicas para as versões SDL
=============================================

Nesta seção descreveremos as opções de configuração voltadas
especificamente para qualquer versão compatível com o SDL (incluindo o
Windows caso o MAME tenha sido compilado com o SDL ao invés da sua forma
nativa). Inicie o MAME com o comando ``mame -v`` para ver quais são os
drivers que estão disponíveis para o seu sistema, abaixo um exemplo para
o Linux. ::

	Available videodrivers: x11 wayland KMSDRM dummy
	Current Videodriver: x11
		Display #0
			Renderdrivers:
				opengl		(0x0)
				opengles2	(0x0)
				software	(0x0)
	Available audio drivers:
		pulseaudio          
		alsa                
		dsp                 
		jack                
		disk                
		dummy
	...
	Leave sdlwindow_init
	Enter sdl_info::create
	window: using renderer opengl
	renderer: flag SDL_RENDERER_ACCELERATED
	Leave renderer_sdl2::create
	Audio: Start initialization
	Audio: Driver is pulseaudio
	Audio: frequency: 48000, channels: 2, samples: 256

Aqui temos o exemplo para o Windows das versões do MAME que forem
compiladas com o SDL usando a opção ``OSD=sdl``, para mais informações
veja :ref:`Microsoft Windows <compiling-windows>`. ::

	Available videodrivers: windows dummy
	Current Videodriver: windows
		Display #0
			Renderdrivers:
				direct3d	(0x0)
				direct3d11	(0x0)
				opengl		(0x0)
				opengles2	(0x0)
				software	(0x0)
	Available audio drivers:
		wasapi
		directsound
		winmm
		disk
		dummy
	...
	Leave sdlwindow_init
	Enter sdl_info::create
	window: using renderer direct3d11
	renderer: flag SDL_RENDERER_ACCELERATED
	Leave renderer_sdl2::create
	DirectSound: Primary buffer: 48000 Hz, 16 bits, 2 channels

.. raw:: latex

	\clearpage

Aqui temos opções disponíveis para customização em todas as versões
SDL: ::

	Hints:
		SDL_FRAMEBUFFER_ACCELERATION             (NULL)
		SDL_RENDER_DRIVER                        (NULL)
		SDL_RENDER_OPENGL_SHADERS                (NULL)
		SDL_RENDER_SCALE_QUALITY                 (NULL)
		SDL_RENDER_VSYNC                         (NULL)
		SDL_VIDEO_X11_XVIDMODE                   (NULL)
		SDL_VIDEO_X11_XINERAMA                   (NULL)
		SDL_VIDEO_X11_XRANDR                     (NULL)
		SDL_GRAB_KEYBOARD                        (NULL)
		SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS         (NULL)
		SDL_IOS_IDLE_TIMER_DISABLED              (NULL)
		SDL_IOS_ORIENTATIONS                     (NULL)
		SDL_XINPUT_ENABLED                       (NULL)
		SDL_GAMECONTROLLERCONFIG                 (NULL)
		SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS     (NULL)
		SDL_ALLOW_TOPMOST                        (NULL)
		SDL_TIMER_RESOLUTION                     (NULL)
		SDL_RENDER_DIRECT3D_THREADSAFE           (NULL)
		SDL_VIDEO_ALLOW_SCREENSAVER              (NULL)
		SDL_ACCELEROMETER_AS_JOYSTICK            (NULL)
		SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK   (NULL)
		SDL_VIDEO_WIN_D3DCOMPILER                (NULL)
		SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT      (NULL)
		SDL_VIDEO_MAC_FULLSCREEN_SPACES          (NULL)
		SDL_MOUSE_RELATIVE_MODE_WARP             (NULL)
		SDL_RENDER_DIRECT3D11_DEBUG              (NULL)
		SDL_VIDEO_HIGHDPI_DISABLED               (NULL)
		SDL_WINRT_PRIVACY_POLICY_URL             (NULL)
		SDL_WINRT_PRIVACY_POLICY_LABEL           (NULL)
		SDL_WINRT_HANDLE_BACK_BUTTON             (NULL)

Não há qualquer garantia que ao alterar qualquer uma destas opções traga
alguma melhoria de performance, a sua sorte pode variar bastante
dependendo do sistema operacional usado, da sua placa de vídeo e seus
respectivos drivers.

No **Linux** e **macOS** você pode definir estes
parâmetros como variáveis de ambiente no seu ``~/.bashrc`` como por
exemplo: ::

	SDL_FRAMEBUFFER_ACCELERATION=1
	SDL_RENDER_DRIVER=opengl
	SDL_RENDER_OPENGL_SHADERS=1

Antes do executável do MAME: ::

	SDL_FRAMEBUFFER_ACCELERATION=1 SDL_RENDER_DRIVER=opengl SDL_RENDER_OPENGL_SHADERS=1 ./mame64

Ou então exportando estas opções para o ambiente, elas serão lidas
durante a inicialização do MAME: ::

	export SDL_FRAMEBUFFER_ACCELERATION=1 SDL_RENDER_DRIVER=opengl SDL_RENDER_OPENGL_SHADERS=1

Já para as versões do **Windows** você pode definir estas opções como
variáveis do ambiente no prompt de comando antes de iniciar o MAME com
os comandos:

.. raw:: latex

	\clearpage

::

	set SDL_FRAMEBUFFER_ACCELERATION=1
	set SDL_RENDER_DRIVER=direct3d11
	set SDL_RENDER_OPENGL_SHADERS=1

Criar um arquivo **.BAT** com estas opções predefinidas dentro do
diretório do MAME, exemplo de um ``run.bat``: ::

	@echo off
	set SDL_FRAMEBUFFER_ACCELERATION=1
	set SDL_RENDER_DRIVER=direct3d11
	set SDL_RENDER_OPENGL_SHADERS=1
	mame64.exe

Ou então deixar isso disponível como variável do sistema, pressione as
teclas :kbd:`WIN` + :kbd:`R` e execute o comando **sysdm.cpl**, siga
para --> **Avançado** --> **Variáveis de Ambiente**, na parte de baixo
da tela onde está escrito **Variáveis do sistema** clique em **Novo**,
na próxima janela que aparecer adicione o **Nome da variável** que
deseja definir, no campo **Valor** defina o valor apropriado. O valor
para ``SDL_RENDER_DRIVER`` seria ``direct3d11`` e assim por diante,
reinicie o computador ou encerre a sessão que estiver usando para que as
modificações sejam aplicadas.

Novamente, não é garantia que ao definir estas opções você note alguma
melhora na performance da emulação, tudo vai depender do hardware usado
e seus respectivos drivers.

.. raw:: latex

	\clearpage

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


Configuração para tela inteira
------------------------------

.. _mame-scommandline-useallheads:

**-useallheads**

	Partilha a tela inteira com diferentes monitores.

		O valor predefinido é **none** (nenhum).


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


Configurações para o mapeamento do mouse
----------------------------------------

.. _mame-scommandline-mouseindex:

::

	-mouse_index1
	-mouse_index2
	...
	-mouse_index8

Faça o mapeamento do mouse para uma das 8 entradas.

		O valor predefinido é **auto**.

Configurações para o mapeamento do teclado
------------------------------------------

.. _mame-scommandline-keybidx:

::

	-keyb_idx1
	-keyb_idx2
	...
	-keyb_idx8

Faça o mapeamento do teclado para uma das 8 entradas.

		O valor predefinido é **auto**.


Opções para a configuração dos drivers
--------------------------------------

.. _mame-scommandline-videodriver:

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

