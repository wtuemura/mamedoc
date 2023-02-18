
.. raw:: latex

	\clearpage

.. _advanced-bgfx:

Efeitos BGFX para (quase) todo mundo
====================================

.. contents:: :local:

.. note::

	Segundo `este post <https://www.reddit.com/r/MAME/comments/bx1c90/would_using_hlsl_add_input_lag_with_my_spec/eq3boab>`_
	feito pelo **MameHaze** [#]_ os efeitos BGFX causam lentidão na
	emulação e poderão ser removidos do MAME no futuro.

Introdução
----------

Por padrão, o MAME gera uma versão idealizada de como estaria o vídeo ao
ser enviado ao monitor do gabinete de arcade, com uma mínima alteração
na saída (principalmente para esticar a imagem do jogo de volta à
proporção original do monitor, geralmente 4:3). Isso funciona bem,
contudo, perde um pouco do fator nostalgia. Os monitores arcade nunca
foram ideais, ainda que estivesse em perfeitas condições, a natureza de
um monitor CRT distorce essa imagem de maneira que altera a aparência da
imagem original de forma significativa.

Os monitores de LCD modernos simplesmente não têm a mesma aparência e
mesmo os monitores CRT de computador, não se igualam a aparência visual
de um monitor de arcade sem uma ajuda extra.

E é aí que o novo renderizador **BGFX** com **HLSL** entra em cena.

O HLSL simula a maioria dos efeitos (e defeitos) que um monitor de
arcade CRT geraria ao sinal de vídeo, tornando o resultado bem próximo a
um monitor CRT de arcade, dando um ar muito mais autêntico ao visual.
No entanto, o HLSL exige um certo esforço por parte do usuário: as
configurações que você usa serão adaptadas às especificações do sistema
do seu PC, especialmente, ao monitor que você está utilizando.
Além disso, haviam centenas de milhares de diferentes tipos de monitores
nos fliperamas. Cada um foi ajustado e mantido de forma diferente, o que
significa que não há apenas uma aparência correta. As diretrizes básicas
serão fornecidas aqui para ajudá-lo, mas você também pode pedir ajuda
nos fóruns mais conhecidos sobre o MAME espalhados pela internet.


.. raw:: latex

	\clearpage


Resolução e a relação de aspecto da tela
----------------------------------------


A resolução é um assunto muito importante para as configurações do hlsl.
Você desejará que o MAME esteja usando a resolução nativa do seu monitor
para evitar distorções e atrasos adicionais criados pelo seu monitor ao
tentar preencher a imagem na tela.

Enquanto a maioria dos sistemas de arcade usava um monitor com proporção
de tela no formato 4:3 (ou 3:4 se o monitor estivesse orientado
verticalmente como é no caso do **Pac Man**), a essa altura do
campeonato é difícil encontrar nos dias de hoje um monitor ou TV que
tenha uma proporção de tela no formato 4:3.

A boa notícia é que esse espaço extra que sobra nas laterais não é
desperdiçado. Muitos gabinetes de arcade na época utilizavam uma moldura
com ilustrações ao redor da tela, caso você tenha esses arquivos o MAME
também irá exibir essas ilustrações na tela. Para se obter um melhor
resultado, ative o visualizador de ilustrações e selecione
:guilabel:`Aproxime para a região da tela`, consulte
:ref:`mamemenus-video-options` para obter mais informações.

Alguns monitores de LCD mais antigos usavam uma resolução nativa de
1280x1024 onde tinham uma proporção de tela no formato 5:4.
Neste exemplo, não há muito espaço extra suficiente para exibir a
ilustração e você vai notar um leve esticamento vertical, porém os
resultados ainda serão bons o suficiente, como se fossem um monitor com
formato 4:3.


Começando com o BGFX
--------------------

Antes de começar, você precisará seguir as instruções de configuração
inicial do MAME encontrada em outra parte deste manual.
As distribuições oficiais do MAME à partir da versão 0.172 já incluem o
bgfx, então você não precisa baixar nenhum outro arquivo adicional.

Abra o seu ``mame.ini`` no seu editor de texto preferido como o bloco de
notas por exemplo e verifique se as seguintes opções estão definidas
corretamente:

* ``video bgfx``

Agora tire um momento para ler as definições de configuração na seção
abaixo para aprender como melhor configurar as opções do bgfx.

Como descrito em :ref:`advanced-multi-CFG`, o MAME segue uma sequência
na hora de processar os arquivos ``.ini``. As configurações bgfx podem ser
editadas diretamente no arquivo ``mame.ini``, porém para tirar melhor
proveito do poder dos arquivos de configuração do MAME, talvez seja
melhor copiar as opções do **bgfx** do ``mame.ini`` para um outro
arquivo de configuração e fazer as modificações lá.

Particularmente, você vai querer que as configurações
``bgfx_screen_chains`` sejam específicas e personalizáveis para cada
sistema em vez de uma única configuração para todos.

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

	Determina como manipular a renderização **BGFX** tela a tela. As
	opções disponíveis são:

	* ``default`` Gera uma tela com filtro bilinear.
	* ``unfiltered`` Geral uma tela sem filtro.
	* ``hlsl`` Simula uma tela CRT usando shaders hlsl.
	* ``crt-geom`` Geral uma tela sem filtro.
	* ``crt-geom-deluxe`` Geral uma tela sem filtro.
	* ``lcd-grid`` Geral uma tela sem filtro.

	Nós fazemos uma distinção entre os dispositivos de tela emuladas
	(que chamamos de **screen** ou **tela**) e a tela física (que
	chamaremos de **window** ou **janela**, configurável através da
	opção ``-numscreens``). Nós usamos dois pontos ``:`` para separar as
	janelas e as vírgulas ``,`` para separar as telas definindo valores
	na opção ``-bgfx_screen_chains`` .

	Numa combinação de só uma janela, no caso de jogos com uma única
	tela, como o **Pac Man** num monitor físico de PC, você pode
	definir a opção como::

		bgfx_screen_chains hlsl

	As coisas se complicam um pouco mais quando temos diversas telas e
	janelas.

	Para usar uma só janela, num jogo com mais de uma tela, como é o
	caso do jogo **Darius** usando só um monitor físico de PC, defina as
	opções para cada uma dessas telas individualmente, como mostra o
	exemplo abaixo::

		bgfx_screen_chains hlsl,hlsl,hlsl

	Isso também funciona com jogos que usam uma única tela caso você
	queira espelhar a saída dela para vários outros monitores físicos.
	Por exemplo, você pode configurar o jogo **Pac Man** para ter uma
	saída não filtrada para ser usada numa transmissão de vídeo
	enquanto a saída para segunda tela é configurada para exibir uma
	tela com os efeitos hlsl.

	Num jogo com múltiplas telas em várias janelas como o jogo
	**Darius** usando três monitores físicos, defina as opções como
	mostra abaixo de forma individual para cada janela::

		bgfx_screen_chains hlsl:hlsl:hlsl

	Outro exemplo seria o jogo **Taisen Hot Gimmick** que usa dois
	monitores CRT para cada jogador mostrando a mão de cada um. Caso
	esteja usando duas janelas com duas telas físicas, faça como o
	exemplo abaixo::

		bgfx_screen_chains hlsl:hlsl

	Outro caso especial, a Nichibutsu tinha uma sistema tipo coquetel
	de Mahjongg que usa uma tela CRT bem no meio do sistema, junto com
	outras duas telas de LCD individuais mostrando a mão para cada
	jogador. Nós gostaríamos que os LCDs não fossem tão filtrados como
	eram, enquanto o CRT seria melhorado através do uso do hlsl.
	
	Como queremos dar a cada jogador sua própria tela cheia
	(dois monitores físicos) junto com o LCD, nós fazemos assim::

		-numscreens 2 -view0 "Player 1" -view1 "Player 2" -video bgfx -bgfx_screen_chains hlsl,unfiltered:hlsl,unfiltered

	Isso configura a visualização de cada tela respectivamente, mantendo
	o efeito de tela CRT com HLSL para cada janela física enquanto fica
	sem os filtros nas telas LCD.

	Caso esteja usando apenas uma janela ou tela, tendo em mente que o
	jogo ainda tem três telas, nós faríamos assim::

		bgfx_screen_chains hlsl,unfiltered,unfiltered

	Observe que as vírgulas estão nas bordas externas e qualquer
	dois-pontos estão no meio. [#]_


.. raw:: latex

	\clearpage


.. _advanced-bgfx-shadow_mask:

**bgfx_shadow_mask**

	Especifica o arquivo PNG para ser usado como efeito da máscara. Por
	padrão é usado o arquivo ``slot-mask.png``.

.. _advanced-bgfx-lut:

**bgfx_lut**

	Use um arquivo LUT para aplicar diferentes efeitos de textura.

		O Valor predefinido é ``nenhum``

.. _advanced-bgfx-avi_name:

**bgfx_avi_name**

	Essa opção permite que você possa definir um nome de arquivo AVI
	para gravar o vídeo do sistema emulado com os efeitos
	``bgfx_avi_name pacman.avi`` por exemplo.

		O Valor predefinido é ``auto``

.. raw:: latex

	\clearpage


Customizando as configurações BGFX HLSL dentro do MAME
------------------------------------------------------

Comece rodando o MAME com o jogo de sua preferência (**mame pacman** por
exemplo).

Use a tecla til (**~**) [#]_ para chamar a tela de opções que vai
aparecer na parte de baixo da tela. Use as teclas cima e baixo para
navegar dentre as várias opções, enquanto as teclas esquerda e direita
irão permitir que você altere o valor dessas opções. Os resultados
aparecerão em tempo real conforme elas forem sendo alteradas.

Observe que as configurações são individuais para cada tela.

As configurações dos controles deslizantes do BGFX são salvas
individualmente por sistema em arquivos CFG. Caso a configuração
``bgfx_screen_chains`` tenha sido definida (num arquivo INI ou através
da linha de comando), ela definirá os efeitos iniciais. Caso não exista
uma configuração ``bgfx_screen_chains``, o MAME usará os efeitos que
você escolheu na última vez que rodou o sistema.


Usando os filtros para adicionar pilares nos cantos da tela do vídeo
--------------------------------------------------------------------

O MAME inclui exemplos de shaders BGFX e layouts para preencher o
espaço não utilizado numa tela widescreen 16:9 com uma versão emulada da
borda do vídeo. Todos os arquivos necessários estão inclusos, bastam ser
ativados.

Para sistemas que usam monitores horizontais 4:3, experimente estas
opções::

		-override_artwork bgfx/border_blur -view Horizontal -bgfx_screen_chains crt-geom,pillarbox_left_horizontal,pillarbox_right_horizontal


Para sistemas que usam monitores verticais 3:4, experimente estas
opções::

		-override_artwork bgfx/border_blur -view Vertical -bgfx_screen_chains crt-geom,pillarbox_left_vertical,pillarbox_right_vertical

* Você pode usar uma configuração diferente no lugar do ``crt-geom``
  para que o efeito seja aplicado à imagem da tela principal no centro
  (``default``, ``hlsl`` ou ``lcd-grid`` por exemplo).

* Caso tenha alterado a visualização do sistema no MAME
  anteriormente, a visualização correta dos pilares, por padrão, não
  será selecionada. Use o menu de opções do vídeo para selecionar a
  visualização correta.

* Você pode adicionar essas configurações a um arquivo INI para que
  elas sejam aplicados automaticamente em determinados sistemas
  (``horizont.ini`` ou ``vertical.ini`` ou o arquivo INI de um
  determinado sistema por exemplo).


.. [#]	**Citação** "O uso do BGFX adiciona um atraso em torno de 2 ou 3
		quadros e no geral é considerado inadequado para jogos, ainda
		que se obtenha uma melhor aparência visual (Eu acredito que
		(o BGFX) acabará sendo removido já que há muitos problemas
		segundo os próprios usuários)".
.. [#]	Onde? (Nota do tradutor)
.. [#]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
