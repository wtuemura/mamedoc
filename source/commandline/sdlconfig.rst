.. raw:: latex

	\clearpage

Configurações específicas para as versões SDL
=============================================

Nesta seção descreveremos as opções de configuração voltadas
especificamente para qualquer versão MAME que for compatível com o SDL
(incluindo o Windows caso o MAME tenha sido compilado com o SDL ao invés
da sua forma nativa). Inicie o MAME com o comando ``mame -v`` para ver
quais são os drivers que estão disponíveis para o seu sistema, abaixo um
exemplo no Linux.

::

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
veja :ref:`Microsoft Windows <compiling-windows>`.

::

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

Aqui temos as opções disponíveis para a customização em todas as versões
SDL::

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
alguma melhoria do desempenho, a sua sorte pode variar bastante
dependendo do sistema operacional utilizado, da sua placa de vídeo e dos
seus respectivos drivers.

No **Linux** e **macOS** você pode definir estes
parâmetros como variáveis de ambiente no seu ``~/.bashrc`` como por
exemplo::

	export SDL_FRAMEBUFFER_ACCELERATION=opengl
	export SDL_RENDER_DRIVER=opengl
	export SDL_RENDER_OPENGL_SHADERS=1

Antes do executável do MAME::

	SDL_FRAMEBUFFER_ACCELERATION=opengl SDL_RENDER_DRIVER=opengl SDL_RENDER_OPENGL_SHADERS=1 ./mame

Ou então exportando estas opções para o ambiente, elas serão lidas
durante a inicialização do MAME::

	export SDL_FRAMEBUFFER_ACCELERATION=1 SDL_RENDER_DRIVER=opengl SDL_RENDER_OPENGL_SHADERS=1

Já para as versões do **Windows** você pode definir estas opções como
variáveis do ambiente no prompt de comando antes de iniciar o MAME com
os comandos::

	set SDL_FRAMEBUFFER_ACCELERATION=1
	set SDL_RENDER_DRIVER=direct3d11
	set SDL_RENDER_OPENGL_SHADERS=1

Criar um arquivo **.BAT** com estas opções predefinidas dentro do
diretório do MAME, exemplo de um ``run.bat``::

	@echo off
	set SDL_FRAMEBUFFER_ACCELERATION=1
	set SDL_RENDER_DRIVER=direct3d11
	set SDL_RENDER_OPENGL_SHADERS=1
	mame.exe

Ou então deixar isso disponível como variável do sistema, pressione as
teclas :kbd:`WIN` + :kbd:`R` e execute o comando **sysdm.cpl**, siga
para --> :guilabel:`Avançado` --> :guilabel:`Variáveis de Ambiente`, na
parte de baixo da tela onde está escrito :guilabel:`Variáveis do
sistema` clique em :guilabel:`Novo`, na próxima janela que aparecer
adicione o :guilabel:`Nome da variável` que deseja definir, no campo
:guilabel:`Valor` defina o valor apropriado. O valor para
``SDL_RENDER_DRIVER`` seria ``direct3d11`` e assim por diante, reinicie
o computador ou encerre a sessão que estiver usando para que as
alterações sejam aplicadas.

Novamente, não é garantia que ao definir estas opções você note alguma
melhora no desempenho da emulação, tudo vai depender do hardware usado
e seus respectivos drivers.

Para mais informações, consulte a página de
`variáveis <https://wiki.libsdl.org/CategoryHints>`_ do SDL.

.. raw:: latex

	\clearpage

Opções de desempenho
--------------------

.. _mame-scommandline-sdlvideofps:

**-[no]sdlvideofps**

	Ativa a saída de dados para benchmark no subsistema de vídeo SDL
	incluindo o driver de vídeo do seu sistema, o servidor X (caso seja
	aplicável) e stack Opengl em modo ``-video opengl``.

Opções de vídeo
---------------

.. _mame-scommandline-centerh:

**-[no]centerh**

	Centraliza o eixo horizontal da tela.

		O valor predefinido é ``Ligado`` (**-centerh**).

.. _mame-scommandline-centerv:

**-[no]centerv**

	Centraliza o eixo vertical da tela.

		O valor predefinido é ``Ligado`` (**-centerv**).


Configuração para tela inteira
------------------------------

.. _mame-scommandline-useallheads:

**-useallheads**

	Partilha a tela inteira com diferentes monitores.

		O valor predefinido é ``none`` (nenhum).


.. _mame-scommandline-attach_window:

**-attach_window**

	Anexa a tela a uma determinada janela.

		O valor predefinido é ``none`` (nenhum).


Configurações específicas quando o driver de vídeo for software
---------------------------------------------------------------

.. _mame-scommandline-scalemode:

**-scalemode** < ``none`` | ``hwblit`` | ``hwbest`` | ``yv12`` | ``yv12x2`` | ``yuy2`` | ``yuy2x2`` >

	Modos de escala da família de espaços de cor, esta opção funciona
	apenas com **-video soft**.

		O valor predefinido é ``none`` (nenhum).


.. raw:: latex

	\clearpage

Configurações para o mapeamento do teclado
------------------------------------------

.. _mame-scommandline-keymap:

**-keymap**

	Permite que você ative o uso de um mapa de teclado personalizado.

		O valor predefinido é ``Desligado`` (**-nokeymap**).

.. _mame-scommandline-keymapfile:

**-keymap_file** <*arquivo*>
	
	Use em conjunto com **-keymap**, permite que você escolha um
	arquivo com um mapa de teclado customizado, atualmente o MAME já vem
	com um mapa de teclado para o teclado ABNT2 chamado
	**km_br_LINUX.map** no diretório **keymaps**. Um mapa é útil para
	que o mapeamento das teclas já predefinidas coincidam com o mapa de
	um teclado ABNT2 por exemplo, assim a tecla :kbd:`~` (til) que fica
	acima da tecla :kbd:`Tab` no teclado ANSI Americano pode ser
	remapeado para a tecla que fica do lado direito da tecla :kbd:`Ç`
	(cê-cedilha) num teclado ABNT2.
	
	O valor predefinido é ``keymap.dat``.


Configurações de entrada SDL
----------------------------

.. _mame-scommandline-enabletouch:

**-enable_touch**

	Ativa o suporte para entrada por toque. Quando esta opção for
	desativada, será usada a entrada do mouse simulada por dispositivos
	de toque.
	
		O valor predefinido é ``Desligado`` (**-noenable_touch**).


.. _mame-scommandline-sixaxis:

**-sixaxis**

	Use um tratamento especial para lidar com os controles *SixAxis* do
	PS3.
	Pode causar um comportamento indesejado com outros controladores.
	Apenas afeta quando usado com a opção
	:ref:`-joystickprovider sdljoy <mame-commandline-joystickprovider>`.
	
		O valor predefinido é ``Desligado`` (**-nosixaxis**).


.. _mame-scommandline-duallightgun:

**-[no]dual_lightgun** / **-[no]dual**

	Controla se o MAME tenta ou não rastrear duas arma de luz para que
	apareçam como um único mouse. Para isso a opção :ref:`-lightgun
	<mame-commandline-nolightgun>` precisa estar ativada e a opção
	:ref:`-lightgunprovider <mame-commandline-lightgunprovider>` deve
	ser definida como ``sdl``.

	Esta opção oferece suporte a configurações de duas armas que
	funcionam definindo o local do ponteiro do mouse no momento que um
	acionador da arma for ativado. Os acionadores primário e secundário
	da primeira arma correspondem ao primeiro e segundo botões do mouse,
	ja os acionadores primário e secundário do segundo revólver
	correspondem ao terceiro e quarto botões do mouse.

		O valor predefinido é ``Desligado`` (**-nodual_lightgun**).



Mapeamento da pistola de luz SDL
--------------------------------

.. _mame-scommandline-lightgunindex:

::

	-lightgun_index1 <nome>
	-lightgun_index2 <nome>
	...
	-lightgun_index8 <nome>

Nome do dispositivo ou a ID de um determinado slot para a pistola de
luz.

Opções para a configuração dos drivers
--------------------------------------

.. _mame-scommandline-videodriver:

**-videodriver** < ``x11`` | ``directfb`` | ``...`` | ``auto`` >

	Define um driver de vídeo SDL a ser usado, a disponibilidade de
	alguns destes drivers depende do sistema operacional.
	
		O valor predefinido é ``auto``

.. _mame-scommandline-renderdriver:

**-renderdriver** < ``opengl`` | ``directfb`` | ``...`` | ``auto`` >

	Define o driver de renderização SDL a ser usado, a disponibilidade
	de alguns destes drivers depende do sistema operacional.
	
		O valor predefinido é ``auto``

.. _mame-scommandline-audiodriver:

**-audiodriver** < ``pulseaudio`` | ``alsa`` | ``arts`` | ``...`` | ``auto`` >

	Define o driver de áudio SDL a ser usado, a disponibilidade de
	alguns destes drivers depende do sistema operacional.
	
		O valor predefinido é ``auto``

.. _mame-scommandline-gllib:

**-gl_lib** <*driver*>

	Define o **libGL.so** alternativo a ser usado.

		O valor predefinido para o sistema é ``auto``

