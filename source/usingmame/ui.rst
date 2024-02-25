.. raw:: latex

	\clearpage


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
com algo que seja possível apontar na tela (mouse, pistola, etc.),
porém, um teclado é necessário para realizar as configurações iniciais.

As configurações predefinidas mais importantes da interface são as
seguintes:

:kbd:`ScrLk` (Scroll Lock) ou **Forward Delete** no macOS (``IU Alterna``)
    Durante a emulação de sistemas com teclado, ativa ou desativa os
    controles da interface. O MAME iniciar com os controles da interface
    desativados nos sistemas que usam teclados, a não ser que a opção
    :ref:`ui_active <mame-commandline-uiactive>` esteja ligada.
:kbd:`Tab` (Menu de configuração)
    Mostra ou esconde o menu durante a emulação.
:kbd:`Esc` (``UI Back``)
    Retorna para a seleção de sistemas ou encerra o MAME caso ele tenha
    sido iniciado com um determinado sistema (a partir da linha de
    comando ou caso esteja usando um
    :ref:`front-end <frontends>` externo.


.. raw:: latex

	\clearpage


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

Seta :kbd:`cima` (``IU Cima``)
    Destaca o item anterior ou o último caso o primeiro esteja
    destacado.
Seta :kbd:`baixo` (``IU Baixo``)
    Destaca o próximo item da lista ou o primeiro caso o último esteja
    destacado.
Seta :kbd:`esquerda` (``IU Esquerda``)
    Para itens do menu que podem ser ajustados, reduz o valor ou
    seleciona o valor anterior (tais configurações mostram setas
    indicativas).
Seta :kbd:`direita` (``IU Direita``)
    Para itens do menu que podem ser ajustados, aumenta o valor ou
    seleciona o valor posterior (tais configurações mostram setas
    indicativas).
:kbd:`Enter` / :kbd:`Return` e :kbd:`Enter` do teclado numérico (``UI Seleciona``)
    Seleciona o item em destaque.
:kbd:`Forward` :kbd:`Delete` ou :kbd:`Fn` + :kbd:`Delete` em alguns
    teclados compactos (``UI Limpa``)
    Limpa a configuração ou redefine para o valor predefinido
:kbd:`Esc` (``UI Back``)
    Limpa o campo de busca, caso contrário, fecha o menu, retorna ao
    menu anterior ou retorna para a emulação no menu principal (também
    há um item na parte do menu que funciona igual).
:kbd:`Home` (``UI Home``)
    Destaca o primeiro item e rola para o topo do menu.
:kbd:`End` (``UI End``)
    Destaca o último item e rola para a parte debaixo do menu.
:kbd:`PgUp` (``UI Pág. cima``)
    Rola a página do menu para cima.
:kbd:`PgDn` (``UI Pág. baixo``)
    Rola a página do menu para baixo.
:kbd:`[` (``UI Grupo anterior``)
    Move os itens do grupo anterior (não é utilizado em todos os menus).
:kbd:`]` (``UI Próximo grupo``)
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
* Se o primeiro joystick tiver pelo menos três botões, aperte o segundo
  botão do primeiro joystick para fechar e retornar ao menu anterior,
  ou retornando ao sistema que estiver sendo emulado (geralmente tem um
  item na parte inferior do menu para o mesmo fim).

Para controles no estilo *gamepad*, o botão analógico esquerdo e o
teclado direcional geralmente controlam a navegação da interface do
usuário. Dependendo do controle, o botão analógico direito, os gatilhos
e os botões adicionais podem ser atribuídos automaticamente às entradas
da interface do usuário. Verifique o menu de atribuições da entrada da
interface do usuário para ver como os controles estão atribuídos.

Para que seja possível usar o MAME com um controle joystick sem um
teclado, é preciso definir os botões do joystick (ou a combinação dos
seus botões) para estes controles também:

* :guilabel:`Mostra/esconde o menu` / :guilabel:`Tab`
    Para mostrar ou dispensar o menu durante a emulação
* ``IU retorna``
    Para fechar os menus
* ``IU cancela``
    Para fechar os menus, retornar para a tela de seleção, para encerar
    a emulação ou para fechar o MAME.
* ``IU limpa``
    Não é basicamente essencial para a emulação, porém é usado para
    limpar ou redefinir algumas configurações.
* ``IU home``, ``IU fim``, ``IU sobe a página``, ``IU desce a página``,
    ``Grupo anterior da IU`` e ``Próximo grupo da IU``
    Não são essenciais, contudo, tornam a navegação mais fácil em alguns
    menus.

Caso não esteja usando um front-end externo para rodar os sistemas no
MAME, atribua os botões do joystick (ou combinações dos botões) nestes
controles para fazer pleno uso dos menus de seleção do sistema:

* ``IU Próx. foco``, ``IU Foco ant.``
    Para navegar entre os painéis.
* ``IU Adiciona/Remove favoritos``, ``IU Exporta lista`` e ``IU Audita mídia``
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
combinações dos botões para o :guilabel:`Mostra/esconde o menu` /
:guilabel:`Tab`, :guilabel:`Pausa` e/ou :guilabel:`Cancela` para que
seja possível usar o MAME sem usar um teclado.


.. _ui-inptcfg:

Configurando as entradas
------------------------

O MAME precisa de um sistema de entrada flexível para sustentar todos os
mecanismos de controle da vasta gama de sistemas emulados por ele. Nas
entradas que têm apenas dois estados distintos, *ligado* e *desligado*
ou *ativo* e *inativo*, estas entradas são chamadas de digitais. Todas
as outras entradas são chamadas de analógicas, mesmo que isso não seja
estritamente verdadeiro.

Para atribuir os controles da interface do usuário do MAME ou as
entradas predefinidas em todos os sistemas, selecione
:guilabel:`Entrada (geral)` no menu principal durante a emulação ou
selecione :guilabel:`Configurações` do menu de seleção do sistema, em
seguida, selecione :guilabel:`Todas as entradas` e a partir daí,
selecione uma categoria.

Para atribuir entradas no sistema em funcionamento, selecione no menu
principal a opção :guilabel:`Entrada (este sistema)` durante a emulação.
As entradas estão agrupadas por dispositivo e ordenadas por tipo. É
possível mover entre os dispositivos com o próximo grupo e as
teclas/botões do grupo anterior usando as teclas :kbd:`[` e :kbd:`]`.

Os menus de atribuição da entrada mostram o nome da entrada emulada ou
o controle da interface do usuário à esquerda, a entrada (ou combinação
das entradas) à direita.

Para ajustar a sensibilidade, a velocidade da centralização automática,
as configurações da inversão ou para ver como os controles analógicos
emulados reagem, selecione :guilabel:`Controles analógicos` no menu
principal durante a emulação. (Este item só aparece nos sistemas com
controles analógicos).


.. raw:: latex

	\clearpage


.. _ui-inptcfg-digital:

Configurações da entrada digital
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cada entrada digital emulada tem uma única atribuição configurável.
Visando uma maior flexibilidade, o MAME pode combinar as entradas do
host (as teclas, os botões e os eixos do joystick) usando operações
lógicas ``and``, ``not`` e ``or``. Isso fica melhor ilustrado com alguns
exemplos:

Tecla :kbd:`1`
    Neste simples exemplo, ao pressionar a tecla :kbd:`1` no teclado,
    ativa a entrada emulada ou o controle da interface do usuário.
Tecla direcional :kbd:`Baixo` ou baixo no direcional do joystick 1
    Pressionando a seta para baixo no teclado ou no controle, ativa a
    entrada emulada ou o controle da interface do usuário.
Tecla :kbd:`P`
    Ao pressionar a tecla :kbd:`P` do teclado ao mesmo tempo que **não**
    for pressionado :kbd:`Shift`, a tecla ativa a entrada emulada ou o
    controle da interface do usuário. O MAME não mostra operações
    implícitas ``and``.
Tecla :kbd:`P` + :kbd:`Shift` esquerdo ou :kbd:`P` + :kbd:`Shift` direito
    Ao pressionar a tecla :kbd:`P` do teclado ao mesmo tempo que
    pressiona as teclas :kbd:`Shift`, ativa a entrada ou o controle da
    interface do usuário. Novamente, as operações implícitas ``and`` não
    são mostradas.

Tecnicamente, o MAME utiliza a soma boleana da lógica dos produtos para
combinar as entradas.

Quando uma configuração para a entrada digital é destacada, o quadro
abaixo do menu mostra se a seleção irá definir a atribuição ou anexar
uma operação ``or`` a ela. Pressione ``IU Esquerda/Direita`` antes de
selecionar se a configuração será para alternar entre a configuração ou
se será para anexar uma operação ``or``. Pressione :kbd:`Del` ou
:kbd:`forward` :kbd:`delete` para excluir a configuração ou restaurar a
atribuição original.

Ao selecionar uma configuração de entrada digital, o MAME esperará que
você digite uma entrada ou uma combinação das entradas para uma operação
lógica ``and``:

* Pressione uma tecla, um botão ou mova o controle analógico uma vez
  para adicionar uma operação ``and``.
* Pressione uma tecla, um botão ou mova o controle analógico duas vezes
  para adicionar uma operação ``not`` na operação ``and``. Ao pressionar
  a mesma tecla, botão ou movendo o mesmo controle analógico mais de uma
  vez, isso faz com que se ligue ou desligue a operação ``not`` várias
  vezes.
* Ao pressionar :kbd:`Esc` **antes** restaura a configuração original.
* A nova configuração é mostrada abaixo do menu. Aguarde cerca de um
  segundo depois da ativação para que a nova configuração seja aceita.

Veja aqui como criar algumas configurações de exemplo:

Tecla :kbd:`1`
    Pressione uma vez a tecla :kbd:`1` no teclado, aguarde 1 segundo
    para aceitar a nova configuração.
Tecla :kbd:`F12` :kbd:`Shift` :kbd:`Alt`
    Pressione uma vez a tecla :kbd:`F12` no teclado, pressione uma vez a
    tecla :kbd:`Shift` esquerda, pressione uma vez a tecla :kbd:`Alt`
    esquerda, aguarde cerca de um segundo para que a nova configuração
    seja aceita.
Tecla :kbd:`P`
    Pressione uma vez a tecla :kbd:`P`, pressione duas vezes a tecla
    :kbd:`Shift` esquerda, pressione duas vezes a tecla :kbd:`Shift`
    direita, aguarde cerca de um segundo para que a nova configuração
    seja aceita.


.. raw:: latex

	\clearpage


.. _ui-inptcfg-analog:

Configurações da entrada analógica
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cada entrada analógica emulada possui três configurações de atribuição:

* Use a configuração do *axis setting* (ajuste do eixo) para atribuir um
  eixo analógico como controle de uma entrada analógica. As
  configurações do eixo utiliza o nome da entrada com o sufixo "Analog"
  (Analógico). O ajuste do eixo para o volante no sistema *Ridge Racer*
  por exemplo, é chamado de :guilabel:`Steering Wheel Analog`.
* Use o :guilabel:`increment setting` para atribuir à entrada (ou na
  combinação delas) o aumento do seu valor. A configuração para este
  incremento utiliza o nome :guilabel:`Analog Inc`. Por exemplo, a
  configuração de incremento no volante do sistema *Ridge Racer* se
  chama :guilabel:`Steering Wheel Analog Inc`. Esta é a entrada digital
  para este sistema, caso um eixo analógico seja atribuído à ele, o MAME
  não vai incrementar o valor emulado numa velocidade proporcional.
* Use o :guilabel:`decrement setting` para atribuir à entrada (ou na
  combinação delas) a redução do seu valor. A configuração para este
  incremento utiliza o nome :guilabel:`Analog Dec`. Por exemplo, a
  configuração de incremento no volante do sistema *Ridge Racer* se
  chama :guilabel:`Steering Wheel Analog Dec`. Esta é a entrada digital
  para este sistema, caso um eixo analógico seja atribuído a ele, o MAME
  não vai incrementar o valor emulado numa velocidade proporcional.

Os ajustes de aumento e de redução são muito mais úteis para controlar
uma entrada analógica usando controles digitais (as teclas do teclado,
os botões do joystick ou um teclado direcional por exemplo). Eles são
configurados da mesma maneira que as entradas digitais (:ref:`ver
acima <ui-inptcfg-digital>`). **É de extrema importância que não se
atribua o mesmo controle ao ajuste do eixo, assim como os ajustes para o
aumento e/ou para a redução na mesma entrada ao mesmo tempo.**
Por exemplo, caso atribua o ajuste analógico :guilabel:`Steering Wheel
Analog` do *Ridge Racer* ao eixo X ao analógico esquerdo no seu
controle, você não deve atribuir nem o ajuste analógico
:guilabel:`Steering Wheel Analog Inc` nem o ajuste :guilabel:`Steering
Wheel Analog Dec` ao eixo X do mesmo analógico.

É possível atribuir um ou mais eixos analógicos ao ajuste do eixo de uma
entrada analógica emulada. Quando diversos eixos são atribuídos num
ajuste do eixo, eles são adicionados juntos, porém os controles de
posição absoluta anularão os controles de posição relativa. Por exemplo,
suponha que para o sistema **Arkanoid** você atribua o ajuste do eixo 
guilabel:`Dial Analog` ao :guilabel:`Mouse X` ou :guilabel:`Joy 1 LSX`
ou :guilabel:`Joy 1 RSX` ao mouse num controle estilo Xbox. Será
possível controlar a palheta com o mouse ou com o eixo analógico,
porém o mouse só terá efeito caso ambos os eixos analógicos estejam na
posição neutra (centralizados) no eixo X. Se qualquer um dos eixos
analógicos não estiver devidamente centralizado no eixo X, o mouse não
surtirá qualquer efeito, pois um mouse é um controle de posição
relativa, enquanto um joystick é um controle de posição absoluta.

Para os controles de posição absoluta como joysticks e pedais, O MAME
permite a atribuição do alcance total de um eixo ou o alcance de um lado
da posição neutra (*meio eixo*) ao ajuste de um eixo. A atribuição de um
"meio eixo" é usada normalmente nos pedais ou nas outras entradas
absolutas onde a posição neutra está numa extremidade do alcance da
faixa de entrada. Vamos supor que para o sistema **Ridge Racer** você
atribua o ajuste analógico do pedal de freio à parte de um eixo vertical
do joystick abaixo da posição neutra. Caso controle esteja na posição
neutra na vertical ou acima dela, o pedal do freio será liberado; já se
o joystick estiver abaixo da posição neutra na vertical, o pedal do
freio será aplicado proporcionalmente. Metade dos eixos são exibidos com
o nome do eixo seguido por um sinal de mais ou menos (:guilabel:`+` ou
:guilabel:`-`). O sinal de **mais** se refere à parte do eixo abaixo ou
à direita da posição neutra; o sinal de **menos** se refere à parte do
eixo acima ou à esquerda da posição neutra. Para os controles dos pedais
ou do gatilho analógico, a faixa ativa é tratada como estando acima da
posição neutra (a metade do eixo indicada por um sinal de **menos**).

Quando as teclas ou os botões são atribuídos a um ajuste do eixo, eles
ativam condicionalmente os controles analógicos que forem atribuídos ao
ajuste. Isto pode ser usado em conjunto com um controle de posição
absoluta para criar um controle
":ref:`pegadiço <mame-commandline-joystickmap>`".

Aqui estão alguns exemplos de algumas das atribuições possíveis para o
ajuste dos eixos assumindo que seja usado um controle do Xbox e um
mouse:

Joy 1 RSY
    Faça um movimento vertical no analógico direito para atribuir essa
    entrada à emulação.
Mouse X ou Joy 1 LT ou Joy 1 RT Reverse
    Faça um movimento horizontal, ou ative os gatilhos esquerda e
    direita para atribuir essa entrada à emulação. O gatilho
    direito é invertido, assim sendo, ele trabalha na direção inversa em
    relação ao gatilho esquerdo.
Joy 1 LB Joy 1 LSX
    Faça um movimento horizontal no analógico esquerdo para atribuir
    essa entrada à emulação, porém *apenas* enquanto estiver mantendo
    pressionado o botão superior esquerdo. Caso o botão superior direito
    seja liberado enquanto o analógico esquerdo não estiver centralizado
    no eixo horizontal, a entrada da emulação manterá seu valor até o
    botão superior direito seja pressionado novamente (um controle
    "pegadiço").
não Joy 1 RB Joy 1 RSX ou Joy 1 RB Joy 1 RSX Inverso
    Faça um movimento horizontal no analógico direito para atribuir essa
    entrada à emulação, mas inverta o controle caso o botão superior
    direito seja mantido pressionado.

Ao selecionar a configuração de um eixo, o MAME vai aguardar a sua
resposta:

* Movimente um controle analógico para atribuí-lo ao ajuste de um eixo.
* Pressione uma tecla ou botão (ou uma combinação deles) *antes* ao
  mover um controle analógico para ativá-lo condicionalmente.
* Ao anexar a um ajuste, caso o último controle seja um controle com
  posição absoluta, mova o mesmo controle novamente para alternar
  entre a extensão total do eixo, a parte do eixo em ambos os lados da
  posição neutra e a faixa completa do eixo invertido.
* Ao anexar a um ajuste, caso o último controle atribuído seja um
  controle de posição relativa, mova o mesmo controle novamente para
  alternar a direção do controle entre ligado ou desligado.
* Ao anexar um ajuste, movimente um controle analógico desde que não
  seja o último controle atribuído ou pressione uma tecla ou botão para
  adicionar uma operação ``or``.
* Ao pressionar :kbd:`Esc` **antes** de ativar uma entrada do eixo,
  isso faz com que a configuração seja limpa, restaurando a sua
  atribuição original.
* Ao pressionar :kbd:`Esc` **depois** de ativar uma entrada do eixo,
  isso mantém a sua atribuição original.
* A nova configuração é mostrada abaixo do menu. Espere um segundo
  depois de ativar uma entrada para que a nova configuração seja aceita.

Para realizar o ajuste da sensibilidade, da velocidade centralização
automática, das configurações de inversão para entradas analógicas ou
para ver como elas respondem às suas configurações, selecione a opção
:guilabel:`Controles analógicos` no menu principal durante a emulação.
A configuração das entradas estão agrupadas por dispositivo e ordenadas
por tipo. É possível mover entre os dispositivos com o próximo grupo e
as teclas/botões do grupo anterior usando as teclas :kbd:`[` e :kbd:`]`.
O estado das entradas analógicas é mostrado abaixo do menu e elas reagem
em tempo real. Pressione a tecla responsável pela
:guilabel:`Visualização na tela` (a tecla :kbd:`~` e :kbd:`\`` num
teclado US ANSI QWERTY e as teclas :kbd:`"` e :kbd:`'` num teclado
ABNT-2) para ocultar o menu principal, facilitando o teste sem alterar
as configurações. Pressione novamente a mesma tecla ou botão
para mostrar o menu completo novamente.

Cada entrada analógica possuí quatro configurações no menu
:guilabel:`Analog Controls`:

* Os controles de configuração :guilabel:`increment` /
  :guilabel:`decrement` (aumento / redução) controlam o quão rápido os
  valores da entrada aumenta ou reduz em resposta aos controles
  atribuídos nos ajustes de :guilabel:`increment` /
  :guilabel:`decrement`.
* A configuração :guilabel:`auto-centering speed` (velocidade
  autocentrante) controla o quão rápido o valor da entrada retorna ao
  estado neutro quando os controles atribuídos às configurações de
  :guilabel:`increment` / :guilabel:`decrement` são liberados.
* O ajuste :guilabel:`reverse` (inverso) permite inverter a direção
  da resposta recebida dos controles ao ser liberado. Ao definir como
  zero (``0``) faz com que o valor não retorne automaticamente para a
  posição neutro. Isso se aplica aos controles atribuídos ao ajuste do
  eixo e aos ajustes de :guilabel:`increment` / :guilabel:`decrement`.
* O ajuste :guilabel:`sensitivity` (sensibilidade) ajusta a resposta
  recebida do controle atribuído ao ajuste do eixo.

Use as teclas ou botões da :kbd:`esquerda` e :kbd:`direita` para ajustar
a configuração em destaque. Ao selecionar uma configuração ou ao
pressionar a tecla :kbd:`Del` (:kbd:`Forward` :kbd:`Delete`) restabelece
o seu valor inicial.

As unidades para as configurações da velocidade **increment/decrement**,
**auto-centering speed** e **sensitivity** estão vinculadas à
implementação do driver/dispositivo. As configurações da velocidade
**increment/decrement**, **auto-centering speed** também são vinculadas
à taxa dos quadros da tela principal do sistema. A resposta aos
controles atribuídos às configurações de **increment/decrement** também
será alterada caso o sistema altere a taxa de quadros desta tela.


.. _ui-selmenu:

O menu de seleção de programa e de sistema
------------------------------------------

Ao iniciar o MAME sem definir um sistema na linha de comando, será
mostrado o menu para a seleção de sistemas (assumindo que a opção
:ref:`-ui <mame-commandline-ui>` esteja definido como ``cabinet``).
O menu para a seleção de sistemas também será exibido caso você
escolha :guilabel:`Selecione um novo sistema` no menu principal
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
  Clique num filtro para aplicá-lo à lista de sistemas/programas.
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
  mostrar imagens e informações. Clique numa aba para alternar entre
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
de programas) e pelo nome abreviado. A tecla :kbd:`Esc` limpa a busca
caso uma esteja sendo feita no momento.


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

:kbd:`Tab` (``IU Próx. foco``)
    Foca a próxima região. A ordem é a lista de sistema/programa,
    configurações (caso esteja disponível), a lista dos filtros (caso
    esteja visível), abas de informação/imagem (caso estejam visíveis).
:kbd:`Shift` + :kbd:`Tab` (``IU Foco ant.``)
    Move o foco para a região anterior.
:kbd:`Alt` + :kbd:`D` (``IU Visualiza DAT externa``)
    Mostra o visualizador de informações em tela inteira.
:kbd:`Alt` + :kbd:`F` (``IU Adiciona/remove favoritos``)
    Adiciona ou remove o sistema ou programa em destaque na lista de
    favoritos.
:kbd:`F1` (``IU Afere mídia``)
    Realiza uma aferição das ROMs e das imagens dos discos dos sistemas.
    Os resultados são salvos e utilizados pelos filtros
    :guilabel:`Disponível` e :guilabel:`Indisponível`.

Quando o foco estiver na lista de filtros, é possível usar o
controle de navegação do menu (:kbd:`cima`, :kbd:`baixo`, :kbd:`Home` e
:kbd:`End`) para destacar um filtro e :kbd:`Enter` / :kbd:`Return` para
selecioná-lo.

Quando o destaque estiver em qualquer região além das abas de
:guilabel:`Informação` / :guilabel:`imagem`, é possível alterar a
imagem ou a informação com as setas direcionais :kbd:`<` / :kbd:`>`.
Quando o destaque estiver nas abas :guilabel:`imagens` /
:guilabel:`Informações`, é possível rolar o texto com as informações a
informação :kbd:`cima`, :kbd:`baixo`, :kbd:`PgUp`, :kbd:`PgDn`,
:kbd:`Home` e :kbd:`End`.


.. raw:: latex

	\clearpage


.. _ui-simpleselmenu:

O menu de seleção simplificada do sistema
-----------------------------------------

Caso inicie o MAME sem especificar um sistema na linha de comando (ou
caso escolha :guilabel:`Selecione um novo sistema` durante a emulação)
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
