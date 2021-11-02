.. _ui:

A interface do usuário
======================

.. contents:: :local:


.. _ui-intro:

Introdução
----------

O MAME oferece uma simples interface ao usuário para que seja
intuitivo selecionar, rodar um sistema ou um programa; assim como,
alterar as configurações durante a emulação de um sistema. A interface
foi projetada para ser utilizável com um teclado, com um controle ou
com algo que seja possível apontar na tela (mouse, pistola, etc), porém,
um teclado é necessário para realizar as configurações iniciais.

As configurações predefinidas mais importantes da interface são as
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
usuário`. Como padrão, o MAME utiliza o US ANSI QWERTY como mapeamento
do teclado, consulte o capítulo :ref:`default-comparative-kbd` para ver
as diferenças entre o teclado Americano e o ABNT-2 usado no Brasil.

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
    Limpa o campo de busca, caso contrário, fecha o menu, retorna ao
    menu anterior ou retorna para a emulação no menu principal (também
    há um item na parte do menu que funciona igual).
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

* :guilabel:`Menu de configuração` / :guilabel:`Tab`

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

* :guilabel:`IU Adiciona/Remove favoritos`, :guilabel:`IU Exporta lista`
  :guilabel:`IU Audita mídia`

	Caso queira acessar estes recursos sem um teclado ou mouse.


.. _ui-menus-mouse:

Usando um mouse ou trackball
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

MAME suporta a navegação através dos menus usando um mouse ou
*trackball* que funciona como um dispositivo apontador no sistema:

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
:guilabel:`Tab`, :guilabel:`Pausa` e/ou :guilabel:`IU Cancela` para que
seja possível usar o MAME sem usar um teclado.


.. _ui-selmenu:

O menu de seleção de programa e de sistema
------------------------------------------

Ao iniciar o MAME sem definir um sistema na linha de comando, será
mostrado o menu para a seleção de sistemas (assumindo que a
:ref:`opção ui <mame-commandline-ui>` esteja definido como ``cabinet``).
O menu para a seleção de sistemas também será exibido caso você
escolha :guilabel:`Selecione uma nova máquina` no menu principal
durante a emulação. A seleção de um sistema que usa listas de programas
mostra um menu de seleção semelhante.

O menu para a seleção de sistemas e de programas está dividido nestas
partes:

* A área no topo mostra o nome e a versão do emulador, a quantidade
  dos sistemas ou dos itens do programa e o texto da pesquisa
  atual. O menu para a seleção do programa também mostra o nome do
  sistema selecionado.
* A barra de ferramentas abaixo da área do cabeçalho. Os botões
  mostrados na barra de ferramentas variam conforme o menu. Passe o
  ponteiro do mouse sobre um botão para ver uma descrição e clique para
  selecioná-lo.

  Os botões da barra de ferramentas são :guilabel:`adiciona` /
  :guilabel:`remove` um sistema ou programa que estiver destacado nos
  favoritos (ícone de estrela), :guilabel:`Exporta a lista exibida para
  um arquivo` (ícone de disquete), :guilabel:`Audita a mídia`
  (ícone de lupa), :guilabel:`mostra as DATs` (ícone "i" num círculo
  azul), :guilabel:`Retornar ao menu anterior` e :guilabel:`Encerrar`
  (ícone de um "X" num quadrado vermelho).
* A lista dos sistemas ou dos programa ficam ao centro. O menu para a
  seleção dos sistemas, há opções para configuração abaixo da lista. Os
  clones são mostrados com um texto numa cor diferente (o padrão é
  cinza). É possível clicar com o botão direito do mouse no nome de um
  sistema ou programa que funciona como um atalho, mostrando as opções
  de configuração para o sistema.

  Os sistemas ou os itens de programa são ordenados pelo seu nome
  completo ou descrição, mantendo os sistemas clonados logo abaixo dos
  sistemas principais. Pode parecer confuso num primeiro momento caso as
  suas configurações de filtro façam com que um sistema principal ou
  item de programa fique oculto enquanto um ou mais dos seus clones
  fiquem visíveis.
* O painel de informação na parte inferior, exibe informações resumidas
  sobre o sistema ou o programa em destaque. A cor de fundo muda
  dependendo da condição da emulação: verde para aqueles que funcionam,
  âmbar para emulação imperfeita ou caso tenha problemas conhecidos e
  vermelho no caso de problemas mais sérios como emulação incompleta.

  Uma estrela amarela é exibida na parte superior esquerda do painel de
  informação caso o sistema ou programa destacado estiver na sua lista
  de favoritos.
* À esquerda há a lista dos filtros com as suas respectivas opções.
  Clique em um filtro para aplicá-lo à lista de sistemas/programas.
  Alguns filtros mostram um menu com opções adicionais (informar o
  fabricante para o filtro do :guilabel:`Fabricante`, ou definir um
  arquivo e grupo para o filtro de :guilabel:`Categoria` por exemplo).

  Clique em :guilabel:`Sem filtro` para exibir todos os sistemas
  disponíveis. Clique em :guilabel:`Filtro personalizado` para combinar
  diversos filtros. Clique no pilar entre a lista de filtros e a lista
  de sistemas/programa para mostrar ou ocultar a lista dos filtros.
  Esteja ciente que os filtros ainda permanecem aplicados mesmo que a
  lista dos filtros fique escondida.
* À direita há o visualizador de informações. Este possui duas abas para
  mostrar imagens e informações. Clique em uma aba para alternar entre
  elas; clique nos triângulos à esquerda ou à direita ao lado do título
  da imagem/informação para alternar entre as imagens ou as fontes de
  informação.

  As informações dos sistemas são mostradas automaticamente. As
  informações da lista de programas são mostradas para itens que forem
  relacionados com programas. Informações adicionais dos arquivos
  externos podem ser mostradas quando o
  :ref:`plug-in Data <plugins-data>` estiver ativo.

É possível digitar algo na tela principal para iniciar pesquisa
automática na lista exibida ao centro. Os sistemas são pesquisados pelo
nome completo, fabricante e pelo nome abreviado. Caso esteja usando
nomes de sistemas traduzidos, os nomes fonéticos também serão
pesquisados caso estejam presentes. Os programas são pesquisados pela
descrição, por títulos alternativos (elementos ``alt_title`` nas listas
de programas) e pelo nome abreviado. :guilabel:`UI Cancela` (tecla
:kbd:`Esc`) irá limpar a busca caso uma esteja sendo feita no momento.


.. _ui-selmenu-nav:

Controles de navegação
~~~~~~~~~~~~~~~~~~~~~~

Além dos :ref:`controles usuais de navegação <ui-menus>`, o sistema e
os menus para a seleção de programas têm controles configuráveis
adicionais para navegar pelo layout dos vários painéis, fornecendo
alternativas aos botões da barra de ferramentas caso não queira usar um
dispositivo apontador.
Como padrão, o MAME utiliza o US ANSI QWERTY como mapeamento do
teclado, consulte o capítulo :ref:`default-comparative-kbd` para ver as
diferenças entre o teclado Americano e o ABNT-2 usado no Brasil.

As configurações correspondentes com o mapeamento padrão do teclado são:

:kbd:`Tab` (IU Próx. foco)
    Foca a próxima região. A ordem é a lista de sistema/programa,
    configurações (caso esteja disponível), a lista dos filtros (caso
    esteja visível), abas de informação/imagem (caso estejam visíveis).
:kbd:`Shift` + :kbd:`Tab` (IU Foco ant.)
    Move o foco para a região anterior.
:kbd:`Alt` + :kbd:`D` (IU Visualiza DAT externa)
    Mostra o visualizador de informações em tela inteira.
:kbd:`Alt` + :kbd:`F` (IU Adiciona/remove favoritos)
    Add or remove the highlighted system or software item from the favourites
    list.
:kbd:`F1` (IU Afere mídia)
    Realiza uma aferição das ROMs e das imagens dos discos dos sistemas.
    Os resultados são salvos e utilizados pelos filtros
    :guilabel:`Disponível` e :guilabel:`Indisponível`.

Quando o foco estiver na lista de filtros, é possível usar o
controle de navegação do menu (:kbd:`cima`, :kbd:`baixo`, :kbd:`Home` e
:kbd:`End`) para destacar um filtro e :guilabel:`IU Seleciona`
(:kbd:`Enter`/ :kbd:`Return`) para selecioná-lo.

Quando o destaque estiver em qualquer região além das abas de
:guilabel:`Informação` / :guilabel:`imagem`, é possível alterar a
imagem ou a informação com as setas direcionais :kbd:`<` / :kbd:`>`.
Quando o destaque estiver nas abas :guilabel:`imagens` /
:guilabel:`Informações`, é possível rolar o texto com as informações a
informação :kbd:`cima`, :kbd:`baixo`, :kbd:`PgUp`, :kbd:`PgDn`,
:kbd:`Home` e :kbd:`End`.


.. _ui-simpleselmenu:

O menu de seleção simplificada do sistema
-----------------------------------------

Caso inicie o MAME sem especificar um sistema na linha de comando (ou
caso escolha :guilabel:`Selecione uma nova máquina` durante a emulação)
com a opção :ref:`-ui <mame-commandline-ui>` definida como ``simple``,
a seleção simplificada do sistema será mostrada. A seleção simplificada
exibe 15 sistemas selecionados aleatoriamente desde que possuam as suas
respectivas ROMs disponíveis dentro da pasta
:ref:`ROM <mame-commandline-rompath>`. É possível digitar para realizar
uma busca. Ao limpar a busca faz com que outros 15 sistemas aleatórios
sejam exibidos novamente.

O painel de informação na parte debaixo mostra um resumo da informação
do sistema que estiver destacado/selecionado. A cor de fundo muda
conforme a condição da emulação daquele sistema: verde para aqueles que
funcionam, âmbar para emulação imperfeita ou caso tenha problemas
conhecidos e vermelho no caso de problemas mais sérios como emulação
incompleta.
