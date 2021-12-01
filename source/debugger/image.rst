.. raw:: latex

	\clearpage


.. _debugger-image-list:

Comandos para a depuração de imagens
====================================

.. line-block::

    :ref:`debugger-command-images`
        Lista todos os dispositivos de imagem e todas as que estiverem montadas.
    :ref:`debugger-command-mount`
        Monta o arquivo da imagem num determinado dispositivo.
    :ref:`debugger-command-unmount`
        Desmonta a imagem.

.. _debugger-command-images:

images
------

**images**

Faz a listagem dos nomes das instâncias dos dispositivos de imagens de
mídia no sistema e as imagens montadas no momento, caso haja alguma.
Os nomes curtos das instâncias também são listados, |acpa|. Os itens da
lista de programa que estiverem montados são exibidos com um nome na
lista, com um nome curto do programa e da sua parte separados por
dois-pontos; outras imagens que estiverem montadas são mostradas como
nome de arquivo.

Exemplo:

.. line-block::

    ``images``
        Lista o nome da imagem e as imagens que estiverem montadas.

|ret| :ref:`debugger-image-list`.


.. _debugger-command-mount:

mount
-----

**mount** <*instância*>,<*nome_do_arquivo*>

Monta um arquivo num dispositivo. O dispositivo pode ser especificado
pela sua instância ou pelo seu nome curto, |acpa|.

Alguns dispositivos de mídia permitem que os itens da lista de programas
sejam montados usando este comando, ao oferecer um nome curto do item da
lista no lugar parâmetro <*nome_do_arquivo*>.

Exemplos:

.. line-block::

    ``mount flop1,os1xutls.td0``
        Monta o arquivo ``os1xutls.td0`` no dispositivo com o nome ``flop1``.
    ``mount cart,10yard``
        Monta o item da lista de programas ``10yard`` no dispositivo ``cart``.

|ret| :ref:`debugger-image-list`.


.. _debugger-command-unmount:

unmount
-------

**unmount <instance>**

Desmonta a imagem que estiver montada no dispositivo (caso haja alguma).
O dispositivo pode ser informado pelo seu nome completo ou nome curto,
|acpa|.

Exemplo:

.. line-block::

    ``unmount cart``
        Desmonta qualquer imagem que estiver montada com o nome ``cart``.

|ret| :ref:`debugger-image-list`.

.. |ret| replace:: Retorna para
.. |acpa| replace:: assim como é permitido através da linha de comando
