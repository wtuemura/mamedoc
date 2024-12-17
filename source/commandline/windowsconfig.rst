.. raw:: latex

	\clearpage

Configurações específicas para o Windows
========================================

Nesta seção, descrevemos todas as opções de configuração disponíveis
apenas para a versão nativa do MAME no Windows (não SDL).


Opções de desempenho
~~~~~~~~~~~~~~~~~~~~

.. _mame-wcommandline-priority:

**-priority** <*prioridade*>

	Define a prioridade de tarefas (*threads*) usadas pelo MAME. Não há
	tarefas predefinidas para não haver interferência com outros
	aplicativos. Os valores válidos variam de ``-15`` a ``1``, sendo
	``1`` a maior prioridade.

		O valor predefinido é ``0`` (**prioridade NORMAL**).


.. _mame-wcommandline-profile:

**-profile** [*n*]

	Faz o uso de um perfil determinado por [*n*].


Configurações de tela inteira
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _mame-wcommandline-triplebuffer:

**-[no]triplebuffer** / **-[no]tb**

	Ativa ou não o "*triple buffering*", buffering é o nome da técnica
	ou função que faz o armazenamento prévio de dados em uma memória
	preliminar. Por analogia, funciona como uma caixa d'água, garantindo
	um fluxo constante na saída mesmo quando está cheia. Normalmente, o
	MAME escreve "a seco" diretamente na tela, sem utilizar a memória
	preliminar. Porém, com essa opção ativa, o MAME cria e escreve seus
	ciclos intermediários em ordem, usando três memórias preliminares.
	Essa é uma maneira de tentar manter o fluxo contínuo de dados,
	evitando interrupções. Dentre as três, apenas a primeira é exibida;
	a segunda fica em espera, sendo acumulada, e a terceira é
	constantemente escrita. A opção ``-triplebuffer`` sobrescreve a
	opção ``-waitvsync`` caso a memória preliminar seja criada com
	sucesso.

	|ngdi|.

		O valor predefinido é **Desligado** (**-notriplebuffer**).


.. _mame-wcommandline-fullscreenbrightness:

**-full_screen_brightness** <*valor*> / **-fsb** <*valor*>

	Controla o brilho ou o nível de preto da tela.
	Selecionando valores menores (até ``0.1``) é possível obter uma tela
	mais escura, enquanto valores maiores (até ``2.0``) resultarão em
	uma tela mais clara.

	Note que nem todas as placas de vídeo são compatíveis com essa
	opção. |ngdi|.

		O valor predefinido é ``1.0``.

.. _mame-wcommandline-fullscreencontrast:

**-full_screen_contrast** <*valor*> / **-fsc** <*valor*>

	Controla o contraste ou o nível de branco da tela.
	Selecionando valores menores (até ``0.1``) é possível obter uma tela
	mais apagada, enquanto valores maiores (até ``2.0``) resultarão em
	uma tela mais saturada.

	Note que nem todas as placa de vídeo são compatíveis com essa opção.
	|ngdi|.

		O valor predefinido é ``1.0``.

.. raw:: latex

	\clearpage

.. _mame-wcommandline-fullscreengamma:

**-full_screen_gamma** <*valor*> / **-fsg** <*valor*>

	Ajuste de gama da tela, faz o ajuste da escala de luminância,
	ajustando o contraste entre o claro e o escuro. Essa opção não
	afeta a ilustração ou outras partes da tela.

	Note que nem todas as placa de vídeo são compatíveis com essa opção.
	|ngdi|.

		O valor predefinido é ``1.0``.


Opções para o modo janela
~~~~~~~~~~~~~~~~~~~~~~~~~


.. _mame-wcommandline-menu:

**-menu** <*valor*>

	Caso esteja disponível e implementado na interface do usuário,
	habilita uma barra de menu.

		O valor predefinido é ``0``.

.. _mame-wcommandline-attach_window:

**-attach_window**

	Se anexa a uma janela arbitrária.

		Não há valor predefinido.


Opções para a entrada de controle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. _mame-wcommandline-duallightgun:

**-[no]dual_lightgun** / **-[no]dual**

	Controla se o MAME tenta ou não rastrear duas pistolas de luz que
	aparecem como um único mouse. Para isso, é necessário que a
	opção :ref:`-lightgun <mame-commandline-nolightgun>` esteja ativada
	e a opção
	:ref:`-lightgunprovider <mame-commandline-lightgunprovider>` esteja
	definida como win32.

	Essa opção suporta configurações mais antigas com duas pistolas de
	luz que funcionam ajustando a localização do ponteiro do mouse no
	momento em que um gatilho da pistola for ativado. Os gatilhos
	primário e secundário no primeiro revólver correspondem,
	respectivamente, ao primeiro e ao segundo botão do mouse, e os
	gatilhos primário e secundário no segundo revólver correspondem,
	respectivamente, ao terceiro e ao quarto botão do mouse.

	Se houver várias pistolas de luz conectadas, provavelmente será
	preciso ativar apenas a opção
	:ref:`-lightgun <mame-commandline-nolightgun>`, usar a opção padrão
	``rawinput`` em
	:ref:`-lightgunprovider <mame-commandline-lightgunprovider>` e
	configurar cada pistola de luz individualmente.

		O valor predefinido é **Desligado** (**-nodual_lightgun**).


.. |ngdi| replace:: Essa opção não funciona com o modo ``-video gdi``
