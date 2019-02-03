
.. raw:: latex

	\clearpage

.. _mamemenu:

O cardápio de opções do MAME
============================

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

Configurações
-------------

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

Opções de configuração
======================

Personalizar a interface
------------------------

Configurar diretórios
~~~~~~~~~~~~~~~~~~~~~

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
