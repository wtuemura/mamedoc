.. raw:: latex

	\clearpage

Configurações específicas para o Windows
========================================

Nesta seção descrevemos todas as opções de configuração disponível
apenas para a versão nativa do MAME no Windows (não SDL).

Opções de desempenho
--------------------

.. _mame-wcommandline-priority:

**-priority** <*prioridade*>

	Define a prioridade de tarefas (*threads*) usadas pelo MAME. Não há
	nenhuma tarefa predefinida para que não haja interferência com
	outros aplicativos.
	Os valores válidos ficam entre **-15** até **1** onde **1** é a
	maior prioridade.

		O valor predefinido é **0** (**prioridade NORMAL**).

.. _mame-wcommandline-profile:

**-profile** [*n*]

	Faz o uso de um perfil determinado por [*n*].


Configurações de tela inteira
-----------------------------

.. _mame-wcommandline-triplebuffer:

**-[no]triplebuffer** / **-[no]tb**

	Ativa ou não o "triple buffering", buffering é o nome da técnica ou
	função que faz o armazenamento prévio de dados em uma memória
	preliminar. Normalmente o MAME escreve "a seco" diretamente na tela
	sem fazer firulas com a memória preliminar. Porém com essa opção
	ativa o MAME cria e escreve seus ciclos intermediários e em ordem
	usando três memórias preliminares. Essa é uma maneira de tentar
	manter o fluxo contínuo de dados, evitando interrupções. Dentre as
	três, apenas a primeira é exibida, a segunda fica na espera sendo
	acumulada e a terceira fica sendo escrita constantemente.
	A opção ``-triplebuffer`` sobrescreve a opção ``-waitvsync`` caso a
	memória preliminar seja criada com sucesso.
	
	Essa opção não funciona com ``-video gdi``.
	
		O valor predefinido é **Desligado** (**-notriplebuffer**).

.. _mame-wcommandline-fullscreenbrightness:

**-full_screen_brightness** <*valor*> / **-fsb** <*valor*>

	Controla o brilho ou nível de preto da tela.
	Selecionando valores menores (até **0.1**) produzirá uma tela mais
	escura, enquanto valores maiores (até **2.0**) produzirão uma tela
	mais clara.

	Note que nem todas as placa de vídeo são compatíveis com essa opção.
	Essa opção também não funciona com ``-video gdi``.

		O valor predefinido é **1.0**.

.. _mame-wcommandline-fullscreencontrast:

**-full_screen_contrast** <*valor*> / **-fsc** <*valor*>

	Controla o contraste ou nível de branco da tela.
	Selecionando valores menores (até **0.1**) produzirá uma tela mais
	apagada, enquanto valores maiores (até **2.0**) produzirão uma tela
	mais saturada.

	Note que nem todas as placa de vídeo são compatíveis com essa opção.
	Essa opção também não funciona com ``-video gdi``.

		O valor predefinido é **1.0**.

.. raw:: latex

	\clearpage

.. _mame-wcommandline-fullscreengamma:

**-full_screen_gamma** <*valor*> / **-fsg** <*valor*>

	Ajuste de gama da tela, faz o ajuste da escala de luminância da
	tela ajustando o contraste entre o claro e escuro.
	Essa opção não afeta a arte ou outras partes da tela.

	Note que nem todas as placa de vídeo são compatíveis com essa opção.
	Essa opção não funciona com ``-video gdi``.

		O valor predefinido é **1.0**.

Opções para o modo janela
-------------------------

.. _mame-wcommandline-menu:

**-menu** <*valor*>

	Habilita uma barra de menu caso esteja disponível e implementado na
	interface do usuário.

		O valor predefinido é **0**.

.. _mame-wcommandline-attach_window:

**-attach_window**

	Se anexa a uma janela arbitrária.

		Não há valor predefinido.

Opções para a entrada de controle
---------------------------------

.. _mame-wcommandline-duallightgun:

**-[no]dual_lightgun** / **-[no]dual**

	Controla se o MAME tenta ou não rastrear duas pistolas de luz
	conectadas ao mesmo tempo. Essa opção requer ``-lightgun``. Essa
	opção é um quebra galho para ser compatível com certos tipos antigos
	de pistolas de luz. Caso possua múltiplas pistolas de luz
	conectadas, basta apenas usar a opção ``-mouse`` e configurar cada
	pistola individualmente.

		O valor predefinido é **Desligado** (**-nodual_lightgun**).
