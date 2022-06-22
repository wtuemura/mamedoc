.. _plugins-autofire:

Autofire Plugin
===============

.. contents:: :local:


.. _plugins-autofire-intro:

Introdução
----------

O *autofire plugin* permite simular um botão turbo (disparo automático),
pode ser útil para pessoas com alguma deficiência ou lesões em jogos de
tiro ou onde é preciso pressionar o botão repetidas vezes, e pode também
auxiliar na prevenção de lesões por esforço repetitivo por exemplo.

Para configurar o plug-in pressione :kbd:`Tab` durante a emulação,
selecione :guilabel:`Opções dos plug-ins` --> :guilabel:`Turbo`. O MAME
não vem com nenhum botão turbo configurado, ao clicar duas vezes em
:guilabel:`Adiciona um botão turbo`, você tem as opções para a
configurações do botão, consulte :ref:`plugins-autofire-settings` para
mais detalhes dessa configuração. Quando não quiser mais a configuração,
destaque o botão que deseja excluir e clique em :kbd:`Del`.

Todas as configurações do turbo são salvas na pasta **autofire** dentro
da pasta designada para os dados do plug-in
(consulte :ref:`homepath option <mame-commandline-homepath>`). Ali
ficam armazenados arquivos de configuração para cada sistema, a
nomenclatura usada é o nome da ROM com a extensão ``.cfg``. Por exemplo,
a configuração de um botão turbo para **Super-X** é salvo como
``superx.cfg``, o conteúdo do arquivo tem o formato JSON.


.. _plugins-autofire-settings:

Configurando os botões turbo
----------------------------

Ambas as opções para adicionar um novo botão turbo como para alterar as
suas configurações são as mesmas.

Depois de entrar na opção :guilabel:`Adiciona um botão turbo`, clique
duas vezes em :guilabel:`Entrada`, dessa lista, faça um clique duplo no
botão que deseja ativar o turbo, em seguida escolha a
:guilabel:`Tecla de atalho`, esta tecla pode ser uma tecla do teclado ou
um botão qualquer do seu controle. Note porém que você não pode usar o
mesmo botão já predefinido pelo MAME.

As opções :guilabel:`Quadros ligados` e :guilabel:`Quadros desligados`
definem a quantidade dos quadros que o botão deve permanecer pressionado
e quando deve ser liberado, o ajuste pode ser feito com as teclas
:kbd:`esquerda` / :kbd:`direita` do teclado ou usando as setas ao lado
da opção, para retornar aos valores originais, use a tecla :kbd:`Del`.
Ao concluir a configuração clique em :guilabel:`Crie` para criar o seu
botão turbo.

Quanto menor o valor, mais rápido é o tubo, quanto maior o valor, mais
lento ele fica. Observe que nem todos os sistemas podem aceitar valores
muito baixos (rápido), para que o turbo surta efeito no sistema Alcon
por exemplo, é preciso configurar os valores como 2 **quadros ligados**
e 2 **quadros desligados**. Ao concluir a configuração, pressione
:kbd:`Tab` para retornar para a emulação.
Experimente diferentes valores para obter os melhores resultados.

Se durante o teste o turbo não agir da forma desejada, retorne para a
opção e clique duas vezes no botão para alterar as suas configurações.


.. _plugins-autofire-notes:

Observações e possíveis imprevistos
-----------------------------------

Os botões turbo agem como se estivessem conectados em paralelo
com as entradas convencionais do MAME. Isso significa que caso defina
um atalho para o botão turbi no mesmo botão ou chave que também é
atribuída diretamente a uma das entradas emuladas, você pode obter
resultados inesperados. Usando Gradius como exemplo:

* Vamos supor que você atribuiu o **botão 1** do seu controle como tiro
  e também definiu ele como turbo. Ao manter o botão de tiro pressionado
  ele nunca será liberado e o turbo para de funcionar, o mesmo acontece
  caso defina um outro botão qualquer como turbo (**botão 3** por
  exemplo) e mantenha o **botão 1** e o **botão 3** pressionados ao
  mesmo tempo.
* Caso tenha definido o **botão 3** como turbo e ele também esteja
  definido como *powerup*, a ação vai sempre ativar o *powerup* pois
  internamente é como se este botão estivesse sempre pressionado.

Por isso que é referível escolher um outro botão qualquer e não aqueles
que já estejam sendo usado pela emulação.

Usar um outro botão como turbo é útil, em jogos onde é preciso manter o
botão de tiro pressionado para liberar um tiro com maior poder de fogo
(*Raiden Fighters* por exemplo), assim, usar um outro botão com a função
turbo acaba sendo uma necessidade [#TURBO]_.

..  [#TURBO]	Nas versões mais antigas do MAME, o processo era muito
				mais simples, bastava ativar o turbo no botão que queria
				usar, porém a função foi removida no
				`MAME 0.216 <https://github.com/mamedev/mame/commit/90fe1e649a7bc9ea667de249736062d5dea21f7a>`_ .
				Com a função removida, não dá mais para usar o botão que
				já funcionava como tiro, agora é preciso escolher um
				botão diferente. ``(o_O)!``
