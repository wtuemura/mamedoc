.. _debugger-registerpoints-list:

Comandos do ponto de identificação
==================================

.. line-block::

    :ref:`debugger-command-rpset`
        Define um |pdi| [#pdi]_ que será disparado quando atingir uma <*condição*>.
    :ref:`debugger-command-rpclear`
        Limpa os |pdis|.
    :ref:`debugger-command-rpdisable`
        Desativa um |pdi|.
    :ref:`debugger-command-rpenable`
        Ativa um |pdi|.
    :ref:`debugger-command-rplist`
        Lista os |pdis|.

.. [#pdi]	Registerpoint no Inglês.

Os |pdis| avaliam uma expressão cada vez que a *CPU* executa uma
instrução interrompendo-a e ativando o depurador caso o seu resultado
seja verdadeiro (igual a um).


.. _debugger-command-rpset:

rpset
-----

**rp[set]** <*condição*>[,<*ação*>]

Define um novo |pdi| que será iniciado quando a <*ação*> informada for
verdadeira (igual a um). Para prevenir que a <*condição*> seja
interpretada como uma atribuição, ela deve ser cercada por ``{`` ``}``.
O parâmetro opcional <*ação*> oferece um comando que será executado
sempre que um |pdi| for disparado. |oqts| ``rpset``.

Cada |pdi| que for definido será atribuído a um índice numérico que pode
ser utilizado como referência em outros comandos do |pdi| e seus índices
são únicos durante a seção.

Exemplos:

.. line-block::

    ``rp {PC==150}``
        Define um |pdi| que irá interromper a execução, sempre que o registro **PC** for igual a ``150``.
    ``temp0=0; rp {PC==150},{temp0++; g}``
        Define um |pdi| que aumentara o valor da variável ``temp0`` sempre que o registro **PC** for igual a ``150``.
    ``rp {temp0==5}``
        Define um |pdi| que irá interromper a execução sempre que a variável ``temp0`` for igual a ``150``.

|ret| :ref:`debugger-registerpoints-list`.


.. _debugger-command-rpclear:

rpclear
-------

**rpclear** [<*rpnum*>,[,…]]

Limpa os |pdis|. Quando um <*rpnum*> é definido, apenas essa referência
será limpa, caso contrário, todos serão.

Exemplos:

.. line-block::

    ``rpclear 3``
        Limpa o |pdi| com o índice 3.
    ``rpclear``
        Limpa todos os |pdis|.

|ret| :ref:`debugger-registerpoints-list`.


.. _debugger-command-rpdisable:

rpdisable
---------

**rpdisable** [<*rpnum*>[,…]]

Desativa os |pdis|. Quando um <*rpnum*> é definido, apenas essa
referência será desativada, caso contrário, todas serão.

Observe que ao desativar um |pdi| ele não é excluído, apenas marca
temporariamente |pdi| como inativo. Os |pdis| que forem desativados não
causam a interrupção da execução, as condições associadas às expressões
não serão avaliadas e seus respectivos comandos não serão executados.

Exemplos:

.. line-block::

    ``rpdisable 3``
        Desativa o |pdi| com o índice 3.
    ``rpdisable``
        Desativa todos os |pdis|.

|ret| :ref:`debugger-registerpoints-list`.


.. _debugger-command-rpenable:

rpenable
--------

**rpenable** [<*rpnum*>[,…]]

Ativa os |pdis|. Quando um <*rpnum*> é definido, apenas essa
referência será ativada, caso contrário, todas serão.

Exemplos:

.. line-block::

    ``rpenable 3``
        Ativa o |pdi| com o índice 3.
    ``rpenable``
        Ativa todos os |pdis|.

|ret| :ref:`debugger-registerpoints-list`.


.. _debugger-command-rplist:

rplist
------

**rplist** [<*CPU*>]

Lista todos os |pdis| atuais junto com seus respectivos índices,
condições e ações associadas. Quando nenhuma <*CPU*> é definida, os
|pdis| de todas as *CPUs* do sistema serão listadas. A <*CPU*> pode ser
determinada por uma etiqueta ou pelo número da *CPU* no depurador
(|cpom|).

Exemplos:

.. line-block::

    ``rplist``
        Lista todos os |pdis|.
    ``rplist .``
        Lista todos os |pdis| na *CPU* que estiver visível.
    ``rplist maincpu``
        Lista todos os |pdis| na *CPU* |ccad| ``:maincpu``.

|ret| :ref:`debugger-registerpoints-list`.

.. |ret| replace:: Retorna para
.. |pdi| replace:: ponto de identificação
.. |pdis| replace:: pontos de identificação
.. |oqts| replace:: Observe que talvez seja necessário cercar a ação
   dentro de chaves ``{`` ``}`` garantindo que as vírgulas e os
   ponto-e-vírgulas dentro do comando não sejam interpretadas no
   contexto do próprio comando
.. |cpom| replace:: consulte :ref:`debugger-devicespec` para obter mais
   detalhes
.. |ccad| replace:: com o caminho absoluto da etiqueta
