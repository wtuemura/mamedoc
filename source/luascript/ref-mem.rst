.. raw:: latex

	\clearpage


.. _luascript-ref-mem:

Classes dos sistemas de memória Lua
===================================

A interface Lua do MAME expõe vários objetos da memória do sistema,
incluindo os espaços de endereçamento, compartilhamentos, seus bancos e
as regiões da memória.  Os *scripts* podem ler e escrever a partir do
sistema emulado da memória.

.. contents::
    :local:
    :depth: 1


.. _luascript-ref-memman:

O gerenciador de memória
------------------------

|encaa| ``memory_manager`` do MAME que permite os compartilhamentos da
memória, os bancos e as regiões num sistema que será enumerado.

Instanciação
~~~~~~~~~~~~

**manager.machine:memory()**

	Obtém a instância do gerenciador global da memória para o sistema
	emulado.

Propriedades
~~~~~~~~~~~~

**memory.shares[]**

	O :ref:`compartilhamento da memória <luascript-ref-memshare>` no
	sistema, indexada pela tag absoluta. Os métodos ``at`` e o
	``index_of`` têm O(n) complexidade; todas outras operações
	compatíveis têm complexidade O(1).


**memory.banks[]**

	Os :ref:`banco da memória <luascript-ref-membank>` no sistema,
	indexada pela tag absoluta. Os métodos ``at`` e o ``index_of`` têm
	O(n) complexidade; todas outras operações compatíveis têm
	complexidade O(1).


**memory.regions[]**

	As :ref:`regiões da memória <luascript-ref-memregion>` no sistema,
	indexada pela tag absoluta. Os métodos ``at`` e o ``index_of`` têm
	O(n) complexidade; todas outras operações compatíveis têm
	complexidade O(1).


.. _luascript-ref-addrspace:

O espaço de endereçamento da memória
------------------------------------

|encaa| ``address_space`` do MAME que representa um espaço do endereço
pertencente a um dispositivo.

Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].spaces[nome]**

	Obtém o espaço do endereço com um nome específico para um
	determinado dispositivo. Observe que esses nomes são específicos
	para o tipo do dispositivo.

Métodos
~~~~~~~

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


**space:read_direct_i{8,16,32,64}(endereço)**

	Lê um valor inteiro assinado com o tamanho em bits do endereço
	informado, um byte de cada vez, obtendo um ponteiro de leitura para
	cada byte do endereço. Caso um ponteiro de leitura não pode ser
	obtido para o byte de um endereço, o byte do resultado
	correspondente será zero.

.. raw:: latex

	\clearpage


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

	Lê um intervalo de endereços como uma *string* binária. O endereço
	final deve ser maior ou igual ao endereço inicial.  A largura deve
	ser 8, 16, 30 ou 64. Caso o passo seja informado, ele deve ser um
	número positivo dos elementos.


**space:add_change_notifier(callback)**

	Adiciona um *callback* para receber as notificações das alterações
	do manipulador no espaço de endereçamento. A função de *callback* é
	repassada numa *string* simples como um argumento, seja ``r`` caso
	os manipuladores de leitura tenham se alterado de forma potencial,
	``w`` no caso dos manipuladores de escrita e ``rw`` em ambos os
	casos.

	Retorna um
	:ref:`notificador da assinatura <luascript-ref-notifiersub>`. 


**space:install_read_tap(início, fim, nome, callback)**

	Faz a instalação de um
	:ref:`manipulador pass-through <luascript-ref-addrspacetap>` que fará a
	recepção das notificações de leitura a partir de uma determinada
	faixa de endereços no espaço de endereçamento da memória. O início e
	o fim do endereço são abrangentes. O nome deve ser uma *string* e o
	*callback* uma função.

	O *callback* repassa 3 argumentos para o *offset* do acesso, para a
	leitura dos dados e a máscara de acesso à memória. A compensação é
	a compensação absoluta no espaço de endereçamento. Para alterar os
	dados que estão sendo lidos, retorne o valor alterado da função do
	*callback* como um número inteiro. Caso o *callback* não retorne um
	valor inteiro, os dados não serão alterados.


**space:install_write_tap(início, fim, nome, callback)**

	Faz a instalação de um
	:ref:`manipulador pass-through <luascript-ref-addrspacetap>` que fará a
	recepção das notificações de escrita a partir de uma determinada
	faixa de endereços no espaço de endereçamento da memória. O nome
	deve ser uma *string* e o *callback* uma função.

	O *callback* repassa 3 argumentos para o *offset* do acesso, para a
	escrita dos dados e a máscara de acesso à memória. A compensação é
	a compensação absoluta no espaço de endereçamento. Para alterar os
	dados que estão sendo escritos, retorne o valor alterado da função
	do *callback* como um número inteiro. Caso o *callback* não retorne
	um valor inteiro, os dados não serão alterados.


Propriedades
~~~~~~~~~~~~

**space.name** |sole|

	O nome da exibição do espaço do endereço.


**space.shift** |sole|

	A granularidade do endereço para o espaço do endereçamento informado
	como a transferência necessária para traduzir o endereço de um byte
	num endereço nativo. Os valores positivos se transferem para o bit
	mais importante (à esquerda) e os valores negativos se transferem
	em direção ao |bcmi| (à direita).


**space.index** |sole|

	O índice do espaço com base zero. Alguns índices do espaço têm
	significados especiais para o depurador.


**space.address_mask** |sole|

	A máscara do espaço do endereço.


**space.data_width** |sole|

	A largura dos dados para o espaço em bits.


**space.endianness** |sole|

	O Endianness do espaço (``"big"`` ou ``"little"``).


**space.map** |sole|

	O :ref:`mapa do endereçamento da memória <luascript-ref-addrmap>`
	configurado para o espaço ou ``nil``.


.. _luascript-ref-addrspacetap:

O manipulador pass-through
--------------------------

Faz o rastreio do manipulador *"pass-through"* instalado num 
:ref:`espaço de endereçamento da memória <luascript-ref-addrspace>`. Ele
recebe as notificações dos acessos numa determinada faixa de
endereçamento, pode alterar os dados que são lidos ou escritos se assim
for preciso. Observe que as chamadas de retorno do manipulador
*"pass-through"* não são executadas como corrotinas.


Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].spaces[nome]:install_read_tap(início, fim, nome, callback)**

	Faz a instalação de um manipulador *"pass-through"* que receberá as
	notificações das leituras a partir de uma determinada faixa de
	endereçamento num :ref:`espaço de endereçamento da memória
	<luascript-ref-addrspace>`.


**manager.machine.devices[tag].spaces[nome]:install_write_tap(início, fim, nome, callback)**

	Faz a instalação de um manipulador *"pass-through"* que receberá as
	notificações das escritas a partir de uma determinada faixa de
	endereçamento num :ref:`espaço de endereçamento da memória
	<luascript-ref-addrspace>`.


Métodos
~~~~~~~

**passthrough:reinstall()**

	Reinstala o manipulador *pass-through* no espaço de endereçamento da
	memória. Pode ser necessário caso o manipulador seja removido devido
	as alterações dos outros manipuladores dentro do espaço de
	endereçamento da memória.


**passthrough:remove()**

	Faz a remoção do manipulador *pass-through* do espaço de
	endereçamento da memória. O *callback* associado não será invocado
	em resposta aos futuros acessos da memória.

Propriedades
~~~~~~~~~~~~

**passthrough.addrstart** |sole|

	Abrange o início do endereço da faixa do endereçamento que foi
	alterado pelo manipulador *pass-through* (quando o manipulador for
	notificado no endereçamento mais baixo por exemplo).


**passthrough.addrend** |sole|

	Abrange o fim do endereço da faixa do endereçamento que foi alterado
	pelo manipulador *pass-through* (quando o manipulador for notificado
	no endereçamento mais alto por exemplo).


**passthrough.name** |sole|

	O nome de exibição para o manipulador *pass-through*.


.. _luascript-ref-addrmap:

O mapa de endereçamento da memória
----------------------------------

|encaa| ``address_map`` do MAME que é usada para configurar os
manipuladores para um espaço do endereço.


Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].spaces[nome].map**

	Obtém o mapa do endereço configurado para o espaço de um endereço ou
	``nil`` caso nenhum mapa seja configurado.

Propriedades
~~~~~~~~~~~~

**map.spacenum** |sole|

	A quantidade do espaço de endereço do espaço de endereço onde o mapa
	está associado.


**map.device** |sole|

	O dispositivo que possui o endereçamento onde o mapa está associado.


**map.unmap_value** |sole|

	O valor constante para retornar a partir das leituras não mapeadas.


**map.global_mask** |sole|

	Máscara global que será aplicada a todos os endereços ao acessar o
	espaço.


**map.entries[]** |sole|

	As :ref:`entradas do endereçamento da memória
	<luascript-ref-addrmapentry>` não configuradas no mapa do endereço.
	Usa índices inteiros com base ``1``.  O operador do índice e o
	método ``at`` tem complexidade O(n).


.. _luascript-ref-addrmapentry:

As entradas do endereçamento da memória
---------------------------------------

|encaa| ``address_map_entry`` do MAME que representa uma entrada na
configuração de um mapa de endereços.

Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].spaces[nome].map.entries[índice]**

	Obtém uma entrada a partir do mapa configurado para um espaço de
	endereço.


Propriedades
~~~~~~~~~~~~

**entry.address_start** |sole|

	Endereço inicial do intervalo da entrada.


**entry.address_end** |sole|

	Endereço final do intervalo da entrada (inclusive).


**entry.address_mirror** |sole|

	Bits do espelho do endereço.


**entry.address_mask** |sole|

	Bits da máscara do endereço.  É válido apenas para os manipuladores.


**entry.mask** |sole|

	Máscara da pista, indicando quais as linhas dos dados do barramento
	estão conectadas ao manipulador.


**entry.cswidth** |sole|

	A largura do gatilho para um manipulador que não está conectado a
	todas as linhas de dados.


**entry.read** |sole|

	Os :ref:`dados do manipulador do mapa de endereçamento da memória
	<luascript-ref-memhandlerdata>` para a leitura do manipulador.


**entry.write** |sole|

	Os :ref:`dados do manipulador do mapa de endereçamento da memória
	<luascript-ref-memhandlerdata>` para a escrita no manipulador.


**entry.share** |sole|

	A tag do compartilhamento da memória para tornar as entradas da RAM
	acessíveis ou ``nil``.


**entry.region** |sole|

	A tag explícita da região da memória para entradas da ROM, ou
	``nil``.  Para entradas da ROM, o ``nil`` deduz a região da tag do
	dispositivo.


**entry.region_offset** |sole|

	O *offset* inicial na região da memória para as entradas da ROM.


.. _luascript-ref-memhandlerdata:

Dados do manipulador do mapa de endereçamento da memória
--------------------------------------------------------

|encaa| ``map_handler_data`` do MAME que oferece os dados de
configuração para os manipuladores nos mapas dos endereços.

Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].spaces[nome].map.entries[índice].read**

	Obtém os dados do manipulador de leitura para uma entrada do mapa
	dos endereços.


**manager.machine.devices[tag].spaces[nome].map.entries[índice].write**

	Obtém os dados do manipulador de gravação para uma entrada do mapa
	dos endereços.


Propriedades
~~~~~~~~~~~~

**data.handlertype** |sole|

	O tipo do manipulador. Será um dos ``"none"``, ``"ram"``, ``"rom"``,
	``"nop"``, ``"unmap"``, ``"delegate"``, ``"port"``, ``"bank"``,
	``"submap"`` ou ``"unknown"``.  Observe que os vários valores dos
	tipos do manipulador podem produzir ``"delegate"`` ou ``"unknown"``.


**data.bits** |sole|

	A largura dos dados para o manipulador em bits.


**data.name** |sole|

	Nome de exibição para o manipulador ou ``nil``.


**data.tag** |sole|

	A tag para portas de E/S, os bancos da memória ou ``nil``.


.. _luascript-ref-memshare:

Compartilhamento da memória
---------------------------

|encaa| ``memory_share`` do MAME que representa um nome alocado na
região da memória.


Instanciação
~~~~~~~~~~~~

**manager.machine.memory.shares[tag]**

	Obtém um compartilhamento da memória através da tag absoluta ou
	``nil`` caso o compartilhamento da memória não  exista.


**manager.machine.devices[tag]:memshare(tag)**

	Obtém um compartilhamento da memória através da tag em relação a um
	dispositivo ou ``nil`` caso o compartilhamento da memória não
	exista.


Métodos
~~~~~~~

**share:read_i{8,16,32,64}(offs)**

	Lê um valor inteiro assinado do tamanho em bits do *offset*
	informado no compartilhamento da memória.


**share:read_u{8,16,32,64}(offs)**

	Lê um valor inteiro não assinado com o tamanho em bits a partir do
	*offset* do compartilhamento da memória.


**share:write_i{8,16,32,64}(offs, valor)**

	Grava um valor inteiro assinado com o tamanho em bits para o
	*offset* informado no compartilhamento da memória.


**share:write_u{8,16,32,64}(offs, valor)**

	Grava um valor inteiro não assinado com o tamanho em bits para o
	*offset* informado no compartilhamento da memória.


Propriedades
~~~~~~~~~~~~

**share.tag** |sole|

	A marca absoluta do compartilhamento da memória.


**share.size** |sole|

	O tamanho do compartilhamento da memória em bytes.


**share.length** |sole|

	O comprimento do compartilhamento da memória em elementos da largura
	nativa.


**share.endianness** |sole|

	O endianness do compartilhamento da memória (``"big"`` ou
	``"little"``).


**share.bitwidth** |sole|

	A largura do elemento nativo do compartilhamento da memória em bits.


**share.bytewidth** |sole|

	A largura do elemento nativo do compartilhamento da memória em bytes.


.. _luascript-ref-membank:

Banco de memória
----------------

|encaa| ``memory_bank`` do MAME que representa uma região determinada da
memória.


Instanciação
~~~~~~~~~~~~

**manager.machine.memory.banks[tag]**

	Obtém uma região da memória por tag absoluta, ou ``nil`` caso o
	banco da memória não exista.


**manager.machine.devices[tag]:membank(tag)**

	Obtém uma região da memória por tag relativa a um dispositivo ou
	``nil`` caso o banco da memória não exista.

Propriedades
~~~~~~~~~~~~

**bank.tag** |sole|

    A tag absoluta do banco da memória.


**bank.entry** |lees|

	O número da entrada com base zero atualmente selecionado.


.. _luascript-ref-memregion:

Região da memória
-----------------

|encaa| ``memory_region`` do MAME que representa a região da memória
usada para armazenar dados somente leitura como as ROMs ou o resultado
fixo do que for descriptografado.


Instanciação
~~~~~~~~~~~~

**manager.machine.memory.regions[tag]**

	Obtém uma região de memória por tag absoluta ou ``nil`` caso
	nenhuma região da memória exista.


**manager.machine.devices[tag]:memregion(tag)**

	Obtém uma região da memória por tag relativa a um dispositivo ou
	``nil`` caso o banco da memória não exista.

Métodos
~~~~~~~

**region:read_i{8,16,32,64}(offs)**

	Lê um valor inteiro assinado do tamanho em bits do *offset*
	informado na região da memória. O *offset* é definido em bytes. A
	tentativa de leitura além da região da memória retorna zero.


**region:read_u{8,16,32,64}(offs)**

	Lê um valor inteiro não assinado com o tamanho em bits a partir do
	*offset* da região da memória. O *offset* é definido em bytes. A
	tentativa de leitura além da região da memória retorna zero.


**region:write_i{8,16,32,64}(offs, valor)**

	Grava um valor inteiro assinado com o tamanho em bits para o
	*offset* informado da região da memória. O *offset* é definido em
	bytes. A tentativa de escrever além da região da memória não surte
	nenhum efeito.


.. raw:: latex

	\clearpage


**region:write_u{8,16,32,64}(offs, valor)**

	Grava um valor inteiro não assinado com o tamanho em bits para o
	*offset* informado na região da memória. O *offset* é definido em
	bytes. A tentativa de escrever além da região da memória não surte
	nenhum efeito.


Propriedades
~~~~~~~~~~~~

**region.tag** |sole|

	A tag absoluta da região da memória.


**region.size** |sole|

	O tamanho da região da memória em bytes.


**region.length** |sole|

	O comprimento da região da memória com elementos nativos de largura.


**region.endianness** |sole|

	O endianness da região de memória (``"big"`` ou ``"little"``).


**region.bitwidth** |sole|

	A largura do elemento nativo da região da memória em bits.


**region.bytewidth** |sole|

	A largura do elemento nativo da região da memória em bytes.

.. |encaa| replace:: Encapsula a classe
.. |sole| replace:: (somente leitura)
.. |lees| replace:: (leitura e escrita)
.. |bcmi| replace:: byte menos importante
