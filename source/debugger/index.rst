.. _debugger:

O DEPURADOR
===========

.. contents:: :local:


.. _debugger-intro:

Introdução
----------

O MAME inclui um depurador interativo de baixo nível que tem como alvo
o sistema de emulação. Pode ser uma ferramenta útil para diagnosticar
problemas relacionados à emulação, no desenvolvimento do software para
rodar em sistemas antigos, na criação das trapaças, para o "*hacking*"
de uma ROM ou simplesmente para investigar como o software funciona.

Use a opção ``-debug`` na linha de comando para iniciar o MAME com o
depurador ativado. Como padrão, pressione a tecla :kbd:`'` (:kbd:`"`)
durante a emulação para entrar no depurador (é possível alterar a tecla
alterando a configuração :guilabel:`Entra no depurador`).

A aparência exata do depurador depende do seu sistema operacional e das
opções com as quais o MAME foi compilado. Todas as variantes do
depurador fornecem uma interface com várias janelas para a visualização
do conteúdo da memória e do código desmontado.

A janela do console do depurador é uma janela especial que mostra o
conteúdo dos registros da *CPU*, o código desmontado em torno do
endereço do contador atual do programa e fornece também uma interface
com linha de comando que auxilia em toda a funcionalidade do depurador.

.. _debugger-sections-list:

Os comandos do depurador
------------------------

Os comandos do depurador são descritos nas seções abaixo. Também é
possível digitar ``help comando`` no console do depurador para que a
ajuda seja exibida diretamente na tela do depurador.

.. toctree::
	:titlesonly:

	general
	memory
	execution
	breakpoint
	watchpoint
	registerpoints
	exceptionpoint
	annotation
	cheats
	image


.. raw:: latex

	\clearpage


.. _debugger-devicespec:

Determinando os dispositivos e as faixas de endereço
----------------------------------------------------

Os diversos comandos de depuração aceitam parâmetros que determinam em
qual dispositivo se vai operar. Caso um dispositivo não seja definido
de forma explícita, a *CPU* que será utilizada é a |qevm|. Os
dispositivos podem ser definidos através de uma etiqueta ou através do
número da *CPU* no depurador:

* As etiquetas são os caminhos separados por dois pontos (``:``) que o
  MAME utiliza para identificar os dispositivos dentro de um sistema
  (``:maincpu`` por exemplo).
  Você os vê nas opções de configuração dos dispositivos de slot, nas
  listas de origem da desmontagem do depurador, no visualizador da
  memória e em vários outros lugares dentro da interface do MAME.
* A numeração da *CPU* é um incremento monotônico dos números que o
  depurador atribui aos dispositivos do tipo *CPU* dentro de um sistema,
  começando por zero. O símbolo ``cpunum`` contém o número da *CPU*
  |qevm| (você pode vê-la usando o comando ``print cpunum`` no console).

Quando uma etiqueta é iniciada com um circunflexo ``^`` ou ponto
``.``, ela é interpretada com relação a *CPU* |qevm|, caso contrário,
ela é interpretada com relação ao dispositivo raiz do sistema. Quando um
argumento do dispositivo for ambíguo como uma etiqueta ou um número da
*CPU*, ele será interpretado como uma etiqueta.

Exemplos:

.. line-block::

    ``maincpu``
        O dispositivo com a etiqueta absoluta ``:maincpu``.
    ``^melodypsg``
        O dispositivo irmão da *CPU* visível com a etiqueta ``melodypsg``.
    ``.:adc``
        O sub-dispositivo da *CPU* visível com a etiqueta ``adc``.
    ``2``
        O terceiro dispositivo do tipo *CPU* no sistema (num índice com base zero).

Os comandos que operam na memória estendem isso ao permitir que a
etiqueta do dispositivo ou o número da *CPU* seja opcionalmente seguido
por um identificador na região do endereçamento, ele são cadeias de
caracteres do tipo etiqueta. Você pode vê-los nas listas de origem do
visualizador da memória do depurador. Quando o identificador da região
do endereçamento for omitido, uma região predefinida do endereço será
usada. Normalmente, esta é a região que aparece primeiro para no
dispositivo.
Muitos comandos têm variantes com sufixos ``d``, ``i`` e ``o`` (dados,
E/S e *opcodes*) que, por padrão, são as regiões do endereçamento nos
índices **1**, **2** e **3**, respectivamente, pois estes têm um
significado especial nos dispositivos do tipo *CPU*.

Em casos ambíguos, a região predefinida do endereçamento de um
sub-dispositivo será usado no lugar de uma determinada região específica
do endereço.

Exemplos:

.. line-block::

    ``ram``
        |spc| |ccad| na região ``:ram`` ou a ``ram`` |nrvd|.
    ``.:io``
        |spc| do sub-dispositivo da *CPU* visível |etq| ``:io`` ou o ``io`` |nrvd|.
    ``:program``
        |spc| |ccad| na região ``:program`` ou o ``program`` |ndrm|.
    ``^vdp``
        |spc| do dispositivo irmão |nrvd| |etq| ``vdp``.
    ``^:data``
        |spc| do dispositivo irmão |nrvd| |etq| ``data`` ou ``data`` na região do dispositivo principal |nrvd|.
    ``1:rom``
        |spc| do sub-dispositivo da *CPU* visível da 2ª *CPU* do sistema (|ibz|) |etq| ``:rom`` ou da ``rom`` da 2ª *CPU* do sistema.
    ``2``
        |spc| do 3º dispositivo tipo *CPU* no sistema (|ibz|).

Quando um comando toma como parâmetro um endereço emulado da memória, o
endereço pode opcionalmente ser seguido por uma determinação na |fde|,
conforme descrito acima.

Exemplos:

.. line-block::

    ``0220``
        O endereço ``0220`` na |fdep| |nrvd|.
    ``0378:io``
        O endereço ``0378`` na |fdep| |abs| ``:io`` ou ``io`` |neep| |nrvd|.
    ``1234:.:rom``
        O endereço ``1234`` na |fdep| no dispositivo relacionado |nrvd| com a etiqueta ``:rom`` ou da ``rom`` |neep| |nrvd|.
    ``1260:^vdp``
        O endereço ``1260`` na |fdep| do dispositivo irmão |nrvd| |etq| ``vdp``.
    ``8008:^:data``
        O endereço ``8008`` na |fdep| do dispositivo irmão |nrvd| |etq| ``:data`` ou ``data`` na região do dispositivo principal |nrvd|.
    ``9660::ram``
        O endereço ``9660`` na |fdep| do dispositivo com a etiqueta absoluta ``:ram`` ou ``ram`` |ndrm|.


Os exemplos aqui incluem muitos atalhos, mas geralmente, o depurador
deve tomar o significado mais provável para um dispositivo ou uma
especificação na região do endereçamento.


.. _debugger-express:

A sintaxe das expressões do depurador
-------------------------------------

As expressões podem ser usadas em qualquer lugar onde um parâmetro
numérico ou um parâmetro booleano seja esperado. A sintaxe das
expressões é semelhante a um subconjunto da sintaxe de expressão no
estilo C, com precedência total do operador e dos parênteses. Faltam
alguns operadores (notadamente o operador condicional ternário) e alguns
novos (assessores da memória).

A tabela abaixo lista todos os operadores, ordenados da mais alta para a
mais baixa prioridade:

.. line-block::

	``(`` ``)``
		Parenteses padrão.
	``++`` ``--``
		Postfix aumento/redução.
	``++`` ``--`` ``~`` ``!`` ``-`` ``+`` ``b@`` ``w@`` ``d@`` ``q@`` ``b!`` ``w!`` ``d!`` ``q!``
		Prefix aumento/redução, complemento binário, complemento lógico, identidade unária/negação, acesso da memória.
	``*`` ``/`` ``%``
		Multiplicação, divisão, modulo.
	``+`` ``-``
		Adição, subtração.
	``<<`` ``>>``
		Lógica binária [#bitwize]_ deslocamento [#shift]_ esquerdo/direito
	``<`` ``<=`` ``>`` ``>=``
		Menor, menor ou igual, maior, maior ou igual.
	``==`` ``!=``
		Igual, não igual.
	``&``
		Lógica binária de conjunção (**AND**).
	``^``
		Lógica binária exclusiva (**OR**).
	``|``
		Lógica binária de união (**OR**).
	``&&``
		Conjunção lógica (**AND**).
	``||``
		Disjunção lógica (**OR**).
	``=`` ``*=`` ``/=`` ``%=`` ``+=`` ``-=`` ``<<=`` ``>>=`` ``&=`` ``|=`` ``^=``
		Atribuição e alteração da atribuição.
	``,``
		Separa os termos e os parâmetros das funções.

.. [#bitwize]	Bitwise no Inglês.
.. [#shift]	Shift no Inglês.

.. raw:: latex

	\clearpage

As principais diferenças em relação à expressão semântica com C:

* Todos os números são valores não assinados com **64-bits**. Isso
  significa que números negativos não são permitidos.
* A conjunção lógica e os operadores de disjunção ``&&`` e ``||`` não
  apresentam propriedades de curto-circuito - ambos os lados da
  expressão são sempre avaliados.


.. _debugger-express-num:

Números
~~~~~~~

Os números literais são prefixados de acordo com suas respectivas bases:

* Hexadecimal (**base-16**) com ``$`` or ``0x``.
* Decimal (**base-10**) com ``#``.
* Octal (**base-8**) com ``0o``.
* Binário (**base-2**) com ``0b``.
* Números não prefixados são hexadecimais (**base-16**).

Exemplos:

* ``123`` é **123** em hexadecimal (**291** decimal).
* ``$123`` é **123** em hexadecimal (**291** decimal).
* ``0x123`` é **123** em hexadecimal (**291** decimal).
* ``#123`` é **123** em decimal.
* ``0o123`` é **123** em octal (**83** decimal).
* ``0b1001`` é **1001** binário (**9** decimal).
* ``0b123`` é **inválido**.


.. _debugger-express-bool:

Valores booleanos
~~~~~~~~~~~~~~~~~

Qualquer expressão que avalia até um número pode ser utilizado onde um
valor booleano seja necessário. Zero é tratado como falso, todos os
valores *não zero* são tratados como verdadeiros. Além disso, uma
*string* [#string]_ ``true`` é tratada como verdadeira e uma *string*
``false`` é tratada como falsa.

Uma expressão vazia pode ser apresentada como um argumento para que os
parâmetros booleanos sejam usados como comandos padrão que possam ser
usados para depuração, mesmo quando os parâmetros subsequentes sejam
definidos.

.. [#string] Pode ser traduzido como cadeia de caracteres, cadência de
   caracteres, sequência de caracteres, caracteres, texto, linha, dentre
   outras variantes dependendo do contexto,
   `mais informações <https://homepages.dcc.ufmg.br/~rodolfo/aedsi-2-06/cadeiadecaractere/cadeiadecaractere.html>`_.


.. _debugger-express-mem:

Acesso à memória
~~~~~~~~~~~~~~~~

Os operadores do prefixo de acesso à memória permitem a leitura e a
escrita nas regiões dos endereços emulados. Os operadores do prefixo da
memória determinam o tamanho do acesso e se os efeitos colaterais estão
desativados, opcionalmente, podem ser precedidos por uma determinação
na região do endereçamento. Os tamanhos do acesso suportado e os modos
dos efeitos colaterais são:

* ``b`` |dua| **8-bit** (byte).
* ``w`` |dua| **16-bit** (word).
* ``d`` |dua| **32-bit** (double word ou dword).
* ``q`` |dua| **64-bit** (quadruple word ou qword).
* ``@`` |sec|.
* ``!`` não |sec|.

Ao suprimir os efeitos colaterais de um acesso de leitura, a leitura do
valor de um endereço seria obtida sem mais efeitos. Por exemplo, a
leitura de uma "caixa postal" (*mailbox*) com efeitos colaterais
desativada não limpará a sinalização que estiver pendente e a leitura de
uma *FIFO* com os efeitos colaterais desativado, não fará a remoção de
um item.

Nos acessos de escrita, ao suprimir os efeitos colaterais, o
comportamento na maioria dos casos não é alterado, é preciso ver os
efeitos da escrita no local. Entretanto, há algumas exceções onde é útil
separar os diversos efeitos de um acesso de escrita, por exemplo:

* Alguns registros precisam ser escritos em sequência para evitar as
  condições de corrida. O depurador pode emitir várias escritas no mesmo
  ponto no tempo da emulação, de modo que estas condições de corrida não
  possam ser evitadas de forma trivial. Por exemplo, a escrita para a
  saída do MC68HC05 compara o registro com byte alto (*OCRH*) e impede a
  comparação até que a saída compare o registro com byte baixo (*OCRL*)
  seja escrita para evitar as condições de corrida. Como o depurador
  pode escrever em ambos os locais ao mesmo tempo do ponto de vista do
  sistema que está sendo emulado, assim no geral, a condição de corrida
  não é relevante. Ela é mais propensa a erros quando se pode
  acidentalmente definir seu estado oculto quando tudo o que se
  realmente deseja fazer é alterar o valor, assim ao escrever no *OCRH*
  com efeitos colaterais suprimidos, ele não inibe a comparação, apenas
  altera o valor no registro do comparador da saída.
* Ao escrever em alguns registros, os efeitos são diversos, o que pode
  ser útil para fins de depuração. Usando novamente o MC68HC05 como
  exemplo, ao escrever no *OCRL* o valor no registro de comparação da
  saída se altera e também limpa a sinalização de comparação da saída
  (*OCF*) permitindo comparar se ela foi anteriormente inibida durante a
  escrita no *OCRH*. A escrita no *OCRL* com efeitos colaterais
  desativado altera apenas o valor no registro sem apagar o *OCF* ou
  permite a comparação uma vez que é útil para a depuração. A escrita no
  *OCRL* com efeitos colaterais ativados tem efeitos adicionais.


Opcionalmente, o tamanho pode ser precedido por uma indicação do tipo de
acesso:

* ``p`` ou ``lp`` |delp| 0 (programa).
* ``d`` ou ``ld`` |delp| 1 (dados).
* ``i`` ou ``li`` |delp| 2 (E/S).
* ``3`` ou ``l3`` |delp| 3 (*opcodes*).
* ``pp`` |defp| 0 (programa).
* ``pd`` |defp| 1 (dados).
* ``pi`` |defp| 2 (E/S).
* ``p3`` |defp| 3 (opcodes).
* ``r`` |dpal| 0 (programa).
* ``o`` |dpal| 3 (opcodes).
* ``m`` define uma região da memória.

Finalmente, isso pode ser precedido por uma etiqueta e/ou um nome na
região do endereçamento seguido por um ponto (``.``).

Isso pode parecer muita coisa para ser assimilado, então vamos olhar
nos exemplos mais simples:

.. line-block::

    ``b@<addr>``
        |crab| <``addr``> |nedp| |eese|.
    ``b!<addr>``
        |crab| <``addr``> |nedp| |enes| como ao ler a "caixa de mensagens" (*mailbox*) limpando a sinalização pendente ou ao ler o *FIFO* removendo um item.
    ``w@<addr>`` e ``w!<addr>``
        |crab| <``addr``> |nedp| suprimindo ou não respectivamente os efeitos colaterais.
    ``d@<addr>`` e ``d!<addr>``
        Consulte a palavra dupla (*double word*) no <``addr``> |nedp|, respectivamente suprimindo ou não os efeitos colaterais.
    ``q@<addr>`` e ``q!<addr>``
        Consulte a palavra quadrupla (*quadruple word*) no <``addr``> |nedp|, respectivamente suprimindo ou não os efeitos colaterais.

A adição dos tipos de acesso oferece possibilidades adicionais:

.. line-block::

    ``dw@300``
        |crap| em ``300`` |nedd| |eese|.
    ``id@400``
        |crap| dupla em ``400`` na região de E/S da *CPU* atual |eese|.
    ``ppd!<addr>``
        |crap| dupla no endereço físico <``addr``> |nedp| |enes|.
    ``rw@<addr>``
        |crap| no endereço <``addr``> |nedp| usando um ponteiro de acesso direto para leitura/escrita.

Se quisermos acessar uma |fde| de um dispositivo que não seja a CPU
atual, uma |fde| além dos quatro primeiros índices ou uma região da
memória, precisamos incluir uma etiqueta ou um nome:

.. line-block::

    ``ramport.b@<addr>``
        |crbe| no endereço <``addr``> na região ``ramport`` |nedp|.
    ``audiocpu.dw@<addr>``
        |crbe| no endereço <``addr``> na região de dados da *CPU* com a etiqueta absoluta ``:audiocpu``.
    ``maincpu:status.b@<addr>``
        |crbe| no endereço <``addr``> na região ``status`` da *CPU* com a etiqueta absoluta ``:maincpu``.
    ``monitor.mb@78``
        |crbe| na região ``78`` da memória com a etiqueta absoluta ``:monitor``.
    ``..md@202``
        |crap| dupla no endereço ``22`` da região da memória com o mesmo caminho da etiqueta como a da *CPU*.

Algumas combinações não são úteis. Os endereços físicos e lógicos por
exemplo, eles são equivalentes em algumas *CPUs* e o ponteiro de acesso
direto para a leitura/escrita nunca tem um efeito colateral. Ao acessar
a região da memória (acesso do tipo ``m``) é preciso que uma etiqueta
seja definida.

O acesso à memória pode ser usado com ambos os ``lvalues`` e
``rvalues``, assim é possível escrever ``b@100 = ff`` para armazenar um
byte na memória.


.. _debugger-express-func:

Funções
~~~~~~~

O depurador suporta uma quantidade de funções úteis nas expressões.

.. line-block::

    ``min(<a>, <b>)``
        Retorna o menor valor de dois argumentos.
    ``max(<a>, <b>)``
        Retorna o maior valor de dois argumentos.
    ``if(<condição>, <valor_verdadeiro>, <valor_falso>)``
        Retorna o <``valor_verdadeiro``> caso a <``condição``> seja verdadeira (não zero), ou caso contrário, <``valor_falso``>. Observe que ambas as expressões para <``valor_verdadeiro``> e <``valor_falso``> são ambos avaliados independentemente ainda que a <``condição``> seja verdadeira ou falsa.
    ``abs(<x>)``
        Reinterpreta o argumento como um inteiro assinado com **64-bit** e retorna um valor absoluto.
    ``bit(<x>, <n>[, <w>])``
        Extrai e alinha à direita, um campo do bit <``w``> a partir dos bits com largura <``x``> na posição do bit de menor importância <``n``>, contando a partir do bit menos importante. Caso <``w``> seja omitido, um único bit é extraído.
    ``s8(<x>)``
        |paaa| **8** para **64-bits** (|sob| **8** até **63**, inclusive, |cvb| **7** |cpbc|).
    ``s16(<x>)``
        |paaa| **16** para **64-bits** (|sob| **16** até **63**, inclusive, |cvb| **15** |cpbc|).
    ``s32(<x>)``
        |paaa| **32** para **64-bits** (|sob| **32** até **63**, inclusive, |cvb| **31** |cpbc|).

.. |spc| replace:: A região do endereçamento padrão
.. |abs| replace:: do dispositivo com a etiqueta absoluta
.. |ccad| replace:: com o caminho absoluto da etiqueta
.. |qevm| replace:: que estiver visível no momento
.. |nrvd| replace:: da região visível da *CPU*
.. |etq| replace:: com a etiqueta
.. |ibz| replace:: num índice com base zero
.. |neep| replace:: do endereçamento
.. |ndrm| replace:: no dispositivo raiz do sistema
.. |dua| replace:: determina um acesso
.. |sec| replace:: suprime os efeitos colaterais
.. |delp| replace:: define um endereço lógico predefinido para a região
.. |defp| replace:: define um endereço físico predefinido para a região
.. |dpal| replace:: define um ponteiro de acesso predefinido de leitura/escrita para a região
.. |crab| replace:: Com referência ao byte em
.. |nedp| replace:: na região do programa da *CPU* atual
.. |eese| replace:: enquanto estiver suprimindo os efeitos colaterais
.. |enes| replace:: enquanto **não** estiver suprimindo os efeitos colaterais
.. |crap| replace:: Com referência a palavra
.. |nedd| replace:: na região de dados da *CPU* atual
.. |crbe| replace:: Com referência ao byte
.. |paaa| replace:: Prolonga a assinatura do argumento de
.. |sob| replace:: substitui os bits
.. |cvb| replace:: com o valor do bit
.. |cpbc| replace:: contando a partir do bit com menor importância
.. |fde| replace:: faixa de endereços
.. |fdep| replace:: faixa de endereço padrão

