.. raw:: latex

	\clearpage


.. _luascript-ref-render:

Classes do sistema de renderização Lua
======================================

O sistema de renderização é responsável por desenhar o que você vê nas
janelas do MAME, incluindo as telas emuladas, a arte e os elementos da
interface do usuário.

.. contents::
    :local:
    :depth: 1


.. _luascript-ref-renderbounds:

Limites do renderizador
-----------------------

|encaa| ``render_bounds`` do MAME que representa um retângulo usando as
coordenadas de ponto flutuante.


Instanciação
~~~~~~~~~~~~

**emu.render_bounds()**

	Cria os limites da renderização de um objeto que representa uma
	unidade quadrada com o canto superior esquerdo em (``0``, ``0``) e
	canto inferior direito em (``1``, ``1``). Observe que ao renderizar
	as coordenadas do alvo elas não possuem necessariamente as mesmas
	escalas ``X`` e ``Y``, então isso pode não representar a geração de
	um quadrado.


**emu.render_bounds (esquerda, cima, direita, baixo)**

	Cria os limites da renderização de um objeto representando um
	retângulo com o canto superior esquerdo em (``x0``, ``y0``) e o
	canto inferior direito em (``x1``, ``y1``).

	Todos os argumentos devem ser em números de ponto flutuante.


Métodos
~~~~~~~

**bounds:includes(x, y)**

	|ubis| o ponto informado está dentro do retângulo. O retângulo deve
	ser normalizado para que funcione (direito maior que o esquerdo e
	baixo maior do que cima). Os argumentos devem ser números de ponto
	flutuante.


**bounds:set_xy(esquerda, cima, direita, baixo)**

	Define a posição e o tamanho do retângulo nos termos das posições
	das bordas. Todos os argumentos devem ser em números de ponto
	flutuante.


**bounds:set_wh(esquerda, cima, largura, altura)**

	Define a posição e o tamanho do retângulo nos termos da posição do
	canto superior esquerdo, da largura e da altura. Todos os argumentos
	devem ser em números de ponto flutuante.

Propriedades
~~~~~~~~~~~~

**bounds.x0** |lees|

	A coordenada mais à esquerda no retângulo (ou seja, a coordenada
	``X`` do lado da borda esquerda ou no canto superior esquerdo).


**bounds.x1** |lees|

	A coordenada mais à direita no retângulo (ou seja, a coordenada
	``X`` da borda direita ou do canto inferior direito).


**bounds.y0** |lees|

	A coordenada superior no retângulo (ou seja, a coordenada ``Y`` da
	parte da borda superior ou no canto superior esquerdo).


**bounds.y1** |lees|

	A coordenada mais inferior do retângulo (ou seja, a coordenada ``Y``
	da borda inferior ou do canto inferior direito).


**bounds.width** |lees|

	A largura do retângulo. Ao definir esta propriedade a posição da
	extremidade direita muda.


**bounds.height** |lees|

	A altura do retângulo. Ao definir esta propriedade a posição da
	borda inferior muda.


**bounds.aspect** |sole|

	A proporção entre a largura e altura do retângulo. Observe que o
	alvo geralmente é usado em coordenadas de renderização que não
	necessariamente têm escalas ``X`` e ``Y`` iguais. Um retângulo
	representando um quadrado na saída final não necessariamente tem uma
	proporção ``1``.


.. _luascript-ref-rendercolor:

Renderização da cor
-------------------

|encaa| ``render_color`` do MAME que representa um formato de cor ARGB
(alfa, vermelho, verde, azul). Os canais são valores de ponto flutuante
que variam entre zero (``0``, alfa transparente ou sem cor) a um (``1``,
opaco ou totalmente colorido). Os valores do canal da cor não são
pré-multiplicados pelo valor do canal alfa.


Instanciação
~~~~~~~~~~~~

**emu.render_color()**

	Cria um objeto colorido representando o branco opaco (todos os
	canais definidos como ``1``). Este é o valor da identidade, a
	multiplicação do ARGB por este valor não irá alterar uma cor.


**emu.render_color(a, r, g, b)**

	Cria a renderização de um objeto colorido com o alfa, vermelho,
	verde e os valores do canal azul. Os argumentos devem ser todos
	números de ponto flutuante no intervalo de zero (``0``) até um
	(``1``).


Métodos
~~~~~~~

**color:set(a, r, g, b)**

	Define os valores dos canais alfa, vermelho, verde e azul da cor do
	objeto. Todos os argumentos devem números de ponto flutuante no
	intervalo de zero (``0``) até um (``1``).


Propriedades
~~~~~~~~~~~~

**color.a** |lees|

	O valor alfa, no intervalo entre zero (0, transparente) até um (1,
	opaco).


**color.r** |lees|

	O valor do canal vermelho, no intervalo entre zero (``0`` desligado)
	até um (``1``, intensidade total).


**color.g** |lees|

	O valor do canal verde, no intervalo entre zero (``0`` desligado)
	até um (``1``, intensidade total).


**color.b** |lees|

	O valor do canal azul, no intervalo entre zero (``0`` desligado) até
	um (``1``, intensidade total).

.. raw:: latex

	\clearpage


.. _luascript-ref-palette:

Paleta
------

|encaa| ``palette_t`` do MAME que representa uma tabela de cores que
pode ser buscada pelo índice com base zero. As paletas sempre contêm
as entradas adicionais especiais para o preto e branco.

Cada cor possui um valor associado do ajuste do contraste. Cada grupo de
ajuste possui valores associados do ajuste do brilho e do contraste. A
paleta também possui valores gerais para o ajuste do brilho, do
contraste e do gama.

|acsre| alfa/vermelho/verde/azul (ARGB). |osvalo|. Os valores dos canais
da cor não são previamente multiplicados pelo valor alpha. Os valores do
canal devem ser empacotados em bytes com 32 bits inteiros não assinados
pelo valor do canal alfa, na ordem alpha, vermelho, verde, azul a partir
do byte mais importante até o |bcmi|.


Instanciação
~~~~~~~~~~~~

**emu.palette(cores, [grupos])**

	Cria uma paleta com uma quantidade determinada de cores e de grupos
	para o ajuste de brilho e contraste. A quantidade dos grupos das
	cores retorna para um caso não seja definido. As cores são
	inicializadas em preto, o ajuste do brilho é inicializado com
	o valor ``0,0``, o contraste com ``1,0`` e o gama com ``1,0``.


Métodos
~~~~~~~

**palette:entry_color(índice)**

	Obtém a cor especificada |noin|.

	Os valores do índice variam entre zero e |aquan|. Retorna a cor
	preta caso o |insej|.


**palette:entry_contrast(índice)**

	Obtém o ajuste de contraste para a cor |noin|. Este é um número de
	ponto flutuante.

	Indexa a faixa de valores entre zero e |aquan|. Retorna ``1.0``
	caso o |insej|.


**palette:entry_adjusted_color(índice, [grupo])**

	Obtém a cor com os ajustes aplicados de brilho, contraste e gama.

	Caso o grupo seja definido, os valores do índice das cores variam de
	zero |aquan| e os valores do grupo variam entre zero e a quantidade
	dos grupos de ajuste na paleta menos um.

	Quando um grupo não é definido, os valores do índice variam entre
	zero a quantidade de cores multiplicado pelo número dos grupos de
	ajuste mais um. Os valores do índice podem ser calculados
	multiplicando o índice do grupo com base zero pela quantidade de
	cores na paleta e adicionando o índice das cores com base zero. Os
	dois últimos valores do índice correspondem às entradas especiais
	para o preto e o branco respectivamente.

	Retorna a cor preta caso a combinação definida do índice e do grupo
	de ajuste seja inválida.

.. raw:: latex

	\clearpage


**palette:entry_set_color(índice, cor)**

	Define a cor |espno|. A cor pode ser definida através de um único
	valor de 32 bits compactado ou como valores individuais para os
	canais vermelho, verde e azul (nesta ordem).

	Os valores do índice variam entre zero |aquan|. Gera um erro caso o
	valor do índice seja inválido.


**palette:entry_set_red_level(índice, nível)**

	Define o valor da cor vermelha do canal |espno|. Os outros valores
	não são afetados.

	Os valores do índice variam entre ``0`` até |aquan|. |guec| o valor
	do índice seja inválido.


**palette:entry_set_green_level(índice, nível)**

	Define o valor da cor verde do canal |espno|. Os outros valores
	não são afetados.

	Os valores do índice variam entre ``0`` até |aquan|. |guec| o valor
	do índice seja inválido.


**palette:entry_set_blue_level(índice, nível)**

	Define o valor da cor azul do canal |espno|. Os outros valores
	não são afetados.

	Os valores do índice variam entre ``0`` até |aquan|. |guec| o valor
	do índice seja inválido.


**palette:entry_set_contrast(índice, nível)**

	Define o valor de ajuste do contraste da cor |espno|. |eeun|.

	Os valores do índice variam entre ``0`` até |aquan|. |guec| o valor
	do índice seja inválido.


**palette:group_set_brightness(grupo, brilho)**

	Define o valor de ajuste do brilho para o grupo de ajuste |espno|.
	|eeun|.

	Os valores do grupo variam entre ``0`` até a quantidade dos grupos
	de ajuste na palete meno um. |guec| o valor do índice seja inválido.


**palette:group_set_contrast(grupo, contraste)**

	Define o valor de ajuste do contraste para o grupo de ajuste
	|espno|. |eeun|.

	Os valores do grupo variam entre ``0`` até a quantidade dos grupos
	de ajuste na palete meno um. |guec| o valor do índice seja inválido.


Propriedades
~~~~~~~~~~~~

**palette.colors** |sole|

	A quantidade de entradas das cores de cada grupo de cores na paleta.

**palette.groups** |sole|

	A quantidade dos grupos de cores na paleta.

**palette.max_index** |sole|

	A quantidade valida dos índices de cores na paleta.

**palette.black_entry** |sole|

	O índice da entrada especial para a cor preta.

**palette.white_entry** |sole|

	O índice da entrada especial para a cor branca.

**palette.brightness** |soes|

	Ajuste geral do brilho para a paleta. |eeun|.


**palette.contrast** |soes|

	Ajuste geral do contraste para a paleta. |eeun|.

**palette.gamma** |soes|

	Ajuste geral do gama para a paleta. |eeun|.


.. _luascript-ref-bitmap:

Bitmap
------

Envelopa a implementação das classes ``bitmap_t`` e ``bitmap_specific``,
que representam bitmaps bidimensionais armazenados em ordem de maior
prioridade na fila. As coordenadas do pixel têm base zero, aumentando
para a direita e para baixo. Vários formatos de pixels são suportados.


Instanciação
~~~~~~~~~~~~

**emu.bitmap_ind8(paleta, [largura, altura], [xslop, yslop])**

	|cubi| 8 bit. Numa :ref:`paleta <luascript-ref-palette>`, cada
	pixel é um índice de 8 bits não assinado, base zero.
	|navl|. |clsd|. |vidq|. |dvit|. |navi|. |qlam|.

	|rird|.

.. raw:: latex

	\clearpage


**emu.bitmap_ind16(paleta, [largura, altura], [xslop, yslop])**

	|cubi| 16 bit. Numa :ref:`paleta <luascript-ref-palette>`, cada
	pixel é um índice de 16 bits não assinado, base zero.
	|navl|. |clsd|. |vidq|. |dvit|. |navi|. |qlam|.

	|rird|.


**emu.bitmap_ind32(paleta, [largura, altura], [xslop, yslop])**

	|cubi| 32 bit. Numa :ref:`paleta <luascript-ref-palette>`, cada
	pixel é um índice de 32 bits não assinado, base zero.
	|navl|. |clsd|. |vidq|. |dvit|. |navi|. |qlam|.

	|rird|.


**emu.bitmap_ind64(paleta, [largura, altura], [xslop, yslop])**

	|cubi| 64 bit. Numa :ref:`paleta <luascript-ref-palette>`, cada
	pixel é um índice de 64 bits não assinado, base zero.
	|navl|. |clsd|. |vidq|. |dvit|. |navi|. |qlam|.

	|rird|.


**emu.bitmap_yuy16([largura, altura], [xslop], yslop])**

	|cbef| Y'CbCr com subamostragem de croma
	[#CHROMA]_ 4:2:2 (os pares dos pixels horizontais têm valores
	individuais de luma [#LUMA]_, porém, compartilham os valores de
	croma). Cada pixel é um valor inteiro de 16 bits. O byte mais
	importante do valor de 8 bits não assinado da cor do pixel, é o
	componente Y' (luma). Para cada par horizontal dos pixels, o byte
	menos importante do primeiro valor do pixel (base zero par X
	coordenada) é o valor Cb de 8 bits assinado para o par de pixels,
	e o byte menos importante do segundo pixel (base zero ímpar X
	coordenada) é o valor Cr de 8 bits assinado para o par de pixels.

		.. [#CHROMA] Cor
		.. [#LUMA] Luminância

	|navl|. |clsd|. |vidq|. |dvit|. |navi|. |qlam|.

	|rird|.


**emu.bitmap_rgb32([largura, altura], [xslop, yslop])**

	|cbef| RGB sem o canal alfa (transparência). |cprv| 16 bit. O byte 
	mais importante do valor do pixel é ignorado. |tbrm|.

	|navl|. |clsd|. |vidq|. |dvit|. |navi|. |qlam|.

	|rird|.


**emu.bitmap_argb32([largura, altura], [xslop, yslop])**

	|cbef| ARGB. |cprv| 32 bit. O byte mais importante do valor do canal
	do pixel é o valor alpha de 8 bit sem assinatura (transparência)
	onde valores menores são mais transparentes. |tbrm|. Os valores dos
	canais de cores não são previamente multiplicados pelos valores dos
	canais alpha.

	|navl|. |clsd|. |vidq|. |dvit|. |navi|. |qlam|.

	|rird|.


**emu.bitmap_yuy16(source, [x0, y0, x1, y1])**

	|cbef| Y'CbCr com subamostragem 4:2:2 de croma representando uma
	exibição de uma parte do bitmap existente. O retângulo de recorte
	inicial é definido para os limites da exibição. |obose|.

	Na ausência das coordenadas, o novo bitmap representará uma
	visualização do retângulo do recorte atual do bitmap original. Caso
	as coordenadas sejam fornecidas, o novo bitmap representará uma
	exibição do retângulo com o canto superior esquerdo em
	(``x0``, ``y0``) e com o canto inferior direito em (``x1``, ``y1``)
	no bitmap original. As coordenadas estão em unidades de pixels. As
	coordenadas do canto inferior direito são inclusivas.

	O bitmap original deve ser de propriedade do *script* Lua e deve
	usar o formato Y'CbCr. Gera um erro caso as coordenadas sejam
	especificadas representando um retângulo que não esteja totalmente
	contido dentro do retângulo de recorte do bitmap original.


**emu.bitmap_rgb32(source, [x0, y0, x1, y1])**

	|cbef| RGB com subamostragem 4:2:2 de croma representando uma
	exibição de uma parte do bitmap existente. O retângulo de recorte
	inicial é definido para os limites da exibição. |obose|.

	Na ausência das coordenadas, o novo bitmap representará uma
	visualização do retângulo do recorte atual do bitmap original. Caso
	as coordenadas sejam fornecidas, o novo bitmap representará uma
	exibição do retângulo com o canto superior esquerdo em
	(``x0``, ``y0``) e com o canto inferior direito em (``x1``, ``y1``)
	no bitmap original. As coordenadas estão em unidades de pixels. As
	coordenadas do canto inferior direito são inclusivas.

	O bitmap original deve ser de propriedade do *script* Lua e deve
	usar o formato RGB. Gera um erro caso as coordenadas sejam
	especificadas representando um retângulo que não esteja totalmente
	contido dentro do recorte do retângulo do bitmap original.


**emu.bitmap_argb32(source, [x0, y0, x1, y1])**

	|cbef| ARGB com subamostragem 4:2:2 de croma representando uma
	exibição de uma parte do bitmap existente. O retângulo de recorte
	inicial é definido para os limites da exibição. |obose|.

	Na ausência das coordenadas, o novo bitmap representará uma
	visualização do retângulo do recorte atual do bitmap original. Caso
	as coordenadas sejam fornecidas, o novo bitmap representará uma
	exibição do retângulo com o canto superior esquerdo em
	(``x0``, ``y0``) e com o canto inferior direito em (``x1``, ``y1``)
	no bitmap original. As coordenadas estão em unidades de pixels. As
	coordenadas do canto inferior direito são inclusivas.

	O bitmap original deve ser de propriedade do *script* Lua e deve
	usar o formato ARGB. Gera um erro caso as coordenadas sejam
	especificadas representando um retângulo que não esteja totalmente
	contido dentro do recorte do retângulo do bitmap original.


**emu.bitmap_argb32.load(data)**

	|cbef| **ARGB** a partir de dados em formato PNG, JPEG (JFIF/EXIF)
	ou Microsoft DIB (BMP). |guec| os dados sejam inválidos ou caso o
	formato não seja compatível.


Métodos
~~~~~~~

**bitmap:cliprect()**

	Retorna as coordenadas esquerda, cima, direita e baixo do retângulo
	de recorte do bitmap. As coordenadas estão em unidades de pixels. As
	coordenadas baixo e direita são inclusivas.


**bitmap:reset()**

	Define a largura e a altura como zero e libera o armazenamento dos
	pixels caso o bitmap possua o seu próprio armazenamento ou libera o
	bitmap original se ele representar uma exibição de um outro bitmap.

	|obds|.


**bitmap:allocate(largura, altura, [xslop, yslop])**

	Reatribui o armazenamento para o bitmap, define a sua largura, a
	sua altura e ajusta o retângulo de recorte para a totalidade do
	bitmap. |cabij|; |sbiru|. O armazenamento do pixel será preenchido
	com o valor zero.

	|vidq|. |dvit|. |navi|. |qlam|.

	|obds|.


**bitmap:resize(largura, altura, [xslop, yslop])**

	Altera a largura, a altura e define o recorte do retângulo em todo o
	bitmap.

	|vidq|. |dvit|. |navi2|.

	Caso o bitmap já possua um armazenamento alocado e for grande o
	suficiente para o tamanho atualizado, ele será usado sem ser
	liberado; caso seja muito pequeno, este sempre será liberado e
	realocado. Se o bitmap representar uma exibição de um outro bitmap,
	o bitmap original será liberado. Quando o armazenamento do pixel for
	alocado, ele será preenchido com o valor zero (na utilização de
	um armazenamento já existente, o seu conteúdo não será alterado).

	|obds|.


**bitmap:wrap(source, [x0, y0, x1, y1])**

	Faz com que o bitmap represente uma visualização de uma parte de um
	outro bitmap e define o recorte do retângulo para os limites da
	visualização.

	|nacoo|. |cacoo|. |acee|. |acodc|.

	|obose|. |cabij|; |sbiru|.

	|obdes| e devem usar o mesmo formato de pixel. Gera um erro caso as
	coordenadas sejam definidas representando um retângulo que não
	esteja totalmente contido dentro do retângulo de recorte do bitmap
	original; caso o bitmap seja referenciado por um outro bitmap ou
	:ref:`textura <luascript-ref-rendertexture>`; ou caso a origem e o
	destino sejam o mesmo bitmap.


**bitmap:pix(x, y)**

	Retorna o valor da cor do pixel no local determinado. |ascoo|.


**bitmap:pixels([x0, y0, x1, y1])**

	Retorna os pixels, a largura e a altura da parte do bitmap |ccse|.
	|acee|. |acodc|. |nadao|.

	Os pixels retornam empacotados numa string binária na ordem
	*"Endian"* do host. Os pixels são organizados na ordem principal da
	linha, da esquerda para a direita e de cima para baixo. O tamanho e
	o formato dos valores do pixel dependem do formato do bitmap. |guec|
	forem especificadas coordenadas que representem um retângulo não
	totalmente contido no retângulo de recorte do bitmap.


**bitmap:fill(cor, [x0, y0, x1, y1])**

	Preenche uma parte do bitmap com o valor da cor especificada. Na
	ausência das coordenadas, o recorte do retângulo será preenchido;
	caso as coordenadas sejam fornecidas, a interseção do recorte do
	retângulo e do retângulo com canto superior esquerdo em
	(``x0``, ``y0``) e canto inferior direito em (``x1``, ``y1``) serão
	preenchidos. |acee|. |acodc|.


**bitmap:plot(x, y, cor)**

	Define o valor da cor do pixel no local especificado caso esteja
	dentro do recorte do retângulo. |ascoo|.


**bitmap:plot_box(x, y, largura, altura, cor)**

	Preenche a interseção do recorte do retângulo e o retângulo com o
	canto superior esquerdo (``x``, ``y``) e a altura e largura
	especificadas com o valor especificada da cor. As coordenadas e as
	dimensões estão em unidades de pixels.


Propriedades
~~~~~~~~~~~~

**bitmap.palette** |lees|

	A :ref:`paleta <luascript-ref-palette>` usada para traduzir os
	valores do pixel para cores. Aplicável apenas para bitmaps que
	utilizem formatos de pixel indexados.


**bitmap.width** |sole|

	Largura do bitmap em pixels.


**bitmap.height** |sole|

	Altura do bitmap em pixels.


**bitmap.rowpixels** |sole|

	Passo da linha do armazenamento do bitmap em pixels. Ou seja, a
	diferença na compensação dos pixels no mesmo local horizontal em
	linhas consecutivas. Pode ser maior que a largura.

**bitmap.rowbytes** |sole|

	Passo da linha do armazenamento do bitmap em bytes. Ou seja, a
	diferença em endereços de byte dos pixels na mesma localização
	horizontal das linhas consecutivas.


**bitmap.bpp** |sole|

	O tamanho do tipo usado para representar os pixels no bitmap em bits
	(pode ser maior que a quantidade de bits importantes).


**bitmap.valid** |sole|

	Um valor booleano que indica se o bitmap tem armazenamento
	disponível (pode ser *false* para bitmaps vazios).


**bitmap.locked** |sole|

	Um valor booleano que indica se o armazenamento do bitmap é
	referenciado por outro bitmap ou
	:ref:`textura <luascript-ref-rendertexture>`.


.. _luascript-ref-rendertexture:

Renderização da textura
-----------------------

|encaa| ``render_texture`` do MAME, representa a textura que pode ser
desenhada no :ref:`contêiner do renderizador
<luascript-ref-rendercontainer>`. As texturas renderizadas devem ser
liberadas antes que a emulação em andamento seja encerrada.


Instanciação
~~~~~~~~~~~~

**manager.machine.render:texture_alloc(bitmap)**

	Cria uma :ref:`textura <luascript-ref-rendertexture>` com base num
	:ref:`bitmap <luascript-ref-bitmap>`. |obdes| e deve usar o
	formato Y'CbCr, RGB ou ARGB. |obose|.


Métodos
~~~~~~~

**texture:free()**

	Libera a textura. O armazenamento do bitmap subjacente será
	liberado.


Propriedades
~~~~~~~~~~~~

**texture.valid** |sole|

	Um valor booleano que indica se a textura é válida (*false* no caso
	da textura ter sido liberada).


.. _luascript-ref-renderman:

Gerenciador do renderizador
---------------------------

|encaa| ``render_manager`` do MAME que é responsável pelo gerenciamento
do destino da renderização e das texturas.


Instanciação
~~~~~~~~~~~~

**manager.machine.render**

	Obtém a instância do gerenciador da renderização global para a
	sessão emulada.


Métodos
~~~~~~~

**render:texture_alloc(bitmap)**

	Cria uma :ref:`textura <luascript-ref-rendertexture>` com base num 
	:ref:`bitmap <luascript-ref-bitmap>`. |obdes| e deve usar o
	formato Y'CbCr, RGB ou ARGB. |obose|. As texturas renderizadas
	devem ser liberadas antes que a seção da emulação seja encerrada.


Propriedades
~~~~~~~~~~~~

**render.max_update_rate** |sole|

	A taxa de atualização máxima em Hertz. |eeun|.


**render.ui_target** |sole|

	O :ref:`alvo do renderizador <luascript-ref-rendertarget>` usado
	para desenhar a interface do usuário (incluindo os menus, os
	controles deslizantes e as mensagens de pop-up). Geralmente é a
	primeira janela ou a primeira tela do host.


**render.ui_container** |sole|


	O :ref:`contêiner do renderizador <luascript-ref-rendercontainer>`
	usado para desenhar a interface do usuário.


**render.targets[ ]** |sole|

	A lista da renderização dos alvos, incluindo as janelas e as telas
	geradas, bem como os alvos ocultos renderizados para coisas como a
	renderização das capturas da tela. Usa índices inteiros com base ``1``.
	O operador de índice e o método ``at`` têm O(n) complexidade.


.. _luascript-ref-rendertarget:

Alvo do renderizador
--------------------

|encaa| ``render_target`` do MAME que representa a saída de um canal de
vídeo. Pode ser uma janela, a tela do host ou um alvo oculto usado para
a renderização da captura da tela.


Instanciação
~~~~~~~~~~~~

**manager.machine.render.targets[índice]**

	Obtenha a renderização de um alvo por índice.


**manager.machine.render.ui_target**

	Obtenha a renderização de um alvo usado para exibir a interface do
	usuário (incluindo os menus, os controles deslizantes e as mensagens
	de pop-up). Geralmente é a primeira janela do host ou tela.


**manager.machine.video.snapshot_target**

	Obtém o destino de renderização usado para produzir instantâneos e
	gravações de vídeo.


Propriedades
~~~~~~~~~~~~

**target.ui_container** |sole|

	O :ref:`contêiner do renderizador <luascript-ref-rendercontainer>`
	para desenhar elementos da interface do usuário sobre este alvo de
	renderização ou ``nil`` para alvos ocultos de renderização
	(alvos que não são mostrados diretamente ao usuário).


**target.index** |sole|

	O índice do destino de renderização com base ``1``. Isso tem
	complexidade O(n).


**target.width** |sole|

	A geração da largura da renderização do alvo em pixels.  Este é um
	número inteiro.


**target.height** |sole|

	A geração da altura da renderização do alvo em pixels. Este é um
	número inteiro.


**target.pixel_aspect** |sole|

	A geração da renderização da proporção entre a largura e a altura
	dos pixels. Isto é um número de ponto flutuante.


**target.hidden** |sole|

	Um valor booleano que indica se este alvo é uma renderização interna
	que não é exibido diretamente para o usuário (por exemplo, o alvo da
	renderização usado para criar as capturas da tela).


**target.is_ui_target** |sole|

	Um valor booleano que indica se este é o destino de renderização
	usado para exibir a interface do usuário.


**target.max_update_rate** |lees|

	A taxa de atualização máxima para a renderização do alvo em Hertz.


**target.orientation** |lees|

	Os sinalizadores de orientação do alvo. Esta é uma máscara de bits
	inteira, onde o bit ``0`` (``0x01``) é definido para espelhar
	horizontalmente, o bit ``1`` (``0x02``) é definido para espelhar
	verticalmente e o bit ``2`` (``0x04``) é definido para espelhar ao
	longo do canto superior esquerdo inferior e a diagonal direita.

.. raw:: latex

	\clearpage


**target.view_names[ ]**

	Os nomes das visualizações disponíveis para a renderização deste
	alvo. Usa base ``1`` e índices inteiros.  Os métodos ``find`` e o
	``index_of`` têm O(n) complexidade; todas as outras operações
	compatíveis têm complexidade O(1).


**target.current_view** |sole|

	A visualização selecionada atualmente para o alvo renderizado. Isto
	é um objeto da :ref:`visualização do layout
	<luascript-ref-renderlayview>`.


**target.view_index** |lees|

	O índice base ``1`` da visualização selecionada para a renderização
	deste alvo.


**target.visibility_mask** |sole|

	Uma máscara de bits inteira indicando quais as coleções dos itens
	estão visíveis no momento da visualização atual.


**target.screen_overlay** |lees|

	Um valor booleano que indica se as sobreposições da tela estão
	ativadas.


**target.zoom_to_screen** |lees|

	Um valor booleano que indica se renderização do alvo está
	configurado para escalar fazendo com que as telas emuladas preencham
	toda a janela/tela o quanto for possível.


.. _luascript-ref-rendercontainer:

Contêiner do renderizador
-------------------------

|encaa| ``render_container``.


Instanciação
~~~~~~~~~~~~

**manager.machine.render.ui_container**

	Obtém o contêiner de renderização usado para desenhar a interface do
	usuário, incluindo menus, controles deslizantes e as mensagens de
	pop-up.


**manager.machine.render.targets[índice].ui_container**

	Obtém o contêiner de renderização usado para desenhar elementos da
	interface do usuário num determinado alvo de renderização.


**manager.machine.screens[tag].container**

	Obtém o contêiner de renderização usado para desenhar uma
	determinada tela.


Métodos
~~~~~~~

**container:draw_box(esquerda, cima, direita, baixo, [linha], [preenchimento])**

	Desenha um retângulo delineado com bordas nas posições indicadas.

	As coordenadas são números de ponto flutuante no intervalo entre
	``0`` (zero) até ``1`` (um), com (``0``, ``0``) na parte superior
	esquerda e (``1``, ``1``) na parte inferior direita da janela ou da
	tela que mostra a interface do usuário. Observe que a relação de
	aspecto geralmente não é quadrada. As coordenadas são limitadas à
	área da janela ou da tela.

	As cores de preenchimento e da linha estão no formato
	alfa/vermelho/verde/azul (ARGB). |osvalo|. Os valores dos canais das
	cores não são previamente multiplicados pelo valor alfa. Os valores
	dos canais devem ser empacotados em bytes de um inteiro com 32 bits
	sem assinatura na ordem alfa, vermelho, verde, azul do byte mais
	importante para o de menor importância. Caso a cor da linha não seja
	informada, é usada a cor do texto da interface; caso a cor de
	preenchimento não seja informada, é usada a cor de fundo da
	interface do usuário.


**container:draw_line(x0, y0, x1, y1, [cor])**

	Desenha uma linha a partir de (``x0``, ``y0``) até (``x1``, ``y1``).

	As coordenadas são números de ponto flutuante no intervalo entre
	``0`` (zero) até ``1`` (um), com (``0``, ``0``) na parte superior
	esquerda e (``1``, ``1``) na parte inferior direita da janela ou da
	tela que mostra a interface do usuário. Observe que a relação de
	aspecto geralmente não é quadrada.
	As coordenadas são limitadas à área da janela ou da tela.

	As coordenadas são números de ponto flutuante em unidades de pixels
	da tela emulada, com a origem em (``0``, ``0``). Observe que os
	pixels da tela emulada geralmente não são quadrados. O sistema de
	coordenadas é rotacionada caso a tela seja girada, o que geralmente
	é o caso para as telas no formato vertical. Antes da rotação, a
	origem está na parte superior esquerda e as coordenadas aumentam
	para a direita e para baixo.
	As coordenadas são limitadas à área da tela.

	A cor da linha está no formato alfa/vermelho/verde/azul (ARGB). Os
	valores dos canais estão no intervalo entre ``0`` (transparente ou
	desligado) e ``255`` (opaco ou com intensidade total). Os valores
	dos canais das cores não são previamente multiplicados pelo valor
	alfa. |osval|. Caso a cor da linha não seja informada, é usada a cor
	do texto da interface do usuário.


**container:draw_quad(textura, x0, y0, x1, y1, [cor])**

	Desenha um retângulo texturizado com o canto superior esquerdo em
	(``x0``, ``y0``) e o canto inferior direito em (``x1``, ``y1``).
	Caso uma cor seja especificada, os valores dos pixels da textura do
	canal ARGB são multiplicados pelos valores correspondentes da cor
	que foi especificada.

	As coordenadas são números de ponto flutuante na faixa entre ``0``
	(zero) até ``1`` (um) com (``0``, ``0``) na parte superior esquerda
	e (``1``, ``1``) na parte inferior direita da janela ou da tela que
	mostra a interface do usuário. Observe que a relação de aspecto
	geralmente não é quadrada. Caso o retângulo se estenda além dos
	limites do contêiner, este será recortado.

	A cor está no formato alfa/vermelho/verde/azul (ARGB). Os valores
	dos canais estão no intervalo entre ``0`` (transparente ou
	desligado) e ``255`` (opaco ou com intensidade total). Os valores
	dos canais das cores não são previamente multiplicados pelo valor
	alfa. |osval|.


**container:draw_text(x|justificativa, y, texto, [primeiro plano], [plano de fundo])**

	Desenha uma linha na posição definida. Se a tela for racionada o
	texto também será.

	Quando o primeiro argumento for um número, o texto será alinhado à
	esquerda nesta coordenada X. Quando o primeiro argumento for um
	texto, este deve ser ``"left"``, ``"center"`` ou ``"right"`` para
	que o texto seja desenhado e alinhado à esquerda/ao centro/à direita
	da janela ou da tela respectivamente. O segundo argumento define a
	coordenada Y da ascensão máxima do texto.

	As coordenadas são números de ponto flutuante no intervalo entre
	``0`` (zero) até ``1`` (um), com (``0``, ``0``) na parte superior
	esquerda e (``1``, ``1``) na parte inferior direita da janela ou da
	tela que mostra a interface do usuário. Observe que a relação de
	aspecto geralmente não é quadrada.
	As coordenadas são limitadas à área da janela ou da tela.

	As cores do primeiro plano e do plano de fundo estão no formato
	alfa/vermelho/verde/azul (ARGB). |osvalo|. Os valores dos canais da
	cor não são previamente multiplicados pelo valor alpha.
	Os valores do canal devem ser empacotados em bytes com 32 bits
	inteiros não assinados pelo valor do canal alfa, na ordem alpha,
	vermelho, verde, azul a partir do byte mais importante até o byte
	com menor importância. Caso a cor do primeiro plano não seja
	informado, a cor do texto da interface será usada; caso a cor de
	fundo não seja informada, a cor do fundo da interface será usada.


Propriedades
~~~~~~~~~~~~

**container.user_settings** |lees|

	A :ref:`configuração do usuário do contêiner
	<luascript-ref-rendercntnrsettings>`. Pode ser usado para controlar
	uma série de ajustes de imagem.


**container.orientation** |lees|

	Os sinalizadores de orientação do contêiner. Esta é uma máscara de
	bits inteira, onde o bit ``0`` (``0x01``) é definido para espelhar
	horizontalmente, o bit ``1`` (``0x02``) é definido para espelhar
	verticalmente e o bit ``2`` (``0x04``) é definido para espelhar ao
	longo do canto superior esquerdo inferior e a diagonal direita.


**container.xscale** |lees|

	O fator de escala X do contêiner. |eeun|.


**container.yscale** |lees|

	O fator de escala Y do contêiner. |eeun|.


**container.xoffset** |lees|

	O *offset* X do contêiner. |eeun| onde um (``1``) corresponde ao
	tamanho X do contêiner.


**container.yoffset** |lees|

	O *offset* Y do contêiner. |eeun| onde um (``1``) corresponde ao
	tamanho Y do contêiner.


**container.is_empty** |sole|

	Um valor booleano que indica se o contêiner não possui itens.


.. _luascript-ref-rendercntnrsettings:

Configurações do contêiner do usuário
-------------------------------------

|encaa| ``render_container::user_settings`` do MAME que representa os
ajustes da imagem aplicados a um
:ref:`contêiner do renderizador <luascript-ref-rendercontainer>`.


Instanciação
~~~~~~~~~~~~

**manager.machine.screens[tag].container**

	Obtém a renderização atual do contêiner usado para desenhar uma
	determinada tela.


Propriedades
~~~~~~~~~~~~

**settings.orientation** |lees|

	Os sinalizadores de orientação do contêiner. Esta é uma máscara de
	bits inteira, onde o bit ``0`` (``0x01``) é definido para espelhar
	horizontalmente, o bit ``1`` (``0x02``) é definido para espelhar
	verticalmente e o bit ``2`` (``0x04``) é definido para espelhar ao
	longo do canto superior esquerdo inferior e a diagonal direita.


**settings.brightness** |lees|

	O ajuste do brilho aplicado ao contêiner. |eeun|.


**settings.contrast** |lees|

	O ajuste do contraste aplicado ao contêiner. |eeun|.


**settings.gamma** |lees|

	O ajuste gama aplicado ao contêiner. |eeun|.


**settings.xscale** |lees|

	O fator de escala X do contêiner. |eeun|.


**settings.yscale** |lees|

	O fator de escala Y do contêiner. |eeun|.


**settings.xoffset** |lees|

	O *offset* X do contêiner. |eeun| onde um (``1``) representa o
	tamanho X do contêiner.


**settings.yoffset** |lees|

	O *offset* Y do contêiner. |eeun| onde um (``1``) representa o
	tamanho Y do contêiner.


.. _luascript-ref-renderlayfile:

Arquivo layout
--------------

|encaa| ``layout_file`` do MAME, faz a representação das visualizações
carregadas a partir de um :ref:`arquivo layout <layfile>` que pode ser
utilizado para uma renderização final.


Instanciação
~~~~~~~~~~~~

Um objeto do arquivo layout é fornecido ao seu *script* layout na
variável ``file``. Os objetos do arquivo layout não são instanciados
diretamente a partir dos *scripts* Lua.

Métodos
~~~~~~~

**layout:set_resolve_tags_callback(cb)**

	|dufp| realizar tarefas adicionais depois que o sistema emulado
	tenha finalizado a sua inicialização, quando as tags nas
	visualizações do layout tenham sido resolvidas e os manipuladores
	dos itens da visualização principal tenham sido configurados.
	A função não deve aceitar nenhum argumento.

	Use com ``nil`` para remover o |callback|.


Propriedades
~~~~~~~~~~~~

**layout.device** |sole|

	O dispositivo que fez com que o arquivo layout fosse carregado.
	Normalmente o dispositivo raiz do sistema no caso dos layouts
	externos.


**layout.views[ ]** |sole|

	As :ref:`visualizações do layout <luascript-ref-renderlayview>`
	criados a partir do arquivo layout.
	As visualizações são indexadas por nomes não qualificados (ou seja,
	o valor do atributo ``name``). As visualizações são ordenadas como
	aparecem no arquivo de layout ao iterar ou usar o método ``at``.
	Os métodos do índice obtém ``at`` e ``index_of`` com complexidade
	O(n).

	Observe que nem todas as visualizações no arquivo XML podem ser
	criadas. Por exemplo, as visualizações não são criadas se a
	referência das telas forem fornecidas pelos dispositivos do cartão
	do slot caso o os referidos dispositivos do cartão do slot não
	estiverem presentes no sistema.


.. _luascript-ref-renderlayview:

Visualização do layout
----------------------

|encaa| ``layout_view`` do MAME que representa uma visualização que pode
ser renderizada num determinado alvo. As visualizações são criadas a
partir dos arquivos layout, podem ser carregados a partir da arte
externa, interna do MAME ou gerada automaticamente com base nas telas do
sistema que está sendo emulado.


Instanciação
~~~~~~~~~~~~

**manager.machine.render.targets[índice].current_view**

	Obtém a visualização selecionada atualmente para renderizar um
	determinado alvo.


**file.views[nome]**

	Obtém a visualização de um determinado nome definido a partir de um
	:ref:`arquivo de layout <luascript-ref-renderlayfile>`. De maneira
	geral, é assim que um *script* de layout obtém as visualizações.


Métodos
~~~~~~~

**view:has_screen(tela)**

	|ubis| a tela está presente na visualização. Isso é verdadeiro para
	telas que estão presentes, mas não visíveis porque o usuário ocultou
	a coleção dos itens que pertencem à ela.


**view:set_prepare_items_callback(cb)**

	|dufp| realizar tarefas adicionais antes que os itens da
	visualização sejam adicionados na renderização do alvo em preparação
	para o desenho de um quadro de vídeo. A função não deve aceitar
	quaisquer argumentos. Use com ``nil`` para remover o |callback|.


**view:set_preload_callback(cb)**

	|dufp| realizar tarefas adicionais após pré-carregar a visualização
	dos itens visíveis. A função não deve aceitar quaisquer argumentos.
	Use com ``nil`` para remover o |callback|. Esta função pode ser
	invocada quando o usuário seleciona uma visualização ou torna a
	visualização do item de uma coleção visível. Ele pode ser invocado
	várias vezes para obter uma exibição, portanto, evite repetir
	tarefas dispendiosas.


**view:set_recomputed_callback(cb)**

	|dufp| realizar tarefas adicionais depois que as
	dimensões da visualizações tenham sido recomputadas.
	A função não deve aceitar quaisquer argumentos. Use com ``nil``
	para remover o |callback|.

	As coordenadas da visualização são recalculadas em vários eventos,
	incluindo a janela que estiver sendo redimensionada, entrando ou
	saindo do modo de tela inteira e alterando a configuração de zoom
	para região da tela.

**view:set_pointer_updated_callback(cb)**

	|dufp| receber notificações quando um ponteiro ingressar, se mover
	ou alterar os estados do botão na exibição. A função deve aceitar
	nove argumentos:

	* O tipo do ponteiro (``mouse``, ``pen``, ``touch`` ou ``unknown``).
	* A ID do ponteiro (um inteiro não negativo que não se alterará
	  durante a vida do ponteiro).
	* A ID do dispositivo para grupos de ponteiros para reconhecer
	  multitoque. (inteiro não negativo).
	* A posição horizontal nas coordenadas do layout.
	* A posição vertical nas coordenadas do layout.
	* Uma máscara de bits que representa os botões pressionados no
	  momento.
	* Uma máscara de bits que representa os botões que foram
	  pressionados nesta atualização.
	* Uma máscara de bits que representa os botões que foram liberados
	  nesta atualização.
	* A contagem de cliques (positivo para ações com clique simultâneo
	  ou negativo se um clique for transformado numa retenção (clicar e
	  manter) ou arraste (clicar e arrastar)).

	Invoque com ``nil`` para remover o |callback|.


.. raw:: latex

	\clearpage


**view:set_pointer_left_callback(cb)**

	|dufp| receber notificações quando um ponteiro deixar de
	ser visível normalmente. A função deve aceitar nove argumentos:

	* O tipo do ponteiro (``mouse``, ``pen``, ``touch`` ou ``unknown``).
	* A ID do ponteiro (um inteiro não negativo que não se alterará
	  durante a vida do ponteiro). A ID pode ser reutilizada para um
	  novo ponteiro após receber esta notificação.
	* A ID do dispositivo para grupos de ponteiros para reconhecer
	  multitoque. (inteiro não negativo).
	* A posição horizontal nas coordenadas do layout.
	* A posição vertical nas coordenadas do layout.
	* Uma máscara de bits que representa os botões que foram liberados
	  nesta atualização.
	* A contagem de cliques (positivo para ações com clique simultâneo
	  ou negativo se um clique for transformado numa retenção (clicar e
	  manter) ou arraste (clicar e arrastar)).

	Invoque com ``nil`` para remover o |callback|.


**view:set_pointer_aborted_callback(cb)**

	|dufp| receber notificações quando o ponteiro deixar de estar
	visível de maneira anormal. A função deve aceitar nove argumentos:

	* O tipo do ponteiro (``mouse``, ``pen``, ``touch`` ou ``unknown``).
	* A ID do ponteiro (um inteiro não negativo que não se alterará
	  durante a vida do ponteiro). A ID pode ser reutilizada para um
	  novo ponteiro após receber esta notificação.
	* A ID do dispositivo para grupos de ponteiros para reconhecer
	  multitoque. (inteiro não negativo).
	* A posição horizontal nas coordenadas do layout.
	* A posição vertical nas coordenadas do layout.
	* Uma máscara de bits que representa os botões que foram liberados
	  nesta atualização.
	* A contagem de cliques (positivo para ações com clique simultâneo
	  ou negativo se um clique for transformado numa retenção (clicar e
	  manter) ou arraste (clicar e arrastar)).

	Invoque com ``nil`` para remover o |callback|.


**view:set_forget_pointers_callback(cb)**

	|dufp| receber notificações quando a visualização deve parar de
	processar a entrada do ponteiro. Invoque com ``nil`` para remover o
	|callback|.

	Isso pode ocorrer em várias situações, por exemplo, quando ocorre a
	alteração da configuração da visualização ou a questão de um menu
	assumir o controle da entrada.


Propriedades
~~~~~~~~~~~~

**view.items[ ]** |sole|

	O elemento do layout e da tela de :ref:`visualização do item do
	layout <luascript-ref-renderlayitem>` numa visualização. Este
	contêiner não suporta iteração por chave usando ``pairs``; só é
	compatível a iteração através do índice usando ``ipairs``. A chave é
	o valor do atributo ``id``, caso esteja presente. Apenas itens com
	atributos ``id`` podem ser pesquisados através das chaves. O método
	index get tem complexidade O(1) e os métodos ``at`` e o ``index_of``
	têm complexidade O(n).


**view.name** |sole|

	Exibe o nome da visualização.
	Isso pode ser qualificado para indicar o dispositivo que causou o
	carregamento do :ref:`arquivo layout <layfile>`, quando não for o
	dispositivo raiz do sistema.


**view.unqualified_name** |sole|

	O nome não qualificado da visualização, exatamente como aparece no
	atributo ``name`` no arquivo layout.


**view.visible_screen_count** |sole|

	A quantidade dos itens nas telas que estão atualmente ativados na
	visualização.


**view.effective_aspect** |sole|

	A proporção efetiva entre a largura e a altura da visualização com a
	sua configuração atual.

.. raw:: latex

	\clearpage


**view.bounds** |sole|

	O :ref:`limites do renderizador <luascript-ref-renderbounds>` do
	objeto que representa os limites efetivos da visualização na sua
	configuração atual.
	As coordenadas estão em unidades de visualização, que são
	arbitrárias, porém assumidas como tendo uma proporção quadrada.


**view.has_art** |sole|

	Um valor booleano que indica se a visualização possui itens que não
	são da	tela, incluindo itens que não são visíveis porque o usuário
	ocultou a coleção dos itens aos quais elas pertencem.


**view.show_pointers** |lees|

	Um valor booleano que define se os ponteiros do mouse e da caneta
	devem ser exibidos na visualização.


**view.hide_inactive_pointers** |lees|

	Um valor booleano que define se os ponteiros do mouse devem ser
	ocultados na exibição após um período de inatividade.


.. _luascript-ref-renderlayitem:

Visualização do item do layout
------------------------------

|encaa| ``layout_view_item`` do MAME que representa um item numa
:ref:`visualização do layout <luascript-ref-renderlayview>`. Um item é
desenhado como uma superfície retangular texturizada. A textura é
fornecida por uma tela emulada ou um elemento do layout. Observe que as
chamadas de retorno dos itens de visualização do layout não são
executadas como corrotinas.


Instanciação
~~~~~~~~~~~~

**layout.views[name].items[id]**

	Obtém um item da visualização através do ID.
	O item deve ter um atributo ``id`` no arquivo layout para que possa
	ser pesquisado através do ID.


Métodos
~~~~~~~

**item:set_state(state)**

	Define o valor usado como o estado do elemento e o estado da
	animação na ausência dos vínculos. O argumento deve ser um número
	inteiro.


**item:set_element_state_callback(cb)**

	Define uma função a ser invocada para obter o estado do elemento
	para o item. A função não deve aceitar quaisquer argumentos e deve
	retornar um número inteiro.
	Use com ``nil`` para restaurar o estado original do |callback| do
	elemento (com base nos vínculos do arquivo layout).

	Observe que a função não deve acessar a propriedade
	``element_state`` do item, pois isso resultará numa repetição
	infinita. Este |callback| não será usado para obter o estado de
	animação para o item, mesmo se o item não tiver vínculos explícitos
	do estado de animação no arquivo layout.


**item:set_animation_state_callback(cb)**

	Define uma função que será invocada para obter o estado de animação
	do item. A função não deve aceitar quaisquer argumentos e deve
	retornar um número inteiro. Use com ``nil`` para restaurar o
	estado de animação original do |callback| (com base nos vínculos do
	arquivo layout).

	Observe que a função não deve acessar a propriedade
	``animation_state`` do item, pois isso resultará numa repetição
	infinita.


**item:set_bounds_callback(cb)**

	Define uma função que será invocada para obter os limites do item.
	A função não deve aceitar qualquer argumento e deve retornar um
	:ref:`limites do renderizador <luascript-ref-renderbounds>` do
	objeto nas coordenadas do alvo renderizado. Use com ``nil`` para
	restaurar o estado do limite original do |callback| (com base no
	estado da animação do item e nos elementos ``bounds`` herdados a
	partir do arquivo layout).

	Observe que a função não deve acessar a propriedade ``bounds`` do
	item, pois isso resultará numa repetição infinita.


**item:set_color_callback(cb)**

	Defina uma função que será invocada para obter a cor do
	multiplicador para o item. A função não deve aceitar qualquer
	argumento e deve retornar um objeto
	:ref:`renderização da cor <luascript-ref-rendercolor>`.
	Use com ``nil`` para restaurar a cor original do |callback|
	(com base no estado da animação do item e dos elementos ``color``
	herdados a partir do arquivo layout).

	Observe que a função não deve acessar a propriedade ``color`` do
	item, pois isso resultará numa repetição infinita.


**item:set_scroll_size_x_callback(cb)**

	Define uma função que será invocada para obter o tamanho da janela
	de rolagem horizontal como uma proporção da largura do elemento
	associado. A função não deve aceitar nenhum argumento e retornar um
	valor de ponto flutuante. Use com ``nil`` para restaurar o
	tamanho padrão da rolagem horizontal da janela (com base no
	elemento ``xscroll`` relacionado no arquivo de layout XML).

	Observe que a função não deve acessar a propriedade
	``scroll_size_x`` do item, pois isto resultará numa repetição
	infinita.


**item:set_scroll_size_y_callback(cb)**

	Define uma função que será invocada para obter o tamanho da janela
	de rolagem vertical como uma proporção da altura do elemento
	associado. A função não deve aceitar nenhum argumento e retornar um
	valor de ponto flutuante. Use com ``nil`` para restaurar o tamanho
	padrão da rolagem horizontal da janela (com base no elemento
	``yscroll`` relacionado no arquivo de layout XML).

	Observe que a função não deve acessar a propriedade
	``scroll_size_y`` do item, pois isto resultará numa repetição
	infinita.


**item:set_scroll_pos_x_callback(cb)**

	Define uma função que será invocada para obter a posição da rolagem
	horizontal. Um valor zero coloca a janela de rolagem horizontal na
	borda esquerda do elemento associado. Se o item não se enrola
	horizontalmente, um valor ``1.0`` posiciona a janela de rolagem
	horizontal na borda direita do elemento associado; se o item se
	enrola horizontalmente, um valor ``1.0`` corresponde ao enrolamento
	de retorno à borda esquerda do elemento associado. A função não deve
	aceitar nenhum argumento e deve retornar um valor de ponto
	flutuante. Use com ``nil`` para restaurar a posição padrão da
	rolagem horizontal (com base nas ligações no elemento relativo
	``xscroll`` no arquivo de layout XML).

	Observe que a função não deve acessar a propriedade
	``scroll_pos_x`` do item, pois isto resultará numa repetição
	infinita.


**item:set_scroll_pos_y_callback(cb)**

	Define uma função que será invocada para obter a posição da rolagem
	vertical. Um valor zero coloca a janela de rolagem vertical na
	borda superior do elemento associado. Se o item não se enrola
	verticalmente, um valor ``1.0`` posiciona a janela de rolagem
	vertical na borda de baixo do elemento associado; se o item se
	enrola verticalmente, um valor ``1.0`` corresponde ao enrolamento
	de retorno à borda esquerda do elemento associado. A função não deve
	aceitar nenhum argumento e deve retornar um valor de ponto
	flutuante. Use com ``nil`` para restaurar a posição padrão da
	rolagem horizontal (com base nas ligações no elemento relativo
	``yscroll`` no arquivo de layout XML).

	Observe que a função não deve acessar a propriedade
	``scroll_pos_y`` do item, pois isto resultará numa repetição
	infinita.


Propriedades
~~~~~~~~~~~~

**item.id** |sole|

	Obtenha o identificador opcional do item. Este é o valor do
	atributo ``id`` no arquivo layout, caso esteja presente ou ``nil``.


**item.bounds_animated** |sole|

	Um valor booleano que indica se os limites do item dependem de seu
	estado de animação.


**item.color_animated** |sole|

	Um valor booleano que indica se a cor do item depende de seu estado
	de animação.


**item.bounds** |sole|

	Os limites do item para o estado atual.
	Este é um
	:ref:`limitador do renderizador <luascript-ref-renderbounds>` do
	objeto nas coordenadas do alvo renderizado.


**item.color** |sole|

	A cor do item para o estado atual.
	A cor da tela ou da textura do elemento é multiplicada por esta cor.
	Este faz a :ref:`renderização da cor <luascript-ref-rendercolor>`
	do objeto.


**item.scroll_wrap_x** |sole|

	Um valor booleano indicando se o item se enrola horizontalmente.


**item.scroll_wrap_y** |sole|

	Um valor booleano indicando se o item se enrola verticalmente.


**item.scroll_size_x** |lees|

	Obtém o tamanho da janela de rolagem horizontal do item para a
	condição atual, ou configure o tamanho da janela de rolagem
	horizontal para usar na ausência de ligações. Este é um valor de
	ponto flutuante que representa uma proporção da largura do elemento
	associado.


**item.scroll_size_y** |lees|

	Obtém o tamanho da janela de rolagem vertical do item para a
	condição atual, ou configure o tamanho da janela de rolagem
	vertical para usar na ausência de ligações. Este é um valor de
	ponto flutuante que representa uma proporção da largura do elemento
	associado.


**item.scroll_pos_x** |lees|

	Obtém a posição de rolagem horizontal do item para a condição atual,
	ou defina o tamanho da posição de rolagem horizontal que deve ser
	usada na ausência das ligações. Este é um valor de ponto flutuante.


**item.scroll_pos_y** |lees|

	Obtém a posição de rolagem vertical do item para a condição
	atual, ou defina o tamanho da posição de rolagem vertical que deve
	ser usada na ausência das ligações.
	Este é um valor de ponto flutuante.


**item.blend_mode** |sole|

	Obtém modo de mesclagem do item.
	Este é um valor inteiro, onde ``0`` significa sem mesclagem, ``1``
	significa mesclagem alfa, ``2`` significa multiplicação por RGB,
	``3`` significa mesclagem aditiva e ``-1`` permite que os itens
	dentro de um contêiner determinem os seus próprios modos de
	mesclagem.


.. raw:: latex

	\clearpage


**item.orientation** |sole|

	Obtém os sinalizadores da orientação do item.
	Esta é uma máscara de bits inteira onde o bit ``0`` (``0x01``) é
	definido para espelhar horizontalmente, o bit ``1`` (``0x02``) é
	definido para espelhar verticalmente e o bit ``2`` (``0x04``) é
	definido para espelhar ao longo da diagonal superior esquerda e
	inferior direita.


**item.element_state** |sole|

	Obtenha o estado atual do elemento.
	Isso invocará a função |callback| do estado do elemento para lidar
	com os vínculos.


**item.animation_state** |sole|

	Obtém o estado atual da animação. Isso invocará a função |callback|
	do estado de animação do elemento para lidar com os vínculos.

.. |encaa| replace:: Encapsula a classe
.. |sole| replace:: (somente leitura)
.. |ubis| replace:: Retorna Um valor booleano indicando se
.. |dufp| replace:: Define uma função para
.. |lees| replace:: (leitura e escrita)
.. |acsre| replace:: As cores são representadas no formato
.. |osvalo| replace:: Os valores dos canais estão no intervalo entre
	``0`` (transparente ou desligado) até ``255`` (opaco ou com
	intensidade total)
.. |bcmi| replace:: byte menos importante
.. |noin| replace:: no índice com base zero
.. |aquan| replace:: a quantidade das cores na paleta menos um
.. |insej| replace:: índice seja maior ou igual à quantidade de cores da
	paleta
.. |espno| replace:: especificada no índice com base zero
.. |guec| replace:: Gera um erro caso
.. |eeun| replace:: Este é um número de ponto flutuante
.. |soes| replace:: (somente escrita)
.. |cbef| replace:: Cria um bitmap em formato
.. |navl| replace:: Na ausência dos valores de largura e de altura,
	estes valores são considerados como sendo zero
.. |navi2| replace:: Na ausência dos valores de inclinação ``X`` e ``Y``,
	assume-se que seus valores também sejam zero (as linhas serão
	armazenadas de forma contígua, a linha superior será colocada no
	início do armazenamento do bitmap)
.. |clsd| replace:: Caso a largura seja definida, é obrigatório que a
	altura também seja especificada
.. |vidq| replace:: Os valores de inclinação ``X`` e ``Y`` definem a
	quantidade do armazenamento extra em pixels para reservar cada linha
	à esquerda/direita e respectivamente a parte superior/inferior de
	cada coluna
.. |dvit| replace:: Ao definir o valor de inclinação ``X``, também é
	obrigatório definir um valor de inclinação ``Y``
.. |navi| replace:: Na ausência dos valores de inclinação ``X`` e ``Y``,
	assume-se que seus valores também sejam zero (o armazenamento será
	dimensionado para se ajustar ao conteúdo do bitmap)
.. |qlam| replace:: Quando a largura e/ou a altura for menor ou igual à
	zero, nenhum armazenamento será alocado, independentemente dos
	valores de inclinação ``X`` e ``Y``, assim como, ambos os valores
	para a largura e para a altura do bitmap serão definidos como zero 
.. |rird| replace:: O recorte inicial do retângulo é definido em todo o
	bitmap

.. |cprv| replace:: Cada pixel é representado por um valor inteiro de
.. |tbrm| replace:: Os três bytes restantes, do mais importante ao menos
	importante, são valores de 8 bit sem assinatura dos canais vermelho,
	verde e azul (valores maiores correspondem a intensidades mais
	altas)
.. |obose| replace:: O bitmap original será bloqueado, evitando o
	redimensionamento e a realocação
.. |cubi| replace:: Cria um bitmap indexado com 
.. |obds| replace:: O bitmap deve ser de propriedade do *script* Lua.
	Gera um erro caso o armazenamento do bitmap seja referenciado por um
	outro bitmap ou uma :ref:`textura <luascript-ref-rendertexture>`
.. |cabij| replace:: Caso o bitmap já possua um armazenamento alocado,
	ele sempre será liberado e realocado
.. |sbiru| replace:: se o bitmap representar uma visão de um outro
	bitmap, o bitmap original será liberado
	bitmap, o bitmap original será liberado
.. |nacoo| replace:: Na ausência das coordenadas, o novo bitmap
	representará uma visualização do retângulo do recorte atual do
	bitmap original
.. |cacoo| replace:: Caso as coordenadas sejam fornecidas, o novo bitmap
	representará uma visualização do retângulo com o canto superior
	esquerdo em (``x0``, ``y0``) e com o canto inferior direito em
	(``x1``, ``y1``) no bitmap original
.. |acee| replace:: As coordenadas estão em unidades de pixels
.. |acodc| replace:: As coordenadas do canto inferior direito são
	inclusivas
.. |ccse| replace:: com o canto superior esquerdo em (``x0``, ``y0``) e
	com o canto inferior direito em (``x1``, ``y1``)
.. |nadao| replace:: Na ausência das coordenadas, o retângulo do recorte
	do bitmap será usado
.. |obdes| replace:: O bitmap deve ser de propriedade do *script* Lua
.. |ascoo| replace:: As coordenadas nas unidades dos pixels têm base
	zero
.. |osval| replace:: Os valores dos canais devem ser empacotados em
	bytes de um inteiro com 32 bits sem assinatura na ordem alfa,
	vermelho, verde, azul do byte mais importante para o de menor
	importância.
.. |callback| replace:: retorno de chamada
