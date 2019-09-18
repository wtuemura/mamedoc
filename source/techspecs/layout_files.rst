Os arquivos de Layout
=====================

.. contents:: :local:


.. _layout-intro:

Introdução
----------

Os arquivos de layout [#]_ são usados para informar ao MAME o que exibir
enquanto um sistema emulado estiver rodando e como organizar estes
elementos na tela. O MAME pode renderizar as telas emuladas, imagens,
texto, formas e objetos especiais para dispositivos de saída comuns.
Os elementos podem ser estáticos, ou se atualizar de forma dinâmica para
refletir o estado das entradas e saídas.
Os layouts podem ser gerados automaticamente com base no número ou tipo
de tela emulada, construído e lincado internamente ao binário do MAME ou
disponibilizado externamente. Para o MAME os arquivos de layout são
interpretados como arquivos XML usando a extensão ``.lay``.


.. _layout-concepts:

Conceitos fundamentais
----------------------

.. _layout-concepts-numbers:

Números
~~~~~~~

Os layouts do MAME possuem dois tipos de números, inteiros e de ponto
flutuante.

Os números inteiros podem ser fornecidos em notação decimal ou
hexadecimal. Um número decimal inteiro consiste em um prefixo opcional
**#** (hash [#]_), um caractere opcional **+/-** (mais ou menos) e uma
sequência de dígitos entre **0-9**.

Um número hexadecimal consiste em que um dos prefixos
seja o **$** (cifrão) ou **0x** (zero xis) seguido por uma sequência de
números hexadecimais entre **0-9** e **A-F**. O índice e os dígitos dos
números hexadecimais não diferenciam entre as letras maiúsculas e
minúsculas.

Os números de ponto flutuante podem ser fornecidos em decimal de ponto
fixo ou com notação científica. Observe que os prefixos de número
inteiro e os valores hexadecimais *não* são aceitos onde um número de
ponto flutuante for esperado.

Para alguns atributos, ambos números inteiros e números de ponto
flutuante são permitidos. Nesses casos, a presença de um prefixo
**#** (hash), **$** (cifrão) ou **0x** (zero xis) faz com que o valor
seja interpretado como um número inteiro.
Caso nenhum prefixo de número inteiro, ponto decimal ou a letra E
(maiúsculo ou minusculo) seja encontrado para introduzir um expoente,
ele será interpretado como um número de ponto flutuante.
Caso nenhum prefixo de número inteiro, ponto decimal ou a letra E seja
encontrado, o número será interpretado como um número inteiro.

Os números são analisados usando uma acentuação de caracteres em C [#]_
por questões de portabilidade.


.. _layout-concepts-coordinates:

Coordenadas
~~~~~~~~~~~

As coordenadas de layout são representadas internamente através da norma
IEEE754 como um número binário de 32-bit de ponto flutuante (também
conhecido como "*precisão simples*"). O incremento das coordenadas
nas direções para a direita e para baixo. A origem (**0,0**) não tem um
significado em particular e valores negativos podem ser usados nos
layouts.
As coordenadas são fornecidas como números de ponto flutuante.

O MAME pressupõe que as coordenadas exibição tem a mesma proporção de
aspecto que o pixel de saída do dispositivo (janela ou nativa).
Considerando que sejam pixels quadrados e sem rotação, isso significa
que a distância seja igual nos eixos **X** e **Y** o que corresponde a
distâncias iguais na vertical e horizontal na saída que for renderizada.

Elementos, grupos e exibições, todos têm os seus sistemas internos
de coordenadas. Quando um elemento ou grupo é referenciado a partir de
uma visão ou um outro grupo, as suas coordenadas são dimensionadas
conforme necessário para ajustar os limites definidos.

Os objetos são posicionados e dimensionados usando os elementos limite
``bounds``.
Os elementos limite podem definir a posição da parte do canto superior
esquerdo e usando o atributo de tamanho ``x``, ``y``, largura ``width``
e altura ``height`` ou pode definir as coordenadas dos cantos com os
atributos esquerda ``left``, cima ``top``, direita ``right`` e baixo
``bottom``. Estes dois elementos ``bounds`` são equivalentes: ::

    <bounds x="455" y="120" width="11" height="7" />
    <bounds left="455" top="120" right="466" bottom="127" />

Ambos os atributos ``x`` ou ``left`` devem estar presente para se
distinguir entre os dois elementos. O ``width`` e ``height`` ou
``right`` e ``bottom`` o valor 1.0 é predefinido caso um valor não seja
informado.
Será considerado um erro caso os valores de ``width`` ou ``height``
sejam negativos, caso ``right`` sejam menor que ``left`` ou se
``bottom`` seja menor que ``top``.


.. _layout-concepts-colours:

Cores
~~~~~

As cores são definidas no espaço RGBA. O MAME não tem conhecimento
do leque de perfis de gamma e cores, assim as cores normalmente serão
interpretadas como sRGB junto com a definição de gamma do seu
sistema com o valor de **2.2** geralmente. Os valores dos canais são
definidos como números de ponto flutuante. Os valores dos canais
vermelho, verde e azul variam entre **0.0** (desligado) até **1.0**
(intensidade plena).
Os valores alfa variam entre **0.0** (plena transparência) até **1.0**
(opaco). Os valores dos canais de cores não são previamente
multiplicados pelo valor alfa.

O componente e a cor do item de exibição são especificados usando os
elementos ``color``.
Os atributos relevantes são vermelho ``red``, verde ``green``,
azul ``blue`` e ``alpha``. Este exemplo de elemento ``color`` determina
todos os valores dos canais:

.. code-block:: xml

    <color red="0.85" green="0.4" blue="0.3" alpha="1.0" />

Qualquer atributo de canal que for omitido o seu valor se torna 1.0,
valor já predefinido (intensidade plena ou opaco). Será considerado um
erro caso os valores do canal estejam fora do intervalo entre de **0.0**
até **1.0** (inclusive).


.. _layout-concepts-params:

Parâmetros
~~~~~~~~~~

Os parâmetros são variáveis nomeadas que podem ser usadas na maioria
dos atributos. Para usar um parâmetro em um atributo, cerque seu nome
com caracteres til *(~)*.
Caso um parâmetro não seja definido, nenhuma substituição será feita.
Aqui um exemplo mostrando os dois casos do parâmetro, use os valores dos
parâmetros de ``digitno`` e ``x`` que serão substituídos por
``~digitno~`` e ``~x~``:

.. code-block:: xml

    <element name="digit~digitno~" ref="digit">
        <bounds x="~x~" y="80" width="25" height="40" />
    </element>

Um nome para o parâmetro é uma sequência de letras maiúsculas das letras
**A-Z**, das letras minusculas **a-z**, dígitos decimais **0-9**, ou
caracteres subtraço (_).
Os nomes dos parâmetros levam em consideração as letras maiúsculas e
minúsculas. Quando a procura de um parâmetro, o motor do layout começa
no escopo atual trabalhando de dentro para fora. O nível do escopo mais periférico,
corresponde ao elemento de primeiro nível ``mamelayout``. Cada elemento
``repeat``, ``group`` ou ``view`` cria um novo nível de escopo.

Internamente, um parâmetro pode conter uma carreira de caracteres,
números inteiros ou números de ponto flutuante, porém essa é mais
transparente.
Os números inteiros são armazenados como *64-bit signed* com dois valores
complementares, os números de ponto flutuante são armazenados como
binários *IEEE754 64-bit*, estes números de ponto flutuante também são
conhecido como "precisão dupla". Os números inteiros são substituídos em
notação decimal e números de ponto flutuante são substituídos em seu
formato padrão que pode ser decimal de ponto fixo ou notação científica
dependendo do valor. Não há nenhuma maneira de sobrescrever a formatação
padrão dos parâmetros de um número inteiro ou de ponto flutuante.

Existem dois tipos de parâmetros: *value parameters* and *generator
parameters*. O parâmetro "value parameters" mantém o seu valor atribuído
até que seja reatribuído.
O parâmetro "*generator parameters*" tem um valor inicial, um incremento
e/ou uma transferência [#]_ aplicada para cada interação.

Os valores dos parâmetros são atribuídos usando um elemento ``param``
junto com elementos ``name`` e ``value``. Os valores do parâmetro podem
aparecer de dentro de um elemento de primeiro nível ``mamelayout`` e
dentro dos elementos ``repeat``, ``view`` assim como dentro da definição
dos elementos ``group`` (isso é, elementos ``group`` dentro do nível
superior do elemento ``mamelayout``, ao contrário dos elementos
``group`` dentro de elementos ``view`` definidos por outros elementos
``group``.
O valor do parâmetro pode ser reatribuído a qualquer momento.

Aqui está um exemplo atribuindo o valor "4" para o parâmetro
"firstdigit":

.. code-block:: xml

    <param name="firstdigit" value="4" />

Os geradores de parâmetros são atribuídos usando o elemento
``param`` com os atributos ``name``, ``start``, ``increment``,
``lshift`` e ``rshift``.
Os geradores de parâmetros só podem aparecer de dentro de elementos
``repeat`` (veja :ref:`layout-parts-repeats` para mais informações).
Os geradores de parâmetros não deve ser reatribuídos no mesmo escopo
(um nome de parâmetro idêntico pode ser definido em um escopo filho.
Aqui alguns exemplos dos geradores de parâmetros:

.. code-block:: xml

    <param name="nybble" start="3" increment="-1" />
    <param name="switchpos" start="74" increment="156" />
    <param name="mask" start="0x0800" rshift="4" />

* O parâmetro ``nybble`` geram os valores 3, 2, 1...
* O parâmetro ``switchpos`` geram os valores 74, 230, 386...
* O parâmetro ``mask`` geram os valores 2048, 128, 8...

O atributo ``increment`` deve ser um número inteiro ou de ponto
flutuante a ser adicionado ao valor do parâmetro. Os atributos
``lshift`` e ``rshift`` devem ser números positivos inteiros definindo a
quantidade de bits que serão transferidos no valor dos parâmetros para a
esquerda e direita. A transferência e o incremento são aplicados no
final do bloco de repetição antes que a próxima iteração comece.
Se ambos os incrementos e a transferências forem fornecidas o valor
do incremento é aplicado antes do valor da transferência.

Caso o atributo ``incremento`` esteja presente e for um número de
ponto flutuante, o valor do parâmetro será interpretado como um número
inteiro ou de ponto flutuante e depois convertido para um número de
ponto flutuante antes que o incremento seja adicionado. Caso o atributo
``increment`` esteja presente e for um número de ponto flutuante, o
valor do parâmetro será interpretado como um valor de número inteiro ou
de ponto flutuante antes que o valor incremental seja adicionado.
O valor do incremento será convertido em um número de ponto flutuante
antes da adição caso o valor seja um número de ponto flutuante.

Caso os atributos ``lshift`` ou ``rshift`` estejam presentes e não
forem iguais, o valor do parâmetro será interpretado como um número
inteiro ou de ponto flutuante convertido em um número inteiro conforme
seja necessário e transferido de acordo. A transferência para a esquerda
é definida como uma transferência feita para o bit mais importante.
Caso ambos os parâmetros ``lshift`` e ``rshift`` sejam fornecidos, estes
serão compensados antes dos valores serem aplicados. Isto significa que
você não pode, por exemplo, usar atributos iguais tanto para
`` lshift`` como para ``rshift`` visando limpar os bits em um valor de
parâmetro extremo após a primeira interação.

Será considerado um erro caso o elemento ``param`` não esteja em
qualquer um dos atributos ``value`` ou ``start``, será também
considerado um erro caso ambos os elementos ``param`` tiverem  os mesmos
atributos ``value`` ou qualquer um dos mesmos atributos ``start``,
``increment``, ``lshift``, ou ``rshift``.

Um elemento ``param`` define ou reatribui o seu valor em um parâmetro no
escopo atual mais interno. Não é possível definir ou reatribuir os
parâmetros em um escopo de contenção.

.. _layout-concepts-predef-params:

Parâmetros predefinidos
~~~~~~~~~~~~~~~~~~~~~~~

Uma certa quantidade de valores predefinidos nos parâmetros já estão
disponíveis e fornecem informações sobre a máquina em execução:

**devicetag**

	Um exemplo do caminho completo da tag do dispositivo que será
	responsável pela leitura do layout, seria ``:`` para o driver do
	controlador do dispositivo raiz ou ``:tty:ie15`` para o terminal
	conectado em uma porta. Este parâmetro é uma sequência de caracteres
	definida no escopo global de visualização do layout.

**devicebasetag**

	A base da tag do dispositivo que será responsável pela leitura do
	layout, como por exemplo ``root`` para o driver do dispositivo raiz
	ou ``ie15`` para o terminal que estiver conectado em uma porta.
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

	A parte horizontal da relação de aspecto do pixel visível na área da
	primeira tela (caso esteja presente). A relação de aspecto
	do pixel é fornecida como uma fração impropriamente reduzida.
	Observe que este é o componente horizontal aplicado *antes* da
	rotação. Este parâmetro é um número inteiro definido no escopo
	global do layout.

**scr0nativeyaspect**

	A parte vertical da relação de aspecto do pixel visível na área da
	primeira tela (caso esteja presente). A relação de aspecto do pixel
	é fornecida como uma fração impropriamente reduzida. Observe que
	este é o componente vertical aplicado *antes* da rotação. Este
	parâmetro é um número inteiro definido no escopo global do layout.

.. raw:: latex

	\clearpage

**scr0width**

	A largura da área visível da primeira tela (se houver) nos pixels
	emulados. Observe que a largura é aplicada *antes* da rotação.
	Este parâmetro é um número inteiro definido no escopo global do
	layout.

**scr0height**

	A altura da área visível da primeira tela (se houver) nos pixels
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

	A parte horizontal da relação de aspecto do pixel visível na área da
	segunda tela (caso esteja presente). Este parâmetro é um número
	inteiro definido no escopo global de visualização do layout.

**scr1nativeyaspect**

	A parte vertical da relação de aspecto do pixel visível na área da
	segunda tela (caso esteja presente). Este parâmetro é um número inteiro
	definido no escopo global de visualização do layout.

**scr1width**

	A largura da área visível da segunda tela (se houver) nos pixels
	emulados. Este parâmetro é um número inteiro definido no escopo
	global do layout.

**scr1height**

	A altura da área visível da segunda tela (se houver) nos pixels
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

	A largura da área visível da tela (base-zero) *N*\ th (se presente)
	nos pixels emulados. Este parâmetro é um número inteiro definido no
	escopo de visualização do layout.

**scr\ *N*\ height**

	A largura da área visível da tela (base-zero) *N*\ th (se presente)
	nos pixels emulados. Este parâmetro é um número inteiro definido no
	escopo de visualização do layout.

**viewname**

	O nome da exibição atual. Este parâmetro é uma sequências de
	caracteres definido no escopo de visualização.
	Não é definido fora do campo de visão.


Para parâmetros relacionados à tela, elas são numeradas do zero na
ordem em que aparecem na configuração da máquina. Todas as telas estão
inclusas (não apenas nos sub-dispositivos do dispositivo que fizeram com
que o layout fosse carregado). **X/width** e **Y/height** referem-se as
dimensões horizontal e vertical da tela *antes* da rotação ser aplicada.
Os valores baseados na área visível são calculados no final da
configuração. Caso o sistema não reconfigure a tela durante a execução
os valores dos parâmetros não serão atualizados assim como os layouts
não serão recalculados.

.. _layout-parts:

As partes de um layout
----------------------

Uma visualização define a disposição de um objeto gráfico a ser exibido.
O arquivo de layout do MAME pode conter diversas exibições. As
exibições são construídas a partir de elementos *elements* e telas
*screens*. Para simplificar os layouts complexos, os blocos repetidos e
os grupos reutilizáveis são compatíveis entre si.

O elemento de primeiro nível de um arquivo de layout do MAME deve ser um
elemento``mamelayout`` junto com um atributo ``version``. O atributo
``version`` deve ser um valor inteiro. Atualmente, o MAME suporta apenas
a versão 2 e não carregará qualquer outra versão diferente.
Este é um exemplo de uma tag inicial para um elemento ``mamelayout``::

    <mamelayout version="2">

Em geral, os filhos de primeiro nível do elemento ``mamelayout`` são
processados em ordem de chegada de cima para baixo. Uma exceção é que
por questões históricas, as exibições são processadas por último.
Isso significa que as exibições veem os valores finais de todos os
parâmetros do final do elemento ``mamelayout`` e pode se referir a
elementos e grupos que possam aparecer depois deles.

Os seguintes elementos são permitidos dentro do elemento de primeiro
nível ``mamelayout``:

**param**

    Define ou reatribui um valor para um parâmetro. Veja
    :ref:`layout-concepts-params` para mais informações.

.. raw:: latex

	\clearpage

**element**

    Define um elemento, um dos objetos básicos que podem ser organizados
    em uma Visualização. Veja :ref:`layout-parts-elements` para mais
    informações.

**group**

    Define um grupo de elementos ou telas que possam ser reutilizáveis e
    que também possam ser usados como referência em uma visualização
    ou em outros grupos.

    Veja :ref:`layout-parts-groups` para mais informações.

**repeat**

    Um grupo repetido de elementos que podem conter os elementos
    ``param``, ``element``, ``group`` e ``repeat``.
    Veja :ref:`layout-parts-repeats` para mais informações.

**view**

    Um arranjo de elementos ou de telas que podem ser exibidos em um
    dispositivo de saída (uma janela ou tela do host).
    Veja :ref:`layout-parts-views` para mais informações.

**script**

    Permite que scripts lua sejam usados para um layout aprimorado de
    interação.


.. _layout-parts-elements:

Elementos
~~~~~~~~~

Os elementos são um dos objetos visuais mais básicos que podem ser
organizados junto com as telas para compor uma visualização. Os
elementos podem ser construídos com um ou mais componentes *components*
porém um elemento é tratado como uma única superfície ao compor o
gráfico da cena e sua renderização. Um elemento pode ser usado em
diversas exibições e pode também ser usado diversas vezes dentro de
uma exibição.

A aparência de um elemento depende do seu estado *state*. O estado é um
valor inteiro que geralmente vem de uma área da porta I/O ou de uma
saída emulada (veja a discussão em :ref:`layout-parts-views` para
mais informações de como conectar um elemento a uma porta ou saída I/O).
Qualquer componente de um elemento pode ser restrito apenas ao desenho
quando o estado do elemento tiver um valor específico. Alguns
componentes (como mostradores de segmento múltiplo e mostradores
rotativos [#]_) que usam diretamente o estado para determinar a sua
aparência final.

Cada elemento possui o seu próprio sistema interno de coordenadas. Os
limites dos elementos dos sistema de coordenadas são computados de
maneira que cada parte individual dos componentes sejam unidos.

Todo elemento deve definir o seu nome usando o atributo ``name``. Os
elementos são consultados pelo nome quando são consultados em grupos ou
exibições. Será considerado um erro caso o arquivo de layout
contenha vários elementos com atributos ``name`` idênticos.
Os elementos podem, opcionalmente, fornecer um valor de estado padrão
com um atributo ``defstate`` para ser usado casp não esteja conectado em
uma saída emulada ou porta I/O. Se presente, o atributo ``defstate``
deve possuir um valor inteiro não negativo.

.. raw:: latex

	\clearpage

Os elementos filho do elemento ``element`` representam os componentes
que são desenhados em ordem de leitura do primeiro ao último
(componentes desenhados em cima de componentes que vierem antes deles).
Suporte a todos os componentes com alguns recursos em comum:

* Cada componente pode ter um atributo ``state``. Se presente, o
  componente só será desenhado quando o estado do elemento corresponder
  ao seu valor (se ausente, o componente sempre será desenhado).
  Se presente, o atributo ``state`` deve ser um valor inteiro não
  negativo.
* Cada componente pode ter um elemento filho ``bounds`` definindo a
  sua posição e tamanho (veja :ref:`layout-concepts-coordinates`). Caso
  tal elemento não esteja presente, os limites serão predefinidos a uma
  unidade quadrada, com o valor **1.0** para a largura e a altura e
  **0.0** para o canto superior esquerdo.
* Cada componente de cor pode ter um elemento filho ``color`` definindo
  uma cor RGBA (Veja :ref:`layout-concepts-colours` para mais
  informações).
  Isso pode ser usado para controlar a geometria da cor dos componentes,
  desenhados de forma algorítmica ou textual, sendo ignorado pelos
  componentes ``image``. Caso tal elemento não esteja presente,
  será usada uma cor predefinida que é branca e opaca.

Há suporte para os seguintes componentes:

**rect**

	Desenha um retângulo colorido uniforme preenchendo as suas bordas.

**disk**

	Desenha uma elipse colorida uniforme ajustada às suas bordas.

**image**

	Desenha uma imagem carregada de um arquivo PNG ou JPEG. O nome do
	arquivo a ser carregado (incluindo o nome da extensão do arquivo) é
	informado usando o atributo ``file``. Adicionalmente, um atributo
	opcional ``alphafile`` pode ser usado para determinar o nome de um
	arquivo PNG (incluindo o nome da extensão do arquivo) para ser
	carregado dentro do canal alfa da imagem. O(s) arquivo(s) de
	imagem(s) devem ser colocados no mesmo diretório que o arquivo de
	layout. Caso o atributo ``alphafile`` esteja relacionado a um
	arquivo, ele deve ter as mesmas dimensões que o arquivo definido no
	atributo ``file`` e a sua profundidade de bits por pixel não deve
	ser maior que 8 bits por canal. A intensidade de brightness dessa
	imagem, é copiada para o canal alfa, com intensidade plena
	(branco em escala de cinza) o que corresponde a um opaco
	pleno e o preto a uma transparência plena.

**text**

	Desenha o texto usando a fonte da interface e na cor definida pelo
	usuário. O texto a ser desenhado deve ser informado usado um
	atributo ``string``.  Um atributo ``align`` pode ser usado para
	definir o alinhamento do texto. Se presente, o atributo ``align``
	deve ser um valor inteiro onde (zero) significa centralizado, 1 (um)
	significa alinhado à esquerda e 2 (dois) significa alinhado à direita.
	Caso o atributo ``align`` esteja ausente a predefinição determina
	que o texto seja centralizado.

**dotmatrix**

	Desenha um segmento horizontal de oito pixels em um mostrador em
	formato de matriz de pontos, usando pixels circulares em uma cor
	determinada. Os bits que determinam o estado do elemento definem
	quais os pixels que estarão acesos, com o bit de menor importância
	correspondendo ao pixel mais à esquerda. Os pixels apagados são
	desenhados com uma menor intensidade (**0x20/0xff**).

**dotmatrix5dot**

	Desenha um segmento horizontal de cinco pixels em um mostrador em
	formato de matriz de pontos, usando pixels circulares em uma cor
	determinada. Os bits que determinam o estado do elemento definem
	quais os pixels que estarão acesos, com o bit de menor importância
	correspondendo ao pixel mais à esquerda. Os pixels apagados são
	desenhados com uma menor intensidade (**0x20/0xff**).

**dotmatrixdot**

	Desenha um único elemento de um mostrador em formato de de matriz de
	pontos com pixels circulares em uma cor determinada. O bit de menor
	importância do estado do elemento determina se o pixel vai estar
	aceso. Um pixel apagado é desenhado com uma menor intensidade
	(**0x20/0xff**).

**led7seg**

	Desenha um mostrador LED ou fluorescente alfanumérico comum com
	dezesseis segmentos e o mostrador em uma cor determinada. Os oito bits
	baixos do estado do elemento controlam quais os segmentos estarão
	acesos. Começando pelo bit de menor importância a sequência de
	atualização dos bits correspondentes começam no segmento superior,
	superior direito, depois continuando no sentido horário para o
	segmento superior esquerdo, a barra central e o ponto decimal.
	Os pixels apagados são desenhados com uma menor intensidade
	(**0x20/0xff**).

**led8seg_gts1**

	Desenha um mostrador fluorescente digital de oito segmentos do tipo
	usado em máquinas de fliperama *Gottlieb System 1* [#]_ (na verdade uma
	parte da Futaba). Comparado com um mostrador padrão
	com sete segmentos, esses mostradores não têm ponto decimal, a barra
	do meio horizontal está quebrada no centro, assim como no meio da
	barra vertical controlada pelo bit que controlaria o ponto decimal
	num mostrador comum com sete segmentos. Os pixels apagados são
	desenhados com uma menor intensidade (**0x20/0xff**).

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
	Os pixels apagados são desenhados com uma menor intensidade
	(**0x20/0xff**).

**led14segsc**

	Desenha um mostrador LED ou fluorescente alfanumérico padrão com
	catorze segmentos com ponto decimal/vírgula em uma cor determinada. Os
	16 bits baixos do elemento controlam quais segmentos estarão acesos.
	Os 14 bits baixos correspondem aos mesmos segmentos que no
	componente ``led14seg``. Dois bits adicionais correspondem ao ponto
	decimal e cauda de vírgula. Os pixels apagados são desenhados com
	uma menor intensidade (**0x20/0xff**).

**led16seg**

	Desenha um mostrador LED ou fluorescente alfanumérico padrão com dezesseis
	segmentos em uma cor determinada. Os 16 bit baixos do elemento controlam
	quais os elementos que estarão acesos. Começando pelo bit de menor
	importância a sequência de atualização dos bits correspondentes
	começam na metade esquerda da barra superior, a metade direita da
	barra superior, continuando no sentido horário para o segmento
	superior esquerdo, as metades esquerda e direita da barra central e
	horizontal, as metades superior e inferior da barra do meio
	vertical, e as barras diagonais no sentido horário a partir do canto
	inferior esquerdo até a parte inferior direito. Os pixels apagados
	são desenhados com uma menor intensidade
	(**0x20/0xff**).

**led16segsc**

	Desenha um mostrador LED ou fluorescente alfanumérico padrão com
	dezesseis segmentos e o ponto decimal em uma cor determinada.
	Os 16 bits baixos do elemento controlam quais segmentos estarão
	acesos. Os 18 bits inferiores correspondem aos mesmos controles de
	estado dos segmentos que em ``led16seg``. Dois bits adicionais
	correspondem ao ponto decimal e cauda de vírgula. Os pixels apagados
	são desenhados com uma menor intensidade (**0x20/0xff**).

**simplecounter**

	Exibe o valor numérico do estado do elemento usando a fonte do sistema
	em uma cor determinada. O valor é formatado em notação decimal. Um
	atributo ``digits`` pode ser informado para definir a quantidade
	mínima de dígitos a serem exibidos. Se presente, o atributo
	``digits`` deve ser um número inteiro, se ausente, um mínimo de dois
	dígitos será exibido.

	O atributo ``maxstate`` pode ser informado
	para definir o valor máximo do estado a ser exibido. Se presente, o atributo
	``maxstate`` deve ser um número positivo; caso esteja ausente o valor
	predefinido é **999**.  Um atributo ``align`` pode ser usado para
	determinar o alinhamento do texto. Caso esteja presente, o atributo
	``align`` deve ser um número inteiro onde **0** significa alinhar
	ao centro, **1** alinhar à esquerda e **2** alinhar à direita.
	Na sua ausência o texto será centralizado.

**reel**

	Usado para desenhar os cilindros usados por máquinas de caça
	níquel.
	Os atributos compatíveis são ``symbollist``, ``stateoffset``,
	``numsymbolsvisible``, ``reelreversed`` e ``beltreel``.

Um exemplo de um elemento que desenha um texto estático do lado esquerdo
da tela:

.. code-block:: xml

    <element name="label_reset_cpu">
        <text string="CPU" align="1"><color red="1.0" green="1.0" blue="1.0" /></text>
    </element>


Um exemplo de um elemento que mostra um LED redondo onde a intensidade do
seu brilho depende do estado alto da saída:

.. code-block:: xml

    <element name="led" defstate="0">
        <rect state="0"><color red="0.43" green="0.35" blue="0.39" /></rect>
        <rect state="1"><color red="1.0" green="0.18" blue="0.20" /></rect>
    </element>

Um exemplo de elemento de um botão que retorna um efeito visual quando
pressionado:

.. code-block:: xml

    <element name="btn_rst">
        <rect state="0"><bounds x="0.0" y="0.0" width="1.0" height="1.0" /><color red="0.2" green="0.2" blue="0.2" /></rect>
        <rect state="1"><bounds x="0.0" y="0.0" width="1.0" height="1.0" /><color red="0.1" green="0.1" blue="0.1" /></rect>
        <rect state="0"><bounds x="0.1" y="0.1" width="0.9" height="0.9" /><color red="0.1" green="0.1" blue="0.1" /></rect>
        <rect state="1"><bounds x="0.1" y="0.1" width="0.9" height="0.9" /><color red="0.2" green="0.2" blue="0.2" /></rect>
        <rect><bounds x="0.1" y="0.1" width="0.8" height="0.8" /><color red="0.15" green="0.15" blue="0.15" /></rect>
        <text string="RESET"><bounds x="0.1" y="0.4" width="0.8" height="0.2" /><color red="1.0" green="1.0" blue="1.0" /></text>
    </element>


.. _layout-parts-views:

Exibições
~~~~~~~~~

Uma exibição define um arranjo de elementos ou imagens na tela emulada
que podem ser exibidas em uma janela ou em uma tela.
As exibições também conectam elementos as entradas I/O e saídas
emuladas.
Um arquivo de layout podem conter vários modos de exibição. Caso uma
exibição corresponda a uma tela inexistente, ela se torna
*inviável*.

O MAME exibirá uma mensagem de aviso, irá ignorar a exibição que for
inviável e continuará a carregar as exibições do arquivo de layout.
Isso é muito útil para sistemas onde uma tela é opcional, por exemplo,
computadores com controles do painel frontal e um terminal serial
opcional.

As exibições são identificadas pelo nome na interface do usuário
do MAME e na linha de comando. Para arquivos de layouts associados a
dispositivos outros que o dispositivo de driver raiz, os nomes das
exibições dos dispositivos são precedidos por uma tag (com os dois
pontos iniciais omitidos) por exemplo, para exibir um dispositivo
chamado "*Keyboard LEDs*" vindo do dispositivo ``:tty:ie15``, ele deve ser
associado como **tty:ie15 Keyboard LEDs** na interface do usuário do
MAME.
As exibições são mostradas na ordem em que são carregadas.
Dentro de um arquivo de layout, as exibições são carregados em ordem
de chegada, começando de cima para baixo.

As exibições são criadas com elementos ``view`` dentro de um atributo de
nível primário do elemento ``mamelayout``. Cada elemento ``view`` deve
ter um nome usando o atributo ``name``, informando seu nome legível para
o uso na interface do usuário e nas opções de linha de comando.
Este é um exemplo de uma tag inicial válida para um elemento
``view``:

.. code-block:: xml

    <view name="Control panel">

O elemento "view" cria um escopo emaranhado dentro do parâmetro de escopo
de primeiro nível ``mamelayout``. Por razões históricas, os elementos
``view`` são processados *depois* de todos os outros elementos
herdados de ``mamelayout``. Isso significa que uma exibição pode
fazer referência a elementos e grupos que apareçam depois naquele
arquivo, os parâmetros anexados ao escopo terão seus valores ao final do
elemento ``mamelayout``.

Os seguintes elementos filho são permitidos dentro do elemento ``view``:

**bounds**

	Define a origem e o tamanho da exibição interna do sistema de
	coordenadas caso esteja presente.
	Veja :ref:`layout-concepts-coordinates` para maiores detalhes.
	Se ausente, os limites de exibição serão computados unindo os
	limites de todas as telas e elementos dentro da região sendo
	exibida. Só faz sentido ter um elemento ``bounds`` como um filho
	direto de um elemento ``view``. Qualquer conteúdo fora dos limites
	da exibição serão recortados e a visualização será redimensionada
	proporcionalmente para se ajustar aos limites da tela ou janela.

**param**

	Define ou reatribui um parâmetro de valor no escopo da exibição. Veja
	:ref:`layout-concepts-params` para mais informações.

.. raw:: latex

	\clearpage

**screen**

	Adiciona uma imagem de tela emulada à exibição. A tela deve ser
	identificada usando um atributo ``index`` ou um atributo ``tag``
	(um elemento ``screen`` não pode ter ambos os atributos ``index`` e
	``tag``).
	Se presente, o atributo ``index`` deve ser um valor inteiro e não
	negativo. As telas são numeradas pela ordem em que aparecem na
	configuração da máquina, começando com zero (**0**). Se presente, o
	atributo ``tag`` deve ser o caminho da tag para a tela em relação ao
	dispositivo que provoque a leitura do layout. As telas são
	desenhadas na ordem em que aparecem no arquivo de layout, A sua
	ordem de exibição começa de frente para trás.

**group**

	Adiciona o conteúdo do grupo à exibição
	(veja :ref:`layout-parts-groups`).
	Para adicionar o nome do grupo use o atributo ``ref``. Será
	considerado um erro caso nenhum grupo com este nome seja definido
	no arquivo de layout. Veja abaixo para mais informações sobre a
	questão de posicionamento.

**repeat**

	Repete o seu conteúdo definindo a sua quantidade pelo atributo
	``count``. O atributo ``count`` deve ser um número inteiro e
	positivo. Em uma exibição, o elemento ``repeat`` pode conter os
	elementos ``element``, ``screen``, ``group`` e mais elementos
	``repeat``, que funcionam da mesma maneira que quando colocados em
	uma visualização direta.
	Veja :ref:`layout-parts-repeats` para mais informações de como usar os
	elementos ``repeat``.

As Telas com elementos ``screen``,  elementos de layout ``element`` e
elementos de grupo ``group`` podem ter a sua orientação alterada usando
o elemento ``orientation``.
Para as telas, os modificadores de orientação são aplicados junto com os
modificadores de orientação definido no dispositivo de tela da máquina.
O elemento ``orientation`` suportam os seguintes atributos, todos
eles são opcionais:

**rotate**

	Se presente, aplica rotação no sentido horário em incrementos de
	noventa graus. Deve ser um número inteiro igual a **0**, **90**, ou
	**270**.

**swapxy**

	Permite que a tela, elemento ou grupo seja espelhado ao longo de uma
	linha em quarenta e cinco graus para vertical, da esquerda para a
	direita. Se presente deve ser entre ``yes`` ou ``no``.
	O espelhamento se aplica logicamente após a rotação.

**flipx**

	Permite que a tela, elemento ou grupo sejam espelhados à partir de
	uma linha com 45 graus em torno de seu eixo vertical, vindo da quina
	superior esquerda até a quina inferior direita. Se presente deve ser
	entre ``yes`` ou ``no``.
	O espelhamento ocorre após a rotação.

**flipy**

	Permite que a tela, elemento ou grupo sejam espelhado ao redor do seu
	eixo horizontal, de cima para baixo. Se presente, deve ser entre
	``yes`` ou ``no``. O espelhamento ocorre após a rotação.

As Telas (elementos ``screen``) e elementos de layout (elementos
``element``) podem conter um atributo ``blend`` para determinar o modo
de mesclagem. Os valores válidos são ``none`` (sem mesclagem), ``alpha``
(mesclagem alpha) [#]_, ``multiply`` (multiplicação RGB) [#]_, e ``add``
(mesclagem aditiva) [#]_. A predefinição para a tela é permitir que o
driver defina a mesclagem por camada, sendo que o modo de mesclagem dos
elementos de layout é predefinido como mesclagem alpha.

As Telas (elementos ``screen``), elementos de layout (elementos
``element``) e elementos de grupo (``group``) podem ser posicionados e
redimensionados usando um elemento ``bounds``
(veja :ref:`layout-concepts-coordinates` para mais informações).
Na ausência do elemento ``bounds`` os elementos "screens" e "layout"
retornam aos valores predefinidos em unidades quadradas (origem em
**0,0** e ambos os valores de altura e largura serão igual a **1**).

Na ausência do elemento ``bounds``, os grupos são expandidos sem
qualquer tradução ou redimensionamento (note que os grupos podem
posicionar as telas ou elementos fora dos seus limites. Este exemplo
mostra uma exibição com referência a posição da tela com um elemento de
layout individual e dois grupos de elementos:

.. code-block:: xml

    <view name="LED Displays, Terminal and Keypad">
        <screen index="0"><bounds x="0" y="132" width="320" height="240" /></screen>
        <element ref="beige"><bounds x="320" y="0" width="172" height="372" /></element>
        <group ref="displays"><bounds x="0" y="0" width="320" height="132" /></group>
        <group ref="keypad"><bounds x="336" y="16" width="140" height="260" /></group>
    </view>

As Telas (elementos ``screen``), elementos de layout (``element``) e
elementos de grupos (``group``) podem ter um sub-elemento ``color``
(veja :ref:`layout-concepts-colours`) ao definir uma cor modificadora,
o valor dessa cor será usada como multiplicador para alterar as cores
componentes da tela ou de elementos de layout.

Caso um elemento ``element`` contenham atributos ``inputtag`` e
``inputmask``, ao clicar neles terá o mesmo efeito que pressionar uma
tecla ou botão correspondente mapeado(s) para essa(s) entrada(s).
O atributo ``inputtag`` define o caminho da tag de uma porta de I/O em
relação ao dispositivo que fez com que o arquivo de layout fosse
carregado. O atributo ``inputmask`` deve ser um número inteiro definindo
os bits da porta de I/O que o elemento deve ativar. Este exemplo mostra
como inicializar os botões pressionáveis:

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


Caso um elemento contenha um atributo ``name``, ele usará seu estado com
base no valor correspondente da saída emulada com o mesmo nome. Observe
que os nomes de saída são globais, o que pode se tornar um problema
quando uma máquina usar diferentes categorias do mesmo tipo de
dispositivo. Veja :ref:`layout-parts-elements` para obter mais
informações de como um estado do elemento afeta a sua aparência.
Este exemplo mostra como os mostradores digitais podem ser conectados
nas saídas emuladas:

.. code-block:: xml

    <element name="digit6" ref="digit"><bounds x="16" y="16" width="48" height="80" /></element>
    <element name="digit5" ref="digit"><bounds x="64" y="16" width="48" height="80" /></element>
    <element name="digit4" ref="digit"><bounds x="112" y="16" width="48" height="80" /></element>
    <element name="digit3" ref="digit"><bounds x="160" y="16" width="48" height="80" /></element>
    <element name="digit2" ref="digit"><bounds x="208" y="16" width="48" height="80" /></element>
    <element name="digit1" ref="digit"><bounds x="256" y="16" width="48" height="80" /></element>


Caso um elemento justifique um elemento de layout e tenha ambos os
atributos ``inputtag`` e ``inputmask`` porém faltar um nome de atributo
``name``, ele usará o seu estado com base no valor correspondente da
porta I/O mascarada com o valor do atributo ``inputmask`` onde será
aplicado um operador lógico XOR junto com os valores predefinidos da
porta I/O. Este último é importante para entradas que estão em um estado
baixo. Caso o resultado seja não zero, o estado se torna 1, caso
contrário será 0. Em geral é útil para permitir botões que sejam
clicáveis e chaves interruptoras [#]_ que proveem um retorno visível na
tela.

É possível obter raw data através da porta I/O ao utilizar o elemento
``inputraw="1"`` mascarado com o valor de ``inputmask`` e deslocado
(shifted) para a direita para eliminar os zeros (uma máscara **0x05**
não causará nenhum deslocamento, enquanto uma máscara **0xb0** resultará
no deslocamento do valor em 4 bits para a direita por exemplo).

O MAME trata todos os elementos do layout como sendo retangulares ao
lidar com a entrada do mouse habilitando apenas o elemento mais à frente
na região onde o ponteiro estiver presente.


.. _layout-parts-groups:

Grupos reutilizáveis
~~~~~~~~~~~~~~~~~~~~

Os grupos permitem que um arranjo de telas ou de elementos de layout
sejam usados várias vezes em uma exibição ou outros grupos. Os grupos
podem ser de grande ajuda mesmo que você use o arranjo apenas uma vez,
pois eles podem ser usados para agregar parte de um layout complexo.
Os grupos são definidos usando elementos ``group`` dentro de elementos
``mamelayout`` de primeiro nível e representados ao usar elementos
``group`` dentro de elementos ``view`` e outros elementos ``group``.

Cada definição de grupo deve ter um atributo ``name`` informando um
identificador único. Será considerado um erro caso o arquivo de layout
tenha várias definições de grupos usando um atributo ``name`` idêntico.
O valor do atributo ``name`` é usado quando for justificar a exibição de
um grupo ou outro. Este é um exemplo da tag de abertura para a definição
de um elemento grupo dentro do elemento de primeiro nível
``mamelayout``: ::

    <group name="panel">

Este grupo pode então ser justificado em uma exibição ou em outro
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
funcionem da mesma maneira que as exibições.
Veja :ref:`layout-parts-views` para mais informações.
Um grupo pode justificar outros grupos, porém loops recursivos não são
permitidos. Será considerado um erro caso um grupo representar a si
mesmo de forma direta ou indireta.

Os grupos possuem seus próprios sistemas de coordenadas internas.
Caso um elemento de definição de grupo não tenha um elemento limitador
``bounds`` como filho direto, os seus limites serão computados junto com
a união dos limites de todas as telas, elementos de layout ou grupos
relacionados.
Um elemento filho ``bounds`` pode ser usado para definir
explicitamente grupos limitadores
(veja :ref:`layout-concepts-coordinates` para mais informações).
Observe que os limites dos grupos são usados com a única justificativa
para calcular as coordenadas de transformação quando for relacionado
a um grupo.
Um grupo pode posicionar as telas ou elementos fora de seus limites e eles
não serão cortados.

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
           Os grupos limitadores são traduzidos e escalonados para preencher 2/3 da escala horizontal e o dobro verticalmente
           Elemento superior esquerdo posicionado em  (0,0) com 6.67 de largura e 20 de altura
           Elemento inferior direito posicionado em (13.33,10) com 6.67 de largura e 20 de altura
           Os elementos de visualização calculado com origem em (0,0) 20 de largura e 30 de altura
        -->
        <element ref="topleft"><bounds x="5" y="10" width="10" height="10" /></element>
        <element ref="bottomright"><bounds x="25" y="15" width="10" height="10" /></element>
    </view>

Isto é relativamente simples, como todos os elementos inerentemente caem
dentro dos limites automaticamente calculados ao grupo. Agora, considere
o que acontece caso a posição dos elementos de um grupo estiver fora dos
seus limites:

.. code-block:: xml

    <group name="periphery">
        <!-- os limites dos elementos estão acima da quina superior e à direita da quina direita -->
        <bounds x="10" y="10" width="20" height="25" />
        <element ref="topleft"><bounds x="10" y="0" width="10" height="10" /></element>
        <element ref="bottomright"><bounds x="30" y="20" width="10" height="10" /></element>

    <view name="Test">
        <!--
           Os grupos limitadores são traduzidos e escalonados para preencher 2/3 da escala horizontal unido verticalmente.
           Elemento superior esquerdo posicionado em (5,-5) com 15 de largura e 10 de altura
           Elemento inferior direito posicionado em (35,15) com 15 de largura e 10 de altura
           Os elementos de visualização calculado com origem em (5,-5) 45 de largura e 30 de altura
        -->
        <group ref="periphery"><bounds x="5" y="5" width="30" height="25" /></group>
    </view>

Os elementos de grupo são traduzidos e escalonados conforme são
necessários para distorcer os limites internos dos grupos para o limite
de exibição final. O conteúdo dos grupos não fica limitado aos seus
limites. A exibição considera os limites dos elementos atuais ao
calcular seus próprios limites e não os limites de destino especificado
para o grupo.

Quando um grupo é interpretado, ele cria um escopo do parâmetro
agrupado.
A lógica do escopo pai é o escopo do parâmetro de visualização, grupo ou
bloco de repetição onde o grupo for interpretado (*não* é um parente
léxico ao elemento de primeiro nível ``mamelayout``).
Qualquer elemento ``param`` dentro do conjunto de definição, estabelece
os parâmetros dos elementos no escopo local para o grupo interpretado.
Os parâmetros locais não persistem através de várias interpretações.
Veja :ref:`layout-concepts-params` para mais informações sobre os
parâmetros. (Observe que o nome dos grupos não fazem parte do seu
conteúdo e qualquer referência de parâmetro no próprio atributo ``name``
será substituído no ponto onde a definição do grupo aparecer no primeiro
nível do elemento de escopo ``mamelayout``.)

.. raw:: latex

	\clearpage

.. _layout-parts-repeats:

Repetindo Blocos
~~~~~~~~~~~~~~~~

Os blocos repetidos fornecem uma maneira concisa de gerar ou organizar
um grande número de elementos similares. A repetição de blocos são
geralmente usadas em conjunto com o gerador de parâmetros
(veja :ref:`layout-concepts-params`).
As repetições de blocos podem ser agrupados para criar arranjos mais
complexos.

Os blocos repetidos são criados com o elemento ``repeat``.
Cada elemento ``repeat`` requer um atributo ``count`` definindo um
número de iterações a serem geradas.
O atributo ``count`` deve ser um número inteiro e positivo. A repetição
de blocos é permitida dentro do elemento de primeiro nível
``mamelayout``, dentro dos elementos ``group`` e ``view`` assim como
dentro de outros elementos ``repeat``. O exato elemento filho permitido
dentro do elemento ``repeat`` depende de onde ele aparecer:

* Um bloco repetido dentro do elemento de primeiro nível ``mamelayout``
  podem conter os seguintes elementos
  ``param``, ``element``, ``group`` (definição), e ``repeat``.
* Um bloco repetido dentro de um elemento ``group`` ou ``view`` podem
  conter os seguintes elementos
  ``param``, ``element`` (referência), ``screen``, ``group``
  (referência), e ``repeat``.

Um bloco de repetição faz a repetição efetiva do seu conteúdo diversas
vezes dependendo do valor definido no atributo ``count``.
Veja as seções relevantes para mais informações de como os elementos
filho são usados (:ref:`layout-parts`, :ref:`layout-parts-groups`,
e :ref:`layout-parts-views`). Um bloco que se repete cria um escopo de
parâmetros agrupados dentro do escopo do parâmetro de seu elemento pai
léxico (DOM).

Gerando rótulos numéricos em branco de zero a onze com o nome
``label_0``, ``label_1``, e assim por diante (dentro do elemento de
primeiro nível ``mamelayout``):

.. code-block:: xml

    <repeat count="12">
        <param name="labelnum" start="0" increment="1" />
        <element name="label_~labelnum~">
            <text string="~labelnum~"><color red="1.0" green="1.0" blue="1.0" /></text>
        </element>
    </repeat>

Uma fileira horizontal com 40 mostradores digitais, com cinco unidades
de espaço entre elas, controladas pelas saídas ``digit0`` até
``digit39`` (dentro de um elemento ``group`` ou ``view``):

.. code-block:: xml

    <repeat count="40">
        <param name="i" start="0" increment="1" />
        <param name="x" start="5" increment="30" />
        <element name="digit~i~" ref="digit">
            <bounds x="~x~" y="5" width="25" height="50" />
        </element>
    </repeat>

Oito mostradores com matrix de ponto medindo cinco por sete em uma
linha, com pixels controlados por ``Dot_000`` até ``Dot_764``
(dentro de um elemento ``group`` ou ``view``):

.. code-block:: xml

    <repeat count="8"> <!-- 8 digits -->
        <param name="digitno" start="1" increment="1" />
        <param name="digitx" start="0" increment="935" /> <!-- distância entre dígitos ((111 * 5) + 380) -->
        <repeat count="7"> <!-- 7 rows in each digit -->
            <param name="rowno" start="1" increment="1" />
            <param name="rowy" start="0" increment="114" /> <!-- distância vertical entre LEDs -->
            <repeat count="5"> <!-- 5 columns in each digit -->
                <param name="colno" start="1" increment="1" />
                <param name="colx" start="~digitx~" increment="111" /> <!-- distância horizontal entre LEDs -->
                <element name="Dot_~digitno~~rowno~~colno~" ref="Pixel" state="0">
                    <bounds x="~colx~" y="~rowy~" width="100" height="100" /> <!-- tamanho de cada LED -->
                </element>
            </repeat>
        </repeat>
    </repeat>

Dois teclados "clicáveis", separados horizontalmente por um teclado
numérico quatro por quatro (dentro de um elemento ``group`` ou
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

Os botões são desenhados usando os elementos ``btn00`` na parte superior
esquerda, ``btn07`` na parte superior direita, ``btn30`` na parte
inferior esquerda e ``btn37`` na parte inferior direita contando entre
eles. As quatro colunas são conectadas às portas I/O ``row0``, ``row1``,
``row2``, and ``row3``, de cima para baixo.
As colunas consecutivas são conectadas aos bits das portas I/O, começando
com o bit de menor importância do lado esquerdo. Observe que o parâmetro
``mask`` no elemento mais interno ``repeat``, recebe o seu valor inicial
vindo do parâmetro correspondentemente nomeado no delimitador de escopo,
mas não o modifica.

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

O elemento ``repeat`` mais externo gera um grupo de duas colunas em cada
interação; o próximo elemento ``repeat`` gera uma coluna individual em
cada interação; o elemento ``repeat`` interno produz dois recortes
horizontais adjacentes em cada interação.
As colunas são conectadas às portas I/O através do ``board:IN.7``
no topo do ``board.IN.0`` na parte inferior.


.. _layout-errors:

O Tratamento de erros
---------------------

* Para os arquivos de layout internos (fornecidos pelo desenvolvedor),
  os erros são detectados pelo script ``complay.py`` durante uma falha
  de compilação.
* O MAME irá parar de carregar um arquivo de layout caso haja um erro
  de sintaxe e nenhuma exibição de layout estará disponível.
  Alguns exemplos de erros de sintaxe são referências para elementos ou
  grupos indefinidos, limites inválidos, cores inválidas, grupos
  recursivamente emaranhados e a redefinição do gerador de parâmetros.
* O MAME mostrará uma mensagem de aviso e continuará caso uma exibição
  faça referência à uma tela inexistente durante o carregamento de um
  layout.
  Exibições apontando para telas não existentes, não são exibidas, são
  consideradas inviáveis e tão pouco estarão disponíveis para o usuário.


.. _layout-autogen:

As Exibições geradas automaticamente
------------------------------------

Após o carregamento interno de layouts (fornecido pelo desenvolvedor) e
do layout externo (fornecido pelo usuário). As seguintes exibições são
geradas de forma automática:

* Será exibido a mensagem "*No screens Attached to the system*" ou
  "*Sem telas anexadas ao sistema*" caso o sistema não possua telas e
  tão pouco sejam encontradas exibições viáveis no sistema interno ou
  externo de layout.
* A tela será exibida em sua proporção física e com a rotação aplicada
  em cada tela emulada.
* A tela será exibida em uma proporção onde os pixels sejam quadrados e
  com a rotação aplicada para cada tela emulada onde a proporção de
  pixel configurada não corresponda a proporção física.
* Serão exibidos duas cópias da imagem da tela uma em cima da outra com
  um pequeno espaço entre elas caso o sistema emule apenas uma tela.
  A cópia da parte de cima será rotacionada em 180 graus. Esta visão
  pode ser usada em uma cabine tipo cocktail, que disponibiliza uma mesa
  onde os jogadores se sentam frente a frente, ou alternando os jogos
  que não girem automaticamente a tela para o segundo jogador.
* As telas serão organizadas horizontalmente da esquerda para a direita
  e verticalmente de cima para baixo, ambos com e sem pequenas lacunas
  entre elas caso o sistema tenha exatamente duas telas emuladas e
  nenhuma exibição no layout interno ou externo mostrando todas as
  telas, ou caso o sistema tenha mais de duas telas emuladas.
* As telas serão exibidas em formato de grade, em ambas as fileiras
  principais (da esquerda para a direita e de cima para baixo) e o pilar
  principal (de cima para baixo e depois da esquerda para a direita).
  As exibições são geradas com e sem intervalos entre as telas.

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

O script pode também detectar muitos erros comuns de formatação nos
arquivos de layout fornecendo melhores mensagens de erro do que o MAME
durante a carga de tais arquivos.

Observe que o script não executa todo o mecanismo de layout, por isso
não pode detectar erros nos parâmetros usados como referências para os
elementos indefinidos ou agrupamentos dos grupos organizados de forma
recursiva.
O script **complay.py** é compatível com os interpretadores Python
a partir das versões 2.7, 3 ou mais recentes, ele usa três parâmetros,
um nome de arquivo de entrada, um nome do arquivo de saída e um nome
base para as variáveis na saída: ::

	python scripts/build/complay.py <input> [<output> [<varname>]]

O nome do arquivo de entrada é obrigatório. Caso nenhum nome de arquivo
de saída seja fornecido, o **complay.py** irá analisar e verificar a
entrada, informando qualquer erros encontrado, sem gerar qualquer
arquivo na saída.
Caso nenhum nome de variável base seja fornecido, o **complay.py** irá
gerar um com base no nome do arquivo de entrada. Isso não garante a
produção de identificadores válidos.

Os status de saída são:

	* **0** (zero) quando for concluído com sucesso.

	* **1** quando houver um erro durante a invocação por linha de
	  comando.

	* **2** caso haja erro no arquivo de entrada.

	* **3** caso seja um erro de I/O.

Ao definir um arquivo de saída o arquivo será criado ou substituído caso
seja concluído com sucesso ou removido no caso de falha.

Para aferir um arquivo de layout visando identificar se há algum tipo de
erro, execute o script apontando o caminho completo para o arquivo, como
mostra o exemplo abaixo: ::

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
		<https://i.postimg.cc/FF2GYc9v/Reels.jpg>`_ usados em máquinas
		caça niqueis. (Nota do tradutor)
.. [#]	`Aqui <https://www.youtube.com/watch?v=-rrP4Prx1rc>`_ um exemplo
		destes mostradores. (Nota do tradutor)
.. [#]	Alpha Blending
.. [#]	RGB multiplication
.. [#]	Additive blending
.. [#]	Toggle switches, também é conhecido como chave alavanca.
		(Nota do tradutor)
