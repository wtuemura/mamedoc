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
	* **Marrom**: São máquinas que funcionam mas estão imperfeitas na parte de som ou vídeo.

Abaixo da lista de máquinas nós temos:

	* **Configurações**: Exibe uma lista das configurações do MAME.
	* **Configure a máquina**: Exibe uma lista das opções para configurar a máquina selecionada.
	* **Plug-ins**: Exibe uma lista para a configuração de plug-ins
	* **Encerrar**: Encerra o MAME

Todos os itens exibidos essa interface podem ser selecionados usando as
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

  Exibe toda a lista de máquinas conhecidas e cadastradas no catálogo
  interno do MAME sem nenhum filtro.

.. _mamemenu-disponivel:

* **Disponível**

  Exibe a lista de máquinas que o MAME identificou dentro do diretório
  roms.

.. _mamemenu-nao-disponivel:

* **Não disponível**

  Exibe toda a lista de máquinas conhecidas e cadastradas no catálogo
  interno do MAME que não estão disponíveis, ainda que a interface
  mostre a cor verde.

.. _mamemenu-funciona:

* **Funciona**

  Exibe uma lista de máquinas que funcionam e estão em condição verde e
  marrom, as máquinas na condição vermelha ou que ainda não funcionem
  ficam de fora da lista.

.. _mamemenu-nao-funciona:

* **Não funciona**

  Exibe apenas máquinas que tenham condição vermelha e que não
  funcionam.

.. _mamemenu-mecanico:

* **Mecânico**

  Exibe toda a lista de máquinas mecânicas conhecidas e cadastradas no
  catálogo interno do MAME como Pinball por exemplo.

.. _mamemenu-nao-mecanico:

* **Não mecânico**

  Repete a lista :ref:`Não filtrado <mamemenu-nao-filtrado>`.

.. _mamemenu-categoria:

* **Categoria**

  Este filtro usa de arquivos *.ini* para separar as máquinas por diversas
  categoria diferentes como por exemplo gabinetes com 2 jogadores, 4 jogadores,
  jogo de tiro, de corrida, de tabuleiro, corrida, etc. Em categorias
  onde a lista seja muito grande, clique duas vezes com o mouse em cima
  da lista para que uma nova tela seja exibida e fique mais fácil
  escolher a opção desejada. Note que o uso destes arquivos pode fazer
  com que o MAME demore um pouco mais para iniciar.

  O MAME não incluí nenhum arquivo de categoria, na internet é possível
  acessar o site `Progetto-Snaps <http://www.progettosnaps.net>`_ que
  oferece estes arquivos *.ini* para download `aqui
  <http://www.progettosnaps.net/renameset/>`_. Depois que o arquivo for
  baixado e extraído o diretório **folders** deve ser copiado para o
  diretório raíz do MAME.

  Até o presente momento não existe uma tradução dessas categorias para
  o Português Brasileiro. Abaixo estão as categorias existentes até o
  momento e que funcionam com o MAME, as categorias que não funcionam
  com o MAME foram criadas para serem usadas com o MAMEUI [#]_ e não
  estão listadas aqui:

	* **Cabinets**: Lista as máquinas **Arcade** do MAME estão divididas em tipos de gabinetes.
	* **Category**: Lista as máquinas separadas em categorias como corrida, tabuleiro, tiro, etc.
	* **Driver**: Lista as máquinas do MAME consideradas de corrida ou que envolva qualquer tipo de direção.
	* **FreePlay**: Lista as máquinas **Arcade** do MAME que possuem a opção de poder jogar de graça.
	* **MonoChrome**: Lista as máquinas separada por cores.
	* **Resolution**: Lista as máquinas separadas por resolução.

.. raw:: latex

	\clearpage

O site ainda oferece outros tipos de *.ini* como **version.ini** que
separa as máquinas por versão em que elas apareceram pela primeira vez
no MAME, note que este aquivos extras não serão abordados neste
documento porém já deve ter ficado fácil compreender a sua utilidade no
MAME.

.. _mamemenu-favoritos:

* **Favoritos**

  Exibe uma lista das máquinas que foram favoritadas, para adicionar uma
  máquina à lista de favoritos, pressione **TAB**, no menu que aparecer
  selecione **Adicione aos Favoritos**.

.. _mamemenu-bios:

* **BIOS**

  Exibe uma lista de máquinas que precisam de uma BIOS para funcionar.

.. _mamemenu-sembios:

* **Sem BIOS**

  Exibe uma lista de máquinas que não precisam de uma BIOS para
  funcionar.

.. _mamemenu-pai:

* **Principais**

  Quando existirem máquinas derivadas da máquina principal exibe
  uma lista das máquinas que são originadas desta matriz.

.. _mamemenu-clones:

* **Clones**

  Exibe uma lista de máquinas que são consideradas clones das máquinas
  originais.

.. _mamemenu-fabricante:

* **Fabricante**

  Exibe uma lista com todos os fabricantes catalogados pelo MAME.

.. _mamemenu-ano:

* **Ano**

  Exibe uma lista das máquinas separadas por ano de lançamento.

.. _mamemenu-save-support:

* **Com suporte a salvamento**

  Exibe uma lista de máquinas onde o salvamento do estado da máquina
  seja possível.

.. _mamemenu-nosave-support:

* **Sem suporte ao salvamento**

  Exibe uma lista de máquinas onde não é possível salvar o estado da
  máquina.

.. _mamemenu-chd:

* **Precisa de CHD**

  Exibe uma lista de máquinas que precisam de uma imagem de disco para
  funcionar.

.. _mamemenu-nochd:

* **Não precisa de CHD**

  Exibe uma lista de máquinas que não precisam de uma imagem de disco
  para funcionar.

.. _mamemenu-tela-vertical:

* **Tela vertical**

  Exibe uma lista de máquinas que usam orientação vertical de tela.

.. _mamemenu-tela-horizontal:

* **Tela horizontal**

  Exibe uma lista de máquinas que usam orientação horizontal de tela.

.. _mamemenu-filtro-personalizado:

* **Filtro Personalizado**

  Todo o filtro criado será listado aqui.

.. raw:: latex

	\clearpage

.. _mamemenu-config-during-gameplay:

Durante a emulação
------------------

Estas opções podem ser acessadas durante a emulação e estão acessíveis
ao pressionar a tecla TAB.

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

Aqui as entradas podem variar bastante dependendo da máquina emulada.
Aqui ficam as configurações que serão utilizadas apenas na máquina que
estiver sendo emulada no momento, as configurações vão desde créditos,
botões, acesso ao modo de serviço da máquina (caso seja um arcade) ou
das teclas de um computador pessoal, etc.

Chaves DIP
~~~~~~~~~~

Aqui ficam as chaves DIP, elas servem para definir as configurações da
máquina (quando for relevante) como a quantidade de fichas necessárias
para registrar 1 crédito, se a tela será invertida ou não, se a máquina
ficará em silêncio ou tocará músicas enquanto ninguém a estiver
jogando, etc.

Sempre que uma chave for alterada, sempre selecione **Reinicie** para
que a alteração seja aplicada. Em alguma máquina a ação já pode ser
vista na tela, contudo, não é sempre o caso.

Informação da contabilidade
~~~~~~~~~~~~~~~~~~~~~~~~~~~

É o registro interno da máquina que mostra o tempo total que ela ficou
em execução e a quantidade de fichas que foram colocadas nela.

Informação da máquina
~~~~~~~~~~~~~~~~~~~~~

Um breve descritivo do nome da máquina, o tipo do processador, do áudio
e a resolução do vídeo.

.. raw:: latex

	\clearpage

Controles deslizantes
~~~~~~~~~~~~~~~~~~~~~

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

		O valor predefinido é **1.0**

* **Contraste da tela**

  Faz o controle do nível de branco da tela, consulte também
  :ref:`-contrast <mame-commandline-contrast>`.

		O valor predefinido é **1.0**

* **Gama da tela**

  Faz o ajuste da escala de luminância da tela, consulte também
  :ref:`-gamma <mame-commandline-gamma>`.

		O valor predefinido é **1.0**

* **Extensão horizontal da tela**

  Estica a tela no eixo horizontal.

		O valor predefinido é **1.0**

* **Posição horizontal da tela**

  Desloca a tela no eixo horizontal

		O valor predefinido é **0.0**

* **Extensão vertical da tela**

  Estica a tela no eixo vertical.

		O valor predefinido é **1.0**

* **Posição vertical da tela**

  Desloca a tela no eixo vertical

		O valor predefinido é **0.0**

.. raw:: latex

	\clearpage

Opções do vídeo
~~~~~~~~~~~~~~~

Tela #X
^^^^^^^

Caso a máquina possua mais de uma tela, todas elas serão listadas aqui,
onde "X" indica o número da tela e cada uma delas com as opções
mostradas abaixo.

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

		O valor predefinido é **None**


* **Aproxime a área da tela**

  Quando a máquina estiver usando uma artwork onde exista uma tela,
  somente esta região será aproximada.

		O valor predefinido é **Desligado**

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

		O valor predefinido é **Ligado**

* **Mantenha a proporção da tela**

  Mantém a proporção 4:3 da tela, independente do que as outras
  configurações façam, consulte também
  :ref:`-keepaspect <mame-commandline-keepaspect>`.

		O valor predefinido é **Ligado**

.. raw:: latex

	\clearpage

Snapshot
^^^^^^^^

* **Nome**

  Caso esteja usando uma **artwork** e ela tiver um nome, ela será
  exibida aqui indicando que é assim que o print de tela será feita.

.. raw:: html

	<p></p>

* **Screen 0 Standard (4:3)**

  Faz um print de tela nesta proporção

.. raw:: html

	<p></p>

* **Screen 0 Pixel Aspect (X:Y)**

  Faz um print da tela usando a proporção original (SAR) como 8:7,
  12:7, etc.

.. raw:: html

	<p></p>

* **Cocktail**

  Faz um print da tela espelhada no eixo vertical.

.. raw:: html

	<p></p>

* **Rotação**

  Faz um print da tela com a tela rotacionada como demonstrado no
  exemplo anterior.

		O valor predefinido é **None**

* **Aproxime a área da tela**

  Quando a máquina estiver usando uma artwork onde exista uma tela, o
  print da tela será feito somente desta região.

		O valor predefinido é **Desligado**

Opções dos Plug-ins
~~~~~~~~~~~~~~~~~~~

Quando os plug-ins forem ativados na configuração, eles serão listados
aqui. Qualquer alteração que for feita ao ativar um plugin, ele é
gravado no arquivo ``plugin.ini`` que fica na mesma pasta do MAME ou em
``~/.mame`` em sistemas Linux e macOS.

Para mais informações consulte :ref:`Plug-ins <mamemenu-plugins>`.

Visualização da DAT externa
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Esta opção estará disponível quando dois critérios forem atendidos, o
plug-in **Data plugin** precisa estar ativo e os arquivos **\*.dat**
(command.dat, gameinit.dat, etc) precisam estar dentro do diretório
**dats**.

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

* **Fontes**

  Permite a customização da tipografia da interface, dentro desta opção
  temos:

	* **Tipografia da interface**: Aqui é possível definir uma fonte
	  para toda a interface do MAME.

		O valor predefinido é **Padrão**

	* **Linhas**: Ajusta a dimensão do espaço e o tamanho da fonte,
	  quanto maior o valor maior a dimensão da interface e menor o texto
	  na tela.

		O valor predefinido é **30**

	* **Tamanho da caixa de informação**: Ajusta o tamanho da fonte nas
	  caixas de texto na tela.

		O valor predefinido é **0.75**

.. _mamemenu-cores:

* **Cores**

  Permite a customização completa das cores da interface do MAME, as
  opções disponíveis são:

	* **Texto Normal**: Define a cor do texto de toda a interface.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **255**

	* **Cor Selecionada**: Define a cor do item que for selecionado.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**

	* **Fundo do texto normal**: Aparentemente não tem função alguma.

		O valor predefinido é Opacidade: **239**, Vermelho: **0**,
		Verde: **0**, Azul: **0**

	* **Cor de fundo selecionada**: Define a cor do item selecionado.

		O valor predefinido é Opacidade: **239**, Vermelho: **128**,
		Verde: **128**, Azul: **0**

	* **Cor de subitem**: Define a cor dos itens que estiverem abaixo do
	  item principal.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **255**

	* **Clone**: Define a cor do texto de segundo plano.

		O valor predefinido é Opacidade: **255**, Vermelho: **128**,
		Verde: **128**, Azul: **128**

	* **Borda**: Define a cor das linhas da borda da tela.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **255**

	* **Fundo**: Define a cor do fundo da tela e máquinas clonadas.

		O valor predefinido é Opacidade: **239**, Vermelho: **16**,
		Verde: **16**, Azul: **48**

	* **Chave DIP**: Define a cor das chaves DIP selecionadas em
	  máquinas que usam tal chaves.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**

	* **Cor indisponível**: Aparentemente não tem função alguma.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**

	* **Cor do controle deslizante**: Define a cor dos controles
	  deslizantes.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**

	* **Fundo do visualizador GFX**: Define a cor de fundo do
	  visualizador GFX (tecla **F4**).

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **0**

	* **Cor da sobreposição do mouse**: Define a cor que texto terá
	  quando o mouse passar por cima de algum item selecionável.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **128**

	* **Cor de fundo da sobreposição do mouse**: Define a cor de fundo
	  do texto quando o mouse passar por cima de um item selecionável.

		O valor predefinido é Opacidade: **112**, Vermelho: **64**,
		Verde: **64**, Azul: **0**

	* **Cor de subposição do mouse**: Aparentemente não tem função
	  alguma.

		O valor predefinido é Opacidade: **255**, Vermelho: **255**,
		Verde: **255**, Azul: **128**

	* **Cor de fundo da subposição do mouse**: Aparentemente não tem
	  função alguma.

		O valor predefinido é Opacidade: **176**, Vermelho: **96**,
		Verde: **96**, Azul: **0**

.. _mamemenu-idioma:

* **Idioma**

  Permite a seleção do Idioma da interface do MAME, faça um clique duplo
  no campo do idioma para abrir uma listagem com todos os idiomas
  disponíveis.

		O valor predefinido é **English**

* **Painéis laterais**

  Configura a exibição ou não dos painéis laterais da interface do MAME.
  As opções disponíveis são:

	* **Mostra tudo**
	* **Esconda os filtros**
	* **Esconda info/imagem**
	* **Esconda ambos**

.. raw:: latex

	\clearpage

Configuração dos Diretórios
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

* **Prints da tela**

  Define o caminho do diretório onde serão armazenados os prints
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

Opções do Vídeo
~~~~~~~~~~~~~~~

Essas opções sempre serão carregadas na inicialização do MAME, lembrando
que a linha de comando **SEMPRE** tem prioridade, independente do que
seja definido aqui.

* **Modo do vídeo**

  Para mais informações consulte :ref:`-video <mame-commandline-video>`.

		O valor predefinido é **Auto**

* **Quantidade de telas**

  Predefine a quantidade das telas que serão usadas na emulação.

		O valor predefinido é **1**.

* **GLSL**

  Ativa ou não os efeitos GLSL, para mais informações consulte
  :ref:`-gl_glsl_filter <mame-commandline-glglslfilter>`.

		O valor predefinido é **Desligado**

* **Filtragem bilinear**

  Ativa ou não os filtros de tela para suavizar os gráficos, caso os
  gráficos fiquem muito borrados, experimente ativar também a opção
  **Pré-escala de bitmap**.

		O valor predefinido é **Ligado**

* **Pré-escala do bitmap**

  Opção útil quando máquinas com baixa resolução são ampliadas para uma
  resolução maior, use essa opção para dar uma amenizada nessa
  aparência, essa opção geralmente é utilizada em conjunto com a opção
  **Filtragem bilinear**.

		O valor predefinido é **1**.

* **Modo janela**

  Faz o MAME exibir a tela emulada em uma janela ou em uma tela inteira.

		O valor predefinido é **Desligado**.

* **Manter a proporção da tela**

  Faz com que a proporção da imagem exibida seja sempre mantida.

		O valor predefinido é **Ligado**.

* **Inicie com a tela expandida**

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

Opções do Áudio
~~~~~~~~~~~~~~~

* **Áudio**

  Ativa o áudio ou não, para mais informações consulte
  :ref:`-sound <mame-commandline-sound>`.

		O valor predefinido é **Ligado**.

* **Taxa da amostragem**

  Define a taxa da amostragem do áudio que será usada em todas as
  máquinas.

		O valor predefinido é **48000**.

* **Use amostras externas**

  Veja :ref:`-samples <mame-commandline-nosamples>`.

.. _mamemenu-config-etc:

Opções Diversas
~~~~~~~~~~~~~~~

* **Skip imperfect emulation warnings**

  Faz com que o MAME não exiba as telas de aviso das máquinas com
  emulação imperfeita (tarja amarela).

		O valor predefinido é **Desligado**.

* **Re-select last machine launched / Lembrar da última máquina jogada**

  Faz com que o MAME se lembre da última máquina que foi jogada através
  da interface do MAME.

		O valor predefinido é **Ligado**.

* **Aumente as imagens no painel direito**

  Aumenta o tamanho de qualquer uma das imagens exibidas no painel
  direito da interface do MAME, sempre mantendo a proporcionalidade da
  imagem.

		O valor predefinido é **Ligado**.

* **Trapaças**

  Ativa ou não o sistema de trapaças do MAME.

		O valor predefinido é **Desligado**.

* **Exiba o ponteiro do mouse**

  Ativa ou não a exibição do mouse na interface do MAME.

		O valor predefinido é **Ligado**.

* **Confirme se deseja encerrar a máquina ou não**

  Faz com que o MAME sempre te pergunte se quer realmente encerrar a
  emulação da máquina ou não.

		O valor predefinido é **Desligado**.

* **Omita a tela de informações ao iniciar**

  Não exibe a tela com informações sobre o sistema quando iniciar uma
  máquina.

		O valor predefinido é **Desligado**.

.. raw:: latex

	\clearpage

* **Mantenha o aspecto 4:3 para os prints de tela**

  Faz com que todos os prints da tela mantenham uma proporção de
  4:3.

		O valor predefinido é **Ligado**.

* **Use uma imagem como plano de fundo**

  Permite o uso de uma imagem como papel de parede na interface do MAME.
  Escolha uma imagem **.JPG** ou **.PNG** e a renomeie para
  **backgound.jpg** ou **backgound.png**. Para fazer uso dela coloque-a
  no diretório raiz do MAME (no mesmo diretório onde o executável do
  MAME se encontra).

		O valor predefinido é **Ligado**.

* **Omita a tela de seleção da BIOS**

  Faz com que o MAME inicie a máquina com a primeira BIOS disponível
  para a máquina ao em vez de usar uma lista.

		O valor predefinido é **Desligado**.

* **Omita as partes do cardápio da seleção do programa**

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

* **Esconda as máquinas sem ROMs da lista de disponíveis**

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

* **Atribuição do dispositivo paddle**

  Caso exista um controlador para remo, os valores
  disponíveis são **none**, **keyboard**, **mouse**, **Lightgun** e
  **joystick**.

		O valor predefinido é **keyboard**.

* **Atribuição do dispositivo dial**

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

Entradas Gerais
~~~~~~~~~~~~~~~

* **interface do usuário**

  Aqui estão os principais atalhos já predefinidos da interface do MAME,
  todos eles podem ser alterados conforme a necessidade. Para retornar
  ao valor original tecle **DELETE** duas vezes em cima da opção.

.. raw:: html

	<p></p>

* **On Screen Display**

  Exibe um visor na parte inferior da tela durante a emulação para a
  realização de ajustes em tempo real.

	A tecla predefinida é **Til**.

* **Break in Debugger**

  Atalho para entrar no depurador durante a emulação, só funciona caso
  o MAME tenha sido compilado com ferramentas de depuração.

	A tecla predefinida é **Til**.

* **Config Menu**

  Chama o cardápio de opções do MAME.

	A tecla predefinida é **Tab**.

* **Pause**

  Pausa a emulação.

	A tecla predefinida é **P**.

* **Pause - Single Step**

  Avança em passos de um quadro.

	As teclas predefinidas são **P** + **Shift Esq**.

* **Rewing - Single Step**

  Retrocede em passos de um quadro.

	As teclas predefinidas são **Til** + **Shift Esq**.

* **Reset Machine**

  Encerra a emulação e a reinicia do zero.

	As teclas predefinidas são **F3** + **Shift Esq**.

* **Soft Reset**

  Reinicie sem encerrar a emulação.

	A telcla predefinida é **F3**.

* **Show GFX**

  Mostra a paleta GFX decodificada e os tilemaps dos jogos.

	A tecla predefinida é **F4**.

* **Frameskip Dec**

  Redução do salto de quadros.

	A tecla predefinida é **F8**.

.. raw:: latex

	\clearpage

* **Frameskip Inc**

  Aumento do salto de quadros.

	A tecla predefinida é **F9**.

* **Throttle**

  Acelerador da emulação, faz a emulação rodar cerca de 3x mais rápido
  que o normal, não funciona em versões SDL.

	A tecla predefinida é **F10**.

* **Fast Forward**

  Como o exemplo anterior porém faz a emulação rodar o mais rápido
  possível.

.. raw:: html

	<p></p>

* **Show FPS**

  Exibe quantos quadros por segundo a emulação está rodando.

	A tecla predefinida é **PgDn** em versões SDL do MAME e **Insert**
	no Windows. 

* **Save Snapshot**

  Salva um instantâneo da tela.

	A tecla predefinida é **F12**.

* **Write current timecode**

  Salva o tempo decorrido.

	A tecla predefinida é **F12**.

* **Record MNG**

  Grava um vídeo em formato MNG sem áudio.

	As teclas predefinidas são **F12** + **Shift Esq**.

* **Record AVI**

  Grava um vídeo em formato AVI.

	A teclas predefinidas são **F12** + **Shift Esq**.

* **Toggle Cheat**

  Ativa a trapaça no jogo.

	A tecla predefinida é **F6**.

* **Toggle autofire**

  Ativa o modo turbo dos botões de tiro.

	A tecla predefinida é **Nenhum**.

* **UI Up**

  Move o cursor para cima.

	A tecla predefinida é **Tecla cima** ou **Cima do controle**.

* **UI Down**

  Move o cursor para baixo.

	A tecla predefinida é **Tecla baixo** ou **Baixo do controle**.

.. raw:: latex

	\clearpage

* **UI Left**

  Move o cursor para a esquerda.

	A tecla predefinida é **Tecla esquerda** ou **Esquerda do
	controle**.

* **UI Right**

  Move o cursor para a direita.

	A tecla predefinida é **Tecla direita** ou **Direita do controle**.

* **UI Home**

  Move o cursor para o topo da lista.

	A tecla predefinida é **Tecla home**.

* **UI End**

  Move o cursor para o fim da lista.

	A tecla predefinida é **Tecla end**.

* **UI Page Up**

  Move o cursor para o topo da lista saltando 26 linhas por vez.

	A tecla predefinida é **Tecla page up**.

* **UI Page Down**

  Move o cursor para o fim da lista saltando 26 linhas por vez.

	A tecla predefinida é **Tecla page down**.

* **Focus Next**

  Faz com que foco do cursor passe para a próxima janela da interface.

	A tecla predefinida é **Tab**.

* **Focus Previous**

  Faz com que foco do cursor passe para a anterior anterior da
  interface.

	A tecla predefinida é **Tab + Shift Esq.**.

* **UI Select**

  Tecla de seleção para qualquer item selecionável.

	As teclas predefinidas são **Enter**, **Botão 0 do controle** ou
	**Tecla enter do teclado numérico**.

* **UI Cancel**

  Tecla para cancelar qualquer ação.

	A tecla predefinida é **Tecla escape ou esq**.

* **UI Display Comment**

  Tecla para exibir comentário.

	A tecla predefinida é **Tecla espaço**.

* **UI Clear**

  Tecla para apagar/zerar uma opção.

	A tecla predefinida é **Tecla delete ou del**.

.. raw:: latex

	\clearpage

* **UI Zoom In**

  Tecla para aproximar (dar zoom) na interface. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **Tecla =**.

* **UI Zoom Out**
  Tecla para sair do zoom da interface. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **Tecla -**.

* **UI Previous Group**

  Faz a lista pular para o grupo anterior. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **[**. 

* **UI Next Group**

  Faz a lista pular para o próximo grupo. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **]**.

* **UI Rotate**

  Gira a interface.

	A tecla predefinida é **R** (não funciona).

* **Show Profile**

  Exibe o analisador de desempenho (não funciona).

	A teclas predefinidas são **F11** + **Shift Esq**.

* **UI Toggle**

  Alterna a interface do usuário.

	A tecla predefinida é **Screen lock**.

* **UI Paste Text**

  Cola texto na interface do usuário (não funciona).

	As teclas predefinidas são **Screen lock** + **Shift Esq**.

* **Toggle deugger**

  Alterna o Depurador.

	A tecla predefinida é **F5**.

* **Save State**

  Salva o estado da máquina.

	As teclas predefinidas são **F7** + **Shift Esq**.

* **Load State**

  Carrega o estado da máquina.

	A tecla predefinida é **F7**.

.. raw:: latex

	\clearpage

* **UI (First) Tape Start**

  Inicia a fita na interface primária.

	A tecla predefinida é **F2**.

* **UI (First) Tape Stop**

  Para a fita na interface primária.

	As teclas predefinidas são **F2** + **Shift Esq**.

* **UI External DAT View**

  Exibe o DAT externo, para que a visualização do DAT seja possível é
  preciso ativar o plugin **Data Plugin** na interface ou editando o
  arquivo ``plugin.ini``, o valor da linha **data** de **0** para **1**.

	As teclas predefinidas são **Alt Esq** + **D**.

* **UI Add/Remove favorites**

  Adiciona ou remove as máquinas dos favoritos.

	As teclas predefinidas são **Alt Esq** + **F** (não funciona).

* **UI Export List**

  Exporta a lista das máquinas no formato:

	* **XML** igual ao comando **-listxml**.
	* **XML** igual ao comando **-listxml** excluindo os dispositivos.
	* **TXT** igual ao comando **-listfull**.

	As teclas predefinidas são **Alt Esq** + **E**.

* **UI Audit Unavailable**

  Realiza uma auditoria das ROMs removendo as não disponíveis, o
  resultado é salvo no arquivo **mame_avail.ini** dentro do diretório
  **ui**.

	A tecla predefinida é **F1**.

* **UI Audit All**

  Realiza uma auditoria de todas as ROMs, o resultado é salvo no arquivo
  **mame_avail.ini** dentro do diretório **ui**.

	As teclas predefinidas são **F1** + **Shift Esq**.

* **Toggle Fullscreen**

  Alterna entre tela inteira e janela.

	As teclas predefinidas são **Enter** + **Alt Esq**.

* **Toggle Fullscreen**

  Alterna para tela inteira.

	A tecla predefinida é **Enter** + **Alt Esq**.

* **Toggle Filter**

  Alterna entre usar ou não o filtro na tela.

	As teclas predefinidas são **F5** + **Ctrl Esq**.

.. raw:: latex

	\clearpage

* **Decrease Prescaling**

  Reduz a pré-escala dos pixels.

	As teclas predefinidas são **F6** + **Ctrl Esq**.

* **Increase Prescaling**

  Aumenta a pré-escala de dos pixels.

	As teclas predefinidas são **F7** + **Ctrl Esq**.

* **Record Rendered Video**

  Grava o vídeo usando todos os efeitos e filtros ativos na tela.

	As teclas predefinidas são **F12** + **Ctrl+Alt Esq**.

* **Player 1 ~ 10 controls**

  Definições para todos os botões e controles usados pela máquina
  separado por jogador, entre o jogador 1 até o 10. Abaixo a lista das
  opções predefinidas para o jogador 1 que podem ser alteradas na
  própria interface do MAME.

.. raw:: latex

	\clearpage

.. _mamemenu-general-inputs-P1:

Predefinições para o jogador 1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Player 1 Controls                   | Predefinição                  |
+======================================+===============================+
|  P1 up                               | up or joy 1 up                |
+--------------------------------------+-------------------------------+
|  P1 down                             | down or joy 1 down            |
+--------------------------------------+-------------------------------+
|  P1 left                             | left or joy 1 left            |
+--------------------------------------+-------------------------------+
|  P1 right                            | right or joy 1 right          |
+--------------------------------------+-------------------------------+
|  P1 right stick/up                   | I or joy 1 button 1           |
+--------------------------------------+-------------------------------+
|  P1 right stick/down                 | K or joy 1 button 2           |
+--------------------------------------+-------------------------------+
|  P1 right stick/left                 | J or joy 1 button 0           |
+--------------------------------------+-------------------------------+
|  P1 right stick/right                | L or joy 1 button 3           |
+--------------------------------------+-------------------------------+
|  P1 left stick/up                    | E or joy 1 up                 |
+--------------------------------------+-------------------------------+
|  P1 left stick/down                  | D or joy 1 down               |
+--------------------------------------+-------------------------------+
|  P1 left stick/left                  | S or joy 1 left               |
+--------------------------------------+-------------------------------+
|  P1 left stick/right                 | F or joy 1  right             |
+--------------------------------------+-------------------------------+
|  P1 button 1                         | joy 1 button 3                |
+--------------------------------------+-------------------------------+
|  P1 button 2                         | joy 1 button 6                |
+--------------------------------------+-------------------------------+
|  P1 button 3                         | joy 1 button 0                |
+--------------------------------------+-------------------------------+
|  P1 button 4                         | joy 1 button 7                |
+--------------------------------------+-------------------------------+
|  P1 button 5                         | joy 1 button 2                |
+--------------------------------------+-------------------------------+
|  P1 button 6                         | joy 1 button 1                |
+--------------------------------------+-------------------------------+
|  P1 button 7                         | C or joy 1 button 6           |
+--------------------------------------+-------------------------------+
|  P1 button 8                         | V or joy 1 button 7           |
+--------------------------------------+-------------------------------+
|  P1 button 9                         | B or joy 1 button 8           |
+--------------------------------------+-------------------------------+
|  P1 button 10                        | N or joy 1 button 9           |
+--------------------------------------+-------------------------------+
|  P1 button 11                        | M or joy 1 button 10          |
+--------------------------------------+-------------------------------+
|  P1 button 12                        | comma or joy 1 button 11      |
+--------------------------------------+-------------------------------+
|  P1 button 13                        | Stop                          |
+--------------------------------------+-------------------------------+
|  P1 button 14                        | Slash                         |
+--------------------------------------+-------------------------------+
|  P1 button 15                        | Rshift                        |
+--------------------------------------+-------------------------------+
|  P1 button 16                        | n/a                           |
+--------------------------------------+-------------------------------+
|  P1 start                            | 1                             |
+--------------------------------------+-------------------------------+
|  P1 select                           | 5                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong A                        | A                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong B                        | B                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong C                        | C                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong D                        | D                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong E                        | E                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong F                        | F                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong G                        | G                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong H                        | H                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong I                        | I                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong J                        | J                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong K                        | K                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong L                        | L                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong M                        | M                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong O                        | O                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong P                        | Colon                         |
+--------------------------------------+-------------------------------+
|  P1 mahjong Q                        | Q                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong Kan                      | Lcontrol                      |
+--------------------------------------+-------------------------------+
|  P1 mahjong Pon                      | Lalt                          |
+--------------------------------------+-------------------------------+
|  P1 mahjong Chi                      | Space                         |
+--------------------------------------+-------------------------------+
|  P1 mahjong Reach                    | Shift                         |
+--------------------------------------+-------------------------------+
|  P1 mahjong Ron                      | Z                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong Bet                      | 3                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong Last Chance              | Ralt                          |
+--------------------------------------+-------------------------------+
|  P1 mahjong Score                    | Rcontrol                      |
+--------------------------------------+-------------------------------+
|  P1 mahjong Double Up                | Rshift                        |
+--------------------------------------+-------------------------------+
|  P1 mahjong Flip Flop                | Y                             |
+--------------------------------------+-------------------------------+
|  P1 mahjong Big                      | Return                        |
+--------------------------------------+-------------------------------+
|  P1 mahjong Small                    | Backspace                     |
+--------------------------------------+-------------------------------+
|  P1 hanafuda A/1                     | A                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda B/2                     | B                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda C/3                     | C                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda D/4                     | D                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda E/5                     | E                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda F/6                     | F                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda G/7                     | G                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda H/8                     | H                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda Yes                     | M                             |
+--------------------------------------+-------------------------------+
|  P1 hanafuda No                      | N                             |
+--------------------------------------+-------------------------------+
|  High                                | A                             |
+--------------------------------------+-------------------------------+
|  Low                                 | S                             |
+--------------------------------------+-------------------------------+
|  Half Gamble                         | D                             |
+--------------------------------------+-------------------------------+
|  Deal                                | 2                             |
+--------------------------------------+-------------------------------+
|  Double up                           | 3                             |
+--------------------------------------+-------------------------------+
|  Take                                | 4                             |
+--------------------------------------+-------------------------------+
|  Stand                               | L                             |
+--------------------------------------+-------------------------------+
|  Bet                                 | M                             |
+--------------------------------------+-------------------------------+
|  Key in                              | Q                             |
+--------------------------------------+-------------------------------+
|  Key out                             | W                             |
+--------------------------------------+-------------------------------+
|  Payout                              | I                             |
+--------------------------------------+-------------------------------+
|  Door                                | O                             |
+--------------------------------------+-------------------------------+
|  Service                             | 9                             |
+--------------------------------------+-------------------------------+
|  Book-keeping                        | 0                             |
+--------------------------------------+-------------------------------+
|  Hold 1                              | Z                             |
+--------------------------------------+-------------------------------+
|  Hold 2                              | X                             |
+--------------------------------------+-------------------------------+
|  Hold 3                              | C                             |
+--------------------------------------+-------------------------------+
|  Hold 4                              | V                             |
+--------------------------------------+-------------------------------+
|  Hold 5                              | B                             |
+--------------------------------------+-------------------------------+
|  Cancel                              | N                             |
+--------------------------------------+-------------------------------+
|  Bet                                 | 1                             |
+--------------------------------------+-------------------------------+
|  Stop Reel 1                         | X                             |
+--------------------------------------+-------------------------------+
|  Stop Reel 2                         | C                             |
+--------------------------------------+-------------------------------+
|  Stop Reel 3                         | V                             |
+--------------------------------------+-------------------------------+
|  Stop Reel 4                         | B                             |
+--------------------------------------+-------------------------------+
|  Stop all reels                      | Z                             |
+--------------------------------------+-------------------------------+
|  P1 pedal 1 analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  P1 pedal 1 analog dec               | None                          |
+--------------------------------------+-------------------------------+
|  P1 pedal 1 analog inc               | Lcontrol or joy 1 button 0    |
+--------------------------------------+-------------------------------+
|  P1 pedal 2 analog                   | n/a                           |
+--------------------------------------+-------------------------------+
|  P1 pedal 2 analog dec               | None                          |
+--------------------------------------+-------------------------------+
|  P1 pedal 2 analog inc               | Lalt or joy 1 button 1        |
+--------------------------------------+-------------------------------+
|  P1 pedal 3 analog                   | None                          |
+--------------------------------------+-------------------------------+
|  P1 pedal 3 analog dec               | None                          |
+--------------------------------------+-------------------------------+
|  P1 pedal 3 analog inc               | Space or joy 1 button 2       |
+--------------------------------------+-------------------------------+
|  Paddle analog                       | ...                           |
+--------------------------------------+-------------------------------+
|  Paddle analog dec                   | Left                          |
+--------------------------------------+-------------------------------+
|  Paddle analog inc                   | Right                         |
+--------------------------------------+-------------------------------+
|  Paddle V analog                     | ...                           |
+--------------------------------------+-------------------------------+
|  Paddle V analog dec                 | Up                            |
+--------------------------------------+-------------------------------+
|  Paddle V analog inc                 | Down                          |
+--------------------------------------+-------------------------------+
|  Positional analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  Positional analog dec               | Right                         |
+--------------------------------------+-------------------------------+
|  Positional analog inc               | Left                          |
+--------------------------------------+-------------------------------+
|  Positional V analog                 | ...                           |
+--------------------------------------+-------------------------------+
|  Positional V analog dec             | Up                            |
+--------------------------------------+-------------------------------+
|  Positional V analog inc             | Down                          |
+--------------------------------------+-------------------------------+
|  Dial analog                         | ...                           |
+--------------------------------------+-------------------------------+
|  Dial analog dec                     | Up                            |
+--------------------------------------+-------------------------------+
|  Dial analog inc                     | Down                          |
+--------------------------------------+-------------------------------+
|  Dial V analog                       | ...                           |
+--------------------------------------+-------------------------------+
|  Dial V analog dec                   | Up                            |
+--------------------------------------+-------------------------------+
|  Dial V analog inc                   | Down                          |
+--------------------------------------+-------------------------------+
|  Track X analog                      | ...                           |
+--------------------------------------+-------------------------------+
|  Track X analog dec                  | Left                          |
+--------------------------------------+-------------------------------+
|  Track X analog inc                  | Right                         |
+--------------------------------------+-------------------------------+
|  Track Y analog                      | ...                           |
+--------------------------------------+-------------------------------+
|  Track Y analog dec                  | Up                            |
+--------------------------------------+-------------------------------+
|  Track Y analog inc                  | Down                          |
+--------------------------------------+-------------------------------+
|  AD stick X analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  AD stick X analog dec               | Left                          |
+--------------------------------------+-------------------------------+
|  AD stick X analog inc               | Right                         |
+--------------------------------------+-------------------------------+
|  AD stick Y analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  AD stick Y analog dec               | Up                            |
+--------------------------------------+-------------------------------+
|  AD stick Y analog inc               | Down                          |
+--------------------------------------+-------------------------------+
|  AD stick Z analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  AD stick Z analog dec               | A                             |
+--------------------------------------+-------------------------------+
|  AD stick Z analog inc               | Z                             |
+--------------------------------------+-------------------------------+
|  Lightgun X analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  Lightgun X analog dec               | Left                          |
+--------------------------------------+-------------------------------+
|  Lightgun X analog inc               | Right                         |
+--------------------------------------+-------------------------------+
|  Lightgun Y analog                   | ...                           |
+--------------------------------------+-------------------------------+
|  Lightgun Y analog dec               | Up                            |
+--------------------------------------+-------------------------------+
|  Lightgun Y analog inc               | Down                          |
+--------------------------------------+-------------------------------+
|  Mouse X analog                      | ...                           |
+--------------------------------------+-------------------------------+
|  Mouse X analog dec                  | Left                          |
+--------------------------------------+-------------------------------+
|  Mouse X analog inc                  | Right                         |
+--------------------------------------+-------------------------------+
|  Mouse Y analog                      | ...                           |
+--------------------------------------+-------------------------------+
|  Mouse Y analog dec                  | Up                            |
+--------------------------------------+-------------------------------+
|  Mouse Y analog inc                  | Down                          |
+--------------------------------------+-------------------------------+

.. _mamemenu-general-inputs-P2:

Predefinições para o jogador 2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Player 2 Controls                   | Predefinição                  |
+======================================+===============================+
|  P2 up                               | R                             |
+--------------------------------------+-------------------------------+
|  P2 down                             | F                             |
+--------------------------------------+-------------------------------+
|  P2 left                             | D                             |
+--------------------------------------+-------------------------------+
|  P2 right                            | G                             |
+--------------------------------------+-------------------------------+
|  P2 button 1                         | A                             |
+--------------------------------------+-------------------------------+
|  P2 button 2                         | S                             |
+--------------------------------------+-------------------------------+
|  P2 button 3                         | Q                             |
+--------------------------------------+-------------------------------+
|  P2 button 4                         | W                             |
+--------------------------------------+-------------------------------+
|  P2 start                            | 2                             |
+--------------------------------------+-------------------------------+
|  P2 select                           | 6                             |
+--------------------------------------+-------------------------------+
|  P2 pedal 1 analog inc               | A                             |
+--------------------------------------+-------------------------------+
|  P2 pedal 2 analog inc               | S                             |
+--------------------------------------+-------------------------------+
|  P2 pedal 3 analog inc               | Q                             |
+--------------------------------------+-------------------------------+
|  Paddle 2 analog dec                 | D                             |
+--------------------------------------+-------------------------------+
|  Paddle 2 analog inc                 | G                             |
+--------------------------------------+-------------------------------+
|  Paddle V 2 analog dec               | R                             |
+--------------------------------------+-------------------------------+
|  Paddle V 2 analog inc               | F                             |
+--------------------------------------+-------------------------------+
|  Positional 2 analog dec             | D                             |
+--------------------------------------+-------------------------------+
|  Positional 2 analog inc             | G                             |
+--------------------------------------+-------------------------------+
|  Positional V 2 analog dec           | R                             |
+--------------------------------------+-------------------------------+
|  Positional V 2 analog inc           | F                             |
+--------------------------------------+-------------------------------+
|  Dial 2 analog dec                   | D                             |
+--------------------------------------+-------------------------------+
|  Dial 2 analog inc                   | G                             |
+--------------------------------------+-------------------------------+
|  Dial V 2 analog dec                 | R                             |
+--------------------------------------+-------------------------------+
|  Dial V 2 analog inc                 | F                             |
+--------------------------------------+-------------------------------+
|  Track X 2 analog dec                | D                             |
+--------------------------------------+-------------------------------+
|  Track X 2 analog inc                | G                             |
+--------------------------------------+-------------------------------+
|  Track Y 2 analog dec                | R                             |
+--------------------------------------+-------------------------------+
|  Track Y 2 analog inc                | F                             |
+--------------------------------------+-------------------------------+
|  AD stick X 2 analog dec             | D                             |
+--------------------------------------+-------------------------------+
|  AD stick X 2 analog inc             | G                             |
+--------------------------------------+-------------------------------+
|  AD stick Y 2 analog dec             | R                             |
+--------------------------------------+-------------------------------+
|  AD stick Y 2 analog inc             | F                             |
+--------------------------------------+-------------------------------+
|  Lightgun X 2 analog dec             | D                             |
+--------------------------------------+-------------------------------+
|  Lightgun X 2 analog inc             | G                             |
+--------------------------------------+-------------------------------+
|  Lightgun Y analog dec               | R                             |
+--------------------------------------+-------------------------------+
|  Lightgun Y analog inc               | F                             |
+--------------------------------------+-------------------------------+
|  Mouse X 2 analog dec                | D                             |
+--------------------------------------+-------------------------------+
|  Mouse X 2 analog inc                | G                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 2 analog dec                | R                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 2 analog inc                | F                             |
+--------------------------------------+-------------------------------+

.. _mamemenu-general-inputs-P3:

Predefinições para o jogador 3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Player 3 Controls                   | Predefinição                  |
+======================================+===============================+
|  P3 up                               | I                             |
+--------------------------------------+-------------------------------+
|  P3 down                             | K                             |
+--------------------------------------+-------------------------------+
|  P3 left                             | J                             |
+--------------------------------------+-------------------------------+
|  P3 right                            | L                             |
+--------------------------------------+-------------------------------+
|  P3 button 1                         | Rcontrol                      |
+--------------------------------------+-------------------------------+
|  P3 button 2                         | Rshift                        |
+--------------------------------------+-------------------------------+
|  P3 button 3                         | Return                        |
+--------------------------------------+-------------------------------+
|  P3 start                            | 3                             |
+--------------------------------------+-------------------------------+
|  P3 select                           | 7                             |
+--------------------------------------+-------------------------------+
|  P3 pedal 1 analog inc               | Rcontrol                      |
+--------------------------------------+-------------------------------+
|  P3 pedal 3 analog inc               | Rshift                        |
+--------------------------------------+-------------------------------+
|  P3 pedal 3 analog inc               | Return                        |
+--------------------------------------+-------------------------------+
|  Paddle 3 analog dec                 | J                             |
+--------------------------------------+-------------------------------+
|  Paddle 3 analog inc                 | L                             |
+--------------------------------------+-------------------------------+
|  Paddle V 3 analog dec               | I                             |
+--------------------------------------+-------------------------------+
|  Paddle V 3 analog inc               | K                             |
+--------------------------------------+-------------------------------+
|  Positional 3 analog dec             | J                             |
+--------------------------------------+-------------------------------+
|  Positional 3 analog inc             | L                             |
+--------------------------------------+-------------------------------+
|  Positional V 3 analog dec           | I                             |
+--------------------------------------+-------------------------------+
|  Positional V 3 analog inc           | K                             |
+--------------------------------------+-------------------------------+
|  Dial 3 analog dec                   | J                             |
+--------------------------------------+-------------------------------+
|  Dial 3 analog inc                   | L                             |
+--------------------------------------+-------------------------------+
|  Dial V 3 analog dec                 | I                             |
+--------------------------------------+-------------------------------+
|  Dial V 3 analog inc                 | K                             |
+--------------------------------------+-------------------------------+
|  Track X 3 analog dec                | J                             |
+--------------------------------------+-------------------------------+
|  Track X 3 analog inc                | L                             |
+--------------------------------------+-------------------------------+
|  Track Y 3 analog dec                | I                             |
+--------------------------------------+-------------------------------+
|  Track Y 3 analog inc                | K                             |
+--------------------------------------+-------------------------------+
|  AD stick X 3 analog dec             | J                             |
+--------------------------------------+-------------------------------+
|  AD stick X 3 analog inc             | L                             |
+--------------------------------------+-------------------------------+
|  AD stick Y 3 analog dec             | I                             |
+--------------------------------------+-------------------------------+
|  AD stick Y 3 analog inc             | K                             |
+--------------------------------------+-------------------------------+
|  Lightgun X 3 analog dec             | J                             |
+--------------------------------------+-------------------------------+
|  Lightgun X 3 analog inc             | L                             |
+--------------------------------------+-------------------------------+
|  Lightgun Y analog dec               | I                             |
+--------------------------------------+-------------------------------+
|  Lightgun Y analog inc               | K                             |
+--------------------------------------+-------------------------------+
|  Mouse X 3 analog dec                | J                             |
+--------------------------------------+-------------------------------+
|  Mouse X 3 analog inc                | L                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 3 analog dec                | I                             |
+--------------------------------------+-------------------------------+
|  Mouse Y 3 analog inc                | K                             |
+--------------------------------------+-------------------------------+

.. _mamemenu-general-inputs-P4:

Predefinições para o jogador 4
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tabularcolumns:: |l|c|p{5cm}|

+--------------------------------------+-------------------------------+
|  Player 4 Controls                   | Predefinição                  |
+======================================+===============================+
|  P4 up                               | 8_pad                         |
+--------------------------------------+-------------------------------+
|  P4 down                             | 2_pad                         |
+--------------------------------------+-------------------------------+
|  P4 left                             | 4_pad                         |
+--------------------------------------+-------------------------------+
|  P4 right                            | 6_pad                         |
+--------------------------------------+-------------------------------+
|  P4 button 1                         | 0_pad                         |
+--------------------------------------+-------------------------------+
|  P4 button 2                         | Del_pad                       |
+--------------------------------------+-------------------------------+
|  P4 button 3                         | Enter_pad                     |
+--------------------------------------+-------------------------------+
|  P4 start                            | 4                             |
+--------------------------------------+-------------------------------+
|  P4 select                           | 8                             |
+--------------------------------------+-------------------------------+
|  P4 pedal 1 analog inc               | 0_pad                         |
+--------------------------------------+-------------------------------+
|  P4 pedal 2 analog inc               | Del_pad                       |
+--------------------------------------+-------------------------------+
|  P4 pedal 3 analog inc               | Enter_pad                     |
+--------------------------------------+-------------------------------+

As predefinições para o jogador 5 em diante estão vazias e podem ser
customizadas conforme a necessidade.

.. _mamemenu-other-controls:

* **Outros controles**

  Muda a configuração dos botões usados para crédito, serviço, inicio
  de jogadores, etc. Abaixo a lista das opções predefinidas que podem
  ser alteradas na própria interface do MAME.

+--------------------------------------+-------------------------------+
|  1 Player start                      |  1                            |
+--------------------------------------+-------------------------------+
|  2 Players start                     |  2                            |
+--------------------------------------+-------------------------------+
|  3 Players start                     |  3                            |
+--------------------------------------+-------------------------------+
|  4 Players start                     |  4                            |
+--------------------------------------+-------------------------------+
|  5 Players start                     |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  6 Players start                     |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  7 Players start                     |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  8 Players start                     |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 1                              |  5                            |
+--------------------------------------+-------------------------------+
|  Coin 2                              |  6                            |
+--------------------------------------+-------------------------------+
|  Coin 3                              |  7                            |
+--------------------------------------+-------------------------------+
|  Coin 4                              |  8                            |
+--------------------------------------+-------------------------------+
|  Coin 5                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 6                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 7                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 8                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 9                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 10                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 11                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Coin 12                             |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Bill1                               |  Backspace                    |
+--------------------------------------+-------------------------------+
|  Service 1                           |  9                            |
+--------------------------------------+-------------------------------+
|  Service 2                           |  0                            |
+--------------------------------------+-------------------------------+
|  Service 3                           |  Tecla menos                  |
+--------------------------------------+-------------------------------+
|  Service 4                           |  Tecla igual                  |
+--------------------------------------+-------------------------------+
|  Tilt 1                              |  T                            |
+--------------------------------------+-------------------------------+
|  Tilt 2                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Tilt 3                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Tilt 4                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Power On                            |  F1                           |
+--------------------------------------+-------------------------------+
|  Power Off                           |  F2                           |
+--------------------------------------+-------------------------------+
|  Service                             |  F2                           |
+--------------------------------------+-------------------------------+
|  Tilt                                |  T                            |
+--------------------------------------+-------------------------------+
|  Door interlock                      |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Memory reset                        |  F1                           |
+--------------------------------------+-------------------------------+
|  Volume down                         |  Tecla menos                  |
+--------------------------------------+-------------------------------+
|  Volume up                           |  Tecla igual                  |
+--------------------------------------+-------------------------------+
|  Keypad                              |  Nenhum                       |
+--------------------------------------+-------------------------------+
|  Keyboard                            |  None                         |
+--------------------------------------+-------------------------------+

.. raw:: latex

	\clearpage

.. _mamemenu-advanced-options:

Opções avançadas
~~~~~~~~~~~~~~~~

Opções de Desempenho
^^^^^^^^^^^^^^^^^^^^

* **Salto automático dos quadros**

  Ignora quadros de forma automática visando manter a velocidade da
  emulação.

	O valor predefinido é **Desligado**

* **Salto de quadro**

  Define uma quantidade fixa de quadros a serem ignorados visando manter
  a velocidade da emulação.

	O valor predefinido é **0**

* **Supressão da velocidade**

  Ativa a supressão de velocidade da emulação para que a máquina
  emulada rode em sua velocidade nativa em vez da velocidade do
  processador em que a máquina está sendo emulada.

	O valor predefinido é **Ligado**

* **Mute quando a supressão da velocidade estiver desligada**

  Silencia o áudio quando a supressão de velocidade estiver desligado.

	O valor predefinido é **Desligado**

* **Dormir**

  Reduz o consumo de processamento quando o MAME estiver parado sem
  fazer nada.

	O valor predefinido é **Ligado**

* **Velocidade**

  Controla a velocidade do jogo com relação ao tempo de emulação.

	O valor predefinido é **1**

* **Ajuste a velocidade para bater com a taxa de atualização**

  Controla a velocidade da emulação de forma automática mantendo a taxa
  de atualização de tela mais lenta em referência com a taxa de
  atualização de tela do computador que está rodando a emulação.

	O valor predefinido é **Desligado**

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

	O valor predefinido é **Ligado**

* **Rotacione à direita**

  Rotacione a tela em 90 graus sentido horário.

	O valor predefinido é **Desligado**

* **Rotacione à esquerda**

  Rotacione a tela em 90 graus sentido anti-horário.

	O valor predefinido é **Desligado**

* **Auto rotacione à direita**

  Rotacione automaticamente a tela em 90 graus sentido horário caso
  a tela esteja orientada verticalmente.

	O valor predefinido é **Desligado**

* **Auto rotacione à esquerda**

  Rotacione automaticamente a tela em 90 graus sentido anti-horário
  caso a tela esteja orientada verticalmente.

	O valor predefinido é **Desligado**

* **Vire o eixo X**

  Inverte a tela da esquerda para a direita.

	O valor predefinido é **Desligado**

* **Vire o eixo Y**

  Inverte a tela da direita para a esquerda.

	O valor predefinido é **Desligado**

.. _mamemenu-advanced-illustration:

Opções das Ilustrações
^^^^^^^^^^^^^^^^^^^^^^

* **Aproxime a área da tela**

  Aproxima a região da tela emulada quando estiver numa ilustração.

	O valor predefinido é **Desligado**

.. _mamemenu-advanced-state-playback:

Opções do estado/reprodução
^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **Salve/Restaure automático**

  Em sistema compatíveis, carrega automaticamente o estado da máquina e
  a salva ao encerrar.

	O valor predefinido é **Desligado**

* **Permita o rebobinamento**

  Permite o rebobinamento do estado da máquina.

	O valor predefinido é **Desligado**

* **Capacidade de rebobinamento**

  Reserva uma quantidade em Megabytes da memória para rebobinamento.

	O valor predefinido é **100**

* **Filtro bilinear para os prints da tela**

  Define se os vídeos ou os prints da tela terão o filtro aplicado.

	O valor predefinido é **Ligado**

* **Marca de queimado**

  Cria prints da tela com marcas de fósforo queimado.

	O valor predefinido é **Desligado**

.. _mamemenu-advanced-input-options:

Opções da Entrada
^^^^^^^^^^^^^^^^^

* **Trava da ficha**

  Faz com que a máquina ignore a inserção de fichas em momentos que a
  máquina não está pronta para recebê-las.

	O valor predefinido é **Ligado**

* **Mouse**

  Permite o uso de um mouse nas máquinas.

	O valor predefinido é **Desligado**

* **Controle**

  Permite o uso de um controle nas máquinas.

	O valor predefinido é **Ligado**

* **Pistola de luz**

  Ativa o uso do uma pistola de luz.

	O valor predefinido é **Desligado**

* **Mais de um teclado**

  Permite o uso de mais de um teclado para cada entrada compatível.

	O valor predefinido é **Desligado**

.. raw:: latex

	\clearpage

* **Mais de um mouse**

  Permite o uso de mais de um mouse para cada entrada compatível.

	O valor predefinido é **Desligado**

* **Steadykey**

  Alguns sistemas exigem que dois ou mais botões sejam pressionados
  exatamente ao mesmo tempo para realizar movimentos ou comandos
  especiais. Devido a limitação do hardware do teclado, pode ser difícil
  ou até mesmo impossível de realizar usando um teclado comum. Essa
  opção seleciona diferentes modos de manuseio o que torna mais fácil
  registrar o pressionamento simultâneo das teclas, porém tem a
  desvantagem de deixar a sua capacidade de resposta mais lenta.

	O valor predefinido é **Desligado**

* **IU ativa**

  Ativa a opção para que a interface do usuário se sobreponha a do
  teclado emulado caso esteja presente.

	O valor predefinido é **Desligado**

* **Recarga fora da tela**

  Converte o botão 2 da pistola de luz como recarga fora da tela.

	O valor predefinido é **Desligado**

* **Zona morta do controle**

  Permite fazer o ajuste fino do ponto morto do controle ou manche.

	O valor predefinido é **0.3**

* **Saturação do controle**

  Faz o ajuste findo do eixo de fim de curso do controle.

	O valor predefinido é **0.85**

* **Teclado natural**

  Ativa ou não o uso de um teclado natural.

	O valor predefinido é **Desligado**

* **Comando contraditório**

  Aceita comandos contraditórios e simultâneos no controle digital como
  esquerda e direita ou cima e baixo.

	O valor predefinido é **Desligado**

* **Impulso de ficha**

  Define o tempo de impulso da ficha.

	O valor predefinido é **0**

.. _mamemenu-config-saving:

Salve a Configuração
~~~~~~~~~~~~~~~~~~~~

Salva todas as alterações feitas.

Retorna ao menu anterior
~~~~~~~~~~~~~~~~~~~~~~~~

Retorna para a tela anterior.

.. raw:: latex

	\clearpage

.. _mamemenu-config-machine:

Configure a Máquina
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

* **Adiciona aos Favoritos**

  Adiciona a máquina selecionada aos seus favoritos.

.. raw:: html

	<p></p>

* **Salva a configuração da máquina**

  Salva a configuração apenas para a máquina selecionada.

.. raw:: latex

	\clearpage

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

..	[#] O `MAMEUI <http://www.mameui.info/>`_ é uma versão do MAME com
		interface gráfica.
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
