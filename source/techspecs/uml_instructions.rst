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


.. _umlinst-flow:

Controle de fluxo
-----------------

.. _umlinst-comment:

COMMENT
~~~~~~~

Insere um comentário no código UML registrado.

+--------------------+---------------------------------+
| Disassembly        | Uso                             |
+====================+=================================+
| .. code-block::    | .. code-block:: C++             |
|                    |                                 |
|     comment string |     UML_COMMENT(block, string); |
+--------------------+---------------------------------+

Operações
^^^^^^^^^

string
    O texto do comentário como um ponteiro para uma cadeia de caracteres
    com terminação NUL. Ele deve permanecer válido até que o código seja
    gerado para o bloco.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

label (número da etiqueta)
    O número da etiqueta deve ser associado ao local atual. Um número de
    etiqueta não deve ser usado mais de uma vez em um bloco com código
    gerado.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

handle (manipulador do código)
    O manipulador de código a ser vinculado ao local atual. O
    manipulador já deve estar alocado e não deve ter sido vinculado
    desde a última redefinição do código gerado (todos os manipuladores
    são implicitamente desvinculados ao redefinir o cache de código
    gerado).

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

mode (32-bit – imediato, variável de mapa)
    O modo a ser associado ao local atual no código gerado. Deve ser
    maior ou igual a zero e menor que o número de modos especificados
    durante a criação do contexto do recompilador.
pc (32-bit – imediato, variável de mapa)
    O valor do contador de programa emulado a ser associado ao local
    atual no código gerado.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
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

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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
|     callh   handle,cond |     UML_CALLHc(block, handle, cond); |
+-------------------------+--------------------------------------+

Operações
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

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

handle (manipulador do código)
    O manipulador está localizado no ponto de entrada da sub-rotina a
    ser chamada. Embora já deva estar alocado, o manipulador não
    precisa ser vinculado até que a instrução seja executada. Invocar um
    manipulador que não estava vinculado no momento da geração do código
    pode resultar em um código menos eficiente do que chamar um
    manipulador que já estava vinculado.
arg (32-bit – memória, registro inteiro, imediato, variável de mapa)
    Valor que será armazenado no registro **EXP**.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que a
    sub-rotina seja invocada. Se a condição não for atendida, a
    sub-rotina não será invocada e o registro EXP não será alterado.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que a
    sub-rotina retorne. Se a condição não for atendida, a execução
    continuará com a instrução seguinte.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

mode (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O modo associado ao local no código gerado para o qual o controle
    deve ser transferido. Deve ser maior ou igual a zero e menor que o
    número de modos especificados durante a criação do contexto do
    recompilador.
pc (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O valor do contador de programa emulado, associado ao local no
    código gerado, é o que determina para onde o controle deve ser
    transferido.
handle (manipulador do código)
    Se nenhum local no código gerado estiver associado ao modo
    especificado e aos valores do contador de programa emulado, o
    manipulador será localizado no ponto de entrada da sub-rotina a ser
    invocada. Embora o manipulador já deva estar alocado, não é
    necessário vinculá-lo até que a instrução seja executada. Invocar um
    manipulador que não estava vinculado no momento da geração do código
    pode resultar em um código menos eficiente do que invocar um
    manipulador que já estava vinculado.

Sinalizadores
^^^^^^^^^^^^^

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

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

Operações
^^^^^^^^^

arg (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O valor a ser retornado ao solicitante.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para sair do
    código gerado. Se a condição não for atendida, a execução continuará
    com a instrução seguinte.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

func (C function)
    O ponteiro de função indica qual função deve ser invocada.
arg (memória)
    Argumento para encaminhar para a função.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que a
    função seja invocada. Se a condição não for atendida, a função não
    será invocada.

Sinalizadores
^^^^^^^^^^^^^

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

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

Operações
^^^^^^^^^

pc (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O valor do contador de programa emulado deve ser fornecido à função
    de gancho de instruções do depurador.

Sinalizadores
^^^^^^^^^^^^^

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

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

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+


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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro inteiro)
    |odpo|.
src (32-bit ou 64-bit – memória, registro inteiro, imediato, variável de mapa)
    |ovdo|.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que o
    valor seja copiado. Se a condição não for atendida, a instrução não
    terá efeito.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro de ponto flutuante)
    |odpo|.
src (32-bit ou 64-bit – memória, registro de ponto flutuante)
    |ovdo|.
cond (condição)
    Se uma condição for fornecida, ela deve ser atendida para que o
    valor seja copiado. Se a condição não for atendida, a instrução não
    terá efeito.



Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^
* Se os operandos **src** e **dst** se referirem ao mesmo local de
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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro de ponto flutuante)
    |odpo|.
src (32-bit ou 64-bit – memória, registro inteiro)
    |ovdo|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro inteiro)
    |odpo|.
src (32-bit ou 64-bit – memória, registro de ponto flutuante)
    |ovdo|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro inteiro)
    |dovl|.
base (memória)
    |ebrm|.
index (32-bit – memória, registro inteiro, imediato, variável de mapa)
    |bpce|.
size (tamanho do acesso)
    |tvsl|.
scale (escala do índice)
    |feao|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro inteiro)
    |dovl|.
base (memória)
    |ebrm|.
index (32-bit – memória, registro inteiro, imediato, variável de mapa)
    |bpce|.
size (tamanho do acesso)
    |tvsl|.
scale (escala do índice)
    |feao|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

base (memória)
    |ebre|.
index (32-bit – memória, registro inteiro, imediato, variável de mapa)
    |bpce|.
src (32-bit ou 64-bit – memória, registro inteiro, imediato, variável de mapa)
    |ovse|.
size (tamanho do acesso)
    |tvsr|.
scale (escala do índice)
    |feao|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro de ponto flutuante)
    |dovl|.
base (memória)
    |ebrm|.
index (32-bit – memória, registro inteiro, imediato, variável de mapa)
    |ebce|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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


Operações
^^^^^^^^^

base (memória)
    |ebre|.
index (32-bit – memória, registro inteiro, imediato, variável de mapa)
    |ebcr|.
src (32-bit ou 64-bit – memória, registro de ponto flutuante)
    |ovse|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

dst (32-bit – memória, registro inteiro)
    O destino para onde o valor do registro **EXP** deve ser copiado.
    Observe que o registro **EXP** só pode conter um valor de 32 bits.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+


.. raw:: latex

	\clearpage


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

Operações
^^^^^^^^^

mapvar (variável de mapa)
    O valor para definir a variável de mapa.
value (32-bit – imediato, variável de mapa)
    O valor para definir a variável de mapa. Observe que as variáveis de
    mapa só podem conter valores de 32 bits.

Sinalizadores
^^^^^^^^^^^^^

+---------------+-------------+
| carry (C)     | |ucg|.      |
+---------------+-------------+
| overflow (V)  | |ucg|.      |
+---------------+-------------+
| zero (Z)      | |ucg|.      |
+---------------+-------------+
| sign (S)      | |ucg|.      |
+---------------+-------------+
| unordered (U) | |ucg|.      |
+---------------+-------------+

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

Operações
^^^^^^^^^

dst (32-bit – memória, registro inteiro)
    O destino para copiar o valor da variável de mapa. Observe que as
    variáveis de mapa só podem conter valores de 32 bits.
mapvar (variável de mapa)
    A variável de mapa para recuperar o valor do quadro de código gerado
    mais externo.

Sinalizadores
^^^^^^^^^^^^^

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+


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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro inteiro)
    |dove|.
addr (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O endereço a ser lido no espaço de endereço emulado. |ok32|.
size (tamanho do acesso)
    O tamanho do acesso à memória emulada. Deve ser um dos seguintes
    valores: **SIZE_BYTE** (8 bits), **SIZE_WORD** (16 bits),
    **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits). Observe que
    esse operando controla o tamanho do acesso à memória emulada,
    enquanto o tamanho da instrução define o tamanho do operando
    **dst**.
space (número do espaço de endereço)
    |unii|.


.. raw:: latex

	\clearpage


Sinalizadores
^^^^^^^^^^^^^

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro inteiro)
    O destino onde o valor lido do espaço da memória emulada que será
    armazenado.
addr (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O endereço do espaço da memória emulada que será lido. |ok32|.
mask (32-bit ou 64-bit – memória, registro inteiro, imediato, variável de mapa)
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

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.
* |oask|.
* Convertido para :ref:`READ <umlinst-read>` se o operando **mask** for
  um valor imediato com todos os bits definidos.

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

Operações
^^^^^^^^^

addr (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O endereço do espaço da memória emulada que será escrito. |ok32|.
src (32-bit ou 64-bit – memória, registro inteiro, imediato, variável de mapa)
    O valor a ser escrito no espaço de endereço emulado.
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

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

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

Operações
^^^^^^^^^

addr (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O endereço do espaço da memória emulada que será escrito. |ok32|.
src (32-bit ou 64-bit – memória, registro inteiro, imediato, variável de mapa)
    O valor a ser escrito no espaço de endereço emulado.
mask (32-bit ou 64-bit – memória, registro inteiro, imediato, variável de mapa)
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

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.
* Os valores imediatos dos operandos **src** e **mask** são truncados
  para o tamanho do acesso.
* Convertido para :ref:`WRITE <umlinst-read>` se o operando **mask** for
  um valor imediato com todos os bits definidos.

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

Operações
^^^^^^^^^

dst (32-bit ou 64-bit – memória, registro de ponto flutuante)
    O destino onde o valor lido do espaço de endereço emulado será
    armazenado.
addr (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O endereço a ser lido no espaço de endereço emulado. |ok32|.
space (número do espaço de endereço)
    |unii|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

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

Operações
^^^^^^^^^

addr (32-bit – memória, registro inteiro, imediato, variável de mapa)
    O endereço para gravação no espaço de endereço emulado. |ok32|.
src (32-bit ou 64-bit – memória, registro de ponto flutuante)
    O valor a ser escrito no espaço de endereço emulado.
space (número do espaço de endereço)
    |unii|.

Sinalizadores
^^^^^^^^^^^^^

+---------------+--------------+
| carry (C)     | |udf|.       |
+---------------+--------------+
| overflow (V)  | |udf|.       |
+---------------+--------------+
| zero (Z)      | |udf|.       |
+---------------+--------------+
| sign (S)      | |udf|.       |
+---------------+--------------+
| unordered (U) | |udf|.       |
+---------------+--------------+

Regras de simplificação
^^^^^^^^^^^^^^^^^^^^^^^

* |oait|.


.. |udf| replace:: Não definido
.. |ucg| replace:: Inalterado
.. |odpo| replace:: O valor a ser copiado para o destino
.. |ovdo| replace:: O valor a ser copiado da origem
.. |ovse| replace:: O valor a ser escrito na memória
.. |dovl| replace:: O destino onde o valor lido da memória será
   armazenado
.. |dove| replace:: O destino onde o valor lido da memória emulada será
   armazenado
.. |ebrm| replace:: O endereço base da região da memória que será lido
.. |ebre| replace:: O endereço base da região da memória que será
   escrito
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
.. |tvsl| replace:: Especifica o tamanho do valor a ser lido. Deve ser
   um dos seguintes valores: **SIZE_BYTE** (8 bits), **SIZE_WORD**
   (16 bits), **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits).
   Observe que esse operando controla o tamanho do valor lido da
   memória, enquanto o tamanho da instrução define o tamanho do
   operando **dst**
.. |tvsr| replace:: Especifica o tamanho do valor a ser escrito. Deve
   ser um dos seguintes valores: **SIZE_BYTE** (8 bits), **SIZE_WORD**
   (16 bits), **SIZE_DWORD** (32 bits) ou **SIZE_QWORD** (64 bits).
   Observe que esse operando controla o tamanho do valor a ser escrito
   na memória, enquanto o tamanho da instrução define o tamanho do
   operando **dst**
.. |feao| replace:: O fator de escala a ser aplicado ao operando
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
   endereço a ser lido. Pode ser **SPACE_PROGRAM**, **SPACE_DATA**,
   **SPACE_IO** ou **SPACE_OPCODES** para um dos espaços de endereço
   comuns da CPU ou um número inteiro não negativo convertido em
   **memory_space**
.. |askd| replace:: A máscara de acesso está implícita para garantir que
   todos os bits estão definidos
