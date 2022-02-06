
.. raw:: latex

	\clearpage

.. _advanced-bgfx:

Efeitos BGFX para (quase) todo mundo
====================================

.. note::

	Segundo `este post <https://www.reddit.com/r/MAME/comments/bx1c90/would_using_hlsl_add_input_lag_with_my_spec/eq3boab>`_
	feito pelo **MameHaze** [#]_ os efeitos BGFX causam lentidão na
	emulação e poderão ser removidos do MAME no futuro.

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

É aí então que entra em cena os novos processamentos **bgfx** com
**hlsl**.

O filtro **hlsl** simula a maioria dos efeitos de vídeo que um monitor
CRT de arcade teria, fazendo com que o resultado visual seja muito mais
realista. Porém, os filtros **hlsl** exigem um esforço extra dos
recursos do seu computador e em especial do monitor que você estiver
usando.

Além disso, havia centenas de milhares de tipos monitores diferentes nos
fliperamas. Cada um foi ajustado e mantido de forma diferente, o que
significa que, não tem como escolher e definir entre todos eles, apenas
um como referência. Diretrizes básicas serão fornecidas aqui para
ajudá-lo, mas você também poderá pedir mais opiniões em qualquer um dos
fóruns conhecidos sobre o MAME espalhados pela internet.


Resolução e a relação de aspecto da tela
----------------------------------------


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
recortado [#]_.

Alguns monitores de LCD mais antigos usavam uma resolução nativa de
1280x1024 onde tinham uma proporção de tela no formato 5:4.
Neste exemplo, não há muito espaço extra suficiente para exibir a
ilustração e você vai notar um leve esticamento vertical, porém os
resultados ainda serão bons o suficiente, como se fossem um monitor com
formato 4:3.

.. raw:: latex

	\clearpage

Introdução ao BGFX
------------------

Antes de começar, você precisará seguir as instruções de configuração
inicial do MAME encontrada em outra parte deste manual.
As distribuições oficiais do MAME à partir da versão 0.172 já incluem o
bgfx, então você não precisa baixar nenhum outro arquivo adicional.

Abra o seu ``mame.ini`` no seu editor de texto preferido como o bloco de
notas por exemplo e verifique se as seguintes opções estão definidas
corretamente:

* **video bgfx**

Agora tire um momento para ler as definições de configuração na seção
abaixo para aprender como melhor configurar as opções do bgfx.

Como descrito em :ref:`advanced-multi-CFG`, o MAME segue uma sequência
na hora de processar os arquivos ``.ini``. As configurações bgfx podem ser
editadas diretamente no arquivo ``mame.ini``, porém para tirar melhor
proveito do poder dos arquivos de configuração do MAME, talvez seja
melhor copiar as opções do **bgfx** do ``mame.ini`` para um outro
arquivo de configuração e fazer as modificações lá.

Particularmente, você vai querer que as configurações
**bgfx_screen_chains** sejam específicas e personalizáveis para cada
máquina em vez de uma única configuração para todas.

Salve o arquivo ``.ini`` e já estamos prontos para começar.

.. raw:: latex

	\clearpage

Alterando as configurações
--------------------------

.. _advanced-bgfx-path:

**bgfx_path**

 	Seus arquivos de sombreamento **bgfx** (*bgfx shader*) são
 	armazenados aqui. Por definição, o nome desta pasta é **bgfx**, fica
 	na pasta raiz do MAME.

.. _advanced-bgfx-backend:

**bgfx_backend**

	Seleciona um tipo de infraestrutura de renderização para que o bgfx
	possa usar, o MAME faz a escolha da melhor opção compatível e
	disponível no seu sistema, caso queira defini-las manualmente, estas
	são as opções disponíveis:

	* ``d3d9`` Renderizador do Direct3D 9.0 (Requer o Windows XP ou
	  uma versão mais nova do Windows).

	* ``d3d11`` Renderizador do Direct3D 11.0 (Requer o Windows Vista
	  com o D3D11 atualizado, o  Windows 7 ou uma versão mais nova do
	  Windows).

	* ``d3d12`` Renderizador do Direct3D 12.0 (Requer o Windows 10 ou
	  uma versão mais nova do Windows, assim como uma placa de vídeo
	  com um driver compatível).

	* ``opengl`` Renderizador OpenGL (Requer Drivers compatíveis com
	  OpenGL, pode não funcionar bem  com algumas placas de vídeo mais
	  antigas ou mal projetadas). Compatível com Linux/macOS.

	* ``metal`` Metal Apple Graphics API (Requer macOS 10.14 Mavericks
	  ou mais recente).

	* ``vulkan`` Renderizador Vulkan (via hardware), compatível
	  atualmente com OpenGL ES 3.1, OpenGL 4.X ou versões mais recentes.
	  Requer drivers compatíveis para as placas de vídeo mais atuais e
	  pode não ser compatível com as placas de vídeo ou com drivers mais
	  antigos.

		O valor predefinido é ``auto``.

.. _advanced-bgfx-debug:

**bgfx_debug**

	Ativa as funcionalidades de depuração, voltado apenas para os
	desenvolvedores.

**bgfx_screen_chains**

	Determina como manipular a renderização **bgfx** tela a tela. As
	opções disponíveis são:

	* **default** Gera uma tela com filtro bilinear.

	* **unfiltered** Geral uma tela sem filtro.

	* **hlsl** Simula uma tela CRT usando shaders hlsl.

	Nós fazemos um distinção entre dispositivos de tela emuladas (na
	qual a chamamos de **screen** ou **tela**) e tela física
	(na qual a chamaremos de **window** ou **janela**, configurável
	através da opção ``-numscreens``). Nós usamos dois pontos ``:`` para
	separar janelas e vírgulas ``,`` para separar as telas.
	
	As vírgulas sempre saem do lado de fora da cadeia (veja o exemplo do
	**House Mannequin**).

	Numa combinação de só uma janela, no caso de jogos com uma única
	tela, como o **Pac Man** num monitor físico de PC, você pode
	definir a opção como:

		``bgfx_screen_chains hlsl``

	As coisas se complicam um pouco mais quando temos diversas telas e
	janelas.

	Para usar uma só janela, num jogo com múltiplas telas, como é o caso
	do jogo **Darius** usando só um monitor físico de PC, defina as
	opções para cada uma dessas telas individualmente, como mostra o
	exemplo abaixo:

		``bgfx_screen_chains hlsl,hlsl,hlsl``

	Isso também funciona com jogos que usam uma única tela caso você
	queira espelhar a saída dela para vários outros monitores físicos.
	Por exemplo, você pode configurar o jogo **Pac Man** para ter uma
	saída não filtrada para ser usada numa transmissão de vídeo
	enquanto a saída para segunda tela é configurada para exibir uma
	tela com os efeitos hlsl.

	Num jogo com múltiplas telas em várias janelas como o jogo
	**Darius** usando três monitores físicos, defina as opções como
	mostra abaixo de forma individual para cada janela:

		``bgfx_screen_chains hlsl:hlsl:hlsl``

	Outro exemplo seria o jogo **Taisen Hot Gimmick** que usa dois
	monitores CRT para cada jogador mostrando a mão de cada um. Caso
	esteja usando duas janelas com duas telas físicas, faça como o
	exemplo abaixo:

		``bgfx_screen_chains hlsl:hlsl``

	Outro caso especial, a Nichibutsu tinha uma máquina tipo coquetel
	de Mahjongg que usa uma tela CRT bem no meio da máquina, junto com
	outras duas telas de LCD individuais mostrando a mão para cada
	jogador. Nós gostaríamos que os LCDs não fossem tão filtrados como
	eram, enquanto o CRT seria melhorado através do uso do hlsl.
	
	Como queremos dar a cada jogador sua própria tela cheia
	(dois monitores físicos) junto com o LCD, nós fazemos assim: ::

	-numscreens 2 -view0 "Player 1" -view1 "Player 2" -video bgfx bgfx_screen_chains hlsl,unfiltered,unfiltered:hlsl,unfiltered,unfiltered

	Isso configura a visualização de cada tela respectivamente, mantendo
	o efeito de tela CRT com HLSL para cada janela física enquanto fica
	sem os filtros nas telas LCD.

	Caso esteja usando apenas uma janela ou tela, tendo em mente que o
	jogo ainda tem três telas, nós faríamos assim:

		``bgfx_screen_chains hlsl,unfiltered,unfiltered``

	Observe que as vírgulas estão nas bordas externas e qualquer
	dois-pontos estão no meio. [#]_

.. _advanced-bgfx-shadow_mask:

**bgfx_shadow_mask**

	Especifica o arquivo PNG para ser usado como efeito de máscara de
	sombra. Por definição o nome do arquivo é ``slot-mask.png``.

.. _advanced-bgfx-lut:

**bgfx_lut**

	Use um arquivo LUT para aplicar diferentes efeitos de textura.

		O Valor predefinido é ``nenhum``

.. _advanced-bgfx-avi_name:

**bgfx_avi_name**

	Essa opção permite que você possa definir um nome de arquivo AVI
	para gravar o vídeo da máquina emulada com os efeitos
	``bgfx_avi_name pacman.avi`` por exemplo.

		O Valor predefinido é ``auto``

.. raw:: latex

	\clearpage


Customizando as configurações bgfx hlsl dentro do MAME
------------------------------------------------------

.. note::

	*As configurações bgfx hlsl não são gravados ou lidas de
	qualquer arquivo de configuração. É esperado que isso mude no futuro.*

Comece rodando o MAME com o jogo de sua preferência (**mame pacman** por
exemplo)

Use a tecla til (**~**) [#]_ para chamar a tela de opções que vai
aparecer na parte de baixo da tela. Use as teclas cima e baixo para
navegar dentre as várias opções, enquanto as teclas esquerda e direita
irão permitir que você altere o valor dessas opções. Os resultados
aparecerão em tempo real conforme elas forem sendo alteradas.

Observe que as configurações são individuais para cada tela.

.. [#]	**Citação** "O uso do BGFX adiciona um atraso em torno de 2 ou 3
		quadros e no geral é considerado inadequado para jogos, ainda
		que se obtenha uma melhor aparência visual (Eu acredito que
		(o BGFX) acabará sendo removido já que há muitos problemas
		segundo os próprios usuários)".
.. [#]	Cropped do Inglês. (Nota do tradutor)
.. [#]	Onde? (Nota do tradutor)
.. [#]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
