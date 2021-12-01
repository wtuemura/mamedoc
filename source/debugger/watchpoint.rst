.. raw:: latex

	\clearpage

.. _debugger-watchpoints-list:

Comandos do ponto de controle do depurador
==========================================

.. line-block::

    :ref:`debugger-command-wpset`
        Define o |pdc| do acesso da memória.
    :ref:`debugger-command-wpclear`
        Apaga os |pdcs|.
    :ref:`debugger-command-wpdisable`
        Desativa os |pdcs|.
    :ref:`debugger-command-wpenable`
        Ativa os |pdcs|.
    :ref:`debugger-command-wplist`
        Lista os |pdcs|.

Os |pdcs| [#watchpoint]_ interrompe a execução do depurador quando uma
*CPU* acessa um ponto numa determinada faixa da memória.

.. [#watchpoint]	Watchpoint no Inglês.

.. _debugger-command-wpset:

wpset
-----

**wp[{d|i|o}][set]** <*endereço*>[:<*faixa*>],<*comprimento*>,<*tipo*>[,<*condição*>[,<*ação*>]]

Define um novo |pdc| iniciando em determinado <*endereço*> que se
estende através do parâmetro <*comprimento*>. Toda a faixa do |pdc| é o
<*endereço*> através do <*endereço*>+<*comprimento*>-1, inclusive. O
<*endereço*> pode ser opcionalmente seguido pela |fde| da *CPU*
(consulte :ref:`debugger-devicespec` para obter mais detalhes). Quando
nenhuma |fde| for definida, |osdc|. O comando ``wpset`` retorna a
primeira |fde| que for exposta pela *CPU*, ``wpdset`` |rfi| 1 (dados),
``wpiset`` |rfi| 2 (E/S), já ``wposet`` |rfi| 3 (*opcodes*). O parâmetro
<*tipo*> determina o tipo de acesso que serão retidos, ele pode ser um
destes 3 valores ``r`` para os acessos de leitura, ``w`` para os acessos
para a escrita ou ``rw`` para ambos os acessos de leitura e escrita.

Já o parâmetro opcional <*condição*> permite que uma expressão seja
definida para que ela seja avaliada cada vez que um |pdc| seja
alcançado. Quando o resultado da expressão for verdadeiro (não zero) o
|pdc| interromperá a execução, caso contrário, a execução continuará sem
qualquer notificação. O parâmetro opcional <*ação*> oferece um comando
para ser executado sempre que um |pdc| seja alcançado e a <*condição*>
seja verdadeira. |oqts| ``wpset``.

Cada |pdc| que for definido é atribuído a um índice numérico que pode
ser utilizado como referência em outros comandos do |pdc|. Durante a
sessão os índices do |pdc| são únicos.

Duas variáves estão disponíveis para tornar as expressões <*condição*>
mais uteis: para todos os |pdcs|, a variável ``wpaddr`` é definido no
endereço de acesso que foi alcançado; para a gravação no |pdc|, a
variável ``wpdata`` é definida nos dados que estão sendo gravados.

Exemplos:

.. line-block::

    ``wp 1234,6,rw``
        |duqi| sempre que uma leitura ou escrita acontecer na primeira faixa de endereço entre ``1234-1239``.
    ``wp 23456:data,a,w,wpdata == 1``
        |duqi| sempre que uma gravação ocorrer no espaço ``data`` na faixa de endereço entre ``23456-2345f`` e a gravação dos dados seja igual à ``1``.
    ``wp 3456:maincpu,20,r,1,{ printf "Read @ %08X\n",wpaddr ; g }``
        Define um |pdc| na *CPU* |ccad| ``:maincpu`` a execução será interrompida sempre que ocorrer uma leitura na primeira faixa de endereço entre ``3456-3475``. Quando ocorrer, imprima ``Read @ <wpaddr>`` no console do depurador e a execução é resumida.
    ``temp0 = 0 ; wp 45678,1,w,wpdata==f0,{ temp0++ ; g }``
        Define um |pdc| na *CPU* que estiver visível que interromperá a execução sempre que ocorrer uma gravação no endereço ``45678`` e onde o valor que será escrito seja igual à ``f0``. Quando ocorrer, incremente o valor ``temp0`` e  a execução é resumida.

|ret| :ref:`debugger-watchpoints-list`.


.. _debugger-command-wpclear:

wpclear
-------

**wpclear** [<*wpnum*>[,…]]

Apaga os |pdcs|. Quando o <*wpnum*> for definido, as referências dos
|pdcs| serão apagadas. Ao não ser definido, todos os |pdcs| serão
apagados.

Exemplos:

.. line-block::

    ``wpclear 3``
        Apaga o |pdc| com o índice ``3``.
    ``wpclear``
        Apaga todos os |pdcs|.

|ret| :ref:`debugger-watchpoints-list`.


.. _debugger-command-wpdisable:

wpdisable
---------

**wpdisable** [<*wpnum*>[,…]]

Desativa os |pdcs|. Quando o <*wpnum*> for definido, as referências dos
|pdcs| serão desativadas. Ao não ser definido, todos os |pdcs| serão
desativados.

Observe que ao desativar um |pdc| ele não é excluído, marca
temporariamente o |pdc| como inativo. Os |pdcs| que forem desativados
não causam a interrupção da execução, as condições associadas às
expressões não serão avaliadas e seus respectivos comandos não serão
executados.

Exemplos:

.. line-block::

    ``wpdisable 3``
        Desativa o |pdc| com o índice ``3``.
    ``wpdisable``
        Desativa todos os |pdcs|.

|ret| :ref:`debugger-watchpoints-list`.


.. _debugger-command-wpenable:

wpenable
--------

**wpenable** [<*wpnum*>[,…]]

Ativa os |pdcs|. Quando o <*wpnum*> for definido, as referências dos
|pdcs| serão ativadas. Ao não ser definido, todos os |pdcs| serão
ativados.

Exemplos:

.. line-block::

    ``wpenable 3``
        Ativa o |pdc| com o índice ``3``.
    ``wpenable``
        Ativa todos os |pdcs|.

|ret| :ref:`debugger-watchpoints-list`.


.. _debugger-command-wplist:

wplist
------

**wplist** [<*CPU*>]

Lista os |pdcs| atuais junto com seus índices e quaisquer ações ou
condições associadas. Quando nenhuma <*CPU*> for definida, os |pdcs| em
todas as *CPUs* do sistema serão listadas, ao ser definida, apenas os
|pdcs| para esta *CPU* será listada. A <*CPU*> pode ser determinada por
uma etiqueta ou através de um número do depurador. (consulte
:ref:`debugger-devicespec` para obter mais detalhes).

Exemplos:

.. line-block::

    ``wplist``
        Lista todos os |pdcs|.
    ``wplist .``
        Lista todos os |pdcs| para a *CPU* que estiver visível.
    ``wplist maincpu``
        Lista todos os |pdcs| para a *CPU* |ccad| ``:maincpu``.

|ret| :ref:`debugger-watchpoints-list`.


.. |pdc| replace:: ponto de controle
.. |pdcs| replace:: pontos de controle
.. |ret| replace:: Retorna para
.. |fde| replace:: faixa de endereços
.. |osdc| replace:: o sufixo do comando define a faixa do endereço
.. |oqts| replace:: Observe que talvez seja necessário cercar a ação
   dentro de chaves ``{`` ``}`` garantindo que as vírgulas e os
   ponto-e-vírgulas dentro do comando não sejam interpretadas no
   contexto do próprio comando
.. |rfi| replace:: retorna para a faixa do índice
.. |duqi| replace:: Define um |pdc| que interromperá uma execução na *CPU* que estiver visível
.. |ccad| replace:: com o caminho absoluto da etiqueta
