.. _ui:

A interface de usuário
======================

.. contents:: :local:


.. _ui-intro:

Introdução
----------

O MAME oferece uma interface de usuário simples para que seja possível
selecionar ou executar um sistema ou um programa, assim como, para
alterar as configurações durante a emulação de um sistema. A interface
foi projetada para ser utilizável com um teclado, com um controle ou
com algo que seja possível apontar na tela (mouse, pistola, etc), porém,
é preciso um teclado para as configurações iniciais.

As configurações predefinidas mais importantes para os controles que
precisam ser conhecidos durante a execução de uma emulação  e as
configurações correspondentes no caso de se desejar alterá-las são as
seguintes:

:kbd:`ScrLk` (Scroll Lock) ou **Forward Delete** no macOS (IU Alterna)
    Durante a emulação de sistemas com teclado, ativa ou desativa os
    controles da interface. O MAME iniciar com os controles da interface
    desativados nos sistemas que usam teclados, a não ser que a opção
    :ref:`ui_active <mame-commandline-uiactive>` esteja ligada.
:kbd:`Tab` (Menu de configuração)
    Mostra ou esconde o menu durante a emulação.
:kbd:`Esc` (UI Cancela)
    Retorna para a seleção de sistemas ou encerra o MAME caso ele tenha
    sido iniciado com um determinado sistema (a partir da linha de
    comando ou caso esteja usando um
    :ref:`front-end <frontends>` externo.


.. _ui-menus:

Navegando pelos menus
---------------------

É predefinido que seja possível navegar pela interface do MAME usando os
cursores do teclado. Todos os controles da interface podem ser alteradas
na opção :guilabel:`Todas as entradas` --> :guilabel:`Interface do
usuário`. Como padrão o MAME utiliza o US ANSI QWERTY como mapeamento do
teclado, consulte o capítulo :ref:`default-comparative-kbd` para ver as
diferenças entre o teclado Americano e o ABNT-2 usado no Brasil.

As configurações correspondentes com o mapeamento padrão do teclado são:

Seta :kbd:`cima` (IU Cima)
    Destaca o item anterior ou o último caso o primeiro esteja
    destacado.
Seta :kbd:`baixo` (IU Baixo)
    Destaca o próximo item da lista ou o primeiro caso o último esteja
    destacado.
Seta :kbd:`esquerda` (IU Esquerda)
    For menu items that are adjustable settings, reduce the value or select the
    previous setting (these menu items show left- and right-facing triangles
    beside the value).
Seta :kbd:`direita` (IU Direita)
    Para itens do menu que podem ser ajustados, seus valores podem ser
    incrementados ou selecionados para a próxima configuração (tais
    configurações mostram setas indicativas).
:kbd:`Enter` / :kbd:`Return` e :kbd:`Enter` do teclado numérico (UI Seleciona)
    Seleciona o item em destaque.
Forward Delete ou :kbd:`Fn` + :kbd:`Delete` em alguns teclados compactos (UI Limpa)
    Limpa a configuração ou redefine para o valor predefinido
:kbd:`Esc` (UI Cancela)
    Fecha o menu, retorna para o menu anterior ou retorna para a
    emulação no menu principal (também há um item na parte do menu que
    funciona igual).
:kbd:`Home` (UI Home)
    Destaca o primeiro item e rola para o topo do menu.
:kbd:`End` (UI End)
    Destaca o último item e rola para a parte debaixo do menu.
:kbd:`PgUp` (UI Pág. cima)
    Rola a página do menu para cima.
:kbd:`PgDn` (UI Pág. baixo)
    Rola a página do menu para baixo.
:kbd:`[` (UI Grupo anterior)
    Move os itens do grupo anterior (não é utilizado em todos os menus).
:kbd:`]` (UI Próximo grupo)
    Move o próximo item do grupo (não é utilizado em todos os menus).


.. _ui-menus-gamectrl:

Usando um controle
~~~~~~~~~~~~~~~~~~

É possível navegar na interface do MAME usando um controle ou joystick.
Por predefinição, apenas os controles mais importantes da interface têm
atribuições do joystick:

* Mova o controle do joystik para cima ou para baixo no eixo y para
  destacar próximo item ou o item anterior.
* Mova o controle do joystik para esquerda ou para direita no eixo x
  para ajustar a configurações.
* Pressione o primeiro botão no primeiro joystick para selecionar o item
  destacado.

Para que seja possível usar o MAME com um controle joystick sem um
teclado, é preciso definir os botões do joystick (ou a combinação dos
seus botões) para estes controles também:

* :guilabel:`Menu de configuração` / :kbd:`Tab`

	Para mostrar ou dispensar o menu durante a emulação

* :guilabel:`UI Cancela`

	Para fechar os menus, retornar para a tela de seleção, para encerar
	a emulação ou para fechar o MAME.

* :guilabel:`UI Limpa`

	Não é basicamente essencial para a emulação, porém é usado para
	limpar ou redefinir algumas configurações.

* :guilabel:`UI Home`, :guilabel:`UI End`, :guilabel:`UI Pág. cima`,
  :guilabel:`UI Pág. baixo`, :guilabel:`UI Grupo anterior` e
  :guilabel:`UI Próximo grupo`

	Não são essenciais, contudo, tornam a navegação mais fácil em alguns
	menus.

Caso não esteja usando um front-end externo para rodar os sistemas no
MAME, atribua os botões do joystick (ou combinações dos botões) nestes
controles para fazer pleno uso dos menus de seleção do sistema:

* :guilabel:`IU Próx. foco`, :guilabel:`IU Foco ant.`

	Para navegar entre os painéis.

* :guilabel:`IU Adiciona/remove favoritos`, :guilabel:`IU Exporta lista`
  :guilabel:`IU Audita mídia`

	Caso queira acessar estes recursos sem um teclado ou mouse.


.. _ui-menus-mouse:

Usando um mouse ou trackball
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

MAME suporta a navegação através dos menus usando um mouse ou trackball
que funciona como um dispositivo apontador no sistema:

* Clique nos itens do menu para destacá-los.
* Faça um clique duplo para selecioná-los
* Clique nas setas da esquerda/direita para ajustar as configurações.
* Para menus com muitos itens que não caibam na tela, use as setas
  cima/baixo para rolar as opções.
* Use gestos de rolagem vertical para rolar os menus ou as caixas de
  texto com muitos itens para que elas caibam na tela.
* Clique nos itens da barra de ferramentas para selecioná-los ou passe
  o mouse sobre eles para ver uma descrição.

Caso tenha botões adicionais no mouse, talvez queira atribuir
combinações dos botões para o :guilabel:`Menu de configuração` /
:kbd:`Tab`, :guilabel:`Pausa` e/ou :guilabel:`IU Cancela` para que seja
possível usar o MAME sem usar um teclado.
