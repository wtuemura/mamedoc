
.. raw:: latex

	\clearpage

.. _mamemenu:

Cardápio de opções
==================

.. contents:: :local:

.. raw:: latex

	\clearpage

Caso inicie o MAME sem nenhum parâmetro na linha de comando ou
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
	* **Sair**: Encerra o MAME

Todos os itens exibidos essa interface podem ser selecionados usando as
setas do seu teclado (cima, baixo, esquerda, direita) e são selecionadas
pressionando a tecla **Enter** do teclado. A interface também aceita o
uso do mouse fazendo a seleção com um clique e um duplo clique para abri
a opção ou rodar uma máquina.

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


Opções de configuração
----------------------

.. _mamemenu-filtro:

Filtro
~~~~~~

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
  com o MAME foram criadas para serem usadas com o MAMEUI [#]_ e não
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

Aqui é possível personalizar a interface do MAME, os valores numéricos
podem ser alterados movendo o direcional para a esquerda e direita ou
pressionando a tecla **Enter** e digitando o valor manualmente.

As opções disponíveis são:

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

  Permite customizar o Idioma da interface do MAME, use um
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

  Define o caminho do diretório onde se encontram as ROMs. Veja também
  :ref:`-rompath <mame-commandline-rompath>`.

		O valor predefinido é um diretório chamado **roms** no diretório
		raiz do MAME.

* **Software em mídia**

  Define o caminho onde é armazenado a imagem dos arquivos em mídia como
  CD-ROM, floppy, fita K7 ou qualquer outro programa avulso.

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
  usadas como amostras de som no MAME.

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

* **INIs de categoria**

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

* **Trapaças**

  Define o caminho do diretório onde se encontra o arquivo de trapaça.
  Este arquivo também pode ser deixado na pasta raiz do MAME.

		O valor predefinido é um diretório chamado **cheats** no
		diretório raiz do MAME. [#]_

* **Retratos**

  Define o caminho do diretório onde serão armazenados os instantâneos
  da tela e a gravação de vídeo. [#]_

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

* **Arte**

  Define o caminho do diretório onde se encontram as ilustrações
  gráficas que fazem o preenchimento de fundo da tela das máquinas.
  Veja mais em :ref:`-artpath <mame-commandline-artpath>`.

		O valor predefinido é um diretório chamado **artwork** no
		diretório raiz do MAME.

* **Chefes**

  Define o caminho do diretório onde se encontram as imagens com os
  instantâneos de tela dos chefes de fase. [#]_

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
  instantâneos de tela mostrando o **GAME OVER**.

		O valor predefinido é um diretório chamado **gameover** no
		diretório raiz do MAME.

* **Como**

  Define o caminho do diretório onde se encontram as imagens ou fotos
  daqueles panfletos que mostravam as instruções de como jogar.

		O valor predefinido é um diretório chamado **howto** no
		diretório raiz do MAME.

* **Logo**

  Define o caminho do diretório onde se encontram as imagens ou
  ilustrações com a logomarca das empresas.

		O valor predefinido é um diretório chamado **logos** no
		diretório raiz do MAME.

* **Placares**

  Define o caminho do diretório onde se encontram as imagens com os
  instantâneos de tela mostrando as maiores pontuações. [#]_

		O valor predefinido é um diretório chamado **scores** no
		diretório raiz do MAME.

* **Versus**

  Define o caminho do diretório onde se encontram as imagens com os
  instantâneos de tela mostrando as maiores pontuações.

		O valor predefinido é um diretório chamado **versus** no
		diretório raiz do MAME.

* **Capas**

  Define o caminho do diretório onde se encontram as imagens com as
  capas dos jogos.

		O valor predefinido é um diretório chamado **covers** no
		diretório raiz do MAME.

.. raw:: latex

	\clearpage

Opções de Vídeo
~~~~~~~~~~~~~~~

Essas opções sempre serão lidas no inicio do MAME, lembrando que a linha
de comando **sempre** terá prioridade, independente do que seja definido
aqui.

* **Modo do Vídeo**

  Veja :ref:`-video <mame-commandline-video>`.

		O valor predefinido é **Auto**

* **Número de Telas**

  Predefine a quantidade de telas a serem usadas.

		O valor predefinido é **1**.

* **GLSL**

  Habilita ou não os efeitos GLSL.

		O valor predefinido é **Desligado**

* **Filtragem Bilinear**

  Habilita ou não os filtros de tela para suavizar os gráficos, caso os
  gráficos fiquem muito borrados, experimente habilitar também a opção
  **Pré-escala de bitmap**.

		O valor predefinido é **Ligado**

* **Pré-escala de Bitmap**

  Opção útil quando máquinas com baixa resolução são ampliadas para uma
  resolução maior, use essa opção para dar uma amenizada nessa
  aparência, essa opção geralmente é utilizada em conjunto com a opção
  **Filtragem bilinear**.

		O valor predefinido é **1**.

* **Modo Janelado**

  Faz o MAME exibir a tela em uma janela ou em uma tela inteira.

		O valor predefinido é **Desligado**.

* **Manter a proporção da tela**

  Faz com que a proporção da imagem exibida seja sempre mantida.

		O valor predefinido é **Ligado**.

* **Iniciar Maximizado**

  Faz o MAME exibir uma janela na altura máxima da sua tela. 

		O valor predefinido é **Ligado**.

* **Atualização Sincronizada de Quadros**

  Veja :ref:`-syncrefresh <mame-commandline-syncrefresh>`.

* **Aguardar Sincronismo Vertical**

  Veja :ref:`-waitvsync <mame-commandline-waitvsync>`.

Opções de Som
~~~~~~~~~~~~~

* **Som**

  Habilita o não o áudio.

		O valor predefinido é **Ligado**.

* **Taxa de amostragem**

  Define a taxa de amostragem que será usada em todas as máquinas.

		O valor predefinido é **48000**.

* **Usar amostras externas**

  Veja :ref:`- samples <mame-commandline-nosamples>`.

Opções diversas
~~~~~~~~~~~~~~~

* **Lembrar da última máquina selecionada**

  Faz com que o MAME se lembre da última máquina selecionada na
  interface do MAME.

		O valor predefinido é **Ligado**.

* **Aumentar as imagens no painel direito**

  Aumenta o tamanho de qualquer uma das imagens exibidas no painel
  direito da interface do MAME, sempre mantendo a proporcionalidade da
  imagem.

		O valor predefinido é **Ligado**.

* **Trapaças**

  Habilita ou não o sistema de trapaças do MAME.

		O valor predefinido é **Desligado**.

* **Exibir o ponteiro do mouse**

  Habilita ou não a exibição do mouse na interface do MAME.

		O valor predefinido é **Ligado**.

* **Confirmar saída das máquinas**

  Faz com que o MAME sempre peça uma confirmação ao sair.

		O valor predefinido é **Desligado**.

* **Omitir a tela de informação ao iniciar**

  Não exibe a tela com informações sobre o sistema.

		O valor predefinido é **Desligado**.

* **Manter aspecto 4:3 para instantâneos de tela**

  Faz com que todos os prints da tela mantenham uma proporção de
  4:3.

		O valor predefinido é **Ligado**.

.. raw:: latex

	\clearpage

* **Usar imagem como plano de fundo**

  Permite o uso de uma imagem como papel de parede na interface do MAME.
  Escolha uma imagem *.JPG* e a renomeie para **backgound.jpg**.

		O valor predefinido é **Ligado**.

* **Omitir a tela de seleção de BIOS**

  Faz com que o MAME inicie a máquina com a primeira BIOS disponível
  para a máquina ao em vez de usar uma lista.

		O valor predefinido é **Desligado**.

* **Omitir partes do cardápio de seleção de software**

  Altera a maneira com que a lista de software é exibida, em vez de
  exibir a lista como é predefinido pelo MAME, a lista será exibida na
  sequência que os itens estiverem listados no arquivo da respectiva
  lista.

		O valor predefinido é **Desligado**.

* **Informação automática de aferição**

  Exibe na aba de informações gerais ao lado direito da interface do
  MAME informação quanto a condição **BOA** ou **RUIM** da ROM
  selecionada. Assim como também verifica se a máquina usa amostras ou
  não aferindo a condição delas caso esteja **BOA** ou **RUIM**. Caso a
  máquina não use amostras aparecerá a mensagem **Nenhuma Necessária**.
  Note que essa função deixa a interface do MAME um pouco mais lenta
  devido as aferições que são feitas a cada seleção da ROM.

		O valor predefinido é **Desligado**.

* **Esconder máquinas sem ROMs da lista de disponíveis**

  Esconde da lista máquinas eletrônicas que não usam ROMs.

		O valor predefinido é **Ligado**.

.. raw:: latex

	\clearpage

Mapeamento de dispositivos
~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Entradas gerais
~~~~~~~~~~~~~~~

* **interface do usuário**

  Aqui estão os principais atalhos já predefinidos da interface do MAME,
  todos eles podem ser alterados conforme a necessidade. Para retornar
  ao valor original tecle **DELETE** duas vezes em cima da opção.

* **On screen display**

  Exibe um visor na parte inferior da tela durante a emulação para a
  realização de ajustes em tempo real.

	A tecla predefinida é **Til**.

* **Brek in debugger**

  Atalho para entrar no depurador durante a emulação, só funciona caso
  o MAME tenha sido compilado com ferramentas de depuração.

	A tecla predefinida é **Til**.

* **Config menu**

  Chama o cardápio de opções do MAME.

	A tecla predefinida é **Tab**.

* **Pause**

  Pausa a emulação.

	A tecla predefinida é **P**.

* **Pause - Single step**

  Avança em passos de um quadro.

	As teclas predefinidas são **P** + **Shift Esq**.

* **Rewing - Single step**

  Retrocede em passos de um quadro.

	As teclas predefinidas são **Til** + **Shift Esq**.

* **Reset machine**

  Encerra a emulação e a inicia do zero.

	As teclas predefinidas são **F3** + **Shift Esq**.

* **Soft reset**

  Recomeça o software apenas sem encerrar a emulação.

	A telcla predefinida é **F3**.

* **Show gfx**

  Mostra a paleta GFX decodificada e os tilemaps dos jogos.

	A tecla predefinida é **F4**.

* **Frameskip dec**

  Redução do salto de quadros.

	A tecla predefinida é **F8**.

* **Frameskip inc**

  Aumento do salto de quadros.

	A tecla predefinida é **F9**.

* **Throttle**

  Acelerador da emulação, faz a emulação rodar cerca de 3x mais rápido
  que o normal, não funciona em versões SDL.

	A tecla predefinida é **F10**.

* **Fast forward**

  Como o exemplo anterior porém faz a emulação rodar o mais rápido
  possível.

* **Show fps**

  Exibe quantos quadros por segundo a emulação está rodando.

	A tecla predefinida é **PgDn** em versões SDL do MAME e **Insert**
	no Windows. 

* **Save snapshot**

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

* **Toggle cheat**

  Habilita a trapaça no jogo.

	A tecla predefinida é **F6**.

* **Toggle autofire**

  Habilita o modo turbo dos botões de tiro.

	A tecla predefinida é **Nenhum**.

* **UI up**

  Move o cursor para cima.

	A tecla predefinida é **Tecla cima** ou **Cima do controle**.

* **UI down**

  Move o cursor para baixo.

	A tecla predefinida é **Tecla baixo** ou **Baixo do controle**.

* **UI left**

  Move o cursor para a esquerda.

	A tecla predefinida é **Tecla esquerda** ou **Esquerda do
	controle**.

* **UI right**

  Move o cursor para a direita.

	A tecla predefinida é **Tecla direita** ou **Direita do controle**.

* **UI home**

  Move o cursor para o topo da lista.

	A tecla predefinida é **Tecla home**.

* **UI end**

  Move o cursor para o fim da lista.

	A tecla predefinida é **Tecla end**.

* **UI page up**

  Move o cursor para o topo da lista saltando 26 linhas por vez.

	A tecla predefinida é **Tecla page up**.

* **UI page down**

  Move o cursor para o fim da lista saltando 26 linhas por vez.

	A tecla predefinida é **Tecla page down**.

* **UI select**

  Tecla de seleção para qualquer item selecionável.

	As teclas predefinidas são **Enter**, **Botão 0 do controle** ou
	**Tecla enter do teclado numérico**.

* **UI cancel**

  Tecla para cancelar qualquer ação.

	A tecla predefinida é **Tecla escape ou esq**.

* **UI Display comment**

  Tecla para exibir comentário.

	A tecla predefinida é **Tecla espaço**.

* **UI clear**

  Tecla para apagar/zerar uma opção.

	A tecla predefinida é **Tecla delete ou del**.

* **UI zoom in**

  Tecla para aproximar (dar zoom) na interface. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **Tecla =**.

* **UI zoom out**
  Tecla para sair do zoom da interface. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **Tecla -**.

* **UI previous group**

  Faz a lista pular para o grupo anterior. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **[**. 

* **UI next group**

  Faz a lista pular para o próximo grupo. Ainda não funciona em
  teclados ABNT, apenas em teclados tipo ANSI.

	A tecla predefinida é **]**.

* **UI rotate**

  Rotaciona a interface.

	A tecla predefinida é **R** (não funciona).

* **Show profile**

  Exibe o analisador de desempenho (não funciona).

	A teclas predefinidas são **F11** + **Shift Esq**.

* **UI Toggle**

  Alterna a interface do usuário.

	A tecla predefinida é **Screen lock**.

* **UI paste text**

  Cola texto na interface do usuário (não funciona).

	As teclas predefinidas são **Screen lock** + **Shift Esq**.

* **Toggle deugger**

  Alterna o depurador.

	A tecla predefinida é **F5**.

* **Save state**

  Salva o estado da máquina.

	As teclas predefinidas são **F7** + **Shift Esq**.

* **Load state**

  Carrega o estado da máquina.

	A tecla predefinida é **F7**.

* **UI (First) tape start**

  Inicia a fita na interface primária.

	A tecla predefinida é **F2**.

* **UI (First) tape stop**

  Para a fita na interface primária.

	As teclas predefinidas são **F2** + **Shift Esq**.

* **UI external DAT view**

  Exibe o DAT externo.

	As teclas predefinidas são **Alt Esq** + **D** (não funciona).

* **UI Add/Remove favorites**

  Adiciona ou remove as máquinas dos favoritos.

	As teclas predefinidas são **Alt Esq** + **F** (não funciona).

* **UI export list**

  Exporta a lista das máquinas em formato:

	* **XML** igual ao comando **-listxml**.
	* **XML** igual ao comando **-listxml** excluindo os dispositivos.
	* **TXT** igual ao comando **-listfull**.

	As teclas predefinidas são **Alt Esq** + **E**.

* **UI Audit unavailable**

  Realiza uma auditoria das ROMs removendo as não disponíveis, o
  resultado é salvo no arquivo **mame_avail.ini** dentro do diretório
  **ui**.

	A tecla predefinida é **F1**.

* **UI Audit all**

  Realiza uma auditoria de todas as ROMs, o resultado é salvo no arquivo
  **mame_avail.ini** dentro do diretório **ui**.

	As teclas predefinidas são **F1** + **Shift Esq**.

* **Toggle fullscreen**

  Alterna entre tela inteira e janela.

	As teclas predefinidas são **Enter** + **Alt Esq**.

* **Toggle uneven stretch**

  Alterna entre poder esticar a tela com e sem proporção de tamanho.

	As teclas predefinidas são **F3** + **Ctrl Esq**.

* **Toggle keepaspect**

  Alterna entre manter ou não a proporção da tela.

	As teclas predefinidas são **F4** + **Ctrl Esq**.

* **Toggle filter**

  Alterna entre usar ou não o filtro na tela.

	As teclas predefinidas são **F5** + **Ctrl Esq**.

* **Decrease prescaling**

  Reduz a pré-escala de dos pixels.

	As teclas predefinidas são **F6** + **Ctrl Esq**.

* **Increase prescaling**

  Aumenta a pré-escala de dos pixels.

	As teclas predefinidas são **F7** + **Ctrl Esq**.

* **Record rendered video**

  Grava o vídeo usando todos os efeitos e filtros ativos na tela.

	As teclas predefinidas são **F12** + **Ctrl+Alt Esq**.

* **Player 1 ~ 10 controls**

  Definições para todos os botões e controles usados pela máquina
  separado por jogador, entre o jogador 1 até o 10. Abaixo a lista das
  opções predefinidas para o jogador 1 que podem ser alteradas na
  própria interface do MAME.

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

Opções avançadas
~~~~~~~~~~~~~~~~

Opções de performance
^^^^^^^^^^^^^^^^^^^^^

* **Salto de quadros automático**

  Ignora quadros de forma automática visando manter a velocidade da
  emulação.

	Valor predefinido é **Desligado**

* **Salto de quadro**

  Define uma quantidade fixa de quadros a serem ignorados visando manter
  a velocidade da emulação.

	Valor predefinido são **0** quadros.

* **Supressão de velocidade**

  Habilita a supressão de velocidade da emulação para que a máquina
  emulada rode em sua velocidade nativa ao invés da velocidade do
  processador em que a máquina está sendo emulada.

	Valor predefinido é **Ligado**

* **Dormir**

  Reduz o consumo de processamento quando o MAME estiver parado sem
  fazer nada.

	Valor predefinido é **Ligado**

* **Velocidade**

  Controla a velocidade do jogo com relação ao tempo de emulação.

	Valor predefinido é **1**

* **Atualização de velocidade**

  Controla a velocidade da emulação de forma automática mantendo a taxa
  de atualização de tela mais lenta em referência com a taxa de
  atualização de tela do computador que está rodando a emulação.

	Valor predefinido é **Desligado**

* **Low Latency**

  Reduz a latência (atraso) dos dispositivos de entrada como joysticks
  por exemplo. Para mais informações veja :ref:`-[no]lowlatency
  <mame-commandline-lowlatency>`.

Opções de rotação
^^^^^^^^^^^^^^^^^

* **Rotação**

  Permite que a orientação da tela mude conforme a orientação de tela do
  jogo.

	Valor predefinido é **Ligado**

* **Rotacionar para direita**

  Rotacione a tela em 90 graus sentido horário.

	Valor predefinido é **Desligado**

* **Rotacionar para esquerda**

  Rotacione a tela em 90 graus sentido anti-horário.

	Valor predefinido é **Desligado**

* **Auto rotacionar para direita**

  Rotacione automaticamente a tela em 90 graus sentido horário caso
  a tela esteja orientada verticalmente.

	Valor predefinido é **Desligado**

* **Auto rotacionar para esquerda**

  Rotacione automaticamente a tela em 90 graus sentido anti-horário
  caso a tela esteja orientada verticalmente.

	Valor predefinido é **Desligado**

* **Giro X**

  Inverte a tela da esquerda para a direita.

	Valor predefinido é **Desligado**

* **Giro Y**

  Inverte a tela da direita para a esquerda.

	Valor predefinido é **Desligado**


Opções de Ilustrações
^^^^^^^^^^^^^^^^^^^^^

* **Recorte da ilustração**

  Recorta a imagem usada como ilustração de forma que ocupe toda a tela
  emulada em apenas um eixo.

	Valor predefinido é **Desligado**

* **Usar plano de fundo**

  Permite o uso de uma imagem de plano de fundo caso exista um arquivo
  de plano de fundo disponível.

	Valor predefinido é **Ligado**

* **Usar sobreposições**

  Permite o uso de uma imagem de sobreposição na tela caso exista um
  arquivo de sobreposição disponível.

	Valor predefinido é **Ligado**

* **Usar molduras**

  Permite o uso de uma imagem de moldura na tela caso exista um arquivo
  de moldura disponível.

	Valor predefinido é **Ligado**

* **Usar painéis de controle**

  Permite o uso de uma imagem na de painel de controle na tela caso
  exista um arquivo de painel de controle disponível.

	Valor predefinido é **Ligado**

* **Usar marquises**

  Permite o uso de uma imagem de marquise na tela caso exista um
  arquivo de marquise disponível.

	Valor predefinido é **Ligado**

Opções de Estado/Playback
^^^^^^^^^^^^^^^^^^^^^^^^^

* **Salvar/Restaurar Automático**

  Em sistema compatíveis, carrega automaticamente o estado da máquina e
  a salva ao sair.

	Valor predefinido é **Desligado**

* **Retroceder**

  Habilita o rebobinamento do estado da máquina.

	Valor predefinido é **Desligado**

* **Função de rebobinamento**

  Reserva uma memória para rebobinamento em Megabytes.

	Valor predefinido é **100**

* **Retrato bilinear**

  Define se os vídeos ou instantâneos de tela terão o filtro aplicado.

	Valor predefinido é **Ligado**

* **Burn-in**

  Cria prints de tela com marcas de fósforo queimado.

	Valor predefinido é **Desligado**

Opções de Entrada
^^^^^^^^^^^^^^^^^

* **Ignora ficha**

  Faz com que a máquina ignore a inserção de fichas em momentos em que
  a máquina não está pronta para recebê-las.

	Valor predefinido é **Ligado**

* **Mouse**

  Permite o uso de um mouse nas máquinas.

	Valor predefinido é **Desligado**

* **Controle**

  Permite o uso de um controle nas máquinas.

	Valor predefinido é **Ligado**

* **Pistola de luz**

  Habilita o uso do uma pistola de luz.

	Valor predefinido é **Desligado**

* **Teclado múltiplo**

  Permite o uso de mais de um teclado para cada entrada compatível.

	Valor predefinido é **Desligado**

* **Mouse múltiplo**

  Permite o uso de mais de um mouse para cada entrada compatível.

	Valor predefinido é **Desligado**

* **Steadykey**

  Alguns sistemas exigem que dois ou mais botões sejam pressionados
  exatamente ao mesmo tempo para realizar movimentos ou comandos
  especiais. Devido a limitação do hardware do teclado, pode ser difícil
  ou até mesmo impossível de realizar usando um teclado comum. Essa
  opção seleciona diferentes modos de manuseio o que torna mais fácil
  registrar o pressionamento simultâneo das teclas, porém tem a
  desvantagem de deixar a sua capacidade de resposta mais lenta.

	Valor predefinido é **Desligado**

* **IU ativa**

  Habilita a opção para que a interface do usuário se sobreponha a do
  teclado emulado caso esteja presente.

	Valor predefinido é **Desligado**

* **Recarga fora da tela**

  Converte o botão 2 da pistola de luz como recarga fora da tela.

	Valor predefinido é **Desligado**

* **Zona morta do controle**

  Permite fazer o ajuste fino do ponto morto do controle ou manche.

	Valor predefinido é **0.3**

* **Saturação do controle**

  Faz o ajuste findo do eixo de fim de curso do controle.

	Valor predefinido é **0.85**

* **Teclado natural**

  Habilita ou não o uso de um teclado natural.

	Valor predefinido é **Desligado**

* **Direção simultânea**

  Aceita a entrada de comandos contraditórios e simultâneos no controle
  digital como esquerda e direita ou cima e baixo ao mesmo tempo.

	Valor predefinido é **Desligado**

* **Impulso de ficha**

  Define o tempo de impulso da ficha.

	Valor predefinido é **0**

Salvar Configuração
~~~~~~~~~~~~~~~~~~~

Salva todas as alterações feitas.

Voltar ao menu anterior
~~~~~~~~~~~~~~~~~~~~~~~

..	[#] O `MAMEUI <http://www.mameui.info/>`_ é uma versão do MAME com
		interface gráfica.
..	[#] O site do `MAMEICONS <http://icons.mameworld.info/>`_ e
		`Progetto Snaps <http://www.progettosnaps.net/icons>`_ oferecem
		tais ícones e outras imagens para download.
..	[#] O site `Pugsy's Cheat <http://cheat.retrogames.com/>`_ é um dos
		mais conhecidos que oferece um arquivo de trapaça para download.
.. 	[#] Em alguns lugares as pessoas também conhecem como "*print de
		tela*", "*print da tela*", "*captura de tela*", "*fazer um
		printscreen*", "*fazer um print da tela*", etc.
..	[#] O site `MAME Channel <https://www.mamechannel.it/pages/titles.php>`_
		oferece diferentes telas de títulos para download.
..	[#] É possível baixar essas imagens do site `EmuMovies
		<https://emumovies.com/files/file/3493-mame-bosses-pack/>`_.
..	[#] É possível baixar essas imagens do site `High-Score
		<http://highscore.com/>`_ e
		`Cubeman <http://www.cubeman.org/mame1.html>`_.
