.. raw:: latex

	\clearpage

.. _luareference:

As referências das Classes Lua do MAME
======================================

.. contents::
    :local:
    :depth: 2

.. _luareference-intro:

Introdução
----------

Vários aspectos do MAME podem ser controlados usando Lua scripts. Muitas
classes importantes estão expostas como objetos Lua.

.. raw:: latex

	\clearpage

.. _luareference-intro-containers:

Contêineres
~~~~~~~~~~~

Várias propriedades rendem envoltórios dos recipientes. Os envoltórios
dos contêineres são fáceis de serem criados e fornecem uma interface
semelhante a uma tabela só de leitura. A complexidade das operações
podem variar. Os envoltórios dos contêineres geralmente disponibilizam a
maioria destas operações:

**#c**

	Obtém a quantidade dos itens dentro do contêiner.

**c[k]**

	Retorna o item que corresponda a tecla ``k`` ou ``nil`` caso a chave
	não esteja presente.

**pairs(c)**

	Repete o contêiner por chave e por valor. A chave é o que você
	passaria para operador do índice ou o método ``get`` para obter o
	valor.

**ipairs(c)**

	Repete o contêiner através de um índice e de um valor. O índice é o
	que você passaria para ao método ``at`` para obter o valor (pode ser
	o mesmo como a chave para alguns contêineres).

**c:empty()**

	Retorna um Booleano indicando se não há itens no contêiner.

**c:get(k)**

	Retorna o item que corresponda a tecla ``k`` ou ``nil`` caso a chave
	não esteja presente. Normalmente é o equivalente ao operador do
	índice.

**c:at(i)**

	Retorna o valor no índice com base 1 (1-based) ``i`` ou ``nil`` caso
	não esteja fora do alcance.

**c:find(v)**

	Retorna a chave para o item ``v`` ou ``nil`` caso não esteja no
	contêiner. A chave é o que você passaria ao índice do operador para
	obter o valor.

**c:index_of(v)**

	Retorna o índice com base 1 (1-based) para o item ``v`` or ``nil``
	caso não esteja no contêiner. O índice é o que você passaria ao
	método ``at`` para obter o valor.

.. raw:: latex

	\clearpage

.. _luareference-core:

Classes Principais
------------------

Muitas das classes principais do MAME usadas para implementar a emulação
de uma sessão estão disponíveis para os scripts Lua.

.. _luareference-core-mameman:

Gerenciador da máquina do MAME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``mame_machine_manager`` do MAME que contém a
máquina em execução, o gerenciador da IU e os outros componentes
globais.

Instanciação
^^^^^^^^^^^^

**manager**

	O gerenciador da máquina do MAME está disponível como uma variável
	global no ambiente Lua.

Propriedades
^^^^^^^^^^^^

**manager.machine** (somente leitura)

	:ref:`luareference-core-machine` para a sessão da emulação atual.

**manager.ui** (somente leitura)

	:ref:`luareference-core-uiman` para a sessão da emulação atual.

**manager.options** (somente leitura)

	As :ref:`luareference-core-emuopts` para a sessão da emulação atual.

**manager.plugins[]** (somente leitura)

	Obtém informações sobre o
	:ref:`plug-in Lua <luareference-core-plugin>` que estão presentes,
	indexados por nome. Os métodos do índice obtém ``at`` e ``index_of``
	com complexidade O(n).

.. raw:: latex

	\clearpage

.. _luareference-core-machine:

A máquina em execução
~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``running_machine`` do MAME que representa uma
sessão da emulação. Ele fornece acesso aos outros principais objetos
que implementam uma sessão da emulação, bem como a árvore dos
dispositivos emulados.

Instanciação
^^^^^^^^^^^^

**manager.machine**

	Obtém a instância da máquina em execução para a sessão de emulação
	atual.

Métodos
^^^^^^^

**machine:exit()**

	Agenda o encerramento da sessão da emulação atual.
	Isso irá retornar ao menu da seleção do sistema ou encerrar o
	aplicativo, dependendo de como ele foi iniciado.
	Este método retorna imediatamente antes que o encerramento do
	programada ocorra.

**machine:hard_reset()**

	Agenda uma reinicialização a frio. Isso é implementado destruindo a
	sessão da emulação e iniciando outra sessão para o mesmo sistema.
	Este método retorna imediatamente antes que a reinicialização
	programada aconteça.

**machine:soft_reset()**

	Agenda uma reinicialização suave. Isso é implementado chamando o
	método da redefinição do dispositivo principal, que é propagado pela
	árvore dos dispositivos.
	Este método retorna imediatamente antes que a reinicialização
	programada aconteça.

**machine:save(nome_do_arquivo)**

	Agenda o salvamento do estado da máquina no arquivo informado. Caso
	o nome do arquivo seja um caminho relativo, ele será considerado
	relativo ao primeiro diretório do estado de salvamento configurado.
	Este método retorna imediatamente antes que o estado da máquina seja
	salvo. Caso este método seja chamado quando uma operação de salvar
	ou de carregar já esteja pendente, a operação pendente anterior será
	cancelada.

**machine:load(nome_do_arquivo)**

	Agenda o carregamento do estado da máquina a partir do arquivo
	informado. Caso o nome do arquivo seja um caminho relativo, os
	diretórios configurados para do estado de salvamento serão
	pesquisados. Este método retorna imediatamente antes que o estado da
	máquina seja salvo. Caso este método seja chamado quando uma
	operação de salvar ou de carregar já esteja pendente, a operação
	pendente anterior será cancelada.

**machine:popmessage([msg])**

	Exibe uma mensagem pop-up para o usuário. Caso a mensagem não seja
	informada, a mensagem de pop-up exibida no momento (caso haja)
	ficará oculta.

**machine:logerror(msg)**

	Grava a mensagem no log de erros da máquina. Isso pode ser exibido
	em uma janela do depurador, gravado em um arquivo ou gravado na
	saída de erro predefinida.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**machine.system** (somente leitura)

	:ref:`luareference-core-driver` para o sistema atual.

**machine.parameters** (somente leitura)

	O :ref:`gerenciador dos parâmetros <luareference-core-paramman>`
	para a sessão da emulação atual.

**machine.video** (somente leitura)

	O :ref:`gerenciador do vídeo <luareference-core-videoman>` para a
	sessão da emulação atual.

**machine.sound** (somente leitura)

	O :ref:`gerenciador do áudio <luareference-core-soundman>` para a
	sessão da emulação atual.

**machine.output** (somente leitura)

	O :ref:`gerenciador da saída <luareference-core-outputman>` para a
	sessão da emulação atual.

**machine.memory** (somente leitura)

	O :ref:`gerenciador da memória <luareference-mem-manager>` para a
	sessão da emulação atual.

**machine.ioport** (somente leitura)

	O :ref:`gerenciador da porta de E/S <luareference-input-ioportman>`
	para a sessão da emulação atual.

**machine.input** (somente leitura)

	O :ref:`gerenciador da entrada <luareference-input-inputman>` para a
	sessão da emulação atual.

**machine.natkeyboard** (somente leitura)

	Obtém o
	:ref:`gerenciador do teclado natural <luareference-input-natkbd>`,
	usado para controlar a entrada do teclado e do teclado numérico no
	sistema emulado.

**machine.uiinput** (somente leitura)

	O :ref:`gerenciador da entrada da IU <luareference-input-uiinput>`
	para a sessão da emulação atual.

**machine.render** (somente leitura)

	O :ref:`gerenciador do renderizador <luareference-render-manager>`
	para a sessão da emulação atual.

**machine.debugger** (somente leitura)

	O :ref:`gerenciador do depurador <luareference-debug-manager>` para
	a sessão da emulação atual ou ``nil`` se o depurador não estiver
	ativado.

**machine.options** (somente leitura)

	As :ref:`luareference-core-emuopts` definidas pelo usuário para a
	sessão da emulação atual.

**machine.samplerate** (somente leitura)

	A taxa de amostragem da saída do áudio em Hertz.

**machine.paused** (somente leitura)

	Um booleano que indica se a emulação não está em execução no
	momento, geralmente porque a sessão foi pausada ou o sistema emulado
	não concluiu a inicialização.

.. raw:: latex

	\clearpage

**machine.exit_pending** (somente leitura)

	Um booleano que indica se a sessão da emulação está programada para
	encerrar.

**machine.hard_reset_pending** (somente leitura)

	Um booleano que indica se uma reinicialização forçada do sistema
	emulado está pendente.

**machine.devices** (somente leitura)

	:ref:`luareference-dev-enum` que produz todos os
	:ref:`dispositivos <luareference-dev-device>` no sistema que está
	sendo emulado.

**machine.screens** (somente leitura)

	:ref:`luareference-dev-enum` que produz todos os
	:ref:`dispositivos da tela <luareference-dev-screen>` no sistema que
	está sendo emulado.

**machine.cassettes** (somente leitura)

	:ref:`luareference-dev-enum` que produz todos os
	:ref:`dispositivos da imagem em fita cassete
	<luareference-dev-cass>` no sistema que está sendo emulado.

**machine.images** (somente leitura)

	:ref:`luareference-dev-enum` que produz toda a
	:ref:`interface para os dispositivos de imagem
	<luareference-dev-diimage>` no sistema que está sendo emulado.

**machine.slots** (somente leitura)

	:ref:`luareference-dev-enum` que produz toda a
	:ref:`luareference-dev-dislot` no sistema que está sendo emulado.

.. raw:: latex

	\clearpage

.. _luareference-core-videoman:

Gerenciador do vídeo
~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``video_manager`` do MAME que é responsável por
coordenar a exibição do vídeo que está sendo emulado, a aceleração da
velocidade e da leitura de entradas do host.

Instanciação
^^^^^^^^^^^^

**manager.machine.video**

	Obtém o gerenciador do vídeo para a sessão da emulação atual.

Métodos
^^^^^^^

**video:frame_update()**

	Atualiza as telas emuladas, lê as entradas do host e atualiza a
	saída de vídeo.

**video:snapshot()**

	Salva os arquivos da captura da tela de acordo com a configuração
	atual. Caso o MAME esteja configurado para obter as capturas da tela
	emulada de forma nativa, a captura da tela que será salvo será de
	todas as telas que estiverem visíveis numa janela ou da tela do
	host com a configuração da exibição atual.
	Caso o MAME esteja configurado para obter as capturas da tela
	emulada de forma nativa, ou seja, o sistema não tiver uma tela
	emulada, uma captura da tela será salva usando a visualização
	selecionada no momento.

**video:begin_recording([nome_do_arquivo], [formato])**

	Interrompe todas as gravações de vídeo em andamento e começa a
	gravar as telas emuladas que estão visíveis ou a exibição do
	captura da tela atual, dependendo se o MAME está configurado
	para obter as capturas nativas da tela emulada. Caso o nome do
	arquivo não seja informado, a configuração do nome do arquivo da
	captura da tela será usada.
	Caso o nome do arquivo seja um caminho relativo, ele será
	interpretado em relação ao primeiro diretório da configuração da
	captura da tela. Caso o formato seja informado ele deve ser
	``avi`` ou ``mng``. Se não for informado, a predefinição é ``AVI``.

**video:end_recording()**

	Interrompe qualquer gravação de vídeo em andamento.

**video:snapshot_size()**

	Retorna a largura e a altura em pixels das capturas da tela criados
	com a configuração atual do destino e o estado da tela emulada. Isso
	pode ser configurado de forma explicita pelo usuário, calculado com
	base na visualização da captura selecionada e na resolução de
	quaisquer telas visíveis e que estejam sendo emuladas.

**video:snapshot_pixels()**

	Retorna os pixels de uma captura criado usando a configuração do
	destino da captura atual em inteiros com 32 bits e compactados
	em uma string binária na ordem Endian do host. Os pixels são
	organizados em ordem maior da linha, da esquerda para a direita e de
	cima para baixo.  Os valores do pixel são cores no formato RGB
	compactadas em inteiros com 32 bits.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**video.speed_factor** (somente leitura)

	Ajuste de velocidade da emulação configurada em escala de mil (ou
	seja, a proporção para a velocidade normal multiplicada por 1.000).

**video.throttled** (leitura e escrita)

	Um booleano que indica se o MAME deve esperar antes das atualizações
	do vídeo para evitar a execução mais rápida do que a velocidade
	desejada.

**video.throttle_rate** (leitura e escrita)

	A velocidade de emulação desejada como uma proporção da velocidade
	total ajustada através do fator de velocidade (ou seja, 1 é a
	velocidade normal ajustada pelo fator de velocidade, números maiores
	são mais rápidos e números menores são mais lentos).

**video.frameskip** (leitura e escrita)

	A quantidade dos quadros emulados do vídeo para serem ignorados a
	cada doze ou -1 para ajustar automaticamente a quantidade de
	quadros para ignorar visando para manter a velocidade da emulação
	desejada.

**video.speed_percent** (somente leitura)

	A velocidade emulada atualmente em porcentagem da velocidade total
	ajustada pelo fator da velocidade.

**video.effective_frameskip** (somente leitura)

	A quantidade dos doze quadros emulados que são ignorados.

**video.skip_this_frame** (somente leitura)

	Um booleano que indica se o gerenciador do vídeo vai ignorar as
	telas emuladas para o quadro atual.

**video.snap_native** (somente leitura)

	Um booleano que indica se o gerenciador do vídeo fará capturas
	nativa da tela emulada. Além da definição da configuração relevante,
	o sistema emulado deve ter pelo menos uma tela que esteja sendo
	emulada.

**video.is_recording** (somente leitura)

	Um booleano que indica se alguma gravação de vídeo está em
	andamento.

**video.snapshot_target** (somente leitura)

	Um :ref:`alvo do renderizador <luareference-render-target>` usado
	para produzir as capturas da tela e para as gravações de vídeo.

.. raw:: latex

	\clearpage

.. _luareference-core-soundman:

Gerenciador do áudio
~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``sound_manager`` do MAME que gerencia o gráfico do
fluxo do áudio emulado e coordena a sua saída.

Instanciação
^^^^^^^^^^^^

**manager.machine.sound**

	Obtém o gerenciador do áudio para a sessão da emulação atual.

Métodos
^^^^^^^

**sound:start_recording([nome_do_arquivo])**

	Inicia a gravação em um arquivo WAV. Não tem efeito se estiver
	gravando. Caso o nome do arquivo não seja informado usa o nome do
	arquivo WAV configurado (da linha de comando ou do arquivo INI) ou
	não tem efeito se nenhum nome do arquivo WAV estiver configurado.
	Retorna ``true`` se a gravação foi iniciada ou ``false`` se a
	gravação já estiver em andamento, a abertura do arquivo gerado
	falhou ou nenhum nome para o arquivo foi informado ou foi
	configurado.

**sound:stop_recording()**

	Interrompe a gravação e fecha o arquivo se estiver um arquivo WAV
	estiver sendo gravado.

**sound:get_samples()**

	Retorna o conteúdo atual do buffer da amostra gerada como uma string
	binária. As amostras são inteiros com 16 bits na ordem dos bytes do
	host. As amostras dos canais estéreo esquerdo e direito são
	intercaladas.

Propriedades
^^^^^^^^^^^^

**sound.muted** (somente leitura)

	Um booleano que indica se a saída do áudio está silenciada por algum
	motivo.

**sound.ui_mute** (leitura e escrita)

	Um booleano que indica se a saída do áudio está silenciada a pedido
	do usuário.

**sound.debugger_mute** (leitura e escrita)

	Um booleano que indica se a saída do áudio está silenciada a pedido
	do depurador.

**sound.system_mute** (leitura e escrita)

	Um booleano que indica se a saída do áudio foi silenciada a pedido
	do sistema que está sendo emulado.

**sound.attenuation** (leitura e escrita)

	A atenuação do volume da saída em decibéis. Geralmente deve ser um
	número inteiro negativo ou zero.

**sound.recording** (somente leitura)

	Um booleano que indica se a saída do áudio está sendo gravada em um
	arquivo WAV.

.. raw:: latex

	\clearpage

.. _luareference-core-outputman:

Gerenciador da saída
~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``output_manager`` do MAME que fornece acesso às
saídas do sistema que podem ser usadas para arte interativa ou
consumidas por programas externos.

Instanciação
^^^^^^^^^^^^

**manager.machine.output**

	Obtém o gerenciador da saída para a sessão da emulação atual.

Métodos
^^^^^^^

**output:set_value(nome, valor)**

	Define o valor de saída informada.  O valor deve ser um número
	inteiro. A saída será criada caso ainda não exista.

**output:set_indexed_value(prefixo, índice, valor)**

	Acrescenta o índice (formatado como um inteiro decimal) ao prefixo e
	define o valor da saída correspondente. O valor deve ser um número
	inteiro. A saída será criada caso ainda não exista.

**output:get_value(nome)**

	Retorna o valor da saída informada ou zero caso não exista.

**output:get_indexed_value(prefixo, índice)**

	Anexa o índice (formatado como um inteiro decimal) ao prefixo e
	retorna o valor da saída correspondente ou zero caso não exista.

**output:name_to_id(nome)**

	Obtém o ID com número inteiro exclusivo por sessão para a saída
	informada ou zero caso não exista.

**output:id_to_name(id)**

	Obtém o nome da saída com o ID exclusivo por sessão informada ou
	``nil`` caso não exista. Este método tem complexidade O(n),
	portanto, evite chamá-lo quando o desempenho for importante.

.. raw:: latex

	\clearpage

.. _luareference-core-paramman:

Gerenciador dos parâmetros
~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``parameters_manager`` do MAME que fornece um
armazenamento simples do valor da chave paraos  metadados das definições
da ROM do sistema.

Instanciação
^^^^^^^^^^^^

**manager.machine.parameters**

	Obtém o gerenciador dos parâmetros para a sessão da emulação atual.

Métodos
^^^^^^^

**parameters:lookup(tag)**

	Obtém o valor do parâmetro informado caso esteja definido ou uma
	string vazia se não estiver.

**parameters:add(tag, valor)**

	Define o parâmetro informado caso não esteja.
	Não tem efeito se o parâmetro informado já estiver definido.

.. raw:: latex

	\clearpage

.. _luareference-core-uiman:

O gerenciador da IU
~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``mame_ui_manager`` do MAME que lida com menus e as
outras funcionalidades da interface do usuário.

Instanciação
^^^^^^^^^^^^

**manager.ui**

	Obtém o gerenciador da IU para a sessão atual.

Métodos
^^^^^^^

**ui:get_char_width(ch)**

	Obtém a largura de um caractere Unicode como uma proporção da
	largura do contêiner da IU na fonte atualmente utilizada na altura
	configurada da linha da IU.

**ui:get_string_width(str)**

	Obtém a largura de uma string como uma proporção da largura do
	contêiner da IU na fonte atualmente utilizada na altura configurada
	da linha da IU.

**ui:set_aggressive_input_focus(ativa)**

	Em algumas plataformas isso controla se o MAME deve aceitar o foco
	da entrada em mais situações do que quando as suas janelas têm o
	foco da IU.

Propriedades
^^^^^^^^^^^^

**ui.options** (somente leitura)

	As :ref:`luareference-core-coreopts` da IU para a sessão atual.

**ui.line_height** (somente leitura)

	A altura configurada da linha de texto da IU como uma proporção da
	altura do contêiner da IU.

**ui.menu_active** (somente leitura)

	Um booleano que indica se um elemento da IU interativa está
	atualmente ativa.
	Os exemplos incluem os menus e os controles deslizantes.

**ui.single_step** (leitura e escrita)

	Um Booleano que controla se o sistema emulado deve ser pausado
	automaticamente quando o próximo quadro for desenhado.
	Esta propriedade é redefinida automaticamente quando acontecer a
	pausa automática.

**ui.show_fps** (leitura e escrita)

	Um Booleano que controla se a velocidade atual da emulação e as
	configurações do salto de quadro devem ser exibidas.

**ui.show_profiler** (leitura e escrita)

	Um Booleano que controla se as estatísticas da criação do perfil
	devem ser exibidas.

.. raw:: latex

	\clearpage

.. _luareference-core-driver:

Os metadados do driver do sistema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fornece alguns metadados para um sistema que estiver sendo emulado.

Instanciação
^^^^^^^^^^^^

**emu.driver_find(nome)**

	Obtém os metadados do driver informado para o sistema com o nome
	abreviado ou ``nil`` caso o sistema não exista.

**manager.machine.system**

	Obtém os metadados do driver para o sistema atual.

Propriedades
^^^^^^^^^^^^

**driver.name** (somente leitura)

	O nome abreviado do sistema, conforme usado na linha de comando,
	nos arquivos de configuração e ao pesquisar os recursos.

**driver.description** (somente leitura)

	O nome completo da exibição do sistema.

**driver.year** (somente leitura)

	O ano do lançamento do sistema. Pode conter pontos de interrogação
	caso não seja totalmente conhecido.

**driver.manufacturer** (somente leitura)

	O fabricante, o desenvolvedor ou o distribuidor do sistema.

**driver.parent** (somente leitura)

	O nome abreviado do sistema principal para fins de organização ou
	``"0"`` se o sistema não venha de uma matriz.

**driver.compatible_with** (somente leitura)

	O nome abreviado de um sistema onde este sistema seja compatível
	com o software ou ``nil`` caso o sistema não esteja listado como
	compatível com um outro sistema.

**driver.source_file** (somente leitura)

	O arquivo de origem onde este driver do sistema estiver definido.
	O formato do caminho depende do conjunto das ferramentas onde o
	emulador foi compilado.

**driver.rotation** (somente leitura)

	Uma string que indica a rotação aplicada a todas as telas no sistema
	depois que a orientação da tela informada na configuração da máquina
	seja aplicada.
	Será um dos ``"rot0"``, ``"rot90"``, ``"rot180"`` ou ``"rot270"``.

.. raw:: latex

	\clearpage

**driver.type** (somente leitura)

	Uma string que fornece um tipo de sistema. Será um dos ``"arcade"``,
	``"console"``, ``"computer"`` ou ``"other"``.
	Isso é apenas para fins informativos e pode não estar disponível no
	futuro.

**driver.not_working** (somente leitura)

	Um booleano que indica se o sistema está marcado como não
	funcionando.

**driver.supports_save** (somente leitura)

	Um booleano que indica se o sistema oferece suporte para salvar os
	estados.

**driver.no_cocktail** (somente leitura)

	Um booleano que indica se a inversão da tela no modo coquetel não é
	compatível.

**driver.is_bios_root** (somente leitura)

	Um booleano que indica se este sistema representa um sistema que
	executa o software a partir de uma mídia removível sem que a mídia
	esteja presente.

**driver.requires_artwork** (somente leitura)

	Um booleano que indica se o sistema requer uma arte externa para ser
	utilizável.

**driver.clickable_artwork** (somente leitura)

	Um booleano que indica se o sistema requer recursos clicáveis na
	arte para que possam ser utilizáveis.

**driver.unofficial** (somente leitura)

	Um booleano que indica se esta é uma modificação não oficial do
	usuário porém comum em um sistema.

**driver.no_sound_hw** (somente leitura)

	Um booleano que indica se o sistema não possui hardware com saída de
	áudio.

**driver.mechanical** (somente leitura)

	Um booleano que indica se o sistema depende de recursos mecânicos
	que não podem ser simulados corretamente.

**driver.is_incomplete** (somente leitura)

	Um booleano que indica se o sistema é um protótipo com
	funcionalidade incompleta.

.. raw:: latex

	\clearpage

.. _luareference-core-plugin:

Plug-in Lua
~~~~~~~~~~~

Fornece uma descrição de um plugin Lua que esteja disponível.

Instanciação
^^^^^^^^^^^^

**manager.plugins[nome]**

	Obtém a descrição do plug-in Lua com o nome informado ou ``nil``
	caso o plug-in não esteja disponível.

Propriedades
^^^^^^^^^^^^

**plugin.name** (somente leitura)

	O nome abreviado do plug-in usado na configuração e durante o
	acesso.

**plugin.description** (somente leitura)

	Exibe o nome do plug-in.

**plugin.type** (somente leitura)

	O tipo do plug-in. Pode ser ``"plugin"`` para os plug-ins que podem
	ser carregados pelo usuário ou ``"library"`` para as bibliotecas que
	fornecem funcionalidades comum aos diferentes plug-ins.

**plugin.directory** (somente leitura)

	O caminho para o diretório que contém os arquivos de plug-in.

**plugin.start** (somente leitura)

	Um booleano que indica se o plug-in está ativado.

.. raw:: latex

	\clearpage

.. _luareference-dev:

Dispositivos
------------

Diversas classes dos dispositivos e classes combinadas dos dispositivos
são expostas ao Lua. Os dispositivos podem ser pesquisados através das
tags ou enumerados.

.. _luareference-dev-enum:

Os enumeradores dos dispositivos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Os enumeradores dos dispositivos são contêineres especiais que permitem
iterar (repetir) e pesquisar os dispositivos através da tag. Um
enumerador pode ser criado para encontrar qualquer tipo de dispositivo,
para encontrar dispositivos de um tipo em particular ou para encontrar
dispositivos que implementem uma interface específica. Ao iterar os
dispositivos utilizando ``pairs`` ou ``ipairs`` tais dispositivos
retornam primeiro através da árvore dos dispositivos em ordem de
criação.

O índice faz com que o operador procure um dispositivo através da tag.
Ele retorna ``nil`` caso nenhum dispositivo com a tag especificada seja
encontrado ou se o dispositivo com tal tag não atenda aos requisitos do
tipo ou da interface do enumerador dos dispositivos. A complexidade é
O(1) caso o resultado seja colocado em cache, porém, a busca de um
dispositivo sem cache é custosa. O método ``at`` tem complexidade O(n).

Caso crie um enumerador dos dispositivos com um ponto de partida
diferente do dispositivo da máquina principal, a entrega de uma tag
completa ou uma tag contendo as referências principais para o operador
do índice pode fazer com que retorne um dispositivo que não seria
descoberto pela iteração. Se você criar um enumerador dos dispositivos
com uma extensão restrita, os dispositivos que não seriam encontrados
por serem muito extensos dentro hierarquia ainda podem ser pesquisados
através da tag.

A criação de um enumerador para os dispositivos com extensão restrita a
zero pode ser usada para reduzir um dispositivo ou testar se um
dispositivo consegue implementar uma determinada interface. Por exemplo,
isto testará se um dispositivo consegue implementar a interface de
imagem da mídia:

.. code-block:: Lua

    image_intf = emu.image_enumerator(device, 0):at(1)
    if image_intf then
        print(string.format("Device %s mounts images", device.tag))
    end

Instanciação
^^^^^^^^^^^^

**manager.machine.devices**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo <luareference-dev-device>` no sistema.

**manager.machine.screens**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo da tela <luareference-dev-screen>` no sistema.

**manager.machine.cassettes**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo da imagem em fita cassete <luareference-dev-cass>`
	no sistema.

**manager.machine.images**

	Retorna um dispositivo enumerador que irá iterar sobre a
	:ref:`interface para os dispositivos de imagem no sistema
	<luareference-dev-diimage>` no sistema.

.. raw:: latex

	\clearpage

**manager.machine.slots**

	Retorna um dispositivo enumerador que irá iterar sobre a
	:ref:`interface para os dispositivos slot <luareference-dev-dislot>`
	no sistema.

**emu.device_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo <luareference-dev-device>` na sub-árvore começando
	em um dispositivo específico. O dispositivo informado será incluído.
	Caso a profundidade seja informada este deve ser um valor inteiro
	que irá definir a quantidade máxima dos níveis que serão iterados
	abaixo do dispositivo informado (Por exemplo, 1 irá limitar a
	iteração do dispositivo e dos dispositivos relacionados).

**emu.screen_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo da tela <luareference-dev-screen>` na sub-árvore
	começando em um dispositivo específico. O dispositivo informado será
	incluído se for um dispositivo tela. Caso a profundidade seja
	informada este deve ser um valor inteiro que irá definir a
	quantidade máxima dos níveis que serão iterados abaixo do
	dispositivo informado (Por exemplo, 1 irá limitar a iteração do
	dispositivo e dos dispositivos relacionados).

**emu.cassette_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo da imagem em fita cassete <luareference-dev-cass>`
	na sub-árvore começando em um dispositivo específico. O dispositivo
	informado será incluído se for um dispositivo cassete. Caso a
	profundidade seja informada este deve ser um valor inteiro que irá
	definir a quantidade máxima dos níveis que serão iterados abaixo do
	dispositivo informado (Por exemplo, 1 irá limitar a iteração do
	dispositivo e dos dispositivos relacionados).

**emu.image_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre a
	:ref:`interface para os dispositivos de imagem
	<luareference-dev-diimage>` na sub-árvore começando em um
	dispositivo específico. O dispositivo informado será incluído caso
	seja uma mídia de um dispositivo de imagem. Caso a profundidade seja
	informada este deve ser um valor inteiro que definirá a quantidade
	máxima dos níveis que serão iterados abaixo do dispositivo informado
	(Por exemplo, 1 irá limitar a iteração do dispositivo e dos
	dispositivos relacionados).

**emu.slot_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre a
	:ref:`interface para os dispositivos slot <luareference-dev-dislot>`
	na sub-árvore começando em um dispositivo específico. O dispositivo
	informado será incluído se for um dispositivo slot. Caso a
	profundidade seja informada este deve ser um valor inteiro que
	definirá a quantidade máxima dos níveis que serão iterados abaixo do
	dispositivo informado (Por exemplo, 1 irá limitar a iteração do
	dispositivo e dos dispositivos relacionados).

.. raw:: latex

	\clearpage

.. _luareference-dev-device:

Dispositivo
~~~~~~~~~~~

Encapsula a classe ``device_t`` do MAME que serve de base para todas as
classes dos dispositivos.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag]**

	Obtém um dispositivo através de uma tag com relação ao dispositivo
	da máquina principal ou ``nil`` caso o dispositivo não exista.

**manager.machine.devices[tag]:subdevice(tag)**

	Obtém um dispositivo através de uma tag com relação a outro
	dispositivo arbitrário ou ``nil`` caso o dispositivo não exista.

Métodos
^^^^^^^

**device:subtag(tag)**

	Converte uma tag com relação ao dispositivo em uma tag absoluta.

**device:siblingtag(tag)**

	Converte uma tag com relação ao dispositivo principal do dispositivo
	em uma tag absoluta.

**device:memshare(tag)**

	Obtém um :ref:`compartilhamento da memória <luareference-mem-share>`
	através de uma tag com relação ao dispositivo ou ``nil`` caso o
	compartilhamento da memória não exista.

**device:membank(tag)**

	Obtém um :ref:`banco da memória <luareference-mem-bank>` através de
	uma tag com relação ao dispositivo ou ``nil`` caso o banco da
	memória não exista.

**device:memregion(tag)**

	Obtém uma :ref:`região da memória <luareference-mem-region>` através
	de uma tag com relação ao dispositivo ou ``nil`` caso a região da
	memória não exista.

**device:ioport(tag)**

	Obtém uma :ref:`porta de E/S <luareference-input-ioport>` através da
	tag com relação ao dispositivo ou ``nil`` caso a porta de E/S não
	exista.

**device:subdevice(tag)**

	Obtém um dispositivo através de uma tag com relação ao dispositivo.

**device:siblingdevice(tag)**

	Obtém um dispositivo através de uma tag com relação ao dispositivo
	principal.

**device:parameter(tag)**

	Obtém o valor do parâmetro através da tag relativa ao dispositivo ou
	uma string vazia caso não esteja definida.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**device.tag** (somente leitura)

	A tag absoluta do dispositivo em forma canônica.

**device.basetag** (somente leitura)

	O último componente da tag do dispositivo (Por exemplo, quando a sua
	tag for relativa ao dispositivo principal) ou ``"root"`` para o
	dispositivo raiz da máquina.

**device.name** (somente leitura)

	Exibe o nome completo para o tipo do dispositivo.

**device.shortname** (somente leitura)

	O nome curto do tipo do dispositivo (usado, por exemplo, na linha de
	comando, ao procurar por recursos como ROMs ou a ilustração e em
	vários arquivos de dados).

**device.owner** (somente leitura)

	A relação direta do dispositivo na árvore do dispositivo ou ``nil``
	para o dispositivo raiz do dispositivo da máquina.

**device.configured** (somente leitura)

	Um booleano que indica se o dispositivo concluiu a configuração.

**device.started** (somente leitura)

	Um booleano que indica se o dispositivo concluiu a inicialização.

**device.debug** (somente leitura)

	A :ref:`interface de depuração do dispositivo
	<luareference-debug-devdebug>` para o dispositivo caso seja um
	dispositivo CPU ou ``nil`` caso não seja ou se o depurador não
	estiver ativado.

**device.spaces[]** (somente leitura)

	A tabela dos :ref:`espaços do endereçamento da memória
	<luareference-mem-space>` do dispositivo, indexado por nome.
	Válido apenas para os dispositivos que implementam a interface da
	memória. Observe que os nomes são específicos para o tipo do
	dispositivo e não têm um significado especial.

.. raw:: latex

	\clearpage

.. _luareference-dev-screen:

Dispositivo da tela
~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``screen_device`` do MAME que representa uma saída
emulada vídeo.

Instanciação
^^^^^^^^^^^^

**manager.machine.screens[tag]**

	Obtém um dispositivo tela através da tag em relação ao dispositivo
	da máquina raiz, ou ``nil`` caso o dispositivo não exista ou caso
	não seja um dispositivo tela.

Classes de base
^^^^^^^^^^^^^^^

* :ref:`luareference-dev-device`

Métodos
^^^^^^^

**screen:orientation()**

	Retorna o ângulo de rotação em graus (será um de 0, 90, 180 ou 270),
	ou se a tela está virada da esquerda para a direita e se está
	invertida de cima para baixo. Essa é a orientação final da tela
	depois que a orientação tenha sido definida na configuração da
	máquina e a rotação tenha sido aplicada.

**screen:time_until_pos(v, [h])**

	Obtém o tempo restante até que o raster atinja a posição
	especificada.  Caso o componente horizontal da posição não é seja
	informado, a predefinição é zero (0, ou seja, o início da linha).
	O resultado é um número de ponto flutuante em unidades de segundos.

**screen:time_until_vblank_start()**

	Obtém o tempo restante até o início do intervalo de apagamento
	vertical. O resultado é um número de ponto flutuante em unidades de
	segundos.

**screen:time_until_vblank_end()**

	Obtém o tempo restante até o final do intervalo de apagamento
	vertical. O resultado é um número de ponto flutuante em unidades de
	segundos.

**screen:snapshot([nome_do_arquivo])**

	Salva uma captura da tela em formato PNG. Caso nenhum nome do
	arquivo seja informado, será usado o caminho e o formato padrão
	configurado para a captura da tela. Caso o nome do arquivo informado
	não seja um caminho absoluto, ele será interpretado em relação ao
	primeiro caminho que foi configurado. O nome do arquivo pode conter
	variáveis que serão substituídas pelo nome do sistema ou por um
	número incremental.

	Caso contrário, retorna um erro caso a leitura do arquivo da captura
	da tela falhe ou ``nil``.

.. raw:: latex

	\clearpage

**screen:pixel(x, y)**

	Obtém o pixel no local informado. As coordenadas estão em pixels,
	com a origem no canto superior esquerdo da área visível, aumentando
	para o para a direita e para baixo. Retorna um índice da paleta ou
	de uma cor no formato RGB compactado em um inteiro com 32 bits.
	Retorna zero (0) se o ponto informado estiver fora da área visível.

**screen:pixels()**

	Retorna todos os pixels visíveis como inteiros com 32 bits
	empacotados em uma string binária em ordenado como Endian. Pixels
	são organizados em ordem maior da linha, da esquerda para direita e
	depois de cima para baixo. Os valores dos pixels são índices da
	paleta ou cores no formato RGB compactadas em inteiros com 32 bits.

**screen:draw_box(esquerda, cima, direita, baixo, [linha], [preencha])**

	Desenha um retângulo delineado com bordas nas posições informadas.

	As coordenadas são números de ponto flutuante em unidades de pixels
	da tela, com a origem em (0, 0). Observe que os pixels da tela
	geralmente não são quadrados. A sistema de coordenadas é rotacionada
	caso a tela seja girada, o que geralmente é o caso para as telas de
	formato vertical. Antes da rotação, a origem está na parte superior
	esquerda e as coordenadas aumentam para a direita e para baixo.
	Coordenadas são limitadas à área da tela.

	O preenchimento e as cores das linhas estão no formato ARGB
	alfa/vermelho/verde/azul.
	Os valores dos canais estão no intervalo de 0 (transparente ou
	desligado) até 255 inclusive (opaco ou com intensidade total). Os
	valores dos canais da cor não são previamente multiplicados pelo
	valor alfa. Os valores do canal devem ser compactados em bytes de um
	Inteiro com 32 bits não assinado, na ordem alfa, vermelho, verde,
	azul a partir do byte mais importante até o bit com menor
	importância. Caso a cor da linha não seja informado, a cor do texto
	da IU é usada; caso a cor do preenchimento não seja informada, a cor
	do fundo da IU será usada.

**screen:draw_line(x1, y1, x2, y2, baixo, [cor])**

	Desenha uma linha a partir de (x1, y1) a (x2, y2).

	As coordenadas são números de ponto flutuante em unidades de pixels
	da tela, com a origem em (0, 0). Observe que os pixels da tela
	geralmente não são quadrados. A sistema de coordenadas é rotacionada
	caso a tela seja girada, o que geralmente é o caso para as telas de
	formato vertical. Antes da rotação, a origem está na parte superior
	esquerda e as coordenadas aumentam para a direita e para baixo.
	Coordenadas são limitadas à área da tela.

	A cor da linha está no formato ARGB alfa/vermelho/verde/azul. Os
	valores do canal estão no intervalo de 0 (transparente ou desligado)
	até 255 inclusive (opaco ou com intensidade total). Os valores dos
	canais da cor não são previamente multiplicados pelo valor alpha.
	Os valores do canal devem ser compactados em bytes com 32 bits
	inteiros e não assinado na ordem alfa, vermelho, verde, azul a
	partir do byte mais importante até o byte com menor importância.
	Caso a cor da linha não seja informada, a cor do texto da IU será
	usada.

.. raw:: latex

	\clearpage

**screen:draw_text(x|justify, y, texto, [primeiro plano], [plano de fundo])**

	Desenha o texto na posição informada. Se a tela for rotacionada, o
	texto será girado.

	Caso o primeiro argumento seja um número, o texto será alinhado à
	esquerda nesta coordenada X. Caso o primeiro argumento seja uma
	string, ela deve ser ``"left"``, ``"center"`` ou ``"right"`` para
	desenhar o texto alinhado à esquerda na borda esquerda da tela,
	centralizado horizontalmente na tela ou alinhado à direita na borda
	direita da tela respectivamente. O segundo argumento determina a
	coordenada Y da altura máxima do texto.

	As coordenadas são números de ponto flutuante em unidades de pixels
	da tela, com a origem em (0, 0).  Observe que os pixels da tela
	geralmente não são quadrados. A sistema de coordenadas é rotacionada
	caso a tela seja girada, o que geralmente é o caso para as telas com
	formato vertical. Antes da rotação, a origem está na parte superior
	esquerda e as coordenadas aumentam para a direita e para baixo.
	Coordenadas são limitadas à área da tela.

	As cores do primeiro plano e do plano de fundo estão no formato ARGB
	alfa/vermelho/verde/azul mídia. Os valores dos canais estão no
	intervalo de 0 (transparente ou desligado) até 255 inclusive (opaco
	ou com intensidade total). Os valores dos canais da cor não são
	previamente multiplicados pelo valor alpha.
	Os valores do canal devem ser compactados em bytes com 32 bits
	inteiros não assinado na ordem alfa, vermelho, verde, azul a partir
	do byte mais importante até o byte com menor importância. Caso a cor
	do primeiro plano não seja informada, a cor do texto da IU será
	usada; caso a cor de fundo não for informada, a cor do fundo da IU
	será usada.

Propriedades
^^^^^^^^^^^^

**screen.width** (somente leitura)

	A largura do bitmap produzido pela tela emulada em pixels.

**screen.height** (somente leitura)

	A altura do bitmap produzido pela tela emulada em pixels.

**screen.refresh** (somente leitura)

	A taxa de atualização configurada da tela em Hertz (isso pode não
	refletir o valor atual).

**screen.refresh_attoseconds** (somente leitura)

	O intervalo de atualização configurado da tela em attosegundos
	(isso pode não refletir o valor atual).

**screen.xoffset** (somente leitura)

	O offset predefinido da posição X da tela. Este é um número de ponto
	flutuante onde um (1) corresponde ao tamanho X do contêiner da tela.
	Isso pode ser útil para restaurar o valor original após ajustar o
	offset X através do contêiner da tela.

**screen.yoffset** (somente leitura)

	O offset predefinido da posição Y da tela.  Este é um número de
	ponto flutuante onde um (1) corresponde ao tamanho Y do contêiner da
	tela. Isso pode ser útil para restaurar o valor original após
	ajustar o offset Y através do contêiner da tela.

.. raw:: latex

	\clearpage

**screen.xscale** (somente leitura)

	O fator de escala original da tela X, como um número de ponto
	flutuante. Isso pode ser útil para restaurar o valor original após
	ajustar a escala X através do contêiner da tela.

**screen.yscale** (somente leitura)

	O fator de escala original da tela Y, como um número de ponto
	flutuante. Isso pode ser útil para restaurar o valor original após
	ajustar a escala Y através do contêiner da tela.

**screen.pixel_period** (somente leitura)

	O intervalo necessário para desenhar um pixel horizontal, como um
	número de ponto flutuante em em unidades de segundos.

**screen.scan_period** (somente leitura)

	O intervalo necessário para desenhar uma linha de varredura
	(incluindo o intervalo horizontal de apagamento), como um número de
	ponto flutuante em unidades de segundos.

**screen.frame_period** (somente leitura)

	O intervalo necessário para desenhar um quadro completo (incluindo
	os intervalos de apagamento), como um número de ponto flutuante em
	unidades de segundos.

**screen.frame_number** (somente leitura)

	A quantidade dos quadros da tela atual. Isso aumenta monotonicamente
	cada intervalo dos quadros.

**screen.container** (somente leitura)

	O :ref:`contêiner do renderizador <luareference-render-container>`
	usado para desenhar a tela.

.. raw:: latex

	\clearpage

.. _luareference-dev-cass:

Dispositivo da imagem em fita cassete
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``cassette_image_device`` do MAME que representa um
mecanismo cassete compacto normalmente usado por um computador doméstico
para armazenamento dos programas.

Instanciação
^^^^^^^^^^^^

**manager.machine.cassettes[tag]**

	Obtém a imagem de um dispositivo cassete por tag em relação ao
	dispositivo da máquina raiz ou ``nil`` caso o dispositivo não exista
	ou caso não seja a imagem de um dispositivo cassete.

Classes de base
^^^^^^^^^^^^^^^

* :ref:`luareference-dev-device`
* :ref:`luareference-dev-diimage`

Métodos
^^^^^^^

**cassette:stop()**

	Desativa a reprodução.

**cassette:play()**

	Ativa a reprodução. O cassete tocará se o motor estiver ativado.

**cassette:forward()**

	Avança a reprodução.

**cassette:reverse()**

	Retrocede a reprodução.

**cassette:seek(tempo, de_onde)**

	Salte para a posição informada na fita.  O tempo é um número de
	ponto flutuante em unidades de segundos, em relação ao ponto
	informado no argumento de_onde. O argumento de_onde deve ser
	``"set"``, ``"cur"`` ou ``"end"`` para realizar a busca com relação
	ao início da fita, a posição atual ou o fim da fita,
	respectivamente.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**cassette.is_stopped** (somente leitura)

	Um booleano que indica se a fita está parada (ou seja, não está
	gravando e nem reproduzindo).

**cassette.is_playing** (somente leitura)

	Um booleano que indica se a reprodução está ativada (ou seja, o
	cassete vai reproduzir se o motor estiver ativado).

**cassette.is_recording** (somente leitura)

	Um booleano que indica se a gravação está ativada (ou seja, o
	gravador da fita vai gravar se o motor estiver ativado).

**cassette.motor_state** (leitura e escrita)

	Um booleano que indica se o motor do cassete está ativado.

**cassette.speaker_state** (leitura e escrita)

	Um booleano que indica se o alto-falante do cassete está ativado.

**cassette.position** (somente leitura)

	A posição atual como um número de ponto flutuante em unidades de
	segundos com relação ao início da fita.

**cassette.length** (somente leitura)

	A duração da fita como um número de ponto flutuante em unidades de
	segundos, ou zero (0) caso nenhuma imagem da fita seja montada.

.. raw:: latex

	\clearpage

.. _luareference-dev-diimage:

Interface para os dispositivos de imagem
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``device_image_interface`` do MAME que é uma mistura
implementada através dos dispositivos que podem carregar os arquivos de
imagem da mídia.

Instanciação
^^^^^^^^^^^^

**manager.machine.images[tag]**

	Obtém um dispositivo de imagem por tag em relação ao dispositivo da
	máquina raiz, ou ``nil`` caso o dispositivo não exista ou caso não
	seja um dispositivo de imagem da mídia.

Métodos
^^^^^^^

**image:load(nome_do_arquivo)**

	Carrega o arquivo informado como uma imagem de mídia. Retorna
	``"pass"`` ou ``"fail"``.

**image:load_software(nome)**

	Carrega uma imagem da mídia descrita em uma lista de software.
	Retorna ``"pass"`` ou ``"fail"``.

**image:unload()**

	Descarrega a imagem que foi montada.

**image:create(nome_do_arquivo)**

	Cria e monta um arquivo de imagem da mídia com o nome informado.
	Retorna ``"pass"`` ou ``"fail"``.

**image:display()**

	Retorna uma string do “front panel display” para o dispositivo, caso
	seja compatível. Isso pode ser usado para exibir as informações de
	status, como a posição atual da cabeça ou do estado do motor.

Propriedades
^^^^^^^^^^^^

**image.is_readable** (somente leitura)

	Um booleano que indica se o dispositivo oferece suporte à leitura.

**image.is_writeable** (somente leitura)

	Um booleano que indica se o dispositivo oferece suporte para
	gravação.

**image.must_be_loaded** (somente leitura)

	Um booleano que indica se o dispositivo requer que uma imagem da
	mídia seja carregada para começar.

**image.is_reset_on_load** (somente leitura)

	Um booleano que indica se o dispositivo requer uma reinicialização
	forçada para alterar as imagens da mídia (geralmente para slots de
	cartucho que contêm um hardware adicional para os chips de memória).

.. raw:: latex

	\clearpage

**image.image_type_name** (somente leitura)

	Uma string para categorizar o dispositivo da mídia.

**image.instance_name** (somente leitura)

	O nome da instância do dispositivo na configuração atual. Isso é
	usado para configurar a carga da imagem da mídia na linha de comando
	ou nos arquivos INI. Isso não é estável, pode ter um número anexado
	que pode mudar dependendo da configuração do slot.

**image.brief_instance_name** (somente leitura)

	O nome curto da instância do dispositivo na configuração atual. Isto
	é, usado para definir a imagem da mídia que será carregada na linha
	de comando ou nos arquivos INI.  Isso não é estável, pode ter um
	número anexado que pode mudar dependendo da configuração do slot.

**image.formatlist[]** (somente leitura)

	O :ref:`formato da imagem da mídia <luareference-dev-imagefmt>` são
	suportados pelo dispositivo, indexado por nome. O operador do índice
	e dos métodos ``index_of`` têm Complexidade O(n); todas as outras
	operações compatíveis têm complexidade O(1).

**image.exists** (somente leitura)

	Um booleano que indica se um arquivo de imagem da mídia está
	montado.

**image.readonly** (somente leitura)

	Um booleano que indica se um arquivo de imagem da mídia está montado
	em mode de somente leitura.

**image.filename** (somente leitura)

	O caminho completo para o arquivo montado da imagem da mídia ou
	``nil`` se nenhuma imagem da mídia estiver montada.

**image.crc** (somente leitura)

	A verificação de redundância cíclica com 32 bits do conteúdo do
	arquivo da imagem montada caso a imagem não tenha sido carregada a
	partir de uma lista de software, é montado como somente leitura e
	não for um CD-ROM, caso contrário é zero (0).

**image.loaded_through_softlist** (somente leitura)

	Um booleano que indica se a imagem da mídia montada foi carregada a
	partir de uma lista de software ou ``false`` caso nenhuma imagem da
	mídia tenha sido montada.

**image.software_list_name** (somente leitura)

	O nome curto da lista de software caso a imagem da mídia montada
	tenha sido carregada a partir de uma lista de software.

**image.software_longname** (somente leitura)

	O nome completo do item do software caso a imagem da mídia montada
	tenha sido carregada a partir de uma lista de software ou caso
	contrário, ``nil``.

.. raw:: latex

	\clearpage

**image.software_publisher** (somente leitura)

	O editor do item do software caso a imagem da mídia montada tenha
	sido carregada a partir de uma lista de software ou caso contrário,
	``nil``.

**image.software_year** (somente leitura)

	O ano de lançamento do item do software caso a imagem da mídia
	montada tenha sido carregada a partir de uma lista de software ou
	caso contrário, ``nil``.

**image.software_parent** (somente leitura)

	O nome abreviado do item do software principal caso a imagem da
	mídia montada tenha sido carregada a partir de uma lista de software
	ou caso contrário, ``nil``.

**image.device** (somente leitura)

	O :ref:`dispositivo <luareference-dev-device>` subjacente.

.. raw:: latex

	\clearpage

.. _luareference-dev-dislot:

Interface para os dispositivos slot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``device_slot_interface`` do MAME que é uma mistura
implementada através dos dispositivos que instanciam um dispositivo
herdado que foi definido pelo usuário.

Instanciação
^^^^^^^^^^^^

**manager.machine.slots[tag]**

	Obtém um dispositivo slot atavés da tag com relação ao dispositivo
	da máquina raiz ou ``nil`` caso o dispositivo não exista ou caso não
	seja um dispositivo slot.

Propriedades
^^^^^^^^^^^^

**slot.fixed** (somente leitura)

	Um booleano que indica se este é um slot com um cartão informado
	na configuração da máquina que não possa ser alterada pelo usuário.

**slot.has_selectable_options** (somente leitura)

	Um booleano que indica se o slot tem alguma opção selecionável pelo
	usuário (ao contrário das opções que só podem ser selecionadas
	programaticamente, normalmente para os slots fixos ou para carregar
	as imagens da mídia).

**slot.options[]** (somente leitura)

	As :ref:`opções do slot <luareference-dev-slotopt>` que descrevem os
	dispositivos herdados que podem ser instanciados pelo slot,
	indexados pelo valor da opção. A métodos ``at`` e o ``index_of``
	possuí O(n) complexidade; todas as outras operações compatíveis têm
	complexidade O(1).

**slot.device** (somente leitura)

	O :ref:`dispositivo <luareference-dev-device>` subjacente.

.. raw:: latex

	\clearpage

.. _luareference-dev-imagefmt:

O formato da imagem da mídia
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``image_device_format`` do MAME que descreve o
formato do arquivo da mídia compatível através da
:ref:`interface para os dispositivos de imagem
<luareference-dev-diimage>`.

Instanciação
^^^^^^^^^^^^

**manager.machine.images[tag].formatlist[nome]**

	Obtém um formato da imagem da mídia compatível com um determinado
	dispositivo através de um nome.

Propriedades
^^^^^^^^^^^^

**format.name** (somente leitura)

	Um nome abreviado usado para identificar o formato. Isso geralmente
	corresponde a extensão do nome do arquivo principal usado para o
	formato.

**format.description** (somente leitura)

	O nome completo do formato.

**format.extensions[]** (somente leitura)

	Produz uma tabela das extensões do nome do arquivo usados no
	formato.

**format.option_spec** (somente leitura)

	Uma string que descreve as opções disponíveis durante a criação do
	formato da imagem da mídia. A string não se destina a ser legível
	para humanos.

.. raw:: latex

	\clearpage

.. _luareference-dev-slotopt:

Opções do slot
~~~~~~~~~~~~~~

Encapsula a classe ``device_slot_interface::slot_option`` do MAME que
representa um dispositivo herdado da :ref:`interface para os
dispositivos slot <luareference-dev-dislot>` que podem ser instanciados
para configuração.

Instanciação
^^^^^^^^^^^^

**manager.machine.slots[tag].options[nome]**

	Obtém uma opção do slot para uma determinada
	:ref:`interface para os dispositivos slot <luareference-dev-dislot>`
	através do nome (ou seja, o valor usado para selecionar a opção).

Propriedades
^^^^^^^^^^^^

**option.name** (somente leitura)

	O nome da opção do slot. Este é o valor usado para selecionar esta
	opção na linha de comando ou em um arquivo INI.

**option.device_fullname** (somente leitura)

	O nome completo da exibição do tipo do dispositivo instanciado por
	esta opção.

**option.device_shortname** (somente leitura)

	O nome abreviado do tipo de dispositivo instanciado por esta opção.

**option.selectable** (somente leitura)

	Um Booleano que indica se a opção pode ser selecionada pelo usuário
	(as opções que não são selecionáveis pelo usuário geralmente são
	usados para os slots fixos ou para carregar as imagens da mídia).

**option.default_bios** (somente leitura)

	A configuração padrão da BIOS para o dispositivo instanciado usando
	esta opção, ou ``nil`` caso a BIOS informada nas definições da ROM
	do dispositivo seja usada.

**option.clock** (somente leitura)

	A frequência do clock configurada para o dispositivo instanciado
	usando esta opção. Este é um número inteiro com 32 bits não
	assinado. Se os oito primeiros bits mais importantes forem
	configurados, é uma proporção da frequência do clock do dispositivo
	principal, com o numerador nos bits 12-23 e o denominador nos bits
	0-11. Se os oito bits mais importantes não estiverem todos
	configurados, a frequência será em Hertz.

.. raw:: latex

	\clearpage

.. _luareference-mem:

Sistema da memória
------------------

A interface Lua do MAME expõe vários objetos da memória do sistema,
incluindo os espaços de endereçamento, compartilhamentos da memória,
bancos da memória e as regiões da memória.  Os scripts podem ler e
escrever a partir do sistema de memória emulado.

.. _luareference-mem-manager:

Gerenciador da memória
~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``memory_manager`` do MAME que permite os
compartilhamentos da memória, os bancos e as regiões em um sistema que
será enumerado.

Instanciação
^^^^^^^^^^^^

**manager.machine:memory()**

	Obtém a instância do gerenciador global da memória para o sistema
	emulado.

Propriedades
^^^^^^^^^^^^

**memory.shares[]**

	O :ref:`compartilhamento da memória <luareference-mem-share>` no
	sistema, indexada pela tag absoluta. Os métodos ``at`` e o
	``index_of`` têm O(n) complexidade; todas outras operações
	compatíveis têm complexidade O(1).

**memory.banks[]**

	Os :ref:`banco da memória <luareference-mem-bank>` no sistema,
	indexada pela tag absoluta. Os métodos ``at`` e o ``index_of`` têm
	O(n) complexidade; todas outras operações compatíveis têm
	complexidade O(1).

**memory.regions[]**

	As :ref:`regiões da memória <luareference-mem-region>` no sistema,
	indexada pela tag absoluta. Os métodos ``at`` e o ``index_of`` têm
	O(n) complexidade; todas outras operações compatíveis têm
	complexidade O(1).

.. raw:: latex

	\clearpage

.. _luareference-mem-space:

Espaço do endereçamento da memória
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``address_space`` do MAME que representa um espaço
do endereço pertencente a um dispositivo.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag].spaces[nome]**

	Obtém o espaço do endereço com o nome específico para um determinado
	dispositivo. Observe que esses nomes são específicos para o tipo do
	dispositivo.

Métodos
^^^^^^^

**space:read_i{8,16,32,64}(endereço)**

	Lê um valor inteiro assinado com o tamanho em bits do endereço
	informado.

**space:read_u{8,16,32,64}(endereço)**

	Lê um valor inteiro não assinado com o tamanho em bits a partir do
	endereço informado.

**space:write_i{8,16,32,64}(endereço, valor)**

	Grava um valor inteiro assinado com o tamanho em bits no endereço
	informado.

**space:write_u{8,16,32,64}(endereço, valor)**

	Grava um valor inteiro não assinado com o tamanho em bits para o
	endereço informado.

**space:readv_i{8,16,32,64}(endereço)**

	Lê um valor inteiro assinado com o tamanho em bits a partir do
	endereço virtual informado. O endereço é traduzido com a intenção da
	leitura da depuração. Retorna zero se a tradução do endereço falhar.

**space:readv_u{8,16,32,64}(endereço)**

	Lê um valor inteiro não assinado com o tamanho em bits a partir do
	endereço informado. O endereço é traduzido com a intenção da leitura
	da depuração. Retorna zero se a tradução do endereço falhar.

**space:writev_i{8,16,32,64}(endereço, valor)**

	Grava um valor inteiro assinado com o tamanho em bits para o
	endereço virtual informado. O endereço é traduzido com a intenção de
	gravação da depuração. Não escreva se a tradução do endereço falhar.

**space:writev_u{8,16,32,64}(endereço, valor)**

	Grava um valor inteiro não assinado com o tamanho em bits para o
	endereço informado. O endereço é traduzido com a intenção de
	gravação da depuração. Não grava se a tradução do endereço falhar.

.. raw:: latex

	\clearpage

**space:read_direct_i{8,16,32,64}(endereço)**

	Lê um valor inteiro assinado com o tamanho em bits do endereço
	informado, um byte de cada vez, obtendo um ponteiro de leitura para
	cada byte do endereço. Caso um ponteiro de leitura não pode ser
	obtido para o byte de um endereço, o byte do resultado
	correspondente será zero.

**space:read_direct_u{8,16,32,64}(endereço)**

	Lê um valor inteiro não assinado com o tamanho em bits a partir do
	endereço informado, um byte de cada vez, obtendo um ponteiro de
	leitura para cada byte informado. Caso a leitura de um ponteiro não
	possa ser obtido para o endereço do byte, o resultado do byte
	correspondente será zero.

**space:write_direct_i{8,16,32,64}(endereço, valor)**

	Grava um valor inteiro assinado com o tamanho em bits no endereço
	informado, um byte de cada vez, obtendo um ponteiro de gravação para
	cada endereço do byte. Caso um ponteiro de escrita não possa ser
	obtido para o endereço de um byte, o byte correspondente não será
	escrito.

**space:write_direct_u{8,16,32,64}(endereço, valor)**

	Grava um valor inteiro não assinado com o tamanho em bits para o
	endereço informado, um byte de cada vez, obtendo um ponteiro de
	gravação para cada byte informado. Caso um ponteiro de gravação não
	possa ser obtido para o endereço de um byte, o byte correspondente
	não será escrito.

**space:read_range(inicio, fim, largura, [passo])**

	Lê um intervalo de endereços como uma string binária. O endereço
	final deve ser maior ou igual ao endereço inicial.  A largura deve
	ser 8, 16, 30 ou 64. Caso o passo seja informado, ele deve ser um
	número positivo dos elementos.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**space.name** (somente leitura)

	O nome da exibição do espaço do endereço.

**space.shift** (somente leitura)

	A granularidade do endereço para o espaço do endereçamento informado
	como a transferência necessária para traduzir o endereço de um byte
	em um endereço nativo. Os valores positivos se transferem para o bit
	mais importante (à esquerda) e os valores negativos se transferem
	em direção ao byte com menor importância (à direita).

**space.index** (somente leitura)

	O índice do espaço com base zero. Alguns índices do espaço têm
	significados especiais para o depurador.

**space.address_mask** (somente leitura)

	A máscara do espaço do endereço.

**space.data_width** (somente leitura)

	A largura dos dados para o espaço em bits.

**space.endianness** (somente leitura)

	O Endianness do espaço (``"big"`` ou ``"little"``).

**space.map** (somente leitura)

	O :ref:`mapa do endereçamento da memória <luareference-mem-map>`
	configurado para o espaço ou ``nil``.

.. raw:: latex

	\clearpage

.. _luareference-mem-map:

O mapa do endereçamento da memória
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``address_map`` do MAME que é usada para configurar
os manipuladores para um espaço do endereço.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag].spaces[nome].map**

	Obtém o mapa do endereço configurado para o espaço de um endereço ou
	``nil`` caso nenhum mapa seja configurado.

Propriedades
^^^^^^^^^^^^

**map.spacenum** (somente leitura)

	A quantidade do espaço de endereço do espaço de endereço onde o mapa
	está associado.

**map.device** (somente leitura)

	O dispositivo que possui o endereçamento onde o mapa está associado.

**map.unmap_value** (somente leitura)

	O valor constante para retornar a partir das leituras não mapeadas.

**map.global_mask** (somente leitura)

	Máscara global que será aplicada a todos os endereços ao acessar o
	espaço.

**map.entries[]** (somente leitura)

	As :ref:`entradas do endereçamento da memória
	<luareference-mem-mapentry>` não configuradas no mapa do endereço.
	Usa índices inteiros com base 1.  O operador do índice e o método
	``at`` tem complexidade O(n).

.. raw:: latex

	\clearpage

.. _luareference-mem-mapentry:

Entrada do endereçamento da memória
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``address_map_entry`` do MAME que representa uma
entrada na configuração de um mapa de endereços.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag].spaces[nome].map.entries[índice]**

	Obtém uma entrada a partir do mapa configurado para um espaço de
	endereço.

Propriedades
^^^^^^^^^^^^

**entry.address_start** (somente leitura)

	Endereço inicial do intervalo da entrada.

**entry.address_end** (somente leitura)

	Endereço final do intervalo da entrada (inclusive).

**entry.address_mirror** (somente leitura)

	Bits do espelho do endereço.

**entry.address_mask** (somente leitura)

	Bits da máscara do endereço.  É válido apenas para os manipuladores.

**entry.mask** (somente leitura)

	Máscara da pista, indicando quais as linhas dos dados do barramento
	estão conectadas ao manipulador.

**entry.cswidth** (somente leitura)

	A largura do gatilho para um manipulador que não está conectado a
	todas as linhas de dados.

**entry.read** (somente leitura)

	Os :ref:`dados do manipulador do mapa de endereçamento da memória
	<luareference-memory-handlerdata>` para a leitura do manipulador.

**entry.write** (somente leitura)

	Os :ref:`dados do manipulador do mapa de endereçamento da memória
	<luareference-memory-handlerdata>` para a escrita no manipulador.

**entry.share** (somente leitura)

	A tag do compartilhamento da memória para tornar as entradas da RAM
	acessíveis ou ``nil``.

**entry.region** (somente leitura)

	A tag explícita da região da memória para entradas da ROM, ou
	``nil``.  Para entradas da ROM, o ``nil`` deduz a região da tag do
	dispositivo.

**entry.region_offset** (somente leitura)

	O offset inicial na região da memória para as entradas da ROM.

.. raw:: latex

	\clearpage

.. _luareference-memory-handlerdata:

Dados do manipulador do mapa de endereçamento da memória
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``map_handler_data`` do MAME que oferece os dados de
configuração para os manipuladores nos mapas dos endereços.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag].spaces[nome].map.entries[índice].read**

	Obtém os dados do manipulador de leitura para uma entrada do mapa
	dos endereços.

**manager.machine.devices[tag].spaces[nome].map.entries[índice].write**

	Obtém os dados do manipulador de gravação para uma entrada do mapa
	dos endereços.

Propriedades
^^^^^^^^^^^^

**data.handlertype** (somente leitura)

	O tipo do manipulador. Será um dos ``"none"``, ``"ram"``, ``"rom"``,
	``"nop"``, ``"unmap"``, ``"delegate"``, ``"port"``, ``"bank"``,
	``"submap"`` ou ``"unknown"``.  Observe que os vários valores dos
	tipos do manipulador podem produzir ``"delegate"`` ou ``"unknown"``.

**data.bits** (somente leitura)

	A largura dos dados para o manipulador em bits.

**data.name** (somente leitura)

	Nome de exibição para o manipulador ou ``nil``.

**data.tag** (somente leitura)

	A tag para portas de E/S, os bancos da memória ou ``nil``.

.. raw:: latex

	\clearpage

.. _luareference-mem-share:

Compartilhamento da memória
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``memory_share`` do MAME que representa um nome
alocado na zona da memória.

Instanciação
^^^^^^^^^^^^

**manager.machine.memory.shares[tag]**

	Obtém um compartilhamento da memória através da tag absoluta ou
	``nil`` caso o compartilhamento da memória não  exista.

**manager.machine.devices[tag]:memshare(tag)**

	Obtém um compartilhamento da memória através da tag em relação a um
	dispositivo ou ``nil`` caso o compartilhamento da memória não
	exista.

Métodos
^^^^^^^

**share:read_i{8,16,32,64}(offs)**

	Lê um valor inteiro assinado do tamanho em bits do offset informado
	no compartilhamento da memória.

**share:read_u{8,16,32,64}(offs)**

	Lê um valor inteiro não assinado com o tamanho em bits a partir do
	offset do compartilhamento da memória.

**share:write_i{8,16,32,64}(offs, valor)**

	Grava um valor inteiro assinado com o tamanho em bits para o offset
	informado no compartilhamento da memória.

**share:write_u{8,16,32,64}(offs, valor)**

	Grava um valor inteiro não assinado com o tamanho em bits para o
	offset informado no compartilhamento da memória.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**share.tag** (somente leitura)

	A marca absoluta do compartilhamento da memória.

**share.size** (somente leitura)

	O tamanho do compartilhamento da memória em bytes.

**share.length** (somente leitura)

	O comprimento do compartilhamento da memória em elementos da largura
	nativa.

**share.endianness** (somente leitura)

	O endianness do compartilhamento da memória (``"big"`` ou
	``"little"``).

**share.bitwidth** (somente leitura)

	A largura do elemento nativo do compartilhamento da memória em bits.

**share.bytewidth** (somente leitura)

	A largura do elemento nativo do compartilhamento da memória em bytes.

.. raw:: latex

	\clearpage

.. _luareference-mem-bank:

Banco da memória
~~~~~~~~~~~~~~~~

Encapsula a classe ``memory_bank`` do MAME que representa uma zona
denominada da memória.

Instanciação
^^^^^^^^^^^^

**manager.machine.memory.banks[tag]**

    Obtém uma região da memória por tag absoluta, ou ``nil`` caso o
    banco da memória não exista.

**manager.machine.devices[tag]:membank(tag)**

	Obtém uma região da memória por tag relativa a um dispositivo ou
	``nil`` caso o banco da memória não exista.

Propriedades
^^^^^^^^^^^^

**bank.tag** (somente leitura)

    A tag absoluta do banco da memória.

**bank.entry** (leitura e escrita)

	O número da entrada com base zero atualmente selecionado.

.. raw:: latex

	\clearpage

.. _luareference-mem-region:

Região da memória
~~~~~~~~~~~~~~~~~

Encapsula a classe ``memory_region`` do MAME que representa a região da
memória usada para armazenar dados somente leitura como ROMs ou o
resultado fixo das descriptografias.

Instanciação
^^^^^^^^^^^^

**manager.machine.memory.regions[tag]**

	Obtém uma região de memória por tag absoluta ou ``nil`` caso
	nenhuma região da memória exista.

**manager.machine.devices[tag]:memregion(tag)**

	Obtém uma região da memória por tag relativa a um dispositivo ou
	``nil`` caso o banco da memória não exista.

Métodos
^^^^^^^

**region:read_i{8,16,32,64}(offs)**

	Lê um valor inteiro assinado do tamanho em bits do offset informado
	na região da memória.

**region:read_u{8,16,32,64}(offs)**

	Lê um valor inteiro não assinado com o tamanho em bits a partir do
	offset da região da memória.

**region:write_i{8,16,32,64}(offs, valor)**

	Grava um valor inteiro assinado com o tamanho em bits para o offset
	informado da região da memória.

**region:write_u{8,16,32,64}(offs, valor)**

	Grava um valor inteiro não assinado com o tamanho em bits para o
	offset informado na região da memória.

Propriedades
^^^^^^^^^^^^

**region.tag** (somente leitura)

	A tag absoluta da região da memória.

**region.size** (somente leitura)

	O tamanho da região da memória em bytes.

**region.length** (somente leitura)

	O comprimento da região da memória com elementos nativos de largura.

**region.endianness** (somente leitura)

	O endianness da região de memória (``"big"`` ou ``"little"``).

**region.bitwidth** (somente leitura)

	A largura do elemento nativo da região da memória em bits.

**region.bytewidth** (somente leitura)

	A largura do elemento nativo da região da memória em bytes.

.. raw:: latex

	\clearpage

.. _luareference-input:

Sistema de entrada
------------------

Permite que os scripts obtenham a inserção vinda do usuário e acessem as
portas de E/S no sistema emulado.

.. _luareference-input-ioportman:

Gerenciador da porta de E/S
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``ioport_manager`` do MAME que oferece acesso para as
portas emuladas de E/S e lida com as configurações da entrada.

Instanciação
^^^^^^^^^^^^

**manager.machine:ioport()**

	Obtém a instância do gerenciador global da porta de E/S para a
	máquina emulada.

Métodos
^^^^^^^

**ioport:count_players()**

	Retorna a quantidade dos controladores do jogador no sistema.

**ioport:type_pressed(tipo, [jogador])**

	Retorna um booleano indicando se a entrada informada foi atualmente
	pressionada. O tipo da entrada da porta é um valor enumerado. O
	número do jogador é um índice com base zero. Se o número do jogador
	não for informado, será presumido que seja zero.

**ioport:type_name(tipo, [jogador])**

	Retorna o nome da exibição para o tipo da entrada informada e o
	número do jogador. O tipo da entrada é um valor enumerado. O número
	do jogador é um índice com base zero. Se o número do jogador não for
	informado, será presumido que seja zero.

**ioport:type_group(tipo, jogador)**

	Retorna a entrada do grupo para o tipo da entrada informada e o
	número do jogador. O tipo da entrada é um valor enumerado. O número
	do jogador é um índice com base zero. Retorna um valor inteiro
	informando o agrupamento para a entrada. Se o número do jogador não
	for informado, será presumido que seja zero.

	Deve ser invocado com os valores obtidos a partir dos campos da
	porta de E/S para informar o agrupamento canônico da configuração da
	entrada em uma IU.

**ioport:type_seq(tipo, [jogador], [tipo_da_sequência])**

	Obtenha a sequência da entrada configurada para o tipo de entrada
	informada, o número do jogador e o tipo da sequência. O tipo da
	entrada é um valor enumerado. O número do jogador é um índice com
	base zero. Se o número do jogador não for informado, será presumido
	que seja zero. Caso o tipo da sequência seja informada ela deve ser
	``"standard"``, ``"increment"`` ou ``"decrement"``; caso não seja,
	será presumido que seja ``"standard"``.

	Isso fornece acesso à configuração geral da entrada.

.. raw:: latex

	\clearpage

**ioport:token_to_input_type(string)**

	Retorna o tipo da entrada e o número do jogador para o tipo da
	entrada do token informado.

**ioport:input_type_to_token(tipo, [jogador])**

	Retorna a string do token para o tipo da entrada informada e o
	número do jogador. Se o número do jogador não for informado, será
	presumido que seja zero.

Propriedades
^^^^^^^^^^^^

**ioport.ports[]**

	Obtém a emulação da :ref:`porta de E/S <luareference-input-ioport>`
	no sistema.
	Chaves são tags absolutas.  Os métodos ``at`` e o ``index_of``
	têm complexidade O(n); todas as outras operações compatíveis têm
	complexidade O(1).

.. raw:: latex

	\clearpage

.. _luareference-input-natkbd:

Gerenciador do teclado natural
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``natural_keyboard`` do MAME que gerencia o teclado
emulado e as entradas do teclado.

Instanciação
^^^^^^^^^^^^

**manager.machine.natkeyboard**

	Obtém a instância do gerenciador do teclado natural global para a
	máquina que está sendo emulada.

Métodos
^^^^^^^

**natkeyboard:post(texto)**

	Publique um texto literal na máquina emulada.  A máquina deve ter
	uma entrada de teclado com os caracteres vinculados e o dispositivo
	correto da entrada do teclado deve estar ativado.

**natkeyboard:post_coded(texto)**

	Publique o texto na máquina que está sendo emulada. Códigos entre
	chaves são interpretados no texto. A máquina deve ter as entradas do
	teclado com os caracteres vinculados e o dispositivo correto da
	entrada do teclado deve estar ativado.

	Os códigos reconhecidos são ``{BACKSPACE}``, ``{BS}``, ``{BKSP}``,
	``{DEL}``, ``{DELETE}``, ``{END}``, ``{ENTER}``, ``{ESC}``,
	``{HOME}``, ``{INS}``, ``{INSERT}``, ``{PGDN}``, ``{PGUP}``,
	``{SPACE}``, ``{TAB}``, ``{F1}``, ``{F2}``, ``{F3}``, ``{F4}``,
	``{F5}``, ``{F6}``, ``{F7}``, ``{F8}``, ``{F9}``, ``{F10}``,
	``{F11}``, ``{F12}`` e ``{QUOTE}``.

**natkeyboard:paste()**

	Publique o conteúdo da área de transferência do host na máquina
	emulada. A máquina deve ter as entradas do teclado com caracteres
	vinculados e o dispositivo correto da entrada do teclado deve estar
	ativado.

**natkeyboard:dump()**

	Retorna uma string com uma descrição legível do teclado e dos
	dispositivos de entrada do teclado numérico no sistema, se eles
	estão ativados e os seus caracteres vinculados.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**natkeyboard.empty** (somente leitura)

	Um booleano que indica se o buffer da entrada do gerenciador do
	teclado natural está vazio.

**natkeyboard.full** (somente leitura)

	Um booleano que indica se o buffer da entrada do gerenciador do
	teclado natural está cheio.

**natkeyboard.can_post** (somente leitura)

	Um booleano que indica se o sistema emulado suporta a postagem dos
	dados dos caracteres através do gerenciador do teclado natural.

**natkeyboard.is_posting** (somente leitura)

	Um booleano que indica se os dados postados dos caracteres estão
	sendo entregues ao sistema que está sendo emulado.

**natkeyboard.in_use** (leitura e escrita)

	Um booleano que indica se o modo “teclado natural” está ativado.
	Quando O modo “teclado natural” está ativado o gerenciador do
	teclado natural traduz a entrada de caractere do host para
	pressionamentos da tecla do sistema emulado.

**natkeyboard.keyboards[]**

	Obtém o :ref:`dispositivo de entrada do teclado
	<luareference-input-kbddev>` no sistema que está sendo emulado,
	indexado através da tag absoluta do dispositivo. O índice get tem
	O(n) complexidade; todas as outras operações compatíveis têm
	complexidade O(1).

.. raw:: latex

	\clearpage

.. _luareference-input-kbddev:

Dispositivo de entrada do teclado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Representa um teclado ou dispositivo de entrada do teclado que é
gerenciado pelo :ref:`gerenciador do teclado natural
<luareference-input-natkbd>`.

Instanciação
^^^^^^^^^^^^

**manager.machine.natkeyboard.keyboards[tag]**

	Obtém o dispositivo da entrada do teclado com a tag informada ou
	``nil`` se a tag não corresponder a um dispositivo da entrada do
	teclado.

Propriedades
^^^^^^^^^^^^

**keyboard.device** (somente leitura)

	O dispositivo subjacente.

**keyboard.tag** (somente leitura)

	A tag absoluta do dispositivo subjacente.

**keyboard.basetag** (somente leitura)

	O último componente da tag do dispositivo subjacente ou ``"root"``
	para o dispositivo raiz da máquina.

**keyboard.name** (somente leitura)

	A descrição legível para as pessoas do tipo do dispositivo
	subjacente.

**keyboard.shortname** (somente leitura)

	O identificador do tipo do dispositivo subjacente.

**keyboard.is_keypad** (somente leitura)

	Um booleano que indica se o dispositivo subjacente possui as
	entradas do teclado numérico, mas não para a entradas do teclado.
	Isso é usado para determinar quais dispositivos da entrada do
	teclado deve ser ativado por padrão.

**keyboard.enabled** (leitura e escrita)

	Um booleano que indica se as entradas do teclado e/ou do teclado
	numérico do dispositivo estão ativados.

.. raw:: latex

	\clearpage

.. _luareference-input-ioport:

Porta de E/S
~~~~~~~~~~~~

Encapsula a classe ``ioport_port`` do MAME que representa uma porta
emulada de E/S.

Instanciação
^^^^^^^^^^^^

**manager.machine.ioport.ports[tag]**

	Obtém uma porta de E/S emulada através da tag absoluta ou ``nil``
	caso a tag não corresponda a uma porta de E/S.

**manager.machine.devices[devtag]:ioport(porttag)**

	Obtém uma porta de E/S emulada através da tag relativa a um
	dispositivo ou ``nil`` se não houver nenhuma porta de E/S.

Métodos
^^^^^^^

**port:read()**

	Leia o valor de entrada atual.  Retorna um número inteiro com 32
	bits.

**port:write(valor, máscara)**

	Grave nos campos da saída da porta de E/S que são configuradas na
	máscara informada. A máscara e o valor devem ser inteiros e com 32
	bits. Observe que isso não define os valores para os campos da
	entrada.

**port:field(máscara)**

	Obtenha o primeiro :ref:`campo da porta de E/S
	<luareference-input-field>` correspondente aos bits que são
	definidos na máscara informada ou ``nil`` se não houver nenhum campo
	correspondente.

Propriedades
^^^^^^^^^^^^

**port.device**  (somente leitura)

	O dispositivo que possui a porta de E/S.

**port.tag** (somente leitura)

	A etiqueta absoluta da porta E/S

**port.active** (somente leitura)

	Uma máscara indicando quais os bits da porta E/S correspondem aos
	campos ativos (isto é, os bits que não não utilizados ou não foram
	atribuídos).

**port.live** (somente leitura)

	O estado ativo da porta de E/S.

**port.fields[]** (somente leitura)

	Obtém uma tabela do :ref:`campo da porta de E/S
	<luareference-input-field>` indexados por nome.

.. raw:: latex

	\clearpage

.. _luareference-input-field:

Campo da porta de E/S
~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``ioport_field`` do MAME que representa um campo
dentro da porta de E/S.

Instanciação
^^^^^^^^^^^^

**manager.machine.ioport.ports[tag]:field[máscara]**

	Obtém um campo para a porta informada através dos bits da máscara.

**manager.machine.ioport.ports[tag].fields[nome]**

	Obtém um campo para a porta informada através do nome de exibição.

Métodos
^^^^^^^

**field:set_value(valor)**

	Define o valor do campo da porta de E/S.  Para os campos digitais,
	o valor é comparado com zero para determinar se o campo deve estar
	ativo; para os campos analógicos, o valor deve estar alinhado à
	direita e na faixa correta.

**field:set_input_seq(tipo_da_sequência, sequência)**

	Define a sequência de entrada para o tipo da sequência informada.
	Isso é usado para definir as configurações da entrada por máquina.
	O tipo da sequência deve ser ``"standard"``, ``"increment"`` ou
	``"decrement"``.

**field:input_seq(tipo_da_sequência)**

	Obtenha a sequência da entrada configurada para o tipo da sequência
	informada. Isso obtém as configurações da entrada por máquina. O
	tipo da sequência deve ser ``"standard"``, ``"increment"`` ou
	``"decrement"``.

**field:set_default_input_seq(tipo_da_sequência, sequência)**

	Define a sequência da entrada predefinida para o tipo da sequência
	informada. É usado para definir as configurações gerais da entrada.
	O tipo da sequência deve ser ``"standard"``, ``"increment"`` ou
	``"decrement"``.

**field:default_input_seq(tipo_da_sequência)**

	Obtém a sequência da entrada predefinida para o tipo da sequência
	informada. Obtém as configurações gerais da entrada. O tipo da
	sequência deve ser ``"standard"``, ``"increment"`` ou
	``"decrement"``.

**field:keyboard_codes(shift)**

	Obtém uma tabela dos caracteres correspondentes ao campo para o
	estado do shift informado. O estado do shift é uma máscara de bits
	das teclas ativas do shift.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**field.device** (somente leitura)

	O dispositivo que possui a porta que o campo pertence.

**field.port** (somente leitura)

	A :ref:`porta de E/S <luareference-input-ioport>` que o campo
	pertence.

**field.live** (somente leitura)

	O :ref:`estado do campo da porta de E/S em tempo real
	<luareference-input-fieldlive>` do campo.

**field.type** (somente leitura)

	O tipo da entrada do campo.  Este é um valor enumerado.

**field.name** (somente leitura)

	O nome da exibição do campo.

**field.default_name** (somente leitura)

	O nome da configuração para o campo do sistema emulado (não pode
	ser substituído por scripts ou plug-ins).

**field.player** (somente leitura)

	O número do jogador para o campo com base zero.

**field.mask** (somente leitura)

	Os Bits na porta de E/S correspondente a este campo.

**field.defvalue** (somente leitura)

	O valor predefinido do campo

**field.sensitivity** (somente leitura)

	A sensibilidade ou ganho para os campos analógicos

**field.way** (somente leitura)

	A quantidade das direções permitidas através do restritor da
	placa/portão para um joystick digital ou zero (0) para as outras
	entradas.

**field.type_class** (somente leitura)

	O tipo da classe para o campo da entrada para um dos ``"keyboard"``,
	``"controller"``, ``"config"``, ``"dipswitch"`` ou ``"misc"``.

**field.is_analog** (somente leitura)

	Um booleano que indica se o campo é um eixo analógico ou controle
	posicional.

**field.is_digital_joystick** (somente leitura)

	Um booleano que indica se o campo corresponde ao comutador de um
	joystick digital.

**field.enabled** (somente leitura)

	Um booleano que indica se o campo está ativado.

.. raw:: latex

	\clearpage

**field.optional** (somente leitura)

	Um booleano que indica se o campo é opcional e não é obrigatório
	para uso no sistema que está sendo emulado.

**field.cocktail** (somente leitura)

	Um booleano que indica se o campo é usado apenas quando o sistema é
	configurado para um gabinete de mesa tipo coquetel.

**field.toggle** (somente leitura)

	Um booleano que indica se o campo corresponde a uma botão do
	hardware tipo liga/desliga ou um botão de pressão.

**field.rotated** (somente leitura)

	Um booleano que indica se o campo corresponde a um controle que é
	rotacionado em relação à orientação padrão.

**field.analog_reverse** (somente leitura)

	Um booleano que indica se o campo corresponde a um controle
	analógico que aumenta na direção oposta à convenção (por exemplo,
	valores maiores quando um pedal é solto ou um joystick é movido para
	a esquerda).

**field.analog_reset** (somente leitura)

	Um booleano que indica se o campo corresponde a um incremental da
	posição da entrada (por exemplo, um dial ou eixo do trackball) que
	deve ser redefinida para zero para cada quadro do vídeo.

**field.analog_wraps** (somente leitura)

	Um booleano que indica se o campo corresponde a uma entrada
	analógica que encapsula a partir de uma extremidade da sua faixa
	para a outra (por exemplo, uma posição incremental como a entrada de
	um dial ou o eixo do trackball).

**field.analog_invert** (somente leitura)

	Um booleano que indica se o campo corresponde a uma entrada
	analógica que tem o seu valor complementado.

**field.impulse** (somente leitura)

	Um booleano que indica se o campo corresponde a uma entrada digital
	que é ativado por um determinado período de tempo fixo.

**field.crosshair_scale** (somente leitura)

	O fator de escala para traduzir o intervalo do campo para a posição
	da mira. Um valor de um (1) que traduz o intervalo total do campo
	para a largura total ou altura da tela.

**field.crosshair_offset** (somente leitura)

	O offset para traduzir o intervalo do campo para a posição da mira.

**field.user_value** (leitura e escrita)

	O valor da chave DIP ou das definições da configuração.

**field.settings[]** (somente leitura)

	Obtém uma tabela das configurações ativadas atualmente para um
	interruptor DIP ou o campo de configuração, indexado por valor.

.. raw:: latex

	\clearpage

.. _luareference-input-fieldlive:

Estado do campo da porta de E/S em tempo real
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``ioport_field_live`` do MAME que representa o estado
em tempo real de uma porta de E/S.

Instanciação
^^^^^^^^^^^^

**manager.machine.ioport.ports[tag]:field(máscara).live**

	Obtém o estado em tempo real para um campo da porta de E/S.

Propriedades
^^^^^^^^^^^^

**live.name**

	O nome da exibição do campo.

.. raw:: latex

	\clearpage

.. _luareference-input-inputman:

Gerenciador da entrada
~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``input_manager`` do MAME que lê os dispositivos da
entrada do host e verifica se as entradas configuradas estão ativas.

Instanciação
^^^^^^^^^^^^

**manager.machine:input()**

	Obtém a instância global do gerenciador da entrada para o sistema
	que está sendo emulado.

Métodos
^^^^^^^

**input:code_value(código)**

	Obtém o valor atual para a entrada do host correspondente ao código
	informado. Retorna um valor inteiro assinado onde zero é a posição
	neutra.

**input:code_pressed(código)**

	Retorna um booleano indicando se o código informado da entrada do
	host correspondente tem um valor diferente de zero (ou seja, não é
	uma posição neutra).

**input:code_pressed_once(código)**

	Retorna um booleano indicando se o código informado da entrada do
	host correspondente saiu da posição neutra desde a última vez que
	foi verificado através desta função. O gerenciador da entrada pode
	rastrear uma quantidade de entradas desta forma.

**input:code_name(código)**

	Obtenha o nome de exibição para um código da entrada.

**input:code_to_token(código)**

	Obtenha a string do token para um código da entrada. Isso deve ser
	usado ao salvar uma configuração.

**input:code_from_token(token)**

	Converta uma string do token em um código de entrada. Retorna o
	código de entrada inválido se o token não for válido ou caso
	pertença a um dispositivo de entrada que não está presente.

**input:seq_pressed(sequência)**

	Retorna um booleano indicando se a sequência de entrada informada
	foi realmente pressionada.

**input:seq_clean(sequência)**

	Remova os elementos inválidos da sequência da entrada informada.
	Retorna uma nova, sequência limpa da entrada.

**input:seq_name(sequência)**

	Obtenha o texto de exibição para uma sequência da entrada.

.. raw:: latex

	\clearpage

**input:seq_to_tokens(sequência)**

	Converta uma sequência da entrada em uma string token. Isso deve ser
	usado quando for salvar ma configuração.

**input:seq_from_tokens(tokens)**

	Converta uma string token em uma sequência de entrada. Isso deve ser
	usado quando for carregar uma configuração.

**input:axis_code_poller()**

	Retorna um :ref:`código da condição da entrada
	<luareference-input-codepoll>` para obter um código da entrada do
	host analógico.

**input:switch_code_poller()**

	Retorna um :ref:`código da condição da entrada
	<luareference-input-codepoll>` para obter um código da entrada do
	interruptor do host.

**input:keyboard_code_poller()**

	Retorna um :ref:`código da condição da entrada
	<luareference-input-codepoll>` para a obtenção de um código da
	entrada do interruptor do host que considera apenas a entrada dos
	dispositivos do teclado.

**input:axis_sequence_poller()**

	Retorna uma :ref:`sequência da condição da entrada
	<luareference-input-seqpoll>` para obter uma sequência da entrada
	para configurar uma entrada analógica.

**input:axis_sequence_poller()**

	Retorna uma :ref:`sequência da condição da entrada
	<luareference-input-seqpoll>` para obter uma sequência da entrada
	para configurar uma entrada digital.

Propriedades
^^^^^^^^^^^^

**input.device_classes[]** (somente leitura)

	Pega uma tabela host :ref:`host da classe do dispositivo da entrada
	<luareference-input-devclass>` indexada por nome.

.. raw:: latex

	\clearpage

.. _luareference-input-codepoll:

Código da condição da entrada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``input_code_poller`` do MAME que é usada para
pesquisar as entradas do host que estão sendo ativadas.

Instanciação
^^^^^^^^^^^^

**manager.machine.input:axis_code_poller()**

	Retorna uma condição do código da entrada que pesquisa as entradas
	analógicas que estão sendo ativadas.

**manager.machine.input:switch_code_poller()**

	Retorna uma condição do código da entrada que pesquisa as entradas
	do interruptor do host que estão sendo ativadas.

**manager.machine.input:keyboard_code_poller()**

	Retorna uma condição do código da entrada que pesquisa as entradas
	do interruptor do host que estão sendo ativadas, considerando apenas
	os dispositivos da entrada do teclado.

Métodos
^^^^^^^

**poller:reset()**

	Redefine a lógica da pesquisa.  As entradas do interruptor ativo são
	apagadas e as entradas das posições analógica são definidas.

**poller:poll()**

	Retorna um código da entrada correspondente à primeira entrada
	relevante do host que foi ativado desde a última vez que o método
	foi invocado. Retorna um código de entrada inválido caso nenhuma
	entrada relevante tenha sido ativada.

.. raw:: latex

	\clearpage

.. _luareference-input-seqpoll:

Sequência da condição da entrada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe da condição ``input_sequence_poller`` do MAME que
permite que os usuários atribuam combinações na entrada do host para as
entradas emuladas e outras ações.

Instanciação
^^^^^^^^^^^^

**manager.machine.input:axis_sequence_poller()**

	Retorna uma condição da sequência da entrada para atribuir as
	entradas do host a uma entrada analógica.

**manager.machine.input:switch_sequence_poller()**

	Retorna uma condição da sequência da entrada para atribuir as
	entradas do host a entrada de um interruptor.

Métodos
^^^^^^^

**poller:start([seq])**

	Comece a obter.  Caso uma sequência seja fornecida, ela será usada
	como uma sequência inicial para entradas analógicas, o usuário pode
	alternar entre a faixa completa e as porções positivas e negativas
	de um eixo; para as entradas do interruptor, um código “or” é
	anexado e o usuário pode adicionar uma combinação alternativa da
	entrada do host.

**poller:poll()**

	Obtém a entrada do usuário e atualiza a sequência, caso seja
	apropriado. Retorna um booleano que indica se a entrada da sequência
	está completa. Se este método retornar falso, você deve continuar
	com o processo de obtenção.

Propriedades
^^^^^^^^^^^^

**poller.sequence (somente leitura)**

	A sequência da entrada atual.  Isso é atualizado durante o processo
	de obtenção. É possível para que a sequência se torne inválida.

**poller.valid (somente leitura)**

	Um booleano que indica se a sequência da entrada atual é válida.

**poller.modified (somente leitura)**

	Um booleano que indica se a sequência foi alterada através de alguma
	entrada do usuário desde o início do processo.

.. raw:: latex

	\clearpage

.. _luareference-input-devclass:

Host da classe do dispositivo da entrada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``input_class`` do MAME que representa uma categoria
da entrada do host dos dispositivos (por exemplo, teclados ou
joysticks).

Instanciação
^^^^^^^^^^^^

**manager.machine.input.device_classes[nome]**

	Obtém uma entrada da classe do dispositivo por nome.

Propriedades
^^^^^^^^^^^^

**devclass.name** (somente leitura)

	O nome da classe do dispositivo.

**devclass.enabled** (somente leitura)

	Um booleano que indica se a classe do dispositivo está ativo.

**devclass.multi** (somente leitura)

	Um booleano que indica se a classe do dispositivo oferece suporte a
	vários dispositivos ou as entradas de todos os dispositivos da
	classe são combinadas e tratadas como um único dispositivo.

**devclass.devices[]** (somente leitura)

	Obtém uma tabela :ref:`host do dispositivo da entrada
	<luareference-input-inputdev>` na classe. As chaves são os índices
	com base 1.

.. raw:: latex

	\clearpage

.. _luareference-input-inputdev:

Host do dispositivo da entrada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``input_device`` do MAME que representa um
dispositivo da entrada do host.

Instanciação
^^^^^^^^^^^^

**manager.machine.input.device_classes[nome].devices[índice]**

	Obtém um dispositivo de entrada específica de um host.

Propriedades
^^^^^^^^^^^^

**inputdev.name** (somente leitura)

	Nome da exibição do dispositivo.  Não há garantia de que isso seja
	exclusivo.

**inputdev.id** (somente leitura)

	String do identificador exclusivo para o dispositivo. Isso pode não
	ser legível para as pessoas.

**inputdev.devindex** (somente leitura)

	O índice do dispositivo dentro da classe de dispositivo. Isso não é
	necessariamente o mesmo que o índice na propriedade ``devices`` da
	classe do dispositivo o índice do ``devindex`` podem não ser
	contíguos.

**inputdev.items** (somente leitura)

	Obtém as tabelas :ref:`host do item do dispositivo da entrada
	<luareference-input-inputitem>`, indexado através da ID do item. A
	ID do item é um valor enumerado.

.. raw:: latex

	\clearpage

.. _luareference-input-inputitem:

Host do item do dispositivo da entrada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``input_device_item`` do MAME que representa uma
única entrada do host (por exemplo uma chave, botão ou eixo).

Instanciação
^^^^^^^^^^^^

**manager.machine.input.device_classes[nome].devices[índice].items[id]**

	Obtém um item individual da entrada do host.  A ID do item é um
	valor enumerado.

Propriedades
^^^^^^^^^^^^

**item.name** (somente leitura)

	O nome da exibição da entrada do item.  Observe que este é apenas o
	nome do próprio item que não inclui o nome do dispositivo. O nome
	completo da exibição para o item pode ser obtido ao invocar o método
	``code_name`` no :ref:`gerenciador da entrada
	<luareference-input-inputman>` com o código do item.

**item.code** (somente leitura)

	O código de identificação da entrada do item. Isso é usado por
	vários métodos do :ref:`gerenciador da entrada
	<luareference-input-inputman>`.

**item.token** (somente leitura)

	A string token do item da entrada. Observe que este é um fragmento
	do token para o o próprio item que não inclui a parte do
	dispositivo. O token completo para o item pode ser obtido ao invocar
	o método ``code_to_token`` no :ref:`gerenciador da entrada
	<luareference-input-inputman>` com o código do item.

**item.current** (somente leitura)

	O valor atual do item. Este é um número inteiro assinado onde zero é
	a posição neutra.

.. raw:: latex

	\clearpage

.. _luareference-input-uiinput:

Gerenciador da entrada da IU
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``ui_input_manager`` do MAME que é usada para a
entrada de alto nível.

Instanciação
^^^^^^^^^^^^

**manager.machine.uiinput**

	Obtém a instância do gerenciador da entrada global da IU para a
	máquina.

Métodos
^^^^^^^

**uiinput:find_mouse()**

	Retorna o ponteiro do mouse do sistema host, posição X, posição Y,
	estado do botão e o :ref:`alvo do renderizador
	<luareference-render-target>` que se encaixa. A posição no host
	está em pixels, onde zero está na parte superior/esquerda. O estado
	do botão é um booleano que indica se o botão principal do mouse está
	pressionado.

	Se o ponteiro do mouse não estiver sobre uma das janelas do MAME,
	isso pode retornar a posição e renderizar o alvo de quando o
	ponteiro do mouse estava mais recentemente sobre uma das janelas do
	MAME. O alvo da renderização pode ser ``nil`` se o ponteiro do
	mouse não estiver sobre uma das janelas do MAME.

**uiinput:pressed(tipo)**

	Retorna um booleano indicando se a entrada da IU informada foi
	pressionada. O tipo da entrada é um valor enumerado.

**uiinput:pressed_repeat(tipo, velocidade)**

	Retorna um booleano indicando se a entrada da IU informada foi
	pressionada ou a repetição automática foi disparada na velocidade
	informada. O tipo da entrada é um valor enumerado; a velocidade é um
	intervalo em sessenta avos de um segundo.

Propriedades
^^^^^^^^^^^^

**uiinput.presses_enabled (leitura e escrita)**

	Se o gerenciador da entrada da IU verificará se há atualizações do
	quadro das entradas da IU.

.. raw:: latex

	\clearpage

.. _luareference-render:

Sistema renderizador
--------------------

O sistema de renderização é responsável por desenhar o que você vê nas
janelas do MAME, incluindo as telas emuladas, a arte e os elementos da
interface do usuário.

.. _luareference-render-bounds:

Limites do renderizador
~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``render_bounds`` do MAME que representa um retângulo
usando as coordenadas de ponto flutuante.

Instanciação
^^^^^^^^^^^^

**emu.render_bounds()**

	Cria os limites da renderização de um objeto que representa uma
	unidade quadrada com o canto superior esquerdo em (0, 0) e canto
	inferior direito em (1, 1). Observe que ao renderizar as coordenadas
	do alvo elas não possuem necessariamente as mesmas escalas X e Y,
	então isso pode não representar a geração de um quadrado.

**emu.render_bounds (esquerda, cima, direita, baixo)**

	Cria os limites da renderização de um objeto representando um
	retângulo com o canto superior esquerdo em (x0, y0) e o canto
	inferior direito em (x1, y1).

	Todos os argumentos devem ser em números de ponto flutuante.

Métodos
^^^^^^^

**bounds:includes(x, y)**

	Retorna um booleano indicando se o ponto informado está dentro do
	retângulo. O retângulo deve ser normalizado para que funcione
	(direito maior que o esquerdo e baixo maior do que cima). Os
	argumentos devem ser números de ponto flutuante.

**bounds:set_xy(esquerda, cima, direita, baixo)**

	Define a posição e o tamanho do retângulo nos termos das posições
	das bordas. Todos os argumentos devem ser em números de ponto
	flutuante.

**bounds:set_wh(esquerda, cima, largura, altura)**

	Define a posição e o tamanho do retângulo nos termos da posição do
	canto superior esquerdo, da largura e da altura. Todos os argumentos
	devem ser em números de ponto flutuante.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**bounds.x0** (leitura e escrita)

	A coordenada mais à esquerda no retângulo (ou seja, a coordenada X
	do lado da borda esquerda ou no canto superior esquerdo).

**bounds.x1** (leitura e escrita)

	A coordenada mais à direita no retângulo (ou seja, a coordenada X da
	borda direita ou do canto inferior direito).

**bounds.y0** (leitura e escrita)

	A coordenada superior no retângulo (ou seja, a coordenada Y da parte
	da borda superior ou no canto superior esquerdo).

**bounds.y1** (leitura e escrita)

	A coordenada mais inferior do retângulo (ou seja, a coordenada Y da
	borda inferior ou do canto inferior direito).

**bounds.width** (leitura e escrita)

	A largura do retângulo. Ao definir esta propriedade a posição da
	extremidade direita muda.

**bounds.height** (leitura e escrita)

	A altura do retângulo. Ao definir esta propriedade a posição da
	borda inferior muda.

**bounds.aspect** (somente leitura)

	A proporção entre a largura e altura do retângulo. Observe que o
	alvo geralmente é usado em coordenadas de renderização que não
	necessariamente têm escalas X e Y iguais. Um retângulo representando
	um quadrado na saída final não necessariamente tem uma proporção de
	1.

.. raw:: latex

	\clearpage

.. _luareference-render-color:

Renderização da cor
~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``render_color`` do MAME que representa um formato
de cor ARGB (alfa, vermelho, verde, azul). Os canais são valores de
ponto flutuante que variam de zero (0, alfa transparente ou sem cor) a
um (1, opaco ou totalmente colorido). Os valores do canal da cor não são
pré-multiplicados pelo valor do canal alfa.

Instanciação
^^^^^^^^^^^^

**emu.render_color()**

	Cria um objeto colorido representando o branco opaco (todos os
	canais definidos como 1). Este é o valor da identidade, a
	multiplicação do ARGB por este valor não irá alterar uma cor.

**emu.render_color(a, r, g, b)**

	Cria a renderização de um objeto colorido com o alfa, vermelho,
	verde e os valores do canal azul. Os argumentos devem ser todos
	números de ponto flutuante no intervalo de zero (0) até um (1).

Métodos
^^^^^^^

**color:set(a, r, g, b)**

	Define os valores dos canais alfa, vermelho, verde e azul da cor do
	objeto. Os argumentos devem ser todos números de ponto flutuante no
	intervalo de zero (0) até um (1).

Propriedades
^^^^^^^^^^^^

**color.a** (leitura e escrita)

	O valor alfa, na faixa entre zero (0, transparente) até um (1,
	opaco).

**color.r** (leitura e escrita)

	O valor do canal vermelho, na faixa entre zero (0, desligado) até um
	(1, intensidade total).

**color.g** (leitura e escrita)

	O valor do canal verde, na faixa entre zero (0, desligado) até um
	(1, intensidade total).

**color.b** (leitura e escrita)

	O valor do canal azul, na faixa entre zero (0, desligado) até um
	(1, intensidade total).

.. raw:: latex

	\clearpage

.. _luareference-render-manager:

Gerenciador do renderizador
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``render_manager`` do MAME que é responsável pelo
gerenciamento do destino da renderização e das texturas.

Instanciação
^^^^^^^^^^^^

**manager.machine.render**

	Obtém a instância do gerenciador da renderização global para a
	sessão emulada.

Propriedades
^^^^^^^^^^^^

render.max_update_rate (somente leitura)

    A taxa de atualização máxima em Hertz.  Este é um número de ponto flutuante.

**render.ui_target** (somente leitura)

	O :ref:`alvo do renderizador <luareference-render-target>` usado
	para desenhar a interface do usuário (incluindo os menus, os
	controles deslizantes e as mensagens de pop-up). Geralmente é a
	primeira janela ou a primeira tela do host.

**render.ui_container** (somente leitura)

	O :ref:`contêiner do renderizador <luareference-render-container>`
	usado para desenhar a interface do usuário.

**render.targets[]** (somente leitura)

	A lista da renderização dos alvos, incluindo as janelas e as telas
	geradas, bem como os alvos ocultos renderizados para coisas como a
	renderização das capturas da tela. Usa índices inteiros com base 1.
	O operador de índice e o método ``at`` têm O(n) complexidade.

.. raw:: latex

	\clearpage

.. _luareference-render-target:

Alvo do renderizador
~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``render_target`` do MAME que representa a saída de
um canal de vídeo. Pode ser uma janela, a tela do host ou um alvo oculto
usado para a renderização da captura da tela.

Instanciação
^^^^^^^^^^^^

**manager.machine.render.targets[índice]**

	Obtenha a renderização de um alvo por índice.

**manager.machine.render.ui_target**

	Obtenha a renderização de um alvo usado para exibir a interface do
	usuário (incluindo os menus, os controles deslizantes e as mensagens
	de pop-up). Geralmente é a primeira janela do host ou tela.

Propriedades
^^^^^^^^^^^^

**target.index** (somente leitura)

	O índice do destino de renderização com base 1. Isso tem
	complexidade O(n).

**target.width** (somente leitura)

	A geração da largura da renderização do alvo em pixels.  Este é um
	número inteiro.

**target.height** (somente leitura)

	A geração da altura da renderização do alvo em pixels. Este é um
	número inteiro.

**target.pixel_aspect** (somente leitura)

	A geração da renderização da proporção entre a largura e a altura
	dos pixels. Isto é um número de ponto flutuante.

**target.hidden** (somente leitura)

	Um booleano que indica se este alvo é uma renderização interna que
	não é exibido diretamente para o usuário (por exemplo, o alvo da
	renderização usado para criar as capturas da tela).

**target.is_ui_target** (somente leitura)

	Um booleano que indica se este é o destino de renderização usado
	para exibir a interface do usuário.

**target.max_update_rate** (leitura e escrita)

	A taxa de atualização máxima para a renderização do alvo em Hertz.

**target.orientation** (leitura e escrita)

	Os sinalizadores de orientação do alvo. Esta é uma máscara bit
	inteira, onde o bit 0 (0x01) é definido para espelhar
	horizontalmente, o bit 1 (0x02) é definido para espelhar
	verticalmente e o bit 2 (0x04) é definido para espelhar ao longo do
	canto superior esquerdo inferior e a diagonal direita.

.. raw:: latex

	\clearpage

**target.view_names[]**

	Os nomes das visualizações disponíveis para a renderização deste
	alvo. Usa base 1 e índices inteiros.  Os métodos ``find`` e o
	``index_of`` têm O(n) complexidade; todas as outras operações
	compatíveis têm complexidade O(1).

**target.current_view** (somente leitura)

	A visualização selecionada atualmente para o alvo renderizado. Isto
	é um objeto da :ref:`visualização do layout
	<luareference-render-layview>`.

**target.view_index** (leitura e escrita)

	O índice base 1 da visualização selecionada para a renderização
	deste alvo.

**target.visibility_mask** (read-only)

	Uma máscara bit inteira indicando quais as coleções dos itens estão
	visíveis no momento da visualização atual.

**target.screen_overlay** (leitura e escrita)

	Um booleano que indica se as sobreposições da tela estão ativadas.

**target.zoom_to_screen** (leitura e escrita)

	Um booleano que indica se renderização do alvo está configurado para
	escalar fazendo com que as telas emuladas preencham toda a
	janela/tela o quanto for possível.

.. raw:: latex

	\clearpage

.. _luareference-render-container:

Contêiner do renderizador
~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``render_container``.

Instanciação
^^^^^^^^^^^^

**manager.machine.render.ui_container**

	Obtém a renderização do contêiner usado para desenhar a interface do
	usuário, incluindo menus, controles deslizantes e as mensagens de
	pop-up.

**manager.machine.screens[tag].container**

	Obtém a renderização do contêiner usado para desenhar uma
	determinada tela.

Propriedades
^^^^^^^^^^^^

**container.user_settings** (leitura e escrita)

	A :ref:`configuração do usuário do contêiner
	<luareference-render-contsettings>`. Pode ser usado para controlar
	uma série de ajustes de imagem.

**container.orientation** (leitura e escrita)

	Os sinalizadores de orientação do contêiner. Esta é uma máscara bit
	inteira, onde o bit 0 (0x01) é definido para espelhar
	horizontalmente, o bit 1 (0x02) é definido para espelhar
	verticalmente e o bit 2 (0x04) é definido para espelhar ao longo do
	canto superior esquerdo inferior e a diagonal direita.

**container.xscale** (leitura e escrita)

	O fator de escala X do contêiner. Este é um número de ponto
	flutuante.

**container.yscale** (leitura e escrita)

	O fator de escala Y do contêiner. Este é um número de ponto
	flutuante.

**container.xoffset** (leitura e escrita)

	O offset X do contêiner.  Este é um número de ponto flutuante onde
	um (1) corresponde ao tamanho X do contêiner.

**container.yoffset** (leitura e escrita)

	O offset Y do contêiner.  Este é um número de ponto flutuante onde
	um (1) corresponde ao tamanho Y do contêiner.

**container.is_empty** (somente leitura)

	Um booleano que indica se o contêiner não possui itens.

.. raw:: latex

	\clearpage

.. _luareference-render-contsettings:

Configurações do usuário do contêiner
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``render_container::user_settings`` do MAME que
representa os ajustes da imagem aplicados a um
:ref:`contêiner do renderizador <luareference-render-container>`.

Instanciação
^^^^^^^^^^^^

**manager.machine.screens[tag].container**

	Obtém a renderização atual do contêiner usado para desenhar uma
	determinada tela.

Propriedades
^^^^^^^^^^^^

**settings.orientation** (leitura e escrita)

	Os sinalizadores de orientação do contêiner. Esta é uma máscara bit
	inteira, onde o bit 0 (0x01) é definido para espelhar
	horizontalmente, o bit 1 (0x02) é definido para espelhar
	verticalmente e o bit 2 (0x04) é definido para espelhar ao longo do
	canto superior esquerdo inferior e a diagonal direita.

**settings.brightness** (leitura e escrita)

	O ajuste do brilho aplicado ao contêiner. Este é um número de ponto
	flutuante.

**settings.contrast** (leitura e escrita)

	O ajuste do contraste aplicado ao contêiner. Este é um número de
	ponto flutuante.

**settings.gamma** (leitura e escrita)

	O ajuste gama aplicado ao contêiner. Este é um número de ponto
	flutuante.

**settings.xscale** (leitura e escrita)

	O fator de escala X do contêiner. Este é um número de ponto
	flutuante.

**settings.yscale** (leitura e escrita)

	O fator de escala Y do contêiner. Este é um número de ponto
	flutuante.

**settings.xoffset** (leitura e escrita)

	O offset X do contêiner. Este é um número de ponto flutuante onde
	um (1) representa o tamanho X do contêiner.

**settings.yoffset** (leitura e escrita)

	O offset Y do contêiner. Este é um número de ponto flutuante onde
	um (1) representa o tamanho Y do contêiner.

.. raw:: latex

	\clearpage

.. _luareference-render-layfile:

Arquivo layout
~~~~~~~~~~~~~~

Encapsula a classe ``layout_file`` do MAME que representa as
visualizações carregadas a partir de um arquivo layout para uso do
destino de uma renderização.

Instanciação
^^^^^^^^^^^^

Um objeto do arquivo layout é fornecido ao seu script layout na variável
``file``. Os objetos do arquivo layout não são instanciados diretamente
a partir dos scripts Lua.

Métodos
^^^^^^^

**layout:set_resolve_tags_callback(cb)**

	Define uma função para realizar tarefas adicionais depois que a
	máquina emulada tenha finalizado a sua inicialização, quando as tags
	nas visualizações do layout tenham sido resolvidas e os
	manipuladores dos itens da visualização principal tenham sido
	configurados. A função não deve aceitar nenhum argumento.

	Invoque com ``nil`` para remover o callback.

Propriedades
^^^^^^^^^^^^

**layout.device** (somente leitura)

	O dispositivo que fez com que o arquivo layout fosse carregado.
	Normalmente o dispositivo raiz da máquina no caso dos layouts
	externos.

**layout.views[]** (somente leitura)

	As :ref:luareference-render-layview` criados a partir do arquivo
	layout.
	As visualizações são indexadas por nomes não qualificados (ou seja,
	o valor do atributo ``name``). As visualizações são ordenadas como
	aparecem no arquivo de layout ao iterar ou usar o método ``at``.
	Os métodos do índice obtém ``at`` e ``index_of`` com complexidade
	O(n).

	Observe que nem todas as visualizações no arquivo XML podem ser
	criadas. Por exemplo, as visualizações não são criadas se a
	referência das telas forem fornecidas pelos dispositivos do cartão
	do slot caso o os referidos dispositivos do cartão do slot não
	estiverem presentes no sistema.

.. raw:: latex

	\clearpage

.. _luareference-render-layview:

Visualização do layout
~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``layout_view`` do MAME que representa uma
visualização que pode ser renderizada em um determinado alvo.  As
visualizações são criadas a partir dos arquivos layout, podem ser
carregados a partir da arte externa, interna do MAME ou gerada
automaticamente com base nas telas do sistema que está sendo emulado.

Instanciação
^^^^^^^^^^^^

Os scripts do layout em geralmente

**manager.machine.render.targets[índice].current_view**

	Obtém a visualização selecionada atualmente para renderizar um
	determinado alvo.

Métodos
^^^^^^^

**view:has_screen(tela)**

	Retorna um booleano indicando se a tela está presente na
	visualização. Isso é verdadeiro para telas que estão presentes, mas
	não visíveis porque o usuário ocultou a coleção dos itens que
	pertencem à ela.

**view:set_prepare_items_callback(cb)**

	Define uma função para realizar tarefas adicionais antes que os
	itens da visualização sejam adicionados na renderização do alvo em
	preparação para o desenho de um quadro de vídeo. A função não deve
	aceitar quaisquer argumentos. Invoque com ``nil`` para remover o
	callback.

**view:set_preload_callback(cb)**

	Define uma função para realizar tarefas adicionais após pré-carregar
	a visualização dos itens visíveis. A função não deve aceitar
	quaisquer argumentos. Invoque com ``nil`` para remover o callback.
	Esta função pode ser invocada quando o usuário seleciona uma
	visualização ou torna a visualização do item de uma coleção visível.
	Ele pode ser invocado várias vezes para obter uma exibição,
	portanto, evite repetir tarefas dispendiosas.

**view:set_recomputed_callback(cb)**

	Defina uma função para realizar tarefas adicionais depois que as
	dimensões da visualizações tenham sido recomputadas.
	A função não deve aceitar quaisquer argumentos. Invoque com ``nil``
	para remover o callback.

	As coordenadas da visualização são recalculadas em vários eventos,
	incluindo a janela que estiver sendo redimensionada, entrando ou
	saindo do modo de tela inteira e alterando a configuração de zoom
	para região da tela.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**view.items[]** (somente leitura)

	O elemento do layout e da tela de :ref:`visualização do item do
	layout <luareference-render-layitem>` em uma visualização. Este
	contêiner não suporta iteração por chave usando ``pairs``; só é
	compatível a iteração através do índice usando ``ipairs``. A chave é
	o valor do atributo ``id``, caso esteja presente. Apenas itens com
	atributos ``id`` podem ser pesquisados através das chaves. O método
	index get tem complexidade O(1) e os métodos ``at`` e o ``index_of``
	têm complexidade O(n).

**view.name** (somente leitura)

	Exibe o nome da visualização.
	Isso pode ser qualificado para indicar o dispositivo que causou o
	carregamento do arquivo layout, quando não é o dispositivo raiz da
	máquina.

**view.unqualified_name** (somente leitura)

	O nome não qualificado da visualização, exatamente como aparece no
	atributo ``name`` no arquivo layout.

**view.visible_screen_count** (somente leitura)

	A quantidade dos itens nas telas que estão atualmente ativados na
	visualização.

**view.effective_aspect** (somente leitura)

	A proporção efetiva entre a largura e a altura da visualização com a
	sua configuração atual.

**view.bounds** (somente leitura)

	O :ref:`limites do renderizador <luareference-render-bounds>` do
	objeto que representa os limites efetivos da visualização na sua
	configuração atual.
	As coordenadas estão em unidades de visualização, que são
	arbitrárias, porém assumidas como tendo uma proporção quadrada.

**view.has_art**

	Um booleano que indica se a visualização possui itens que não são da
	tela, incluindo itens que não são visíveis porque o usuário ocultou
	a coleção dos itens aos quais elas pertencem.

.. raw:: latex

	\clearpage

.. _luareference-render-layitem:

Visualização do item do layout
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``layout_view::item`` do MAME que representa um item
em uma visualização. Um item é desenhado como uma superfície retangular
texturizada. A textura é fornecida por uma tela emulada ou um elemento
do layout.

Instanciação
^^^^^^^^^^^^

**layout.views[name].items[id]**

	Obtém um item da visualização através do ID.
	O item deve ter um atributo ``id`` no arquivo layout para que possa
	ser pesquisado através do ID.

Métodos
^^^^^^^

**item:set_state(state)**

	Define o valor usado como o estado do elemento e o estado da
	animação na ausência dos vínculos. O argumento deve ser um número
	inteiro.

**item.set_element_state_callback(cb)**

	Define uma função a ser invocada para obter o estado do elemento
	para o item. A função não deve aceitar quaisquer argumentos e deve
	retornar um número inteiro.
	Invoque com ``nil`` para restaurar o estado original do callback do
	elemento (com base nos vínculos no arquivo layout).

	Observe que a função não deve acessar a propriedade
	``element_state`` do item, pois isso resultará em uma recursão
	infinita. Este callback não será usado para obter o estado de
	animação para o item, mesmo se o item não tiver vínculos explícitos
	do estado de animação no arquivo layout.

**item.set_animation_state_callback(cb)**

	Define uma função que será invocada para obter o estado de animação
	do item. A função não deve aceitar quaisquer argumentos e deve
	retornar um número inteiro. Invoque com ``nil`` para restaurar o
	estado de animação original do callback (com base nos vínculos no
	arquivo layout).

	Observe que a função não deve acessar a propriedade
	``animation_state`` do item, pois isso resultará em uma recursão
	infinita.

**item.set_bounds_callback(cb)**

	Define uma função a ser chamada para obter os limites do item.
	A função não deve aceitar qualquer argumento e deve retornar um
	:ref:`limites do renderizador <luareference-render-bounds>` do
	objeto nas coordenadas do alvo renderizado. Invoque com ``nil`` para
	restaurar o estado do limite original do callback (com base no
	estado da animação do item e nos elementos ``bounds`` herdados no
	arquivo layout).

	Observe que a função não deve acessar a propriedade ``bounds`` do
	item, pois isso resultará em uma recursão infinita.

**item.set_color_callback(cb)**

	Defina uma função que será invocada para obter a cor do
	multiplicador para o item. A função não deve aceitar qualquer
	argumento e deve retornar um objeto
	:ref:`renderização da cor <luareference-render-color>`.
	Invoque com ``nil`` para restaurar a cor original do callback
	(com base no estado da animação do item e dos elementos ``color``
	herdados no arquivo layout).

	Observe que a função não deve acessar a propriedade ``color`` do
	item, pois isso resultará em uma recursão infinita.

.. raw:: latex

	\clearpage

Propriedades
^^^^^^^^^^^^

**item.id** (somente leitura)

	Obtenha o identificador opcional do item. Este é o valor do
	atributo ``id`` no arquivo layout caso esteja presente ou ``nil``.

**item.bounds_animated** (somente leitura)

	Um booleano que indica se os limites do item dependem de seu estado
	de animação.

**item.color_animated** (somente leitura)

	Um booleano que indica se a cor do item depende de seu estado de
	animação.

**item.bounds** (somente leitura)

	Os limites do item para o estado atual.
	Este é um
	:ref:`limitador do renderizador <luareference-render-bounds>` do
	objeto nas coordenadas do alvo renderizado.

**item.color** (somente leitura)

	A cor do item para o estado atual.
	A cor da tela ou da textura do elemento é multiplicada por esta cor.
	Este faz a :ref:`renderização da cor <luareference-render-color>`
	do objeto.

**item.blend_mode** (somente leitura)

	Obtém modo de mesclagem do item.
	Este é um valor inteiro, onde 0 significa sem mesclagem, 1 significa
	mesclagem alfa, 2 significa multiplicação por RGB, 3 significa
	mesclagem aditiva e -1 permite que os itens dentro de um contêiner
	determinem os seus próprios modos de mesclagem.

**item.orientation** (somente leitura)

	Obtém os sinalizadores da orientação do item.
	Esta é uma máscara bit inteira onde o bit 0 (0x01) é definido para
	espelhar horizontalmente, o bit 1 (0x02) é definido para espelhar
	verticalmente e o bit 2 (0x04) é definido para espelhar ao longo da
	diagonal superior esquerda e inferior direita.

**item.element_state** (somente leitura)

	Obtenha o estado atual do elemento.
	Isso invocará a função callback do estado do elemento para lidar com
	os vínculos.

**item.animation_state** (somente leitura)

	Obtém o estado atual da animação. Isso invocará a função callback do
	estado de animação do elemento para lidar com os vínculos.

.. raw:: latex

	\clearpage

.. _luareference-debug:

Depurador
---------

Alguns dos principais recursos de depuração do MAME podem ser
controlados a partir do script Lua. O depurador deve ser ativado para
usar os recursos de depuração (normalmente usando ``-debug`` na linha de
comando).

.. _luareference-debug-manager:

Gerenciador do depurador
~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``debugger_manager`` do MAME que fornece a interface
principal para controlar o depurador.

Instanciação
^^^^^^^^^^^^

**manager.machine:debugger()**

	Retorna a instância do gerenciador de depuração global ou ``nil`` se
	o depurador não estiver ativado.

Métodos
^^^^^^^

**debugger:command(str)**

	Execute um comando no console do depurador.  O argumento é a string
	do comando. A saída é enviada ao console do depurador e ao console
	Lua.

Propriedades
^^^^^^^^^^^^

**debugger.consolelog[]** (somente leitura)

	As linhas no log do console (saída dos comandos do depurador).
	Este contêiner suporta apenas o comprimento das operações do índice.

**debugger.errorlog[]** (read-only)

	As linhas no registro log de erros (saída ``logerror``).
	Este contêiner suporta apenas o comprimento das operações do índice.

**debugger.visible_cpu** (leitura e escrita)

	O dispositivo CPU com foco no depurador. As alterações se tornam
	visíveis no console do depurador depois da próxima etapa.
	Não há efeito quando configurando para um dispositivo que não seja
	uma CPU.

**debugger.execution_state** (leitura e escrita)

	Tanto ``"run"`` se o sistema que estiver sendo emulado estiver
	rodando, ou ``"stop"`` caso esteja parado no depurador.

.. raw:: latex

	\clearpage

.. _luareference-debug-devdebug:

Interface de depuração do dispositivo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Encapsula a classe ``device_debug`` do MAME que fornece a interface do
depurador para um dispositivo emulado da CPU.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag]:debug()**

	Retorna a interface do depurador para um dispositivo emulado da CPU
	ou ``nil`` caso o dispositivo não seja uma CPU.

Métodos
^^^^^^^

**debug:step([cnt])**

	Avance através da quantidade especificada das instruções.
	Caso a contagem das instruções não seja informada, o padrão é uma
	única instrução.

**debug:go()**

	Execute a CPU que estiver sendo emulada.

**debug:bpset(addr, [cond], [act])**

	Defina um breakpoint no endereço informado com uma condição e ações
	opcionais. Caso a ação não seja informada, o padrão é apenas parar
	no depurador. Retorna o número do breakpoint para o novo breakpoint.

	Caso seja especificada, a condição deve ser uma expressão do
	depurador que será avaliada sempre que o breakpoint for atingido.
	A execução só será interrompida se a expressão for avaliada como um
	valor diferente de zero. Caso a condição não seja informada, o
	padrão é sempre estar ativo.

**debug:bpenable([bp])**

	Ative o breakpoint informado ou todos os breakpoints do dispositivo
	caso nenhum número do breakpoint seja informado. Retorna se o número
	informado correspondeu a um breakpoint caso o número do breakpoint
	seja informado ou ``nil`` caso nenhum seja informado.

**debug:bpdisable([bp])**

	Desative o breakpoint informado ou todos os breakpoints do
	dispositivo caso nenhum número seja informado. Retorna se o número
	informado correspondeu a um breakpoint caso o número do breakpoint
	seja informado ou ``nil`` caso nenhum seja informado.

**debug:bpclear([bp])**

	Limpe o breakpoint informado ou todos caso se nenhum número seja
	informado. Retorna se o número informado correspondeu a um
	breakpoint caso o número do breakpoint seja informado ou ``nil``
	caso nenhum seja informado.

.. raw:: latex

	\clearpage

**debug:bplist()**

	Retorna uma tabela dos breakpoints para o dispositivo. As chaves são
	os números dos breakpoints e os valores são os
	:ref:`breakpoints <luareference-debug-breakpoint>`.

**debug:wpset(espaço, tipo, endereço, comprimento, [condição], [act])**

	Define um watchpoint sobre o intervalo dos endereços informados com
	uma ação e condição opcionais. O tipo deve ser ``"r"``, ``"w"`` ou
	``"rw"`` para a leitura, a escrita ou a leitura e a escrita do
	breakpoint. Caso a ação não seja informada, o padrão é apenas parar
	no depurador.
	Retorna o número do watchpoint para o novo watchpoint.

	Caso seja especificada, a condição deve ser uma expressão do
	depurador que será avaliada sempre que o breakpoint for atingido.
	A execução só será interrompida caso a expressão seja avaliada como
	um valor diferente de zero. A variável ``wpaddr`` é definida para
	o atual endereço que acionou o watchpoint, a variável ``wpdata`` é
	definida para o dado que está sendo lido ou gravado, a variável
	``wpsize`` é definida para o tamanho do dado em bytes.

	Caso a condição não seja definida, ela sempre estará ativa.

**debug:wpenable([wp])**

	Ative o watchpoint informado ou todos os watchpoints do dispositivo
	caso nenhum número seja informado. Retorna se o número informado
	correspondeu a watchpoint caso um número seja informado ou ``nil``
	caso nenhumseja.

**debug:wpdisable([wp])**

	Desative o watchpoint informado ou todos os watchpoints do
	dispositivo caso nenhum número seja informado. Retorna se o número
	informado correspondeu a watchpoint caso um número seja informado ou
	``nil`` caso nenhum seja.

**debug:wpclear([wp])**

	Limpe o watchpoint informado ou todos os watchpoints do dispositivo
	caso nenhum número seja informado. Retorna se o número informado
	correspondeu a watchpoint caso um número seja informado ou ``nil``
	caso nenhum seja.

**debug:wplist(spaço)**

	Retorna uma tabela com os watchpoints para o espaço de endereço
	informado para o dispositivo. As chaves são os números watchpoints e
	os valores são os
	:ref:`watchpoints <luareference-debug-watchpoint>`.

.. raw:: latex

	\clearpage

.. _luareference-debug-breakpoint:

Breakpoint
~~~~~~~~~~

Encapsula a classe ``debug_breakpoint`` do MAME que representa um ponto
de interrupção (breakpoint) para um dispositivo emulado da CPU.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag]:debug():bplist()[bp]**

	Obtém o breakpoint informado para um dispositivo emulada da CPU ou
	``nil`` caso nenhum breakpoint corresponda ao índice informado.

Propriedades
^^^^^^^^^^^^

**breakpoint.index** (somente leitura)

	O índice do breakpoint. Pode ser usado para ativar, desativar ou
	limpar o breakpoint através da :ref:`interface de depuração do
	dispositivo <luareference-debug-devdebug>`.

**breakpoint.enabled** (somente leitura)

	Um booleano que indica se o breakpoint no momento está ativo.

**breakpoint.address** (somente leitura)

	O endereço do breakpoint.

**breakpoint.condition** (somente leitura)

	Uma expressão do depurador avaliada cada vez que o breakpoint for
	atingido. A ação só será disparada caso esta expressão seja avaliada
	como um valor diferente de zero. Uma string vazia caso nenhuma
	condição seja informada.

**breakpoint.action** (somente leitura)

	Uma ação que o depurador executará quando o breakpoint for atingido
	e a condição for avaliada como um valor diferente de zero.
	Uma string vazia caso nenhuma ação seja informada.

.. raw:: latex

	\clearpage

.. _luareference-debug-watchpoint:

Watchpoint
~~~~~~~~~~

Encapsula a classe ``debug_watchpoint`` do MAME que representa um ponto
de controle (watchpoint) para um dispositivo emulado da CPU.

Instanciação
^^^^^^^^^^^^

**manager.machine.devices[tag]:debug():wplist(espaço)[wp]**

	Obtém o watchpoint informado para um watchpoint de um dispositivo
	emulado da CPU ou ``nil`` caso nenhum watchpoint no espaço de
	endereço corresponda ao índice informado.

Propriedades
^^^^^^^^^^^^

**watchpoint.index** (somente leitura)

	O índice do watchpoint. Pode ser usado para ativar, desativar ou
	limpar o watchpoint através da :ref:`interface de depuração do
	dispositivo <luareference-debug-devdebug>`.

**watchpoint.enabled** (somente leitura)

	Um booleano que indica se o watchpoint no momento está ativo.

**watchpoint.type** (somente leitura)

	O tipo deve ser ``"r"``, ``"w"`` ou ``"rw"`` para a leitura, a
	escrita ou a leitura e a escrita do watchpoint.

**watchpoint.address** (somente leitura)

	O endereço inicial do intervalo dos endereços do watchpoint.

**watchpoint.length** (somente leitura)

	O comprimento do intervalo dos endereços do watchpoint.

**watchpoint.condition** (somente leitura)

	Uma expressão do depurador avaliada cada vez que o watchpoint for
	atingido. A ação só será disparada caso esta expressão seja avaliada
	como um valor diferente de zero. Uma string vazia caso nenhuma
	condição seja informada.

**watchpoint.action** (somente leitura)

	Uma ação que o depurador executará quando o watchpoint for atingido
	e a condição for avaliada como um valor diferente de zero.
	Uma string vazia caso nenhuma ação seja informada.

