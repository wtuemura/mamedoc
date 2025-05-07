.. _luascript-ref-common:

Tipos comuns e globais em Lua
=============================

.. contents::
    :local:
    :depth: 1


.. _luascript-ref-containers:

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

	Retorna o item que corresponda a tecla :kbd:`k` ou **nil** caso a
	chave não esteja presente.


**pairs(c)**

	Repete o contêiner por chave e por valor. A chave é o que você
	passaria para operador do índice ou o método **get** para obter o
	valor.


**ipairs(c)**

	Repete o contêiner através de um índice e de um valor. O índice é o
	que você passaria para ao método **at** para obter o valor (pode ser
	o mesmo como a chave para alguns contêineres).


**c:empty()**

	|ubis| não há itens no contêiner.


**c:get(k)**

	Retorna o item que corresponda a tecla :kbd:`k` ou **nil** caso a
	tecla não esteja presente. Normalmente é o equivalente ao operador
	do índice.


**c:at(i)**

	Retorna o valor no índice com base **1** (1-based) **i** ou **nil**
	caso não esteja fora do alcance.


**c:find(v)**

	Retorna a chave para o item **v** ou **nil** caso não esteja no
	contêiner. A chave é o que você passaria ao índice do operador para
	obter o valor.


**c:index_of(v)**

	Retorna o índice com base **1** (1-based) para o item **v** ou
	**nil** caso não esteja no contêiner. O índice é o que você passaria
	ao método ``at`` para obter o valor.

.. raw:: latex

	\clearpage


.. _luascript-ref-emu:

Interface do emulador
~~~~~~~~~~~~~~~~~~~~~

A interface **emu** fornece o acesso à principal funcionalidade do
emulador. Diversas classes também estão disponíveis como propriedades na
interface do emulador.

Métodos
^^^^^^^

**emu.wait(duração, …)**

	Aguarda a duração determinada pelo tempo da emulação. A duração
	pode ser definida como :ref:`attotime <luascript-ref-attotime>`
	ou um valor numérico em segundos. |qaar|. Retorna um booleano
	indicando se a duração expirou normalmente.

	Todas as invocações pendentes para **emu.wait**, imediatamente
	retornarão **false** caso um estado salvo seja carregado ou se a
	sessão da emulação for encerrada. |ruea|.


**emu.wait_next_update(…)**

	Aguarda até a próxima atualização de vídeo/UI. |qaar|. |ruea|.


**emu.wait_next_frame(…)**

	Aguarda até que o próximo quadro da emulação seja concluído.
	Quaisquer argumentos serão retornados a que os invocou. |ruea|.


**emu.add_machine_reset_notifier(callback)**

	|aurd| for reinicializado. |runda|.


**emu.add_machine_stop_notifier(callback)**

	|aurd| for parado. |runda|.


**emu.add_machine_pause_notifier(callback)**

	|aurd| for pausado. |runda|.


**emu.add_machine_resume_notifier(callback)**

	|aurd| resumir as operações. |runda|.


**emu.add_machine_frame_notifier(callback)**

	|aurd| concluir um quadro. |runda|.


**emu.add_machine_pre_save_notifier(callback)**

	Adiciona um retorno de chamada para receber as notificações antes
	que o estado da emulação seja salvo. |runda|.

.. raw:: latex

	\clearpage


**emu.add_machine_post_load_notifier(callback)**

	Adicione uma chamada de retorno para receber notificação depois que
	o sistema emulado for restaurado para um estado salvo anteriormente.
	Retorna uma :ref:`assinatura do notificador
	<luascript-ref-notifiersub>`.


**emu.register_sound_update(callback)**

	Adiciona uma chamada de retorno para receber novas amostras que
	foram criadas. As amostras são provenientes dos dispositivos de
	áudio para os quais a propriedade gancho foi definida como **true**.
	A chamada de retorno recebe um parâmetro que é um hash com a
	etiqueta do dispositivo como chave, um vetor (do tamanho do canal)
	e de um vetor (do tamanho do buffer) com amostras na faixa entre
	**-1..1**.


**emu.add_machine_post_load_notifier(callback)**

	Adiciona um retorno de chamada para receber as notificações depois
	que o estado da emulação seja salvo. |runda|.


**emu.print_error(mensagem)**

	Exibe uma mensagem de erro.


**emu.print_warning(mensagem)**

	Exibe uma mensagem de alerta.


**emu.print_info(mensagem)**

	Exibe uma mensagem informacional.


**emu.print_verbose(mensagem)**

	Exibe uma mensagem loquaz de diagnóstico (desativado por padrão).


**emu.print_debug(mensagem)**

	Exibe uma mensagem loquaz de depuração (ativada por padrão apenas em
	versões de depuração).


**emu.lang_translate([contexto], mensagem)**

	Procure uma mensagem com contexto opcional no catálogo atual das
	mensagens traduzidas. Retorna a mensagem original caso nenhuma
	mensagem traduzida correspondente seja encontrada.


**emu.subst_env(string)**

	Variáveis de ambiente substituíveis em texto (*string*). A sintaxe
	depende do sistema operacional do host.

.. |ubis| replace:: Retorna um booleano indicando se
.. |qaar| replace:: Quaisquer argumentos adicionais será retornado a
	quem os invocou
.. |ruea| replace:: Retornará um erro ao invocar esta função através dos
	retornos de chamada (*callbacks*) que não forem executados como
	rotinas conjuntas
.. |aurd| replace:: Adiciona um retorno de chamada para receber as
	notificações quando o sistema emulado
.. |runda| replace:: Retorna a
	:ref:`assinatura do notificador <luascript-ref-notifiersub>`
