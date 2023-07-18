.. _plugins:

PLUG-INS
========

.. contents:: :local:


.. _plugins-intro:

Introdução
----------

Os plug-ins externos oferecem funcionalidades adicionais ao MAME, eles
foram escritos de maneira a se comunicarem com programas ou plataformas
externas, jogar jogos de forma autônoma, exibir estruturas internas do
jogo, como hitbox [#HITBOX]_, fornecer interfaces alternativas so usuário, e
realizar testes automáticos da emulação.  Consulte :ref:`luascript` para
obter mais informações sobre a API Lua do MAME.

..  [#HITBOX]	São regiões delimitadoras que quando ultrapassadas o jogo
				identifica um contato. Consulte `este exemplo <https://www.tecmundo.com.br/voxel/especiais/182960-hitboxes-e-frames-entenda-como-funcionam-os-jogos-de-luta.htm>`_
				para mais informações e ilustrações sobre o assunto.


.. _plugins-using:

Usando os plug-ins
------------------

Para ativar os plug-ins é preciso ligar a opção
:ref:`plugins <mame-commandline-plugins>` e confira se a opção
:ref:`opção pluginspath <mame-commandline-pluginspath>` incluí o caminho
a pasta onde os seus plug-ins estão. Também é possível configurar os
plug-ins num arquivo INI ou através da linha de comando. Ao entrar em
:guilabel:`Configurações` --> :guilabel:`Configuração dos diretórios`
--> :guilabel:`plugins` é possível definir o caminho dos seus plug-ins.

Diversos plug-ins precisam armazenar configurações e/ou dados, a opção
:ref:`homepath <mame-commandline-homepath>` define onde estes dados
serão armazenados (é predefinido que seja armazenado na mesma pasta de
trabalho do MAME). É possível alterar esta opção em
:guilabel:`Configurações` --> :guilabel:`Configuração dos diretórios`
--> :guilabel:`Dados do plug-in`.

Antes de tentar ligar ou desligar um plug-in específico, tenha certeza
que ele está ativo, uma vez ativo talvez seja preciso encerrar e iniciar
o MAME novamente para que o plug-in surta efeito, não é preciso fazer
isso para o plug-in de **Trapaça**, porém, outros podem precisar dessa
reinicialização. Também é possível usar a opção
:ref:`plugin <mame-commandline-plugin>` através da linha de comando ou
alterando as configurações no arquivo ``plugi.ini``.

Caso algum plug-in ativo precise de uma configuração adicional ou
precise mostrar algum tipo de informação uma **Opção do plug-in** deverá
aparecer no menu principal (acessado através da tecla :kbd:`Tab` durante
a emulação).


.. _plugins-included:

Plug-ins inclusos
-----------------

MAME inclui vários plug-ins que proporcionam uma funcionalidade útil e
servem como exemplo de código que pode ser usado como um ponto de
partida ao escrever os seus próprios plug-ins.

.. toctree::
    :titlesonly:

    autofire
    console
    data
    discord
    dummy
    gdbstub
    hiscore
    inputmacro
    layout
    timecode
    timer
