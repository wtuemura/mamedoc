.. raw:: latex

	\clearpage

.. _umlinst:

Referência de instruções UML
============================

.. contents::
    :local:
    :depth: 2


.. raw:: latex

	\clearpage


.. _umlinst-intro:

Introdução
----------

UML é o conjunto de instruções usado pela estrutura do recompilador do
MAME. Os front-ends traduzem o código em execução nas CPUs convidadas
para instruções UML, e os back-ends convertem as instruções UML em um
formato que pode ser executado ou interpretado no sistema anfitrião.

Muitas instruções UML têm vários tamanhos de instrução. As instruções
inteiras têm como padrão o tamanho de 32 bits. Adicionar um prefixo
``D`` ou ``d`` ao mnemônico altera para o tamanho de 64 bits (palavra
dupla).  As instruções de ponto flutuante usam o prefixo/sufixo
mnemônico ``FS`` ou ``fs`` para o formato IEEE 754 de 32 bits (precisão
simples) ou o prefixo/sufixo ``FD`` ou ``fd`` para o formato IEEE 754 de
64 bits (precisão dupla).


.. _umlinst-special:

Tipos de valores especiais
--------------------------

.. _umlinst-conditions:

Condições
~~~~~~~~~

+-------------+--------------------------------+-------------+------------------------+
| Disassembly | Mnemônico                      | Utilização  | Sinalizadores testados |
+=============+================================+=============+========================+
| ``z``       | zero                           | ``COND_Z``  | ``Z``                  |
|             +--------------------------------+-------------+                        |
|             | igual                          | ``COND_E``  |                        |
+-------------+--------------------------------+-------------+------------------------+
| ``nz``      | não zero                       | ``COND_NZ`` | ``!Z``                 |
|             +--------------------------------+-------------+                        |
|             | não igual                      | ``COND_NE`` |                        |
+-------------+--------------------------------+-------------+------------------------+
| ``s``       | define polaridade              | ``COND_S``  | ``S``                  |
+-------------+--------------------------------+-------------+------------------------+
| ``ns``      | polaridade não definida        | ``COND_NS`` | ``!S``                 |
+-------------+--------------------------------+-------------+------------------------+
| ``c``       | transporte (carry)             | ``COND_C``  | ``C``                  |
|             +--------------------------------+-------------+                        |
|             | abaixo (não assinado)          | ``COND_B``  |                        |
+-------------+--------------------------------+-------------+------------------------+
| ``nc``      | sem transporte (no carry)      | ``COND_NC`` | ``!C``                 |
|             +--------------------------------+-------------+                        |
|             | abaixo ou igual (não assinado) | ``COND_AE`` |                        |
+-------------+--------------------------------+-------------+------------------------+
| ``v``       | transbordamento (assinado)     | ``COND_V``  | ``V``                  |
+-------------+--------------------------------+-------------+------------------------+
| ``nv``      | sem transbordamento (assinado) | ``COND_NV`` | ``!V``                 |
+-------------+--------------------------------+-------------+------------------------+
| ``u``       | desordenado                    | ``COND_U``  | ``U``                  |
+-------------+--------------------------------+-------------+------------------------+
| ``nu``      | não desordenado                | ``COND_NU`` | ``!U``                 |
+-------------+--------------------------------+-------------+------------------------+
| ``a``       | acima (não assinado)           | ``COND_A``  | ``!Z && !C``           |
+-------------+--------------------------------+-------------+------------------------+
| ``be``      | abaixo ou igual (não assinado) | ``COND_BE`` | ``Z || C``             |
+-------------+--------------------------------+-------------+------------------------+
| ``g``       | maior que (assinado)           | ``COND_G``  | ``!Z && (S == V)``     |
+-------------+--------------------------------+-------------+------------------------+
| ``le``      | menor que ou igual a (assinado)| ``COND_LE`` | ``Z || (S != V)``      |
+-------------+--------------------------------+-------------+------------------------+
| ``l``       | menor que (assinado)           | ``COND_L``  | ``S != V``             |
+-------------+--------------------------------+-------------+------------------------+
| ``ge``      | maior que ou igual a (assinado)| ``COND_GE`` | ``S == V``             |
+-------------+--------------------------------+-------------+------------------------+


.. raw:: latex

	\clearpage


.. _umlinst-flagmask:

Máscaras com sinalizadores
~~~~~~~~~~~~~~~~~~~~~~~~~~

+-------+-------------+-----------+----------------+
| Valor | Disassembly | Mnemônico | Utilização     |
+=======+=============+===========+================+
| 0x01  | ``C``       | carry     | ``FLAG_C``     |
+-------+-------------+-----------+----------------+
| 0x02  | ``V``       | overflow  | ``FLAG_V``     |
+-------+-------------+-----------+----------------+
| 0x04  | ``Z``       | zero      | ``FLAG_Z``     |
+-------+-------------+-----------+----------------+
| 0x08  | ``S``       | sign      | ``FLAG_S``     |
+-------+-------------+-----------+----------------+
| 0x10  | ``U``       | unordered | ``FLAG_U``     |
+-------+-------------+-----------+----------------+
| 0x00  |             |           | ``FLAGS_NONE`` |
+-------+-------------+-----------+----------------+
| 0x1f  | ``USZVC``   |           | ``FLAGS_ALL``  |
+-------+-------------+-----------+----------------+

Os sinalizadores são: **transporte (C)**, **estouro (V)**, **zero (Z)**,
**sinal (S)** e **não ordenado (U)**.

.. note:: Do original: **carry (C)**, **overflow (V)**, **zero (Z)**,
   **sign (S)** e **unordered (U)**.


.. _umlinst-roundmode:

Modos de arredondamento do ponto flutuante
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+-------+-------------+-----------+-------------------+---------------------------------------+
| Valor | Disassembly | Mnemônico | Utilização        | Modo                                  |
+=======+=============+===========+===================+=======================================+
| 0     | ``trunc``   | truncado  | ``ROUND_TRUNC``   | Arredondar para zero                  |
+-------+-------------+-----------+-------------------+---------------------------------------+
| 1     | ``round``   | circular  | ``ROUND_ROUND``   | |apon|                                |
+-------+-------------+-----------+-------------------+---------------------------------------+
| 2     | ``ceil``    | teto      | ``ROUND_CEIL``    | Arredondar para o infinito positivo   |
+-------+-------------+-----------+-------------------+---------------------------------------+
| 3     | ``floor``   | piso      | ``ROUND_FLOOR``   | Arredondar para infinito negativo     |
+-------+-------------+-----------+-------------------+---------------------------------------+
|       | ``default`` | padrão    | ``ROUND_DEFAULT`` | |uomda|                               |
+-------+-------------+-----------+-------------------+---------------------------------------+


.. raw:: latex

	\clearpage


.. _umlinst-flow:

Controle de fluxo
-----------------

.. _umlinst-comment:

COMMENT
~~~~~~~

Insere um comentário no código UML registrado.

+--------------------+---------------------------------+
| Disassembly        | Utilização                      |
+====================+=================================+
| .. code-block::    | .. code-block:: C++             |
|                    |                                 |
|     comment string |     UML_COMMENT(block, string); |
+--------------------+---------------------------------+

Operandos
^^^^^^^^^

string
    O texto do comentário como um ponteiro para uma cadeia de caracteres
    com terminação NUL. Ele deve permanecer válido até que o código seja
    gerado para o bloco.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-nop:

NOP
~~~

Sem operação.

+-----------------+---------------------+
| Disassembly     | Utilização          |
+=================+=====================+
| .. code-block:: | .. code-block:: C++ |
|                 |                     |
|     nop         |     UML_NOP(block); |
+-----------------+---------------------+

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-label:

LABEL
~~~~~

Associa um local a um número de etiqueta e o insere no bloco de código
gerado atualmente. Não é permitido reutilizar números das etiquetas em
um bloco de código gerado. A instrução :ref:`JMP <umlinst-jmp>` pode ser
usada para transferir o controle para o local associado a um número da
etiqueta.

+-------------------+----------------------------+
| Disassembly       | Utilização                 |
+===================+============================+
| .. code-block::   | .. code-block:: C++        |
|                   |                            |
|     label   label |     UML_LABEL(block, tag); |
+-------------------+----------------------------+

Operandos
^^^^^^^^^

label (número da etiqueta)
    O número da etiqueta deve ser associado ao local atual. Um número de
    etiqueta não deve ser usado mais de uma vez em um bloco com código
    gerado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-handle:

HANDLE
~~~~~~

Marca um local como ponto de entrada de uma sub-rotina. As sub-rotinas
podem ser invocadas usando as instruções :ref:`CALLH <umlinst-callh>` e
:ref:`EXH <umlinst-exh>`, assim como pelo
:ref:`HASHJMP <umlinst-hashjmp>`, se nenhum local estiver associado ao
modo especificado e ao contador do programa emulado.

+--------------------+--------------------------------+
| Disassembly        | Utilização                     |
+====================+================================+
| .. code-block::    | .. code-block:: C++            |
|                    |                                |
|     handle  handle |     UML_HANDLE(block, handle); |
+--------------------+--------------------------------+

Operandos
^^^^^^^^^

handle (manipulador do código)
    O manipulador de código que será vinculado ao local atual. O
    manipulador já deve estar alocado e não deve ter sido vinculado
    desde a última redefinição do código gerado (todos os manipuladores
    são implicitamente desvinculados ao redefinir o cache de código
    gerado).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-hash:

HASH
~~~~

Associa um local com o modo especificado e os valores do contador de
programa emulado. A instrução :ref:`HASHJMP <umlinst-hashjmp>` pode ser
usada para transferir o controle para o local associado a um modo e a
um valor de contador de programa emulado.

Isso geralmente é usado para marcar o local do código gerado para uma
instrução ou sequência de instruções emulada.

+---------------------+------------------------------+
| Disassembly         | Utilização                   |
+=====================+==============================+
| .. code-block::     | .. code-block:: C++          |
|                     |                              |
|     hash    mode,pc |   UML_HASH(bloco, modo, pc); |
+---------------------+------------------------------+

Operandos
^^^^^^^^^

mode (32-bit – imediato, variável de mapa)
    O modo que será associado ao local atual no código gerado. Deve ser
    maior ou igual a zero e menor que o número de modos especificados
    durante a criação do contexto do recompilador.
pc (32-bit – imediato, variável de mapa)
    O valor do contador de programa emulado que será associado ao local
    atual no código gerado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-jmp:

JMP
~~~

Salta ao local designado por um número de etiqueta dentro do bloco
atual.

+------------------------+-----------------------------------+
| Disassembly            | Utilização                        |
+========================+===================================+
| .. code-block::        | .. code-block:: C++               |
|                        |                                   |
|     jmp     label      |     UML_JMP(block, label);        |
|     jmp     label,cond |     UML_JMPc(block, cond, label); |
+------------------------+-----------------------------------+

Operandos
^^^^^^^^^

label (número da etiqueta)
    O número da etiqueta associada ao local para o qual se deve saltar
    no bloco de código gerado atualmente. Antes que o bloco seja
    finalizado, o número da etiqueta deve estar associado a um local no
    bloco de código gerado.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que se
    possa saltar para a etiqueta especificada. Caso a condição não seja
    atendida, a execução prosseguirá com a instrução subsequente.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-callh:

CALLH
~~~~~

Invoca a sub-rotina. Ela começa no identificador de código especificado.

+-------------------------+--------------------------------------+
| Disassembly             | Utilização                           |
+=========================+======================================+
| .. code-block::         | .. code-block:: C++                  |
|                         |                                      |
|     callh   handle      |     UML_CALLH(block, handle);        |
|     callh   handle,cond |     UML_CALLHc(block, cond, handle); |
+-------------------------+--------------------------------------+

Operandos
^^^^^^^^^

handle (código de manipulação)
    O manipulador está localizado no ponto de entrada da sub-rotina a
    ser chamada. Embora já deva estar alocado, o manipulador não precisa
    ser vinculado até que a instrução seja executada. Chamar um
    manipulador que não estava vinculado no momento da geração do código
    pode resultar em um código menos eficiente do que chamar um
    manipulador que já estava vinculado.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que a
    sub-rotina seja chamada. Se a condição não for atendida, a
    sub-rotina não será executada.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-exh:

EXH
~~~
O registro **EXP** é definido e a sub-rotina que começa no manipulador
de código especificado é chamada. O registro **EXP** é um registro de
função especial de 32 bits, que pode ser recuperado pela instrução
:ref:`GETEXP <umlinst-getexp>`.

+-----------------------------+-----------------------------------------+
| Disassembly                 | Utilização                              |
+=============================+=========================================+
| .. code-block::             | .. code-block:: C++                     |
|                             |                                         |
|     exh     handle,arg      |     UML_EXH(block, handle, arg);        |
|     exh     handle,arg,cond |     UML_EXHc(block, handle, arg, cond); |
+-----------------------------+-----------------------------------------+

Operandos
^^^^^^^^^

handle (manipulador do código)
    O manipulador está localizado no ponto de entrada da sub-rotina a
    ser chamada. Embora já deva estar alocado, o manipulador não
    precisa ser vinculado até que a instrução seja executada. Invocar um
    manipulador que não estava vinculado no momento da geração do código
    pode resultar em um código menos eficiente do que chamar um
    manipulador que já estava vinculado.
arg |3mriivm|
    Valor que será armazenado no registro **EXP**.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que a
    sub-rotina seja invocada. Se a condição não for atendida, a
    sub-rotina não será invocada e o registro EXP não será alterado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |orit|.


.. _umlinst-ret:

RET
~~~

Ao retornar de uma subrotina, transfere o controle para a instrução
seguinte à instrução :ref:`CALLH <umlinst-callh>` ou
:ref:`EXH <umlinst-exh>` usada para invocá-la. Essa instrução só deve
ser usada em sub-rotinas de código gerado. A instrução
:ref:`EXIT <umlinst-exit>` deve ser usada para sair do código gerado.

+------------------+----------------------------+
| Disassembly      | Utilização                 |
+==================+============================+
| .. code-block::  | .. code-block:: C++        |
|                  |                            |
|     ret          |     UML_RET(block);        |
|     ret     cond |     UML_RETc(block, cond); |
+------------------+----------------------------+

Operandos
^^^^^^^^^

cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que a
    sub-rotina retorne. Se a condição não for atendida, a execução
    continuará com a instrução seguinte.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-hashjmp:

HASHJMP
~~~~~~~

Desenrola todos os quadros de sub-rotina de código gerado aninhados e
transfere o controle para o local associado ao modo especificado e aos
valores do contador de programas emulado. Se nenhum local estiver
associado ao modo especificado e aos valores do contador de programas,
invoque a sub-rotina que começa no manipulador de código especificado.
Observe que todos os quadros de sub-rotina de código gerados aninhados
são desdobrados em ambos os casos.

Isso geralmente é usado para saltar para o código correspondente ao
código emulado em um endereço específico quando não se sabe se ele está
no bloco de código gerado atual ou quando o modo muda.

+----------------------------+-----------------------------------------+
| Disassembly                | Utilização                              |
+============================+=========================================+
| .. code-block::            | .. code-block:: C++                     |
|                            |                                         |
|     hashjmp mode,pc,handle |   UML_HASHJMP(block, mode, pc, handle); |
+----------------------------+-----------------------------------------+

Operandos
^^^^^^^^^

mode |3mriivm|
    O modo associado ao local no código gerado para o qual o controle
    deve ser transferido. Deve ser maior ou igual a zero e menor que o
    número de modos especificados durante a criação do contexto do
    recompilador.
pc |3mriivm|
    O valor do contador de programa emulado, associado ao local no
    código gerado, é o que determina para onde o controle deve ser
    transferido.
handle (manipulador do código)
    Se nenhum local no código gerado estiver associado ao modo
    especificado e aos valores do contador de programa emulado, o
    manipulador será localizado no ponto de entrada da sub-rotina que
    será. Embora o manipulador já deva estar alocado, não é mais
    necessário vinculá-lo até que a instrução seja executada. Invocar um
    manipulador que não estava vinculado no momento da geração do código
    pode resultar em um código menos eficiente do que invocar um
    manipulador que já estava vinculado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. raw:: latex

	\clearpage


.. _umlinst-exit:

EXIT
~~~~

O código gerado é enviado de volta ao chamador, que recupera o controle.
Pode ser usado em qualquer nível de invocações de sub-rotinas aninhadas
no código gerado.

+-----------------------+----------------------------------+
| Disassembly           | Utilização                       |
+=======================+==================================+
| .. code-block::       | .. code-block:: C++              |
|                       |                                  |
|     exit    arg,      |     UML_EXIT(block, arg);        |
|     exit    arg,,cond |     UML_EXITc(block, arg, cond); |
+-----------------------+----------------------------------+

Operandos
^^^^^^^^^

arg |3mriivm|
    O valor que será retornado ao solicitante.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para sair do
    código gerado. Se a condição não for atendida, a execução continuará
    com a instrução seguinte.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |orit|.


.. _umlinst-callc:

CALLC
~~~~~

A invocação de uma função C com a assinatura ``void (*)(void *)``.

+---------------------------+-----------------------------------------+
| Disassembly               | Utilização                              |
+===========================+=========================================+
| .. code-block::           | .. code-block:: C++                     |
|                           |                                         |
|     callc   func,arg      |     UML_CALLC(block, func, arg);        |
|     callc   func,arg,cond |     UML_CALLCc(block, func, arg, cond); |
+---------------------------+-----------------------------------------+

Operandos
^^^^^^^^^

func (função C)
    O ponteiro de função indica qual função deve ser invocada.
arg (memória)
    Argumento para encaminhar para a função.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que a
    função seja invocada. Se a condição não for atendida, a função não
    será invocada.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-debug:

DEBUG
~~~~~

Se apropriado, invocar a função de gancho de instrução do depurador.

Se o depurador estiver ativo, isso deverá ser executado antes de cada
instrução emulada. Qualquer estado de CPU emulado mantido nos registros
UML deve ser descarregado na memória antes da execução dessa instrução e
recarregado depois, para garantir que o depurador possa exibir e
modificar os valores corretamente.

+-----------------+---------------------------+
| Disassembly     | Utilização                |
+=================+===========================+
| .. code-block:: | .. code-block:: C++       |
|                 |                           |
|     debug   pc  |     UML_DEBUG(block, pc); |
+-----------------+---------------------------+

Operando
^^^^^^^^

pc |3mriivm|
    O valor do contador de programa emulado deve ser fornecido à função
    de gancho de instruções do depurador.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* O operando **pc** tem seus valores imediatos truncados em 32 bits.


.. _umlinst-break:

BREAK
~~~~~

Se estiver conectado, entre no depurador do host. Se nenhum depurador do
host estiver conectado, não ocorrerá efeito ou travamento, o que
dependerá do sistema e da configuração do host. Trata-se de uma ajuda
para desenvolvedores e não deve ser incluído no código final.

+-----------------+-----------------------+
| Disassembly     | Utilização            |
+=================+=======================+
| .. code-block:: | .. code-block:: C++   |
|                 |                       |
|     break       |     UML_BREAK(block); |
+-----------------+-----------------------+

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. raw:: latex

	\clearpage


.. _umlinst-control:

Condição geral e controle
-------------------------

.. _umlinst-set:

SET
~~~

Defina condicionalmente o inteiro como zero ou um, dependendo dos
sinalizadores.

+----------------------+----------------------------------+
| Disassembly          | Utilização                       |
+======================+==================================+
| .. code-block::      | .. code-block:: C++              |
|                      |                                  |
|     set     dst,cond |     UML_SETc(block, dst);        |
|     dset    dst,cond |     UML_DSETc(block, cond, dst); |
+----------------------+----------------------------------+

Operandos
^^^^^^^^^

dst (32-bit or 64-bit – memória, registro inteiro)
    O destino será definido como zero (0) se a condição não for
    atendida, ou como um (1) se for.
cond (condição)
    Uma condição que será testada. O destino será definido como zero (0)
    se a condição não for atendida ou como um (1) se for.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|


.. _umlinst-carry:

CARRY
~~~~~

Define o sinalizador de transporte.

+---------------------+----------------------------------+
| Disassembly         | Utilização                       |
+=====================+==================================+
| .. code-block::     | .. code-block::                  |
|                     |                                  |
|     carry   src,bit |     UML_CARRY(block, src, bit);  |
|     dcarry  src,bit |     UML_DCARRY(block, src, bit); |
+---------------------+----------------------------------+

Operandos
^^^^^^^^^

src |36mriivm|
    Um valor inteiro contendo um bit que será copiado para o sinalizador
    de transporte.
bit |36mriivm|
    O índice do bit que será copiado para o sinalizador de transporte.
    Os bits são numerados começando em zero para a posição do bit menos
    significativo, ascendendo em direção à posição do bit mais
    significativo. Apenas os cinco ou seis bits menos significativos
    deste operando são usados, a depender do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    Define o valor do bit selecionado do operando **src**.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* O valor imediato do operando **src** é truncado para o tamanho da
  instrução.
* Os valores imediatos para o operando **bit** são truncados para cinco
  ou seis bits para operandos de 32 ou 64 bits, respectivamente.


.. _umlinst-setflgs:

SETFLGS
~~~~~~~

Define os sinais de forma aleatória.

+-----------------+-------------------------------+
| Disassembly     | Utilização                    |
+=================+===============================+
| .. code-block:: | .. code-block::               |
|                 |                               |
|     setflgs src |     UML_SETFLGS(block, src);  |
+-----------------+-------------------------------+

Os cinco bits menos significativos do valor do operando **src** são
copiados para os sinalizadores. Começando pela posição do bit menos
significativo, os bits são copiados para os sinalizadores **carry (C)**,
**overflow (V)**, **zero (Z)**, **sign (S)** e **unordered (U)**.


Operando
^^^^^^^^

src |3mriivm|
    O Valor a ser copiado para os sinalizadores. Apenas os cinco bits
    menos significativos deste operando são usados.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    Define o valor do bit **0** do operando **src**, contando a partir
    do bit menos significativo, começando por zero.
overflow (V)
    Define o valor do bit **1** do operando **src**, contando a partir
    do bit menos significativo, começando por zero.
zero (Z)
    Define o valor do bit **2** do operando **src**, contando a partir
    do bit menos significativo, começando por zero.
sign (S)
    Define o valor do bit **3** do operando **src**, contando a partir
    do bit menos significativo, começando por zero.
unordered (U)
    Define o valor do bit **4** do operando **src**, contando a partir
    do bit menos significativo, começando por zero.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.

.. _umlinst-getflgs:

GETFLGS
~~~~~~~

Copia sinalizadores.

+----------------------+------------------------------------+
| Disassembly          | Utilização                         |
+======================+====================================+
| .. code-block::      | .. code-block:: C++                |
|                      |                                    |
|     getflgs dst,mask |     UML_GETFLGS(block, dst, mask); |
+----------------------+------------------------------------+

As posições de bits correspondentes no operando **mask** são copiadas
para as posições de bits correspondentes em **dst**. As posições de bits
em **dst** que correspondem a sinalizadores ou a posições de bits que
estão desmarcadas em **mask** são desmarcadas.

Os back-ends podem ser capazes de gerar código mais eficiente se menos
posições de bits estiverem definidas em **mask**.

Operandos
^^^^^^^^^

src |3mfpr|
    O destino para onde serão copiados os sinais correspondentes às
    posições de bits definidas no operando **mask**.
mask (máscara do sinalizador – imediato, variável de mapa)
    Especifica quais sinalizadores copiar usando a máscara. Apenas os
    cinco bits menos significativos deste operando são usados.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-setfmod:

SETFMOD
~~~~~~~

Define o modo predefinido de arredondamento do ponto flutuante. Esse
modo é utilizado para operações aritméticas de ponto flutuante e para a
conversão de ponto flutuante para inteiro, quando **ROUND_DEFAULT** for
especificado.

+-------------------+--------------------------------+
| Disassembly       | Utilização                     |
+===================+================================+
| .. code-block::   | .. code-block:: C++            |
|                   |                                |
|     setfmod round |     UML_SETFMOD(block, round); |
+-------------------+--------------------------------+

Operando
^^^^^^^^

round |3mriivm|
    O modo de arredondamento para definir como padrão. Apenas os dois
    bits menos significativos do valor são utilizados. |rrrr|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-getfmod:

GETFMOD
~~~~~~~

Obtém o modo predefinido de arredondamento de ponto flutuante atual,
definido pela instrução :ref:`SETFMOD <umlinst-setfmod>` mais recente.

+-----------------+------------------------------+
| Disassembly     | Utilização                   |
+=================+==============================+
| .. code-block:: | .. code-block:: C++          |
|                 |                              |
|     getfmod dst |     UML_GETFMOD(block, dst); |
+-----------------+------------------------------+

Observe que o resultado dessa instrução pode não corresponder ao modo de
arredondamento predefinido entre a inserção do código gerado e a
execução da primeira instrução :ref:`SETFMOD <umlinst-setfmod>`.

Operando
^^^^^^^^

dst |3mfpr|
    O destino predefinido onde o modo de arredondamento atual será
    armazenado. |rrrr2|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-restore:

RESTORE
~~~~~~~

Define o conteúdo dos registros inteiros e de ponto flutuante UML, o
conteúdo do registro **EXP**, os sinalizadores e o modo padrão de
arredondamento de ponto flutuante a partir da estrutura
``drcuml_machine_state``.

+-----------------+------------------------------+
| Disassembly     | Utilização                   |
+=================+==============================+
| .. code-block:: | .. code-block:: C++          |
|                 |                              |
|     restore src |     UML_RESTORE(block, src); |
+-----------------+------------------------------+

Restaura o estado UML visível do programa a partir de uma estrutura na
memória. A pilha das chamadas de sub-rotinas e o ponteiro da instrução
atual não são alterados. A execução continua com a instrução UML
seguinte.

Operando
^^^^^^^^

src (``drcuml_machine_state`` estrutura – memória)
    A fonte que será usada para definir o estado da máquina UML visível
    ao programa. Pode ser qualquer local da memória do host acessível
    pelo aplicativo. Não está restrito ao cache do recompilador.

Sinalização
^^^^^^^^^^^

carry (C)
    |dpos|.
overflow (V)
    |dpos|.
zero (Z)
    |dpos|.
sign (S)
    |dpos|.
unordered (U)
    |dpos|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-save:

SAVE
~~~~

Copia o conteúdo dos registros inteiros e de ponto flutuante UML, o
conteúdo do registro **EXP**, os sinalizadores e o modo padrão de
arredondamento de ponto flutuante para uma estrutura
``drcuml_machine_state``.

+-----------------+---------------------------+
| Disassembly     | Utilização                |
+=================+===========================+
| .. code-block:: | .. code-block:: C++       |
|                 |                           |
|     save    dst |     UML_SAVE(block, dst); |
+-----------------+---------------------------+

Salva o estado UML visível do programa em uma estrutura na memória que
pode ser restaurada posteriormente usando a instrução
:ref:`RESTORE <umlinst-restore>`. A pilha de chamadas das sub-rotinas e
o ponteiro da instrução atual não são salvas.

Observe que o modo de arredondamento de ponto flutuante salvo pode não
corresponder ao modo de arredondamento padrão efetivo real entre a
entrada do código gerado e a execução da primeira instrução
:ref:`SETFMOD <umlinst-setfmod>` ou :ref:`RESTORE <umlinst-restore>`.

Operando
^^^^^^^^

dst (``drcuml_machine_state`` estrutura – memória)
    O destino onde o estado da máquina UML visível pelo programa será
    salvo. Pode ser qualquer local da memória do host acessível pelo
    aplicativo. Não está restrito ao cache do recompilador.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. raw:: latex

	\clearpage


.. _umlinst-datamove:

Movimentação de dados
---------------------

.. _umlinst-mov:

MOV
~~~

Copia um valor inteiro.

+--------------------------+---------------------------------------+
| Disassembly              | Utilização                            |
+==========================+=======================================+
| .. code-block::          | .. code-block:: C++                   |
|                          |                                       |
|     mov     dst,src      |     UML_MOV(block, dst, src);         |
|     mov     dst,src,cond |     UML_MOVc(block, cond, dst, src);  |
|     dmov    dst,src      |     UML_DMOV(block, dst, src);        |
|     dmov    dst,src,cond |     UML_DMOVc(block, cond, dst, src); |
+--------------------------+---------------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    |odpo|.
src |36mriivm|
    |ovdo|.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que o
    valor seja copiado. Se a condição não for atendida, a instrução não
    terá efeito.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* O operando **src** tem seus valores imediatos truncados para o tamanho
  da instrução.
* A conversão em :ref:`NOP <umlinst-nop>` é feita quando os operandos
  **src** e **dst** referem-se ao mesmo local de memória ou registro e o
  tamanho da instrução for menor que o tamanho do destino.


.. _umlinst-fmov:

FMOV
~~~~

Copia um valor de ponto flutuante. O valor binário será preservado,
mesmo que não seja uma representação válida de um número de ponto
flutuante.

+--------------------------+----------------------------------------+
| Disassembly              | Utilização                             |
+==========================+========================================+
| .. code-block::          | .. code-block:: C++                    |
|                          |                                        |
|     fsmov   dst,src      |     UML_FSMOV(block, dst, src);        |
|     fsmov   dst,src,cond |     UML_FSMOVc(block, cond, dst, src); |
|     fdmov   dst,src      |     UML_FDMOV(block, dst, src);        |
|     fdmov   dst,src,cond |     UML_FDMOVc(block, cond, dst, src); |
+--------------------------+----------------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    |odpo|.
src |36mrpf|
    |ovdo|.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que o
    valor seja copiado. Se a condição não for atendida, a instrução não
    terá efeito.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* Se ambos os operandos **src** e **dst** se referirem ao mesmo local de
  memória ou registro, a operação será convertida em
  :ref:`NOP <umlinst-nop>`.


.. _umlinst-fcopyi:

FCOPYI
~~~~~~

Reinterpreta um valor de ponto flutuante como um valor inteiro. O valor
binário será preservado, mesmo que não seja uma representação válida de
um número de ponto flutuante.

+---------------------+-----------------------------------+
| Disassembly         | Utilização                        |
+=====================+===================================+
| .. code-block::     | .. code-block:: C++               |
|                     |                                   |
|     fscopyi dst,src |     UML_FSCOPYI(block, dst, src); |
|     fdcopyi dst,src |     UML_FDCOPYI(block, dst, src); |
+---------------------+-----------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    |odpo|.
src |36mri|
    |ovdo|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-icopyf:

ICOPYF
~~~~~~

Reinterpreta um valor de ponto flutuante como um valor inteiro. O valor
binário será preservado, mesmo que não seja uma representação válida de
um número de ponto flutuante.

+---------------------+-----------------------------------+
| Disassembly         | Utilização                        |
+=====================+===================================+
| .. code-block::     | .. code-block:: C++               |
|                     |                                   |
|     icopyfs dst,src |     UML_ICOPYFS(block, dst, src); |
|     icopyfd dst,src |     UML_ICOPYFD(block, dst, src); |
+---------------------+-----------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    |odpo|.
src |36mrpf|
    |ovdo|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-load:

LOAD
~~~~

Carrega um valor inteiro de um local da memória com deslocamento
variável. O valor é estendido a zero até atingir o tamanho do destino.
As regras do sistema anfitrião para o alinhamento de inteiros devem ser
seguidas.

+---------------------------------------+------------------------------------------------------+
| Disassembly                           | Utilização                                           |
+=======================================+======================================================+
| .. code-block::                       | .. code-block:: C++                                  |
|                                       |                                                      |
|     load    dst,base,index,size_scale |     UML_LOAD(block, dst, base, index, size, scale);  |
|     dload   dst,base,index,size_scale |     UML_DLOAD(block, dst, base, index, size, scale); |
+---------------------------------------+------------------------------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    |dovl|.
base (memória)
    |ebrm|.
index |3mriivm|
    |bpce|.
size (tamanho do acesso)
    |tvsl|.
scale (escala do índice)
    |feao|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-loads:

LOADS
~~~~~

Carrega um valor inteiro assinado de um local de memória com
deslocamento variável. O valor é estendido por sinal até atingir o
tamanho do destino. As regras do sistema anfitrião para alinhamento de
inteiros devem ser seguidas.

+---------------------------------------+-------------------------------------------------------+
| Disassembly                           | Utilização                                            |
+=======================================+=======================================================+
| .. code-block::                       | .. code-block:: C++                                   |
|                                       |                                                       |
|     loads   dst,base,index,size_scale |     UML_LOADS(block, dst, base, index, size, scale);  |
|     dloads  dst,base,index,size_scale |     UML_DLOADS(block, dst, base, index, size, scale); |
+---------------------------------------+-------------------------------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    |dovl|.
base (memória)
    |ebrm|.
index |3mriivm|
    |bpce|.
size (tamanho do acesso)
    |tvsl|.
scale (escala do índice)
    |feao|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-store:

STORE
~~~~~

Um valor inteiro é armazenado em um local de memória com deslocamento
variável. As regras do sistema anfitrião para alinhamento de números
inteiros devem ser seguidas.

+---------------------------------------+-------------------------------------------------------+
| Disassembly                           | Utilização                                            |
+=======================================+=======================================================+
| .. code-block::                       | .. code-block:: C++                                   |
|                                       |                                                       |
|     store   base,index,src,size_scale |     UML_STORE(block, base, index, src, size, scale);  |
|     dstore  base,index,src,size_scale |     UML_DSTORE(block, base, index, src, size, scale); |
+---------------------------------------+-------------------------------------------------------+

Operandos
^^^^^^^^^

base (memória)
    |ebre|.
index |3mriivm|
    |bpce|.
src |36mriivm|
    |ovse|.
size (tamanho do acesso)
    |tvsr|.
scale (escala do índice)
    |feao|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-fload:

FLOAD
~~~~~

Carrega um valor de ponto flutuante de um local de memória com
deslocamento variável. O valor binário será preservado mesmo que não
seja uma representação válida de um número de ponto flutuante. As
regras do sistema anfitrião para alinhamento de acesso à memória devem
ser seguidas.

+----------------------------+------------------------------------------+
| Disassembly                | Utilização                               |
+============================+==========================================+
| .. code-block::            | .. code-block:: C++                      |
|                            |                                          |
|     fsload  dst,base,index |     UML_FSLOAD(block, dst, base, index); |
|     fdload  dst,base,index |     UML_FDLOAD(block, dst, base, index); |
+----------------------------+------------------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    |dovl|.
base (memória)
    |ebrm|.
index |3mriivm|
    |ebce|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-fstore:

FSTORE
~~~~~~

Um valor de ponto flutuante é armazenado em uma região da memória com
deslocamento variável. O valor binário será preservado mesmo que não
seja uma representação válida de um número de ponto flutuante. As regras
do sistema anfitrião para alinhamento de acesso à memória devem ser
seguidas.

+----------------------------+-------------------------------------------+
| Disassembly                | Utilização                                |
+============================+===========================================+
| .. code-block::            | .. code-block:: C++                       |
|                            |                                           |
|     fsstore base,index,src |     UML_FSSTORE(block, base, index, src); |
|     fdstore base,index,src |     UML_FDSTORE(block, base, index, src); |
+----------------------------+-------------------------------------------+


.. raw:: latex

	\clearpage


Operandos
^^^^^^^^^

base (memória)
    |ebre|.
index |3mriivm|
    |ebcr|.
src |36mrpf|
    |ovse|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-getexp:

GETEXP
~~~~~~

Copia o valor do registro **EXP**. O registro **EXP** pode ser definido
pela instrução :ref:`EXH <umlinst-exh>`.

+-----------------+-----------------------------+
| Disassembly     | Utilização                  |
+=================+=============================+
| .. code-block:: | .. code-block:: C++         |
|                 |                             |
|     getexp  dst |     UML_GETEXP(block, dst); |
+-----------------+-----------------------------+

Operando
^^^^^^^^

dst (32-bit – memória, registro inteiro)
    O destino para onde o valor do registro **EXP** deve ser copiado.
    Observe que o registro **EXP** só pode conter um valor de 32 bits.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-mapvar:

MAPVAR
~~~~~~

O valor de uma variável de mapa é definido a partir do local atual,
conforme o bloco de código gerado.

+--------------------------+---------------------------------------+
| Disassembly              | Utilização                            |
+==========================+=======================================+
| .. code-block::          | .. code-block:: C++                   |
|                          |                                       |
|     mapvar  mapvar,value |     UML_MAPVAR(block, mapvar, value); |
+--------------------------+---------------------------------------+

Operandos
^^^^^^^^^

mapvar (variável de mapa)
    O valor para definir a variável de mapa.
value (32-bit – imediato, variável de mapa)
    O valor para definir a variável de mapa. Observe que as variáveis de
    mapa só podem conter valores de 32 bits.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. _umlinst-recover:

RECOVER
~~~~~~~

Recupera o valor de uma variável de mapa no local da instrução invocada
no quadro de código gerado mais externo. Esta instrução só deve ser
usada dentro de uma subrotina gerada por código. Se executada fora de
qualquer sub-rotina gerada por código, os resultados serão indefinidos.

+------------------------+--------------------------------------+
| Disassembly            | Utilização                           |
+========================+======================================+
| .. code-block::        | .. code-block:: C++                  |
|                        |                                      |
|     recover dst,mapvar |     UML_RECOVER(block, dst, mapvar); |
+------------------------+--------------------------------------+

Operandos
^^^^^^^^^

dst (32-bit – memória, registro inteiro)
    O destino para copiar o valor da variável de mapa. Observe que as
    variáveis de mapa só podem conter valores de 32 bits.
mapvar (variável de mapa)
    A variável de mapa para recuperar o valor do quadro de código gerado
    mais externo.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. raw:: latex

	\clearpage


.. _umlinst-memaccess:

Acesso à memória emulada
------------------------


.. _umlinst-read:

READ
~~~~

Lê de uma região da memória emulada. |askd|.

+---------------------------------+-----------------------------------------------+
| Disassembly                     | Utilização                                    |
+=================================+===============================================+
| .. code-block::                 | .. code-block:: C++                           |
|                                 |                                               |
|     read    dst,addr,space_size |     UML_READ(block, dst, addr, size, space);  |
|     dread   dst,addr,space_size |     UML_DREAD(block, dst, addr, size, space); |
+---------------------------------+-----------------------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    |dove|.
addr |3mriivm|
    O endereço que será lido no espaço de endereço emulado. |ok32|.
size (tamanho do acesso)
    O tamanho do acesso à memória emulada. Deve ser um dos seguintes
    valores: **SIZE_BYTE** (8 bits), **SIZE_WORD** (16 bits),
    **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits). Observe que
    esse operando controla o tamanho do acesso à memória emulada,
    enquanto o tamanho da instrução define o tamanho do operando
    **dst**.
space (número do espaço de endereço)
    |unii|.


Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.


.. _umlinst-readm:

READM
~~~~~

Lê de um espaço de endereço emulado com a máscara de acesso
especificada.

+--------------------------------------+------------------------------------------------------+
| Disassembly                          | Utilização                                           |
+======================================+======================================================+
| .. code-block::                      | .. code-block:: C++                                  |
|                                      |                                                      |
|     readm   dst,addr,mask,space_size |     UML_READM(block, dst, addr, mask, size, space);  |
|     dreadm  dst,addr,mask,space_size |     UML_DREADM(block, dst, addr, mask, size, space); |
+--------------------------------------+------------------------------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor lido do espaço da memória emulada que será
    armazenado.
addr |3mriivm|
    O endereço do espaço da memória emulada que será lido. |ok32|.
mask |36mriivm|
    A máscara de acesso para o acesso à memória emulada.
size (tamanho do acesso)
    O tamanho do acesso à memória emulada. Deve ser um dos seguintes
    valores: **SIZE_BYTE** (8 bits), **SIZE_WORD** (16 bits),
    **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits). Observe que
    esse operando controla o tamanho do acesso à memória emulada,
    enquanto o tamanho da instrução define o tamanho dos operandos
    **dst** e **mask**.
space (número do espaço de endereço)
    |unii|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. raw:: latex

	\clearpage


Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.
* |oask|.
* A conversão para :ref:`READ <umlinst-read>` ocorre se o operando
  **mask** tiver um valor imediato com todos os bits definidos.


.. _umlinst-write:

WRITE
~~~~~

Escreve em um espaço de endereço emulado. |askd|.

+---------------------------------+------------------------------------------------+
| Disassembly                     | Utilização                                     |
+=================================+================================================+
| .. code-block::                 | .. code-block:: C++                            |
|                                 |                                                |
|     write   addr,src,space_size |     UML_WRITE(block, addr, src, size, space);  |
|     dwrite  addr,src,space_size |     UML_DWRITE(block, addr, src, size, space); |
+---------------------------------+------------------------------------------------+

Operandos
^^^^^^^^^

addr |3mriivm|
    O endereço do espaço da memória emulada que será escrito. |ok32|.
src |36mriivm|
    O valor que será escrito no espaço de endereço emulado.
size (tamanho do acesso)
    O tamanho do acesso à memória emulada. Deve ser um dos seguintes
    valores: **SIZE_BYTE** (8 bits), **SIZE_WORD** (16 bits),
    **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits). Observe que
    esse operando controla o tamanho do acesso à memória emulada,
    enquanto o tamanho da instrução define o tamanho do operando
    **src**.
space (número do espaço de endereço)
    |unii|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.
* Os valores imediatos do operando **src** são truncados para o tamanho
  do acesso.


.. _umlinst-writem:

WRITEM
~~~~~~

Escreve em um espaço de endereço emulado com a máscara de acesso que foi
especificada.

+--------------------------------------+-------------------------------------------------------+
| Disassembly                          | Utilização                                            |
+======================================+=======================================================+
| .. code-block::                      | .. code-block:: C++                                   |
|                                      |                                                       |
|     writem  addr,src,mask,space_size |     UML_WRITEM(block, addr, src, mask, size, space);  |
|     dwritem addr,src,mask,space_size |     UML_DWRITEM(block, addr, src, mask, size, space); |
+--------------------------------------+-------------------------------------------------------+

Operandos
^^^^^^^^^

addr |3mriivm|
    O endereço do espaço da memória emulada que será escrito. |ok32|.
src |36mriivm|
    O valor que será escrito no espaço de endereço emulado.
mask |36mriivm|
    A máscara de acesso para o acesso à memória emulada.
size (tamanho do acesso)
    O tamanho do acesso à memória emulada. Deve ser um dos seguintes
    valores: **SIZE_BYTE** (8 bits), **SIZE_WORD** (16 bits),
    **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits). Observe que
    esse operando controla o tamanho do acesso à memória emulada,
    enquanto o tamanho da instrução define o tamanho dos operandos
    **src** e **mask**.
space (número do espaço de endereço)
    |unii|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.
* Os valores imediatos dos operandos **src** e **mask** são truncados
  para o tamanho do acesso.
* A conversão para :ref:`WRITE <umlinst-read>` ocorre se o operando
  **mask** tiver um valor imediato com todos os bits definidos.


.. _umlinst-fread:

FREAD
~~~~~

Lê um valor de ponto flutuante a partir de um espaço de endereço
emulado. O valor binário será preservado mesmo que não se trate de uma
representação válida de um número de ponto flutuante. |askd|.

+---------------------------------+------------------------------------------+
| Disassembly                     | Utilização                               |
+=================================+==========================================+
| .. code-block::                 | .. code-block:: C++                      |
|                                 |                                          |
|     fsread  dst,addr,space_size |     UML_FSREAD(block, dst, addr, space); |
|     fdread  dst,addr,space_size |     UML_FDREAD(block, dst, addr, space); |
+---------------------------------+------------------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o valor lido do espaço de endereço emulado será
    armazenado.
addr |3mriivm|
    O endereço que será lido no espaço de endereço emulado. |ok32|.
space (número do espaço de endereço)
    |unii|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.


.. raw:: latex

	\clearpage


Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.


.. _umlinst-fwrite:

FWRITE
~~~~~~

Grava um valor de ponto flutuante num espaço de endereço emulado. O
valor binário será preservado mesmo que não se trate de uma
representação válida de um número de ponto flutuante. |askd|.

+---------------------------------+-------------------------------------------+
| Disassembly                     | Utilização                                |
+=================================+===========================================+
| .. code-block::                 | .. code-block:: C++                       |
|                                 |                                           |
|     fswrite addr,src,space_size |     UML_FSWRITE(block, addr, src, space); |
|     fdwrite addr,src,space_size |     UML_FDWRITE(block, addr, src, space); |
+---------------------------------+-------------------------------------------+

Operandos
^^^^^^^^^

addr |3mriivm|
    O endereço para gravação no espaço de endereço emulado. |ok32|.
src |36mrpf|
    O valor que será escrito no espaço de endereço emulado.
space (número do espaço de endereço)
    |unii|.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |ucg|.
overflow (V)
    |ucg|.
zero (Z)
    |ucg|.
sign (S)
    |ucg|.
unordered (U)
    |ucg|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.


.. raw:: latex

	\clearpage


.. _umlinst-intarith:

Aritmética e lógica de números inteiros
---------------------------------------


.. _umlinst-add:

ADD
~~~

Adiciona dois inteiros.

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block:: C++                   |
|                           |                                       |
|     add     dst,src1,src2 |     UML_ADD(block, dst, src1, src2);  |
|     dadd    dst,src1,src2 |     UML_DADD(block, dst, src1, src2); |
+---------------------------+---------------------------------------+

Calcula ``dst = src1 + src2``

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor da soma será armazenado.
src1 |36mriivm|
    O primeiro que será adicionado.
src2 |36mriivm|
    O segundo que será adicionado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido no caso de um transporte aritmético do bit mais
    significativo ou quando ele é apagado (estouro sem sinal).
overflow (V)
    É definido no caso de um estouro de complemento de dois assinados
    |occl|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido para o valor do bit mais significativo do resultado (a
    definição ocorre quando o resultado for um inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`
  ou :ref:`OR <umlinst-or>` ocorre se ambos os operandos |sr1sr2| forem
  valores imediatos e os sinalizadores de transporte e estouro não forem
  mais necessários.
* A conversão para :ref:`MOV <umlinst-mov>` ou :ref:`AND <umlinst-and>`
  ocorre se o operando **src1** ou o operando **src2** for zero e os
  sinalizadores de transporte e estouro não forem mais necessários.
* |truncar|.
* |intercambio|.
* Se o operando **src1** for um valor imediato e o operando **src2**
  não for, os operandos serão intercambiados.


.. _umlinst-addc:

ADDC
~~~~

Soma dois números inteiros e o sinalizador de transporte.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block:: C++                    |
|                           |                                        |
|     addc    dst,src1,src2 |     UML_ADDC(block, dst, src1, src2);  |
|     daddc   dst,src1,src2 |     UML_DADDC(block, dst, src1, src2); |
+---------------------------+----------------------------------------+

Calcula ``dst = src1 + src2 + C``

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde a soma será armazenada.
src1 |36mriivm|
    O primeiro que será adicionado.
src2 |36mriivm|
    O segundo que será adicionado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    No caso de aritmética, é definido o bit mais significativo |occl|
    (estouro não assinado).
overflow (V)
    É definido no caso de estouro do complemento de dois assinado, |occl|.
zero (Z)
    É definido caso o resultado seja zero, |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um inteiro negativo assinado, |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* Os valores imediatos dos operandos |sr1sr2| são truncados para o
  tamanho da instrução.
* |intercambio|.
* Se o operando **src1** for um valor imediato e o operando **src2**
  não for, ambos serão intercambiados.


.. _umlinst-sub:

SUB
~~~

Subtrai um número inteiro de outro número inteiro.

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block:: C++                   |
|                           |                                       |
|     sub     dst,src1,src2 |     UML_SUB(block, dst, src1, src2);  |
|     dsub    dst,src1,src2 |     UML_DSUB(block, dst, src1, src2); |
+---------------------------+---------------------------------------+

Calcula ``dst = src1 - src2``

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde a diferença será armazenada.
src1 |36mriivm|
    O minuendo (o valor que será subtraído).
src2 |36mriivm|
    O subtraendo (o valor que será subtraído do minuendo).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido se o subtraendo for um valor sem sinal maior que o
    minuendo |occl| (estouro sem sinal ou empréstimo aritmético).
overflow (V)
    É definido no caso de estouro do complemento de dois assinados
    |occl|.
zero (Z)
    O resultado é definido se for zero, ou, caso contrário, é desmarcado
    (a definição ocorre quando o minuendo e o subtraendo forem iguais
    |occl|).
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um inteiro negativo assinado |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* Os valores imediatos dos operandos |sr1sr2| são truncados para o
  tamanho da instrução.
* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`
  ou :ref:`OR <umlinst-or>` ocorre se ambos os operandos |sr1sr2| forem
  valores imediatos e os sinalizadores de transporte e estouro não forem
  mais necessários.
* A conversão para :ref:`MOV <umlinst-mov>` ou :ref:`AND <umlinst-and>`
  ocorre se o operando **src2** for zero e o sinalizador de transporte e
  estouro não forem mais necessários.


.. _umlinst-subb:

SUBB
~~~~

Subtrai um inteiro e o sinalizador de transporte de outro inteiro.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block:: C++                    |
|                           |                                        |
|     subb    dst,src1,src2 |     UML_SUBB(block, dst, src1, src2);  |
|     dsubb   dst,src1,src2 |     UML_DSUBB(block, dst, src1, src2); |
+---------------------------+----------------------------------------+

Calcula ``dst = src1 - src2 - C``

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde a diferença será armazenada.
src1 |36mriivm|
    O minuendo (o valor que será subtraído).
src2 |36mriivm|
    O subtraendo (o valor que será subtraído do minuendo).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido se o subtraendo mais o sinalizador de transporte for um
    valor sem sinal maior do que o minuendo |occl| (estouro sem sinal ou
    empréstimo aritmético).
overflow (V)
    É definido no caso de um estouro de complemento de dois assinados
    |occl|.
zero (Z)
    É definido caso o resultado seja zero |occl| (a definição ocorre
    quando o minuendo for igual ao subtraendo mais o sinalizador de
    transporte |occl|).
sign (S)
    É definido para o valor do bit mais significativo do resultado (a
    definição ocorre quando o resultado for um inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* Os valores imediatos dos operandos |sr1sr2| são truncados para o
  tamanho da instrução.


.. raw:: latex

	\clearpage


.. _umlinst-cmp:

CMP
~~~

Compara dois números inteiros e defina os sinalizadores como se eles
tivessem sido subtraídos.

+-----------------------+----------------------------------+
| Disassembly           | Utilização                       |
+=======================+==================================+
| .. code-block::       | .. code-block:: C++              |
|                       |                                  |
|     cmp     src1,src2 |     UML_CMP(block, src1, src2);  |
|     dcmp    src1,src2 |     UML_DCMP(block, src1, src2); |
+-----------------------+----------------------------------+

Os sinalizadores são definidos com base no cálculo de **src1 - src2**,
mas o resultado da subtração é descartado.


Operandos
^^^^^^^^^

src1 |36mriivm|
    O valor do lado esquerdo que será comparado, ou o minuendo (o valor
    que será subtraído).
src2 |36mriivm|
    O valor do lado direito que será comparado, ou o subtraendo (o valor
    que será subtraído do minuendo).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido se o valor não assinado do operando **src1** for menor
    que o valor não assinado do operando **src2** |occl|.
overflow (V)
    É definido se a subtração do valor do operando **src2** do valor do
    operando **src1** resultar em um estouro de complemento de dois
    |occl|.
zero (Z)
    É definido se os valores dos operandos |sr1sr2| forem iguais |occl|.
sign (S)
    É definido como o valor do bit mais significativo do resultado da
    subtração do valor do operando **src2** a partir do valor do
    operando **src1** (a definição ocorre quando o resultado for um
    inteiro negativo assinado |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`NOP <umlinst-nop>` ocorre quando mais nenhum
  sinalizador for necessário.
* Os valores imediatos dos operandos |sr1sr2| são truncados para o
  tamanho da instrução.


.. _umlinst-and:

AND
~~~

Calcula a conjunção lógica bit a bit de dois números inteiros (os bits
do resultado serão definidos se os bits correspondentes estiverem
definidos em ambas as entradas).

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block:: C++                   |
|                           |                                       |
|     and     dst,src1,src2 |     UML_AND(block, dst, src1, src2);  |
|     dand    dst,src1,src2 |     UML_DAND(block, dst, src1, src2); |
+---------------------------+---------------------------------------+

Calcula ``dst = src1 & src2``

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde a conjunção lógica será armazenada.
src1 |36mriivm|
    Primeira entrada.
src2 |36mriivm|
    Segunda entrada.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um inteiro negativo assinado |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^
* A conversão para :ref:`MOV <umlinst-mov>` ocorre se ambos os operandos
  |sr1sr2| se referirem ao mesmo local de memória ou registro, se ambos
  tiverem valores imediatos, ou se um dos operandos for um valor
  imediato com ou sem todos os bits definidos, e se os sinalizadores não
  forem mais necessários.
* A conversão para :ref:`OR <umlinst-or>` ocorre se ambos os operandos
  |sr1sr2| tiverem valores imediatos com todos os bits definidos e os
  sinalizadores forem necessários.
* A conversão para :ref:`TEST <umlinst-test>` ocorre se o tamanho da
  instrução for de 64 bits ou se o operando **dst** se referir a um
  local de memória, um dos operandos |sr1sr2| se referir ao mesmo local
  de memória ou registro que o operando **dst**, o outro operando de
  origem se referir ao mesmo local de memória, registro ou tiver um
  valor imediato com todos os bits definidos, e os sinalizadores forem
  necessários.
* Se ambos os operandos, |sr1sr2|, forem valores imediatos, a conjunção
  não for zero e os sinalizadores forem necessários. Neste caso,
  **src1** é substituído pela conjunção e os bits em **src2** será
  definido como um valor imediato com todos os bits definidos.
* Se ambos os operandos |sr1sr2| tiverem valores imediatos e a conjunção
  for zero ou se o operando **src1** ou **src2** tiver o valor imediato
  zero e precisarem de sinalizadores, o operando **src1** é definido
  para se referir ao mesmo local de memória ou registro onde **dst** e
  **src2** seja definido para zero.
* Os valores imediatos dos operandos |sr1sr2| são truncados para o
  tamanho da instrução.
* |intercambio|.
* Se o operando **src1** for um valor imediato e o operando **src2**
  não for, os operandos |sr1sr2| serão intercambiados.


.. _umlinst-test:

TEST
~~~~

Define os sinalizadores com base na conjunção lógica bit a bit de dois
números inteiros.

+-----------------------+-----------------------------------+
| Disassembly           | Utilização                        |
+=======================+===================================+
| .. code-block::       | .. code-block:: C++               |
|                       |                                   |
|     test    src1,src2 |     UML_TEST(block, src1, src2);  |
|     dtest   src1,src2 |     UML_DTEST(block, src1, src2); |
+-----------------------+-----------------------------------+

Define os sinalizadores com base no cálculo dos operandos **src1** e
**src2**, mas descarta o resultado da conjunção.

Operandos
^^^^^^^^^

src1 |36mriivm|
    Primeira entrada.
src2 |36mriivm|
    Segunda entrada.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido se o resultado da conjunção for zero |occl|.
sign (S)
    É definido se o bit mais significativo estiver definido em ambas as
    entradas |occl| (a definição ocorre quando ambas as entradas tiverem
    valores inteiros com sinal negativo |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`NOP <umlinst-nop>` ocorre se os sinalizadores
  não forem mais necessários.
* Se ambos os operandos, |sr1sr2|, forem valores imediatos,
  a conjunção não for zero e os sinalizadores forem necessários. Neste
  caso, **src1** é substituído pela conjunção e os bits em **src2** será
  definido como um valor imediato com todos os bits definidos.
* Se o valor de qualquer um dos operandos |sr1sr2| for zero ou se ambos
  os operandos tiverem valores imediatos e a operação lógica bit a bit
  resultar em zero, os operandos |sr1sr2| serão definidos como o valor
  zero.
* Se ambos os operandos |sr1sr2| se referirem ao mesmo local de memória
  ou registro, o operando **src2** é definido como um valor imediato com
  todos os bits definidos.
* |truncar|.
* Se o operando **src1** for um valor imediato e o operando **src2**
  não for, os operandos |sr1sr2| serão intercambiados.


.. _umlinst-or:

OR
~~

Calcula a disjunção lógica inclusiva bit a bit de dois números inteiros
(os bits do resultado serão definidos se os bits correspondentes
estiverem definidos em qualquer uma das entradas).

+---------------------------+--------------------------------------+
| Disassembly               | Utilização                           |
+===========================+======================================+
| .. code-block::           | .. code-block:: C++                  |
|                           |                                      |
|     or      dst,src1,src2 |     UML_OR(block, dst, src1, src2);  |
|     dor     dst,src1,src2 |     UML_DOR(block, dst, src1, src2); |
+---------------------------+--------------------------------------+

Calcula ``dst = src1 | src2``

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde a disjunção inclusiva lógica será armazenada.
src1 |36mriivm|
    A primeira entrada.
src2 |36mriivm|
    A segunda entrada.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido para o valor do bit mais significativo do resultado (a
    definição ocorre quando o resultado for um inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>` ocorre se ambos os operandos
  |sr1sr2| ambos tiverem valores imediatos ou se um dos operandos
  **src1** ou **src2** for um valor imediato com todos os bits
  definidos e os sinalizadores não forem mais necessários.
* A conversão em :ref:`AND <umlinst-and>` ocorre se ambos os operandos
  |sr1sr2| tiverem valores imediatos e a disjunção inclusiva não tiver
  todos os bits definidos e os sinalizadores forem necessários.
* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`
  ou :ref:`TEST <umlinst-test>` ocorre  se qualquer um dos operandos
  |sr1sr2| tiver como referência mesmo local de memória ou registro, ou
  se um dos operandos |sr1sr2| tiver o valor imediato zero.
* Se um dos operandos |sr1sr2| for um valor imediato com todos os bits
  definidos ou se os operandos |sr1sr2| forem ambos valores imediatos e
  a disjunção inclusiva tiver todos os bits definidos e os sinalizadores
  forem necessários, o operando **src1** é definido para se referir ao
  mesmo local de memória ou registro que **dst**, já o operando **src2**
  é definido como um valor imediato com todos os bits definidos.
* |truncar|.
* |intercambio|.
* Se o operando **src1** for um valor imediato e o operando **src2**
  não for, os operandos |sr1sr2| serão intercambiados.


.. _umlinst-xor:

XOR
~~~

Calcula a disjunção lógica exclusiva bit a bit de dois números inteiros
(os bits do resultado serão definidos se o bit correspondente estiver
definido em uma entrada e não estiver definido na outra entrada).

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block:: C++                   |
|                           |                                       |
|     xor     dst,src1,src2 |     UML_XOR(block, dst, src1, src2);  |
|     dxor    dst,src1,src2 |     UML_DXOR(block, dst, src1, src2); |
+---------------------------+---------------------------------------+

Calcula ``dst = src1 ^ src2``

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde a disjunção exclusiva lógica será armazenada.
src1 |36mriivm|
    A primeira entrada.
src2 |36mriivm|
    A segunda entrada.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido para o valor do bit mais significativo do resultado (a
    definição ocorre quando o resultado for um inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`,
  :ref:`TEST <umlinst-test>` ou :ref:`OR <umlinst-or>` ocorre se ambos
  os operandos |sr1sr2| tiverem valores imediatos, se um dos operandos
  for zero ou se ambos os operandos se referirem ao mesmo local de
  memória ou registro.


.. _umlinst-sext:

SEXT
~~~~

Estende o sinal de um valor inteiro.

+--------------------------+---------------------------------------+
| Disassembly              | Utilização                            |
+==========================+=======================================+
| .. code-block::          | .. code-block::                       |
|                          |                                       |
|     sext    dst,src,size |     UML_SEXT(block, dst, src, size);  |
|     dsext   dst,src,size |     UML_DSEXT(block, dst, src, size); |
+--------------------------+---------------------------------------+

Define **dst** com o valor de **src**, estendendo-o para o tamanho
especificado pelo operando **size** para o tamanho da instrução.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor estendido do sinal será armazenado.
src |36mriivm|
    O valor que será estendido.
size (access size)
    O valor que será estendido.  Deve ser **SIZE_BYTE** (8-bit),
    **SIZE_WORD** (16-bit) ou **SIZE_DWORD** (32-bit).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido para o valor do bit mais significativo do resultado (a
    definição ocorre quando o resultado for um inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`
  ou :ref:`OR <umlinst-or>` ocorre  se o operando **src** for um valor
  imediato ou se o operando **size** especificar um tamanho não menor
  que o tamanho da instrução.


.. _umlinst-lzcnt:

LZCNT
~~~~~

Conta a quantidade de bits zero contíguos alinhados à esquerda em um
número inteiro (conta os zeros à esquerda).

+---------------------+----------------------------------+
| Disassembly         | Utilização                       |
+=====================+==================================+
| .. code-block::     | .. code-block:: C++              |
|                     |                                  |
|     lzcnt   dst,src |     UML_LZCNT(block, dst, src);  |
|     dlzcnt  dst,src |     UML_DLZCNT(block, dst, src); |
+---------------------+----------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o resultado será armazenado.
src |36mriivm|
    O valor de entrada onde será contado os bits com o zero alinhado à
    esquerda.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl| (é definido para o bit
    mais significativa da entrada).
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>` ou :ref:`AND <umlinst-and>`
  ocorre se o operando **src** for um valor imediato.


.. _umlinst-tzcnt:

TZCNT
~~~~~

Conta a quantidade de bits zero contíguos alinhados à direita em um
número inteiro (conta os zeros à direita).

+---------------------+----------------------------------+
| Disassembly         | Utilização                       |
+=====================+==================================+
| .. code-block::     | .. code-block:: C++              |
|                     |                                  |
|     tzcnt   dst,src |     UML_TZCNT(block, dst, src);  |
|     dtzcnt  dst,src |     UML_DTZCNT(block, dst, src); |
+---------------------+----------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o resultado será armazenado.
src |36mriivm|
    O valor de entrada onde será contado os bits com o zero alinhado à
    direita.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl| (é definido para o bit
    mais significativa da entrada).
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>` ou :ref:`AND <umlinst-and>`
  ocorre se o operando **src** for um valor imediato.


.. raw:: latex

	\clearpage


.. _umlinst-intmuldiv:

Multiplicação de inteiros e divisão
-----------------------------------


.. _umlinst-mullw:

MULLW
~~~~~

Multiplica dois valores inteiros.

+---------------------------+------------------------------------------+
| Disassembly               | Utilização                               |
+===========================+==========================================+
| .. code-block::           | .. code-block:: C++                      |
|                           |                                          |
|     mululw  dst,src1,src2 |     UML_MULULW(block, dst, src1, src2);  |
|     mulslw  dst,src1,src2 |     UML_MULSLW(block, dst, src1, src2);  |
|     dmululw dst,src1,src2 |     UML_DMULULW(block, dst, src1, src2); |
|     dmulslw dst,src1,src2 |     UML_DMULSLW(block, dst, src1, src2); |
+---------------------------+------------------------------------------+

Calcula ``dst = src1 * src2`` e produz um resultado do mesmo tamanho que
as entradas. As instruções MULULW e DMULULW recebem valores inteiros não
assinados como entrada e produzem um valor inteiro não assinado como
resultado. Já as instruções MULSLW e DMULSLW recebem valores inteiros
assinados como entrada e produzem um valor inteiro assinado como
resultado. É importante observar que a distinção entre valores assinados
e não assinados afeta apenas o cálculo do sinalizador de estouro para
esta instrução. Ela não afeta o resultado da multiplicação.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o resultado será armazenado.
src1 |36mriivm|
    O multiplicando (o valor que será multiplicado).
src2 |36mriivm|
    O multiplicador (o valor pelo qual multiplicar).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    É definido se o resultado completo da multiplicação não puder ser
    representada dentro do tamanho da instrução.
zero (Z)
    É definido caso o resultado seja zero |occl|. Observe que isso se
    baseia no valor do resultado possivelmente truncado, não no
    resultado completo da multiplicação.
sign (S)
    É definido para o valor do bit mais significativo do resultado (é
    definido se o resultado for um valor inteiro negativo assinado
    |occl|). Observe que isso se baseia no valor do resultado
    possivelmente truncado, não no resultado completo da multiplicação.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`
  ou :ref:`OR <umlinst-or>` ocorre  se ambos os operandos |sr1sr2|
  tiverem valores imediatos ou se o operando **src1** ou **src2** tiver
  um valor imediato zero ou um e o sinalizador de estouro não for
  mais necessário.
* |truncar|.
* |intercambio|.
* Se o operando **src1** for um valor imediato e o operando **src2**
  não for, os operandos |sr1sr2| serão intercambiados.


.. _umlinst-mul:

MUL
~~~

Multiplica dois valores inteiros, podendo produzir um resultado
estendido.

+--------------------------------+----------------------------------------------+
| Disassembly                    | Utilização                                   |
+================================+==============================================+
| .. code-block::                | .. code-block:: C++                          |
|                                |                                              |
|     mulu    dst,edst,src1,src2 |     UML_MULU(block, dst, edst, src1, src2);  |
|     muls    dst,edst,src1,src2 |     UML_MULS(block, dst, edst, src1, src2);  |
|     dmulu   dst,edst,src1,src2 |     UML_DMULU(block, dst, edst, src1, src2); |
|     dmuls   dst,edst,src1,src2 |     UML_DMULS(block, dst, edst, src1, src2); |
+--------------------------------+----------------------------------------------+

Calcula ``edst:dst = src1 * src2`` se os operandos **dst** e **edst**
não se referirem ao mesmo registro ou local de memória, ou
``dst = src1 * src2`` se os operandos **dst** e **edst** se referirem ao
mesmo registro ou local de memória. MULU e DMULU recebem valores
inteiros não assinados como entrada e produzem um valor inteiro não
assinado como resultado, enquanto MULS e DMULS recebem valores inteiros
assinados como entrada e produzem um valor inteiro assinado como
resultado.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde a metade menos significativa do produto completo será
    armazenada.
edst |36mri|
    O destino onde a metade mais significativa do produto completo será
    armazenada, caso esse operando não se refira ao mesmo local de
    memória ou registro que o operando **dst**. Caso se refira ao mesmo
    local de memória ou registro que o operando **dst**, a metade mais
    significativa do produto completo será descartada, produzindo um
    resultado do mesmo tamanho que as entradas.
src1 |36mriivm|
    O multiplicando (o valor que será multiplicado).
src2 |36mriivm|
    O multiplicador (o valor pelo qual multiplicar).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    Define se o resultado completo da multiplicação não puder ser
    representado dentro do tamanho da instrução.
zero (Z)
    Define se o resultado completo da multiplicação for zero |occl|.
    Observe que isso se baseia no resultado completo da multiplicação,
    mesmo quando os operandos **dst** e **edst** se referem ao mesmo
    local de memória ou registro, fazendo com que o resultado seja
    truncado.
sign (S)
    É definido com o valor do bit mais significativo do resultado
    completo da multiplicação (ou se o resultado for um valor assinado
    inteiro negativo |occl|). É importante observar que isso se baseia
    no resultado completo da multiplicação, mesmo quando os operandos
    |dsed| se referem ao mesmo local de memória ou registro, fazendo com
    que o resultado seja truncado.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MULLW <umlinst-mullw>` ocorre se os operandos
  **dst** e **edst** se referirem ao mesmo local de memória ou registro
  e se os sinalizadores zero e assinados não forem mais necessários.
* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`
  ou :ref:`OR <umlinst-or>` ocorre se os operandos **dst** e **edst** se
  referirem ao mesmo local de memória ou registro, se os operandos
  |sr1sr2| forem ambos valores imediatos ou se ambos os operandos forem
  zero, se a metade mais significativa do resultado completo da
  multiplicação for a extensão do sinal da metade menos significativa ou
  se o sinalizador assinado e o sinalizador de estouro não forem mais
  necessários.
* A conversão para :ref:`MOV <umlinst-mov>` ou :ref:`AND <umlinst-and>`
  ocorre se os operandos |dsed| se referirem ao mesmo local de memória
  ou registro, o operando **src1** ou **src2** for um valor imediato,
  uma multiplicação assinada estiver sendo realizada, o sinalizador
  assinado e o sinalizador de estouro não forem mais necessários.
* A conversão para :ref:`MOV <umlinst-mov>` ou :ref:`AND <umlinst-and>`
  ocorre se os operandos |dsed| tiverem como referência o mesmo local de
  memória ou registro; o operando **src1** ou **src2** for um valor
  imediato, uma multiplicação com assinada estiver sendo realizada, o
  sinalizador assinado e o sinalizador assinado de estouro não forem
  mais necessários.
* |truncar|.
* Se o operando **src1** for um valor imediato e o operando **src2**
  não for, os operandos |sr1sr2| serão intercambiados.


.. _umlinst-div:

DIV
~~~

Divide um valor inteiro por outro valor inteiro.

+--------------------------------+----------------------------------------------+
| Disassembly                    | Utilização                                   |
+================================+==============================================+
| .. code-block::                | .. code-block:: C++                          |
|                                |                                              |
|     divu    dst,edst,src1,src2 |     UML_DIVU(block, dst, edst, src1, src2);  |
|     divs    dst,edst,src1,src2 |     UML_DIVS(block, dst, edst, src1, src2);  |
|     ddivu   dst,edst,src1,src2 |     UML_DDIVU(block, dst, edst, src1, src2); |
|     ddivs   dst,edst,src1,src2 |     UML_DDIVS(block, dst, edst, src1, src2); |
+--------------------------------+----------------------------------------------+

Se o valor de **src2** não for zero, o valor de **src1** é dividido pelo
valor de **src2**. O quociente é armazenado no local de memória ou
registro referido por **dst**, e o resto é armazenado no local de
memória ou registro referido por **edst** se ambos os operandos |dsed|
não se referirem ao mesmo local de memória ou registro.

Se o valor de **src2** for zero, o sinalizador de estouro é definido e
os valores dos locais de memória ou registros a que os operandos |dsed|
tenham como referência são indefinidos.

DIVU e DDIVU aceitam entradas inteiras sem sinal e produzem saídas
inteiras sem sinal. DIVS e DDIVS aceitam entradas inteiras com sinal e
produzem saídas inteiras com sinal.

Operandos
^^^^^^^^^

dst |36mri|
    O destino será onde o quociente será armazenado se o valor do
    operando **src2** não for zero.
edst |36mri|
    O destino onde o valor restante será armazenado, caso o operando em
    questão não se refira ao mesmo local de memória, ao registro do
    operando **dst** se o valor do operando **src2** não seja zero.
src1 |36mriivm|
    O dividendo (o valor que será dividido).
src2 |36mriivm|
    O divisor (o valor pelo qual se divide).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    É definido se o divisor (o valor do operando **src2**) for zero
    |occl|.
zero (Z)
    É definido se o divisor (o valor do operando **src2**) não for zero
    e o quociente for |occl|.
sign (S)
    Define como o bit mais significativo do quociente (é definido se o
    quociente for um valor inteiro assinado negativo) se o divisor (o
    valor do operando **src2**) não for zero |occl|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` acontece quando os operandos |dsed| tiverem
  como referência o mesmo local de memória ou registro, os operandos
  |sr1sr2| forem ambos valores imediatos ou o operando **src2** tiver o
  valor imediato um, o operando **src2** não tiver o valor imediato
  zero e o sinalizador de estouro não for necessário.
* |truncar|.


.. raw:: latex

	\clearpage


.. _umlinst-intshift:

Deslocamento e rotação de inteiros
----------------------------------

.. _umlinst-shl:

SHL
~~~

Desloca um valor inteiro à esquerda (em direção à posição do bit mais
significativo), deslocando zeros para a posição do bit menos
significativo.

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block::                       |
|                           |                                       |
|     shl     dst,src,count |     UML_SHL(block, dst, src, count);  |
|     dshl    dst,src,count |     UML_DSHL(block, dst, src, count); |
+---------------------------+---------------------------------------+

O operando **dst** é definido com o valor de **src** deslocado para a
esquerda por **count** posições de bits, considerando o tamanho do
operando em bits. Os zeros são deslocados para a posição de bit menos
significativo.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor deslocado será armazenado.
src |36mriivm|
    O valor que será deslocado.
count |36mriivm|
    A quantidade de posições de bits que serão deslocadas. Apenas os
    cinco ou seis bits menos significativos desse operando são utilizados,
    dependendo do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    Define o valor do último bit deslocado da posição do bit mais
    significativo se a contagem de deslocamento não for um múltiplo do
    tamanho do operando em bits, ou é apagado se a contagem de
    deslocamento for um múltiplo do tamanho do operando em bits.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado
    (ou se o resultado for um valor inteiro negativo assinado |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre se os operandos **src** e **count**
  ambos tiverem valores imediatos ou se o operando **count** tiver o
  valor imediato zero e o sinalizador de transporte não for necessário.
* Os valores imediatos para o operando **src** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-shr:

SHR
~~~

Desloca um valor inteiro à direita (em direção à posição do bit mais
significativo), deslocando zeros para a posição do bit menos
significativo.

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block::                       |
|                           |                                       |
|     shr     dst,src,count |     UML_SHR(block, dst, src, count);  |
|     dshr    dst,src,count |     UML_DSHR(block, dst, src, count); |
+---------------------------+---------------------------------------+

Define **dst** como o valor de **src** deslocado à direita por **count**
posições de bits, considerando o tamanho do operando em bits como
módulo. Os zeros são deslocados para a posição de bit mais
significativo.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor deslocado será armazenado.
src |36mriivm|
    O valor que será deslocado.
count |36mriivm|
    A quantidade de posições de bits que serão deslocadas. Apenas os
    cinco ou seis bits menos significativos deste operando são usados,
    dependendo do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido com o valor do último bit deslocado da posição do bit
    menos significativa se a contagem de deslocamento não for um
    múltiplo do tamanho do operando em bits, ou é apagado se a contagem
    de deslocamento for um múltiplo do tamanho do operando em bits.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado
    (ou se o resultado for um valor inteiro negativo assinado |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre se ambos os operandos |srco| tiverem
  valores imediatos ou se o operando **count** tiver o valor imediato
  zero e o sinalizador de transporte não for necessário.
* Os valores imediatos para o operando **src** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-sar:

SAR
~~~

Desloca um valor inteiro à direita (em direção à posição do bit mais
significativo), preservando o valor do bit mais significativo.

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block::                       |
|                           |                                       |
|     sar     dst,src,count |     UML_SAR(block, dst, src, count);  |
|     dsar    dst,src,count |     UML_DSAR(block, dst, src, count); |
+---------------------------+---------------------------------------+

Define **dst** como o valor de **src** deslocado à direita por **count**
posições de bits, considerando o tamanho do operando em bits como
módulo. O valor do bit mais significativo é preservado após cada etapa
do deslocamento.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor deslocado será armazenado.
src |36mriivm|
    O valor que será deslocado.
count |36mriivm|
    A quantidade de posições de bits que serão deslocadas. Apenas os
    últimos cinco ou seis bits menos significativos deste operando são
    usados, a depender do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido com o valor do último bit deslocado da posição do bit
    menos significativa se a contagem de deslocamento não for um
    múltiplo do tamanho do operando em bits, ou é apagado se a contagem
    de deslocamento for um múltiplo do tamanho do operando em bits.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado
    (ou se o resultado for um valor inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre se os operandos **src** e **count** se
  ambos tiverem valores imediatos ou se o operando **count** for um
  valor imediato zero e o sinalizador de transporte não for necessário.
* Os valores imediatos para o operando **src** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-rol:

ROL
~~~

|uvire| (em direção à posição do bit mais significativo). Os bits
deslocados para fora dessa posição são movidos para a posição do bit
menos significativo.

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block::                       |
|                           |                                       |
|     rol     dst,src,count |     UML_ROL(block, dst, src, count);  |
|     drol    dst,src,count |     UML_DROL(block, dst, src, count); |
+---------------------------+---------------------------------------+

Define **dst** como o valor de **src** rotacionando à esquerda por
**count** posições de bits.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor rotacionado será armazenado.
src |36mriivm|
    O valor que será rotacionado.
count |36mriivm|
    A quantidade de posições de bits que serão rotacionados. Apenas os
    últimos cinco ou seis bits menos significativos deste operando são
    usados, a depender do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido com o valor do último bit rotacionado para fora da
    posição do bit mais significativo e definido como o bit menos
    significativo do resultado se a contagem de deslocamento não for um
    múltiplo do tamanho do operando em bits |occl|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um valor inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre se os operandos |srco| se ambos tiverem
  valores imediatos zero e o sinalizador de transporte não for
  necessário.
* Os valores imediatos para o operando **src** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-ror:

ROR
~~~

|uvird| (em direção à posição do bit menos significativo). Os bits
deslocados para fora da posição do bit menos significativo são movidos
para a posição do bit mais significativo.

+---------------------------+---------------------------------------+
| Disassembly               | Utilização                            |
+===========================+=======================================+
| .. code-block::           | .. code-block::                       |
|                           |                                       |
|     ror     dst,src,count |     UML_ROR(block, dst, src, count);  |
|     dror    dst,src,count |     UML_DROR(block, dst, src, count); |
+---------------------------+---------------------------------------+

Define **dst** como o valor de **src** rotacionando à direita por
**count** posições de bits.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor rotacionado será armazenado.
src |36mriivm|
    O valor que será rotacionado.
count |36mriivm|
    A quantidade de posições de bits que serão rotacionados. Apenas os
    últimos cinco ou seis bits menos significativos deste operando são
    usados, a depender do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido com o valor do último bit, rotacionado para fora da
    posição do bit menos significativo (é definido como o bit mais
    significativo do resultado), se a contagem de deslocamento, o
    tamanho do operando em bits for diferente de zero, ou é apagado se a
    contagem em bits de deslocamento do operando for zero.

overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um valor inteiro negativo assinado |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre se os operandos |srco| forem ambos
  valores imediatos ou se o operando **count** tiver o valor imediato
  zero e o sinalizador de transporte não for necessário.
* Os valores imediatos para o operando **src** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-rolc:

ROLC
~~~~

|uvire| (em direção à posição do bit mais significativo) junto com o
sinalizador de transporte. A cada etapa, o sinalizador de transporte é
deslocado para a posição do bit menos significativo, e o bit deslocado
da posição do bit mais significativo é definido como um sinalizador de
transporte.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block::                        |
|                           |                                        |
|     rolc    dst,src,count |     UML_ROLC(block, dst, src, count);  |
|     drolc   dst,src,count |     UML_DROLC(block, dst, src, count); |
+---------------------------+----------------------------------------+

Define o operando **dst** como o valor de **src** concatenado com o
sinalizador de transporte rotacionado à esquerda pelo **count** de
posições modular com o tamanho do operando em bits. Em cada etapa de
deslocamento, o valor atual do sinalizador de transporte é deslocado
para a posição do bit menos significativo e o sinalizador de transporte
é definido como o valor do bit deslocado da posição do bit mais
significativo.

É importante observar que, embora essa instrução rotacione um valor de
33 ou 65 bits (incluindo o sinalizador de transporte), a contagem de
deslocamento é interpretada em módulos de 32 ou 64 bits.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor rotacionado será armazenado.
src |36mriivm|
    O valor que será rotacionado.
count |36mriivm|
    A quantidade de posições de bits que serão rotacionados. Apenas os
    últimos cinco ou seis bits menos significativos deste operando são
    usados, a depender do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido como o valor do último bit deslocado da posição do bit
    menos significativo, ocorrendo se a contagem de deslocamento não for
    um múltiplo do tamanho do operando em bits, ou permanece inalterado
    se a contagem de deslocamento for um múltiplo do tamanho do operando
    em bits for zero.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um valor inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre o operando de contagem for zero, os
  sinalizadores de zero e o sinal não forem mais necessários.
* Os valores imediatos para o operando **src** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-rorc:

RORC
~~~~
Um valor inteiro concatenado e o sinalizador de transporte são
rotacionados à direita, em direção à posição do bit menos significativo.
A cada etapa, o sinalizador de transporte muda para a posição do bit
mais significativo e é definido pelo bit deslocado da posição menos
significativa.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block::                        |
|                           |                                        |
|     rorc    dst,src,count |     UML_RORC(block, dst, src, count);  |
|     drorc   dst,src,count |     UML_DRORC(block, dst, src, count); |
+---------------------------+----------------------------------------+

Define o operando **dst** como o valor de **src** concatenado com o
sinalizador de transporte rotacionado à direita pelo **count** de
posições modular com o tamanho do operando em bits. Em cada etapa de
deslocamento, o valor atual do sinalizador de transporte é deslocado
para a posição do bit menos significativo e o sinalizador de transporte
é definido como o valor do bit deslocado da posição do bit mais
significativo.

É importante observar que, embora essa instrução rotacione um valor de
33 ou 65 bits (incluindo o sinalizador de transporte), a contagem de
deslocamento é interpretada em módulos de 32 ou 64 bits.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor rotacionado será armazenado.
src |36mriivm|
    O valor que será rotacionado.
count |36mriivm|
    A quantidade de posições de bits que serão rotacionados. Apenas os
    últimos cinco ou seis bits menos significativos deste operando são
    usados, a depender do tamanho da instrução.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido como o valor do último bit deslocado da posição do bit
    menos significativo, se a contagem de deslocamento em bits não for
    zero, ou permanece inalterado se a contagem de deslocamento do
    tamanho do operando em bits for zero.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um valor inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre o operando de contagem for zero, os
  sinalizadores de zero e o sinal não forem mais necessários.
* Os valores imediatos para o operando **src** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-bfx:

BFX
~~~

Extrai um campo de bits contíguo de um valor inteiro.

+---------------------------------+-----------------------------------------------+
| Disassembly                     | Utilização                                    |
+=================================+===============================================+
| .. code-block::                 | .. code-block:: C++                           |
|                                 |                                               |
|     bfxu    dst,src,shift,width |     UML_BFXU(block, dst, src, shift, width);  |
|     bfxs    dst,src,shift,width |     UML_BFXS(block, dst, src, shift, width);  |
|     dbfxu   dst,src,shift,width |     UML_DBFXU(block, dst, src, shift, width); |
|     dbfxs   dst,src,shift,width |     UML_DBFXS(block, dst, src, shift, width); |
+---------------------------------+-----------------------------------------------+

Extrai e alinha à direita um campo de bits contíguo do valor do operando
**src**, conforme especificado pela sua posição de bit menos
significativa e largura em bits. O campo deve ser mais estreito que o
operando **src**, mas pode envolver desde a posição de bit mais
significativa até a posição de bit menos significativa. Os operandos
BFXU e DBFXU estendem a zero um campo não-assinado, e BFXS e DBFXS
estendem o sinal de um campo assinado.

Os back-ends podem otimizar algumas formas dessa instrução, por exemplo,
quando ambos os operandos **shift** e **width** forem valores imediatos.


Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o campo que foi extraído será armazenado.
src |36mriivm|
    O valor usado para extrair um campo de bits contíguo.
shift |36mriivm|
    A posição do bit menos significativo do campo a ser extraído, onde
    zero é a posição do bit menos significativo e as quantidades dos
    bits aumentam em direção à posição do bit mais significativo. Apenas
    os cinco ou seis bits menos significativos deste operando são
    usados, a depender do tamanho da instrução.
width |36mriivm|
    A largura do campo a ser extraído em bits. Apenas os cinco ou seis
    bits menos significativos deste operando são usados, a depender do
    tamanho da instrução. O resultado é indefinido se a largura módulo o
    tamanho da instrução em bits for zero.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado (é
    definido se o resultado for um valor inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^
* É convertido para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>`
  ou :ref:`OR <umlinst-or>` se qualquer um dos operandos **src**,
  **shift** e **width** tiver o valor imediato zero ou caso o operando
  **width** tiver um valor imediato zero.
* É convertido para :ref:`SHR <umlinst-shr>` ou :ref:`SAR <umlinst-sar>`
  se o operando **src** não tiver um valor imediato e se ambos os
  operandos **shift** e **width** tiverem valores imediatos. Neste caso,
  a soma dos valores dos operandos **shift** e **width** deve ser igual
  ao tamanho da instrução em bits.
* Ambos BFXU e DBFXU são convertidos para :ref:`AND <umlinst-and>` se
  o operando **shift** tiver um valor imediato zero e o operando
  **width** tiver um valor imediato.
* Ambos BFXS e DBFXS são convertidos para :ref:`SEXT <umlinst-sext>` se
  o operando **shift** tiver um valor imediato zero e o operando
  **width** tiver o valor imediato 8, 16 ou 32.
* Os valores imediatos do operando **src** são truncados para o tamanho
  da instrução.
* Os valores imediatos dos operandos **shift** e **width** são truncados
  para cinco ou seis bits para operandos de 32 ou 64 bits
  respectivamente.


.. _umlinst-roland:

ROLAND
~~~~~~

Rotacione e mascare um valor inteiro. O valor é rotacionado à esquerda
(em direção à posição do bit mais significativo). Os bits deslocados da
posição mais significativa são movidos para a posição menos
significativa. Em seguida, a conjunção lógica do valor rotacionado e da
máscara é calculada.

+--------------------------------+------------------------------------------------+
| Disassembly                    | Utilização                                     |
+================================+================================================+
| .. code-block::                | .. code-block:: C++                            |
|                                |                                                |
|     roland  dst,src,count,mask |     UML_ROLAND(block, dst, src, count, mask);  |
|     droland dst,src,count,mask |     UML_DROLAND(block, dst, src, count, mask); |
+--------------------------------+------------------------------------------------+

Define o operando **dst** como a conjunção lógica do valor do operando
**src** rotacionando à esquerda em **count** posições de bit e o valor
do operando **mask**.

Os back-ends podem otimizar algumas formas dessa instrução, por exemplo,
quando os operandos **count** e **mask** são ambos valores imediatos.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor mascarado e rotacionado será armazenado.
src |36mriivm|
    O valor que será mascarado e rotacionado.
count |36mriivm|
    A quantidade de posições de bits que serão rotacionadas. Apenas os
    cinco ou seis bits menos significativos deste operando são usados,
    dependendo do tamanho da instrução.
mask |36mriivm|
    A máscara usada para calcular a conjunção lógica.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido caso o resultado seja zero |occl|.
sign (S)
    É definido com o valor do bit mais significativo do resultado
    (é definido se o resultado for um valor inteiro negativo assinado
    |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` ocorre se ambos os operandos **src** e
  **count** tiverem valores imediatos ou se o operando **count** ou
  **mask** tiver um valor imediato zero.
* A conversão para :ref:`ROL <umlinst-rol>` ocorre se o operando
  **mask** tiver um valor imediato com todos os bits definidos.
* A conversão para :ref:`SHL <umlinst-shl>` ocorre se o operando
  **count** tiver um valor imediato e o operando de **mask** tiver um
  valor imediato contendo uma única sequência contígua alinhada à
  esquerda dos bits definidos com o comprimento apropriado com o valor
  do operando **count**.
* A conversão para :ref:`SHR <umlinst-shr>` ocorre se o operando
  **count** tiver um valor imediato e o operando de **mask** tiver um
  valor imediato contendo uma única sequência contígua alinhada à
  direita dos bits definidos com o comprimento apropriado com o valor
  do operando **count**.
* Os valores imediatos dos operandos **src** e **mask** são truncados
  para o tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para
  cinco ou seis bits para operandos de 32 ou 64 bits respectivamente.


.. _umlinst-rolins:

ROLINS
~~~~~~

Rotaciona um valor inteiro e o combina com o valor de destino usando uma
máscara. O valor é rotacionado à esquerda (em direção à posição do bit
mais significativo). Os bits deslocados da posição do bit mais
significativo são movidos para a posição do bit menos significativo. Em
seguida, o valor rotacionado é então combinado com o valor do destino:
para as posições de bits definidas na máscara, os valores das posições
dos bits correspondentes são copiados a partir do valor rotacionado para
o destino; para as posições de bits que estão limpas na máscara, os
valores das posições dos bits correspondentes no destino são
preservados.

+--------------------------------+------------------------------------------------+
| Disassembly                    | Utilização                                     |
+================================+================================================+
| .. code-block::                | .. code-block:: C++                            |
|                                |                                                |
|     rolins  dst,src,count,mask |     UML_ROLINS(block, dst, src, count, mask);  |
|     drolins dst,src,count,mask |     UML_DROLINS(block, dst, src, count, mask); |
+--------------------------------+------------------------------------------------+

Rotaciona o valor do operando **src** à esquerda por **count** posições
de bits  e, em seguida, copia os valores dos bits para **dst**, onde as
posições dos bits correspondentes são definidas no operando **mask**.

Os back-ends podem otimizar algumas formas dessa instrução, por exemplo,
quando ambos os operandos **count** e **mask** são valores imediatos.

Operandos
^^^^^^^^^

dst |36mri|
    O destino que será combinado com o valor rotacionado.
src |36mriivm|
    O valor que será rotacionado e mascarado.
count |36mriivm|
    A quantidade de posições de bits que serão rotacionadas. Apenas os
    cinco ou seis bits menos significativos deste operando são usados,
    dependendo do tamanho da instrução.
mask |36mriivm|
    A máscara que controlará quais posições de bits são copiadas a
    partir do valor rotacionado e quais as posições de bits serão
    preservadas no destino.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido se o resultado for zero |occl|.
sign (S)
    É definido para o valor do bit mais significativo do resultado
    (é definido se o resultado tiver um valor inteiro negativo
    assinado |occl|).
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`ROL <umlinst-rol>`, :ref:`AND <umlinst-and>`,
  :ref:`OR <umlinst-or>` ou :ref:`MOV <umlinst-mov>` ocorre se o
  operando **mask** tiver um valor imediato com todos os bits definidos
  ou se o valor imediato for zero.
* O valor imediato dos operandos **src** e **mask** são truncados para o
  tamanho da instrução.
* Os valores imediatos para o operando **count** são truncados para cinco
  ou seis bits para operandos de 32 ou 64 bits, respectivamente.


.. _umlinst-bswap:

BSWAP
~~~~~

Inverte a ordem dos bytes dentro de um valor inteiro.

+---------------------+----------------------------------+
| Disassembly         | Utilização                       |
+=====================+==================================+
| .. code-block::     | .. code-block:: C++              |
|                     |                                  |
|     bswap   dst,src |     UML_BSWAP(block, dst, src);  |
|     dbswap  dst,src |     UML_DBSWAP(block, dst, src); |
+---------------------+----------------------------------+


.. raw:: latex

	\clearpage


Esta instrução pode ser usada para converter entre a ordem de bytes
*big endian* e *little endian*.

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o resultado será armazenado.
src |36mriivm|
    O Valor que terá a ordem dos bytes invertido.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    É definido se o resultado for zero |occl|.
sign (S)
    É definido para o valor do bit mais importante do resultado (é
    definido se o resultado for um inteiro negativo assinado |occl|).

unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`MOV <umlinst-mov>`, :ref:`AND <umlinst-and>` ou
  :ref:`OR <umlinst-or>` se o operando **src** for um valor imediato.


.. raw:: latex

	\clearpage


.. _umlinst-fparith:

Aritmética de ponto flutuante
-----------------------------


.. _umlinst-fadd:

FADD
~~~~

Soma dois números de ponto flutuante.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block:: C++                    |
|                           |                                        |
|     fsadd   dst,src1,src2 |     UML_FSADD(block, dst, src1, src2); |
|     fdadd   dst,src1,src2 |     UML_FDADD(block, dst, src1, src2); |
+---------------------------+----------------------------------------+

Calcula ``dst = src1 + src2``

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde a soma será armazenada
src1 |36mrpf|
    O primeiro adendo.
src2 |36mrpf|
    O segundo adendo.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-fsub:

FSUB
~~~~

Subtrai um número de ponto flutuante de outro número de ponto flutuante.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block:: C++                    |
|                           |                                        |
|     fssub   dst,src1,src2 |     UML_FSSUB(block, dst, src1, src2); |
|     fdsub   dst,src1,src2 |     UML_FDSUB(block, dst, src1, src2); |
+---------------------------+----------------------------------------+

Calcula ``dst = src1 - src2``

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde a diferença será armazenada.
src1 |36mrpf|
    O minuendo (o valor que será subtraído).
src2 |36mrpf|
    O subtraendo (o valor que será subtraído do minuendo).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-fcmp:

FCMP
~~~~

Compara dois números de ponto flutuante e define os sinalizadores de
transporte, zero e não ordenado de maneira adequada.

+-----------------------+-----------------------------------+
| Disassembly           | Utilização                        |
+=======================+===================================+
| .. code-block::       | .. code-block:: C++               |
|                       |                                   |
|     fscmp   src1,src2 |     UML_FSCMP(block, src1, src2); |
|     fdcmp   src1,src2 |     UML_FDCMP(block, src1, src2); |
+-----------------------+-----------------------------------+

Operandos
^^^^^^^^^

src1 |36mrpf|
    O valor à esquerda que será comparado.
src2 |36mrpf|
    O valor à direita que será comparado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    É definido se o valor de **src1** for menor que o valor de **src2**
    |occl|.
overflow (V)
    |idf|.
zero (Z)
    É definido se ambos os valores dos operandos |sr1sr2| forem iguais
    |occl|.
sign (S)
    |idf|.
unordered (U)
    É definido se qualquer um dos operando **src1** ou **src2** não for
    um número (NaN) |occl|.
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-fmul:

FMUL
~~~~

Multiplica dois números de ponto flutuante.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block:: C++                    |
|                           |                                        |
|     fsmul   dst,src1,src2 |     UML_FSMUL(block, dst, src1, src2); |
|     fdmul   dst,src1,src2 |     UML_FDMUL(block, dst, src1, src2); |
+---------------------------+----------------------------------------+

Calcula ``dst = src1 * src2``

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o produto será armazenado.
src1 |36mrpf|
    O multiplicando (o valor a ser multiplicado).
src2 |36mrpf|
    O multiplicador (o valor pelo qual será multiplicado).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-fdiv:

FDIV
~~~~

Divide um número de ponto flutuante por outro número de ponto flutuante.

+---------------------------+----------------------------------------+
| Disassembly               | Utilização                             |
+===========================+========================================+
| .. code-block::           | .. code-block:: C++                    |
|                           |                                        |
|     fsdiv   dst,src1,src2 |     UML_FSDIV(block, dst, src1, src2); |
|     fddiv   dst,src1,src2 |     UML_FDDIV(block, dst, src1, src2); |
+---------------------------+----------------------------------------+

Calcula ``dst = src1 / src2``

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o quociente será armazenado.
src1 |36mrpf|
    O dividendo (o valor a ser dividido).
src2 |36mrpf|
    O divisor (o valor pelo qual será dividido).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-fneg:

FNEG
~~~~

Nega um número de ponto flutuante.

+---------------------+---------------------------------+
| Disassembly         | Utilização                      |
+=====================+=================================+
| .. code-block::     | .. code-block:: C++             |
|                     |                                 |
|     fsneg   dst,src |     UML_FSNEG(block, dst, src); |
|     fdneg   dst,src |     UML_FDNEG(block, dst, src); |
+---------------------+---------------------------------+

Calculates ``dst = -src``.

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o resultado será armazenado.
src |36mrpf|
    O valor que será negado.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

Não são aplicadas simplificações a esta instrução.


.. _umlinst-fabs:

FABS
~~~~

Calcula o valor absoluto de um número de ponto flutuante.

+---------------------+---------------------------------+
| Disassembly         | Utilização                      |
+=====================+=================================+
| .. code-block::     | .. code-block:: C++             |
|                     |                                 |
|     fsabs   dst,src |     UML_FSABS(block, dst, src); |
|     fdabs   dst,src |     UML_FDABS(block, dst, src); |
+---------------------+---------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o resultado será armazenado.
src |36mrpf|
    O valor para calcular o valor absoluto.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

Não são aplicadas simplificações a esta instrução.


.. _umlinst-fsqrt:

FSQRT
~~~~~

Calcula a raiz quadrada de um número de ponto flutuante.

+---------------------+----------------------------------+
| Disassembly         | Utilização                       |
+=====================+==================================+
| .. code-block::     | .. code-block:: C++              |
|                     |                                  |
|     fssqrt  dst,src |     UML_FSSQRT(block, dst, src); |
|     fdsqrt  dst,src |     UML_FDSQRT(block, dst, src); |
+---------------------+----------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde a raiz quadrada será armazenada.
src |36mrpf|
    O valor para calcular a raiz quadrada.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

Não são aplicadas simplificações a esta instrução.


.. _umlinst-frecip:

FRECIP
~~~~~~

Calcula um valor recíproco aproximado de um número de ponto flutuante.
O algoritmo utilizado, a precisão e a natureza das imprecisões na
aproximação não são especificados.

+---------------------+---------------------------------+
| Disassembly         | Utilização                      |
+=====================+=================================+
| .. code-block::     | .. code-block:: C++             |
|                     |                                 |
|     fsabs   dst,src |     UML_FSABS(block, dst, src); |
|     fdabs   dst,src |     UML_FDABS(block, dst, src); |
+---------------------+---------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o resultado será armazenado.
src |36mrpf|
    O valor para aproximar o recíproco de.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-frsqrt:

FRSQRT
~~~~~~

Calcula um valor recíproco aproximado da raiz quadrada de um número de
ponto flutuante. O algoritmo utilizado, a precisão e a natureza das
imprecisões na aproximação não são especificados.

+---------------------+-----------------------------------+
| Disassembly         | Utilização                        |
+=====================+===================================+
| .. code-block::     | .. code-block:: C++               |
|                     |                                   |
|     fsrsqrt dst,src |     UML_FSRSQRT(block, dst, src); |
|     fdrsqrt dst,src |     UML_FDRSQRT(block, dst, src); |
+---------------------+-----------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o resultado será armazenado.
src |36mrpf|
    O valor para aproximar o recíproco da raiz quadrada de.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-frnds:

FRNDS
~~~~~

Arredonda um valor de ponto flutuante de 64 bits para uma precisão de
32 bits. É utilizado o tipo de arredondamento padrão atual definido com
:ref:`SETFMOD <umlinst-setfmod>`. Observe que para esta instrução. o
tamanho sempre deve ser de 64 bits.

+---------------------+----------------------------------+
| Disassembly         | Utilização                       |
+=====================+==================================+
| .. code-block::     | .. code-block::                  |
|                     |                                  |
|     fdrnds  dst,src |     UML_FDRNDS(block, dst, src); |
+---------------------+----------------------------------+

Operandos
^^^^^^^^^

dst |6mfpr|
    O destino onde o valor arredondado será armazenado.
src |6mfpr|
    O valor de ponto flutuante a ser arredondado com precisão de 32
    bits.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. raw:: latex

	\clearpage


.. _umlinst-fpconv:

Conversão de ponto flutuante
----------------------------


.. _umlinst-ftoint:

FTOINT
~~~~~~

Converte um número de ponto flutuante em um inteiro com complemento de
dois assinado.

+--------------------------------+------------------------------------------------+
| Disassembly                    | Utilização                                     |
+================================+================================================+
| .. code-block::                | .. code-block::                                |
|                                |                                                |
|     fstoint dst,src,size,round |     UML_FSTOINT(block, dst, src, size, round); |
|     fdtoint dst,src,size,round |     UML_FDTOINT(block, dst, src, size, round); |
+--------------------------------+------------------------------------------------+

Operandos
^^^^^^^^^

dst |36mri|
    O destino onde o valor inteiro será armazenado. O tamanho e formato
    são controlados pelo operando **size**.
src |36mrpf|
    O valor de ponto flutuante que será convertido em inteiro. O tamanho
    da instrução define o tamanho e o formato deste operando.
size (tamanho do acesso)
    O tamanho do resultado. Deve ser **SIZE_DWORD** (32 bits) ou
    **SIZE_QWORD** (64 bits). É importante observar que este operando
    controla o tamanho do operando **dst**, enquanto o tamanho da
    instrução define o tamanho do operando **src**.
round (tipo do arredondamento)
    O tipo de arredondamento que será usado. Deve ser **ROUND_ROUND**
    (arredondar para o mais próximo), **ROUND_CEIL** (arredondar para o
    infinito positivo), **ROUND_FLOOR** (arredondar para o infinito
    negativo), **ROUND_TRUNC** (arredondar para zero) ou
    **ROUND_DEFAULT** (usar o tipo de arredondamento padrão atual
    definido com a instrução :ref:`SETFMOD <umlinst-setfmod>`).

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

|nsaa|.


.. _umlinst-ffrint:

FFRINT
~~~~~~

Converte um número inteiro com complemento a dois assinado em um número
de ponto flutuante.

+--------------------------+-----------------------------------------+
| Disassembly              | Utilização                              |
+==========================+=========================================+
| .. code-block::          | .. code-block::                         |
|                          |                                         |
|     fsfrint dst,src,size |     UML_FSFRINT(block, dst, src, size); |
|     fdfrint dst,src,size |     UML_FDFRINT(block, dst, src, size); |
+--------------------------+-----------------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o valor de ponto flutuante será armazenado. O tamanho
    da instrução define o tamanho e o formato deste operando.
src |36mriivm|
    O valor inteiro que será convertido para um valor de ponto
    flutuante. O tamanho e o formato é controlado pelo operando
    **size**.
size (tamanho do acesso)
    O tamanho da entrada. Deve ser **SIZE_DWORD** (32 bits) ou
    **SIZE_QWORD** (64 bits). É importante observar que este operando
    controla o tamanho do operando **src**, enquanto o tamanho da
    instrução define o tamanho do operando **dst**.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* Os valores imediatos para o operando **src** são truncados para o
  tamanho definido usando o operando **size**.


.. _umlinst-ffrflt:

FFRFLT
~~~~~~

Converte entre formatos de ponto flutuante. O tipo de arredondamento
padrão atual é definido usando :ref:`SETFMOD <umlinst-setfmod>`, é usado
se for aplicável.

+--------------------------+-----------------------------------------+
| Disassembly              | Utilização                              |
+==========================+=========================================+
| .. code-block::          | .. code-block::                         |
|                          |                                         |
|     fsfrflt dst,src,size |     UML_FSFRFLT(block, dst, src, size); |
|     fdfrflt dst,src,size |     UML_FDFRFLT(block, dst, src, size); |
+--------------------------+-----------------------------------------+

Operandos
^^^^^^^^^

dst |36mrpf|
    O destino onde o valor convertido será armazenado. O tamanho da
    instrução definem o tamanho e o formato deste operando
src |36mrpf|
    O valor de ponto flutuante que será convertido. O tamanho e o
    formato é controlado pelo operando **size**.
size (tamanho do acesso)
    O tamanho da entrada. Deve ser **SIZE_SHORT** (32 bits) ou
    **SIZE_DOUBLE** (64 bits). É importante observar que este operando
    controla o tamanho do operando **src**, enquanto o tamanho da
    instrução define o tamanho do operando **dst**.

Sinalizadores
^^^^^^^^^^^^^

carry (C)
    |idf|.
overflow (V)
    |idf|.
zero (Z)
    |idf|.
sign (S)
    |idf|.
unordered (U)
    |idf|.

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* A conversão para :ref:`FMOV <umlinst-fmov>` ou
  :ref:`NOP <umlinst-nop>` ocorre se os operandos **dst** e **src**
  tiverem o mesmo tamanho e formato.


.. |idf| replace:: Indefinido
.. |ucg| replace:: Inalterado
.. |odpo| replace:: O valor que será copiado para o destino
.. |ovdo| replace:: O valor que será copiado da origem
.. |ovse| replace:: O valor que será escrito na memória
.. |dovl| replace:: O destino onde o valor lido da memória será
   armazenado
.. |dove| replace:: O destino onde o valor lido da memória emulada será
   armazenado
.. |ebrm| replace:: O endereço base da região da memória que será lido
.. |ebre| replace:: O endereço base da região da memória que será
   escrito
.. |3mriivm| replace:: (32-bit – memória, registro inteiro, imediato,
   variável de mapa)
.. |3mfpr| replace:: (32-bit – memória, registro de ponto flutuante)
.. |6mfpr| replace:: (64-bit – memória, registro de ponto flutuante)
.. |36mri| replace:: (32-bit ou 64-bit – memória, registro inteiro)
.. |36mriivm| replace:: (32-bit ou 64-bit – memória, registro inteiro,
   imediato, variável de mapa)
.. |36mrpf| replace:: (32-bit ou 64-bit – memória, registro de ponto
   flutuante)
.. |bpce| replace:: Esse valor é adicionado ao endereço base para
   calcular o endereço de leitura. Esse valor pode ser escalonado por um
   fator de ``1``, ``2``, ``4`` ou ``8``, dependendo do operando
   **scale**. Observe que esse operando é sempre de 32 bits,
   interpretado como um número inteiro assinado, independentemente do
   tamanho da instrução
.. |ebce| replace:: Esse valor é adicionado ao endereço base para
   calcular o endereço de leitura. Esse valor será escalonado de acordo
   com o tamanho da instrução (multiplicado por ``4`` ou ``8``). Observe
   que esse operando é sempre de 32 bits, interpretado como um número
   inteiro assinado, independentemente do tamanho da instrução.
.. |ebcr| replace:: Esse valor é adicionado ao endereço base para
   calcular o endereço de escrita. Esse valor será escalonado de acordo
   com o tamanho da instrução (multiplicado por ``4`` ou ``8``). Observe
   que esse operando é sempre de 32 bits, interpretado como um número
   inteiro assinado, independentemente do tamanho da instrução.
.. |tvsl| replace:: Especifica o tamanho do valor que será lido. Deve
   ser  um dos seguintes valores: **SIZE_BYTE** (8 bits), **SIZE_WORD**
   (16 bits), **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits).
   Observe que esse operando controla o tamanho do valor lido da
   memória, enquanto o tamanho da instrução define o tamanho do
   operando **dst**
.. |tvsr| replace:: Especifica o tamanho do valor que será escrito. Deve
   ser um dos seguintes valores: **SIZE_BYTE** (8 bits), **SIZE_WORD**
   (16 bits), **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits).
   Observe que esse operando controla o tamanho do valor que será
   escrito na memória, enquanto o tamanho da instrução define o tamanho
   do operando **dst**
.. |feao| replace:: O fator de escala que será aplicado ao operando
   **index**. Deve ser **SCALE_x1**, **SCALE_x2**, **SCALE_x4** ou
   **SCALE_x8** para multiplicar por ``1``, ``2``, ``4`` ou ``8``,
   respectivamente (deslocamento à esquerda de **0**, **1**, **2** ou
   **3 bits**)
.. |oait| replace:: O operando **addr** tem seus valores imediatos
   truncados em 32 bits
.. |orit| replace:: O operando **arg** tem seus valores imediatos
   truncados em 32 bits
.. |oask| replace:: O operando **mask** tem seus valores imediatos
   truncados em 32 bits
.. |ok32| replace:: Observe que esse operando é sempre de 32 bits,
   independentemente do tamanho da instrução
.. |unii| replace:: Um número inteiro que identifica o espaço de
   endereço que será lido. Pode ser **SPACE_PROGRAM**, **SPACE_DATA**,
   **SPACE_IO** ou **SPACE_OPCODES** para um dos espaços de endereço
   comuns da CPU ou um número inteiro não negativo convertido em
   **memory_space**
.. |askd| replace:: A máscara de acesso está implícita para garantir que
   todos os bits estão definidos
.. |nsaa| replace:: Não há simplificações aplicadas a esta instrução
.. |occl| replace:: ou, caso contrário, é apagado
.. |apon| replace:: Arredonde para o número mais próximo, arredonde metade para o número par
.. |uomda| replace:: Use o modo de arredondamento padrão atual
.. |rrrr| replace:: Deve ser 0 (**ROUND_TRUNC**) para arredondar para
   zero, 1 (**ROUND_ROUND**) para arredondar para o valor mais próximo,
   2 (**ROUND_CEIL**) para arredondar para o infinito positivo ou 3
   (**ROUND_FLOOR**) para arredondar para o infinito negativo.
.. |rrrr2| replace:: Será definido como 0 (**ROUND_TRUNC**) para
   arredondar para zero, 1 (**ROUND_ROUND**) para arredondar para o mais
   próximo, 2 (**ROUND_CEIL**) para arredondar para o infinito positivo
   ou 3 (**ROUND_FLOOR**) para arredondar para o infinito negativo
.. |sr1sr2| replace:: **src1** e **src2**
.. |truncar| replace:: Os valores imediatos dos operandos |sr1sr2| são
   truncados para o tamanho da instrução
.. |intercambio| replace:: Se os operandos **src2** e **dst** se
   referirem ao mesmo registro ou local de memória, os operandos
   |sr1sr2| serão intercambiados
.. |dsed| replace:: **dst** e **edst**
.. |srco| replace:: **src** e **count**
.. |uvire| replace:: Um valor inteiro é rotacionado à esquerda
.. |uvird| replace:: Um valor inteiro é rotacionado à direita
.. |dpos| replace:: É definido a partir do operando **src**
