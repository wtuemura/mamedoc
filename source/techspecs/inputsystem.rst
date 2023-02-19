.. raw:: latex

	\clearpage


.. _inputsystem:

Entrada do sistema
==================

.. contents::
   :local:
   :depth: 2


.. _inputsystem-intro:

Introdução
----------

A variedade dos sistemas que o MAME emula, bem como a variação da
hospedagem dos sistemas e dos periféricos, exige um sistema de entrada
flexível e configurável.

Observe que o sistema da entrada tem a preocupação com a entrada de
baixo nível do usuário. A interação de alto nível do usuário, envolvendo
itens como a entrada de texto e dos dispositivos apontadores, é tratada
de forma separada.


.. _inputsystem-components:

Componentes
-----------

Do ponto de vista do sistema que está sendo emulado, o conceito da
entrada do sistema tem os seguintes componentes.


Entrada do dispositivo
~~~~~~~~~~~~~~~~~~~~~~

A entrada dos dispositivos disponibilizam informações sobre os valores
da entrada. A entrada geralmente corresponde a um dispositivo físico
hospedado pelo sistema, por exemplo, um teclado, um mouse ou um
controle de jogo. Entretanto, nem sempre há uma correspondência um-a-um
entre as entradas dos dispositivos e os dispositivos físicos.
Por exemplo, o módulo que provê o teclado SDL, agrega todos os teclados
numa única entrada do dispositivo, já o módulo que provê o *lightgun
Win32*, pode apresentar dois dispositivos usando a entrada de um único
mouse.

A entrada dos dispositivos são identificados através da sua classe
(teclado, mouse, joystick ou revólver) e pela quantidade dos
dispositivos dentro da sua classe. Os provedores dos módulos de entrada
também podem fornecer um identificador dependente da implementação
visando permitir que o usuário possa configurar um valor numérico
estável do dispositivo.

Observe que a entrada dos dispositivos não têm relação com os
dispositivos emulados (implementações do tipo ``device_t``) apesar da
terem uma nomenclatura semelhante.


Item da entrada do dispositivo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Também conhecido como **controle**, o item da entrada do dispositivo
corresponde a uma fonte de entrada que gera um valor único. Isso
geralmente corresponde a um controle físico ou a um sensor, por exemplo,
um eixo do joystick, um botão ou um acelerômetro.

O MAME suporta três tipos de controles: **interruptores**,
**eixos absolutos** e **eixos relativos**:

* Os interruptores geram um valor ``0`` quando estão inativos (liberados
  ou desligados).
* Os eixos absolutos produzem um valor normalizado na faixa entre
  ``-65.536`` até ``65.536`` com o ``0`` correspondendo à posição
  neutra.
* Os eixos relativos produzem um valor correspondente ao movimento a
  partir da atualização da entrada anterior. Os dispositivos do tipo
  mouse, escalam os valores nominais para aproximadamente ``512`` com
  ``100`` DPI  por pixel.

Os valores negativos dos eixos devem corresponder as direções para cima,
para a esquerda, distante do jogador ou no sentido anti-horário. Para
eixos com uma extremidade (pedais, gatilhos e botões sensíveis ao
deslocamento por exemplo), apenas o ``0`` e a parte negativa da faixa
deve ser usada.

Os interruptores são usados para representar os controles que
naturalmente têm dois estados bem distintos, como botões e os
interruptores de comutação.

Os eixos absolutos são usados para representar controles com uma faixa
definida ou uma posição neutra. Os exemplos incluem volantes com
final de curso, eixos de joystick e gatilhos sensíveis ao deslocamento.

Os eixos relativos são usados para representar controles com um alcance
efetivamente infinito. Os exemplos incluem os eixos do mouse, de um
*trackball*, mostradores de codificação incremental e giroscópios.

Os acelerômetros e os eixos de detecção de força do joystick devem ser
representados como eixos absolutos, ainda que o alcance seja
teoricamente aberto. Na prática, há um limite para o alcance que os
transdutores podem relatar, geralmente é substancialmente maior do que o
necessário para uma operação normal.

.. raw:: latex

	\clearpage

Os itens da entrada do dispositivo são identificados pela classe e pelo
número associado ao dispositivo, juntamente com uma **identificação da
entrada do item**. O MAME fornece IDs para os tipos de itens comuns dos
controles. Os controles adicionais ou os controles que não correspondam
a um tipo comum, as IDs são dinamicamente atribuídas para eles. O MAME
suporta centenas de itens por entrada de dispositivo.


Faixa da porta de E/S
~~~~~~~~~~~~~~~~~~~~~

Uma faixa da porta de E/S representa uma fonte de entrada num
dispositivo ou num sistema emulado. A maioria dos tipos das faixas da
porta de E/S pode ser atribuída a uma ou mais combinações de controles,
permitindo ao usuário controlar a entrada para o sistema que estás sendo
emulado.

Da mesma forma que os itens da entrada do dispositivo, existem diversos
tipos de faixas da porta de E/S:

* As **faixas digitais**:

  Funcionam como interruptores que produzem um
  de dois valores distintos. Eles são usados para as teclas de um
  teclado, interruptores de direção do joystick com oito direções,
  comutadores, foto interruptores e outras entradas emuladas que
  funcionam como interruptores com duas posições.
* As **faixas analógicas absolutas**:

  Têm uma faixa com posições mínimas, máximas e neutras definidas. São
  usadas para os eixos de um joystick analógico, pedais sensíveis ao
  deslocamento, comandos rotativos e outras entradas emuladas com uma
  faixa definida.
* As **faixas analógicas relativas**:

  Têm uma faixa inicial com posições mínimas, máximas definidas. Em cada
  atualização, o valor se acumula e se enrola quando passa por qualquer
  uma das extremidades do intervalo. Funcionalmente, isto é como a saída
  de um contador acima/abaixo conectado a um codificador incremental.
  Eles são usados para eixos do mouse/trackball, volantes sem limites de
  parada (fim de curso) e outras entradas emuladas que não têm limites
  de alcance.
* A chave DIP:

  A configuração e as faixas de ajuste permitem que o
  usuário defina um valor através da interface de usuário do MAME.
* Outros tipos especiais da faixa:

  São usados para produzir valores fixos ou gerados de forma
  programática.

Uma faixa digital é exibido para o usuário como uma única entrada
atribuível, que aceita valores de comutação.

Uma faixa analógica é exibida ao usuário como três entradas atribuíveis:
uma **entrada do eixo**, que aceita valores do eixo; uma **entrada de
incremento** e uma **entrada de decremento**, que aceita valores de
comutação.


.. raw:: latex

	\clearpage


Gerenciamento da entrada
~~~~~~~~~~~~~~~~~~~~~~~~

O gerenciador da entrada possui diversas responsabilidades, que incluem:

* Fazer o rastreamento da entrada nos dispositivos disponíveis no
  sistema.
* Ler o valor das entradas.
* Fazer a conversão entre os valores dos identificadores internos, das
  sequências dos símbolos de configuração e das sequências de exibição.

Na prática, os dispositivos e os sistemas emulados raramente interagem
diretamente com o gerenciador de entrada. A razão mais comum para
acessar o gerenciador é implementar controles especiais de depuração
que devem ser desativados nas versões de lançamento. Os plug-ins que
respondem à necessidade de entrada, precisam invocar o gerenciador para
fazer a leitura das entradas.


Gerenciador da porta de E/S
~~~~~~~~~~~~~~~~~~~~~~~~~~~

O gerenciador de E/S possui diversas responsabilidades, que incluem:

* Fazer o gerenciamento das atribuições das faixas dos controles da
  porta de E/S e as ações da interface com o usuário.
* Fazer Leitura dos valores da entrada através do gerenciador e fazer 
  a atualização dos valores da faixa das portas de E/S.

Assim como o gerenciador da entrada, o gerenciador das portas de
E/S é amplamente transparente com os dispositivos e com os sistemas
emulados. Só é preciso configurar as suas portas e as faixas de E/S para
que o gerenciador cuide do resto.


.. raw:: latex

	\clearpage


.. _inputsystem-structures:

Estruturas e os tipos dos dados
-------------------------------

Os seguintes tipos de dados são usados para lidar com a entrada.


Código de entrada
~~~~~~~~~~~~~~~~~

Um código de entrada determina um item de entrada do dispositivo e como
ele deve ser interpretado. É um énuplo [#TUPLE]_ que consiste
basicamente nos seguintes valores, classe do dispositivo (**device
class**), número do dispositivo (**device number**), classe do item
(**item class**), modificador do item (**item modifier**) e a ID do item
(**item ID**):

.. [#TUPLE] Tuple do Inglês, também conhecido como tupla, é uma
            estrutura de dados ordenada por elementos.
            `https://www.wikiwand.com/pt/Énuplo <https://www.wikiwand.com/pt/%C3%89nuplo>`_

* A **classe do dispositivo**:

  O valor numérico do dispositivo junto com a ID do item identificam o
  item do dispositivo que será lido na entrada.
* A **classe do item**:

  Determina o tipo desejado do valor a ser gerado de um interruptor, de
  um eixo absoluto ou de um eixo relativo. Os valores dos eixos podem
  ser convertidos para valores de comutação ao definir um modificador
  adequado.
* O **modificador**:

  Determina como um valor deve ser interpretado. As
  opções válidas dependem do tipo do item do dispositivo na entrada e
  da classe definida do item.

Caso o item da entrada especificada seja um interruptor, ele só poderá
ser lido usando a classe do interruptor e nenhum outro modificador será
suportado. O item sempre retornará ``0`` caso haja a tentativa de ler um
comutador como um eixo absoluto ou como um eixo relativo.

No caso de ser especificado como um eixo absoluto, ele poderá ser lido
como um eixo absoluto ou como um comutador:

* A leitura de um item com um eixo absoluto retorna para o seu estado
  atual de controle, potencialmente se transformado num modificador caso
  um seja especificado. Os modificadores suportados são **invertidos**
  para inverter a faixa de alcance do controle, **positivo** para fazer
  o mapeamento da faixa de alcance positivo do controle na saída (o
  ``0`` corresponde a ``-65.536`` e ``65.536`` corresponde a ``65.536``) e
  **negativo** para mapear a faixa do alcance negativo do controle na
  saída (o ``0`` corresponde a ``-65.536`` e ``-65.536`` corresponde a
  ``65.536``).
* A leitura de um item com um eixo absoluto como um interruptor, retorna
  ``0`` ou ``1`` dependendo caso o controle passe de um limite na
  direção determinada pelo modificador. Use o modificador **negativo**
  para retornar ``1`` quando o controle estiver além do limite na
  direção negativa (para cima ou para a esquerda) ou um modificador
  **positivo** para retornar ``1`` quando o controle estiver além do
  limite na direção positiva (para baixo ou para a direita). Há dois
  pares especiais de modificadores, **esquerda**/**direita** e
  **cima**/**baixo** que são aplicáveis somente aos eixos primários X/Y
  dos dispositivos de joystick. O usuário pode definir um mapa para o
  joystick para controlar como estes modificadores interpretam a
  movimentação do joystick.
* O valor sempre retornará ``0`` ao tentar ler um item com eixo absoluto
  como se fosse um eixo relativo.

.. raw:: latex

	\clearpage

Caso o item informado da entrada seja um eixo relativo, ele pode ser
lido como um eixo relativo ou como um interruptor:

* A leitura de um item com um eixo relativo como um eixo relativo,
  retorna a alteração do valor desde a última atualização da entrada. O
  único modificador suportado é o **inverso**, que negativa o valor,
  revertendo a direção.
* A leitura de um eixo relativo como sendo um interruptor, retorna ``1``
  caso o controle se mova na direção determinada pelo modificador da
  entrada desde a sua última atualização. Use os modificadores
  **negativo**/**esquerda**/**cima** para retornar ``1`` quando o
  controle tiver sido movido na direção negativa (para cima ou para a
  esquerda) ou use os modificadores **positivo**/**direita**/**baixo**
  para retornar ``1`` quando o controle tiver se movido na direção
  positiva (para baixo ou para a direita).
* A tentativa de fazer a leitura de um item com eixo relativo como se
  fosse um eixo absoluto, sempre retorna ``0``.

Há também os códigos especiais da entrada que são usados para
especificar como os vários controles devem ser combinados na entrada de
uma sequência.

O lugar mais comum que será possível encontrar os códigos de entrada no
dispositivo e no código do driver do sistema é ao especificar
atribuições iniciais para as faixas da porta de E/S que não possuam
atribuições padrão fornecidas pelo seu núcleo. A macro ``PORT_CODE`` é
utilizada para esta finalidade.

O MAME oferece macros e funções auxiliares para produzir os códigos de
entrada mais usados, incluindo as teclas padrão do teclado, os eixos e
os botões do mouse/joystick/arma de luz.


Sequência de entrada
~~~~~~~~~~~~~~~~~~~~

Uma sequência de entrada determina uma combinação dos controles que
podem ser atribuídos a uma entrada. O nome diz respeito ao fato de ser
implementado como um recipiente desta sequência com os códigos de
entrada como elementos. É um tanto enganador, pois, as sequências de
entrada são interpretadas utilizando valores instantâneos de controle.
As sequências de entrada são interpretadas de maneira diferente para a
entrada dos comutadores (*switches*) e dos eixos.

A entrada das sequências vindas de comutadores devem conter apenas os
códigos de entrada com a classe do item sendo definida para chavear
juntamente com os códigos especiais de entrada ``or`` e ``not``. A
sequência é interpretada usando a lógica de soma dos produtos. Um código
``not`` faz com que o valor retornado seja invertido imediatamente. A
conjunção dos valores retornados pelos sucessivos códigos é avaliado até
que um código ``or`` seja encontrado. Caso o valor atual for ``1``
quando um código ``or`` for encontrado, ele retorna, caso contrário a
avaliação prossegue.

Sequências de entrada nos eixos podem conter códigos de entrada com a
classe do item definido para comutar um eixo absoluto ou um eixo
relativo juntamente com os códigos especiais ``or`` e ``not``.  É útil
pensar na sequência de entrada como contendo um ou mais grupos com
códigos de entrada separados por códigos ``or``:

* Um código ``not`` faz com que haja uma inversão imediata no valor
  seguinte do código retornado pela comutação. Ele não tem efeito sobre
  os códigos absolutos ou sobre os códigos relativos do eixo.
* Dentro de um grupo, é avaliado a conjunção dos valores retornados
  pelos códigos de comutação. O grupo é ignorado quando o valor for
  zero.
* Dentro de um grupo, são somados diversos valores do eixo que sejam o
  mesmo tipo. São somados os valores dos códigos retornados pelo eixo
  absoluto, assim como, pelos valores do eixo relativo.
* Caso qualquer código de eixo absoluto num grupo retornar um valor
  diferente de zero, a soma dos eixos relativos no grupo será ignorada.
  Qualquer valor absoluto do eixo diferente de zero, tem precedência
  sobre os valores relativos do mesmo.
* A mesma lógica é aplicada ao combinar os valores de um grupo: os
  valores do grupo produzidos a partir do um eixo do mesmo tipo são
  somados, já os valores produzidos a partir dos eixos absolutos têm
  precedência sobre os valores produzidos a partir dos eixos relativos.
* Após a soma dos valores do grupo, caso o valor seja produzido a partir
  dos eixos absolutos, ele é fixado no intervalo entre ``-65.536`` até
  ``65.536`` (os valores produzidos a partir de eixos relativos não são
  fixados).

O código de emulação raramente precisa lidar diretamente com as
sequências de entrada, pois elas são tratadas internamente entre o
gerenciador das portas de E/S e o gerenciador das entradas. Este
gerenciador também converte as sequências da entrada a partir de e para
o token das sequências armazenadas nos arquivos de configuração e gera
um texto para exibir a entrada das sequências para usuários.

Para permitir a configuração, os plug-ins com controles ou com as teclas
de atalho precisam usar sequências de entrada. As classes utilitárias
são fornecidas para permitir que as sequências sejam inseridas pelo
usuário de forma consistente, assim como, o gerenciador da entrada possa
ser usado para realizar conversões de e para a configuração e a exibição
das sequências dos caracteres. É muito raro haver a necessidade de
manipular diretamente estas sequências.


.. _inputsystem-providermodules:

Módulos do gerenciador de entrada
---------------------------------

Os módulos do gerenciador de entrada faz parte da camada dependente do
SO (OSD) e não são expostos diretamente à emulação, ou, ao código da
interface do usuário. Os módulos são responsáveis por detectar os
dispositivos disponíveis de entrada no host, para configurar os
dispositivos de entrada para o gerenciador e fornecer chamadas de
retorno (*callbacks*) para ler o estado atual dos itens do dispositivo
de entrada. Estes módulos também podem fornecer atribuições predefinidas
adicionais de entrada que sejam adequadas para os dispositivos presentes
no host.

O usuário pode escolher quais os módulos de entrada pode ser utilizados.
Um módulo que gerencie a entrada é utilizado para cada uma das quatro
classes de dispositivos de entrada (teclado, mouse, joystick e
lightgun). Os módulos disponíveis dependem do sistema operacional do
host e da implementação do OSD. Diferentes módulos podem usar *APIs*
diferentes, podem se compatíveis com diferentes tipos de dispositivos
ou apresentar dispositivos de maneiras diferentes.


.. _inputsystem-playerpositions:

Posições do jogador
-------------------

O MAME usa um conceito chamado *posições do jogador* para ajudar a
gerenciar as atribuições da entrada. A quantidade de posições dos
jogadores suportados depende do tipo da faixa da porta de E/S:

* Dez posições dos jogadores são suportadas para as entradas comuns do
  jogo, incluindo o joystick, o controlador, o remo, o mostrador, o
  trackball, o lightgun e o mouse.
* Quatro posições dos jogadores são suportadas para as entradas para
  mahjong e para hanafuda.
* Uma posição do jogador é compatível com a entrada usadas pelos
  sistemas de apostas.
* Outras entradas não utilizam as posições dos jogadores. Isto inclui
  slots para moedas, botões de início do jogo de arcade, interruptores
  de inclinação, interruptores de serviço e teclas do teclado/keypad.

O usuário pode configurar as atribuições predefinidas da entrada por
posição do jogador para os tipos da porta de E/S compatíveis que são
salvos no arquivo ``default.cfg``. Estas atribuições são usadas para
todos os sistemas, a menos que o driver do dispositivo/sistema forneça
as suas próprias atribuições predefinidas ou que o usuário faça a
configuração das atribuições da entrada para este sistema em específico.

.. raw:: latex

	\clearpage

Visando facilitar o desenvolvimento dos dispositivos de entrada
reutilizáveis da emulação, particularmente dispositivos de slot, o
gerenciador da porta de E/S renumera automaticamente as posições dos
jogadores ao configurar o sistema que está sendo emulado no momento:

* O gerenciador da porta de E/S inicia na posição 1 do jogador e começa
  a iterar a árvore da emulação do dispositivo em profundidade na
  primeira ordem e a partir do dispositivo raiz.
* Se um dispositivo tem faixas de E/S na porta que sejam compatíveis com
  as posições do jogador, eles são renumerados para iniciar a partir da
  posição atual do gerenciador da porta de E/S do jogador.
* Antes de avançar para o próximo dispositivo, o gerenciador define a
  posição atual do jogador para a sua última posição mais uma.

Para um exemplo simples, considere o que acontece quando você administra
um console Mega Drive da Sega com dois controles conectados:

* O gerenciador da porta de E/S começa na posição 1 do dispositivo raiz
  do jogador.
* O primeiro dispositivo encontrado na porta de E/S que sejam
  compatíveis as posições dos jogadores é o primeiro controle. As
  entradas são renumeradas para começar na posição 1 do jogador. Isto
  não tem efeito visível, pois as faixas da porta de E/S são
  inicialmente numerados a partir da posição 1 do jogador.
* Antes de passar para o próximo dispositivo, o gerenciador da porta de
  E/S define a sua posição atual do jogador para 2 (a última posição do
  jogador mais um).
* O próximo dispositivo encontrado com as faixas da porta de E/S que
  sejam compatíveis com as posições dos jogadores é o segundo controle.
  As entradas são renumeradas para começar na posição 2 do jogador. Isto
  evita conflitos do tipo da faixa da porta de E/S com o primeiro
  controle.
* Antes de passar para o próximo dispositivo, o gerenciador da porta de
  E/S define a sua posição atual do jogador para 3 (a última posição de
  jogador mais um).
* Não são mais encontrados dispositivos na porta de E/S que suportem as
  posições dos jogadores.

.. raw:: latex

	\clearpage


.. _inputsystem-updatingfields:

Atualizando as faixas de E/S da porta
-------------------------------------

O gerenciador da porta de E/S atualiza as faixas da porta de E/S uma vez
para cada quadro de vídeo produzido pela primeira tela emulada do
sistema. A maneira como uma faixa é atualizada depende se fica numa
faixa digital ou numa faixa analógica.


Atualizando as faixas digitais
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A atualização das faixas das portas digitais de E/S é simples:

* |ogdp| da sequência na entrada (|adgd|).
* Se o valor for zero, um valor padrão é definido.
* Caso o valor seja diferente de zero, o complemento binário do valor
  da faixa padrão será definida.


Atualizando as faixas analógicas absolutas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A atualização da faixa absoluta de E/S das portas analógicas são mais
complexas devido à necessidade de ser compatível com uma variedade de
configurações para os controles:

* |ogdp| ao eixo da sequência na entrada (|adgd|).
* Caso o valor atual mude desde a sua última atualização e o item do
  dispositivo da entrada que produziu o valor atual tenha sido um eixo
  absoluto, o valor da faixa é definido como o valor atual dimensionado
  para o intervalo correto e nenhum processamento adicional é executado.
* Quando este valor for diferente de zero e o item do dispositivo da
  entrada que produziu o valor atual for um eixo relativo, o valor atual
  será adicionado ao valor do intervalo, dimensionado pela configuração
  da sensibilidade da faixa.
* |ogdp| ao aumento sequencial da entrada (|adgd|); caso este valor seja
  diferente de zero, o valor da configuração de sensibilidade da
  velocidade de aumento/redução da faixa será adicionado e dimensionado
  através da configuração de sensibilidade.
* |ogdp| a redução sequencial da entrada (|adgd|); caso este valor seja
  diferente de zero, o valor da configuração de sensibilidade da
  velocidade de aumento/redução da faixa será reduzido e dimensionado
  através da configuração de sensibilidade.
* Se a entrada do eixo atual e todos os outros valores forem zero,
  porém, um ou ambos os valores da entrada aumentarem e a redução da
  entrada forem diferentes de zero na última vez que o valor faixa tenha
  sido alterado em resposta à entrada do usuário, a centralização
  automática do valor da velocidade da faixa é adicionado a configuração
  ou subtraído do seu valor para movê-lo para o seu valor predefinido.

Observe que o valor de sensibilidade da configuração para as faixas
analógicas absolutas, afeta a resposta aos itens do dispositivo de
entrada com eixo relativo e as entradas com aumento/redução, mas não
afeta a resposta aos itens de dispositivo da entrada com eixo absoluto
ou com a velocidade de centralização automática.

Atualizando as faixas analógicas relativas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As faixas relativas de E/S da porta analógica também precisam de um
tratamento especial para atender as várias configurações do controle,
mas são um pouco mais simples do que as faixas analógicas absolutas:

* |ogdp| ao eixo da sequência na entrada (|adgd|).
* Quando o valor atual for diferente de zero e o item do dispositivo da
  entrada que produziu o valor atual tenha sido um eixo absoluto, o
  valor atual será adicionado ao valor da faixa, sendo dimensionado
  pela configuração da sensibilidade e nenhum processamento adicional
  será executado.
* Quando o valor atual for diferente de zero e o item do dispositivo da
  entrada que produziu o valor atual for um eixo relativo, o valor atual
  será adicionado ao valor da faixa e dimensionado pela configuração de
  sensibilidade da faixa.
* |ogdp| ao aumento sequencial da entrada (|adgd|); caso este valor seja
  diferente de zero, o valor da configuração de sensibilidade da
  velocidade de aumento/redução da faixa será adicionado e dimensionado
  através da configuração de sensibilidade.
* |ogdp| a redução sequencial da entrada (|adgd|); caso este valor seja
  diferente de zero, o valor da configuração de sensibilidade da
  velocidade de aumento/redução da faixa será reduzido e dimensionado
  através da configuração de sensibilidade.

Observe que o valor de configuração da sensibilidade para as faixas
analógicas relativas afeta a resposta a todas as entradas do usuário.

.. |ogdp| replace:: O gerenciador da porta de E/S lê o valor atual para
	a faixa atribuída
.. |adgd| replace:: através do gerenciador da entrada
