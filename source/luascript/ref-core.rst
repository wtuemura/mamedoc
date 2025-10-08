.. raw:: latex

	\clearpage


.. _luascript-ref-core:

As principais classes Lua
=========================

Muitas das principais classes do MAME usadas para implementar a emulação
de uma sessão, estão disponíveis para os *scripts* Lua.

.. contents::
    :local:
    :depth: 1


.. _luascript-ref-notifiersub:

Assinatura do notificador
-------------------------

Envelopa a classe ``util::notifier_subscription`` do MAME, faz o
gerenciamento de uma assinatura numa notificação de difusão.


Métodos
~~~~~~~

**subscription:unsubscribe()**

	Faz a remoção da notificação das assinaturas . A assinatura se torna
	inativa e nenhuma outra notificação será recebida.


Propriedades
~~~~~~~~~~~~

**subscription.is_active** |sole|

	|ubqi| a assinatura está ativa. A assinatura se torna inativa depois
	que a assinatura for explicitamente cancelada ou caso o notificador
	subjacente seja destruído.

.. raw:: latex

	\clearpage


.. _luascript-ref-attotime:

Attotime
--------

|encaa| ``attotime`` do MAME, o que representa um intervalo de tempo de
alta precisão. Os valores *attotime* suportam a adição e a subtração com
outros valores *attotime*, assim como a multiplicação e a divisão por
números inteiros.


Instanciação
~~~~~~~~~~~~

**emu.attotime()**

	Cria um valor *attotime* representando zero (ou seja, sem tempo
	decorrido).


**emu.attotime(segundos, attosegundos)**

	Cria um *attotime* com as partes inteiras e fracionárias
	específicas.


**emu.attotime(attotime)**

	Cria uma cópia de um valor *attotime* existente no momento.


**emu.attotime.from_double(segundos)**

	Cria um valor *attotime* representando um número específico em
	segundos.


**emu.attotime.from_ticks(períodos, frequência)**

	Cria um *attotime* representando um número específico dos períodos
	da frequência informada em Hertz.


**emu.attotime.from_seconds(segundos)**

	Cria um *attotime* representando um número inteiro específico
	em segundos.


**emu.attotime.from_msec(milissegundos)**

	Cria um *attotime* representando um número inteiro específico
	em milissegundos.


**emu.attotime.from_usec(microssegundos)**

	Cria um *attotime* representando um número inteiro específico
	em microssegundos.


**emu.attotime.from_nsec(nanossegundos)**

	Cria um *attotime* representando um número inteiro específico
	em nanossegundos.


Métodos
~~~~~~~

**t:as_double()**

	Retorna o intervalo de tempo em segundos como um valor de ponto
	flutuante.


**t:as_hz()**

	Interpreta o intervalo como um período e retorna o valor
	correspondente da frequência em Hertz como um ponto flutuante.
	Retorna zero caso ``t.is_never`` seja verdadeiro. O intervalo não
	deve ser zero.


**t:as_khz()**

	Interpreta o intervalo como um período e retorna o valor
	correspondente da frequência em quilo hertz como um ponto flutuante.
	Retorna zero caso ``t.is_never`` seja verdadeiro. O intervalo não
	deve ser zero.

.. raw:: latex

	\clearpage


**t:as_mhz()**

	Interpreta o intervalo como um período e retorna o valor
	correspondente da frequência em mega hertz como um ponto flutuante.
	Retorna zero caso ``t.is_never`` seja verdadeiro. O intervalo não
	deve ser zero.


**t:as_ticks(frequência)**

	Retorna o intervalo como um número inteiro em períodos da frequência
	definida. O valor da frequência é definida em Hertz.


Propriedades
~~~~~~~~~~~~

**t.is_zero** |sole|

	|ubqi| o valor não representa um tempo transcorrido.


**t.is_never** |sole|

	|ubqi| o valor for maior que a quantidade máxima de segundos
	inteiros que possam ser representados (tratados como um tempo
	inalcançável no futuro ou num estouro).


**t.attoseconds** |sole|

	A fração do intervalo dos segundos em atossegundos.


**t.seconds** |sole|

	A quantidade de segundos inteiros no intervalo.


**t.msec** |sole|

	A quantidade de milissegundos inteiros na porção de segundos
	fracionários do intervalo.


**t.usec** |sole|

	A quantidade de microssegundos inteiros na porção de segundos
	fracionários do intervalo.


**t.nsec** |sole|

	A quantidade de nanossegundos inteiros na porção de segundos
	fracionários do intervalo.

.. raw:: latex

	\clearpage


.. _luascript-ref-mameman:

O gerenciador de sistema do MAME
--------------------------------

|encaa| ``mame_machine_manager`` do MAME que contém o sistema em
execução, o gerenciador da IU e os outros componentes globais.


Instanciação
~~~~~~~~~~~~

**manager**

	O gerenciador do sistema do MAME está disponível como uma variável
	global no ambiente Lua.


Propriedades
~~~~~~~~~~~~

**manager.machine** |sole|

	:ref:`luascript-ref-machine` para a sessão da emulação atual.


**manager.ui** |sole|

	:ref:`luascript-ref-uiman` para a sessão da emulação atual.


**manager.options** |sole|

.. As :ref:`luascript-ref-emuopts` para a sessão da emulação atual.
	Ainda não implementado.

**manager.plugins[ ]** |sole|

	Obtém informações sobre o
	:ref:`plug-in Lua <luascript-ref-plugin>` que estão presentes,
	indexados por nome. Os métodos do índice obtém ``at`` e ``index_of``
	com complexidade O(n).


.. _luascript-ref-machine:

O sistema em execução
---------------------

|encaa| ``running_machine`` do MAME que representa uma sessão da
emulação. Ele fornece acesso aos outros principais objetos que
implementam uma sessão da emulação, bem como a árvore dos dispositivos
emulados.


Instanciação
~~~~~~~~~~~~

**manager.machine**

	Obtém a instância do sistema em execução para a sessão de emulação
	atual.


Métodos
~~~~~~~

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

	Agenda o salvamento do estado do sistema no arquivo informado. Caso
	o nome do arquivo seja um caminho relativo, ele será considerado
	relativo ao primeiro diretório do estado de salvamento configurado.
	Este método retorna imediatamente antes que o estado do sistema seja
	salvo. Caso este método seja chamado quando uma operação de salvar
	ou de carregar já esteja pendente, a operação pendente anterior será
	cancelada.


**machine:load(nome_do_arquivo)**

	Agenda o carregamento do estado do sistema a partir do arquivo
	informado. Caso o nome do arquivo seja um caminho relativo, os
	diretórios configurados para do estado de salvamento serão
	pesquisados. Este método retorna imediatamente antes que o estado do
	sistema seja salvo. Caso este método seja chamado quando uma
	operação de salvar ou de carregar já esteja pendente, a operação
	pendente anterior será cancelada.


**machine:popmessage([msg])**

	Exibe uma mensagem pop-up para o usuário. Caso a mensagem não seja
	informada, a mensagem de pop-up exibida no momento (caso haja)
	ficará oculta.


**machine:logerror(msg)**

	Grava a mensagem no log de erros do sistema. Isso pode ser exibido
	numa janela do depurador, gravado num arquivo ou gravado na
	saída de erro predefinida.


Propriedades
~~~~~~~~~~~~

**machine.time** |sole|

	O tempo decorrida da emulação para a sessão atual assim como em
	:ref:`attotime <luascript-ref-attotime>`.


**machine.system** |sole|

	:ref:`os metadados do driver do sistema <luascript-ref-driver>`
	para o sistema atual.


**machine.parameters** |sole|

	O :ref:`gerenciador dos parâmetros <luascript-ref-paramman>`
	para a sessão da emulação atual.


**machine.video** |sole|

	O :ref:`gerenciador de vídeo <luascript-ref-videoman>` para a
	sessão da emulação atual.


**machine.sound** |sole|

	O :ref:`gerenciador do áudio <luascript-ref-soundman>` para a
	sessão da emulação atual.


**machine.output** |sole|

	O :ref:`gerenciador da saída <luascript-ref-outputman>` para a
	sessão da emulação atual.


**machine.memory** |sole|

	O :ref:`gerenciador da memória <luascript-ref-memman>` para a
	sessão da emulação atual.

.. raw:: latex

	\clearpage


**machine.ioport** |sole|

	O :ref:`gerenciador da porta de E/S <luascript-ref-ioportman>`
	para a sessão da emulação atual.


**machine.input** |sole|

	O :ref:`gerenciador da entrada <luascript-ref-inputman>` para a
	sessão da emulação atual.


**machine.natkeyboard** |sole|

	Obtém o
	:ref:`gerenciador do teclado natural <luascript-ref-natkbdman>`,
	usado para controlar a entrada do teclado e do teclado numérico no
	sistema emulado.


**machine.uiinput** |sole|

	O :ref:`gerenciador da entrada da IU <luascript-ref-uiinputman>`
	para a sessão da emulação atual.


**machine.render** |sole|

	O :ref:`gerenciador do renderizador <luascript-ref-renderman>`
	para a sessão da emulação atual.


**machine.debugger** |sole|

	O :ref:`gerenciador do depurador <luascript-ref-debugman>` para
	a sessão da emulação atual ou ``nil`` se o depurador não estiver
	ativado.


**machine.options** |sole|

.. As :ref:`opções <luascript-ref-emuopts>` definidas pelo usuário para a sessão da emulação atual.
	Ainda não implementado.

**machine.samplerate** |sole|

	A taxa de amostragem da saída do áudio em Hertz.


**machine.paused** |sole|

	|ubqi| a emulação não está em execução no momento, geralmente porque
	a sessão foi pausada ou o sistema emulado não concluiu a
	inicialização.


**machine.exit_pending** |sole|

	|ubqi| a sessão da emulação está programada para encerrar.


**machine.hard_reset_pending** |sole|

	|ubqi| uma reinicialização forçada do sistema emulado está pendente.


**machine.devices** |sole|

	Um :ref:`dispositivo enumerador <luascript-ref-devenum>` que produz
	todos os :ref:`dispositivos <luascript-ref-devenum>` |nsqe|.


**machine.palettes** |sole|

	Um :ref:`dispositivo enumerador <luascript-ref-devenum>` que produz
	todos os :ref:`dispositivos paleta <luascript-ref-dipalette>`
	|nsqe|.


**machine.screens** |sole|

	Um :ref:`dispositivo enumerador <luascript-ref-devenum>` que produz
	todos os :ref:`dispositivos tela <luascript-ref-screendev>` |nsqe|.


**machine.cassettes** |sole|

	Um :ref:`dispositivo enumerador <luascript-ref-devenum>` que produz
	todos os :ref:`dispositivos da imagem em fita cassete
	<luascript-ref-diimage>` |nsqe|.

.. raw:: latex

	\clearpage


**machine.images** |sole|

	Um :ref:`dispositivo enumerador <luascript-ref-devenum>` que produz
	toda a :ref:`interface para os dispositivos de imagem
	<luascript-ref-diimage>` |nsqe|.


**machine.slots** |sole|

	Um :ref:`dispositivo enumerador <luascript-ref-devenum>` que produz
	toda a :ref:`dispositivos slot <luascript-ref-dislot>` |nsqe|.


.. _luascript-ref-videoman:

O gerenciador de vídeo
----------------------

|encaa| ``video_manager`` do MAME que é responsável por coordenar a
exibição do vídeo que está sendo emulado, a aceleração da velocidade e
da leitura das entradas do host.


Instanciação
~~~~~~~~~~~~

**manager.machine.video**

	Obtém o gerenciador do vídeo para a sessão da emulação atual.


Métodos
~~~~~~~

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

.. raw:: latex

	\clearpage


**video:snapshot_size()**

	Retorna a largura e a altura em pixels das capturas da tela criados
	com a configuração atual do destino e o estado da tela emulada. Isso
	pode ser configurado de forma explicita pelo usuário, calculado com
	base na visualização da captura selecionada e na resolução de
	quaisquer telas visíveis e que estejam sendo emuladas.


**video:snapshot_pixels()**

	Retorna os pixels de uma captura criado usando a configuração do
	destino da captura atual em inteiros com 32 bits e compactados
	numa *string* binária com ordem Endian do host. Os pixels são
	organizados em ordem maior da linha, da esquerda para a direita e de
	cima para baixo.  Os valores do pixel são cores no formato RGB
	compactadas em inteiros com 32 bits.


Propriedades
~~~~~~~~~~~~

**video.speed_factor** |sole|

	Ajuste de velocidade da emulação configurada em escala de mil (ou
	seja, a proporção para a velocidade normal multiplicada por
	``1.000``).


**video.throttled** |lees|

	|ubqi| o MAME deve esperar antes das atualizações do vídeo para
	evitar a execução mais rápida do que a velocidade desejada.


**video.throttle_rate** |lees|

	A velocidade de emulação desejada como uma proporção da velocidade
	total ajustada através do fator de velocidade (ou seja, ``1`` é a
	velocidade normal ajustada pelo fator de velocidade, números maiores
	são mais rápidos e números menores são mais lentos).


**video.frameskip** |lees|

	A quantidade dos quadros emulados do vídeo para serem ignorados a
	cada doze ou -1 para ajustar automaticamente a quantidade de
	quadros para ignorar visando para manter a velocidade da emulação
	desejada.


**video.speed_percent** |sole|

	A velocidade emulada atualmente em porcentagem da velocidade total
	ajustada pelo fator da velocidade.


**video.effective_frameskip** |sole|

	A quantidade dos doze quadros emulados que são ignorados.


**video.skip_this_frame** |sole|

	|ubqi| o gerenciador do vídeo vai ignorar as telas emuladas para o
	quadro atual.


**video.snap_native** |sole|

	|ubqi| o gerenciador do vídeo fará capturas nativa da tela emulada.
	Além da definição da configuração relevante, o sistema emulado deve
	ter pelo menos uma tela que esteja sendo emulada.

.. raw:: latex

	\clearpage


**video.is_recording** |sole|

	|ubqi| alguma gravação de vídeo está em andamento.


**video.snapshot_target** |sole|

	Um :ref:`alvo do renderizador <luascript-ref-rendertarget>` usado
	para produzir as capturas da tela e para as gravações de vídeo.


.. _luascript-ref-soundman:

O gerenciador de áudio
----------------------

|encaa| ``sound_manager`` do MAME que gerencia o gráfico do fluxo do
áudio emulado e coordena a sua saída.


Instanciação
~~~~~~~~~~~~

**manager.machine.sound**

	Obtém o gerenciador do áudio para a sessão da emulação atual.


Métodos
~~~~~~~

**sound:start_recording([nome_do_arquivo])**

	Inicia a gravação num arquivo WAV. Não tem efeito se estiver
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

	Retorna o conteúdo atual do buffer da amostra gerada como uma
	*string* binária. As amostras são inteiros com 16 bits na ordem dos
	bytes do host. As amostras dos canais estéreo esquerdo e direito são
	intercaladas.


Propriedades
~~~~~~~~~~~~

**sound.muted** |sole|

	|ubqi| a saída do áudio está silenciada por algum motivo.


**sound.ui_mute** |lees|

	|ubqi| a saída do áudio está silenciada a pedido do usuário.


**sound.debugger_mute** |lees|

	|ubqi| a saída do áudio está silenciada a pedido do depurador.


**sound.system_mute** |lees|

	|ubqi| a saída do áudio foi silenciada a pedido do sistema que está
	sendo emulado.

.. raw:: latex

	\clearpage


**sound.volume** |lees|

	A atenuação do volume da saída em decibéis. Geralmente deve ser um
	número negativo ou zero.


**sound.recording** |sole|

	|ubqi| a saída do áudio está sendo gravada num arquivo WAV.


.. _luascript-ref-outputman:

O gerenciador da saída
----------------------

|encaa| ``output_manager`` do MAME que fornece acesso às saídas do
sistema que podem ser usadas para arte interativa ou consumidas por
programas externos.


Instanciação
~~~~~~~~~~~~

**manager.machine.output**

	Obtém o gerenciador da saída para a sessão da emulação atual.


Métodos
~~~~~~~

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


.. _luascript-ref-paramman:

O gerenciador de parâmetros
---------------------------

Wraps MAME’s ``parameters_manager`` class, which provides a simple key-value
store for metadata from system ROM definitions.


Instanciação
~~~~~~~~~~~~

|encaa| ``parameters_manager`` do MAME que fornece um armazenamento
simples do valor da chave para os  metadados das definições da ROM do
sistema.


Métodos
~~~~~~~

**parameters:lookup(tag)**

	Obtém o valor do parâmetro informado caso esteja definido ou uma
	*string* vazia se não estiver.


**parameters:add(tag, valor)**

	Define o parâmetro informado caso não esteja.
	Não tem efeito se o parâmetro informado já estiver definido.


.. _luascript-ref-uiman:

O gerenciador da IU
-------------------

|encaa| ``mame_ui_manager`` do MAME que lida com menus e as outras
funcionalidades da interface do usuário.


Instanciação
~~~~~~~~~~~~

**manager.ui**

	Obtém o gerenciador da IU para a sessão atual.


Métodos
~~~~~~~

**ui:get_char_width(ch)**

	Obtém a largura de um caractere Unicode como uma proporção da
	largura do contêiner da IU na fonte atualmente utilizada na altura
	configurada da linha da IU.


**ui:get_string_width(str)**

	Obtém a largura de uma *string* como uma proporção da largura do
	contêiner da IU na fonte atualmente utilizada na altura configurada
	da linha da IU.


**ui:set_aggressive_input_focus(ativa)**

	Em algumas plataformas isso controla se o MAME deve aceitar o foco
	da entrada em mais situações do que quando as suas janelas têm o
	foco da IU.


**ui:get_general_input_setting(type, [jogador])**

	Obtém uma descrição da :ref:`sequência da entrada
	<luascript-ref-inputseq>` configurada para o tipo da entrada
	indicada e o jogador adequado para usar nos prompts. O tipo da
	entrada é um valor enumerado. O número do jogador é um índice com
	base no número zero. Caso o número do jogador não seja informado, é
	assumido o valor zero.


Propriedades
~~~~~~~~~~~~

**ui.options** |sole|

.. As :ref:`opções <luascript-ref-coreopts>` da interface para a sessão atual.
	As opções da interface para a sessão atual.


**ui.line_height** |sole|

	A altura configurada da linha de texto da interface como uma
	proporção da altura do contêiner da interface.


**ui.menu_active** |sole|

	|ubqi| um elemento da interface interativa está atualmente ativa.
	Os exemplos incluem os menus e os controles deslizantes.


**ui.ui_active** |lees|

	|ubqi| as entradas de controle da IU estão ativadas.


**ui.single_step** |lees|

	Um valor booleano que controla se o sistema emulado deve ser pausado
	automaticamente quando o próximo quadro for desenhado.
	Esta propriedade é redefinida automaticamente quando acontecer a
	pausa automática.


**ui.show_fps** |lees|

	Um valor booleano que controla se a velocidade atual da emulação e
	as configurações do salto de quadro devem ser exibidas.


**ui.show_profiler** |lees|

	Um valor booleano que controla se as estatísticas da criação do
	perfil devem ser exibidas.


.. _luascript-ref-driver:

Os metadados do driver do sistema
---------------------------------

Fornece alguns metadados para um sistema que estiver sendo emulado.


Instanciação
~~~~~~~~~~~~

**emu.driver_find(nome)**

	Obtém os metadados do driver informado para o sistema com o nome
	abreviado ou ``nil`` caso o sistema não exista.


**manager.machine.system**

	Obtém os metadados do driver para o sistema atual.


Propriedades
~~~~~~~~~~~~

**driver.name** |sole|

	O nome abreviado do sistema, conforme usado na linha de comando,
	nos arquivos de configuração e ao pesquisar os recursos.


**driver.description** |sole|

	O nome completo da exibição do sistema.


**driver.year** |sole|

	O ano do lançamento do sistema. Pode conter pontos de interrogação
	caso não seja totalmente conhecido.


**driver.manufacturer** |sole|

	O fabricante, o desenvolvedor ou o distribuidor do sistema.


**driver.parent** |sole|

	O nome abreviado do sistema principal para fins de organização ou
	``"0"`` se o sistema não venha de uma matriz.


**driver.compatible_with** |sole|

	O nome abreviado de um sistema onde este sistema seja compatível
	com o software ou ``nil`` caso o sistema não esteja listado como
	compatível com um outro sistema.


**driver.source_file** |sole|

	O arquivo de origem onde este driver do sistema estiver definido.
	O formato do caminho depende do conjunto das ferramentas onde o
	emulador foi compilado.


**driver.rotation** |sole|

	Uma *string* que indica a rotação aplicada a todas as telas no
	sistema depois que a orientação da tela informada na configuração do
	sistema seja aplicado.
	Será um dos ``"rot0"``, ``"rot90"``, ``"rot180"`` ou ``"rot270"``.


**driver.not_working** |sole|

	|ubqi| o sistema foi marcado como não funcionando.


**driver.supports_save** |sole|

	|ubqi| o sistema é compatível com salvamento de estado.


**driver.no_cocktail** |sole|

	|ubqi| se não existe compatibilidade para a inversão da tela em modo
	coquetel.


**driver.is_bios_root** |sole|

	|ubqi| se este sistema representa um sistema que roda programas a
	partir de uma mídia removível sem que a mídia esteja presente.


**driver.requires_artwork** |sole|

	|ubqi| se o sistema requer a utilização de uma ilustração externa.

.. raw:: latex

	\clearpage


**driver.unofficial** |sole|

	|ubqi| se esta é uma alteração oficial, porém uma alteração comum do
	usuário para o sistema.


**driver.no_sound_hw** |sole|

	|ubqi| o sistema não possui nenhum hardware de saída de áudio.


**driver.mechanical** |sole|

	|ubqi| o sistema depende de recursos mecânicos que não podem ser
	devidamente simulados.


**driver.is_incomplete** |sole|

	|ubqi| o sistema é um protótipo com funcionalidades incompletas.


.. _luascript-ref-plugin:

Plug-in Lua
-----------

Fornece uma descrição de um plug-in Lua que esteja disponível.


Instanciação
~~~~~~~~~~~~

**manager.plugins[nome]**

	Obtém a descrição do plug-in Lua com o nome informado ou ``nil``
	caso o plug-in não esteja disponível.


Propriedades
~~~~~~~~~~~~

**plugin.name** |sole|

	O nome abreviado do plug-in usado na configuração e durante o
	acesso.


**plugin.description** |sole|

	Exibe o nome do plug-in.


**plugin.type** |sole|

	O tipo do plug-in. Pode ser ``"plugin"`` para os plug-ins que podem
	ser carregados pelo usuário ou ``"library"`` para as bibliotecas que
	fornecem funcionalidades comum aos diferentes plug-ins.


**plugin.directory** |sole|

	O caminho para o diretório que contém os arquivos de plug-in.


**plugin.start** |sole|

	|ubqi| o plug-in está ativado.


.. |sole| replace:: (somente leitura)
.. |encaa| replace:: Encapsula a classe
.. |nsqe| replace:: no sistema que está sendo emulado
.. |lees| replace:: (leitura e escrita)
.. |ubqi| replace:: Um valor booleano que indica se
