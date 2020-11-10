.. raw:: latex

	\clearpage

Os arquivos de layout
=====================

.. contents:: :local:


.. _layout-intro:

Introdução
----------

Os arquivos de layout [#]_ são usados para informar ao MAME o que exibir
enquanto a emulação de um sistema estiver rodando e também como
organizá-los na tela. O MAME pode renderizar a emulação das telas
originais dos sistemas, as imagens, os textos, as formas e objetos
especiais na saída comum dos dispositivos.
Os elementos podem ser estáticos ou se atualizar de forma dinâmica para
refletir a condição das entradas e das saídas.
Os layouts podem ser gerados automaticamente com base no número ou no
tipo da tela que será emulada, ser construído e conectado internamente
ao binário do MAME ou sendo disponibilizado externamente. Para o MAME os
arquivos de layout são interpretados como arquivos XML porém utilizam a
extensão ``.lay``.

.. raw:: latex

	\clearpage


.. _layout-concepts:

Conceitos básicos
-----------------

.. _layout-concepts-numbers:

Números
~~~~~~~

Os layouts do MAME possuem dois tipos de números, números inteiros e os
de ponto flutuante.

Os números inteiros podem ser usados com notação decimal ou hexadecimal.
Um número decimal inteiro consiste em um prefixo opcional **#**
(hash [#]_), um caractere opcional **+/-** (mais ou menos) ou uma
sequência de dígitos entre **0-9**.

Um número hexadecimal consiste em que um dos prefixos
seja o **$** (cifrão) ou **0x** (zero xis) seguido por uma sequência de
números decimais entre **0-9** em conjunto com as letras entre **A-F**.
Não há diferenciação entre as letras maiúsculas e as letras minúsculas
no índice e nos dígitos dos números hexadecimais.

Os números de ponto flutuante podem ser usados com decimal de ponto
fixo ou com notação científica. Observe que os prefixos do número
inteiro e os valores hexadecimais *não* são aceitos caso um número de
ponto flutuante seja esperado.

São permitidos como atributos ambos os números inteiros e os números de
ponto flutuante. Nesses casos a presença de um prefixo **#** (hash),
**$** (cifrão) ou **0x** (zero xis) faz com que o valor seja
interpretado como um número inteiro.
Caso nenhum prefixo de número inteiro, o ponto decimal ou a letra E
(maiúsculo ou minusculo) seja encontrado na introdução de um expoente,
este será interpretado como um número de ponto flutuante.
Caso nenhum prefixo de número inteiro, ponto decimal ou a letra E seja
encontrado, o número será interpretado como um número inteiro.

Os números são analisados usando uma acentuação de caracteres em C [#]_
por questões de portabilidade.

.. raw:: latex

	\clearpage


.. _layout-concepts-coordinates:

Coordenadas
~~~~~~~~~~~

As coordenadas do layout são representadas internamente através da norma
IEEE754 como um número binário de 32-bit de ponto flutuante (também
conhecido como "*precisão simples*"). O incremento das coordenadas
se dão nas direções da direita e para baixo. A origem (**0,0**) não
possui um significado em particular e valores negativos podem ser
usados.

O MAME pressupõe que as coordenadas da visualização possuem a mesma
proporção de aspecto com relação aos pixels gerados pelo dispositivo
(janela ou nativa).
Considerando que sejam pixels quadrados e sem rotação, isso significa
que a distância seja igual nos eixos **X** e **Y** o que corresponde a
distâncias iguais na vertical e na horizontal que for gerado pela
renderização.

Todos os elementos, os grupos e as visualizações possuem os seus
sistemas internos de coordenadas. Quando um elemento ou um grupo é
referenciado a partir de uma visualização ou de um outro grupo, as
suas coordenadas são dimensionadas de acordo com a necessidade para que
os limites sejam definidos.

Os objetos são posicionados e dimensionados através do elemento
``bounds`` que define os seus limites ou as suas fronteiras. A posição
horizontal e o seu tamanho podem ser definidos de três maneiras:

* a borda esquerda e a largura usando atributos ``x`` e ``width``.
* O centro horizontal e a largura usando atributos ``xc`` e ``width``.
* As bordas esquerda e direita usando atributos ``left`` e ``right``.
* De maneira semelhante a posição vertical e o seu tamanho podem ser
  definidos através da borda superior e a altura usando atributos
  ``y`` e ``height``.
* O centro vertical e a altura usando atributos ``yc`` e ``height``
* As bordas superiores e inferiores usando atributos ``top`` e
  ``bottom``.

No exemplo abaixo estes três elementos ``bounds`` são equivalentes:

.. code-block:: xml

    <bounds x="455" y="120" width="12" height="8" />
    <bounds xc="461" yc="124" width="12" height="8" />
    <bounds left="455" top="120" right="467" bottom="128" />

É possível utilizar diferentes esquemas nas direções horizontal e
vertical. Por exemplo, estes elementos ``bounds`` equivalentes também
são válidos:

.. code-block:: xml

    <bounds x="455" top="120" width="12" bottom="128" />
    <bounds left="455" yc="124" right="467" height="8" />

Caso nenhum valor seja fornecido, é predefindo que seja **1.0** para o
atributo ``width``/``height`` ou ``right``/``bottom``.
O MAME irá considerar como um erro caso os atributos ``width`` ou
``height`` tenham valores negativos, ``right`` tenha um valor menor que
``left`` ou caso ``bottom`` tenha um valor menor que ``top``.

.. raw:: latex

	\clearpage


.. _layout-concepts-colours:

Cores
~~~~~

As cores são definidas no espaço RGBA. O MAME não trabalha com todo o
leque da gama de cores, portanto, as cores serão interpretadas como
sRGB em conjunto da definição do gamma do seu sistema que geralmente é
**2.2**. Os valores dos canais são definidos como números de ponto
flutuante. Os valores dos canais vermelho, verde e azul variam entre
**0.0** (desligado) até **1.0** (intensidade plena).
Os valores alfa variam entre **0.0** (transparência absoluta) até
**1.0** (opaco). Os valores dos canais das cores não são previamente
multiplicadss pelo valor alfa.

O componente e a cor do item da visualização são definidas através dos
elementos ``color``.
Os atributos relevantes são vermelho ``red``, verde ``green``,
azul ``blue`` e ``alpha``. Este exemplo do elemento ``color`` determina
todos os valores dos canais:

.. code-block:: xml

    <color red="0.85" green="0.4" blue="0.3" alpha="1.0" />

Qualquer atributo omitido do canal terá o seu valor predefinido para
**1.0** (intensidade absoluta ou opaca). Será considerado como um erro
caso os valores do canal estejam fora do intervalo entre de **0.0** até
**1.0**.

Nem toda a ferramenta de edição de imagens trabalhe com o mesmo sistema
que o MAME, assim sendo, utilize
`esta calculadora <https://doc.instantreality.org/tools/color_calculator/>`_
para converter um valor RGB hexadecimal usado em HTML ou RGB por
exemplo, para o formato que o MAME aceita.

.. _layout-concepts-params:

Parâmetros
~~~~~~~~~~

Os parâmetros funcionam como variáveis que podem ser utilizadas para
substituir o valor dos atributos, basta cercar o seu nome com caracteres
til *(~)*.
Nenhuma substituição será feita caso nenhum parâmetro seja definido.
No exemplo abaixo é possível ver como os valores dos parâmetros
``digitno`` e do ``x`` substituirão o ``~digitno~`` e o ``~x~``:

.. code-block:: xml

	<repeat count="8">
		<param name="digitno" start="1" increment="1" />
		<param name="x" start="0" increment="114" />
	<element name="digit~digitno~" ref="digit">
		<bounds x="~x~" y="80" width="25" height="40" />
	</element>

Um nome para o parâmetro é uma sequência de letras maiúsculas das letras
**A-Z**, das letras minusculas **a-z**, dígitos decimais **0-9**, ou
caracteres subtraço (_).
As letras maiúsculas e as letras minúsculas são levadas em consideração
nos nomes dos parâmetros. Durante a procurar por um parâmetro o motor do
layout começando a trabalhar da parte mais interna do escopo atual até a
sua parte mais externa. O nível mais periférico do escopo corresponde ao
elemento do primeiro nível ``mamelayout``. Cada elemento ``repeat``,
``group`` ou ``view`` cria um novo nível de encadeamento do escopo.

Internamente um parâmetro pode conter uma string, números inteiros ou
números de ponto flutuante, porém esta é bem mais óbvia.
Os números inteiros são armazenados como *64-bit signed* com dois valores
complementares, já os números de ponto flutuante são armazenados como
binários *IEEE754* com *64-bit*, estes números também são conhecido como
"precisão dupla". Os números inteiros são substituídos em notação
decimal, já os números de ponto flutuante são substituídos pelo seu
formato padrão que pode ser um decimal de ponto fixo ou dependendo do
valor pode ser uma notação científica. Não há nenhuma maneira de
substituir a formatação predefinida dos parâmetros de um número inteiro
ou de ponto flutuante.

Existem dois tipos de parâmetros: os *valores* e os *geradores*. O
parâmetro "value" mantém o seu valor atribuído até que eles sejam
alterados, já o parâmetro "*gerador*" possui um valor inicial, um
incremento e/ou um deslocamento [#]_ aplicado em cada interação.

Os valores dos parâmetros são atribuídos através do elemento ``param``
junto com os elementos ``name`` e ``value``, os seus valores podem
aparecer de dentro de um elemento de primeiro nível ``mamelayout`` e
dentro dos elementos ``repeat``, ``view`` assim como dentro da definição
dos elementos ``group`` (isso é, elementos ``group`` dentro do nível
superior do elemento ``mamelayout``, ao contrário dos elementos
``group`` dentro de elementos ``view`` definidos por outros elementos
``group``.
O valor do parâmetro pode ser reatribuído a qualquer momento.

Aqui está um exemplo de como atribuir o valor "4" para o parâmetro
"firstdigit":

.. code-block:: xml

	<param name="firstdigit" value="4" />

Os parâmetros dos geradores são atribuídos através do elemento ``param``
em conjunto com os atributos ``name``, ``start``, ``increment``,
``lshift`` e ``rshift``.
Os parâmetros dos geradores só podem aparecer de dentro dos elementos
``repeat`` (consulte :ref:`layout-parts-repeats` para obter mais
informações) e também não devem ser reatribuídos dentro do mesmo escopo
(um parâmetro com um nome idêntico pode ser atribuído em um escopo
através da sua ramificação). Abaixo alguns parâmetros de exemplos dos
geradores:

.. code-block:: xml

    <param name="nybble" start="3" increment="-1" />
    <param name="switchpos" start="74" increment="156" />
    <param name="mask" start="0x0800" rshift="4" />

* O parâmetro ``nybble`` gera os valores 3, 2, 1...
* O parâmetro ``switchpos`` gera os valores 74 (``74``), 230 (``74 + 156``), 386 (``230 + 156``)...
* O parâmetro ``mask`` gera os valores 2048 (``0x0800``), 128 (``0x0800 >> 4``), 8 (``0x80 >> 4``)...

O atributo ``increment`` deve ser um número inteiro ou de ponto
flutuante que será adicionado ao valor do parâmetro. Os atributos
``lshift`` e ``rshift`` devem ser números positivos e inteiros pois
definem a quantidade dos bits que serão aplicados aos parâmetros. O
deslocamento (shift) e o incremento são aplicados no final do bloco que
está sendo repetido antes do inicio da próxima iteração.
O valor do parâmetro poderá ser interpretado como um número de ponto
flutuante ou um número inteiro antes que o incremento ou o deslocamento
seja aplicado. Caso informe ambos os valores para incremento e para o
deslocamento, então o valor do incremento será aplicado primeiro e
depois o valor deslocado.

Caso o atributo ``increment`` esteja presente e seja um número de
ponto flutuante, o seu valor será convertido para um número de ponto
flutuante caso seja necessário antes que o incremento seja adicionado.
Caso o atributo ``increment`` esteja presente e seja um valor inteiro
enquanto o valor do parâmetro seja um número de ponto flutuante, o valor
do incremento será convertido para um número de ponto flutuante antes
que o valor seja adicionado.

Caso os atributos ``lshift`` ou ``rshift`` estejam presentes porém não
sejam iguais, o valor do parâmetro será convertido para um número
inteiro e deslocado conforme a necessidade. O deslocamento para a
esquerda é definido como um deslocamento feito em direção ao bit de
maior importância.
Caso ambos os parâmetros ``lshift`` e ``rshift`` sejam passados, estes
serão compensados antes dos valores serem aplicados. Significa que
não é possível usar atributos iguais tanto para o ``lshift`` como para o
`rshift`` por exemplo para limpar os bits em um valor do final do
parâmetro após a primeira iteração.

Será considerado um erro caso o elemento ``param`` não esteja em
qualquer um dos atributos ``value`` ou ``start``, será também
considerado um erro caso ambos os elementos ``param`` tiverem  os mesmos
atributos ``value`` ou qualquer um dos mesmos atributos ``start``,
``increment``, ``lshift``, ou ``rshift``.

Um elemento ``param`` define ou reatribui o seu valor em um parâmetro no
escopo atual mais interno. Não é possível definir ou reatribuir os
parâmetros em um escopo de contenção.

.. raw:: latex

	\clearpage

.. _layout-concepts-predef-params:

Parâmetros já predefinidos
~~~~~~~~~~~~~~~~~~~~~~~~~~

Uma certa quantidade de valores predefinidos nos parâmetros já estão
disponíveis e fornecem informações sobre a máquina que está em execução:

**devicetag**

	Um exemplo do caminho completo da etiqueta [#TAG]_ dispositivo que será
	responsável pela leitura do layout, seria ``:`` para o driver do
	controlador do dispositivo raiz ou ``:tty:ie15`` para o terminal
	conectado em uma porta. Este parâmetro é uma sequência de caracteres
	definida no escopo global de visualização do layout.

**devicebasetag**

	A base da etiqueta do dispositivo que será responsável pela leitura
	do layout, como por exemplo ``root`` para o driver do dispositivo
	raiz ou ``ie15`` para o terminal que estiver conectado em uma porta.
	Este parâmetro é uma sequência de caracteres definida no escopo
	global do layout.

**devicename**

	O nome completo (descrição) do dispositivo que será responsável pela
	leitura do layout, como por exemplo os terminais ``AIM-65/40`` ou
	``IE15``. Este parâmetro é uma sequência de caracteres
	definida no escopo global do layout.

**deviceshortname**

	Um nome curto do dispositivo que será responsável pela leitura do
	layout, como por exemplo os terminais ``aim65_40`` ou ``ie15``.
	Este parâmetro é uma sequência de caracteres definida no escopo
	global do layout.

**scr0physicalxaspect**

	A parte horizontal da relação de aspecto físico da primeira tela
	(caso esteja presente). A relação de aspecto físico é fornecida como
	uma fração impropriamente reduzida. Observe que este é o componente
	horizontal aplicado *antes* da rotação. Este parâmetro é um número
	inteiro definido no escopo global do layout.

**scr0physicalyaspect**

	A parte vertical da relação de aspecto físico da primeira tela
	(caso esteja presente). A relação de aspecto físico é fornecida como
	uma fração impropriamente reduzida. Observe que este é o componente
	vertical aplicado *antes* da rotação. Este parâmetro é um número
	inteiro definido no escopo global do layout.

**scr0nativexaspect**

	A parte horizontal da relação de aspecto do pixel visível na região
	da primeira tela (caso esteja presente). A relação de aspecto
	do pixel é fornecida como uma fração impropriamente reduzida.
	Observe que este é o componente horizontal aplicado *antes* da
	rotação. Este parâmetro é um número inteiro definido no escopo
	global do layout.

**scr0nativeyaspect**

	A parte vertical da relação de aspecto do pixel visível na região da
	primeira tela (caso esteja presente). A relação de aspecto do pixel
	é fornecida como uma fração impropriamente reduzida. Observe que
	este é o componente vertical aplicado *antes* da rotação. Este
	parâmetro é um número inteiro definido no escopo global do layout.

.. raw:: latex

	\clearpage

**scr0width**

	A largura da região visível da primeira tela (se houver) nos pixels
	emulados. Observe que a largura é aplicada *antes* da rotação.
	Este parâmetro é um número inteiro definido no escopo global do
	layout.

**scr0height**

	A altura da região visível da primeira tela (se houver) nos pixels
	emulados. Observe que a altura é aplicada *antes* da rotação.
	Este parâmetro é um número inteiro definido no escopo global do
	layout.

**scr1physicalxaspect**

	A parte horizontal da relação de aspecto físico da primeira tela
	(caso esteja presente). Este parâmetro é um número inteiro definido
	no escopo global do layout.

**scr1physicalyaspect**

	A parte vertical da relação de aspecto físico da segunda tela
	(caso esteja presente). Este parâmetro é um número inteiro
	definido no escopo global do layout.

**scr1nativexaspect**

	A parte horizontal da relação de aspecto do pixel visível na região
	da segunda tela (caso esteja presente). Este parâmetro é um número
	inteiro definido no escopo global de visualização do layout.

**scr1nativeyaspect**

	A parte vertical da relação de aspecto do pixel visível na região da
	segunda tela (caso esteja presente). Este parâmetro é um número inteiro
	definido no escopo global de visualização do layout.

**scr1width**

	A largura da região visível da segunda tela (se houver) nos pixels
	emulados. Este parâmetro é um número inteiro definido no escopo
	global do layout.

**scr1height**

	A altura da região visível da segunda tela (se houver) nos pixels
	emulados. Este parâmetro é um número inteiro definido no escopo
	global do layout.

**scr\ *N*\ physicalxaspect**

	A parte horizontal da relação de aspecto físico da tela (base-zero)
	*N*\ th (caso esteja presente). Este parâmetro é um número inteiro
	definido no escopo global do layout.

**scr\ *N*\ physicalyaspect**

	A parte vertical da relação de aspecto físico da tela (base-zero)
	*N*\ th (caso esteja presente). Este parâmetro é um número inteiro
	definido no escopo global do layout.

**scr\ *N*\ nativexaspect**

	A parte horizontal da relação de aspecto da parte visível da tela
	(base-zero) *N*\ th (caso esteja presente). Este parâmetro é um
	número inteiro definido no escopo global do layout.

**scr\ *N*\ nativeyaspect**

	A parte vertical da relação de aspecto da parte visível da tela
	(base-zero) *N*\ th (caso esteja presente). Este parâmetro é um
	número inteiro definido no escopo global do layout.

.. raw:: latex

	\clearpage

**scr\ *N*\ width**

	A largura da região visível da tela (base-zero) *N*\ th (se
	presente) nos pixels emulados. Este parâmetro é um número inteiro
	definido no escopo da visualização do layout.

**scr\ *N*\ height**

	A largura da região visível da tela (base-zero) *N*\ th (se
	presente) nos pixels emulados. Este parâmetro é um número inteiro
	definido no escopo de visualização do layout.

**viewname**

	O nome da visualização atual. Este parâmetro é uma sequências de
	caracteres definido no escopo de visualização.
	Não é definido fora do campo de visão.


Para parâmetros relacionados à tela, elas são numeradas do zero na
ordem em que aparecem na configuração da máquina. Todas as telas estão
inclusas (não apenas nos sub-dispositivos do dispositivo que fizeram com
que o layout fosse carregado). **X/width** e **Y/height** referem-se as
dimensões horizontal e vertical da tela *antes* da rotação ser aplicada.
Os valores baseados na região visível são calculados no final da
configuração. Caso o sistema não reconfigure a tela durante a execução
os valores dos parâmetros não serão atualizados assim como os layouts
não serão recalculados.

.. raw:: latex

	\clearpage

.. _layout-parts:

As partes de um layout
----------------------

Uma visualização define a disposição de um objeto gráfico a ser exibido.
O arquivo de layout do MAME pode conter diversas visualizações. As
visualizações são construídas a partir de elementos *elements* e telas
*screens*. Para simplificar a organização de layouts complexos são
compatíveis entre si a repetição dos blocos e dos grupos que podem ser
reutilizados.

O primeiro elemento do cabeçalho de um arquivo de layout do MAME deve
ser um elemento chamado ``mamelayout`` junto com um atributo
``version``. O atributo ``version`` deve ser um valor inteiro.
Atualmente, o MAME suporta apenas a versão 2 e não carregará qualquer
outra versão diferente.
Este é um exemplo de uma tag inicial para um elemento ``mamelayout``:

.. code-block:: xml

	<mamelayout version="2">

Para fins de compatibilidade na identificação do arquivo com diversos
editores de texto é possível declarar que o mesmo é um arquivo XML,
logo, o MAME também aceita o arquivo com uma declaração XML:

.. code-block:: xml

	<?xml version="1.0"?>
	<mamelayout version="2">

Da mesma maneira que é possível usar o identificador XML, também é
possível identificar a codificação do arquivo caso seja necessário:

.. code-block:: xml

	<?xml version="1.0" encoding="UTF-8"?>
	<mamelayout version="2">

Os comentários podem ser adicionados em qualquer parte do arquivo desde
que estejam entre ``<!--`` e ``-->``:

.. code-block:: xml

	<?xml version="1.0"?>
	<!-- Este é um comentário -->
	
	<!--
	Este tipo de comentário também é válido.
	-->
	
	<!--
		Também é possível incluir longas instruções ou informações
		relevantes no seu arquivo de layout para que as pessoas saibam
		o que fazer ou como prosseguir caso seja necessário.
		Identifique os seus arquivos, utilize estes espaços para deixar
		o seu nome ou apelido, a versão, a data que o layout foi criado
		ou que o arquivo foi alterado, a descrição das alterações, os
		direitos autorais, etc.
		
		The Alpha Betas and the Lambda Lambda Lambda Fraternity
		Versão: 1.0
		Criado em: 10/11/2020
		Licença: CC by 4.0
	-->

	<mamelayout version="2">

.. raw:: latex

	\clearpage

Algumas regras devem ser observadas ao adicionar os comentários:

* Os comentários não devem aparecer antes da declaração XML.
* Os comentários não devem aparecer dentro da etiqueta de um elemento.
* Os comentários não devem aparecer dentro do valor de um atributo.
* Os comentários não pode ter a sequência de caracteres ``--``.

Em geral, as ramificações do primeiro elemento ``mamelayout`` são
processados na ordem em que eles chegam, de cima para baixo, exceto as
visualizações que são processadas por último.
Isso significa que as visualizações veem os valores finais de todos os
parâmetros no final do elemento ``mamelayout`` e pode se referir a
elementos e grupos que possam aparecer depois deles.

Os seguintes elementos são permitidos dentro do primeiro elemento
``mamelayout``:

**param**

    Define ou reatribui um valor ao parâmetro. Consulte
    :ref:`layout-concepts-params` para mais informações.


**element**

    Define um elemento, um dos objetos primários a serem organizados
    em uma Visualização. Consulte :ref:`layout-parts-elements` para
    obter mais informações.

**group**

    Define um grupo dos elementos ou das telas que possam ser
    reutilizáveis e que também possam ser usados como referência numa
    visualização ou nos outros grupos.

    Consulte :ref:`layout-parts-groups` para obter mais informações.

**repeat**

    Um grupo de elementos repetidos que podem conter os elementos
    ``param``, ``element``, ``group`` e ``repeat``.
    Consulte :ref:`layout-parts-repeats` para obter mais informações.

**view**

    Um arranjo dos elementos ou das telas que podem ser exibidos na
    saída de um dispositivo (uma janela ou uma tela do host).
    Consulte :ref:`layout-parts-views` para obter mais informações.

**script**

    Permite que scripts lua sejam usados num layout aprimorado ainda
    mais a interação.


.. raw:: latex

	\clearpage

.. _layout-parts-elements:

Os elementos
~~~~~~~~~~~~

Os elementos são um dos objetos visuais mais básicos que podem ser
organizados em conjunto com as telas na composição de uma visualização.
Os elementos podem ser construídos com um ou mais componentes porém um
elemento é tratado como uma única superfície na composição do gráfico
da cena e da sua renderização. Um elemento pode ser usado em diversas
visualizações e pode também serem utilizadas várias vezes dentro da
visualização.

A aparência de um elemento depende do seu *estado*. O estado é um
valor inteiro que geralmente vem de uma região da porta E/S ou da
emulação gerada (consulte :ref:`layout-interact-elemstate` para obter
mais informações de como conectar um elemento numa porta ou na saída
E/S de uma emulação).
Qualquer componente de um elemento pode estar restrito apenas ao desenho
quando o estado do elemento tiver um valor em particular. Alguns
componentes (como os mostradores com múltiplos segmentos e os
mostradores rotativos [#]_ (reels) por exemplo) que usam diretamente o
seu estado para determinar a sua aparência final.

Cada elemento possui o seu próprio sistema interno de coordenadas. Os
limites dos elementos dos sistema de coordenadas são computados através
da união dos limites individuais dos componentes que ele é composto.

Todo elemento deve ter o seu nome definido através do atributo ``name``.
Os elementos são mencionados através do nome quando forem solicitados
nos grupos ou nas visualizações. Haverá um erro caso o arquivo de
layout tenha vários elementos ``name`` com valores iguais.
Os elementos podem de forma opcional, ser utilizado para informar um
valor padrão do seu estado através do atributo ``defstate`` caso esteja
conectado em uma saída emulada ou em uma porta E/S. O valor do atributo
``defstate`` deve possuir um valor inteiro e positivo, os valores
negativos geram erros e fazem com que o layout não seja mais carregado.

As ramificações do elemento ``element`` instanciam componentes que são
desenhados na textura do elemento na ordem de leitura a partir do
primeiro ao último elemento utilizando alpha blending (os componente são
desenhados por cima e podem se sobrepor aos componentes que venham antes
dele). Todos os componentes são compatíveis com algumas características
em comum:

* Os componentes podem ser desenhados de forma condicional dependendo da
  condição do elemento ao informar os atributos ``state`` ou
  ``statemask``. Caso estejam presentes, estes atributos devem ser
  inteiros com valores positivos. Caso apenas o atributo ``state``
  esteja presente, então o componente só será desenhado na tela quando
  o elemento ``state`` coincidir com o seu valor. Caso apenas o atributo
  ``statemask`` esteja presente, então o componente só será desenhado na
  tela caso todos os bits estejam definidos e os seus valores estejam
  definidos através do atributo ``state``.
  
  Na existência de ambos os atributos ``state`` e ``statemask``, então o
  componente só será desenhado na tela quando os bits no elemento
  ``state`` corresponderem ao bit que estiver definido no atributo
  ``statemask`` e também corresponder com os bits do valor do atributo
  ``state``.
  
  O componente sempre será desenhado na ausência de ambos os atributos
  ``state`` ou ``statemask`` ou caso o valor do atributo ``statemask``
  for zero.

.. raw:: latex

	\clearpage

* Cada componente pode ter um sub-elemento ``bounds`` definindo a
  sua posição e o seu tamanho (consulte
  :ref:`layout-concepts-coordinates`). Na ausência de tal elemento os
  limites serão predefinidos a uma unidade quadrada com o valor igual a
  **1.0** tanto para a largura quanto para a altura e com o canto
  superior esquerdo com valor **0.0**.
  
  A posição ou o tamanho de um componente pode ser animado de acordo com
  o estado do elemento ao prover diversos elementos ``bounds`` em
  conjunto com atributos ``state``. O atributo ``state`` de cada
  ramificação do elemento ``bounds`` deve ser um número inteiro e
  positivo. Os atributos ``state`` não devem ser iguais para quaisquer
  um dos dois elementos ``bounds`` que estiverem dentro de um
  componente.
  
  Caso o estado do elemento seja inferior que o valor do atributo
  ``state`` de qualquer uma das ramificações do elemento ``bounds``,
  será utilizada a posição/tamanho definido através do elemento
  ``bounds`` com o menor valor do atributo ``state``. Já quando o estado
  do elemento for maior que o valor do atributo ``state`` de qualquer
  elemento ``bounds``, será utilizada a posição/tamanho especificado
  através do elemento ``bounds`` com o maior valor do atributo
  ``state``. Se o estado do elemento estiver entre os valores do
  atributo ``state`` dos dois elementos ``bounds``, a posição/tamanho
  será interpolada de forma linear.
* Cada componente de cor pode ter um elemento ``color`` definindo uma
  cor RGBA (Consulte :ref:`layout-concepts-colours` para obter mais
  informações).
  Isto pode ser usado para controlar a geometria da cor dos componentes
  desenhados de forma algorítmica ou textual. Para os componentes
  ``image``, a cor dos pixels da imagem são multiplicadas através da cor
  que foi definida. Caso tal elemento não esteja presente, será usada
  uma cor branca opaca já predefinida.
  
  A cor do componente pode ser animada de acordo com o estado do
  elemento ao prover diversos elementos ``color`` em conjunto com os
  atributos ``state``. Os atributos ``state`` não devem ser iguais em
  qualquer um dos dois elementos ``color`` internos de um componente.
  
  Caso o estado do elemento seja inferior ao valor do atributo ``state``
  de qualquer elemento ``color``, será utilizada a cor especificada
  através do elemento ``color`` com o menor valor do atributo ``state``.
  
  Caso o estado do elemento seja superior ao valor do atributo ``state``
  de qualquer elemento ``color``, será utilizada a cor especificada
  através do elemento ``color`` com o maior valor do atributo ``state``.
  Caso o estado do elemento estiver entre os valores do atributo
  ``state`` de dois elementos ``color``, os componentes de cor RGBA
  serão interpolados de forma linear.

.. raw:: latex

	\clearpage

Há suporte para os seguintes componentes:

**rect**

	Desenha um retângulo colorido uniforme com as suas bordas preenchidas.

**disk**

	Desenha uma elipse (círculo) colorido e uniforme.

**image**

	Desenha uma imagem carregada a partir um arquivo PNG, JPEG, Window
	DIB (BMP) ou arquivo SVG. O nome do arquivo a ser carregado
	(incluindo o nome da extensão do arquivo) é informado usando o
	atributo ``file``. Adicionalmente, um atributo opcional
	``alphafile`` pode ser usado para determinar o nome de um
	arquivo PNG (incluindo o nome da extensão do arquivo) para ser
	carregado dentro do canal alfa da imagem.

	Caso o atributo ``alphafile`` esteja relacionado a um arquivo, este
	deve ter as mesmas dimensões (em pixels) que o arquivo definido
	através do atributo ``file`` e a sua profundidade de bits por pixel
	da imagem não deve ser maior que 8 bits por canal. A intensidade de
	brightness desta imagem, é copiada para o canal alfa com plena
	intensidade (branco em escala de cinza) o que corresponde a um opaco
	pleno e o preto a uma transparência plena.
	
	O atributo ``alphafile`` será ignorado caso o atributo ``file``
	aponte para um arquivo SVG, o atributo é apenas utilizado com
	imagens do tipo bitmap.

	O(s) arquivo(s) da(s) imagem(s) devem ser colocados no mesmo
	diretório que o arquivo de layout. Os formatos da imagem são
	detectados durante a analise do conteúdo dos arquivos, os nomes das
	extensões dos arquivos não são levados em consideração. Note porém
	que nos sistemas \*nix o nome dos aquivos com maiúsculas e com
	minúsculas são levadas em consideração quando não estiverem dentro
	de um arquivo ``.zip`` ou ``.7z``.

	É possível identificar quando o MAME não conseguir carregar as
	imagens pois aparecem uma sequência de pequenas bolinhas cinzas na
	tela, isso mostra que ou o MAME não encontrou os arquivos ou houve
	algum outro erro com o formato do arquivo.

**text**

	Desenha o texto usando a fonte da interface e na cor definida pelo
	usuário. O texto que será desenhado deve ser informado através do
	atributo ``string``.  Um atributo ``align`` pode ser usado para
	definir o alinhamento do texto. Se presente, o atributo ``align``
	deve ser um valor inteiro onde (zero) significa centralizado, 1 (um)
	alinhado à esquerda e 2 (dois) alinhado à direita.
	Caso o atributo ``align`` esteja ausente o texto será
	centralizado automaticamente.

**dotmatrix**

	Desenha um segmento horizontal de oito pixels em um mostrador em
	formato de matriz de pontos, usando pixels circulares em uma cor
	determinada. Os bits que determinam o estado do elemento definem
	quais os pixels que estarão acesos, com o bit de menor importância
	correspondendo ao pixel mais à esquerda. Os pixels que estiverem
	apagados são desenhados com uma intensidade menor (**0x20/0xff**).

**dotmatrix5dot**

	Desenha um segmento horizontal de cinco pixels em um mostrador em
	formato de matriz de pontos, usando pixels circulares em uma cor
	determinada. Os bits que determinam o estado do elemento definem
	quais os pixels que estarão acesos, com o bit de menor importância
	correspondendo ao pixel mais à esquerda. Os pixels que estiverem
	apagados são desenhados com uma intensidade menor (**0x20/0xff**).

.. raw:: latex

	\clearpage

**dotmatrixdot**

	Desenha um único elemento de um mostrador em formato de de matriz de
	pontos com pixels circulares em uma determinada cor. O bit de menor
	importância do estado do elemento determina se o pixel vai estar
	aceso. Um pixel apagado é desenhado com uma intensidade menor
	(**0x20/0xff**).

**led7seg**

	Desenha um mostrador LED ou fluorescente alfanumérico comum com
	dezesseis segmentos e o mostrador em uma cor determinada. Os oito bits
	baixos do estado do elemento controlam quais os segmentos estarão
	acesos. Começando pelo bit de menor importância a sequência de
	atualização dos bits correspondentes começam no segmento superior,
	superior direito, depois continuando no sentido horário para o
	segmento superior esquerdo, a barra central e o ponto decimal.
	Os pixels que estiverem apagados são desenhados com uma intensidade
	menor (**0x20/0xff**).

**led8seg_gts1**

	Desenha um mostrador fluorescente digital de oito segmentos do tipo
	usado em máquinas de fliperama *Gottlieb System 1* [#]_ (na verdade
	uma parte da Futaba). Comparado com um mostrador padrão com sete
	segmentos, esses mostradores não têm ponto decimal, a barra do meio
	horizontal está quebrada no centro, assim como no meio da barra
	vertical controlada pelo bit que controlaria o ponto decimal num
	mostrador comum com sete segmentos. Os pixels que estiverem apagados
	são desenhados com uma intensidade menor (**0x20/0xff**).

**led14seg**

	Desenha um mostrador LED ou fluorescente alfanumérico padrão com
	catorze segmentos em uma cor determinada. Os 14 bits mais baixos do
	controle de estado do elemento determinam quais os segmentos estarão
	acesos.
	Começando pelo bit com menor importância, os bits correspondentes ao
	segmento superior, o segmento superior direito, continuando no
	sentido horário para o segmento superior esquerdo, as metades
	esquerda e direita da barra central horizontal, as metades superior
	e inferior do meio vertical da barra, e as barras diagonais no
	sentido horário da parte inferior esquerda para a direita inferior.
	Os pixels que estiverem apagados são desenhados com uma intensidade
	menor (**0x20/0xff**).

**led14segsc**

	Desenha um mostrador LED ou fluorescente alfanumérico padrão com
	catorze segmentos com ponto decimal/vírgula em uma cor determinada.
	Os 16 bits baixos do elemento controlam quais segmentos estarão
	acesos. Os 14 bits baixos correspondem aos mesmos segmentos que no
	componente ``led14seg``. Os dois bits adicionais correspondem ao
	ponto decimal e a vírgula. Os pixels que estiverem apagados são
	desenhados com uma intensidade menor (**0x20/0xff**).

.. raw:: latex

	\clearpage

**led16seg**

	Desenha um mostrador LED ou fluorescente alfanumérico padrão com
	dezesseis segmentos em uma cor determinada. Os 16 bit baixos do
	elemento controlam quais os elementos que estarão acesos. Começando
	pelo bit de menor importância a sequência de atualização dos bits
	correspondentes começam da metade esquerda da barra superior, a
	metade direita da barra superior, continuando no sentido horário
	para o segmento superior esquerdo, as metades esquerda e direita da
	barra central e horizontal, as metades superior e inferior da barra
	do meio vertical, e as barras diagonais no sentido horário a partir
	do canto inferior esquerdo até a parte inferior direito. Os pixels
	que estiverem apagados são desenhados com uma intensidade menor
	(**0x20/0xff**).

**led16segsc**

	Desenha um mostrador LED ou fluorescente alfanumérico padrão com
	dezesseis segmentos e o ponto decimal em uma determinada cor.
	Os 16 bits baixos do elemento controlam quais os segmentos estarão
	acesos. Os 18 bits inferiores correspondem aos mesmos controles do
	estado dos segmentos que em ``led16seg``. Os dois bits adicionais
	correspondem ao ponto decimal e a vírgula. Os pixels que estiverem
	apagados são desenhados com uma intensidade menor (**0x20/0xff**).

**simplecounter**

	Exibe o valor numérico do estado do elemento usando a fonte do
	sistema em uma cor determinada. O valor é formatado em notação
	decimal. Um atributo ``digits`` pode ser informado para definir a
	quantidade mínima de dígitos que serão exibidos. Se presente, o
	atributo ``digits`` deve ser um número inteiro, na sua ausência será
	exibido um dígito com no mínimo dois dígitos.

	O atributo ``maxstate`` pode ser informado para definir o valor
	máximo do estado que será exibido. Se presente, o atributo
	``maxstate`` deve ser um número positivo; na sua ausência o valor
	predefinido é **999**.  Um atributo ``align`` pode ser usado para
	determinar o alinhamento do texto através do atributo ``align``
	que deve ser um número inteiro onde **0** significa alinhar
	ao centro, **1** alinhar à esquerda e **2** alinhar à direita.
	Na sua ausência, o texto será centralizado automaticamente.

**reel**

	Usado para desenhar os cilindros usados por máquinas de caça
	níquel.
	Os atributos compatíveis são ``symbollist``, ``stateoffset``,
	``numsymbolsvisible``, ``reelreversed`` e ``beltreel``.

.. raw:: latex

	\clearpage

Um exemplo de um elemento que desenha um texto estático do lado esquerdo
da tela:

.. code-block:: xml

	<element name="label_reset_cpu">
		<text string="CPU" align="1"><color red="1.0" green="1.0" blue="1.0" /></text>
	</element>


Um exemplo de um elemento que mostra um LED redondo onde a intensidade
do seu brilho depende do nível do seu estado na saída:

.. code-block:: xml

	<element name="led" defstate="0">
		<rect state="0"><color red="0.43" green="0.35" blue="0.39" /></rect>
		<rect state="1"><color red="1.0" green="0.18" blue="0.20" /></rect>
	</element>

Um exemplo de um elemento para um botão que retorna um efeito visual
quando ele for clicado:

.. code-block:: xml

	<element name="btn_rst">
		<rect state="0"><bounds x="0.0" y="0.0" width="1.0" height="1.0" /><color red="0.2" green="0.2" blue="0.2" /></rect>
		<rect state="1"><bounds x="0.0" y="0.0" width="1.0" height="1.0" /><color red="0.1" green="0.1" blue="0.1" /></rect>
		<rect state="0"><bounds x="0.1" y="0.1" width="0.9" height="0.9" /><color red="0.1" green="0.1" blue="0.1" /></rect>
		<rect state="1"><bounds x="0.1" y="0.1" width="0.9" height="0.9" /><color red="0.2" green="0.2" blue="0.2" /></rect>
		<rect><bounds x="0.1" y="0.1" width="0.8" height="0.8" /><color red="0.15" green="0.15" blue="0.15" /></rect>
		<text string="RESET"><bounds x="0.1" y="0.4" width="0.8" height="0.2" /><color red="1.0" green="1.0" blue="1.0" /></text>
	</element>

Um exemplo de um elemento que desenha um LED de sete segmentos
usando imagens externas:

.. code-block:: xml

	<element name="digit_a" defstate="0">
		<image file="a_off.png" />
		<image file="a_a.png" statemask="0x01" />
		<image file="a_b.png" statemask="0x02" />
		<image file="a_c.png" statemask="0x04" />
		<image file="a_d.png" statemask="0x08" />
		<image file="a_e.png" statemask="0x10" />
		<image file="a_f.png" statemask="0x20" />
		<image file="a_g.png" statemask="0x40" />
		<image file="a_dp.png" statemask="0x80" />
	</element>

.. raw:: latex

	\clearpage

Um exemplo de um gráfico com barras que crescem verticalmente e mudam da
cor verde, passando pelo amarelo e para o vermelho à medida que o nível
for aumentando:

.. code-block:: xml

	<element name="pedal">
		<rect>
			<bounds state="0x000" left="0.0" top="0.9" right="1.0" bottom="1.0" />
			<bounds state="0x610" left="0.0" top="0.0" right="1.0" bottom="1.0" />
			<color state="0x000" red="0.0" green="1.0" blue="0.0" />
			<color state="0x184" red="1.0" green="1.0" blue="0.0" />
			<color state="0x610" red="1.0" green="0.0" blue="0.0" />
		</rect>
	</element>

Um exemplo de um gráfico com barras que crescem horizontalmente para a
esquerda ou para a direita e muda de cor do verde, passando pelo
amarelo e para o vermelho à medida que o nível muda da posição neutra:

.. code-block:: xml

	<element name="wheel">
		<rect>
			<bounds state="0x800" left="0.475" top="0.0" right="0.525" bottom="1.0" />
			<bounds state="0x280" left="0.0" top="0.0" right="0.525" bottom="1.0" />
			<bounds state="0xd80" left="0.475" top="0.0" right="1.0" bottom="1.0" />
			<color state="0x800" red="0.0" green="1.0" blue="0.0" />
			<color state="0x3e0" red="1.0" green="1.0" blue="0.0" />
			<color state="0x280" red="1.0" green="0.0" blue="0.0" />
			<color state="0xc20" red="1.0" green="1.0" blue="0.0" />
			<color state="0xd80" red="1.0" green="0.0" blue="0.0" />
		</rect>
	</element>


.. raw:: latex

	\clearpage

.. _layout-parts-views:

As visualizações
~~~~~~~~~~~~~~~~

Uma visualização define um arranjo dos elementos ou das imagens exibidas
da tela emulada numa janela ou numa tela.
As exibições também conectam os elementos, as entradas E/S e as saídas
emuladas.
Um arquivo de layout pode conter vários modos de visualização. Caso uma
visualização corresponda a uma tela inexistente, ela se torna
*inválida*.

O MAME exibirá uma mensagem de aviso ignorando toda a visualização que
for considerada inválida e continuará a carregar aquelas que forem
consideradas corretas.
Isso é muito útil nos sistemas onde uma tela seja opcional, como
computadores que tenham apenas controles no painel frontal e onde um
terminal serial seja opcional.

As visualizações são identificadas através do nome na interface de
usuário do MAME ou na linha de comando. Para os arquivos de layouts que
sejam associados aos dispositivos ou a outros onde o dispositivo do
controlador principal, os nomes das visualizações dos dispositivos sejam
precedidos por uma tag (com os dois pontos iniciais omitidos) por
exemplo, para exibir um dispositivo chamado "*Keyboard LEDs*" vindo do
dispositivo ``:tty:ie15``, ele deve ser associado como **tty:ie15
Keyboard LEDs**.

As visualizações são exibidas na ordem em que forem sendo carregadas.

As visualizações são criadas com elementos ``view`` dentro de um
atributo do primeiro nível do elemento ``mamelayout``. É obrigatório que
cada elemento ``view`` tenha um atributo ``name`` informando um nome
único que será disponibilizado na interface do usuário e nas opções da
linha de comando. Este é um exemplo de um atributo válido para um
elemento ``view``:

.. code-block:: xml

    <view name="Painel de controle">

O elemento "view" cria uma seção visível do ``mamelayout``. Os elementos
``view`` apenas são processados **depois** que todas as outras
ramificações dos outros elementos do``mamelayout`` forem corretamente
carregadas. Isso significa que uma visualização pode fazer referência a
elementos e aos grupos que apareçam posteriormente naquele arquivo assim
como os valores finais dos parâmetros que estejam anexados ao escopo do
``mamelayout``.

As seguintes ramificações dos elementos são permitidos dentro de um
elemento ``view``:

**bounds**

	Define a origem e o tamanho da visualização através das coordenadas
	interna do sistema caso um esteja presente.
	Consulte :ref:`layout-concepts-coordinates` para obter mais
	informações.
	Em sua ausência os limites da visualização serão computadas
	unindo os limites de todas as telas e dos elementos dentro da
	região exibida. Só faz sentido ter um elemento ``bounds`` caso seja
	uma ramificação direta de um elemento ``view``.
	Qualquer conteúdo fora dos limites da visualização ficarão
	recortados e a visualização será redimensionada de forma
	proporcional para que se ajuste aos limites da tela ou da
	janela.

**param**

	Define ou reatribui um valor no parâmetro do escopo da visualização.
	Consulte :ref:`layout-concepts-params` para obter mais informações.

.. raw:: latex

	\clearpage

**element**

	Adiciona um elemento à visualização (consulte
	:ref:`layout-parts-elements`) através do atributo do elemento
	obrigatório ``ref``.
	Haverá um erro caso nenhum elemento ``ref`` seja definido no arquivo
	de layout.

	Opcionalmente pode estar conectada em uma porta E/S emulada
	através dos atributos ``inputtag`` e o ``inputmask`` ou através
	da emulação de uma saída usando um atributo ``name``. Consulte
	:ref:`layout-interact-clickable` e também 
	:ref:`layout-interact-elemstate` para obter mais detalhes sobre
	como informar o valor de uma condição/estado para o elemento
	que for solicitado.

**screen**

	Adiciona uma imagem emulada da tela na visualização. A tela deve ser
	identificada através do atributo ``index`` ou do atributo ``tag``
	(um elemento ``screen`` não pode ter ambos os atributos ``index`` e
	``tag``).
	Caso esteja presente, o atributo ``index`` deve ter um valor inteiro
	e positivo. As telas são numeradas através da ordem em que aparecem
	na configuração da máquina, começando com zero (**0**). Caso o
	atributo ``tag`` esteja presente, este deve ser o caminho da
	etiqueta para a tela com relação ao dispositivo para que provoque a
	leitura do layout. As telas são desenhadas na ordem em que aparecem
	no arquivo de layout.

	Pode opcionalmente estar conectada em uma porta E/S emulada através
	dos atributos ``inputtag`` e ``inputmask`` ou através de uma saída
	emulada através do atributo ``name``. Consulte
	:ref:`layout-interact-clickable` para obter mais informações.

**collection**

	Adiciona as telas ou os itens em uma coleção de itens que poderão
	ser exibidos ou escondidos pelo usuário (consulte
	:ref:`layout-parts-collections`). O nome da coleção é definida
	através do atributo ``name``. Há um limite de até 32 ``collection``
	por visualização.

**group**

	Adiciona o conteúdo do grupo na visualização (consulte
	:ref:`layout-parts-groups`). O nome do grupo que será adicionado
	pode ser definido através do atributo ``ref``. Haverá um erro caso
	nenhum grupo com este atributo seja definido no arquivo de layout.
	Veja abaixo para mais informações sobre a questão de posicionamento.

**repeat**

	Repete seu conteúdo pela quantidade de vezes que estiver definida no
	atributo ``count``. O atributo ``count`` deve ser um número inteiro
	e positivo. O elemento ``repeat`` aceita os elementos ``element``,
	``screen``, ``group`` mais os elementos ``repeat`` que funcionam da
	mesma maneira que quando colocados em uma visualização direta.
	Consulte :ref:`layout-parts-repeats` para saber como usar os
	elementos ``repeat``.

.. raw:: latex

	\clearpage

As telas com os elementos ``screen``, elementos de layout ``element`` e
os elementos de grupo ``group``, podem ter a sua orientação alterada
usando o elemento ``orientation``.
Para as telas, os modificadores de orientação são aplicados em conjunto
com os modificadores de orientação definido na tela do dispositivo e na
máquina.
O elemento ``orientation`` suporta os seguintes atributos opcionais:

**rotate**

	Se presente, aplica rotação no sentido horário em incrementos de
	90 graus. Deve ser um número inteiro igual a **0**, **90**,
	**180 (90 + 90)** ou **270 (180 + 90)**.

**swapxy**

	Permite que a tela, elemento ou grupo seja espelhado ao longo de uma
	linha em 45 graus na vertical, da esquerda para a direita.
	Se presente o seu valor deve ser ``yes`` ou ``no``.
	O espelhamento se aplica logicamente após a rotação.

**flipx**

	Permite que a tela, elemento ou grupo sejam espelhados à partir de
	uma linha com 45 graus em torno de seu eixo vertical, vindo da quina
	superior esquerda até a quina inferior direita. Se presente o seu
	valor deve ser ``yes`` ou ``no``.
	O espelhamento ocorre após a rotação.

**flipy**

	Permite que a tela, elemento ou grupo sejam espelhados ao redor do
	seu eixo horizontal de cima para baixo. Se presente o seu valor deve
	ser ``yes`` ou ``no``.
	O espelhamento ocorre após a rotação.

As telas (elementos ``screen``) e os elementos de layout (elementos
``element``) podem conter um atributo ``blend`` para determinar o modo
de mesclagem. Os valores válidos são ``none`` (sem mesclagem), ``alpha``
(mesclagem alpha) [#]_, ``multiply`` (multiplicação RGB) [#]_, e ``add``
(mesclagem aditiva) [#]_. A predefinição para a tela é permitir que o
driver defina a mesclagem por camada, sendo que o modo de mesclagem dos
elementos de layout é predefinido como mesclagem alpha.

As telas (elementos ``screen``), elementos de layout (elementos
``element``) e elementos de grupo (``group``) podem ser posicionados e
redimensionados usando um elemento ``bounds``
(consulte :ref:`layout-concepts-coordinates` para mais informações).
Na ausência do sub-elemento ``bounds`` os elementos "screen" e "layout"
retornam aos valores predefinidos em unidades quadradas (origem em
**0,0** e ambos os valores de altura e largura serão igual a **1**).

Na ausência do elemento ``bounds``, os grupos são expandidos sem
qualquer tradução ou redimensionamento (note que os grupos podem
posicionar as telas ou elementos fora dos seus limites. Este exemplo
mostra uma visualização com referência a posição da tela com um elemento
de layout individual e dois grupos de elementos:

.. code-block:: xml

    <view name="LED Displays, Terminal and Keypad">
        <screen index="0"><bounds x="0" y="132" width="320" height="240" /></screen>
        <element ref="beige"><bounds x="320" y="0" width="172" height="372" /></element>
        <group ref="displays"><bounds x="0" y="0" width="320" height="132" /></group>
        <group ref="keypad"><bounds x="336" y="16" width="140" height="260" /></group>
    </view>

As telas (elementos ``screen``), elementos de layout (``element``) e
elementos de grupos (``group``) podem ter um sub-elemento ``color``
(consulte :ref:`layout-concepts-colours`) ao definir uma cor
modificadora. O valor dessa cor será usada como multiplicador para
alterar as cores componentes da tela ou dos elementos de layout.

As telas (elementos ``screen``) e os elementos de layout (``element``)
podem ter a sua cor, posição e tamanho animados ao invormar diversos
elementos ``color`` e/ou sub-elementos ``bounds`` em conjunto com o
atributo ``state``. Consulte :ref:`layout-interact-itemanim` para obter
mais informações.


.. _layout-parts-collections:

Coleções
~~~~~~~~

As coleções das telas ou dos elementos de layout que possam ser exibidos
ou não pelo usuário conforme a sua necessidade. Em uma visualização
única é possível ambas as visualizações e um teclado numérico (keypad)
selecionável por exemplo, permitir que o usuário esconda o teclado
numérico deixando visível apenas a visualização. As coleções são criadas
através do elemento ``collection`` dentro dos elementos ``view``,
``group`` e dos outros elementos ``collection``.

Um elemento ``collection`` deve ter um atributo ``name`` informando o
nome da visualização. Os nomes destinados para ``collection`` devem ser
únicos. A visualização inicial da coleção deve ser definida através do
atributo ``visible``. Defina o atributo ``visible`` para ``yes`` caso a
coleção deva estar visível desde o inicio ou ``no`` caso queira
escondê-la. É predefinido que as coleções estejam visíveis.

Aqui um exemplo demonstrando a utilização de um ``collection``
permitindo que partes de uma visualização possam ser escondidas pelo
usuário:

.. code-block:: xml

	<view name="Telas LED, CRT e Teclado Numérico">
		<collection name="LED Displays">
			<group ref="displays"><bounds x="240" y="0" width="320" height="47" /></group>
			</collection>
		<collection name="Keypad">
			<group ref="keypad"><bounds x="650" y="57" width="148" height="140" /></group>
			</collection>
			<screen tag="screen"><bounds x="0" y="57" width="640" height="480" /></screen>
	</view>

Uma coleção cria um escopo de parâmetros agrupados. Qualquer elemento
``param`` que estiver dentro do elemento de coleção define os parâmetros
no escopo local para a coleção. Para mais detalhes sobre os parâmetros
consulte :ref:`layout-concepts-params`. Observe que o nome da coleção e
a visualização predefinida não fazem parte do seu conteúdo, quaisquer
referências dos parâmetros nos atributos ``name`` e ``visible`` serão
substituídos usando os valores dos parâmetros a partir da origem do
escopo relacionado com a coleção.

.. raw:: latex

	\clearpage


.. _layout-parts-groups:

Grupos reutilizáveis
~~~~~~~~~~~~~~~~~~~~

Os grupos permitem que um arranjo de telas ou de elementos de layout
sejam usados várias vezes em uma visualização ou outros grupos. Os
grupos podem ser de grande ajuda mesmo que seja usado o arranjo apenas
uma vez, pois eles podem ser usados para agregar parte de um layout
complexo.
Os grupos são definidos usando elementos ``group`` dentro de elementos
``mamelayout`` de primeiro nível e representados ao usar elementos
``group`` dentro de elementos ``view`` e outros elementos ``group``.

Cada definição de grupo deve ter um atributo ``name`` informando um
identificador único. Será considerado um erro caso o arquivo de layout
tenha várias definições de grupos usando um atributo ``name`` idêntico.
O valor do atributo ``name`` é usado quando for justificar a
visualização de um grupo ou outro. Este é um exemplo da abertura da
etiqueta para definir o grupo de um elemento dentro do primeiro elemento
``mamelayout``:

.. code-block:: xml

    <group name="panel">

Este grupo pode então ser justificado em uma visualização ou em outro
elemento ``group`` usando um elemento de grupo como referência.
Opcionalmente os limites de destino, a orientação e as modificações
das cores poderão ser informados também.
O atributo ``ref`` identifica o grupo a qual faz referência, neste
exemplo são fornecidos os valores de limite:

.. code-block:: xml

    <group ref="panel"><bounds x="87" y="58" width="23" height="23.5" /></group>

Os elementos de definição dos grupos permitem que todos os elementos
filhos que forem iguais, sejam exibidos. O posicionamento e as
orientações das tela, elementos de layout e arranjo desses grupos
funcionem da mesma maneira que as visualizações.
Veja :ref:`layout-parts-views` para mais informações.
Um grupo pode justificar outros grupos, porém loops recursivos não são
permitidos. Será considerado um erro caso um grupo represente a si
mesmo de forma direta ou indireta.

Os grupos possuem seus próprios sistemas de coordenadas internas.
Caso um elemento de definição de grupo não tenha um elemento limitador
``bounds`` como filho direto, os seus limites serão computados junto com
a união dos limites de todas as telas, elementos de layout ou grupos
relacionados.
Um elemento filho ``bounds`` pode ser usado para definir
explicitamente grupos limitadores
(consulte :ref:`layout-concepts-coordinates` para mais informações).
Observe que os limites dos grupos são usados com a única justificativa
para calcular as coordenadas de transformação quando forem relacionados
a um grupo. Um grupo pode posicionar as telas ou os elementos fora dos
seus limites sem que sejam cortados.

.. raw:: latex

	\clearpage

Para demonstrar como o cálculo dos limites funcionam, considere este
exemplo:

.. code-block:: xml

    <group name="autobounds">
        <!-- limites automaticamente calculados com sua origem em (5,10), largura 30, e altura 15 -->
        <element ref="topleft"><bounds x="5" y="10" width="10" height="10" /></element>
        <element ref="bottomright"><bounds x="25" y="15" width="10" height="10" /></element>
    <view name="Teste">
        <!--
           Os grupos limitadores são traduzidos e escalonados para preencher 2/3 da escala
           horizontal e o dobro verticalmente.
           O elemento superior esquerdo posicionado em  (0,0) com 6.67 de largura e 20 de altura
           O elemento inferior direito posicionado em (13.33,10) com 6.67 de largura e 20 de altura
           Os elementos de visualização calculado com origem em (0,0) 20 de largura e 30 de altura
        -->
        <element ref="topleft"><bounds x="5" y="10" width="10" height="10" /></element>
        <element ref="bottomright"><bounds x="25" y="15" width="10" height="10" /></element>
    </view>

Como todos os elementos inerentemente caem dentro dos limites calculados
ao grupo de forma automática. Agora, considere o que acontece caso a
posição dos elementos de um grupo estejam fora dos seus limites:

.. code-block:: xml

    <group name="periphery">
        <!-- os limites dos elementos estão acima da quina superior e à direita da quina direita -->
        <bounds x="10" y="10" width="20" height="25" />
        <element ref="topleft"><bounds x="10" y="0" width="10" height="10" /></element>
        <element ref="bottomright"><bounds x="30" y="20" width="10" height="10" /></element>
    <view name="Test">
        <!--
           Os grupos limitadores são traduzidos e escalonados para preencher 2/3 da escala
           horizontal unido verticalmente.
           O elemento superior esquerdo posicionado em (5,-5) com 15 de largura e 10 de altura
           O elemento inferior direito posicionado em (35,15) com 15 de largura e 10 de altura
           Os elementos de visualização calculado com origem em (5,-5) 45 de largura e 30 de altura
        -->
        <group ref="periphery"><bounds x="5" y="5" width="30" height="25" /></group>
    </view>

Os elementos de grupo são traduzidos e escalonados conforme sejam
necessários para distorcer os limites internos dos grupos para o limite
de visualização final. O conteúdo dos grupos não ficam restritos aos
seus limites. A visualização considera os limites dos elementos atuais
ao calcular os seus próprios limites e não aos limites do destino
definido para o grupo.

Quando um grupo é instanciado [#INSTANCIA]_, ele cria um escopo agrupado
do parâmetro.
A lógica do escopo principal é o escopo do parâmetro de visualização,
do grupo ou do bloco de repetição onde o grupo for instanciado (*não* é
um parente léxico ao elemento de primeiro nível ``mamelayout``).
Qualquer elemento ``param`` dentro da definição do conjunto, estabelece
os parâmetros dos elementos no escopo local para o grupo instanciado.
Os parâmetros locais não se preservam através das várias instancias.

Consulte :ref:`layout-concepts-params` para obter mais informações sobre
os parâmetros. (Observe que o nome dos grupos não fazem parte do seu
conteúdo e qualquer referência de parâmetro no próprio atributo ``name``
será substituído no ponto onde a definição do grupo aparecer no primeiro
nível do elemento de escopo ``mamelayout``.)

.. raw:: latex

	\clearpage

.. _layout-parts-repeats:

Repetindo os blocos
~~~~~~~~~~~~~~~~~~~

A repetição dos blocos fornecem uma maneira concisa de gerar ou para
organizar uma grande quantidade de elementos iguais. A repetição dos
blocos são geralmente usados em conjunto com o gerador de parâmetros
(consulte :ref:`layout-concepts-params`).
A repetição dos blocos podem ser agrupados para criar arranjos mais
complexos.

Os blocos repetidos são criados através do elemento ``repeat``.
Cada elemento ``repeat`` requer um atributo ``count`` definindo uma
quantidade de iterações que serão geradas.
O atributo ``count`` deve ser um número inteiro e positivo. A repetição
dos blocos é permitida dentro do elemento de primeiro nível
``mamelayout``, dentro dos elementos ``group`` e ``view`` assim como
dentro dos outros elementos ``repeat``. O exato sub-elemento permitido
dentro do elemento ``repeat`` depende de onde ele for aparecer:

* Um bloco repetido dentro do elemento de primeiro nível ``mamelayout``
  podem conter os seguintes elementos
  ``param``, ``element``, ``group`` (definição) e ``repeat``.
* Um bloco repetido dentro de um elemento ``group`` ou ``view`` podem
  conter os seguintes elementos, ``param``, ``element`` (referência),
  ``screen``, ``group`` (referência) e ``repeat``.

Um bloco de repetição repete o seu conteúdo diversas vezes dependendo do
valor definido no atributo ``count``. Consulte as seções relevantes para
obter mais informações de como os sub-elementos são usados
(:ref:`layout-parts`, :ref:`layout-parts-groups`
e :ref:`layout-parts-views`). Um bloco que se repete cria um escopo de
parâmetros agrupados dentro do escopo do parâmetro do seu elemento
léxico principal (DOM).

O exemplo abaixo geram rótulos numéricos em branco a partir do zero até
o onze com o nome ``label_0``, ``label_1`` e assim por diante (dentro do
elemento de primeiro nível ``mamelayout``):

.. code-block:: xml

    <repeat count="12">
        <param name="labelnum" start="0" increment="1" />
        <element name="label_~labelnum~">
        <text string="~labelnum~"><color red="1.0" green="1.0" blue="1.0" /></text>
        </element>
    </repeat>

Uma fileira horizontal com 40 mostradores digitais, separadas por cinco
unidades de espaço entre elas, controladas pelas saídas ``digit0`` até
``digit39`` (dentro de um elemento ``group`` ou ``view``):

.. code-block:: xml

    <repeat count="40">
        <param name="i" start="0" increment="1" />
        <param name="x" start="5" increment="30" />
        <element name="digit~i~" ref="digit">
        <bounds x="~x~" y="5" width="25" height="50" />
        </element>
    </repeat>

.. raw:: latex

	\clearpage

Oito mostradores com matrix de ponto medindo cinco por sete em uma
linha, com pixels controlados por ``Dot_000`` até ``Dot_764``
(dentro de um elemento ``group`` ou ``view``):

.. code-block:: xml

    <!-- 8 dígitos -->
    <repeat count="8">
        <param name="digitno" start="1" increment="1" />
        <!-- a distância entre os dígitos ((111 * 5) + 380) -->
        <param name="digitx" start="0" increment="935" />
          <!-- 7 linhas para cada dígito -->
          <repeat count="7">
        <param name="rowno" start="1" increment="1" />
        <!-- a distância vertical entre os LEDs -->
        <param name="rowy" start="0" increment="114" />
          <!-- 5 colunas em cada dígito -->
          <repeat count="5">
        <param name="colno" start="1" increment="1" />
        <!-- a distância horizontal entre os LEDs -->
        <param name="colx" start="~digitx~" increment="111" />
          <element name="Dot_~digitno~~rowno~~colno~" ref="Pixel" state="0">
          <!-- o tamanho de cada LED -->
          <bounds x="~colx~" y="~rowy~" width="100" height="100" />
             </element>
           </repeat>
        </repeat>
    </repeat>

Dois teclados que podem ser clicados, separados horizontalmente por um
teclado numérico quatro por quatro (dentro de um elemento ``group`` ou
``view``):

.. code-block:: xml

    <repeat count="2">
        <param name="group" start="0" increment="4" />
        <param name="padx" start="10" increment="530" />
        <param name="mask" start="0x01" lshift="4" />
          <repeat count="4">
        <param name="row" start="0" increment="1" />
        <param name="y" start="100" increment="110" />
          <repeat count="4">
        <param name="col" start="~group~" increment="1" />
        <param name="btnx" start="~padx~" increment="110" />
        <param name="mask" start="~mask~" lshift="1" />
          <element ref="btn~row~~col~" inputtag="row~row~" inputmask="~mask~">
          <bounds x="~btnx~" y="~y~" width="80" height="80" />
             </element>
           </repeat>
        </repeat>
    </repeat>

.. raw:: latex

	\clearpage

Os botões são desenhados usando os elementos ``btn00`` na parte superior
esquerda, ``btn07`` na parte superior direita, ``btn30`` na parte
inferior esquerda e ``btn37`` na parte inferior direita contando entre
eles. As quatro colunas são conectadas às portas E/S ``row0``, ``row1``,
``row2``, and ``row3`` de cima para baixo.
As colunas consecutivas são conectadas aos bits das portas E/S começando
com o bit de menor importância do lado esquerdo.

Observe que o parâmetro ``mask`` no elemento mais interno ``repeat``
recebe o seu valor inicial a partir do parâmetro correspondentemente
nomeado no delimitador do escopo, porém sem alterá-lo.

Gerando um tabuleiro de xadrez com valores alfa alternados entre 0.4 e
0.2 (dentro de um elemento ``group`` ou ``view``):

.. code-block:: xml

    <repeat count="4">
        <param name="pairy" start="3" increment="20" />
        <param name="pairno" start="7" increment="-2" />
          <repeat count="2">
        <param name="rowy" start="~pairy~" increment="10" />
        <param name="rowno" start="~pairno~" increment="-1" />
        <param name="lalpha" start="0.4" increment="-0.2" />
        <param name="ralpha" start="0.2" increment="0.2" />
          <repeat count="4">
        <param name="lx" start="3" increment="20" />
        <param name="rx" start="13" increment="20" />
        <param name="lmask" start="0x01" lshift="2" />
        <param name="rmask" start="0x02" lshift="2" />
          <element ref="hl" inputtag="board:IN.~rowno~" inputmask="~lmask~">
          <bounds x="~lx~" y="~rowy~" width="10" height="10" />
          <color alpha="~lalpha~" />
          </element>
          <element ref="hl" inputtag="board:IN.~rowno~" inputmask="~rmask~">
          <bounds x="~rx~" y="~rowy~" width="10" height="10" />
          <color alpha="~ralpha~" />
             </element>
           </repeat>
        </repeat>
    </repeat>

O elemento ``repeat`` mais externo gera um grupo com duas colunas em
cada interação; o próximo elemento ``repeat`` gera uma coluna individual
em cada interação; o elemento ``repeat`` interno produz dois recortes
horizontais adjacentes em cada interação.
As colunas são conectadas às portas E/S através do ``board:IN.7``
no topo do ``board.IN.0`` na parte inferior.

.. raw:: latex

	\clearpage


.. _layout-interact:

Interatividade
--------------

As visualizações com interatividade são suportadas através da permissão
dos itens que serão vinculados nas saídas e nas portas E/S. Há suporte
para cinco tipos de interatividades:

**Itens Selecionáveis**

	Caso um item em uma visualização esteja vinculado com uma região dos
	interruptores da porta E/S, ao clicar no item o interruptor emulado
	será ativado.

**Componentes que dependam de uma condição**

	Dependendo do estado do elemento que o contiver, alguns componentes
	serão desenhados de forma diferente. Isso inclui a matriz de pontos,
	o display de LEDs com vários segmentos, os contadores simples e os
	elementos com mostradores rotativos. Consulte
	:ref:`layout-parts-elements` para obter mais detalhes.

**Componentes desenhados de forma condicional**

	Os componentes podem ser desenhados de forma condicional ou
	escondidos dependendo da condição do conteúdo do elemento a partir
	da informação dos valores para os elementos ``state`` e/ou
	``statemask``. Consulte :ref:`layout-parts-elements` para obter mais
	detalhes.

**Parâmetros para a animação dos componentes**

	A posição, tamanho e a cor dos componentes contido em seus elementos
	talvez possam ser animados de acordo com a condição do elemento a
	partir da informação dos diversos elementos ``color`` e/ou
	``bounds`` em conjunto com os atributos de condição ``state``.
	Consulte :ref:`layout-parts-elements` para obter mais detalhes.

**Parâmetros para a animação dos itens**

	A cor, a posição e o tamanho dos itens restritos ao seu espaço de
	visualização podem ser animados de acordo com a sua condição.

.. raw:: latex

	\clearpage


.. _layout-interact-clickable:

Itens que podem ser clicados
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caso um item de visualização (elemento ``element`` ou ``screen``) tenham
atributos ``inputtag`` e ``inputmask`` com valores que correspondam a
uma região com interruptores digitais no sistema emulado, será possível
clicar no elemento para que determinado interruptor seja ativado. O
interruptor permanecerá ativo enquanto o botão do mouse estiver
pressionado e o ponteiro estiver dentro dos limites do item.
(Observe que os limites podem mudar dependendo da condição do estado de
animação do item, consulte :ref:`layout-interact-itemanim`).

O atributo ``inputtag`` determina o caminho do identificador de uma
porta E/S relativa ao dispositivo responsável pelo carregamento do
arquivo de layout. O atributo ``inputmask`` deve ser um valor inteiro
definindo os bits da região da porta de E/S que o item deve ativar.
Este exemplo demonstra a instanciação dos botões que podem ser
clicados:

.. code-block:: xml

    <element ref="btn_3" inputtag="X2" inputmask="0x10">
        <bounds x="2.30" y="4.325" width="1.0" height="1.0" />
    </element>
    <element ref="btn_0" inputtag="X0" inputmask="0x20">
        <bounds x="0.725" y="5.375" width="1.0" height="1.0" />
    </element>
    <element ref="btn_rst" inputtag="RESET" inputmask="0x01">
        <bounds x="1.775" y="5.375" width="1.0" height="1.0" />
    </element>

Ao lidar com o retorno das informações vindas do mouse o MAME trata
todos os elementos de layout como sendo retangular e ativa apenas o
primeiro item que possa ser pressionado cuja região inclua a posição do
ponteiro do mouse.

.. raw:: latex

	\clearpage


.. _layout-interact-elemstate:

O Estado do elemento
~~~~~~~~~~~~~~~~~~~~

Um item de visualização que instancie um elemento (elemento ``element``)
pode fornecer um valor da sua condição para o elemento a partir de uma
porta emulada de E/S ou para a saída. Consulte
:ref:`layout-parts-elements` para obter mais detalhes sobre como o
estado de um elemento afeta sua aparência.

O valor do estado do elemento será obtido através do valor da saída
emulada que corresponda a tal nome caso o elemento ``element`` tenha um
atributo ``name``. Observe que os nomes das saídas são globais
e podem se tornar um problema quando uma máquina utilizar várias
instâncias do mesmo tipo do dispositivo. Este exemplo mostra como
os monitores digitais podem ser conectados na saída emulada:

.. code-block:: xml

    <element name="digit6" ref="digit"><bounds x="16" y="16" width="48" height="80" /></element>
    <element name="digit5" ref="digit"><bounds x="64" y="16" width="48" height="80" /></element>
    <element name="digit4" ref="digit"><bounds x="112" y="16" width="48" height="80" /></element>
    <element name="digit3" ref="digit"><bounds x="160" y="16" width="48" height="80" /></element>
    <element name="digit2" ref="digit"><bounds x="208" y="16" width="48" height="80" /></element>
    <element name="digit1" ref="digit"><bounds x="256" y="16" width="48" height="80" /></element>

O valor do estado do elemento será obtido a partir do valor da porta
correspondente ao E/S mascarado com o valor do ``inputmask`` caso o
elemento ``element`` tenha os atributos ``inputtag`` e ``inputmask``
porém não tenha um atributo ``name``. O atributo ``inputtag``
determina o caminho do identificador de uma porta E/S relativa ao
dispositivo responsável pelo carregamento do arquivo de layout. O
atributo ``inputmask`` deve ser um valor inteiro para definir os bits da
região da porta E/S que o item deve ativar.

O valor da porta E/S é mascarado com o valor do ``inputmask`` e feito
uma operação XOR [#XOR]_ com o valor predefinido da região da porta E/S
caso o elemento ``element`` não tenha qualquer atributo ``inputraw`` ou
caso o valor do atributo ``inputraw`` seja **no**. Em geral é utilizado
para fornecer um retorno visual para os botões que sejam clicáveis como
valores normais para os interruptores alto-ativo e baixo-ativo.

O estado do elemento será obtido a partir dos valores da porta E/S
mascarado com o valor do ``inputmask`` e deslocada para a direita
para remover os zeros restantes caso o elemento ``element`` tenha um
atributo ``inputraw`` com o valor **yes** (por exemplo, uma máscara com
o valor **0x5** não terá deslocamento algum enquanto uma máscara com o
valor **0xb0** resultará num deslocamento com quatro bits à direita).
É útil para obter os valores analógicos das entradas ou das posições.

.. raw:: latex

	\clearpage


.. _layout-interact-itemanim:

A visualização de um item animado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A cor, a posição e o tamanho dos itens que estejam dentro dos limites da
visualização poderão ser animados. Isso é feito através da definição dos
diversos sub-elementos ``color`` ou ``bounds`` com atributos ``state``.
O atributo ``state`` deve ser um número inteiro positivo para cada
elemento ``color`` ou sub-elemento ``bounds``. Dentro do item de
visualização os dois elementos ``color`` e os dois elementos ``bounds``
não podem ter os mesmos atributos ``state`` com os mesmos valores.

Para definir a posição ou o tamanho do item através do sub-elemento
``bounds`` será usado o menor valor do atributo ``state`` caso o estado
de animação do item seja menor que o valor do atributo ``state`` de
qualquer um dos sub-elementos ``bounds``. Já a posição ou o tamanho
definido pelo sub-elemento ``bounds`` será utilizado com o maior valor
do atributo ``state`` caso o estado da animação do item seja maior que o
valor do atributo ``state`` de qualquer um dos sub-elementos ``bounds``.
No entanto a posição ou o tamanho será interpolada de forma linear caso
o estado da animação do item esteja entre os valores do atributo
``state`` dos dois sub-elementos ``bounds``.

A cor será atribuída através do sub-elemento ``color`` com o menor valor
do atributo ``state`` caso o estado de animação do item seja menor do
que o valor do atributo ``state`` de qualquer sub-elemento ``color``.
O mesmo princípio é usado com o maior valor do atributo ``state``.
Os componentes da cor RGBA serão interpolados de forma linear caso o
estado da animação do item esteja entre os valores do atributo ``state``
dos dois sub-elementos ``color``.

O estado da animação de um item pode estar limitada a uma saída emulada
ou a entrada de uma porta durante o fornecimento de um sub-elemento
``animate``. Quando estiver presente o elemento ``animate`` deve possuir
ou um atributo ``inputtag`` ou um atributo ``name`` (porém não ambos).
Na ausência do sub-elemento ``animate`` o estado de animação do item
será idêntico ao estado do seu elemento (consulte
:ref:`layout-interact-elemstate`).

Quando um sub-elemento ``animate`` estiver presente e tiver um atributo
``inputtag``, o estado da animação do item será obtido a partir do valor
correspondente à porta E/S. O atributo ``inputtag`` determina o caminho
da etiqueta de uma porta E/S relativa ao dispositivo que provoque a
leitura do arquivo de layout. São utilizados os valores brutos da porta
da entrada, os valores baixo-ativo do interruptor não são normalizados.

Na presença de um sub-elemento ``animate`` com o atributo ``name`` o
estado da animação do item será obtido através do valor do nome
correspondente a saída emulada. Observe que os nomes das saídas são
globais e podem se tornar um problema quando uma máquina utilizar várias
instâncias do mesmo tipo do dispositivo.

O estado da animação será mascarado com o valor ``mask`` e deslocada
para a direita para remover os zeros restantes caso um sub-elemento
``animate`` tenha um atributo ``mask`` (por exemplo, uma máscara com o
valor **0x5** não terá deslocamento algum enquanto uma máscara com o
valor **0xb0** resultará num deslocamento com quatro bits à direita).
Observe que o atributo ``mask`` aplica o valor da saída (determinado
através do atributo ``inputtag``). Na presença do atributo ``mask`` o
seu valor deve ser inteiro, na ausência, é equivalente a todas as
definições com 32 bits.

.. raw:: latex

	\clearpage

Este exemplo exibe elementos com estado independente para o elemento e
para a animação obtendo o estado da animação a partir das saídas
emuladas para controlar a sua posição:

.. code-block:: xml

    <repeat count="5">
        <param name="x" start="10" increment="9" />
        <param name="i" start="0" increment="1" />
        <param name="mask" start="0x01" lshift="1" />

        <element name="cg_sol~i~" ref="cosmo">
            <animate name="cg_count~i~" />
            <bounds state="0" x="~x~" y="10" width="6" height="7" />
            <bounds state="255" x="~x~" y="48.5" width="6" height="7" />
        </element>

        <element ref="nothing" inputtag="FAKE1" inputmask="~mask~">
            <animate name="cg_count~i~" />
            <bounds state="0" x="~x~" y="10" width="6" height="7" />
            <bounds state="255" x="~x~" y="48.5" width="6" height="7" />
        </element>
    </repeat>

Assim como no exemplo anterior porém agora usa o estado da emulação a
partir da posição emulada da entrada para controlar as suas posições:

.. code-block:: xml

        <repeat count="4">
            <param name="y" start="1" increment="3" />
            <param name="n" start="0" increment="1" />
            <element ref="ledr" name="~n~.7">
                <animate inputtag="IN.1" mask="0x0f" />
                <bounds state="0" x="0" y="~y~" width="1" height="1" />
                <bounds state="11" x="16.5" y="~y~" width="1" height="1" />
            </element>
        </repeat>

.. raw:: latex

	\clearpage


.. _layout-errors:

Lidando com erros
-----------------

* Para os arquivos internos de layout (fornecidos pelo desenvolvedor),
  os erros são detectados através script ``complay.py`` durante uma
  falha de compilação.
* O MAME irá parar de carregar um arquivo de layout caso encontre um
  erro de sintaxe, fazendo assim com que nenhuma visualização do
  layout fique disponível.
  Alguns exemplos de erros de sintaxe incluem referências para
  elementos ou grupos indefinidos, limites inválidos, cores inválidas,
  grupos recursivamente emaranhados e a redefinição do gerador dos
  parâmetros.
* O MAME exibirá uma mensagem de aviso e continuará caso uma
  visualização faça referência à uma tela inexistente durante o
  carregamento de um layout.
  Visualizações apontando para telas não existentes não são exibidas,
  elas são consideradas inviáveis e tão pouco estarão disponíveis para o
  usuário.


.. _layout-autogen:

As visualizações que são geradas automaticamente
------------------------------------------------

Após o carregamento interno dos layouts (fornecido pelo desenvolvedor) e
do layout externo (fornecido pelo usuário). As seguintes visualizações
são geradas automaticamente:

* Será exibido a mensagem "*No screens Attached to the system*" ou
  "*Sem telas anexadas ao sistema*" caso o sistema não possua telas e
  tão pouco sejam encontradas visualizações viáveis no sistema interno ou
  externo de layout.
* A tela será exibida com a sua proporção física e com a rotação
  aplicada em cada tela que for emulada.
* A tela será exibida em uma proporção onde os pixels sejam quadrados e
  com a rotação aplicada para cada tela emulada onde a proporção
  configurada para o pixel não corresponda a proporção física.
* Serão exibidos duas cópias da imagem da tela uma uma sobreposta a
  outra com um pequeno espaço entre elas caso o sistema emule apenas uma
  tela.
  A cópia da parte de cima será rotacionada em 180 graus. Esta visão
  pode ser usada em um cabine tipo cocktail, que disponibiliza uma mesa
  onde os jogadores se sentam frente a frente e cada um com a sua tela,
  ou alternando os jogos que não girem automaticamente a tela para o
  segundo jogador.
* As telas serão organizadas horizontalmente da esquerda para a direita
  e verticalmente de cima para baixo, ambos com e sem as pequenas
  lacunas entre elas caso o sistema tenha exatamente duas telas emuladas
  e nenhuma visualização no layout interno ou no layout externo exibindo
  todas as telas, ou caso o sistema tenha mais de duas telas emuladas.
* As telas serão exibidas em formato de grade em ambas as fileiras
  principais (da esquerda para a direita e de cima para baixo) e o pilar
  principal (de cima para baixo e depois da esquerda para a direita).
  As visualizações são geradas com e sem intervalos entre as telas.

.. raw:: latex

	\clearpage

.. _layout-complay:

Usando o complay.py
-------------------

No código fonte do MAME existe um script Python chamado **complay.py**,
encontrado no subdiretório **scripts/build**. Como parte do processo de
compilação do MAME esse script é usado para reduzir o tamanho dos dados
dos layouts internos e para convertê-los de maneira que possam ser
anexados dentro do executável.

O script pode também detectar muitos erros comuns de formatação
exibindo mensagens de erro com mais informações das que o MAME exibe.

Observe que o script não executa todo o mecanismo de layout e portanto
não tem a capacidade de detectar erros nos parâmetros usados como
referências para elementos indefinidos ou para agrupamentos dos grupos
organizados de forma recursiva.
O script **complay.py** é compatível com os interpretadores Python
a partir das versões 2.7, 3 ou mais recente, ele usa três parâmetros,
um nome do arquivo na entrada, um nome do arquivo na saída e um nome
base para as variáveis na saída: ::

	python scripts/build/complay.py <input> [<output> [<varname>]]

É obrigatório o uso de um arquivo na entrada. Caso nenhum nome de arquivo
seja usado na saída, o **complay.py** irá analisar e verificar apenas o
arquivo da entrada, informando quaisquer erros que forem encontrados e
não gerando qualquer tipo de arquivo na saída.
Caso nenhum ``varname`` seja fornecido, o **complay.py** irá
gerar um com base no nome do arquivo da entrada. Isso não garante a
geração de identificadores válidos.

O status gera os seguintes valores:

* **0** (zero) quando for concluído com êxito.
* **1** quando houver um erro durante a invocação através da linha de comando.
* **2** caso haja erro no arquivo de entrada.
* **3** caso seja um erro de E/S.

Ao definir um arquivo na saída este será criado ou substituído caso
seja concluído com sucesso ou removido no caso de falha.

Para aferir um arquivo de layout visando identificar a existência de
algum tipo de erro, execute o script apontando o caminho completo do
arquivo como mostra o exemplo abaixo: ::

	python scripts/build/complay.py artwork/dino/default.lay

.. [#]	Arquivos de disposição dos elementos na tela. (Nota do tradutor)
.. [#]	Em nosso idioma conhecido também como
		cerquilha, jogo da velha, sustenido e atualmente como
		**hashtag**. (Nota do tradutor)
.. [#]	*C locale* em Inglês. (Nota do tradutor)
.. [#]	O termo *shift* é muito amplo, também pode ser
		interpretado como desvio, mudança, turno, inversão, câmbio, etc.
		(Nota do tradutor)
.. [#]	Reels, `mostradores mecânicos
		<https://i.postimg.cc/FF2GYc9v/Reels.jpg>`_ usados nas máquinas
		caça niqueis. (Nota do tradutor)
.. [#]	`Aqui <https://www.youtube.com/watch?v=-rrP4Prx1rc>`_ um exemplo
		destes mostradores. (Nota do tradutor)
.. [#]	Alpha Blending
.. [#]	RGB multiplication
.. [#]	Additive blending
.. [#]	Toggle switches, também é conhecido como chave alavanca.
		(Nota do tradutor)
.. [#TAG]	Tag no Inglês.
.. [#INSTANCIA]	Em programação orientada a objetos, chama-se instância
		de uma classe, um objeto cujo comportamento e estado sejam
		definidos pela classe. (`Wikipedia
		<https://pt.wikipedia.org/wiki/Instância_(ciência_da_computação)>`_)
.. [#XOR]	Exclusive OR ou operador exclusivo, é um operando que sempre
		retorna 1 quando os bits da sua entrada são diferentes e
		O (zero) quando forem iguais.
