.. raw:: latex

	\clearpage


.. _debugger-breakpoint-list:

Comandos do ponto de interrupção do depurador
=============================================

.. line-block::

    :ref:`debugger-command-bpset`
        Define o |pdi| [#BKPOINT]_ no <*endereço*>.
    :ref:`debugger-command-bpclear`
        Limpa todos ou um determinado |pdi|.
    :ref:`debugger-command-bpdisable`
        Desativa todos ou um determinado |pdi|.
    :ref:`debugger-command-bpenable`
        Ativa todos ou um determinado |pdi|.
    :ref:`debugger-command-bplist`
        Lista todos os |pdi|.

.. [#BKPOINT]	*Breakpoint* no Inglês.


 .. _debugger-command-bpset:

bpset
-----

**bp[set]** <*endereço*>[:<*CPU*>][,<*condição*>[,<*ação*>]]

Define uma nova execução do *breakpoint* num determinado <*endereço*>. O
<*endereço*> pode ser seguido por dois pontos, uma etiqueta ou o número
de depuração da *CPU* para definir um |pdi| para uma determinada *CPU*.
Caso nenhuma *CPU* seja informada, o ponto de interrupção será definido
na *CPU* que estiver atualmente visível no depurador.

O parâmetro de <*condição*> opcional permite que você possa definir uma
expressão que será avaliada toda a vez que o endereço de um ponto de
interrupção for alcançado.

Caso o resultado da expressão seja verdadeiro (não zero), o ponto de
interrupção suspenderá a execução; caso contrário, a execução continuará
sem qualquer notificação. O parâmetro opcional <*ação*> fornece um
comando para ser executado sempre que o |pdi| for alcançado e a
<*condição*> seja verdadeira. Observe que talvez seja necessário cercar
a ação com chaves ``{ }`` para garantir que as vírgulas e o ponto e
vírgula dentro do comando não sejam interpretados no contexto do próprio
comando ``bpset``.

A cada |pdi| definido é atribuído a um índice numérico que pode ser
usado para se referir a ele em outros comandos de ponto de interrupção.
Ao longo de uma sessão, os índices do |pdi| são únicos.

Exemplos:

.. line-block::

    ``bp 1234``
        Define um |pdi| |nace| e suspenda [#HALT]_ uma execução sempre que PC seja igual à ``1234``.
    ``bp 23456,a0 == 0 && a1 == 0``
        Define um |pdi| |nace| e suspenda uma execução sempre que PC seja igual à ``23456`` *e* a expressão ``(a0 == 0 && a1 == 0)`` seja verdadeira.
    ``bp 3456:audiocpu,1,{ printf "A0=%08X\n",a0 ; g }``
        Define um |pdi| na *CPU* com o caminho absoluto da etiqueta ``:audiocpu`` que suspenda uma execução sempre que PC seja igual à ``3456``. Quando isso acontecer, imprime ``A0=<a0val>`` no console do deputador e continua a execução.
    ``bp 45678:2,a0==100,{ a0 = ff ; g }``
        Define um |pdi| na terceira *CPU* do sistema (num índice com base zero) e que suspenderá uma execução sempre que PC seja igual à ``45678`` e a expressão ``a0 == 100`` seja verdadeira. Quando isso acontecer, define ``a0`` para ``ff`` e continua a execução.
    ``temp0 = 0 ; bp 567890,++temp0 >= 10``
        Define um |pdi| |nace| e suspenda uma execução sempre que PC seja igual à ``567890`` e a expressão ``++temp0 >= 10`` seja verdadeira. Isso apenas será interrompido de forma efetiva depois que o |pdi| for alcançado 16 vezes.

|ret| :ref:`debugger-breakpoint-list`.

.. [#HALT]	*Halt* no Inglês.

 .. _debugger-command-bpclear:

bpclear
-------

**bpclear** [<*bpnum*>[,…]]

Limpa todos os |pdis|. Caso um <*bpnum*> seja definido,
apenas os |pdis| relacionados a ele serão limpos, |ccts|.

Exemplos:

.. line-block::

    ``bpclear 3``
        Limpa o |pdi| com o índice 3.
    ``bpclear``
        Limpa todos os |pdis|.

|ret| :ref:`debugger-breakpoint-list`.

 .. _debugger-command-bpdisable:

bpdisable
---------

**bpdisable** [<*bpnum*>[,…]]

Desativa os |pdis|. Caso um <*bpnum*> seja definido, apenas os |pdis|
citados serão desativados, |ccts|.

Observe que ao desativar um |pdi| ele não é eliminado, apenas marca
temporariamente o |pdi| como inativo. Os |pdis| desativados não causarão
a suspensão da execução, as expressões relacionadas com as suas
respectivas condições não serão avaliadas e seus comandos relacionados
não serão executados.

Exemplos:

.. line-block::

    ``bpdisable 3``
        Desativa o |pdi| com o índice 3.
    ``bpdisable``
        Desativa todos os |pdis|.

|ret| :ref:`debugger-breakpoint-list`.


 .. _debugger-command-bpenable:

bpenable
--------

**bpenable** [<*bpnum*>[,…]]

Ativa os |pdis|. Caso um <*bpnum*> seja definido, apenas os |pdis|
citados serão ativados, |ccts|.

Exemplos:

.. line-block::

    ``bpenable 3``
        Ativa o |pdi| com o índice 3.
    ``bpenable``
        Ativa todos os |pdis|.

|ret| :ref:`debugger-breakpoint-list`.


 .. _debugger-command-bplist:

bplist
------

**bplist** [<*CPU*>]

Lista os |pdis| existentes juntamente com seus índices e quaisquer
outras condições ou ações associadas. Caso nenhuma <*CPU*> esteja
definida, serão listados os |pdis| para todas as *CPUs* do sistema, caso
contrário, serão listados apenas os |pdis| numa determinada *CPU*.
A <*CPU*> pode ser definida pela etiqueta ou pelo número da *CPU* no
depurador (consulte o capítulo :ref:`debugger-devicespec` para obter
mais informações).

Exemplos:

.. line-block::

    ``bplist``
        |ltop|.
    ``bplist .``
        |ltop| em todas as *CPUs* disponíveis.
    ``bplist maincpu``
        |ltop| na *CPU* com o caminho absoluto da etiqueta ``:maincpu``.

|ret| :ref:`debugger-breakpoint-list`.

.. |ret| replace:: Retorna para
.. |pdi| replace:: ponto de interrupção
.. |pdis| replace:: pontos de interrupção
.. |ltop| replace:: Lista todos os |pdis|
.. |nace| replace:: na *CPU* que estiver visível
.. |ccts| replace:: caso contrário, todos serão
