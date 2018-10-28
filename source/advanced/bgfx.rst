Efeitos BGFX para (quase) todo mundo
====================================

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

É aí então que entra em cena os novos processamentos BGFX com HLSL.

O filtro HLSL simula a maioria dos efeitos de vídeo que um monitor CRT
de arcade teria, fazendo com que o resultado visual seja muito mais
realista. Porém, os filtros HLSL exigem um esforço extra dos recursos do
seu computador e em especial do monitor que você estiver usando.
Além disso, havia centenas de milhares de tipos monitores diferentes nos
fliperamas. Cada um foi ajustado e mantido de forma diferente, o que
significa que, não tem como escolher e definir entre todos eles, apenas
um como referência. Diretrizes básicas serão fornecidas aqui para
ajudá-lo, mas você também poderá pedir mais opiniões em qualquer um dos
fóruns conhecidos sobre o MAME espalhados pela internet.


Resolução e relação de aspecto da tela
--------------------------------------


A resolução é um assunto muito importante para as configurações do HLSL.
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


Introdução ao BGFX
------------------

Antes de começar, você precisará seguir as instruções de configuração
inicial do MAME encontrada em outra parte deste manual.
As distribuições oficiais do MAME à partir da versão 0.172 já incluem o
BGFX, então você não precisa baixar nenhum outro arquivo adicional.

Abra o seu MAME.INI no seu editor de texto preferido como o bloco de
notas por exemplo e verifique se as seguintes opções estão definidas
corretamente:

* **video bgfx**

Agora tire um momento para ler as definições de configuração na seção
abaixo para aprender como melhor configurar as opções do BGFX.

Como descrito em :ref:`advanced-multi-CFG`, o MAME segue uma sequência
na hora de processar os arquivos INI. As configurações BGFX podem ser
editadas diretamente no arquivo MAME.INI, porém para tirar melhor
proveito do poder dos arquivos de configuração do MAME, talvez seja
melhor copiar as opções do BGFX do MAME.INI para um outro arquivo de
configuração e fazer as modificações lá.

Particularmente, você vai querer que as configurações
**bgfx_screen_chains** sejam específicas es customizáveis para cada jogo
individualmente ao invés de uma única configuração para todos os jogos.

Salve o arquivo .INI e já estamos pronto para começar.

Alterando as configurações
--------------------------

| **bgfx_path**
|
| 	É aqui que seus arquivos de sombreamento BGFX (BGFX shader) são armazenados. Por definição inicial, o nome desta pasta será BGFX localizado onde o seu MAME estiver instalado.
|
| **bgfx_backend**
|
|	Seleciona um tipo de infraestrutura de renderização que o BGFX possa usar. As escolhas possíveis são **d3d9**, **d3d11**, **opengl**, and **metal**. O valor predefinido é **auto** que permite que o MAME escolha a melhor opção para você.
|
|	**d3d9** -- Renderizador do Direct3D 9.0 (Requer o Windows XP ou mais recente)
|	**d3d11** -- Renderizador do Direct3D 11.0 (Requer Windows Vista com o D3D11 atualizado ou o  Windows 7 ou mais recente)
|	**opengl** -- Renderizador OpenGL (Requer Drivers OpenGL, pode funcionar melhor em algumas placas de vídeo mais antigas ou mal projetadas, compatível com Linux/Mac OS X)
|	**metal** -- Metal Apple Graphics API (Requer Mac OS X 10.11 El Capitan ou mais recente)
|
| **bgfx_debug**
|
|	Ativa funcionalidades de depuração. A maioria dos usuários não precisará usar isso.
|
| **bgfx_screen_chains**
|
|	Determina como manipular a renderização BGFX tela a tela. As opções disponíveis são **hlsl**, **unfiltered**, and **default**.
|
|	**default** -- saída de filtro bilinear predefinido
|	**unfiltered** -- saída sem filtro mais próxima do original
|	**hlsl** -- saída com simulação de tela HLSL usando sombreadores
|
|	Nós fazemos um distinção entre dispositivos de tela emuladas (na qual a chamamos de **screen** ou **tela**) e tela física (na qual a chamaremos de **window** ou **janela**, configurável através da opção **-numscreens**). Nós usamos dois pontos (:) para separar janelas e vírgulas (,) para separar as telas. As vírgulas sempre saem do lado de fora da cadeia (veja o exemplo do **House Mannequin**)
|
|	Em uma combinação de só uma janela, no caso de jogos com uma única tela, como o Pac Man em um monitor de PC físico, você pode definir a opção como:
|
|		**bgfx_screen_chains hlsl**
|
|	As coisas se complicam um pouco mais quando chegarmos a várias janelas e várias telas.
|
|	Para usar uma só janela, num jogo com múltiplas telas, como é o caso do jogo Darius usando só um monitor físico de PC, defina as opções para cada uma dessas telas individualmente, assim:
|
|		**bgfx_screen_chains hlsl,hlsl,hlsl**
|
|	Isso também funciona com jogos que usam uma só tela e você está espelhando a saída dela para vários outros monitores físicos. Por exemplo, você pode configurar o jogo Pac Man para ter uma saída não filtrada para ser usada em uma transmissão de vídeo enquanto a saída para segunda tela é configurada para exibir uma tela com os efeitos como HLSL.
|
|	Em um jogo com várias telas em várias janelas, como o jogo Darius em três monitores físicos, defina as opções como mostra abaixo (individual para cada janela):
|
|		**bgfx_screen_chains hlsl:hlsl:hlsl**
|
|	Outro exemplo seria o jogo Taisen Hot Gimmick que usa dois monitores CRT, um para cada jogador que mostra a mão de cada jogador individualmente. Se estiver usando duas janelas (com duas telas físicas):
|
|		**bgfx_screen_chains hlsl:hlsl**
|
|	Outro caso especial, a Nichibutsu tinha uma máquina coquetel especial de Mahjongg que usa uma tela CRT no meio da máquina, junto com outras duas telas LCD individuais para cada jogador que mostrava a mão que cada um tinha. Nós gostaríamos que os LCDs não fossem tão filtrados como eram, enquanto o CRT seria melhorado através do uso do HLSL. Como queremos dar a cada jogador sua própria tela cheia (dois monitores físicos) junto com o LCD, nós fazemos assim:
|
|		**-numscreens 2 -view0 "Player 1" -view1 "Player 2" -video bgfx -bgfx_screen_chains hlsl,unfiltered,unfiltered:hlsl,unfiltered,unfiltered**
|
|	Isso configura a visualização de cada tela respectivamente, mantendo o efeito de tela CRT com HLSL para cada janela física enquanto fica sem os filtros nas telas LCD.
|
|	Se estiver usando apenas uma janela (uma tela), tendo em mente que o jogo ainda tem três telas, nós faríamos:
|
|		**bgfx_screen_chains hlsl,unfiltered,unfiltered**
|
|
|	Observe que as vírgulas estão nas bordas externas e qualquer dois-pontos estão no meio.
|
| **bgfx_shadow_mask**
|
|	Especifica o arquivo PNG para ser usado como efeito de máscara de sombra. Por definição inicial o nome do arquivo é **slot-mask.png**.
|
|


Customizando as configurações de BGFX HLSL dentro do MAME
---------------------------------------------------------

**Aviso:** *As configurações BGFX HLSL não são gravados ou lidas de
qualquer arquivo de configuração. É esperado que isso mude no futuro.*

Comece rodando o MAME com o jogo de sua preferência (**mame pacman** por
exemplo)

Use a tecla til (**~**) [1]_ para chamar a tela de opções que vai
aparecer na parte de baixo da tela. Use as teclas cima e baixo para
navegar dentre as várias opções, enquanto as teclas esquerda e direita
irão permitir que você altere o valor dessas opções. Os resultados
aparecerão em tempo real conforme elas forem sendo alteradas.

Observe que as configurações são individuais para cada tela.

.. [1]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
