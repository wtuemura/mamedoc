Efeitos GLSL para \*nix, OS X e Windows
=======================================

Por predefinição, o MAME gera um sinal de vídeo puro, assim como seria
também no hardware original do arcade até o sinal chegar aos circuitos
que levam o sinal ao monitor CRT do arcade, com pequenas modificações na
saída (em geral, esticar a imagem do jogo de volta à proporção que se
teria num monitor CRT, geralmente na proporção 4:3), no geral isso
funciona bem, mas perde-se um pouco do fator nostalgia. Os monitores de
arcade, ainda que em perfeitas condições, nunca foram ideais pois devido
a sua natureza o monitor CRT distorciam a imagem original de maneira
a distorcerem significativamente a sua aparência final na tela.

Os monitores CRT dos arcades são uma experiência única na maneira que a
imagem é formada e apresentada na tela, imagem essa que os monitores de
LCD e até mesmo monitores CRT não possuem.

É aí então que que o GLSL entra em cena.

O filtro GLSL simula a maioria dos efeitos de vídeo que um monitor CRT
de arcade teria, fazendo com que o resultado visual seja muito mais
realista. Porém, os filtros GLSL exigem um esforço extra dos recursos do
seu computador e em especial do monitor que você estiver usando.
Além disso, havia centenas de milhares de tipos monitores diferentes nos
fliperamas. Cada um foi ajustado e mantido de forma diferente, o que
significa que, não tem como escolher e definir entre todos eles, apenas
um como referência. Diretrizes básicas serão fornecidas aqui para
ajudá-lo, mas você também poderá pedir mais opiniões em qualquer um dos
fóruns conhecidos sobre o MAME espalhados pela internet.


Resolução e relação de aspecto da tela
--------------------------------------


A resolução é um assunto muito importante para as configurações do GLSL.
Você desejará que o MAME esteja usando a resolução nativa do seu monitor
para evitar distorções e atrasos adicionais criados pelo seu monitor ao
tentar preencher a imagem na tela.

Enquanto a maioria das máquinas de arcade usava um monitor com proporção
de tela no formato 4:3 (ou 3:4 se o monitor estivesse orientado
verticalmente como é no caso do Pac Man), a essa altura do campeonato é
difícil encontrar nos dias de hoje um monitor ou TV que tenha uma
proporção de tela no formato 4:3. A boa notícia é que esse espaço extra
que sobra nas laterais não é desperdiçado. Muitos gabinetes de arcade na
época utilizavam uma moldura com ilustrações ao redor da tela, caso você
tenha esses arquivos o MAME também irá exibir essas ilustrações na tela.
Para se obter um melhor resultado, ative o visualizador de ilustrações e
selecione o modo recortado ou cropped em Inglês.

Alguns monitores de LCD mais antigos usavam uma resolução nativa de
1280x1024 onde tinham uma proporção de tela no formato 5:4.
Neste exemplo, não há muito espaço extra suficiente para exibir a
ilustração e você vai notar um leve esticamento vertical, porém os
resultados ainda serão bons o suficiente, como se fossem um monitor com
formato 4:3.


Introdução ao GLSL
------------------

Antes de começar, você precisará seguir as instruções de configuração
inicial do MAME encontrada em outra parte deste manual.
As distribuições oficiais do MAME já são compatíveis com o GLSL, mas
**NÃO** incluem os arquivos de sombreamento GLSL. Você precisará obter
esses arquivos de sombreamento através de um outro fornecedor qualquer
pela internet.

Abra o seu ``mame.ini`` no seu editor de texto preferido como o bloco de
notas por exemplo e verifique se as seguintes opções estão definidas
corretamente:

* **video opengl**
* **filter 0**

O primeiro é necessário pois o GLSL requer suporte ao OpenGL. Já o
último desliga os filtros extras que possam interferir com a saída GLSL.

Por último, resta uma edição a mais para ativar o GLSL:

* **gl_glsl 1**

Salve o arquivo ``.ini`` e já estamos pronto para começar.


Customizando as configurações GLSL de dentro do MAME
----------------------------------------------------

Por vários motivos complicados de explicar, as configurações GLSL não
são mais salvas quando você sai do MAME. Isso significa que apesar das
configurações exigirem um pouco mais de trabalho de sua parte, os
resultados sempre sairão conforme esperado.

Comece rodando o MAME com o jogo de sua preferência como por exemplo
**mame pacman**.

Use a tecla til (**~**) [1]_ para chamar a tela de opções que vai
aparecer na parte de baixo da tela. Use as teclas cima e baixo para
navegar dentre as várias opções, enquanto as teclas esquerda e direita
irão permitir que você altere o valor dessas opções. Os resultados
aparecerão em tempo real conforme elas forem sendo alteradas.

Depois de encontrar as configurações desejadas, anote os números em um
bloco de notas e saia do MAME.


Alterando as configurações
--------------------------

Como descrito em :ref:`advanced-multi-CFG`, o MAME segue uma sequência
na hora de processar os arquivos ``.ini``. As configurações GLSL podem
ser editadas diretamente no arquivo ``mame.ini``, porém para tirar melhor
proveito do poder dos arquivos de configuração do MAME, talvez seja
melhor copiar as opções do GLSL do ``mame.ini`` para um outro arquivo de
configuração e fazer as modificações lá.

Por exemplo, uma vez que você encontrou configurações de GLSL que acha
que são apropriadas para os jogos de Neo-Geo, você pode colocar essas
configurações num arquivo ``neogeo.ini`` para que todos os jogos de
Neo-Geo usem essas configurações sem que você tenha que adicioná-las
manualmente uma a uma em diferentes arquivos ``.ini`` como o nome do
jogo.


Alterando as configurações
--------------------------

| **gl_glsl**
|
| 	Caso o valor seja **1** ativa o GLSL, desativa se for definido como **0**. O valor predefinido é **0**.
|
| **gl_glsl_filter**
|
| 	Ativa o filtro na saída do GLSL. Reduz o serrilhado no contorno da imagem,  essa opção deixa a imagem um pouco suavizada.
|
| **glsl_shader_mame0**
|         ...
| **glsl_shader_mame9**
|
| 	Especifica quais dos sombreadores usar, na ordem entre **0** a **9**. Se informe com o autor do seu pacote de sombreadores para saber em que ordem rodar primeiro para obter o melhor efeito.
|
| **glsl_shader_screen0**
|         ...
| **glsl_shader_screen9**
|
| 	Determina em qual tela aplicar os efeitos.
|

.. [1]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
