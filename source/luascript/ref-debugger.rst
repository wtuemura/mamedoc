.. raw:: latex

	\clearpage


.. _luascript-ref-debugger:

Classes de depuração Lua
========================

Alguns dos principais recursos de depuração do MAME podem ser
controlados a partir de um *script* Lua. O depurador deve estar ativado
para que seja possível usar os recursos de depuração (normalmente
usando ``-debug`` na linha de comando).

.. contents::
    :local:
    :depth: 1


.. _luascript-ref-debugsymtable:

Tabela de símbolos
------------------

|encaa| ``symbol_table`` do MAME, fornece o nome dos símbolos que pode
ser usado nas expressões. Note que a tabela de símbolos pode ser criada
e até mesmo utilizada quando o depurador não estiver ativado.


Instanciação
~~~~~~~~~~~~

**emu.symbol_table(sistema)**

	Cria uma nova tabela de símbolos dentro do contexto de uma
	determinado sistema,


**emu.symbol_table(parent, [dispositivo])**

	Cria uma nova tabela de símbolos dentro de uma determinada tabela
	relacionada dos símbolos. No caso de um dispositivo ser definido e
	implemente um ``device_memory_interface``, este será utilizado como
	a base para a busca dos endereços e das regiões da memória. Note que
	caso um dispositivo que não implemente um
	``device_memory_interface`` seja fornecido, este não será utilizado
	(os endereços e a região da memória serão buscadas com relação à
	raiz do dispositivo).


**emu.symbol_table(dispositivo)**

	Cria uma nova tabela de símbolos dentro do contexto de um
	determinado dispositivo. Caso um dispositivo implemente o
	``device_memory_interface``, este será utilizado como a base para a
	busca dos endereços e das regiões da memória. Note que caso um
	dispositivo que não implemente um ``device_memory_interface`` seja
	fornecido, este não será utilizado (os endereços e a região da
	memória serão buscadas com relação à raiz do dispositivo).


Métodos
~~~~~~~

**symbols:set_memory_modified_func(cb)**

	Define uma função que será invocada quando a memória for alterada
	através da tabela de símbolos. Nenhum argumento é passado para a
	função e quaisquer valores retornados são ignorados. Invoque com
	``nil`` para eliminar o *callback*.


**symbols:add(nome, [valor])**

	|dusi| |onds|. Ao
	informar um valor, este deve ser um número inteiro. Durante o
	fornecimento do valor, um símbolo só de leitura é adicionado em
	conjunto com o valor informado. Na ausência deste valor, é criado um
	símbolo de leitura/escrita com valor zero. |osss|.

	Retorna o :ref:`acesso do símbolo <luascript-ref-debugsymentry>`.


**symbols:add(nome, getter, [setter], [formato])**

	|dusi| usando a chamada *getter* e a chamada
	opcional *setter*. Onde |onds|. A chamada *getter* deve uma função
	que retorne um valor inteiro para o valor do símbolo. Caso seja
	informado, o *setter* deve ser uma função que aceite um único valor
	inteiro para o novo valor do símbolo. Um formato *string* para
	exibir o valor do símbolo pode ser usado de forma opcional. |osss|.

	Retorna o :ref:`acesso do símbolo <luascript-ref-debugsymentry>`.

**symbols:add(nome, minparams, maxparams, execute)**

	|dafu|. Onde |onds|. O valor mínimo e máximo da quantidade dos
	valores devem ser inteiros. |osss|.

	Retorna o :ref:`acesso do símbolo <luascript-ref-debugsymentry>`.


**symbols:find(nome)**

	Retorna o :ref:`acesso do símbolo <luascript-ref-debugsymentry>` com
	um determinado nome ou ``nil`` caso não haja um símbolo com um
	determinado nome na tabela de símbolos.


**symbols:find_deep(nome)**

	Retorna o :ref:`acesso do símbolo <luascript-ref-debugsymentry>` com
	um determinado nome ou ``nil`` caso não haja um símbolo com um
	determinado nome na tabela de símbolos ou em quaisquer outra tabela
	de símbolos relacionada.


**symbols:value(nome)**

	Retorna o valor inteiro do símbolo com um determinado nome ou zero
	caso não haja um símbolo com um determinado nome na tabela de
	símbolos ou em quaisquer outra tabela de símbolos relacionada.
	|guec| o símbolo com um determinado nome seja uma função de um
	determinado símbolo.


**symbols:set_value(nome, valor)**

	Define o valor de um símbolo com um determinado nome. |guec| o
	símbolo com um determinado nome seja um símbolo inteiro, somente
	leitura, ou caso seja uma função de um determinado símbolo.
	Não há qualquer efeito caso não exista um símbolo com determinado
	nome na tabela ou em quaisquer tabelas de símbolos relacionados.

.. raw:: latex

	\clearpage


**symbols:memory_value(nome, espaço, offset, tamanho, disable_se)**

	Lê o valor a partir da memória. Oferece um nome ou uma etiqueta no
	espaço de endereçamento, na região da memória onde a leitura será
	feita ou ``nil`` para usar o espaço de endereçamento ou a região da
	memória imposta por ``space``. Consulte
	:ref:`acesso à memória <debugger-express-mem>` para conhecer os
	tipos de acesso e as definições que podem ser utilizadas com
	``space``. O tamanho do acesso pode ter ``1``, ``2``, ``4`` ou ``8``
	bytes. O argumento ``disable_se`` determina
	se os efeitos colaterais do acesso à memória deve ser desativado ou
	não.


**symbols:set_memory_value(nome, espaço, offset, valor, tamanho, disable_se)**

	Escreve um valor na memória. Oferece um nome ou uma etiqueta no
	espaço de endereçamento, na região da memória onde a leitura será
	feita ou ``nil`` para usar o espaço de endereçamento ou a região da
	memória imposta por ``space``. Consulte
	:ref:`acesso à memória <debugger-express-mem>` para conhecer os
	tipos de acesso e as definições que podem ser utilizadas com
	``space``. O tamanho do acesso pode ter ``1``, ``2``, ``4`` ou ``8``
	bytes. O argumento ``disable_se`` determina
	se os efeitos colaterais do acesso à memória deve ser desativado ou
	não.


**symbols:read_memory(espaço, endereço, tamanho, apply_translation)**

	Lê um valor a partir de um espaço de endereçamento. O tamanho do
	acesso pode ter ``1``, ``2``, ``4`` ou ``8`` bytes. Caso o argumento
	``apply_translation`` seja verdadeiro, o endereço será traduzido com
	a intensão de leitura do depurador ou retornará o valor do tamanho
	requisitado com todos os bits definidos caso a tradução do endereço
	falhe.


**symbols:write_memory(espaço, endereço, dado, tamanho, apply_translation)**

	Escreve um valor num determinado espaço de endereçamento. O tamanho
	do acesso pode ter ``1``, ``2``, ``4`` ou ``8`` bytes. Caso o
	argumento ``apply_translation`` seja verdadeiro, o endereço será
	traduzido com a intensão de escrita do depurador. A função de
	alteração da tabela dos símbolos da memória será invocada depois que
	o valor for escrito. caso a tradução do endereço falhe, o valor não
	será escrito e a função de alteração da tabela dos símbolos da
	memória não será invocada.


Propriedades
~~~~~~~~~~~~

**symbols.entries[ ]**

	O :ref:`acesso do símbolo <luascript-ref-debugsymentry>` na tabela
	de símbolos indexada por nomes. Os métodos ``at`` e ``index_of`` têm
	complexidade O(n). Todas as outras operações possuem complexidade
	O(1).


**symbols.parent** |sole|

	A tabela de símbolos relacionados ou ``nil`` caso não haja nada
	relacionado na tabela de símbolos.


.. _luascript-ref-debugexpression:

A interpretação das expressões
------------------------------

|encaa| ``parsed_expression``, representa uma expressão simbólica do
depurador. Repare que as expressões que forem interpretadas podem ser
criadas e até mesmo utilizadas quando o depurador não estiver ativado.


Instanciação
~~~~~~~~~~~~

**emu.parsed_expression(símbolo)**

	Cria uma expressão vazia que usará a :ref:`tabela de símbolos
	<luascript-ref-debugsymtable>` para fazer uma procura pelos
	símbolos.


**emu.parsed_expression(símbolos, string, [default_base])**

	Cria uma expressão ao analisar uma *string*, também é usada um
	:ref:`tabela de símbolos <luascript-ref-debugsymtable>` para fazer
	uma procura pelos símbolos. Na ausência de uma base padrão para fazer
	a busca literal dos inteiros, o hexadecimal 16 é usado.
	|guec| a *string* tenha :ref:`erros de sintaxe
	<luascript-ref-debugexpressionerror>` ou utilize símbolos não
	definidos.


Métodos
~~~~~~~

**expression:set_default_base(base)**

	Define a base padrão para a interpretação dos literais numéricos. A
	base deve ser um valor inteiro e positivo.


**expression:parse(string)**

	Analisar uma cadeia de expressões de depuração. Faz a substituição
	do conteúdo atual da expressão caso não esteja vazia. |guec| a
	*string* tenha :ref:`erros de sintaxe
	<luascript-ref-debugexpressionerror>` ou utilize símbolos não
	definidos. O conteúdo da expressão anterior não é preservada ao
	tentar analisar uma cadeia de expressões inválidas.


**expression:execute()**

	Faz a avaliação da expressão, como resultado, retorna um inteiro não
	assinado. |guec| haja um :ref:`erros de sintaxe
	<luascript-ref-debugexpressionerror>` e a expressão não puder ser
	analisada (ao invocar a função com uma quantidade de argumentos
	inválidos por exemplo).


Propriedades
~~~~~~~~~~~~

**expression.is_empty** |sole|

	Um valor booleano que indica se a expressão possui *tokens*.


**expression.original_string** |sole|

	A *string* original que foi analisada para criar uma expressão.


**expression.symbols** |lees|

	A :ref:`tabela de símbolos <luascript-ref-debugsymtable>` usada para
	procurar pelos símbolos numa expressão.


.. _luascript-ref-debugsymentry:

Acesso do símbolo
-----------------

Envelopa a classe ``symbol_entry`` do MAME, faz a representação do
acesso numa :ref:`tabela de símbolos <luascript-ref-debugsymtable>`.
Observe que as entradas dos símbolos não devem ser usados depois que a
tabela dos símbolos a que pertencem seja destruída.


Instanciação
~~~~~~~~~~~~

**symbols:add(nome, [valor])**

	Adiciona um símbolo inteiro à
	:ref:`tabela de símbolos <luascript-ref-debugsymtable>`, retornando
	um novo símbolo para o acesso.


**symbols:add(nome, getter, [setter], [formato])**

	Adiciona um símbolo inteiro à
	:ref:`tabela de símbolos <luascript-ref-debugsymtable>`, retornando
	um novo símbolo para o acesso.


**symbols:add(nome, minparams, maxparams, execute)**

	Adiciona uma nova função à
	:ref:`tabela de símbolos <luascript-ref-debugsymtable>`, retornando
	um novo símbolo para o acesso.


Propriedades
~~~~~~~~~~~~

**entry.name** |sole|

	O nome do acesso do símbolo.


**entry.format** |sole|

	O formato da *string* usada para converter o acesso do símbolo para
	ser exibido como texto na tela.


**entry.is_function** |sole|

	Um valor booleano indicando se o acesso do símbolo é uma função que
	pode ser invocada.


**entry.is_lval** |sole|

	Um valor booleano indicando se o acesso do símbolo é um símbolo
	inteiro que pode ser definido (se ele pode ser usado no lado
	esquerdo das expressões da atribuição por exemplo).


**entry.value** |lees|

	Um valor inteiro do acesso do símbolo. |guec| caso tente definir um
	valor caso o acesso do símbolo seja de apenas leitura, assim como,
	ao tentar obter ou definir o valor da função de um símbolo.


.. _luascript-ref-debugman:

Gerenciador do depurador
------------------------

|encaa| ``debugger_manager`` do MAME que fornece a interface principal
para controlar o depurador.


Instanciação
~~~~~~~~~~~~

**manager.machine:debugger()**

	Retorna a instância do gerenciador de depuração global ou ``nil`` se
	o depurador não estiver ativado.


Métodos
~~~~~~~

**debugger:command(str)**

	Execute um comando no console do depurador. O argumento é a *string*
	do comando. A saída é enviada ao console do depurador e ao console
	Lua.


Propriedades
~~~~~~~~~~~~

**debugger.consolelog[ ]** |sole|

	As linhas no log do console (saída dos comandos do depurador).
	Este contêiner suporta apenas o comprimento das operações do índice.


**debugger.errorlog[ ]** |sole|

	As linhas no registro log de erros (saída ``logerror``).
	Este contêiner suporta apenas o comprimento das operações do índice.


**debugger.visible_cpu** |lees|

	O dispositivo CPU com foco no depurador. As alterações se tornam
	visíveis no console do depurador depois da próxima etapa.
	Não há efeito quando configurando para um dispositivo que não seja
	uma CPU.


**debugger.execution_state** |lees|

	Tanto ``"run"`` se o sistema que estiver sendo emulado estiver
	rodando, ou ``"stop"`` caso esteja parado no depurador.


.. _luascript-ref-devdebug:

Interface de depuração do dispositivo
-------------------------------------

|encaa| ``device_debug`` do MAME que fornece a interface do depurador
para um dispositivo emulado da CPU.


Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].debug**

	Retorna a interface do depurador para um dispositivo emulado da CPU
	ou ``nil`` caso o dispositivo não seja uma CPU.


Métodos
~~~~~~~

**debug:step([cnt])**

	Avance através da quantidade especificada das instruções.
	Caso a contagem das instruções não seja informada, o padrão é uma
	única instrução.


**debug:go()**

	Execute a CPU que estiver sendo emulada.

.. raw:: latex

	\clearpage


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


**debug:bplist()**

	Retorna uma tabela dos breakpoints para o dispositivo. As chaves são
	os números dos breakpoints e os valores são os
	:ref:`breakpoints <luascript-ref-breakpoint>`.


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

.. raw:: latex

	\clearpage


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
	:ref:`watchpoints <luascript-ref-watchpoint>`.


.. _luascript-ref-breakpoint:

Breakpoint
----------

|encaa| ``debug_breakpoint`` do MAME que representa um ponto de
interrupção (breakpoint) para um dispositivo emulado da CPU.


Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].debug:bplist()[bp]**

	Obtém o breakpoint informado para um dispositivo emulada da CPU ou
	``nil`` caso nenhum breakpoint corresponda ao índice informado.


Propriedades
~~~~~~~~~~~~

**breakpoint.index** |sole|

	O índice do breakpoint. Pode ser usado para ativar, desativar ou
	limpar o breakpoint através da :ref:`interface de depuração do
	dispositivo <luascript-ref-devdebug>`.


**breakpoint.enabled** |lees|

	Um valor booleano que indica se o breakpoint no momento está ativo.


**breakpoint.address** |sole|

	O endereço do breakpoint.


**breakpoint.condition** |sole|

	Uma expressão do depurador avaliada cada vez que o breakpoint for
	atingido. A ação só será disparada caso esta expressão seja avaliada
	como um valor diferente de zero. Uma *string* vazia caso nenhuma
	condição seja informada.


**breakpoint.action** |sole|

	Uma ação que o depurador executará quando o breakpoint for atingido
	e a condição for avaliada como um valor diferente de zero.
	Uma *string* vazia caso nenhuma ação seja informada.


.. _luascript-ref-watchpoint:

Watchpoint
----------

|encaa| ``debug_watchpoint`` do MAME que representa um ponto de controle
(watchpoint) para um dispositivo emulado da CPU.


Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].debug:wplist(espaço)[wp]**

	Obtém o watchpoint informado para um watchpoint de um dispositivo
	emulado da CPU ou ``nil`` caso nenhum watchpoint no espaço de
	endereço corresponda ao índice informado.


Propriedades
~~~~~~~~~~~~

**watchpoint.index** |sole|

	O índice do watchpoint. Pode ser usado para ativar, desativar ou
	limpar o watchpoint através da :ref:`interface de depuração do
	dispositivo <luascript-ref-devdebug>`.


**watchpoint.enabled** |lees|

	Um valor booleano que indica se o watchpoint no momento está ativo.


**watchpoint.type** |sole|

	O tipo deve ser ``"r"``, ``"w"`` ou ``"rw"`` para a leitura, a
	escrita ou a leitura e a escrita do watchpoint.


**watchpoint.address** |sole|

	O endereço inicial do intervalo dos endereços do watchpoint.


**watchpoint.length** |sole|

	O comprimento do intervalo dos endereços do watchpoint.


**watchpoint.condition** |sole|

	Uma expressão do depurador avaliada cada vez que o watchpoint for
	atingido. A ação só será disparada caso esta expressão seja avaliada
	como um valor diferente de zero. Uma *string* vazia caso nenhuma
	condição seja informada.


**watchpoint.action** |sole|

	Uma ação que o depurador executará quando o watchpoint for atingido
	e a condição for avaliada como um valor diferente de zero.
	Uma *string* vazia caso nenhuma ação seja informada.


.. _luascript-ref-debugexpressionerror:

Erro da expressão
-----------------

|encaa| ``expression_error`` do MAME que descreve um erro que esteja
acontecendo enquanto interpretando ou executando expressões do
depurador. |guec| durante a :ref:`interpretação das expressões
<luascript-ref-debugexpression>`. Pode ser convertida para texto para
fornecer uma descrição do erro.


Propriedades
~~~~~~~~~~~~

**err.code** |sole|

	Um número dependente da implementação que representa a categoria de
	erro. Não deve ser exibido para o usuário.


**err.offset** |sole|

	O deslocamento da string de expressão onde o erro foi encontrado.


.. |encaa| replace:: Encapsula a classe
.. |dusi| replace:: Denomina um símbolo inteiro
.. |onds| replace:: seu nome deve ser uma *string*
.. |osss| replace:: O símbolo será substituído na existência de um
	símbolo com um determinado nome já existente na tabela de símbolos.
.. |dafu| replace:: Denomina a função de um símbolo
.. |guec| replace:: Gera um erro caso
.. |sole| replace:: (somente leitura)
.. |lees| replace:: (leitura e escrita)
