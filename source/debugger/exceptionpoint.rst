.. raw:: latex

	\clearpage


.. _debugger-exceptionpoint-list:

Comandos de depuração do ponto de exceção
=========================================

.. line-block::

    :ref:`debugger-command-epset`
        define um novo |pde|.
    :ref:`debugger-command-epclear`
        limpa um |pde| específico ou todos.
    :ref:`debugger-command-epdisable`
        desativa um |pde| específico ou todos.
    :ref:`debugger-command-epenable`
        ativa um |pde| específico ou todos.
    :ref:`debugger-command-eplist`
        lista os |pdes|.

Os |pdes| interrompem a execução e ativam a depuração quando uma CPU
gera uma exceção com número específico.


.. _debugger-command-epset:

epset
-----

**ep[set] <tipo>[,<condição>[,<ação>]]**

Define um novo |pde| do tipo <*tipo*>. O parâmetro da opção
<*condição*> permite que você defina uma expressão que pode ser
avaliada cada vez que um |pde| for atingido. Quando o resultado da
expressão for verdadeiro (não zero), o |pde| na verdade irá interromper
a execução no inicio da execução do manipulador; caso contrário, a
execução continuará sem qualquer outra notificação. O parâmetro da opção
<*ação*> permite que um comando seja executado sempre que o |pde| for
atingido e a <*condição*> seja verdadeira. Observe que talvez seja
necessário incorporar a ação entre chaves ``{}`` visando que as
vírgulas e o ponto e vírgula sejam interpretados como se fossem
aplicados ao próprio comando ``epset``.

A quantidade de exceções dependem do tipo da CPU. As causas das
exceções podem incluir interrupções vetorizadas sejam elas internas ou
externas, assim como, erros que ocorrem nas instruções e nas chamadas do
sistema.

Cada |pde| que for definido, recebe um índice que pode ser usado em
outros comandos de |pde| para fazer uma referência a este |pde|.


Exemplos:

.. line-block::

    ``ep 2``
        Define um |pde| que interromperá a execução sempre que a CPU
        visível gerar uma exceção número 2.

|ret| :ref:`debugger-exceptionpoint-list`


.. _debugger-command-epclear:

epclear
-------

**epclear [<epnum>[,…]]**

O comando *epclear* limpa os |pdes|. Quando um <*epnum*> é definido, são
limpos apenas os |pdes| requisitados, caso contrário, todos os |pdes|
serão limpos.


Exemplos:

.. line-block::

    ``epclear 3``
        Limpa o índice 3 do |pde|.

    ``epclear``
        Limpa todos os |pdes|.

|ret| :ref:`debugger-exceptionpoint-list`


.. _debugger-command-epdisable:

epdisable
---------

**epdisable [<epnum>[,…]]**

O comando *epdisable* desativa os |pdes|. Quando um <*epnum*> é
definido, apenas são desativados os |pdes| requisitados, caso contrário,
todos os |pdes| serão desativados. Observe que ao desativar um |pde|,
ele não é excluído, apenas o marca temporariamente como inativo.


Exemplos:

.. line-block::

    ``epdisable 3``
        Desativa o índice 3 do |pde|.

    ``epdisable``
        Desativa todos os |pdes|.

|ret| :ref:`debugger-exceptionpoint-list`


.. _debugger-command-epenable:

epenable
--------

**epenable [<epnum>[,…]]**

O comando *epenable* ativa os |pdes|. Quando um <*epnum*> é definido,
apenas são ativados os |pdes| requisitados, caso contrário, todos os
|pdes| serão ativados.


Exemplos:

.. line-block::

    ``epenable 3``
        Ativa o índice 3 do |pde|.

    ``epenable``
        Ativa todos os |pdes|.

|ret| :ref:`debugger-exceptionpoint-list`


.. _debugger-command-eplist:

eplist
------

**eplist**

O comando *eplist* lista todos os |pdes| atuais, junto com seus
respectivos índices, condições ou ações que forem anexadas a eles.

|ret| :ref:`debugger-exceptionpoint-list`

.. |pde| replace:: ponto de exceção
.. |pdes| replace:: pontos de exceção
.. |ret| replace:: Retorna para
