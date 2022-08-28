.. raw:: latex

	\clearpage


.. _debugger-annotation-list:

Comandos da anotação do código do depurador
===========================================

.. line-block::

    :ref:`debugger-command-comadd`
        Inclui um comentário num determinado endereço do código desmontado.
    :ref:`debugger-command-comdelete`
        Remove o comentário de um determinado endereço.
    :ref:`debugger-command-comsave`
        Salva o comentário atual num arquivo.
    :ref:`debugger-command-comlist`
        Imprime os comentários disponíveis a partir de um arquivo.
    :ref:`debugger-command-commit`
        Aplica um ``comadd`` seguido de ``comsave``

.. _debugger-command-comadd:

comadd
------

**comadd** <*endereço*>,<*comentário*>

Define o comentário indicado num determinado endereço do código
desmontado |nace|. Este comando pode ser abreviado para ``//``.

Exemplos:

.. line-block::

    ``comadd 0,hello world.``
        Inclui o comentário "hello world." ao código no endereço ``0``.
    ``// 10,opcode não documentado!``
        Inclui o comentário "**opcode não documentado!**" ao código no endereço ``10``.

|ret| :ref:`debugger-annotation-list`.


 .. _debugger-command-comdelete:

comdelete
---------

**comdelete**

Excluí determinado endereço |nace|.

Exemplo:

.. line-block::

    ``comdelete 10``
        Excluí o comentário do código no endereço ``10`` |nace|.

|ret| :ref:`debugger-annotation-list`.

 .. _debugger-command-comsave:

comsave
-------

Grava os comentários atuais no arquivo de comentários XML para o sistema
emulado. Este arquivo será carregado pelo depurador na próxima vez em
que o sistema for executado com a depuração ativada. A opção que define
onde estes arquivos são salvos é definido pela opção
:ref:`comment_directory <mame-commandline-commentdirectory>`.

Exemplo:

.. line-block::

    ``comsave``
        Grava os comentários atuais no arquivo de comentários do sistema.

|ret| :ref:`debugger-annotation-list`.


 .. _debugger-command-comlist:

comlist
-------

Faz a leitura dos comentários armazenados no arquivo de comentário XML
para o sistema emulado e os imprime no console de depuração. Este
comando não afeta os comentários da sessão atual pois faz a leitura
direta do arquivo. A opção que define onde estes arquivos são salvos é
definido pela opção
:ref:`comment_directory <mame-commandline-commentdirectory>`.

Exemplo:

.. line-block::

    ``comlist``
        Mostra os comentários armazenados num arquivo de comentário do sistema.

|ret| :ref:`debugger-annotation-list`.


 .. _debugger-command-commit:

commit
------

**commit** <*endereço*>,<*comentário*>

Define o comentário indicado em determinado endereço no código
desmontado |nace| e grava os comentários no arquivo para o sistema que
estiver sendo emulado no momento. (é equivalente ao comando
:ref:`debugger-command-comadd` seguido de
:ref:`debugger-command-comsave`). Este comando pode ser abreviado para
``/*``.

Exemplos:

.. line-block::

    ``commit 0,hello world.``
        Inclui o comentário "hello world." ao código no endereço ``0`` |nace| e salva os comentários.
    ``/* 10,opcode não documentado!``
        Inclui o comentário "opcode não documentado!" ao código no endereço ``10`` |nace| e salva os comentários.

|ret| :ref:`debugger-annotation-list`.

.. |ret| replace:: Retorna para
.. |nace| replace:: na *CPU* que estiver visível
