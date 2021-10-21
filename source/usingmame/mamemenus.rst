.. raw:: latex

	\clearpage

.. _mamemenu:

Cardápio de opções
==================

.. contents:: :local:

.. raw:: latex

	\clearpage

Caso rode o MAME sem nenhum parâmetro na linha de comando ou
clicando duas vezes em seu ícone, você verá a interface do usuário e
acessando as opções da parte debaixo da tela terá acesso ao cardápio de
opções, entre eles a lista de seleção de jogos ao centro, os filtros do
lado esquerdo, a aba de informações e imagens. No rodapé da tela tem um
descritivo resumido da máquina, com o nome da máquina, nome do
fabricante, ano, a condição som e imagem e se a máquina funciona ou não.

Dependendo da condição das máquinas a interface do MAME exibirá
diferentes cores de fundo indicando a sua condição.

	* **Verde**: São máquinas com roms completas e que funcionam.
	* **Vermelha**: São máquinas que não funcionam direito ou tem roms faltando.
	* **Laranja**: São máquinas que funcionam mas estão imperfeitas na parte de som ou vídeo.

Abaixo da lista das máquinas nós temos:

	* **Configurações**: Exibe uma lista das configurações do MAME.
	* **Configure a máquina**: Exibe uma lista das opções de configuração da máquina selecionada.

Todos os itens exibidos nessa interface podem ser acessadas usando as
setas do seu teclado (cima, baixo, esquerda, direita) e são selecionadas
pressionando a tecla **Enter** do teclado. A interface também aceita o
uso do mouse fazendo a seleção com um clique e um duplo clique para
abrir a opção ou rodar uma máquina.

.. _mamemenu-alt-valores:

Alterando os valores
--------------------

A interface é bem intuitiva, os controles para modificar os valores
predefinidos funcionam da seguinte maneira:

*	**Mouse** - Move o cursor na tela, seleciona os itens, as teclas
	cima, baixo, esquerda e direita fazem o mesmo.
*	**Clique duplo ou Enter** - Aguarda a entrada do usuário (controle,
	teclado, etc).
*	**Delete** - **1x** apaga o valor, **2x** retorna ao valor
	predefinido originalmente.

Os campos que possuam mais de uma opção de escolha podem ser abertos
ao clicar duas vezes nele, como é o caso dos campos disponíveis em
:ref:`Filtro <mamemenu-filtro>`, por exemplo.

.. raw:: latex

	\clearpage

.. _mamemenu-filtro:

Filtro
------

Escolhe entre diferentes filtros pré configurados e um personalizado.
Estes filtros ajudam o usuário a selecionar máquinas separadas por
categorias, caso queira encontrar uma máquina que você não
se lembra do nome porém se lembra do ano, é possível usar o filtro
**Ano** para listar todas as máquinas conhecidas pelo MAME que foram
lançadas naquele ano.

Supondo que eu queira encontrar a máquina **Double Dragon**, faremos de
conta que eu não me lembro, eu só lembro do ano *1987* e que o
fabricante dela foi a *Technos Japan*. Vamos até o
**Filtro Personalizado**, no primeiro filtro adicionamos um filtro para
o **Ano** e colocamos *1987*, adicionamos mais um filtro para o
**Fabricante** e escolhemos *Techmos Japan*, ao retornarmos ao menu
anterior o MAME exibirá uma lista das máquinas que atendam aos critérios
definidos por nós. Neste exemplo então o MAME vai retornar 6 diferentes
máquinas **Double Dragon**, **Super Dodge Ball** e **Nekketsu Koukou
Dodgeball Bu**.

Os filtros disponíveis são:

.. _mamemenu-nao-filtrado:

* **Sem filtro**

  Exibe toda a lista das máquinas conhecidas e cadastradas no catálogo
  interno do MAME sem nenhum filtro.

.. _mamemenu-disponivel:

* **Disponível**

  Exibe a lista das máquinas que o MAME identificou dentro do diretório
  roms.

.. _mamemenu-nao-disponivel:

* **Indisponível**

  Exibe toda a lista das máquinas conhecidas e cadastradas no catálogo
  interno do MAME que não estão disponíveis, ainda que a interface
  mostre a cor verde.

.. _mamemenu-funciona:

* **Funciona**

  Exibe uma lista das máquinas que funcionam e estão em condição verde e
  marrom, as máquinas na condição vermelha ou que ainda não funcionem
  ficam de fora da lista.

.. _mamemenu-nao-funciona:

* **Não funciona**

  Exibe apenas máquinas que tenham condição vermelha e que não
  funcionam.

.. _mamemenu-mecanico:

* **Mecânico**

  Exibe toda a lista das máquinas mecânicas conhecidas e cadastradas no
  catálogo interno do MAME como Pinball por exemplo.

.. _mamemenu-nao-mecanico:

* **Não mecânico**

  Repete a lista :ref:`Não filtrado <mamemenu-nao-filtrado>`.

.. _mamemenu-categoria:

* **Categoria**

  Este filtro usa de arquivos *.ini* para separar as máquinas em
  diversas categoria diferentes como por exemplo gabinetes com 2
  jogadores, 4 jogadores, jogo de tiro, de corrida, de tabuleiro,
  corrida, etc. Em categorias onde a lista seja muito grande, clique
  duas vezes com o mouse em cima da lista para que uma nova tela seja
  exibida e fique mais fácil de escolher a opção desejada. Note que o
  uso destes arquivos pode fazer com que o MAME demore um pouco mais
  para iniciar.

  O MAME não incluí nenhum arquivo de categoria, na internet é possível
  acessar o site `Progetto-Snaps <http://www.progettosnaps.net>`_ que
  oferece estes arquivos *.ini* para download `aqui
  <http://www.progettosnaps.net/renameset/>`_. Depois que o arquivo for
  baixado e extraído o diretório **folders** deve ser copiado para o
  diretório raiz do MAME.

  Até o presente momento não existe uma tradução dessas categorias para
  o Português Brasileiro. Abaixo estão as categorias existentes até o
  momento e que funcionam com o MAME, as categorias que não funcionam
  com o MAME foram criadas para serem usadas com o MAMEUI [#MAMEUIP]_ e
  não estão listadas aqui:

	* **Cabinets**: Lista as máquinas **Arcade** do MAME que estão divididas em tipos de gabinetes.
	* **Category**: Lista as máquinas separadas em categorias como corrida, tabuleiro, tiro, etc.
	* **Driver**: Lista as máquinas por driver como cps1.cpp, 1943.cpp, 3do.cpp, etc.
	* **FreePlay**: Lista as máquinas **Arcade** do MAME que possuem a opção de poder jogar de graça.
	* **MonoChrome**: Lista as máquinas separada por cores.
	* **Resolution**: Lista as máquinas separadas pela sua resolução.

O site ainda oferece outros tipos de *.ini* como **version.ini** que
separa as máquinas por versão em que elas apareceram pela primeira vez
no MAME, note que estes aquivos extras não serão abordados neste
documento porém já deve ter ficado fácil compreender a sua utilidade no
MAME.

.. _mamemenu-favoritos:

* **Favoritos**

  Exibe uma lista das máquinas que foram favoritadas, para adicionar uma
  máquina à lista de favoritos, pressione **TAB**, no menu que aparecer
  selecione **Adicione aos Favoritos**.

.. _mamemenu-bios:

* **BIOS**

  Exibe uma lista das máquinas que precisam de uma BIOS para funcionar.

.. _mamemenu-sembios:

* **Sem BIOS**

  Exibe uma lista das máquinas que não precisam de uma BIOS para
  funcionar.

.. _mamemenu-pai:

* **Principais**

  Quando existirem máquinas derivadas da máquina principal exibe
  uma lista das máquinas que são originadas desta matriz.

.. _mamemenu-clones:

* **Clones**

  Exibe uma lista das máquinas que são consideradas clones das máquinas
  originais.

.. _mamemenu-fabricante:

* **Fabricante**

  Exibe uma lista com todos os fabricantes catalogados pelo MAME.

.. _mamemenu-ano:

* **Ano**

  Exibe uma lista das máquinas separadas por ano de lançamento.

.. _mamemenu-save-support:

* **É possível salvar**

  Exibe uma lista das máquinas onde o salvamento do estado da máquina
  é possível.

.. _mamemenu-nosave-support:

* **Não é possível salvar**

  Exibe uma lista das máquinas onde não é possível salvar o estado da
  máquina.

.. _mamemenu-chd:

* **Precisa de CHD**

  Exibe uma lista das máquinas que precisam de uma imagem de disco para
  funcionar.

.. _mamemenu-nochd:

* **Não precisa de CHD**

  Exibe uma lista das máquinas que não precisam de uma imagem de disco
  para funcionar.

.. _mamemenu-tela-vertical:

* **Tela vertical**

  Exibe uma lista das máquinas que usam orientação vertical de tela.

.. _mamemenu-tela-horizontal:

* **Tela horizontal**

  Exibe uma lista das máquinas que usam orientação horizontal de tela.

.. _mamemenu-filtro-personalizado:

* **Filtro personalizado**

  Todo o filtro criado será listado aqui.

.. raw:: latex

	\clearpage

.. _mamemenu-config-during-gameplay:

Durante a emulação
------------------

Estas opções podem ser acessadas durante a emulação e estão acessíveis
ao pressionar a tecla **TAB**.

Entrada (geral)
~~~~~~~~~~~~~~~

* **Interface do usuário**

  Consulte :ref:`mamemenu-general-inputs`.

.. raw:: html

	<p></p>

* **Controles do jogador [1~10]**

  Consulte :ref:`mamemenu-general-inputs-P1`.

.. raw:: html

	<p></p>

* **Outros controles**

  Consulte :ref:`Outros controles <mamemenu-other-controls>`.

Entrada (esta máquina)
~~~~~~~~~~~~~~~~~~~~~~

Aqui ficam as configurações que serão utilizadas apenas na máquina que
estiver sendo emulada no momento e por isso essa lista varia, as
configurações vão desde créditos, botões, acesso ao modo de serviço da
máquina (caso seja um arcade), teclas de um computador pessoal, etc.

Chaves DIP
~~~~~~~~~~

Aqui ficam as chaves DIP, elas servem para definir as configurações da
máquina (quando for relevante) como, a quantidade de fichas necessárias
para registrar 1 crédito, se a tela será invertida ou não, se a máquina
ficará em silêncio ou reproduzirá qualquer tipo de áudio enquanto
ninguém a estiver jogando, etc.

Sempre que uma chave for alterada, sempre selecione **Reinicie** para
que a alteração seja aplicada. Em alguma máquina a ação já pode ser
vista na tela, contudo, não é sempre o caso.

Informação da contabilidade
~~~~~~~~~~~~~~~~~~~~~~~~~~~

É o registro interno da máquina que mostra o tempo total que ela ficou
em execução e a quantidade de fichas que foram colocadas nela.

Informação da máquina
~~~~~~~~~~~~~~~~~~~~~

Um breve resumo do nome da máquina, o seu driver, o tipo do processador
(vídeo, áudio e outros) e a resolução do vídeo.

.. raw:: latex

	\clearpage

Controles deslizantes
~~~~~~~~~~~~~~~~~~~~~

As opções disponíveis aqui também dependem do tipo da máquina, outros
ajustes podem aparecer porém os principais são estes:

* **Volume principal**

  Faz o ajuste do volume do áudio principal do sistema que estiver sendo
  emulado.

.. raw:: html

	<p></p>

* **Volume com xxx Ch.x**

  Faz o ajuste individual de cada canal de áudio, máquina com áudio mono
  só tem o ``Ch.0``, já máquinas com canal estéreo possuem ``Ch.0``
  (esquerdo) e ``Ch.1`` (direito) e assim por diante. A quantidade de
  canais disponíveis vai depender da máquina que está sendo emulada.

.. raw:: html

	<p></p>

* **Brilho da tela**

  Faz o controle do nível de preto da tela, consulte também
  :ref:`-brightness <mame-commandline-brightness>`.

		O valor predefinido é **1.0**.

* **Contraste da tela**

  Faz o controle do nível de branco da tela, consulte também
  :ref:`-contrast <mame-commandline-contrast>`.

		O valor predefinido é **1.0**.

* **Gama da tela**

  Faz o ajuste da escala de luminância da tela, consulte também
  :ref:`-gamma <mame-commandline-gamma>`.

		O valor predefinido é **1.0**.

* **Extensão horizontal da tela**

  Estica a tela no eixo horizontal.

		O valor predefinido é **1.0**.

* **Posição horizontal da tela**

  Desloca a tela no eixo horizontal

		O valor predefinido é **0.0**.

* **Extensão vertical da tela**

  Estica a tela no eixo vertical.

		O valor predefinido é **1.0**.

* **Posição vertical da tela**

  Desloca a tela no eixo vertical

		O valor predefinido é **0.0**.

.. raw:: latex

	\clearpage

Opções do vídeo
~~~~~~~~~~~~~~~

Tela #X
^^^^^^^

Caso a máquina possua mais de uma tela, todas elas serão listadas aqui,
onde "X" indica o número da tela e cada uma delas com as opções
mostradas abaixo. Aqui também vai aparecer qualquer tipo de ilustração
da máquina emulada e as suas respectivas opções, quando houver.

* **Nome**

  Caso esteja usando uma **artwork** e ela tiver um nome, ela será
  exibida aqui indicando que ela pode ser selecionada.

.. raw:: html

	<p></p>

* **Screen 0 Standard (4:3)**

  Faz com que a tela tenha uma proporção padrão de 4:3.

.. raw:: html

	<p></p>

* **Screen 0 Pixel Aspect (X:Y)**

  Faz com que a tela use a proporção original (SAR) como 8:7, 12:7, etc.

.. raw:: html

	<p></p>

* **Cocktail**

  Faz com que a tela fique espelhada no eixo vertical da tela.

.. raw:: html

	<p></p>

* **Rotação**

  Rotaciona a tela, as opções disponíveis são:

	* **CW 90º**: Rotaciona a tela no sentido horário em 90º.
	* **180º**: Rotaciona a tela em 180º.
	* **CCW 90º**: Rotaciona a tela no sentido anti-horário em 90º.

		O valor predefinido é **None**.


* **Aproxime a área da tela**

  Quando a máquina estiver usando uma artwork onde exista uma tela,
  somente esta região será aproximada.

		O valor predefinido é **Desligado**.

* **Escale a tela com valores racionais**

  Faz com que a tela possa ser expandida usando números racionais em vez
  de números inteiros, isso causa efeitos *"aliasing"* (um efeito
  colateral de deformação dos pixels) indesejáveis na tela, para mais
  informações consulte
  :ref:`-unevenstretch <mame-commandline-unevenstretch>`.

  As opções disponíveis são:

	* **Apenas X**: Expande a tela apenas no eixo X.
	* **Apenas Y**: Expande a tela apenas no eixo Y.
	* **X ou Y (Auto)**: Expande a tela em ambos os eixos automaticamente.

		O valor predefinido é **Ligado**.

* **Mantenha a proporção da tela**

  Mantém a proporção 4:3 da tela, independente do que as outras
  configurações façam, consulte também
  :ref:`-keepaspect <mame-commandline-keepaspect>`.

		O valor predefinido é **Ligado**.

.. raw:: latex

	\clearpage

Snapshot
^^^^^^^^

Faz uma captura da tela, caso esteja usando uma **ilustração** e ela
tiver um nome, faça um clique duplo em cima do nome para que a captura
da tela seja feito.

.. raw:: html

	<p></p>

* **Screen 0 Standard (4:3)**

  Faz um print de tela nesta proporção

.. raw:: html

	<p></p>

* **Screen 0 Pixel Aspect (X:Y)**

  Faz uma captura da tela usando a proporção original (SAR) como 8:7,
  12:7, etc.

.. raw:: html

	<p></p>

* **Cocktail**

  Faz uma captura da tela espelhada no eixo vertical.

.. raw:: html

	<p></p>

* **Rotação**

  Faz uma captura da tela com a tela rotacionada como demonstrado no
  exemplo anterior.

		O valor predefinido é **None**.

* **Aproxime a área da tela**

  Quando a máquina estiver usando uma artwork onde exista uma tela, a
  captura da tela será feita somente desta área.

		O valor predefinido é **Desligado**.

Opções dos plug-ins
~~~~~~~~~~~~~~~~~~~

Quando os plug-ins forem ativados na configuração, eles serão listados
aqui. Qualquer alteração que for feita ao ativar um plugin, ele é
gravado no arquivo ``plugin.ini`` que fica na mesma pasta do MAME ou em
``~/.mame`` em sistemas Linux e macOS.

Para mais informações consulte :ref:`Plug-ins <mamemenu-plugins>`.

Visualização da DAT externa
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Esta opção estará disponível quando dois critérios forem atendidos, o
plug-in **Data plugin** estiver ativo e os arquivos **\*.dat**
(command.dat, gameinit.dat, etc) estiverem dentro do diretório **dats**.

Caso o nome da máquina exista dentro do ``command.dat`` por exemplo,
será exibido uma lista de como jogar, dicas, a lista dos comandos da
máquina na tela (em Inglês), etc.

.. raw:: latex

	\clearpage

.. _mamemenu-config-options:

Configurações
-------------

Personalize a Interface
~~~~~~~~~~~~~~~~~~~~~~~

Aqui é possível personalizar a interface do MAME, os valores numéricos
podem ser alterados movendo o direcional para a esquerda e direita ou
pressionando a tecla **Enter** e digitando o valor manualmente.

As opções disponíveis são:

* **Tipografia da interface**

  Permite a customização da tipografia da interface, dentro desta opção
  temos:

	* **Tipografia da interface**: Aqui é possível definir uma fonte
	  para toda a interface do MAME.

		O valor predefinido é **Padrão**.

	* **Linhas**: Ajusta a dimensão do espaço e o tamanho da fonte,
	  quanto maior o valor maior a dimensão da interface e menor o texto
	  na tela.

		O valor predefinido é **30**.

	* **Tamanho da caixa de informação**: Ajusta o tamanho da fonte nas
	  caixas de texto na tela.

		O valor predefinido é **0.75**.

.. _mamemenu-cores:

* **Cores**

  Permite a customização completa das cores da interface do MAME, as
  opções disponíveis são:

	* **Texto Normal**: Define a cor do texto de toda a interface.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **255**.

	* **Cor Selecionada**: Define a cor do item que for selecionado.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**.

	* **Fundo do texto normal**: Aparentemente não tem função alguma.

		O valor predefinido é Opacidade: **239**, Vermelho: **0**,
		Verde: **0**, Azul: **0**.

	* **Cor de fundo selecionada**: Define a cor do item selecionado.

		O valor predefinido é Opacidade: **239**, Vermelho: **128**,
		Verde: **128**, Azul: **0**.

	* **Cor de subitem**: Define a cor dos itens que estiverem abaixo do
	  item principal.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **255**.

	* **Clone**: Define a cor do texto de segundo plano.

		O valor predefinido é Opacidade: **255**, Vermelho: **128**,
		Verde: **128**, Azul: **128**.

	* **Borda**: Define a cor das linhas da borda da tela.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **255**.

	* **Fundo**: Define a cor do fundo da tela e máquinas clonadas.

		O valor predefinido é Opacidade: **239**, Vermelho: **16**,
		Verde: **16**, Azul: **48**.

	* **Chave DIP**: Define a cor das chaves DIP selecionadas em
	  máquinas que usam tal chaves.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**.

	* **Cor indisponível**: Aparentemente não tem função alguma.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**.

	* **Cor do controle deslizante**: Define a cor dos controles
	  deslizantes.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**.

	* **Fundo do visualizador GFX**: Define a cor de fundo do
	  visualizador GFX (tecla **F4**).

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**.

	* **Cor da sobreposição do mouse**: Define a cor que texto terá
	  quando o mouse passar por cima de algum item selecionável.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **128**.

	* **Cor de fundo da sobreposição do mouse**: Define a cor de fundo
	  do texto quando o mouse passar por cima de um item selecionável.

		O valor predefinido é Opacidade: **112**, Vermelho: **64**,
		Verde: **64**, Azul: **0**.

	* **Cor de subposição do mouse**: Aparentemente não tem função
	  alguma.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **128**.

	* **Cor debaixo do mouse**: Aparentemente não tem
	  função alguma.

		O valor predefinido é Opacidade: **176**, Vermelho: **96**,
		Verde: **96**, Azul: **0**.

.. _mamemenu-idioma:

* **Idioma**

  Permite a seleção do Idioma da interface do MAME, faça um clique duplo
  no campo do idioma para abrir uma listagem com todos os idiomas
  disponíveis.

		O valor predefinido é **English**

* **Os nomes dos sistemas**

  No momento só existe a opção **incorporado**.

		O valor predefinido é **incorporado**.

* **Painéis laterais**

  Configura a exibição ou não dos painéis laterais da interface do MAME.
  As opções disponíveis são:

	* **Mostra tudo**
	* **Esconde os filtros**
	* **Esconde info/imagem**
	* **Esconde ambos**


.. raw:: latex

	\clearpage

Configuração dos diretórios
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Aqui é possível mudar as predefinições do locais onde os diretórios
usados pelo MAME se encontram. As opções disponíveis são:

.. _mamemenu-diretório-roms:

* **ROMs**

  Define o caminho do diretório onde se encontram as ROMs. Veja também
  :ref:`-rompath <mame-commandline-rompath>`.

		O valor predefinido é um diretório chamado **roms** no diretório
		raiz do MAME.

* **Software em mídia**

  Define o caminho onde a imagem em mídia dos arquivos são armazenados
  como CD-ROM, floppy, fita K7 ou qualquer outro programa avulso.

		O valor predefinido é um diretório chamado **software** no
		diretório raiz do MAME.

* **Interface do usuário**
  Define o caminho do diretório onde se encontram os arquivos de
  configuração da interface visual do MAME.

		O valor predefinido é um diretório chamado **ui** no
		diretório raiz do MAME.

* **Idioma**

  Define o caminho do diretório onde se encontram os arquivos de idioma
  da interface do MAME.

		O valor predefinido é um diretório chamado **language** no
		diretório raiz do MAME.

* **Amostras**

  Define o caminho do diretório onde se encontram os arquivos de áudio
  usadas como amostras de áudio no MAME.

		O valor predefinido é um diretório chamado **samples** no
		diretório raiz do MAME.

* **DATs**

  Define o caminho do diretório onde se encontram os arquivos *.dat*.

		O valor predefinido são os diretórios **dats** e **history** no
		diretório raiz do MAME.

* **INIs**

  Define o caminho do diretório onde se encontram os arquivos *.ini*.

		O valor predefinido é um diretório chamado **ini** no
		diretório raiz do MAME.

* **INIs com as categorias**

  Define o caminho do diretório onde se encontram os arquivos *.ini* com
  descritivos de categoria.

		O valor predefinido é um diretório chamado **folders** no
		diretório raiz do MAME.

* **Ícones**

  Define o caminho do diretório onde se encontram os arquivos *.ico*
  para serem usados como ícones que ficam ao lado do nome da máquina.
  [#]_

		O valor predefinido é um diretório chamado **icons** no
		diretório raiz do MAME.

.. raw:: latex

	\clearpage

* **Trapaças**

  Define o caminho do diretório onde se encontra o arquivo de trapaça.
  Este arquivo também pode ser deixado na pasta raiz do MAME.

		O valor predefinido é um diretório chamado **cheats** no
		diretório raiz do MAME. [#]_

* **Capturas da tela**

  Define o caminho do diretório onde serão armazenadas as capturas
  da tela e a gravação de vídeo.

		O valor predefinido é um diretório chamado **snaps** no
		diretório raiz do MAME.

* **Gabinetes**

  Define o caminho do diretório onde se encontram as imagens dos
  gabinetes.

		O valor predefinido são dois diretórios chamados **cabinets** e
		**cabdevs** no diretório raiz do MAME.

* **Panfletos**

  Define o caminho do diretório onde se encontram as imagens dos
  panfletos.

		O valor predefinido é um diretório chamado **flyers** no
		diretório raiz do MAME.

* **Títulos**

  Define o caminho do diretório onde se encontram as imagens que mostram
  a tela de título da máquina.

		O valor predefinido é um diretório chamado **titles** no
		diretório raiz do MAME. [#]_

* **Ends**

  Define o caminho do diretório onde se encontram as imagens que mostram
  a tela de um final de jogo da máquina.

		O valor predefinido é um diretório chamado **ends** no
		diretório raiz do MAME.

* **PCBs**

  Define o caminho do diretório onde se encontram fotos que mostram
  a placa de circuito impresso da máquina.

		O valor predefinido é um diretório chamado **pcb** no
		diretório raiz do MAME.

* **Marquises**

  Define o caminho do diretório onde se encontram as imagens com a arte
  gráfica que ficavam na parte de cima da máquina.

		O valor predefinido é um diretório chamado **marquees** no
		diretório raiz do MAME.

* **Painéis de controle**

  Define o caminho do diretório onde se encontram as imagens ou as fotos
  com a arte gráfica do painel onde se encontram os diferentes controles
  e botões do arcade.

		O valor predefinido é um diretório chamado **cpanel** no
		diretório raiz do MAME.

* **Mira**

  Define o caminho do diretório onde se encontram as imagens com uma
  arte gráfica em formato de mira que serão usadas por jogos de tiro.

		O valor predefinido é um diretório chamado **crosshair** no
		diretório raiz do MAME.

.. raw:: latex

	\clearpage

* **Arte**

  Define o caminho do diretório onde se encontram as ilustrações
  gráficas que fazem o preenchimento de fundo da tela das máquinas.
  Veja mais em :ref:`-artpath <mame-commandline-artpath>`.

		O valor predefinido é um diretório chamado **artwork** no
		diretório raiz do MAME.

* **Chefes**

  Define o caminho do diretório onde se encontram as imagens com os
  prints de tela dos chefes de fase. [#]_

		O valor predefinido é um diretório chamado **bosses** no
		diretório raiz do MAME.

* **Amostra das artes**

  Define o caminho do diretório onde se encontram as imagens com as
  amostras das ilustrações, essas amostras tem um tamanho menor se
  comparadas com as ilustrações completas.

		O valor predefinido são dois diretórios chamados **artwork
		preview** e **artpreview** no diretório raiz do MAME.

* **Selecionado**

  A ser concluído

		O valor predefinido é um diretório chamado **select** no
		diretório raiz do MAME.

* **Fim do jogo**

  Define o caminho do diretório onde se encontram as imagens com os
  prints de tela mostrando o **GAME OVER**.

		O valor predefinido é um diretório chamado **gameover** no
		diretório raiz do MAME.

* **Como**

  Define o caminho do diretório onde se encontram as imagens ou fotos
  daqueles panfletos que mostravam as instruções de como jogar.

		O valor predefinido é um diretório chamado **howto** no
		diretório raiz do MAME.

* **Logotipos**

  Define o caminho do diretório onde se encontram as imagens ou
  ilustrações com a logomarca das empresas.

		O valor predefinido é um diretório chamado **logos** no
		diretório raiz do MAME.

* **Placares**

  Define o caminho do diretório onde se encontram as imagens com os
  prints de tela mostrando as maiores pontuações. [#]_

		O valor predefinido é um diretório chamado **scores** no
		diretório raiz do MAME.

* **Versus**

  Define o caminho do diretório onde se encontram as imagens com os
  prints de tela mostrando as maiores pontuações.

		O valor predefinido é um diretório chamado **versus** no
		diretório raiz do MAME.

.. raw:: latex

	\clearpage

* **Capas**

  Define o caminho do diretório onde se encontram as imagens com as
  capas dos jogos.

		O valor predefinido é um diretório chamado **covers** no
		diretório raiz do MAME.

.. raw:: latex

	\clearpage

.. _mamemenu-config-video:

Opções do vídeo
~~~~~~~~~~~~~~~

Essas opções sempre serão carregadas na inicialização do MAME, lembrando
que a linha de comando **SEMPRE** tem prioridade, independente do que
seja definido aqui.

* **Modo do vídeo**

  Para mais informações consulte :ref:`-video <mame-commandline-video>`.

		O valor predefinido é **Auto**.

* **Quantidade de telas**

  Predefine a quantidade das telas que serão usadas na emulação.

		O valor predefinido é **1**.

* **GLSL**

  Ativa ou não os efeitos GLSL, para mais informações consulte
  :ref:`-gl_glsl_filter <mame-commandline-glglslfilter>`.

		O valor predefinido é **Desligado**.

* **Filtragem bilinear**

  Ativa ou não os filtros de tela para suavizar os gráficos, caso os
  gráficos fiquem muito borrados, experimente ativar também a opção
  **Pré-escala de bitmap**.

		O valor predefinido é **Ligado**.

* **Pré-escala do bitmap**

  Opção útil quando máquinas com baixa resolução são ampliadas para uma
  resolução maior, use essa opção para dar uma amenizada nessa
  aparência, essa opção geralmente é utilizada em conjunto com a opção
  **Filtragem bilinear**.

		O valor predefinido é **1**.

* **Modo janela**

  Faz o MAME exibir a tela emulada em uma janela ou em uma tela inteira.

		O valor predefinido é **Desligado**.

* **Mantenha a proporção da tela**

  Faz com que a proporção da imagem exibida seja sempre mantida.

		O valor predefinido é **Ligado**.

* **Inicia com a tela expandida**

  Faz o MAME exibir a tela emulada em uma janela com o tamanho máximo do
  seu monitor, caso contrário exibe a tela emulada em sua resolução
  nativa.

		O valor predefinido é **Ligado**.

* **Atualização sincronizada dos quadros**

  Consulte :ref:`-syncrefresh <mame-commandline-syncrefresh>`.

* **Aguarde o sincronismo vertical**

  Consulte :ref:`-waitvsync <mame-commandline-waitvsync>`.

.. raw:: latex

	\clearpage

.. _mamemenu-config-audio:

Opções do áudio
~~~~~~~~~~~~~~~

* **Áudio**

  Ativa o áudio ou não, para mais informações consulte
  :ref:`-sound <mame-commandline-sound>`.

		O valor predefinido é **Ligado**.

* **Compressor**

  Tenta manter o nível mais baixo e o mais alto do áudio no mesmo nível,
  atua também na redução do volume do volume do áudio caso seja muito
  alto.

O valor predefinido é **Ligado**.

* **Taxa da amostragem**

  Define a taxa da amostragem do áudio que será usada em todas as
  máquinas.

		O valor predefinido é **48000**.

* **Use amostras externas**

  Veja :ref:`-samples <mame-commandline-nosamples>`.

.. _mamemenu-config-etc:

Opções diversas
~~~~~~~~~~~~~~~

* **Ignore os avisos de emulação imperfeita**

  Faz com que o MAME não exiba as telas de aviso das máquinas com
  emulação imperfeita (tarja amarela).

		O valor predefinido é **Desligado**.

* **Selecione novamente a última máquina já executada**

  Faz com que o MAME se lembre da última máquina que foi jogada através
  da interface do MAME.

		O valor predefinido é **Ligado**.

* **Aumenta as imagens no painel direito**

  Aumenta o tamanho de qualquer uma das imagens exibidas no painel
  direito da interface do MAME, sempre mantendo a proporcionalidade da
  imagem.

		O valor predefinido é **Ligado**.

* **Trapaças**

  Ativa ou não o sistema de trapaças do MAME.

		O valor predefinido é **Desligado**.

* **Mostra o ponteiro do mouse**

  Ativa ou não a exibição do mouse na interface do MAME.

		O valor predefinido é **Ligado**.

* **Confirma se deseja encerrar a máquina ou não**

  Faz com que o MAME sempre te pergunte se quer realmente encerrar a
  emulação da máquina ou não.

		O valor predefinido é **Desligado**.

* **Omite a tela de informações ao iniciar**

  Não exibe a tela com informações sobre o sistema quando iniciar uma
  máquina.

		O valor predefinido é **Desligado**.

* **Mantenha o aspecto 4:3 nas capturas da tela**

  Impõem uma proporção de 4:3 em todas as capturas da tela.

		O valor predefinido é **Ligado**.

* **Usa uma imagem como plano de fundo**

  Permite o uso de uma imagem como papel de parede na interface do MAME.
  Escolha uma imagem **.JPG** ou **.PNG** e a renomeie para
  **background.jpg** ou **background.png**. Para fazer uso dela coloque-a
  no diretório raiz do MAME (no mesmo diretório onde o executável do
  MAME se encontra).

		O valor predefinido é **Ligado**.

* **Omite a tela da escolha da BIOS**

  Faz com que o MAME inicie a máquina com a primeira BIOS disponível
  para a máquina ao em vez de usar uma lista.

		O valor predefinido é **Desligado**.

* **Omite as partes do cardápio da seleção do programa**

  Altera a maneira com que a lista do software é exibida, em vez de
  exibir a lista na ordem predefinida pelo MAME, exibe a lista na ordem
  listada no arquivo da respectiva lista.

		O valor predefinido é **Desligado**.

* **Informação de aferição automática**

  Exibe na aba de informações gerais do lado direito da interface do
  MAME informação quanto a condição da ROM selecionada se é **BOA** ou
  **RUIM**. Assim como também verifica se a máquina usa amostras ou
  não, aferindo se a condição delas seja **BOA** ou **RUIM**. Caso a
  máquina não use amostras, aparecerá a mensagem **Nenhuma Necessária**.
  Note que essa função deixa a interface do MAME um pouco mais lenta
  devido as aferições que são feitas em tempo real a cada seleção da
  ROM.

		O valor predefinido é **Desligado**.

* **Esconde as máquinas sem ROMs da lista de disponíveis**

  Esconde da lista máquinas eletrônicas que não usam ROMs.

		O valor predefinido é **Ligado**.

.. raw:: latex

	\clearpage

.. _mamemenu-config-devices:

Mapeamento do dispositivo
~~~~~~~~~~~~~~~~~~~~~~~~~

* **Atribuição do dispositivo pistola de luz**

  Caso exista um controlador para a pistola de luz, os valores
  disponíveis são **none**, **keyboard**, **mouse**, **Lightgun** e
  **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo trackball**

  Caso exista um controlador para o trackball, os valores disponíveis
  são **none**, **keyboard**, **mouse**, **Lightgun** e **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo pedal**

  Caso exista um controlador para pedais, os valores disponíveis são
  **none**, **keyboard**, **mouse**, **Lightgun** e **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo adstick**

  Caso exista um controlador para adstick, os valores disponíveis são
  **none**, **keyboard**, **mouse**, **Lightgun** e **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo remo**

  Caso exista um controlador para remo, os valores
  disponíveis são **none**, **keyboard**, **mouse**, **Lightgun** e
  **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo discador**

  Caso exista um controlador para discadores, os valores disponíveis
  são **none**, **keyboard**, **mouse**, **Lightgun** e **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo positional**

  Caso exista um controlador de posição, os valores disponíveis são
  **none**, **keyboard**, **mouse**, **Lightgun** e **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo mouse**

  Caso exista um controlador para mouse, os valores disponíveis são
  **none**, **keyboard**, **mouse**, **Lightgun** e **joystick**.

		O valor predefinido é **mouse**.

.. raw:: latex

	\clearpage

.. _mamemenu-general-inputs:

Todas as entradas
~~~~~~~~~~~~~~~~~

* **interface do usuário**

  Aqui estão os principais atalhos já predefinidos da interface do MAME,
  todos eles podem ser alterados conforme a necessidade. Para retornar
  ao valor original tecle **DELETE** duas vezes em cima da opção.

.. raw:: html

	<p></p>

* **Visualização na tela**

  Exibe um visor na parte inferior da tela durante a emulação para a
  realização de ajustes em tempo real.

	A tecla predefinida é **Til**.

* **Interrompe o depurador**

  Atalho para entrar no depurador durante a emulação, só funciona caso
  o MAME tenha sido compilado com ferramentas de depuração.

	A tecla predefinida é **Til**.

* **Guia de configuração**

  Chama o cardápio de opções do MAME.

	A tecla predefinida é **Tab**.

* **Pausa**

  Pausa a emulação.

	A tecla predefinida é **P**.

* **Pausa - passo único**

  Avança em passos de um quadro.

	As teclas predefinidas são **P** + **Shift Esq**.

* **Rebobina - passo único**

  Retrocede em passos de um quadro.

	As teclas predefinidas são **Til** + **Shift Esq**.

* **Redefine a máquina**

  Encerra a emulação e a reinicia do zero.

	As teclas predefinidas são **F3** + **Shift Esq**.

* **Redefinição rápida**

  Reinicia sem encerrar a emulação.

	A telcla predefinida é **F3**.

* **Mostra os gráficos decodificados**

  Mostra a paleta GFX decodificada e os tilemaps dos jogos.

	A tecla predefinida é **F4**.


.. raw:: latex

	\clearpage

* **Pula quadro dec**

  Reduz o salto dos quadros de vídeo, os valores se alteram entre `auto`
  e entre `10~0`. A predefinição é `auto`, ao pressionar a tecla a opção
  sai de `auto` para a velocidade mais rápida e vai diminuindo passo a
  passo até voltar para `auto`

	A tecla predefinida é **F8**.

* **Pula quadro inc**

  Aumenta o salto dos quadros de vídeo,  os valores se alteram entre
  `auto` e entre `0~10`. A predefinição é `auto`, ao pressionar a tecla,
  a opção sai de `auto` e aumenta a velocidade passo a passo até atingir
  `auto`.

	A tecla predefinida é **F9**.

* **Supressor de velocidade**

  Acelera a velocidade da emulação da nativa para o máximo possível.

	A tecla predefinida é **F10**.

* **Avanço rápido**

  Como o exemplo anterior porém faz a emulação rodar o mais rápido
  possível enquanto a tecla estiver pressionada.

.. raw:: html

	<p></p>

* **Mostra FPS**

  Exibe quantos quadros por segundo a emulação está rodando.

	A tecla predefinida é **PgDn** em versões SDL do MAME e **Insert**
	no Windows. 

* **Salva uma captura da tela**

  Captura a tela emulada e a salva no diretório predefinido.

	A tecla predefinida é **F12**.

* **Salva o código de tempo atual**

  Salva o tempo decorrido num arquivo.

	A tecla predefinida é **F12**.

* **Grava MNG**

  Grava um vídeo em formato MNG sem áudio.

	As teclas predefinidas são **F12** + **Shift Esq**.

* **Grava AVI**

  Grava um vídeo em formato AVI.

	A teclas predefinidas são **F12** + **Shift Esq**.

* **Liga/Desliga trapaça**

  Ativa ou desativa a trapaça no jogo.

	A tecla predefinida é **F6**.

* **UI Cima**

  Move o cursor para cima.

	A tecla predefinida é **Tecla cima** ou **Cima do controle**.

* **UI Baixo**

  Move o cursor para baixo.

	A tecla predefinida é **Tecla baixo** ou **Baixo do controle**.

* **UI Esquerda**

  Move o cursor para a esquerda.

	A tecla predefinida é **Tecla esquerda** ou **Esquerda do
	controle**.

* **UI Direita**

  Move o cursor para a direita.

	A tecla predefinida é **Tecla direita** ou **Direita do controle**.

* **UI Home**

  Move o cursor para o topo da lista.

	A tecla predefinida é **Tecla home**.

* **UI Fim**

  Move o cursor para o fim da lista.

	A tecla predefinida é **Tecla end**.

* **UI Pág. cima**

  Move o cursor para o topo da lista saltando 26 linhas por vez.

	A tecla predefinida é **Tecla page up**.

* **UI Pág. baixo**

  Move o cursor para o fim da lista saltando 26 linhas por vez.

	A tecla predefinida é **Tecla page down**.

* **UI Próx. foco**

  Faz com que foco do cursor passe para a próxima janela da interface.

	A tecla predefinida é **Tab**.

* **UI Foco ant.**

  Faz com que foco do cursor passe para a anterior anterior da
  interface.

	A tecla predefinida é **Tab + Shift Esq.**.

* **UI Seleciona**

  Tecla de seleção para qualquer item selecionável.

	As teclas predefinidas são **Enter**, **Botão 0 do controle** ou
	**Tecla enter do teclado numérico**.

* **UI Cancela**

  Tecla para cancelar qualquer ação.

	A tecla predefinida é **Tecla escape ou esq**.

* **UI Mostra comentário**

  Tecla para exibir um comentário.

	A tecla predefinida é **Tecla espaço**.

* **UI Limpa**

  Tecla para apagar/zerar uma opção.

	A tecla predefinida é **Tecla delete ou del**.

* **UI Aproxima**

  Tecla para aproximar (dar zoom) na interface. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **Tecla =**.

* **UI Recua**
  Tecla para sair do zoom da interface. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **Tecla -**.

* **UI Aproximação predefinida**
  Retorna para a aproximação normal da tela.

	A tecla predefinida é **Tecla 0**.

* **UI Grupo anterior**

  Faz a lista pular para o grupo anterior. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **[**. 

* **UI Próximo grupo**

  Faz a lista pular para o próximo grupo. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **]**.

* **UI Rotaciona**

  Gira a interface.

	A tecla predefinida é **R** (não funciona).

* **Mostra o perfil**

  Exibe o analisador de desempenho (não funciona).

	A teclas predefinidas são **F11** + **Shift Esq**.

* **Alterna UI**

  Alterna a interface do usuário.

	A tecla predefinida é **Screen lock**.

* **UI Cola texto**

  Cola texto na interface do usuário (não funciona).

	As teclas predefinidas são **Screen lock** + **Shift Esq**.

* **Salva o estado**

  Salva o estado da máquina.

	As teclas predefinidas são **F7** + **Shift Esq**.

.. raw:: latex

	\clearpage

* **Carrega o estado**

  Carrega o estado da máquina.

	A tecla predefinida é **F7**.

* **UI (Primeiro) inicia fita**

  Inicia a fita na interface primária.

	A tecla predefinida é **F2**.

* **UI (Primeiro) para fita**

  Para a fita na interface primária.

	As teclas predefinidas são **F2** + **Shift Esq**.

* **UI Visualiza DAT externa**

  Exibe o DAT externo, para que a visualização do DAT seja possível é
  preciso ativar o plugin **Data Plugin** na interface ou editando o
  arquivo ``plugin.ini``, o valor da linha **data** de **0** para **1**.

	As teclas predefinidas são **Alt Esq** + **D**.

* **UI Adiciona ou remove um favorito**

  Adiciona ou remove as máquinas da lista de favoritos.

	As teclas predefinidas são **Alt Esq** + **F** (não funciona).

* **UI exporta lista**

  Exporta a lista das máquinas no formato:

	* **XML** igual ao comando **-listxml**.
	* **XML** igual ao comando **-listxml** excluindo os dispositivos.
	* **TXT** igual ao comando **-listfull**.

	As teclas predefinidas são **Alt Esq** + **E**.

* **UI Afere mídia**

  Realiza uma aferição das ROMs removendo as não disponíveis, o
  resultado é salvo no arquivo **mame_avail.ini** dentro do diretório
  **ui**.

	A tecla predefinida é **F1**.

* **Toggle Fullscreen**

  Alterna entre tela inteira e janela.

	As teclas predefinidas são **Enter** + **Alt Esq**.

* **Toggle Filter**

  Alterna entre usar ou não o filtro na tela.

	As teclas predefinidas são **F5** + **Ctrl Esq**.

* **Decrease Prescaling**

  Reduz a pré-escala dos pixels.

	As teclas predefinidas são **F6** + **Ctrl Esq**.


.. raw:: latex

	\clearpage

* **Increase Prescaling**

  Aumenta a pré-escala de dos pixels.

	As teclas predefinidas são **F7** + **Ctrl Esq**.

* **Record Rendered Video**

  Grava o vídeo usando todos os efeitos e filtros ativos na tela.

	As teclas predefinidas são **F12** + **Ctrl+Alt Esq**.

Controles do jogador 1 ~ 10
~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Definições para todos os botões e controles usados pela máquina
  separado por jogador, entre o jogador 1 até o 10. Abaixo a lista das
  opções predefinidas para o jogador 1 que podem ser alteradas na
  própria interface do MAME.


.. _mamemenu-general-inputs-P1:

Predefinições para o jogador 1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Controles do jogador 1              | Predefinição                  |
+======================================+===============================+
|  J1 cima                             | cima ou joy 1 cima            |
+--------------------------------------+-------------------------------+
|  J1 baixo                            | baixo ou joy 1 baixo          |
+--------------------------------------+-------------------------------+
|  J1 esquerda                         | esquerda ou joy 1 esquerda    |
+--------------------------------------+-------------------------------+
|  J1 direita                          | direita ou joy 1 direita      |
+--------------------------------------+-------------------------------+
|  J1 lado direito/cima                | I ou joy 1 botão 1            |
+--------------------------------------+-------------------------------+
|  J1 lado direito/baixo               | K ou joy 1 botão 2            |
+--------------------------------------+-------------------------------+
|  J1 lado direito/esquerdo            | J ou joy 1 botão 0            |
+--------------------------------------+-------------------------------+
|  J1 lado direito/direito             | L ou joy 1 botão 3            |
+--------------------------------------+-------------------------------+
|  J1 lado esquerdo/cima               | E ou joy 1 cima               |
+--------------------------------------+-------------------------------+
|  J1 lado esquerdo/baixo              | D ou joy 1 baixo              |
+--------------------------------------+-------------------------------+
|  J1 lado esquerdo/esquerdo           | S ou joy 1 esquerda           |
+--------------------------------------+-------------------------------+
|  J1 lado esquerdo/direito            | F ou joy 1 direita            |
+--------------------------------------+-------------------------------+
|  J1 botão 1                          | joy 1 botão 3                 |
+--------------------------------------+-------------------------------+
|  J1 botão 2                          | joy 1 botão 6                 |
+--------------------------------------+-------------------------------+
|  J1 botão 3                          | joy 1 botão 0                 |
+--------------------------------------+-------------------------------+
|  J1 botão 4                          | joy 1 botão 7                 |
+--------------------------------------+-------------------------------+
|  J1 botão 5                          | joy 1 botão 2                 |
+--------------------------------------+-------------------------------+
|  J1 botão 6                          | joy 1 botão 1                 |
+--------------------------------------+-------------------------------+
|  J1 botão 7                          | C ou joy 1 botão 6            |
+--------------------------------------+-------------------------------+
|  J1 botão 8                          | V ou joy 1 botão 7            |
+--------------------------------------+-------------------------------+
|  J1 botão 9                          | B ou joy 1 botão 8            |
+--------------------------------------+-------------------------------+
|  J1 botão 10                         | N ou joy 1 botão 9            |
+--------------------------------------+-------------------------------+
|  J1 botão 11                         | M ou joy 1 botão 10           |
+--------------------------------------+-------------------------------+
|  J1 botão 12                         | vírgula ou joy 1 botão 11     |
+--------------------------------------+-------------------------------+
|  J1 botão 13                         | Stop                          |
+--------------------------------------+-------------------------------+
|  J1 botão 14                         | Barra inc. direita            |
+--------------------------------------+-------------------------------+
|  J1 botão 15                         | Shift Direito                 |
+--------------------------------------+-------------------------------+
|  J1 botão 16                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J1 start                            | 1                             |
+--------------------------------------+-------------------------------+
|  J1 select                           | 5                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong A                        | A                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong B                        | B                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong C                        | C                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong D                        | D                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong E                        | E                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong F                        | F                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong G                        | G                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong H                        | H                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong I                        | I                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong J                        | J                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong K                        | K                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong L                        | L                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong M                        | M                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong O                        | O                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong P                        | Dois pontos                   |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Q                        | Q                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Kan                      | Control esquerdo              |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Pon                      | Alt esquerdo                  |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Chi                      | Espaço                        |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Reach                    | Shift                         |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Ron                      | Z                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Bet                      | 3                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Last Chance              | Alt direito                   |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Score                    | Control direito               |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Double Up                | Shift direito                 |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Flip Flop                | Y                             |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Big                      | Return                        |
+--------------------------------------+-------------------------------+
|  J1 Mahjong Small                    | Backspace                     |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda A/1                     | A                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda B/2                     | B                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda C/3                     | C                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda D/4                     | D                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda E/5                     | E                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda F/6                     | F                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda G/7                     | G                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda H/8                     | H                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda Sim                     | M                             |
+--------------------------------------+-------------------------------+
|  J1 Hanafuda Não                     | N                             |
+--------------------------------------+-------------------------------+
|  Chave dentro (in)                   | Q                             |
+--------------------------------------+-------------------------------+
|  Chave fora (out)                    | W                             |
+--------------------------------------+-------------------------------+
|  Serviço                             | 9                             |
+--------------------------------------+-------------------------------+
|  Contabilidade                       | 0                             |
+--------------------------------------+-------------------------------+
|  Porta                               | O                             |
+--------------------------------------+-------------------------------+
|  Prêmio                              | I                             |
+--------------------------------------+-------------------------------+
|  Aposta                              | M                             |
+--------------------------------------+-------------------------------+
|  Negocia                             | 2                             |
+--------------------------------------+-------------------------------+
|  Mantém                              | L                             |
+--------------------------------------+-------------------------------+
|  Leva a pontuação                    | 4                             |
+--------------------------------------+-------------------------------+
|  Dobra                               | 3                             |
+--------------------------------------+-------------------------------+
|  Metade da aposta                    | D                             |
+--------------------------------------+-------------------------------+
|  Alto                                | A                             |
+--------------------------------------+-------------------------------+
|  Baixo                               | S                             |
+--------------------------------------+-------------------------------+
|  Mantém 1                            | Z                             |
+--------------------------------------+-------------------------------+
|  Mantém 2                            | X                             |
+--------------------------------------+-------------------------------+
|  Mantém 3                            | C                             |
+--------------------------------------+-------------------------------+
|  Mantém 4                            | V                             |
+--------------------------------------+-------------------------------+
|  Mantém 5                            | B                             |
+--------------------------------------+-------------------------------+
|  Cancela                             | N                             |
+--------------------------------------+-------------------------------+
|  Interrompe o carretel 1             | X                             |
+--------------------------------------+-------------------------------+
|  Interrompe o carretel 2             | C                             |
+--------------------------------------+-------------------------------+
|  Interrompe o carretel 3             | V                             |
+--------------------------------------+-------------------------------+
|  Interrompe o carretel 4             | B                             |
+--------------------------------------+-------------------------------+
|  Interrompe todos os carreteis       | Z                             |
+--------------------------------------+-------------------------------+
|  J1 pedal 1 analógico                | ...                           |
+--------------------------------------+-------------------------------+
|  J1 pedal 1 analógico inc            | Control esq. ou joy 1 botão 0 |
+--------------------------------------+-------------------------------+
|  J1 pedal 1 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J1 pedal 2 analog                   | n/a                           |
+--------------------------------------+-------------------------------+
|  J1 pedal 2 analógico inc            | Alt esq. ou joy 1 botão 1     |
+--------------------------------------+-------------------------------+
|  J1 pedal 2 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J1 pedal 3 analog                   | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J1 pedal 3 analógico inc            | Espaço ou joy 1 botão 2       |
+--------------------------------------+-------------------------------+
|  J1 pedal 3 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Remo analógico                      | ...                           |
+--------------------------------------+-------------------------------+
|  Remo analógico inc                  | Direita                       |
+--------------------------------------+-------------------------------+
|  Remo analógico dec                  | Esquerda                      |
+--------------------------------------+-------------------------------+
|  Remo V analog                       | ...                           |
+--------------------------------------+-------------------------------+
|  Remo V analógico inc                | Baixo                         |
+--------------------------------------+-------------------------------+
|  Remo V analógico dec                | Cima                          |
+--------------------------------------+-------------------------------+
|  Posicionamento analógico            | ...                           |
+--------------------------------------+-------------------------------+
|  Posicionamento analógico inc        | Direita                       |
+--------------------------------------+-------------------------------+
|  Posicionamento analógico dec        | Esquerda                      |
+--------------------------------------+-------------------------------+
|  Posicionamento V analog             | ...                           |
+--------------------------------------+-------------------------------+
|  Posicionamento V analógico inc      | Baixo                         |
+--------------------------------------+-------------------------------+
|  Posicionamento V analógico dec      | Cima                          |
+--------------------------------------+-------------------------------+
|  Discador analógico                  | ...                           |
+--------------------------------------+-------------------------------+
|  Discador analógico inc              | Baixo                         |
+--------------------------------------+-------------------------------+
|  Discador analógico dec              | Cima                          |
+--------------------------------------+-------------------------------+
|  Discador V analógico                | ...                           |
+--------------------------------------+-------------------------------+
|  Discador V analógico inc            | Baixo                         |
+--------------------------------------+-------------------------------+
|  Discador V analógico dec            | Cima                          |
+--------------------------------------+-------------------------------+
|  Trilha X analógico                  | ...                           |
+--------------------------------------+-------------------------------+
|  Trilha X analógico inc              | Direita                       |
+--------------------------------------+-------------------------------+
|  Trilha X analógico dec              | Esquerda                      |
+--------------------------------------+-------------------------------+
|  Trilha Y analógico                  | ...                           |
+--------------------------------------+-------------------------------+
|  Trilha Y analógico inc              | Baixo                         |
+--------------------------------------+-------------------------------+
|  Trilha Y analógico dec              | Cima                          |
+--------------------------------------+-------------------------------+
|  Controle AD X analógico             | ...                           |
+--------------------------------------+-------------------------------+
|  Controle AD X analógico inc         | Direita                       |
+--------------------------------------+-------------------------------+
|  Controle AD X analógico dec         | Esquerda                      |
+--------------------------------------+-------------------------------+
|  Controle AD Y analog                | ...                           |
+--------------------------------------+-------------------------------+
|  Controle AD Y analógico inc         | Baixo                         |
+--------------------------------------+-------------------------------+
|  Controle AD Y analógico dec         | Cima                          |
+--------------------------------------+-------------------------------+
|  AD stick Z analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  AD stick Z analógico inc            | Z                             |
+--------------------------------------+-------------------------------+
|  AD stick Z analógico dec            | A                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz X analógico          | ...                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz X analógico inc      | Direita                       |
+--------------------------------------+-------------------------------+
|  Pistola de luz X analógico dec      | Esquerda                      |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico          | ...                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico inc      | Baixo                         |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico dec      | Cima                          |
+--------------------------------------+-------------------------------+
|  Mouse X analógico                   | ...                           |
+--------------------------------------+-------------------------------+
|  Mouse X analógico inc               | Direita                       |
+--------------------------------------+-------------------------------+
|  Mouse X analógico dec               | Esquerda                      |
+--------------------------------------+-------------------------------+
|  Mouse Y analógico                   | ...                           |
+--------------------------------------+-------------------------------+
|  Mouse Y analógico inc               | Baixo                         |
+--------------------------------------+-------------------------------+
|  Mouse Y analógico dec               | Cima                          |
+--------------------------------------+-------------------------------+

.. _mamemenu-general-inputs-P2:

Predefinições para o jogador 2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Controles do jogador 2              | Predefinição                  |
+======================================+===============================+
|  J2 cima                             | R                             |
+--------------------------------------+-------------------------------+
|  J2 baixo                            | F                             |
+--------------------------------------+-------------------------------+
|  J2 esquerda                         | D                             |
+--------------------------------------+-------------------------------+
|  J2 direita                          | G                             |
+--------------------------------------+-------------------------------+
|  J2 lado direito/cima                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 lado direito/baixo               | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 lado direito/esquerdo            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 lado direito/direito             | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 lado esquerdo/cima               | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 lado esquerdo/baixo              | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 lado esquerdo/esquerdo           | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 lado esquerdo/direito            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 1                          | A                             |
+--------------------------------------+-------------------------------+
|  J2 botão 2                          | S                             |
+--------------------------------------+-------------------------------+
|  J2 botão 3                          | Q                             |
+--------------------------------------+-------------------------------+
|  J2 botão 4                          | W                             |
+--------------------------------------+-------------------------------+
|  J2 botão 5                          | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 6                          | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 7                          | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 8                          | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 9                          | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 10                         | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 11                         | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 12                         | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 13                         | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 14                         | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 15                         | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 botão 16                         | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 start                            | 2                             |
+--------------------------------------+-------------------------------+
|  J2 select                           | 6                             |
+--------------------------------------+-------------------------------+
|  J2 Mahjong A                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong B                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong C                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong D                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong E                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong F                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong G                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong H                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong I                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong J                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong K                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong L                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong M                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong O                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong P                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Q                        | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Kan                      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Pon                      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Chi                      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Reach                    | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Ron                      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Bet                      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Last Chance              | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Score                    | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Double Up                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Flip Flop                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Big                      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Mahjong Small                    | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda A/1                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda B/2                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda C/3                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda D/4                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda E/5                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda F/6                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda G/7                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda H/8                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda Sim                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 Hanafuda Não                     | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 pedal 1 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  J2 pedal 1 analógico inc            | A                             |
+--------------------------------------+-------------------------------+
|  J2 pedal 1 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 pedal 2 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  J2 pedal 2 analógico inc            | S                             |
+--------------------------------------+-------------------------------+
|  J2 pedal 2 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 pedal 3 analógico                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J2 pedal 3 analógico inc            | Q                             |
+--------------------------------------+-------------------------------+
|  J2 pedal 3 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Remo 2 analógico                    | n/a                           |
+--------------------------------------+-------------------------------+
|  Remo 2 analógico inc                | G                             |
+--------------------------------------+-------------------------------+
|  Remo 2 analógico dec                | D                             |
+--------------------------------------+-------------------------------+
|  Remo V 2 analógico                  | n/a                           |
+--------------------------------------+-------------------------------+
|  Remo V 2 analógico inc              | F                             |
+--------------------------------------+-------------------------------+
|  Remo V 2 analógico dec              | R                             |
+--------------------------------------+-------------------------------+
|  Posicionamento 2 analógico          | n/a                           |
+--------------------------------------+-------------------------------+
|  Posicionamento 2 analógico inc      | G                             |
+--------------------------------------+-------------------------------+
|  Posicionamento 2 analógico dec      | D                             |
+--------------------------------------+-------------------------------+
|  Posicionamento V 2 analógico        | n/a                           |
+--------------------------------------+-------------------------------+
|  Posicionamento V 2 analógico inc    | F                             |
+--------------------------------------+-------------------------------+
|  Posicionamento V 2 analógico dec    | R                             |
+--------------------------------------+-------------------------------+
|  Discador 2 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Discador 2 analógico inc            | G                             |
+--------------------------------------+-------------------------------+
|  Discador 2 analógico dec            | D                             |
+--------------------------------------+-------------------------------+
|  Discador V 2 analógico              | n/a                           |
+--------------------------------------+-------------------------------+
|  Discador V 2 analógico inc          | F                             |
+--------------------------------------+-------------------------------+
|  Discador V 2 analógico dec          | R                             |
+--------------------------------------+-------------------------------+
|  Trilha X 2 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Trilha X 2 analógico inc            | G                             |
+--------------------------------------+-------------------------------+
|  Trilha X 2 analógico dec            | D                             |
+--------------------------------------+-------------------------------+
|  Trilha Y 2 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Trilha Y 2 analógico inc            | F                             |
+--------------------------------------+-------------------------------+
|  Trilha Y 2 analógico dec            | R                             |
+--------------------------------------+-------------------------------+
|  Controle AD X 2 analógico           | n/a                           |
+--------------------------------------+-------------------------------+
|  Controle AD X 2 analógico inc       | G                             |
+--------------------------------------+-------------------------------+
|  Controle AD X 2 analógico dec       | D                             |
+--------------------------------------+-------------------------------+
|  Controle AD Y 2 analógico           | n/a                           |
+--------------------------------------+-------------------------------+
|  Controle AD Y 2 analógico inc       | F                             |
+--------------------------------------+-------------------------------+
|  Controle AD Y 2 analógico dec       | R                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 2 analógico        | n/a                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 2 analógico inc    | G                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 2 analógico dec    | D                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico          | n/a                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico inc      | F                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico dec      | R                             |
+--------------------------------------+-------------------------------+
|  Mouse X 2 analógico                 | n/a                           |
+--------------------------------------+-------------------------------+
|  Mouse X 2 analógico inc             | G                             |
+--------------------------------------+-------------------------------+
|  Mouse X 2 analógico dec             | D                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 2 analógico                 | n/a                           |
+--------------------------------------+-------------------------------+
|  Mouse Y 2 analógico inc             | F                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 2 analógico dec             | R                             |
+--------------------------------------+-------------------------------+

.. _mamemenu-general-inputs-P3:

Predefinições para o jogador 3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Controles do jogador 3              | Predefinição                  |
+======================================+===============================+
|  J3 cima                             | I                             |
+--------------------------------------+-------------------------------+
|  J3 baixo                            | K                             |
+--------------------------------------+-------------------------------+
|  J3 esquerda                         | J                             |
+--------------------------------------+-------------------------------+
|  J3 direita                          | L                             |
+--------------------------------------+-------------------------------+
|  J3 lado direito/cima                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 lado direito/baixo               | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 lado direito/esquerdo            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 lado direito/direito             | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 lado esquerdo/cima               | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 lado esquerdo/baixo              | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 lado esquerdo/esquerdo           | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 lado esquerdo/direito            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 botão 1                          | Control direito               |
+--------------------------------------+-------------------------------+
|  J3 botão 2                          | Shift direito                 |
+--------------------------------------+-------------------------------+
|  J3 botão 3                          | Return                        |
+--------------------------------------+-------------------------------+
|  J3 botão 4                          | W                             |
+--------------------------------------+-------------------------------+
|  J3 botão 5                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 6                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 7                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 8                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 9                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 10                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 11                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 12                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 13                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 14                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 15                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 botão 16                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 start                            | 3                             |
+--------------------------------------+-------------------------------+
|  J3 select                           | 7                             |
+--------------------------------------+-------------------------------+
|  J3 pedal 1 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 pedal 1 analógico inc            | Control direito               |
+--------------------------------------+-------------------------------+
|  J3 pedal 1 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 pedal 2 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  J3 pedal 2 analógico inc            | Shift direito                 |
+--------------------------------------+-------------------------------+
|  J3 pedal 2 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 pedal 3 analógico                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J3 pedal 3 analógico inc            | Return                        |
+--------------------------------------+-------------------------------+
|  J3 pedal 3 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Remo 3 analógico                    | n/a                           |
+--------------------------------------+-------------------------------+
|  Remo 3 analógico inc                | L                             |
+--------------------------------------+-------------------------------+
|  Remo 3 analógico dec                | J                             |
+--------------------------------------+-------------------------------+
|  Remo V 3 analógico                  | n/a                           |
+--------------------------------------+-------------------------------+
|  Remo V 3 analógico inc              | K                             |
+--------------------------------------+-------------------------------+
|  Remo V 3 analógico dec              | I                             |
+--------------------------------------+-------------------------------+
|  Posicionamento 3 analógico          | n/a                           |
+--------------------------------------+-------------------------------+
|  Posicionamento 3 analógico inc      | L                             |
+--------------------------------------+-------------------------------+
|  Posicionamento 3 analógico dec      | J                             |
+--------------------------------------+-------------------------------+
|  Posicionamento V 3 analógico        | n/a                           |
+--------------------------------------+-------------------------------+
|  Posicionamento V 3 analógico inc    | K                             |
+--------------------------------------+-------------------------------+
|  Posicionamento V 3 analógico dec    | I                             |
+--------------------------------------+-------------------------------+
|  Discador 3 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Discador 3 analógico inc            | L                             |
+--------------------------------------+-------------------------------+
|  Discador 3 analógico dec            | J                             |
+--------------------------------------+-------------------------------+
|  Discador V 3 analógico              | n/a                           |
+--------------------------------------+-------------------------------+
|  Discador V 3 analógico inc          | K                             |
+--------------------------------------+-------------------------------+
|  Discador V 3 analógico dec          | I                             |
+--------------------------------------+-------------------------------+
|  Trilha X 3 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Trilha X 3 analógico inc            | L                             |
+--------------------------------------+-------------------------------+
|  Trilha X 3 analógico dec            | J                             |
+--------------------------------------+-------------------------------+
|  Trilha Y 3 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Trilha Y 3 analógico inc            | K                             |
+--------------------------------------+-------------------------------+
|  Trilha Y 3 analógico dec            | I                             |
+--------------------------------------+-------------------------------+
|  Controle AD X 3 analógico           | n/a                           |
+--------------------------------------+-------------------------------+
|  Controle AD X 3 analógico inc       | L                             |
+--------------------------------------+-------------------------------+
|  Controle AD X 3 analógico dec       | J                             |
+--------------------------------------+-------------------------------+
|  Controle AD Y 3 analógico           | n/a                           |
+--------------------------------------+-------------------------------+
|  Controle AD Y 3 analógico inc       | K                             |
+--------------------------------------+-------------------------------+
|  Controle AD Y 3 analógico dec       | I                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 3 analógico        | n/a                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 3 analógico inc    | L                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 3 analógico dec    | J                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico          | n/a                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico inc      | K                             |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico dec      | I                             |
+--------------------------------------+-------------------------------+
|  Mouse X 3 analógico                 | n/a                           |
+--------------------------------------+-------------------------------+
|  Mouse X 3 analógico inc             | L                             |
+--------------------------------------+-------------------------------+
|  Mouse X 3 analógico dec             | J                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 3 analógico                 | n/a                           |
+--------------------------------------+-------------------------------+
|  Mouse Y 3 analógico inc             | K                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 3 analógico dec             | I                             |
+--------------------------------------+-------------------------------+

.. _mamemenu-general-inputs-P4:

Predefinições para o jogador 4
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Controles do jogador 4              | Predefinição                  |
+======================================+===============================+
|  J4 cima                             | 8 teclado numérico            |
+--------------------------------------+-------------------------------+
|  J4 baixo                            | 2 teclado numérico            |
+--------------------------------------+-------------------------------+
|  J4 esquerda                         | 4 teclado numérico            |
+--------------------------------------+-------------------------------+
|  J4 direita                          | 6 teclado numérico            |
+--------------------------------------+-------------------------------+
|  J4 lado direito/cima                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 lado direito/baixo               | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 lado direito/esquerdo            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 lado direito/direito             | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 lado esquerdo/cima               | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 lado esquerdo/baixo              | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 lado esquerdo/esquerdo           | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 lado esquerdo/direito            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 botão 1                          | 0 teclado numérico            |
+--------------------------------------+-------------------------------+
|  J4 botão 2                          | Del teclado numérico          |
+--------------------------------------+-------------------------------+
|  J4 botão 3                          | Return teclado numérico       |
+--------------------------------------+-------------------------------+
|  J4 botão 4                          | W                             |
+--------------------------------------+-------------------------------+
|  J4 botão 5                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 6                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 7                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 8                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 9                          | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 10                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 11                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 12                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 13                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 14                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 15                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 botão 16                         | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 start                            | 4                             |
+--------------------------------------+-------------------------------+
|  J4 select                           | 8                             |
+--------------------------------------+-------------------------------+
|  J4 pedal 1 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 pedal 1 analógico inc            | 0 teclado numérico            |
+--------------------------------------+-------------------------------+
|  J4 pedal 1 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 pedal 2 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  J4 pedal 2 analógico inc            | Del teclado numérico          |
+--------------------------------------+-------------------------------+
|  J4 pedal 2 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 pedal 3 analógico                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  J4 pedal 3 analógico inc            | Enter teclado numérico        |
+--------------------------------------+-------------------------------+
|  J4 pedal 3 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Remo 4 analógico                    | n/a                           |
+--------------------------------------+-------------------------------+
|  Remo 4 analógico inc                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Remo 4 analógico dec                | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Remo V 4 analógico                  | n/a                           |
+--------------------------------------+-------------------------------+
|  Remo V 4 analógico inc              | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Remo V 4 analógico dec              | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Posicionamento 4 analógico          | n/a                           |
+--------------------------------------+-------------------------------+
|  Posicionamento 4 analógico inc      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Posicionamento 4 analógico dec      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Posicionamento V 4 analógico        | n/a                           |
+--------------------------------------+-------------------------------+
|  Posicionamento V 4 analógico inc    | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Posicionamento V 4 analógico dec    | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Discador 4 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Discador 4 analógico inc            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Discador 4 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Discador V 4 analógico              | n/a                           |
+--------------------------------------+-------------------------------+
|  Discador V 4 analógico inc          | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Discador V 4 analógico dec          | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Trilha X 4 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Trilha X 4 analógico inc            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Trilha X 4 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Trilha Y 4 analógico                | n/a                           |
+--------------------------------------+-------------------------------+
|  Trilha Y 4 analógico inc            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Trilha Y 4 analógico dec            | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Controle AD X 4 analógico           | n/a                           |
+--------------------------------------+-------------------------------+
|  Controle AD X 4 analógico inc       | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Controle AD X 4 analógico dec       | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Controle AD Y 4 analógico           | n/a                           |
+--------------------------------------+-------------------------------+
|  Controle AD Y 4 analógico inc       | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Controle AD Y 4 analógico dec       | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 4 analógico        | n/a                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 4 analógico inc    | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Pistola de luz X 4 analógico dec    | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico          | n/a                           |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico inc      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Pistola de luz Y analógico dec      | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Mouse X 4 analógico                 | n/a                           |
+--------------------------------------+-------------------------------+
|  Mouse X 4 analógico inc             | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Mouse X 4 analógico dec             | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Mouse Y 4 analógico                 | n/a                           |
+--------------------------------------+-------------------------------+
|  Mouse Y 4 analógico inc             | Nenhum                        |
+--------------------------------------+-------------------------------+
|  Mouse Y 4 analógico dec             | Nenhum                        |
+--------------------------------------+-------------------------------+

As predefinições para o jogador 5 em diante estão vazias e podem ser
customizadas conforme a necessidade.

.. _mamemenu-other-controls:

* **Outros controles**

  Muda a configuração dos botões usados para crédito, serviço, inicio
  de jogadores, etc. Abaixo a lista das opções predefinidas que podem
  ser alteradas na própria interface do MAME.

+--------------------------------------+-------------------------------+
|  Inicia jogador 1                    |  1                            |
+--------------------------------------+-------------------------------+
|  Inicia jogador 2                    |  2                            |
+--------------------------------------+-------------------------------+
|  Inicia jogador 3                    |  3                            |
+--------------------------------------+-------------------------------+
|  Inicia jogador 4                    |  4                            |
+--------------------------------------+-------------------------------+
|  Inicia jogador 5                    |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Inicia jogador 6                    |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Inicia jogador 7                    |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Inicia jogador 8                    |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 1                             |  5                            |
+--------------------------------------+-------------------------------+
|  Ficha 2                             |  6                            |
+--------------------------------------+-------------------------------+
|  Ficha 3                             |  7                            |
+--------------------------------------+-------------------------------+
|  Ficha 4                             |  8                            |
+--------------------------------------+-------------------------------+
|  Ficha 5                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 6                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 7                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 8                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 9                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 10                            |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 11                            |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Ficha 12                            |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Conta 1                             |  Backspace                    |
+--------------------------------------+-------------------------------+
|  Serviço 1                           |  9                            |
+--------------------------------------+-------------------------------+
|  Serviço 2                           |  0                            |
+--------------------------------------+-------------------------------+
|  Serviço 3                           |  Tecla menos                  |
+--------------------------------------+-------------------------------+
|  Serviço 4                           |  Tecla igual                  |
+--------------------------------------+-------------------------------+
|  Tilt 1                              |  T                            |
+--------------------------------------+-------------------------------+
|  Tilt 2                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Tilt 3                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Tilt 4                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Liga                                |  F1                           |
+--------------------------------------+-------------------------------+
|  Desliga                             |  F2                           |
+--------------------------------------+-------------------------------+
|  Serviço                             |  F2                           |
+--------------------------------------+-------------------------------+
|  Tilt                                |  T                            |
+--------------------------------------+-------------------------------+
|  Trava interna da porta              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Redefine a memória                  |  F1                           |
+--------------------------------------+-------------------------------+
|  Abaixa o volume                     |  Tecla menos                  |
+--------------------------------------+-------------------------------+
|  Aumenta o volume                    |  Tecla igual                  |
+--------------------------------------+-------------------------------+
|  Teclado numérico                    |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Teclado                             |  None                         |
+--------------------------------------+-------------------------------+

.. raw:: latex

	\clearpage

.. _mamemenu-advanced-options:

Opções avançadas
~~~~~~~~~~~~~~~~

Opções de desempenho
^^^^^^^^^^^^^^^^^^^^

* **Salto automático dos quadros**

  Ignora quadros de forma automática visando manter a velocidade da
  emulação.

	O valor predefinido é **Desligado**.

* **Salto de quadro**

  Define uma quantidade fixa de quadros a serem ignorados visando manter
  a velocidade da emulação.

	O valor predefinido é **0**

* **Supressão da velocidade**

  Ativa a supressão de velocidade da emulação para que a máquina
  emulada rode em sua velocidade nativa em vez da velocidade do
  processador em que a máquina está sendo emulada.

	O valor predefinido é **Ligado**.

* **Mute quando a supressão da velocidade estiver desligada**

  Silencia o áudio quando a supressão de velocidade estiver desligado.

	O valor predefinido é **Desligado**.

* **Dormir**

  Reduz o consumo de processamento quando o MAME estiver parado sem
  fazer nada.

	O valor predefinido é **Ligado**.

* **Velocidade**

  Controla a velocidade do jogo com relação ao tempo de emulação.

	O valor predefinido é **1**

* **Ajuste a velocidade para bater com a taxa de atualização**

  Controla a velocidade da emulação de forma automática mantendo a taxa
  de atualização de tela mais lenta em referência com a taxa de
  atualização de tela do computador que está rodando a emulação.

	O valor predefinido é **Desligado**.

* **Baixa latência**

  Reduz a latência (atraso) dos dispositivos de entrada como joysticks
  por exemplo. Para mais informações consulte :ref:`-[no]lowlatency
  <mame-commandline-lowlatency>`.

.. raw:: latex

	\clearpage

.. _mamemenu-advanced-screen-rotation:

Opções da Rotação da Tela
^^^^^^^^^^^^^^^^^^^^^^^^^

* **Rotação**

  Permite que a orientação da tela mude conforme a orientação de tela do
  jogo.

	O valor predefinido é **Ligado**.

* **Rotacione à direita**

  Rotacione a tela em 90 graus sentido horário.

	O valor predefinido é **Desligado**.

* **Rotacione à esquerda**

  Rotacione a tela em 90 graus sentido anti-horário.

	O valor predefinido é **Desligado**.

* **Auto rotacione à direita**

  Rotacione automaticamente a tela em 90 graus sentido horário caso
  a tela esteja orientada verticalmente.

	O valor predefinido é **Desligado**.

* **Auto rotacione à esquerda**

  Rotacione automaticamente a tela em 90 graus sentido anti-horário
  caso a tela esteja orientada verticalmente.

	O valor predefinido é **Desligado**.

* **Vire o eixo X**

  Inverte a tela da esquerda para a direita.

	O valor predefinido é **Desligado**.

* **Vire o eixo Y**

  Inverte a tela da direita para a esquerda.

	O valor predefinido é **Desligado**.

.. _mamemenu-advanced-illustration:

Opções das ilustrações
^^^^^^^^^^^^^^^^^^^^^^

* **Aproxime a área da tela**

  Aproxima a região da tela emulada quando estiver numa ilustração.

	O valor predefinido é **Desligado**.

.. _mamemenu-advanced-state-playback:

Opções do estado/reprodução
^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **Salve/restaure automático**

  Em sistema compatíveis, carrega automaticamente o estado da máquina e
  a salva ao encerrar.

	O valor predefinido é **Desligado**.

* **Permita o rebobinamento**

  Permite o rebobinamento do estado da máquina.

	O valor predefinido é **Desligado**.

* **Capacidade de rebobinamento**

  Reserva uma quantidade em Megabytes da memória para rebobinamento.

	O valor predefinido é **100**

* **Filtro bilinear para as capturas da tela**

  Define se os vídeos ou as capturas da tela terão o filtro aplicado.

	O valor predefinido é **Ligado**.

* **Marca de queimado**

  Cria uma captura da tela com marcas de fósforo queimado.

	O valor predefinido é **Desligado**.

.. _mamemenu-advanced-input-options:

Opções da entrada
^^^^^^^^^^^^^^^^^

* **Trava da ficha**

  Faz com que a máquina ignore a inserção de fichas em momentos que a
  máquina não está pronta para recebê-las.

	O valor predefinido é **Ligado**.

* **Mouse**

  Permite o uso de um mouse nas máquinas.

	O valor predefinido é **Desligado**.

* **Controle**

  Permite o uso de um controle nas máquinas.

	O valor predefinido é **Ligado**.

* **Pistola de luz**

  Ativa o uso do uma pistola de luz.

	O valor predefinido é **Desligado**.

* **Mais de um teclado**

  Permite o uso de mais de um teclado para cada entrada compatível.

	O valor predefinido é **Desligado**.

.. raw:: latex

	\clearpage

* **Mais de um mouse**

  Permite o uso de mais de um mouse para cada entrada compatível.

	O valor predefinido é **Desligado**.

* **Steadykey**

  Alguns sistemas exigem que dois ou mais botões sejam pressionados
  exatamente ao mesmo tempo para realizar movimentos ou comandos
  especiais. Devido a limitação do hardware do teclado, pode ser difícil
  ou até mesmo impossível de realizar usando um teclado comum. Essa
  opção seleciona diferentes modos de manuseio o que torna mais fácil
  registrar o pressionamento simultâneo das teclas, porém tem a
  desvantagem de deixar a sua capacidade de resposta mais lenta.

	O valor predefinido é **Desligado**.

* **IU ativa**

  Ativa a opção para que a interface do usuário se sobreponha a do
  teclado emulado caso esteja presente.

	O valor predefinido é **Desligado**.

* **Recarga fora da tela**

  Converte o botão 2 da pistola de luz como recarga fora da tela.

	O valor predefinido é **Desligado**.

* **Zona morta do controle**

  Permite fazer o ajuste fino do ponto morto do controle ou manche.

	O valor predefinido é **0.3**

* **Saturação do controle**

  Faz o ajuste findo do eixo de fim de curso do controle.

	O valor predefinido é **0.85**

* **Teclado natural**

  Ativa ou não o uso de um teclado natural.

	O valor predefinido é **Desligado**.

* **Comando contraditório**

  Aceita comandos contraditórios e simultâneos no controle digital como
  esquerda e direita ou cima e baixo.

	O valor predefinido é **Desligado**.

* **Impulso de ficha**

  Define o tempo de impulso da ficha.

	O valor predefinido é **0**

.. _mamemenu-plugins:

Plug-ins
--------

* **Autofire plugin**

  Configuração de turbo dos botões.

.. raw:: html

	<p></p>

* **Lua SLAX XML parser**

  Interpretador `SLAXML <https://github.com/Phrogz/SLAXML>`_.

.. raw:: html

	<p></p>

* **Hiscore support**

  Suporte para salvar a pontuação das máquinas ou *hiscore* em um
  arquivo ``hiscore.dat``

.. raw:: html

	<p></p>

* **Console plugin**

  Ativa um console de comandos lua no prompt de comando ou no terminal
  usado para invocar o MAME.

.. raw:: html

	<p></p>

* **json library**

  Ativa o suporte para arquivos
  `json <http://dkolf.de/src/dkjson-lua.fsl/home>`_ (*JavaScript Object
  Notation*) usando Lua.

.. raw:: html

	<p></p>

* **Dummy test plugin**

  Um exemplo vazio com um teste que não faz nada de como criar o seu
  plug-in.

.. raw:: html

	<p></p>

* **GDB stub plugin**

  Plug-in de depuração do MAME para exibir a ordem dos registros gdb.

.. raw:: html

	<p></p>

* **Cheat plugin**

  Permite a ativação de uma trapaça sem precisar iniciar o mame com a
  opção ``-cheat``.

.. raw:: html

	<p></p>

* **Timer plugin**

  Registra o tempo jogado ou o tempo que ficou em uma determinada
  máquina.

.. raw:: html

	<p></p>

* **Data plugin**

  Permite o uso de arquivos \*.dat com informações que serão exibidas
  para o usuário como o ``command.dat``, estes arquivos ficam dentro
  do diretório **dats**.

.. raw:: html

	<p></p>

* **Cheat finder helper library**

  Biblioteca para a assistência de localização de novas trapaças.

.. raw:: html

	<p></p>

* **Discord presence**

  Registra a sua presença no `Discord <https://discord.com>`_,
  exibindo o que você está jogando.

.. raw:: html

	<p></p>

* **Layout helper plugin**

  Usado quando o seu layout precisar rodar scripts Lua.

.. raw:: html

	<p></p>

* **IOPort name/translation plugin**

  Salva todos os nomes das portas usada pela máquina em
  ``ctrl\portname\nome_da_maquina.json``. Para usar, inicie a máquina,
  vá em *Plug-ins* e selecione **Portas das entradas**.

.. _mamemenu-config-saving:

Salve a Configuração
~~~~~~~~~~~~~~~~~~~~

Salva todas as alterações feitas.

Retorna ao menu anterior
~~~~~~~~~~~~~~~~~~~~~~~~

Retorna para a tela anterior.


.. _mamemenu-config-machine:

Configure a máquina
-------------------

Permite que você configure individualmente cada máquina selecionada.

* **BIOS**

  Informa se a máquina usa uma BIOS ou não, nas máquinas que usam BIOS é
  possível escolher qual BIOS você quer que a máquina use.

.. raw:: html

	<p></p>

* **Opções Avançadas**

  Consulte :ref:`mamemenu-advanced-options`.

.. raw:: html

	<p></p>

* **Opções do Vídeo**

  Consulte :ref:`mamemenu-config-video`.

.. raw:: html

	<p></p>

* **Mapeamento dos dispositivos**

  Consulte :ref:`mamemenu-config-devices`.

.. raw:: html

	<p></p>

* **Adicione aos favoritos**

  Adiciona a máquina selecionada aos seus favoritos.

.. raw:: html

	<p></p>

* **Salva a configuração da máquina**

  Salva a configuração apenas para a máquina selecionada.

..	[#MAMEUIP] O `MAMEUI <http://www.mameui.info/>`_ é uma versão do MAME
		com uma interface gráfica diferente.
..	[#] O site do `MAMEICONS <http://icons.mameworld.info/>`_ e
		`Progetto Snaps <http://www.progettosnaps.net/icons>`_ oferecem
		tais ícones e outras imagens para download.
..	[#] O site `Pugsy's Cheat <http://cheat.retrogames.com/>`_ é um dos
		mais conhecidos que oferece um arquivo de trapaça para download.
..	[#] O site `MAME Channel <https://www.mamechannel.it/pages/titles.php>`_
		oferece diferentes telas de títulos para download.
..	[#] É possível baixar essas imagens do site `EmuMovies
		<https://emumovies.com/files/file/3493-mame-bosses-pack/>`_.
..	[#] É possível baixar essas imagens do site `High-Score
		<http://highscore.com/>`_ e
		`Cubeman <http://www.cubeman.org/mame1.html>`_.
