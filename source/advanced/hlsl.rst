
.. raw:: latex

	\clearpage

Os efeitos HLSL para Windows
============================

Por predefinição, o MAME gera um sinal de vídeo puro, assim como seria
também no hardware original do arcade até o sinal chegar aos circuitos
que levam ao monitor CRT do arcade, com pequenas modificações na saída
(em geral, esticar a imagem do jogo de volta à proporção que se teria
num monitor CRT, geralmente na proporção 4:3), no geral isso funciona
bem, mas perde-se um pouco do fator nostalgia. Os monitores de arcade,
ainda que em perfeitas condições, nunca foram ideais pois devido a sua
natureza o monitor CRT distorciam a imagem original de maneira a
distorcerem significativamente a sua aparência final na tela.

Os monitores CRT dos arcades são uma experiência única na maneira que a
imagem é formada e apresentada na tela, imagem essa que os monitores de
LCD e até mesmo monitores CRT não possuem.

É aí então que que o hlsl entra em cena.

O filtro hlsl simula a maioria dos efeitos de vídeo que um monitor CRT
de arcade teria, fazendo com que o resultado visual seja muito mais
realista. Porém, os filtros hlsl exigem um esforço extra dos recursos do
seu computador e em especial do monitor que você estiver usando.
Além disso, havia centenas de milhares de tipos monitores diferentes nos
fliperamas. Cada um foi ajustado e mantido de forma diferente, o que
significa que, não tem como escolher e definir entre todos eles, apenas
um como referência. Diretrizes básicas serão fornecidas aqui para
ajudá-lo, mas você também poderá pedir mais opiniões em qualquer um dos
fóruns conhecidos sobre o MAME espalhados pela internet.


Resolução e relação de aspecto da tela
--------------------------------------


A resolução é um assunto muito importante para as configurações do hlsl.
Você desejará que o MAME esteja usando a resolução nativa do seu monitor
para evitar distorções e atrasos adicionais criados pelo seu monitor ao
tentar preencher a imagem na tela.

Enquanto a maioria das máquinas de arcade usava um monitor com proporção
de tela no formato 4:3 (ou 3:4 se o monitor estivesse orientado
verticalmente como é no caso do **Pac Man**), a essa altura do
campeonato é difícil encontrar nos dias de hoje um monitor ou TV que
tenha uma proporção de tela no formato 4:3.

A boa notícia é que esse espaço extra que sobra nas laterais não é
desperdiçado. Muitos gabinetes de arcade na época utilizavam uma moldura
com ilustrações ao redor da tela, caso você tenha esses arquivos o MAME
também irá exibir essas ilustrações na tela. Para se obter um melhor
resultado, ative o visualizador de ilustrações e selecione o modo
recortado [1]_.

Alguns monitores de LCD mais antigos usavam uma resolução nativa de
1280x1024 onde tinham uma proporção de tela no formato 5:4.
Neste exemplo, não há muito espaço extra suficiente para exibir a
ilustração e você vai notar um leve esticamento vertical, porém os
resultados ainda serão bons o suficiente, como se fossem um monitor com
formato 4:3.

.. raw:: latex

	\clearpage

Introdução ao HLSL
------------------

Antes de começar, você precisará seguir as instruções de configuração
inicial do MAME encontrada em outra parte deste manual.
As distribuições oficiais do MAME já incluem o hlsl, então você não
precisa baixar nenhum outro arquivo adicional.

Abra o seu ``mame.ini`` no seu editor de texto preferido como o bloco de
notas por exemplo e verifique se as seguintes opções estão definidas
corretamente:

	* **video d3d**
	* **filter 0**

O primeiro é necessário porque hlsl requer suporte do Direct3D. O último
desliga filtro extras que possam interferir com a saída hlsl.

Por último, uma edição a mais para ativar o hlsl:

	* **hlsl_enable 1**

Salve o arquivo ``.ini`` e você está pronto para começar.


Várias predefinições foram incluídas na pasta ``ini`` junto com o MAME,
permitindo um bom ponto de partida para as configurações iniciais de
tela para os consoles **Nintendo Game Boy**, **Nintendo Game Boy
Advance**, **Rasterizado** e **Vetorizado**.


Customizando as configurações HLSL dentro MAME
----------------------------------------------

Por vários motivos complicados de explicar, as configurações hlsl não
são mais salvas quando você sai do MAME. Isso significa que apesar das
configurações exigirem um pouco mais de trabalho de sua parte, os
resultados sempre sairão conforme esperado.

Comece rodando o MAME com o jogo de sua preferência como por exemplo
**mame pacman**.

Use a tecla til (**~**) [2]_ para chamar a tela de opções que vai
aparecer na parte de baixo da tela. Use as teclas cima e baixo para
navegar dentre as várias opções, enquanto as teclas esquerda e direita
irão permitir que você altere o valor dessas opções. Os resultados
aparecerão em tempo real conforme elas forem sendo alteradas.

Depois de encontrar as configurações desejadas, anote os números em um
bloco de notas e saia do MAME.


Alterando as configurações
--------------------------

Como descrito em :ref:`advanced-multi-CFG`, o MAME segue uma sequência
na hora de processar os arquivos ``.ini``. As configurações hlsl podem
ser editadas diretamente no arquivo ``mame.ini``, porém para tirar melhor
proveito do poder dos arquivos de configuração do MAME, talvez seja
melhor copiar as opções do hlsl do ``mame.ini`` para um outro arquivo de
configuração e fazer as modificações lá.

Por exemplo, uma vez que você encontrou configurações de hlsl que acha
que são apropriadas para os jogos de Neo-Geo, você pode colocar essas
configurações num arquivo ``neogeo.ini`` para que todos os jogos de Neo-Geo
usem essas configurações sem que você tenha que adicioná-las manualmente
uma a uma em diferentes arquivos ``.ini`` como o nome do jogo.


Alterando as configurações
--------------------------

**hlslpath**

	Seus arquivos de sombreamento hlsl são armazenados aqui.
	Por definição o nome desta pasta é **hlsl** fica na pasta raiz do
	MAME.

**hlsl_snap_width**

	Define a **largura** que as capturas de tela hlsl terão (Alt+F12).

**hlsl_snap_height**

	Define a **altura** que as capturas de tela hlsl terão (Alt+F12).

**shadow_mask_alpha**

	Define a intensidade que o efeito de sombra da máscara terá. O
	intervalo aceitável vai de **0** a **1**, onde **0** não exibe
	nenhum efeito de sombra da máscara, **1** a mascara será
	completamente opaca e **0.5** será **50%** transparente.

**shadow_mask_tile_mode** (*Máscara de Sombra em Modo Ladrilhado*)

	Define se a máscara de sombra deve ser lado a lado com base na
	resolução de tela do seu monitor ou com base na resolução de origem
	do sistema emulado. Os valores válidos são entre **0** para modo de
	tela *Screen* e **1** para modo de origem *Source*. ::

		shadow_mask_texture
		shadow_mask_x_count (Quantidade X de Pixels Máscara de Sombra)
		shadow_mask_y_count (Quantidade Y de Pixels Máscara de Sombra)
		shadow_mask_usize (Tamanho U da Máscara de Sombra)
		shadow_mask_vsize (Tamanho V da Máscara de Sombra)
		shadow_mask_x_count (Deslocamento U da Máscara de Sombra)
		shadow_mask_y_count (Deslocamento V da Máscara de Sombra)

	Essas configurações devem estar em harmonia entre si. As regras
	**shadow_mask_texture** em particular, definem as regras de como
	você deve configurar as outras opções.

**shadow_mask_texture**

	Configura a textura do efeito de máscara de sombra. O MAME vem com
	três máscaras de sombra:

	* ``aperture-grille.png``

	* ``shadow-mask.png``

	* ``slot-mask.png``

**shadow_mask_usize** e **shadow_mask_vsize**

	definem o tamanho a ser usado pela textura do efeito
	**shadow_mask_texture** em valores de porcentagem, começando pelo
	canto superior esquerdo.

	Isso significa que, para uma textura com o tamanho real com pixels
	de 24x24 e um tamanho de u/v com **0.5,0.5**, serão usados **12x12**
	pixels no canto superior esquerdo.

	Lembre-se de definir um tamanho de u/v que possibilite organizar a
	textura lado a lado sem lacunas ou falhas. **0.5,0.5** é bom para
	qualquer uma das textura de máscara de sombra que estão inclusas no
	MAME.

	**shadow_mask_x_count** e **shadow_mask_y_count**

	Definem quantos pixels devem ser usados na tela para exibir o
	tamanho u/v da textura. Caso use o exemplo acima e configurar a
	quantidade textura x/y em uma proporção de **12,12** pixels, ela
	será exibida com uma proporção **1:1** na tela.
	
	Caso defina a quantidade da textura x/y em proporção **24,24** ela
	será exibida duas vezes maior.

	Exemplos de configuração para ``shadow_mask.png``: ::

		shadow_mask_texture shadow-mask.png
		shadow_mask_x_count 12
		shadow_mask_y_count 6 ou 12
		shadow_mask_usize 0.5
		shadow_mask_vsize 0.5

	Exemplos de configuração para ``slot-mask.png``: ::

		shadow_mask_texture slot-mask.png
		shadow_mask_x_count 12
		shadow_mask_y_count 8 ou 16
		shadow_mask_usize 0.5
		shadow_mask_vsize 0.5

	Exemplos de configuração para ``aperture-grille``: ::

		shadow_mask_texture aperture-grille.png
		shadow_mask_x_count 12
		shadow_mask_y_count 12 ou outro qualquer
		shadow_mask_usize 0.5
		shadow_mask_vsize 0.5

**shadow_mask_uoffset** e **shadow_mask_voffset**

	Podem ser usados para customizar o alcance do alinhamento final da
	máscara de sombreamento a nível de subpixel. O intervalo aceitável
	vai de **-1.00** até **1.00**, onde **0.5** move a máscara de
	sombreamento em **50%** com relação ao tamanho u/v da textura.

**distortion**

	Define a intensidade da distorção quadrática da imagem na tela.

**cubic_distortion**

	Define a intensidade da distorção cúbica da imagem na tela.

	Os fatores de distorção em ambos podem ser negativos para que um
	seja compensado pelo outro, por exemplo, *distortion* **0.5** e
	*cubic_distortion* **-0.5**.

**distort_corner**

	Define a intensidade de distorção dos cantos da tela, o que não
	afeta a distorção da imagem na tela em si.

 **round_corner**

	Define a intensidade de arredondamento dos cantos da tela.

**smooth_border**

	Define a intensidade de suavização e desfoque das bordas da tela.

**reflection** (*Intensidade de Reflexo*)

	Se configurado com um valor acima de **0**, cria um efeito de um
	reflexo em formato de mancha esbranquiçada na tela.
	É predefinido que a mancha seja colocada no canto superior direito
	da tela.

	Editando o arquivo ``POST.FX`` na seção **GetSpotAddend**, você
	poderá alterar essa posição.

		Os valores entre **0.00** até **1.00** ajustam a intensidade do
		efeito.

**vignetting**

	Se configurado com um valor acima de **0**, incrementa o efeito
	vinheta nos cantos da tela com um pseudo efeito 3D.

		Os valores entre **0.00** até **1.00** ajustam a intensidade do
		efeito.

**scanline_alpha**

	Determina a intensidade do efeito de linhas de escaneamento dos
	monitores CRT na tela. O intervalo aceitável fica entre **0** e
	**1**, onde **0** não exibe nenhum efeito, **1** seria uma linha de
	escaneamento totalmente preta e **0.5** exibe 50% de transparência.
	
	Observe que na tela dos monitores arcade as linhas de escaneamento
	não são completamente pretas.

**scanline_size**

	Define o espaçamento total das linhas de escaneamento da tela.
	Se configurado como **1**, mostra uma consistente alternância de
	espaço entre as linhas da tela e as linhas de escaneamento.

**scanline_height**

	Define o tamanho total de cada linha individual de escaneamento.
	Se configurando com um valor menor que **1**, faz com que as linhas
	fiquem mais finas, maiores que **1** as deixam mais grossas.

**scanline_variation**

	Define a variação do tamanho de cada linha de escaneamento,
	dependendo do seu brilho. As linhas de escaneamento mais claras
	ficarão mais finas em comparação com as mais escuras.

	Os valores ficam entre **0** e **2.0**, onde o valor predefinido é
	**1.0**. Se definido como **0.0**, todas as linhas de escaneamento
	ficam com o mesmo tamanho, independente do seu brilho.

**scanline_bright_scale**

	Define a escala de brilho que a linha de escaneamento terá.

	Valores maiores que **1** faz com que elas fiquem mais clara,
	valores menores as deixam mais escuras. Se definido como **0**, faz
	desaparecer todas as linhas de escaneamento.

**scanline_bright_offset**

	Define o deslocamento do brilho/saturação das linhas de
	escaneamento, suavizando e deixando mais lisa a parte de cima e de
	baixo de cada linha de escaneamento.

**scanline_jitter**

	Define a intensidade de oscilação ou tremulação das linhas de
	escaneamento na tela do monitor.
	
	Alerta: Valores muitos altos podem irritar seus olhos.

**hum_bar_alpha**

	Define a intensidade do efeito de interferência vertical.

**defocus**

	Define a intensidade de desfoque na tela borrando os pixels
	individualmente como as bordas de um monitor velho. Especifique com
	valores *X,Y* (**defocus 1,1** por exemplo).

Os valores abaixo ajustam a convergência dos canais vermelho, verde e
azul para uma determinada direção simulando um monitor velho, muitos
monitores mal cuidados tem uma péssima convergência causando um efeito
fantasma devido ao vazamento de cores que ficam fora do eixo do
sprite.

	* **converge_x** (*Convergência Linear X, RGB*)

	* **converge_y** (*Convergência Linear Y, RGB*)

	* **radial_converge_x** (*Convergência Radial X, RGB*)

	* **radial_converge_y** (*Convergência Radial Y, RGB*)

Os valores abaixo definem a matriz 3x3 que será multiplicado junto com
os sinais RGB para simular a proporção de interferência em cada
canal de cor.

Por exemplo, o sinal verde com (**0.100, 1.000, 0.250**) é **10%**
mais fraco que o sinal vermelho e **25%** mais forte no sinal
azul.

	* **red_ratio** (*Proporção de sinal RGB Vermelho*)

	* **grn_ratio** (*Proporção de sinal RGB Verde*)

	* **blu_ratio** (*Proporção de sinal RGB Azul*)

**offset**

	Fortalece ou enfraquece a intensidade do deslocamento do sinal em
	uma determinada cor. Por exemplo, o sinal vermelho com um valor
	**0.5** com um desvio/deslocamento de **0.2** será intensificado
	para **0.7**.

**scale**

	Aplica uma escala ao valor da cor do sinal atual.
	Por exemplo, o sinal vermelho com um valor de **0.5** com uma escala
	**1.1**, resultará num sinal de vermelho com **0.55**

**power**

	Define um valor expoente da cor do sinal atual, também conhecido
	como gama. O gama é o valor relativo entre o claro e o escuro de
	uma imagem.
	Por exemplo, o sinal vermelho com um valor de **0.5** e com
	**power** valor **2** no vermelho, resulta um sinal de vermelho com
	**0.25**.

	Em jogos com vetores, essa configuração também pode ser usada para
	ajudar a espessura dessas linhas.

**floor**

	Define o valor do piso do sinal RGB, é o valor mínimo absoluto para
	um sinal de cor.
	Por exemplo, o sinal vermelho com um valor de **0.0** (ausência
	total do sinal vermelho) com o sinal vermelho com piso de **0.2**,
	resulta num sinal vermelho com valor **0.2**.

	Normalmente usado em conjunto com a ilustração ativada para fazer a
	tela ter um brilho da trama mais fraca.

**phosphor_life**

	Define o tempo de vida útil do fósforo das telas CRT, dando um
	efeito de envelhecimento na cor do sinal e de fantasma na tela.
	
	O valor **0** não produz nenhum efeito fantasma, enquanto o valor 1
	deixa um rastro para trás que só volta a ser alterado por sinal de
	cor de maior valor.

	Isso também afeta bastante os jogos vetoriais.

**saturation**

	Define a intensidade de saturação de cor.

.. raw:: latex

	\clearpage

**bloom_blend_mode**

	Define a intensidade da mistura do efeito lume [3]_.
	Os valores ficam entre **0** para um efeito mais *Claro* e **1**
	para um tipo mais *Escuro*, essa última só é útil com monitores do
	tipo STN LCD. 

**bloom_scale**

	Determina a escala da intensidade do efeito lume.
	Os monitores CRT dos arcades tem uma tendência a ter esse efeito
	naturalmente, onde as cores mais claras se misturam com os pixels
	que ficam ao redor. Este efeito utiliza mais recursos da sua placa
	de vídeo, deixe em **0** para desabilitar e economizar recursos de
	processamento da sua GPU.
	

**bloom_overdrive**

	Determina o nível de saturação do branco do efeito lume, os valores
	RGB são separados por vírgula. Muito útil em jogos com tramas
	coloridas, LCD colorido ou jogos vetorizados coloridos.

	* **bloom_lvl0_weight** (*Escala do Nível do Bloom 0*)
	* **bloom_lvl1_weight** (*Escala do Nível do Bloom 1*)
	* .  .  .  .
	* **bloom_lvl7_weight** (*Escala do Nível do Bloom 7*)
	* **bloom_lvl8_weight** (*Escala do Nível do Bloom 8*)

	Define o nível de intensidade do efeito lume.
	Os valores ficam entre **0.00** até **1.00**. Se for usado da
	maneira correta em conjunto com o **phosphor_life** o efeito de
	brilho/fantasma enquanto os objetos se movem na tela será
	aprimorado.

**hlsl_write**

	Defina como **1** para habilitar a gravação dos efeitos hlsl junto
	com a :ref:`gravação do vídeo <mame-commandline-aviwrite>`.

		O valor predefinido é desligado ou **0**. 


Estes são as predefinições sugeridos para os jogos rasterizados:

+------------------------------+-------------------------+---------------------------+
| | bloom_lvl0_weight    1.00  | | Peso 0 do Nível Bloom | | Tamanho Máximo.         |
| | bloom_lvl1_weight    0.64  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 0 |
| | bloom_lvl2_weight    0.32  | | Peso 2 do Nível Bloom | | 1/4 menor que o nível 1 |
| | bloom_lvl3_weight    0.16  | | Peso 3 do Nível Bloom | | 1/4 menor que o nível 2 |
| | bloom_lvl4_weight    0.08  | | Peso 4 do Nível Bloom | | 1/4 menor que o nível 3 |
| | bloom_lvl5_weight    0.06  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 4 |
| | bloom_lvl6_weight    0.04  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 5 |
| | bloom_lvl7_weight    0.02  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 6 |
| | bloom_lvl8_weight    0.01  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 7 |
+------------------------------+-------------------------+---------------------------+

.. raw:: latex

	\clearpage

Jogos vetorizados
-----------------

Os efeitos HLSL também podem ser usados com jogos vetorizados. Devido a
uma grande variedade de opções para a configuração individual de jogos
vetoriais, é altamente recomendável que você os adicione em arquivos INI
individuais jogo a jogo (``tempest.ini`` por exemplo).

As máscaras de sombreamento só estão disponíveis em jogos vetoriais e
não devem ser usados em jogos vetoriais monocromáticos. Além disso, os
jogos de vetoriais não usavam linhas de varredura, de modo que também
devem ser desativados.

Abra o seu arquivo ``.ini`` no seu editor de texto preferido (o Bloco de
notas por exemplo) e verifique se as seguintes opções estão configuradas
corretamente:

	* **video d3d**
	* **filter 0**
	* **hlsl_enable 1**

Nas Opções Principais de Vetores:

	* **beam_width_min 1.0** (*Feixe Com o Máximo de*)
	* **beam_width_max 1.0** (*Feixe Com o Mínimo de*)
	* **beam_intensity_weight 0.0** (*Altura da Intensidade do Feixe*)
	* **flicker 0.0** (*Vector Flicker*)

Na Seção das Opções de Pós Processamento de Vetores:

	* **vector_beam_smooth 0.0** (*Intensidade de Suavização do Feixe do
	  Vetor*)
	* **vector_length_scale 0.5** (*Atenuação Máxima do Vetor*)
	* **vector_length_ratio 0.5** (*Extensão Mínima de Atenuação do Vetor*)

Valores sugeridos para jogos vetoriais:

	* **bloom_scale** o valor dever ser maior em jogos vetoriais do que os
	  jogos rasterizados. Para obter um melhor efeito, tente valores entre
	  0.4 e 1.0.
	* **bloom_overdrive** só deve ser usado em com jogos vetoriais
	  coloridos.

	* **bloom_lvl_weights** deve ser configurado como mostrado abaixo:

+------------------------------+-------------------------+---------------------------+
| | bloom_lvl0_weight    1.00  | | Peso 0 do Nível Bloom | | Tamanho Máximo.         |
| | bloom_lvl1_weight    0.48  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 0 |
| | bloom_lvl2_weight    0.32  | | Peso 2 do Nível Bloom | | 1/4 menor que o nível 1 |
| | bloom_lvl3_weight    0.24  | | Peso 3 do Nível Bloom | | 1/4 menor que o nível 2 |
| | bloom_lvl4_weight    0.16  | | Peso 4 do Nível Bloom | | 1/4 menor que o nível 3 |
| | bloom_lvl5_weight    0.24  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 4 |
| | bloom_lvl6_weight    0.32  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 5 |
| | bloom_lvl7_weight    0.48  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 6 |
| | bloom_lvl8_weight    0.64  | | Peso 1 do Nível Bloom | | 1/4 menor que o nível 7 |
+------------------------------+-------------------------+---------------------------+

.. [1]	Cropped do Inglês. (Nota do tradutor)
.. [2]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
.. [3]	Lume significa clarão de luz, luz forte, o efeito é muito
		semelhante a uma névoa ou neblina.
