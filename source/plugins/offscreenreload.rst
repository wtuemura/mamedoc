.. _plugins-offscreenreload:

Assistente de recarga fora da tela
==================================

.. contents:: :local:


.. _plugins-offscreenreload-intro:

Introdução
----------

O assistente de recarga fora da tela (*Off-Screen Reload Helper*) é um
plug-in que facilita a jogabilidade de jogos que exigem apontar uma pistola de
luz para fora da tela para recarregar a arma. Com ele é possível usar
uma combinação de teclas ou botões para simular essa ação.

É preciso ativá-lo antes de utilizá-lo (consulte
:ref:`plugins-using`). Para configurá-lo, pressione :kbd:`Tab` durante a
emulação para abrir o menu principal, selecione :guilabel:`Opções dos
plug-ins` e, em seguida, selecione :guilabel:`Assistente de recarga fora
da tela`. Se já houver assistentes configurados para o sistema atual,
eles serão listados junto com suas sequências de ativação. Inicialmente,
não haverá nenhum configurado. Para configurar um novo assistente, faça
um clique duplo em :guilabel:`Add reload helper`. Consulte o capítulo
:ref:`plugins-offscreenreload-settings` para saber mais detalhes sobre
como editá-lo. Para excluir um auxiliar de recarga, destaque-o no menu e
pressione a tecla predefinida para :guilabel:`UI Clear` (:kbd:`Del`,
:kbd:`Delete`, :kbd:`Forward`). A tecla padrão do teclado é a tecla
:kbd:`Del`. Como alternativa, também é possível excluir um assistente de
recarga selecionando-o para edição e, em seguida, escolhendo
:guilabel:`Excluir o assistente` no menu.

Este plug-in funciona com jogos que reconhecem a condição de puxar o
gatilho da pistola de luz enquanto um dos eixos dela reporta o seu valor
mínimo. Isso inclui *Lethal Enforcers* e *Virtua Cop*, por exemplo.
Alguns jogos, como *Invasion: The Abductors*, têm requisitos de recarga
mais complexos. Este plug-in não é adequado para esses jogos, mas você
pode usar o :ref:`Input Macro plugin <plugins-inputmacro>` para
recarregar facilmente com uma combinação de teclas ou botões.

Os assistentes são salvos dentro da pasta **offscreenreload** (consulte
o capítulo sobre a opção :ref:`homepath <mame-commandline-homepath>`).
É criado um arquivo para cada nome do sistema (ou nome da ROM), com a
extensão ``.cfg``. Por exemplo, as macros de entrada para a versão
principal do jogo **Lethal Enforcers** serão salvas no arquivo
**lethalen.cfg** dentro da pasta **offscreenreload**. Os assistentes de
recarga são armazenados em formato **JSON**.


.. _plugins-offscreenreload-settings:

Editando o assistente de recarga
--------------------------------

As opções para editar os assistentes de recarga são as mesmas, tanto
para a criação de um novo quanto para a edição de um já existente.
Um assistente de recarga requer um *eixo* (geralmente o eixo Y para a
arma do jogador) e um *gatilho* (geralmente o botão 1 para o jogador,
correspondente ao gatilho da arma).

* Selecione :guilabel:`Botão ou combinação` para definir o controle (ou
  a combinação deles) que deseja usar para ativar o assistente. É
  preferível utilizar uma combinação que já não esteja sendo usada por
  qualquer outra entrada no sistema.
* Selecione :guilabel:`Eixo` para definir o eixo de entrada (geralmente
  :guilabel:`Pistola de luz Y` para o jogador 1 ou
  :guilabel:`Pistola de luz 2 Y` para o jogador 2). São suportadas
  apenas entradas analógicas sem encapsulamento.
* Selecione :guilabel:`Gatilho` para definir o botão de gatilho
  que ativará o assistente (geralmente :guilabel:`P1 Botão 1` para o
  jogador 1 e :guilabel:`P2 Botão 1` para o jogador 2). Apenas entradas
  digitais não alternáveis são compatíveis. O plug-in tenta adivinhar a
  entrada do gatilho quando a entrada do eixo é alterada.


.. raw:: latex

	\clearpage


Ao criar um novo assistente de recarga, a opção :guilabel:`Cancelar` é
substituída para :guilabel:`Criar` após a definição da combinação de
recarga, da entrada do eixo e da entrada do gatilho. Selecione
:guilabel:`Criar` para concluir a criação do assistente e retornar à
lista de assistentes. O novo assistente será adicionado ao final da
lista. Para cancelar sua criação, pressione a tecla :guilabel:`Esc`
antes de definir a sequência/entradas de recarga, para retornar ao menu
anterior.

Ao editar um assistente já existente, selecione :guilabel:`Concluído` ou
pressione a tecla :kbd:`Esc` para retornar à lista de assistentes de
recarga. As alterações entram em vigor imediatamente.

Ao editar um assistente de recarga, pressione a tecla :kbd:`Del` para
excluí-lo. Ele será excluído imediatamente, sem a necessidade de
confirmação adicional. Também é possível excluir um assistente
destacando-o na lista de assistentes de recarga e pressione a tecla
predefinida para :guilabel:`UI Clear` (:kbd:`Del`, :kbd:`Delete`,
:kbd:`Forward`). A tecla padrão do teclado é a tecla :kbd:`Del`.
