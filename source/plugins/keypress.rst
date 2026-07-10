.. _plugins-keypress:

Keypress Display Plugin
========================

O plugin "Keypress" exibe na tela, por meio de mensagens pop-up do MAME,
os nomes de todos os botões que forem pressionados. Ele é útil para
gravar partidas, rastrear as ações do jogador e diagnosticar problemas
de mapeamento de botões.

Para ativá-lo, use a :ref:`opção de plug-in <mame-commandline-plugin>`
na linha de comando:

.. code-block:: shell

    mame <system> -plugin keypress

Ou através da interface principal do MAME, para mais informações
consulte o capítulo :ref:`plugins-using`.

Enquanto o plug-in estiver ativo, quaisquer teclas, botões ou outros
elementos de entrada que forem pressionados, eles serão exibidos como
uma lista separada por espaços na parte de baixo da tela. A mensagem
desaparecerá automaticamente ao liberar as entradas.
