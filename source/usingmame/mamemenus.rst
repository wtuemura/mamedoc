
.. raw:: latex

	\clearpage

.. _mamemenu:

O cardápio de opções do MAME
============================

.. contents:: :local:


Caso você inicie o MAME sem nenhum parâmetro na linha de comando ou
rodando ele com o clicar do mouse, um cardápio de opções será exibido,
entre eles a lista de seleção de jogos ao centro, os filtros do lado
esquerdo, a aba de informações e imagens. No rodapé da tela tem um
descritivo resumido da máquina, com o nome da máquina, nome do
fabricante, ano, a condição som e imagem e se a máquina funciona ou não.

Dependendo da condição das máquinas a interface do MAME mostrará
diferentes cores de fundo indicando a sua condição.

	* **Verde**: São máquinas com roms completas e que funcionam.
	* **Vermelha**: São máquinas que não funcionam direito ou tem roms faltando.
	* **Marrom**: São máquinas que funcionam mas estão imperfeitas na parte de som ou vídeo.

Abaixo da lista de máquinas nós temos:

	* **Opções de configuração**: Exibe uma lista de configurações do MAME.
	* **Configurar a máquina**: Exibe uma lista de opções para configurar a máquina selecionada.
	* **Plug-ins**: Exibe uma lista para a configuração de plug-ins
	* **Sair**: Sai do MAME

Todos os itens exibidos essa interface podem ser selecionados usando as
setas do seu teclado (cima, baixo, esquerda, direita) e são selecionadas
pressionando a tecla **Enter** do teclado. A interface também aceita o
uso do mouse fazendo a seleção com um clique e um duplo clique para abri
a opção ou rodar uma máquina.

.. raw:: latex

	\clearpage


Opções de configuração
----------------------

.. _mamemenu-filtro:

Filtro
~~~~~~

Escolhe entre diferentes filtros pré configurados e um personalizado.
Estes filtros ajudam o usuário a selecionar máquinas separadas por
categorias, supondo que você queira encontrar uma máquina que você não
se lembra do nome porém se lembra do ano, é possível usar o filtro
**Ano** para listar todas as máquinas conhecidas pelo MAME que foram
lançadas naquele ano.

Supondo que eu queira encontrar a máquina **Double Dragon**, faremos de
conta que eu não me lembro, eu só lembro do ano *1987* e que o
fabricante dela foi a *Technos Japan*. Vamos até o
**Filtro Personalizado**, no primeiro filtro adicionamos um filtro para
o **Ano** e colocamos *1987*, adicionamos mais um filtro para o
**Fabricante** e escolhemos *Techmos Japan*, ao retornarmos ao menu
anterior o MAME exibirá uma lista de máquinas que atendam aos critérios
definodos por nós. Neste exemplo então o MAME vai retornar 6 diferentes
máquinas **Double Dragon**, **Super Dodge Ball** e **Nekketsu Koukou
Dodgeball Bu**.

Os filtros disponíveis são:

.. _mamemenu-nao-filtrado:

* **Não filtrado**

  Exibe toda a lista de máquinas conhecidas e cadastradas no catálogo
  interno do MAME.

.. _mamemenu-disponivel:

* **Disponível**

  Exibe a lista de máquinas que o MAME identificou dentro do diretório
  roms.

.. _mamemenu-nao-disponivel:

* **Não disponíveis**

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
  com o MAME foram criadas para serem usadas com o MAMEUI [1]_ e não
  estão listadas aqui:

	* **Cabinets**: Lista as máquinas **Arcade** do MAME estão divididas em tipos de gabinetes.
	* **Category**: Lista as máquinas separadas em categorias como corrida, tabuleiro, tiro, etc.
	* **Driver**: Lista as máquinas do MAME consideradas de corrida ou que envolva qualquer tipo de direção.
	* **FreePlay**: Lista as máquinas **Arcade** do MAME que possuem a opção de poder jogar de graça.
	* **MonoChrome**: Lista as máquinas separada por cores.
	* **Resolution**: Lista as máquinas separadas por resolução.

O site ainda oferece outros tipos de *.ini* como **version.ini** que
separa as máquinas por versão em que elas apareceram pela primeira vez
no MAME, note que este aquivos extras não serão abordados neste
documento porém já deve ter ficado fácil compreender a sua utilidade no
MAME.

.. _mamemenu-favoritos:

* **Favoritos**

  Exibe uma lista das máquinas que foram favoritadas, para adicionar uma
  máquina à lista de favoritos, pressione **TAB**, no menu que aparecer
  selecione **Adicionar aos favoritos**.

.. _mamemenu-bios:

* **BIOS**

  Exibe uma lista de máquinas que precisam de uma BIOS para funcionar.

.. _mamemenu-sembios:

* **Sem BIOS**

  Exibe uma lista de máquinas que não precisam de uma BIOS para
  funcionar.

.. _mamemenu-pai:

* **Pai**

  Quando existirem máquinas que se originaram de uma matriz (pai), exibe
  uma lista de máquinas que são originadas dessa matriz.

.. _mamemenu-clones:

* **Clones**

  Exibe uma lista de máquinas que são consideradas clones das originais.

.. _mamemenu-fabricante:

* **Fabricante**

  Exibe uma lista com todos os fabricantes catalogados pelo MAME.

.. _mamemenu-ano:

* **Ano**

  Exibe uma lista de máquinas separadas por ano de lançamento.

.. _mamemenu-save-support:

* **Com suporte a salvamento**

  Exibe uma lista de máquinas onde é possível salvar o estado da
  máquina.

.. _mamemenu-nosave-support:

* **Sem suporte a salvamento**

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

Personalizar a interface
~~~~~~~~~~~~~~~~~~~~~~~~

Aqui é possível personalizar a interface do MAME, entre as opções estão:

* **Fontes**: Permite a customização da tipografia da interface, dentro
  desta opção temos:

	* **Tipografia da interface**: Aqui é possível definir uma fonte
	  para toda a interface do MAME.

		O Valor predefinido é **Padrão**

	* **Linhas**: Ajusta a dimensão do espaço e o tamanho da fonte,
	  quanto maior o valor maior a dimensão da interface e menor o texto
	  na tela.

		O Valor predefinido é **30**

	* **Tamanho da caixa de informação**: Ajusta o tamanho da fonte nas
	  caixas de texto na tela.

		O Valor predefinido é **0.75**

* **Cores**: Permite a customização completa das cores da interface do
  MAME, as opções disponíveis são:

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

	* **Cor de sobreposição do mouse**: Define a cor que texto terá
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

  Permite que você customize o Idioma da interface do MAME, use um
  clique duplo para abrir a lista e facilitar a seleção.

		O valor predefinido é **English**

* **Mostrar painéis laterais**

  Configura a exibição ou não dos painéis laterais da interface do MAME.
  As opções disponíveis são:

	* **Mostrar Tudo**
	* **Esconder Filtros**
	* **Esconder Info/Imagem**
	* **Esconder Ambos**

Configurar diretórios
~~~~~~~~~~~~~~~~~~~~~

Aqui é possível mudar as predefinições de localização dos diretórios
usados pelo MAME. As opções disponíveis são:

.. _mamemenu-diretório-roms:

* **ROMs**

  Define o caminho do diretório das ROMs. Veja também :ref:`-rompath <mame-commandline-rompath>`.

		O valor predefinido é um diretório chamado **roms** no diretório
		raiz do MAME.

* **Mídia de software**

  Define o caminho onde é armazenado o software a ser usado pela
  emulação.

		O valor predefinido é um diretório chamado **software** no
		diretório raiz do MAME.

* **Interface do usuário**

* **Idioma**

* **Amostras**

* **DATs**

* **INIs**

* **INIs de categoria**

* **Ícones**

* **Trapaças**

* **Retratos**

* **Gabinetes**

* **Panfletos**

* **Títulos**

* **Ends**

* **PCBs**

* **Marquises**

* **Painéis de controle**

* **Mira**

* **Arte**

* **Chefes**

* **Amostra das artes**

* **Selecionado**

* **Fim do jogo**

* **Como**

* **Logos**

* **Placares**

* **Versus**

* **Capas**


Opções de vídeo
~~~~~~~~~~~~~~~

Opções de Som
~~~~~~~~~~~~~

Opções diversas
~~~~~~~~~~~~~~~

Mapeamento de dispositivos
~~~~~~~~~~~~~~~~~~~~~~~~~~

Entradas gerais
~~~~~~~~~~~~~~~

Opções avançadas
~~~~~~~~~~~~~~~~

Salvar Configuração
~~~~~~~~~~~~~~~~~~~

Voltar ao menu anterior
~~~~~~~~~~~~~~~~~~~~~~~

..	[1] O `MAMEUI <http://www.mameui.info/>`_ é uma versão do MAME com
		interface gráfica. (Nota do tradutor)
