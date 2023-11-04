.. raw:: latex

	\clearpage


.. _luascript-ref-input:

Classes do sistema de entrada Lua
=================================

Permite que os scripts obtenham informações recebidas do usuário e
acessem as portas de E/S da entrada do sistema emulado.

.. contents::
    :local:
    :depth: 1


.. _luascript-ref-ioportman:

Gerenciador da porta E/S
------------------------

|encaa| ``ioport_port`` do MAME que representa uma porta emulada de E/S,
assim como, lida com as configurações da entrada.


Instanciação
~~~~~~~~~~~~

**manager.machine:ioport()**

	Obtém a instância do gerenciador global da porta de E/S para o
	sistema emulado.


Métodos
~~~~~~~

**ioport:count_players()**

	Retorna a quantidade dos controladores do jogador no sistema.


**ioport:type_pressed(tipo, [jogador])**

	|ubis| a entrada informada foi atualmente
	pressionada. O tipo da entrada pode ser um valor enumerado ou um
	:ref:`tipo de acesso <luascript-ref-inputtype>`. Caso o tipo de
	acesso seja um valor enumerado, número do jogador é um índice com
	base zero. Se o número do jogador não for informado, será presumido
	que seja zero, sendo o tipo da entrada um tipo de acesso, o número
	do jogador não poderá ser informado de forma separada.


**ioport:type_name(tipo, [jogador])**

	Retorna o nome da exibição para o tipo da entrada informada e o
	número do jogador. O tipo da entrada é um valor enumerado. O número
	do jogador é um índice com base zero. Se o número do jogador não for
	informado, será presumido que seja zero.


**ioport:type_group(tipo, [jogador])**

	Retorna a entrada do grupo para o tipo da entrada informada e o
	número do jogador. O tipo da entrada é um valor enumerado. O número
	do jogador é um índice com base zero. Retorna um valor inteiro
	informando o agrupamento para a entrada. Se o número do jogador não
	for informado, será presumido que seja zero.

	Deve ser invocado com os valores obtidos a partir dos campos da
	porta de E/S para informar o agrupamento canônico da configuração da
	entrada numa IU.


**ioport:type_seq(tipo, [jogador], [tipo_da_sequência])**

	Obtenha a configuração do tipo da :ref:`sequência da entrada
	<luascript-ref-inputseq>` para um determinado tipo de acesso, o
	número do jogador e o tipo da sequência. O tipo da entrada pode ser
	um valor enumerado ou um
	:ref:`tipo de acesso <luascript-ref-inputtype>`. Caso o tipo de
	acesso seja um valor enumerado, o número do jogador pode ser
	informado como um índice com base zero, caso contrário, será
	presumido que seja zero, sendo o tipo da entrada um tipo de acesso,
	o número do jogador não poderá ser informado de forma separada.
	Havendo a informação do tipo da sequência, ela deve ser
	``"standard"``, ``"increment"`` ou ``"decrement"``, na sua ausência,
	será presumido que seja ``"standard"``.

	Isso fornece acesso à configuração geral da entrada.


**ioport:set_type_seq** (tipo, [jogador], tipo_da_sequência, sequência)

	Define a configuração da
	:ref:`sequência de entrada <luascript-ref-inputseq>` para um
	determinado tipo de acesso, o número do jogador e o tipo da
	sequência. O tipo da entrada pode ser um valor enumerado ou um
	:ref:`tipo de acesso <luascript-ref-inputtype>`. Caso o tipo de
	acesso seja um valor enumerado, o número do jogador pode ser
	informado como um índice com base zero, sendo o tipo da entrada um
	tipo de acesso, o número do jogador não poderá ser informado de
	forma separada. A sequência deve ser ``"standard"``, ``"increment"``
	ou ``"decrement"``.

	Isso permite que a configuração geral da entrada possa ser definida.


**ioport:token_to_input_type(string)**

	Retorna uma *string* com o tipo da entrada e o número do jogador
	para o tipo da entrada do token informado.


**ioport:input_type_to_token(tipo, [jogador])**

	Retorna uma *string* do token para o tipo da entrada informada e o
	número do jogador. Se o número do jogador não for informado, será
	presumido que seja zero.


Propriedades
~~~~~~~~~~~~

**ioport.types[ ]** |sole|

	Obtém o :ref:`tipo de acesso <luascript-ref-inputtype>`
	compatível. As teclas são índices arbitrários. Todas as operações
	compatíveis possuem complexidade O(1).


**ioport.ports[ ]**

	Obtém a emulação da :ref:`porta de E/S <luascript-ref-ioport>`
	no sistema.
	Chaves são tags absolutas.  Os métodos ``at`` e o ``index_of``
	têm complexidade O(n); todas as outras operações compatíveis têm
	complexidade O(1).


.. _luascript-ref-natkbdman:

Gerenciador de teclado natural
------------------------------

|encaa| ``natural_keyboard`` do MAME que gerencia o teclado emulado e as
entradas do teclado.


Instanciação
~~~~~~~~~~~~

**manager.machine.natkeyboard**

	Obtém a instância do gerenciador do teclado natural global para o
	sistema que está sendo emulado.


Métodos
~~~~~~~

**natkeyboard:post(texto)**

	Publique um texto literal no sistema emulado. O sistema deve ter
	uma entrada de teclado com os caracteres vinculados e o dispositivo
	correto da entrada do teclado deve estar ativado.


**natkeyboard:post_coded(texto)**

	Publique o texto |nsqe|. Os códigos entre chaves são interpretados
	no texto. O sistema deve ter as entradas do teclado com os
	caracteres vinculados e o dispositivo correto da entrada do teclado
	deve estar ativado.

	Os códigos reconhecidos são ``{BACKSPACE}``, ``{BS}``, ``{BKSP}``,
	``{DEL}``, ``{DELETE}``, ``{END}``, ``{ENTER}``, ``{ESC}``,
	``{HOME}``, ``{INS}``, ``{INSERT}``, ``{PGDN}``, ``{PGUP}``,
	``{SPACE}``, ``{TAB}``, ``{F1}``, ``{F2}``, ``{F3}``, ``{F4}``,
	``{F5}``, ``{F6}``, ``{F7}``, ``{F8}``, ``{F9}``, ``{F10}``,
	``{F11}``, ``{F12}`` e ``{QUOTE}``.


**natkeyboard:paste()**

	Publique o conteúdo da área de transferência do host no sistema
	emulado. O sistema deve ter as entradas do teclado com caracteres
	vinculados e o dispositivo correto da entrada do teclado deve estar
	ativado.


**natkeyboard:dump()**

	Retorna uma *string* com uma descrição legível do teclado e dos
	dispositivos de entrada do teclado numérico no sistema, se eles
	estão ativados e os seus caracteres vinculados.


Propriedades
~~~~~~~~~~~~

**natkeyboard.empty** |sole|

	Um booleano que indica se o buffer da entrada do gerenciador do
	teclado natural está vazio.


**natkeyboard.full** |sole|

	Um booleano que indica se o buffer da entrada do gerenciador do
	teclado natural está cheio.


**natkeyboard.can_post** |sole|

	Um booleano que indica se o sistema emulado suporta a postagem dos
	dados dos caracteres através do gerenciador do teclado natural.


**natkeyboard.is_posting** |sole|

	Um booleano que indica se os dados postados dos caracteres estão
	sendo entregues ao sistema que está sendo emulado.


**natkeyboard.in_use** |lees|

	Um booleano que indica se o modo “teclado natural” está ativado.
	Quando O modo “teclado natural” está ativado o gerenciador do
	teclado natural traduz a entrada de caractere do host para
	pressionamentos da tecla do sistema emulado.


**natkeyboard.keyboards[ ]**

	Obtém o :ref:`dispositivo de entrada do teclado
	<luascript-ref-natkbddev>` |nsqe|, indexado através da tag
	absoluta do dispositivo. O índice get tem O(n) complexidade; todas
	as outras operações compatíveis têm complexidade O(1).


.. _luascript-ref-natkbddev:

Dispositivo de entrada do teclado
---------------------------------

Representa um teclado ou dispositivo de entrada do teclado que é
gerenciado pelo :ref:`gerenciador do teclado natural
<luascript-ref-natkbdman>`. Observe que isso não é uma classe de
:ref:`dispositivo <luascript-ref-device>`.


Instanciação
~~~~~~~~~~~~

**manager.machine.natkeyboard.keyboards[tag]**

	Obtém o dispositivo da entrada do teclado com a tag informada ou
	``nil`` se a tag não corresponder a um dispositivo da entrada do
	teclado.


Propriedades
~~~~~~~~~~~~

**keyboard.device** |sole|

	O :ref:`dispositivo <luascript-ref-device>` subjacente.

**keyboard.tag** |sole|

	A tag absoluta do dispositivo subjacente.


**keyboard.basetag** |sole|

	O último componente da tag do dispositivo subjacente ou ``"root"``
	para o dispositivo raiz do sistema.


**keyboard.name** |sole|

	A descrição legível para as pessoas do tipo do dispositivo
	subjacente.


**keyboard.shortname** |sole|

	O identificador do tipo do dispositivo subjacente.


**keyboard.is_keypad** |sole|

	Um booleano que indica se o dispositivo subjacente possui as
	entradas do teclado numérico, mas não para a entradas do teclado.
	Isso é usado para determinar quais dispositivos da entrada do
	teclado deve ser ativado por padrão.


**keyboard.enabled** |lees|

	Um booleano que indica se as entradas do teclado e/ou do teclado
	numérico do dispositivo estão ativados.


.. _luascript-ref-ioport:

Porta de E/S
------------

|encaa| ``ioport_port`` do MAME que representa uma porta emulada de E/S.

Instanciação
~~~~~~~~~~~~

**manager.machine.ioport.ports[tag]**

	Obtém uma porta de E/S emulada através da tag absoluta ou ``nil``
	caso a tag não corresponda a uma porta de E/S.


**manager.machine.devices[devtag]:ioport(porttag)**

	Obtém uma porta de E/S emulada através da tag relativa a um
	dispositivo ou ``nil`` se não houver nenhuma porta de E/S.


Métodos
~~~~~~~

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
	<luascript-ref-ioportfield>` correspondente aos bits que são
	definidos na máscara informada ou ``nil`` se não houver nenhum campo
	correspondente.


Propriedades
~~~~~~~~~~~~

**port.device**  |sole|

	O dispositivo que possui a porta de E/S.


**port.tag** |sole|

	A etiqueta absoluta da porta E/S


**port.active** |sole|

	Uma máscara indicando quais os bits da porta E/S correspondem aos
	campos ativos (isto é, os bits que não não utilizados ou não foram
	atribuídos).


**port.live** |sole|

	O estado ativo da porta de E/S.


**port.fields[ ]** |sole|

	Obtém uma tabela do :ref:`campo da porta de E/S
	<luascript-ref-ioportfield>` indexados por nome.


.. _luascript-ref-ioportfield:

Campo da porta de E/S
---------------------

|encaa| ``ioport_field`` do MAME que representa um campo dentro da porta
de E/S.


Instanciação
~~~~~~~~~~~~

**manager.machine.ioport.ports[tag]:field(máscara)**

	Obtém um campo para a porta informada através dos bits da máscara.


**manager.machine.ioport.ports[tag].fields[nome]**

	Obtém um campo para a porta informada através do nome de exibição.


Métodos
~~~~~~~

**field:set_value(valor)**

	Define o valor do campo da porta de E/S.  Para os campos digitais,
	o valor é comparado com zero para determinar se o campo deve estar
	ativo; para os campos analógicos, o valor deve estar alinhado à
	direita e no intervalo correto.


**field:clear_value()**

	Limpa o valor programado excedente e restaura o comportamento
	regular do campo.


**field:set_input_seq(tipo_da_sequência, sequência)**

	Define a :ref:`sequência de entrada <luascript-ref-inputseq>`
	para o tipo da sequência informada. Isso é usado para definir as
	configurações da entrada por sistema.
	O tipo da sequência deve ser ``"standard"``, ``"increment"`` ou
	``"decrement"``.


**field:input_seq(tipo_da_sequência)**

	Obtenha a :ref:`sequência de entrada <luascript-ref-inputseq>`
	configurada para o tipo da sequência informada. Isso obtém as
	configurações da entrada por sistema.
	O tipo da sequência deve ser ``"standard"``, ``"increment"`` ou
	``"decrement"``.


**field:set_default_input_seq(tipo_da_sequência, sequência)**

	Define a :ref:`sequência de entrada <luascript-ref-inputseq>`
	predefinida para o tipo da sequência informada. É usado para
	definir as configurações gerais da entrada.
	O tipo da sequência deve ser ``"standard"``, ``"increment"`` ou
	``"decrement"``.


**field:default_input_seq(tipo_da_sequência)**

	Obtém a :ref:`sequência de entrada <luascript-ref-inputseq>`
	predefinida para o tipo da sequência informada.
	Obtém as configurações gerais da entrada. O tipo da sequência deve
	ser ``"standard"``, ``"increment"`` ou ``"decrement"``.


**field:keyboard_codes(shift)**

	Obtém uma tabela dos caracteres correspondentes ao campo para o
	estado do shift informado. O estado do shift é uma máscara de bits
	das teclas ativas do shift.


Propriedades
~~~~~~~~~~~~

**field.device** |sole|

	O dispositivo que possui a porta que o campo pertence.


**field.port** |sole|

	A :ref:`porta de E/S <luascript-ref-ioport>` que o campo
	pertence.


**field.live** |sole|

	O :ref:`estado do campo da porta de E/S em tempo real
	<luascript-ref-ioportfieldlive>` do campo.


**field.type** |sole|

	O tipo da entrada do campo.  Este é um valor enumerado.


**field.name** |sole|

	O nome da exibição do campo.


**field.default_name** |sole|

	O nome da configuração para o campo do sistema emulado (não pode
	ser substituído por *scripts* ou plug-ins).


**field.player** |sole|

	O número do jogador para o campo com base zero.


**field.mask** |sole|

	Os Bits na porta de E/S correspondente a este campo.


**field.defvalue** |sole|

	O valor predefinido do campo.


**field.minvalue** |sole|

	O valor mínimo permitido nos campos analógicos ou ``nil`` nos campos
	digitais.


**field.maxvalue** |sole|

	O valor máximo permitido nos campos analógicos ou ``nil`` nos campos
	digitais.


**field.sensitivity** |sole|

	A sensibilidade ou ganho para os campos analógicos ou ``nil`` nos
	campos digitais.


**field.way** |sole|

	A quantidade das direções permitidas através do restritor da
	placa/portão para um joystick digital ou zero (``0``) para as outras
	entradas.


**field.type_class** |sole|

	O tipo da classe para o campo da entrada para um dos ``"keyboard"``,
	``"controller"``, ``"config"``, ``"dipswitch"`` ou ``"misc"``.


**field.is_analog** |sole|

	Um booleano que indica se o campo é um eixo analógico ou controle
	posicional.

.. raw:: latex

	\clearpage


**field.is_digital_joystick** |sole|

	Um booleano que indica se o campo corresponde ao comutador de um
	joystick digital.


**field.enabled** |sole|

	Um booleano que indica se o campo está ativado.


**field.optional** |sole|

	Um booleano que indica se o campo é opcional e não é obrigatório
	para uso |nsqe|.


**field.cocktail** |sole|

	Um booleano que indica se o campo é usado apenas quando o sistema é
	configurado para um gabinete de mesa tipo coquetel.


**field.toggle** |sole|

	Um booleano que indica se o campo corresponde a uma botão do
	hardware tipo liga/desliga ou um botão de pressão.


**field.rotated** |sole|

	Um booleano que indica se o campo corresponde a um controle que é
	rotacionado em relação à orientação padrão.


**field.analog_reverse** |sole|

	Um booleano que indica se o campo corresponde a um controle
	analógico que aumenta na direção oposta à convenção (por exemplo,
	valores maiores quando um pedal é solto ou um joystick é movido para
	a esquerda).


**field.analog_reset** |sole|

	Um booleano que indica se o campo corresponde a um incremental da
	posição da entrada (por exemplo, um dial ou eixo do trackball) que
	deve ser redefinida para zero para cada quadro do vídeo.


**field.analog_wraps** |sole|

	Um booleano que indica se o campo corresponde a uma entrada
	analógica que encapsula a partir de uma extremidade da sua faixa
	para a outra (por exemplo, uma posição incremental como a entrada de
	um dial ou o eixo do trackball).


**field.analog_invert** |sole|

	Um booleano que indica se o campo corresponde a uma entrada
	analógica que tem o seu valor complementado.


**field.impulse** |sole|

	Um booleano que indica se o campo corresponde a uma entrada digital
	que é ativado por um determinado período de tempo fixo.


**field.crosshair_scale** |sole|

	O fator de escala para traduzir o intervalo do campo para a posição
	da mira. Um valor de um (``1``) que traduz o intervalo total do
	campo para a largura total ou altura da tela.

.. raw:: latex

	\clearpage


**field.crosshair_offset** |sole|

	O *offset* para traduzir o intervalo do campo para a posição da
	mira.


**field.user_value** |lees|

	O valor da chave DIP ou das definições da configuração.


**field.settings[ ]** |sole|

	Obtém uma tabela das configurações ativadas atualmente para um
	interruptor DIP ou o campo de configuração, indexado por valor.


.. _luascript-ref-ioportfieldlive:

Estado do campo da porta de E/S em tempo real
---------------------------------------------

|encaa| ``ioport_field_live`` do MAME que representa o estado em tempo
real de uma porta de E/S.


Instanciação
~~~~~~~~~~~~

**manager.machine.ioport.ports[tag]:field(máscara).live**

	Obtém o estado em tempo real para um campo da porta de E/S.


Propriedades
~~~~~~~~~~~~

**live.name**

	O nome da exibição do campo.


.. _luascript-ref-inputtype:

Tipo da entrada
---------------

Envelopa a classe ``input_type_entry`` do MAME, faz a representação do
tipo de acesso ou do tipo de acesso da interface do usuário no emulador.
Os tipo de acesso são identificados de forma única através da combinação
do índice do jogador e do tipo do valor da sua enumeração.


Instanciação
~~~~~~~~~~~~

**manager.machine.ioport.types[índice]**

	Obtém um tipo de acesso compatível.


Propriedades
~~~~~~~~~~~~

**type.type** |sole|

	Um valor enumerado que representa o tipo de acesso.


**type.group** |sole|

	Um valor inteiro que fornece o agrupamento para o tipo de acesso.
	Deve ser utilizado para fornecer um agrupamento canônico numa
	configuração de entrada da interface do usuário (IU).

.. raw:: latex

	\clearpage


**type.player** |sole|

	Número do jogador com base zero ou zero para controles não
	relacionados com o jogador.


**type.token** |sole|

	A *string* de um token para o tipo de acesso, usado nos arquivos de
	configuração.


**type.name** |sole|

	O nome do tela para o tipo de acesso.


**type.is_analog** |sole|

	|ubis| o tipo de acesso é analógico ou digital.
	As entradas que possuam apenas as condições ligado ou desligado são
	consideradas digitais, enquanto todas as outras são consideradas
	analógicas ainda que elas representem apenas valores discretos ou
	posições.


.. _luascript-ref-inputman:

Gerenciador da entrada
----------------------

|encaa| ``input_manager`` do MAME que lê os dispositivos da entrada do
host e verifica se as entradas configuradas estão ativas.


Instanciação
~~~~~~~~~~~~

**manager.machine:input()**

	Obtém a instância global do gerenciador da entrada para o sistema
	que está sendo emulado.


Métodos
~~~~~~~

**input:code_value(código)**

	Obtém o valor atual para a entrada do host correspondente ao código
	informado. Retorna um valor inteiro assinado onde zero é a posição
	neutra.


**input:code_pressed(código)**

	|ubis| o código informado da entrada do
	host correspondente tem um valor diferente de zero (ou seja, não é
	uma posição neutra).


**input:code_pressed_once(código)**

	|ubis| o código informado da entrada do
	host correspondente saiu da posição neutra desde a última vez que
	foi verificado através desta função. O gerenciador da entrada pode
	rastrear uma quantidade de entradas desta forma.


**input:code_name(código)**

	Obtenha o nome de exibição para um código da entrada.


**input:code_to_token(código)**

	Obtenha a *string* do token para um código da entrada. Isso deve ser
	usado ao salvar uma configuração.


**input:code_from_token(token)**

	Converta uma *string* do token num código de entrada. Retorna o
	código de entrada inválido se o token não for válido ou caso
	pertença a um dispositivo de entrada que não está presente.


**input:seq_pressed(sequência)**

	|ubis| a :ref:`sequência da entrada
	<luascript-ref-inputseq>` informada foi realmente pressionada.


**input:seq_clean(sequência)**

	Remova os elementos inválidos da :ref:`sequência da entrada
	<luascript-ref-inputseq>` informada. Retorna uma nova, sequência
	limpa da entrada.


**input:seq_name(sequência)**

	Obtenha o texto de exibição para uma :ref:`sequência da entrada
	<luascript-ref-inputseq>`.


**input:seq_to_tokens(sequência)**

	Converta uma :ref:`sequência da entrada <luascript-ref-inputseq>`
	numa *string* token. Isso deve ser usado quando for salvar na
	configuração.


**input:seq_from_tokens(tokens)**

	Converta uma *string* token numa :ref:`sequência da entrada
	<luascript-ref-inputseq>`. Isso deve ser usado quando for
	carregar uma configuração.


**input:axis_code_poller()**

	Retorna um :ref:`código da condição da entrada
	<luascript-ref-inputcodepoll>` para obter um código da entrada do
	host analógico.


**input:switch_code_poller()**

	Retorna um :ref:`código da condição da entrada
	<luascript-ref-inputcodepoll>` para obter um código da entrada do
	interruptor do host.


**input:keyboard_code_poller()**

	Retorna um :ref:`código da condição da entrada
	<luascript-ref-inputcodepoll>` para a obtenção de um código da
	entrada do interruptor do host que considera apenas a entrada dos
	dispositivos do teclado.


**input:axis_sequence_poller()**

	Retorna uma :ref:`sequência da condição da entrada
	<luascript-ref-inputcodepoll>` para obter uma
	:ref:`sequência da entrada <luascript-ref-inputseq>` para
	configurar uma entrada analógica.


**input:axis_sequence_poller()**

	Retorna uma :ref:`sequência da condição da entrada
	<luascript-ref-inputcodepoll>` para obter uma
	:ref:`sequência da entrada <luascript-ref-inputseq>` para
	configurar uma entrada digital.


Propriedades
~~~~~~~~~~~~

**input.device_classes[ ]** |sole|

	Pega uma tabela host :ref:`host da classe do dispositivo da entrada
	<luascript-ref-inputdevclass>` indexada por nome.


.. _luascript-ref-inputcodepoll:

Código da condição da entrada
-----------------------------

|encaa| ``input_code_poller`` do MAME que é usada para pesquisar as
entradas do host que estão sendo ativadas.


Instanciação
~~~~~~~~~~~~

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
~~~~~~~

**poller:reset()**

	Redefine a lógica da pesquisa.  As entradas do interruptor ativo são
	apagadas e as entradas das posições analógica são definidas.


**poller:poll()**

	Retorna um código da entrada correspondente à primeira entrada
	relevante do host que foi ativado desde a última vez que o método
	foi invocado. Retorna um código de entrada inválido caso nenhuma
	entrada relevante tenha sido ativada.


.. _luascript-ref-inputseqpoll:

Sequência da condição da entrada
--------------------------------

|encaa| da condição ``input_sequence_poller`` do MAME que permite que os
usuários atribuam combinações na entrada do host para as entradas
emuladas e outras ações.

Instanciação
~~~~~~~~~~~~

**manager.machine.input:axis_sequence_poller()**

	Retorna uma condição da sequência da entrada para atribuir as
	entradas do host a uma entrada analógica.


**manager.machine.input:switch_sequence_poller()**

	Retorna uma condição da sequência da entrada para atribuir as
	entradas do host a entrada de um interruptor.


Métodos
~~~~~~~

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
~~~~~~~~~~~~

**poller.sequence** |sole|

	A :ref:`sequência da entrada <luascript-ref-inputseq>` atual. É
	atualizado durante o processo de obtenção. É possível para que a
	sequência se torne inválida.


**poller.valid** |sole|

	Um booleano que indica se a sequência da entrada atual é válida.


**poller.modified** |sole|

	Um booleano que indica se a sequência foi alterada através de alguma
	entrada do usuário desde o início do processo.


.. _luascript-ref-inputseq:

Sequência da entrada
--------------------

|encaa| ``input_seq`` do MAME que representa a combinação das entradas
do host que possam ser lidos ou designados para uma determinada
entrada da emulação. As sequências da entrada podem ser manipuladas
usando os métodos do
:ref:`gerenciador da entrada <luascript-ref-inputman>`. 
Use um
:ref:`obtentor da sequência de entrada <luascript-ref-inputcodepoll>`
para obter uma sequência da entrada a partir do usuário.


Instanciação
~~~~~~~~~~~~

**emu.input_seq()**

	Cria uma sequência vazia da entrada.


**emu.input_seq(seq)**

	Cria uma cópia de uma sequência já existente da entrada.


Métodos
~~~~~~~

**seq:reset()**

	Limpa a sequência da entrada, removendo todos os itens.


**seq:set_default()**

	Define a sequência da entrada num único item contendo o valor meta
	que definindo qual a configuração padrão deve ser usada.


Propriedades
~~~~~~~~~~~~

**seq.empty** |sole|

	Um booleano indicando se a sequência da entrada está vazia (não
	possui quaisquer itens, indicando uma entrada sem atribuição).


**seq.length** |sole|

	A quantidade dos itens na sequência da entrada.


**seq.is_valid** |sole|

	Um booleano indicando se a sequência da entrada é válida. Para ser
	válido, deve conter pelo menos um item, todos os itens devem possuir
	códigos válidos, todos os grupos dos produtos devem conter pelo
	menos um item que não seja negado e os itens referentes aos eixos
	absolutos e relativos não devem ser misturados dentro de um grupo de
	produtos.


**seq.is_default** |sole|

	Um booleano indicando se a sequência da entrada define se a
	configuração deve ser usada.


.. _luascript-ref-inputdevclass:

Host da classe do dispositivo da entrada
----------------------------------------

|encaa| ``input_class`` do MAME que representa uma categoria da entrada
do host dos dispositivos (por exemplo, teclados ou joysticks).


Instanciação
~~~~~~~~~~~~

**manager.machine.input.device_classes[nome]**

	Obtém uma entrada da classe do dispositivo por nome.


Propriedades
~~~~~~~~~~~~

**devclass.name** |sole|

	O nome da classe do dispositivo.


**devclass.enabled** |sole|

	Um booleano que indica se a classe do dispositivo está ativo.


**devclass.multi** |sole|

	Um booleano que indica se a classe do dispositivo oferece suporte a
	vários dispositivos ou as entradas de todos os dispositivos da
	classe são combinadas e tratadas como um único dispositivo.


**devclass.devices[ ]** |sole|

	Obtém uma tabela :ref:`host do dispositivo da entrada
	<luascript-ref-inputdev>` na classe. As chaves são os índices
	com base ``1``.


.. _luascript-ref-inputdev:

Host do dispositivo da entrada
------------------------------

|encaa| ``input_device`` do MAME que representa um dispositivo da
entrada do host.


Instanciação
~~~~~~~~~~~~

**manager.machine.input.device_classes[nome].devices[índice]**

	Obtém um dispositivo de entrada específica de um host.


Propriedades
~~~~~~~~~~~~

**inputdev.name** |sole|

	Nome da exibição do dispositivo.  Não há garantia de que isso seja
	exclusivo.


**inputdev.id** |sole|

	A *string* do identificador exclusivo para o dispositivo. Isso pode
	não ser legível para as pessoas.


**inputdev.devindex** |sole|

	O índice do dispositivo dentro da classe de dispositivo. Isso não é
	necessariamente o mesmo que o índice na propriedade ``devices`` da
	classe do dispositivo o índice do ``devindex`` podem não ser
	contíguos.


**inputdev.items** |sole|

	Obtém as tabelas :ref:`host do item do dispositivo da entrada
	<luascript-ref-inputdevitem>`, indexado através da ID do item. A
	ID do item é um valor enumerado.


.. _luascript-ref-inputdevitem:

Host do item do dispositivo da entrada
--------------------------------------

|encaa| ``input_device_item`` do MAME que representa uma única entrada
do host (por exemplo uma chave, botão ou eixo).


Instanciação
~~~~~~~~~~~~

**manager.machine.input.device_classes[nome].devices[índice].items[id]**

	Obtém um item individual da entrada do host.  A ID do item é um
	valor enumerado.


Propriedades
~~~~~~~~~~~~

**item.name** |sole|

	O nome da exibição da entrada do item.  Observe que este é apenas o
	nome do próprio item que não inclui o nome do dispositivo. O nome
	completo da exibição para o item pode ser obtido ao invocar o método
	``code_name`` no :ref:`gerenciador da entrada
	<luascript-ref-inputman>` com o código do item.


**item.code** |sole|

	O código de identificação da entrada do item. Isso é usado por
	vários métodos do :ref:`gerenciador da entrada
	<luascript-ref-inputman>`.


**item.token** |sole|

	A *string* token do item da entrada. Observe que este é um fragmento
	do token para o o próprio item que não inclui a parte do
	dispositivo. O token completo para o item pode ser obtido ao invocar
	o método ``code_to_token`` no :ref:`gerenciador da entrada
	<luascript-ref-inputman>` com o código do item.


**item.current** |sole|

	O valor atual do item. Este é um número inteiro assinado onde zero é
	a posição neutra.


.. _luascript-ref-uiinputman:

Gerenciador da entrada da IU
----------------------------

|encaa| ``ui_input_manager`` do MAME que é usada para a entrada de alto
nível.

Instanciação
~~~~~~~~~~~~

**manager.machine.uiinput**

	Obtém a instância do gerenciador da entrada global da IU para a
	sistema.


Métodos
~~~~~~~

**uiinput:reset()**

	Limpa os eventos pendentes e os estados da interface de entrada do
	usuário. Deve ser chamado ao encerrar o modo de um estado onde a
	entrada é tratada diretamente (ao configurar uma combinação de
	entrada por exemplo).

**uiinput:find_mouse()**

	Retorna o ponteiro do mouse do sistema host, posição X, posição Y,
	estado do botão e o :ref:`alvo do renderizador
	<luascript-ref-rendertarget>` que se encaixa. A posição no host
	está em pixels, onde zero está na parte superior/esquerda. O estado
	do botão é um booleano que indica se o botão principal do mouse está
	pressionado.

	Se o ponteiro do mouse não estiver sobre uma das janelas do MAME,
	isso pode retornar a posição e renderizar o alvo de quando o
	ponteiro do mouse estava mais recentemente sobre uma das janelas do
	MAME. O alvo da renderização pode ser ``nil`` se o ponteiro do
	mouse não estiver sobre uma das janelas do MAME.

.. raw:: latex

	\clearpage


**uiinput:pressed(tipo)**

	|ubis| a entrada da IU informada foi pressionada. O tipo da entrada
	é um valor enumerado.


**uiinput:pressed_repeat(tipo, velocidade)**

	|ubis| a entrada da IU informada foi 	pressionada ou a repetição
	automática foi disparada na velocidade informada. O tipo da entrada
	é um valor enumerado; a velocidade é um intervalo em sessenta avos
	de um segundo.


Propriedades
~~~~~~~~~~~~

**uiinput.presses_enabled** |lees|

	Se o gerenciador da entrada da IU verificará se há atualizações do
	quadro das entradas da IU.

.. |encaa| replace:: Encapsula a classe
.. |sole| replace:: (somente leitura)
.. |ubis| replace:: Retorna um booleano indicando se
.. |lees| replace:: (leitura e escrita)
.. |nsqe| replace:: no sistema que está sendo emulado
