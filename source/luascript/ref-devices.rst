.. _luascript-ref-dev:

Classes dos dispositivos Lua
============================

Diversas classes de dispositivos e classes combinadas de dispositivos
são expostas ao Lua. Os dispositivos podem ser pesquisados através das
tags ou podem ser enumerados.

.. contents::
    :local:
    :depth: 1


.. _luascript-ref-devenum:

Os enumeradores de dispositivos
-------------------------------

Os enumeradores de dispositivos são contêineres especiais que permitem
iterar (repetir) e pesquisar os dispositivos através de uma tag. Um
enumerador pode ser criado para encontrar qualquer tipo de dispositivo,
para encontrar dispositivos de um tipo em particular ou para encontrar
dispositivos que implementem uma interface específica. Ao iterar os
dispositivos utilizando ``pairs`` ou ``ipairs``, tais dispositivos
retornam primeiro através da árvore dos dispositivos em ordem de
criação.

O índice faz com que o operador procure um dispositivo através da tag.
Ele retorna ``nil`` caso nenhum dispositivo com a tag especificada seja
encontrado ou se o dispositivo com tal tag não atenda aos requisitos do
tipo ou da interface do enumerador dos dispositivos. A complexidade é
O(1) caso o resultado seja colocado em cache, porém, a busca de um
dispositivo sem cache é custosa. O método ``at`` tem complexidade O(n).

Caso crie um enumerador dos dispositivos com um ponto de partida
diferente do dispositivo do sistema principal, a entrega de uma tag
completa ou uma tag contendo as referências principais para o operador
do índice pode fazer com que retorne um dispositivo que não seria
descoberto pela iteração. Se você criar um enumerador dos dispositivos
com uma extensão restrita, os dispositivos que não seriam encontrados
por serem muito extensos dentro hierarquia ainda podem ser pesquisados
através da tag.

A criação de um enumerador para os dispositivos com extensão restrita a
zero pode ser usada para reduzir um dispositivo ou testar se um
dispositivo consegue implementar uma determinada interface. Por exemplo,
isto testará se um dispositivo consegue implementar a interface de
imagem da mídia:

.. code-block:: Lua

    image_intf = emu.image_enumerator(device, 0):at(1)
    if image_intf then
        print(string.format("Device %s mounts images", device.tag))
    end

Instanciação
~~~~~~~~~~~~~

**manager.machine.devices**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo <luascript-ref-device>` no sistema.


**manager.machine.palettes**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos paleta <luascript-ref-dipalette>` no
	sistema.


**manager.machine.screens**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos da tela <luascript-ref-screendev>` no sistema.


**manager.machine.cassettes**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo de imagem em fita cassete <luascript-ref-cassdev>`
	no sistema.


**manager.machine.images**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos de interface de imagem <luascript-ref-diimage>`
	no sistema.


**manager.machine.slots**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos slot <luascript-ref-dislot>` no sistema.


**emu.device_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo <luascript-ref-device>` na sub-árvore começando
	num dispositivo específico. O dispositivo informado será incluído.
	Caso a profundidade seja informada, este deve ser um valor inteiro
	que irá definir a quantidade máxima dos níveis que serão iterados
	abaixo do dispositivo informado (Por exemplo, ``1`` irá limitar a
	iteração do dispositivo e dos dispositivos relacionados).


**emu.palette_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos paleta <luascript-ref-dipalette>` na
	sub-árvore começando num dispositivo específico. O dispositivo
	informado será incluído caso seja um dispositivo paleta. Caso a
	profundidade seja informada, este deve ser um valor inteiro que irá
	definir a quantidade máxima dos níveis que serão iterados abaixo do
	dispositivo informado (Por exemplo, ``1`` irá limitar a iteração do
	dispositivo e dos dispositivos relacionados).


**emu.screen_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos tela <luascript-ref-screendev>` na sub-árvore
	começando num dispositivo específico. O dispositivo informado será
	incluído se for um dispositivo tela. Caso a profundidade seja
	informada este deve ser um valor inteiro que irá definir a
	quantidade máxima dos níveis que serão iterados abaixo do
	dispositivo informado (Por exemplo, ``1`` irá limitar a iteração do
	dispositivo e dos dispositivos relacionados).


**emu.cassette_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre o
	:ref:`dispositivo de imagem em fita cassete <luascript-ref-cassdev>`
	na sub-árvore começando num dispositivo específico. O dispositivo
	informado será incluído se for um dispositivo cassete. Caso a
	profundidade seja informada, este deve ser um valor inteiro que irá
	definir a quantidade máxima dos níveis que serão iterados abaixo do
	dispositivo informado (Por exemplo, ``1`` irá limitar a iteração do
	dispositivo e dos dispositivos relacionados).

.. raw:: latex

	\clearpage


**emu.image_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos de imagem em mídia <luascript-ref-diimage>` na
	sub-árvore começando num dispositivo específico. O dispositivo
	informado será incluído caso seja uma mídia de um dispositivo de
	imagem. Caso a profundidade seja informada este deve ser um valor
	inteiro que definirá a quantidade máxima dos níveis que serão
	iterados abaixo do dispositivo informado (Por exemplo, ``1`` irá
	limitar a iteração do dispositivo e dos dispositivos relacionados).


**emu.slot_enumerator(dispositivo, [profundidade])**

	Retorna um dispositivo enumerador que irá iterar sobre os
	:ref:`dispositivos slot <luascript-ref-dislot>`
	na sub-árvore começando num dispositivo específico. O dispositivo
	informado será incluído se for um dispositivo slot. Caso a
	profundidade seja informada, este deve ser um valor inteiro que
	definirá a quantidade máxima dos níveis que serão iterados abaixo do
	dispositivo informado (Por exemplo, ``1`` irá limitar a iteração do
	dispositivo e dos dispositivos relacionados).


.. _luascript-ref-device:

Dispositivo
-----------

|encaa| ``device_t`` do MAME que serve de base para todas as
classes dos dispositivos.

Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag]**

	Obtém um dispositivo através de uma tag com relação ao dispositivo
	do sistema principal ou ``nil`` caso o dispositivo não exista.


**manager.machine.devices[tag]:subdevice(tag)**

	Obtém um dispositivo através de uma tag com relação a outro
	dispositivo arbitrário ou ``nil`` caso o dispositivo não exista.

Métodos
~~~~~~~

**device:subtag(tag)**

	Converte uma tag com relação ao dispositivo numa tag absoluta.


**device:siblingtag(tag)**

	Converte uma tag com relação ao dispositivo principal do dispositivo
	numa tag absoluta.


**device:memshare(tag)**

	Obtém um :ref:`compartilhamento da memória <luascript-ref-memshare>`
	através de uma tag com relação ao dispositivo ou ``nil`` caso o
	compartilhamento da memória não exista.


**device:membank(tag)**

	Obtém um :ref:`banco da memória <luascript-ref-membank>` através
	de uma tag com relação ao dispositivo ou ``nil`` caso o banco da
	memória não exista.


**device:memregion(tag)**

	Obtém uma :ref:`região da memória <luascript-ref-memregion>` através
	de uma tag com relação ao dispositivo ou ``nil`` caso a região da
	memória não exista.

.. raw:: latex

	\clearpage


**device:ioport(tag)**

	Obtém uma :ref:`porta de E/S <luascript-ref-ioport>` através da
	tag com relação ao dispositivo ou ``nil`` caso a porta de E/S não
	exista.


**device:subdevice(tag)**

	Obtém um dispositivo através de uma tag com relação ao dispositivo.


**device:siblingdevice(tag)**

	Obtém um dispositivo através de uma tag com relação ao dispositivo
	principal.


**device:parameter(tag)**

	Obtém o valor do parâmetro através da tag relativa ao dispositivo ou
	uma *string* vazia caso não esteja definida.

Propriedades
~~~~~~~~~~~~

**device.tag** |sole|

	A tag absoluta do dispositivo em forma canônica.


**device.basetag** |sole|

	O último componente da tag do dispositivo (Por exemplo, quando a sua
	tag for relativa ao dispositivo principal) ou ``"root"`` para o
	dispositivo raiz do sistema.


**device.name** |sole|

	Exibe o nome completo para o tipo do dispositivo.


**device.shortname** |sole|

	O nome curto do tipo do dispositivo (usado, por exemplo, na linha de
	comando, ao procurar por recursos como ROMs ou a ilustração e em
	vários arquivos de dados).


**device.owner** |sole|

	A relação direta do dispositivo na árvore do dispositivo ou ``nil``
	para o dispositivo raiz do dispositivo do sistema.


**device.configured** |sole|

	Um booleano que indica se o dispositivo concluiu a configuração.


**device.started** |sole|

	Um booleano que indica se o dispositivo concluiu a inicialização.


**device.debug** |sole|

	A :ref:`interface de depuração do dispositivo
	<luascript-ref-devdebug>` para o dispositivo caso seja um
	dispositivo CPU ou ``nil`` caso não seja ou se o depurador não
	estiver ativado.

.. raw:: latex

	\clearpage


**device.state[ ]** |sole|

	O :ref:`estado das entradas <luascript-ref-distateentry>` para os
	dispositivos que expõem a interface de registro do estado, indexadas
	por símbolos ou ``nil`` para outros dispositivos. O operador do
	índice e os métodos ``index_of`` têm complexidade O(n); todas as
	outras operações compatíveis têm complexidade O(1).


**device.spaces[ ]** |sole|

	A tabela dos :ref:`espaços de endereçamento da memória
	<luascript-ref-addrspace>` do dispositivo, indexado por nome.
	Válido apenas para os dispositivos que implementam a interface da
	memória. Observe que os nomes são específicos para o tipo do
	dispositivo e não têm um significado especial.


.. _luascript-ref-dipalette:

Dispositivo paleta
------------------

|encaa| ``device_palette_interface`` do MAME que representa um
dispositivo que traduz uma cadeia de valores em cores.

|acsre| alfa/vermelho/verde/azul (ARGB). |osvalo|. Os valores das cores
do canal não são multiplicados previamente pelo valor alpha. Os valores
do canal devem ser empacotados em bytes com 32 bits inteiros não
assinados pelo valor do canal alfa, na ordem alpha, vermelho, verde,
azul a partir do byte mais importante até o byte com menor importância.


Instanciação
~~~~~~~~~~~~

**manager.machine.palettes[tag]**

	Obtém um dispositivo paleta através da tag em relação ao dispositivo
	raiz do sistema ou ``nil`` caso o dispositivo não exista ou caso não
	seja um dispositivo paleta.


Métodos
~~~~~~~

**palette:pen(índice)**

	Obtém o número da cadeia remapeada para o índice especificado da
	paleta.


**palette:pen_color(pen)**

	Obtém a cor para o número da cadeia especificada.


**palette:pen_contrast(pen)**

	Obtém o valor do contraste para o o número da cadeia especificada.
	|ocvp|.


**palette:pen_indirect(índice)**

	Obtém o índice indireto da cadeia para um índice específico da
	cadeia.


**palette:indirect_color(índice)**

	Obtém o índice indireto da cadeia de cores para um índice específico
	da cadeia.


**palette:set_pen_color(pen, cor)**

	Define a cor para um número específico da cadeia. A cor pode ser
	definida como um único valor empacotado de 32 bits; ou valores
	individuais para os canais vermelho, verde e azul, nesta ordem.

.. raw:: latex

	\clearpage


**palette:set_pen_red_level(pen, nível)**

	Define o valor do canal da cor vermelho para o número da cadeia
	especificada. |ovdo|.


**palette:set_pen_green_level(pen, nível)**

	Define o valor do canal da cor verde para o número da cadeia
	especificada. |ovdo|.


**palette:set_pen_blue_level(pen, nível)**

	Define o valor do canal da cor azul para o número da cadeia
	especificada. |ovdo|.


**palette:set_pen_contrast(pen, fator)**

	Define o valor do contraste para o número da cadeia especificada.
	|ocvp|.


**palette:set_pen_indirect(pen, índice)**

	Define o índice indireto para um número específico da cadeia.


**palette:set_indirect_color(índice, color)**

	Define um índice indireto da cor da cadeia para um índice específico da
	paleta. A cor pode ser definida como um único valor empacotado de 32
	bits; ou valores individuais para os canais vermelho, verde e azul,
	nesta ordem.


**palette:set_shadow_factor(fator)**

	Define o valor do contraste para o grupo *"shadow"* atual. |ocvp|.


**palette:set_highlight_factor(fator)**

	Define o valor do contraste para o grupo atual em destaque. |ocvp|.


**palette:set_shadow_mode(modo)**

	Define o modo *"shadow"*. O valor é o índice da tabela *"shadow"*
	desejada.

Propriedades
~~~~~~~~~~~~

**palette.palette** |sole|

	A :ref:`paleta <luascript-ref-palette>` adjacente gerenciada pelo
	dispositivo.


**palette.entries** |sole|

	A quantidade dos registros de cores na paleta.


**palette.indirect_entries** |sole|

	A quantidade de registros indiretos da cadeia na paleta.


**palette.black_pen** |sole|

	O índice fixo do registro da cor preta na cadeia.

.. raw:: latex

	\clearpage


**palette.white_pen** |sole|

	O índice fixo do registro da cor branca na cadeia.


**palette.shadows_enabled** |sole|

	|ubqi| as cores *"shadow"* estão ativadas.


**palette.highlights_enabled** |sole|

	|ubqi| as cores em destaque estão ativadas.


**palette.device** |sole|

	O dispositivo :ref:`subjacente <luascript-ref-device>`.


.. _luascript-ref-screendev:

Dispositivo tela
----------------

|encaa| ``screen_device`` do MAME que representa uma saída emulada de
vídeo.

Instanciação
~~~~~~~~~~~~

**manager.machine.screens[tag]**

	Obtém um dispositivo tela através da tag em relação ao dispositivo
	raiz do sistema, ou ``nil`` caso o dispositivo não exista ou caso
	não seja um dispositivo tela.

Classes base
~~~~~~~~~~~~

* :ref:`luascript-ref-device`

Métodos
~~~~~~~

**screen:orientation()**

	Retorna o ângulo de rotação em graus (será um de ``0``, ``90``,
	``180`` ou ``270``), ou se a tela está virada da esquerda para a
	direita e se está invertida de cima para baixo. Essa é a orientação
	final da tela depois que a orientação tenha sido definida na
	configuração do sistema e a rotação tenha sido aplicada.


**screen:time_until_pos(v, [h])**

	Obtém o tempo restante até que o raster atinja a posição
	especificada. Caso o componente horizontal da posição não é seja
	informado, a predefinição é zero (``0``, ou seja, o início da
	linha). O resultado é um número de ponto flutuante em unidades de
	segundos.


**screen:time_until_vblank_start()**

	Obtém o tempo restante até o início do intervalo de apagamento
	vertical. O resultado é um número de ponto flutuante em unidades de
	segundos.

.. raw:: latex

	\clearpage


**screen:time_until_vblank_end()**

	Obtém o tempo restante até o final do intervalo de apagamento
	vertical. O resultado é um número de ponto flutuante em unidades de
	segundos.


**screen:snapshot([nome_do_arquivo])**

	Salva uma captura da tela em formato PNG. Caso nenhum nome do
	arquivo seja informado, será usado o caminho e o formato padrão
	configurado para a captura da tela. Caso o nome do arquivo informado
	não seja um caminho absoluto, ele será interpretado em relação ao
	primeiro caminho que foi configurado. O nome do arquivo pode conter
	variáveis que serão substituídas pelo nome do sistema ou por um
	número incremental.

	Caso contrário, retorna um erro caso a leitura do arquivo da captura
	da tela falhe ou ``nil``.


**screen:pixel(x, y)**

	Obtém o pixel no local informado. As coordenadas estão em pixels,
	com a origem no canto superior esquerdo da área visível, aumentando
	para o para a direita e para baixo. Retorna um índice da paleta ou
	de uma cor no formato RGB compactado num inteiro com 32 bits.
	Retorna zero (``0``) se o ponto informado estiver fora da área
	visível.


**screen:pixels()**

	Retorna todos os pixels visíveis, assim como, a região visível da
	largura e da altura.

	Os pixels retornam como inteiros com 32 bits encapsulados numa
	*string* binária ordenado em *Endian*. Os pixels são organizados em
	ordem maior da linha, da esquerda para direita e depois de cima para
	baixo. Os valores dos pixels são índices da paleta ou cores no
	formato RGB encapsuladas em inteiros com 32 bits.


**screen:draw_box(left, up, right, down, [linha], [preenchimento])**

	Desenha um retângulo delineado com bordas nas posições informadas.

	As coordenadas são números de ponto flutuante em unidades de pixels
	da tela emulada, com a origem em (``0``, ``0``). Observe que os
	pixels da tela emulada geralmente não são quadrados. O sistema de
	coordenadas é rotacionada caso a tela seja girada, o que geralmente
	é o caso para as telas no formato vertical. Antes da rotação, a
	origem está na parte superior esquerda e as coordenadas aumentam
	para a direita e para baixo.
	As coordenadas são limitadas à área da tela.

	A abrangência das cores de preenchimento e da linha estão no formato
	alfa/vermelho/verde/azul (ARGB). |osvalo|. Os valores dos canais das
	cores não são previamente multiplicados pelo valor alfa. Os valores
	dos canais devem ser empacotados em bytes de um inteiro com 32 bits
	sem assinatura na ordem alfa, vermelho, verde, azul do byte mais
	importante para o de menor importância. Caso a cor da linha não seja
	informada, é usada a cor do texto da interface; caso a cor de
	preenchimento não seja informada, é usada a cor de fundo da
	interface.

.. raw:: latex

	\clearpage


**screen:draw_line(x0, y0, x1, y1, [cor])**

	Desenha uma linha a partir de (``x0``, ``y0``) a (``x1``, ``y1``).

	As coordenadas são números de ponto flutuante em unidades de pixels
	da tela emulada, com a origem em (``0``, ``0``). Observe que os
	pixels da tela emulada geralmente não são quadrados. O sistema de
	coordenadas é rotacionada caso a tela seja girada, o que geralmente
	é o caso para as telas no formato vertical. Antes da rotação, a
	origem está na parte superior esquerda e as coordenadas aumentam
	para a direita e para baixo. As coordenadas são limitadas à área da
	tela.

	A abrangência da cor da linha está no formato
	alfa/vermelho/verde/azul (ARGB). |osvalo|. Os valores dos canais das
	cores não são previamente multiplicados pelo valor alfa. Os valores
	dos canais devem ser empacotados em bytes de um inteiro com 32 bits
	sem assinatura na ordem alfa, vermelho, verde, azul do byte mais
	importante para o de menor importância. Caso a cor da linha não seja
	informada, é usada a cor do texto da interface.


**screen:draw_text(x|justify, y, text, [primeiro plano], [plano de fundo])**

	Desenha o texto na posição informada. Se a tela for rotacionada, o
	texto será girado.

	Caso o primeiro argumento seja um número, o texto será alinhado à
	esquerda nesta coordenada ``X``. Caso o primeiro argumento seja uma
	*string*, ela deve ser ``"left"``, ``"center"`` ou ``"right"`` para
	desenhar o texto alinhado à esquerda na borda esquerda da tela,
	centralizado horizontalmente na tela ou alinhado à direita na borda
	direita da tela respectivamente. O segundo argumento determina a
	coordenada Y da altura máxima do texto.

	As coordenadas são números de ponto flutuante em unidades de pixels
	da tela emulada, com a origem em (``0``, ``0``). Observe que os pixels da
	tela emulada geralmente não são quadrados. O sistema de coordenadas
	é rotacionada caso a tela seja girada, o que geralmente é o caso
	para as telas no formato vertical. Antes da rotação, a origem está
	na parte superior esquerda e as coordenadas aumentam para a direita
	e para baixo.
	As coordenadas são limitadas à área da tela.

	As cores do primeiro plano e do plano de fundo estão no formato
	alfa/vermelho/verde/azul (ARGB). |osvalo|. Os valores dos canais da
	cor não são previamente multiplicados pelo valor alpha. Os valores
	do canal devem ser empacotados em bytes com 32 bits inteiros não
	assinados pelo valor do canal alfa, na ordem alpha, vermelho, verde,
	azul a partir do byte mais importante até o byte com menor
	importância. Caso a cor do primeiro plano não seja informado, a cor
	do texto da interface será usada; caso a cor de fundo não seja
	informada, a cor do fundo da interface será usada.


Propriedades
~~~~~~~~~~~~

**screen.width** |sole|

	A largura do bitmap produzido pela tela emulada em pixels.


**screen.height** |sole|

	A altura do bitmap produzido pela tela emulada em pixels.


**screen.refresh** |sole|

	A taxa de atualização configurada da tela em Hertz (isso pode não
	refletir o valor atual).


**screen.refresh_attoseconds** |sole|

	O intervalo de atualização configurado da tela em *"attosegundos"*
	(isso pode não refletir o valor atual).

.. raw:: latex

	\clearpage


**screen.xoffset** |sole|

	O *offset* predefinido da posição X da tela. |eeun| onde um (``1``)
	corresponde ao tamanho X do contêiner da tela. Isso pode ser útil
	para restaurar o valor original após ajustar o *offset* ``X``
	através do contêiner da tela.


**screen.yoffset** |sole|

	O *offset* predefinido da posição Y da tela.  |eeun| onde um (``1``)
	corresponde ao tamanho Y do contêiner da tela. Isso pode ser útil
	para restaurar o valor original após ajustar o *offset* ``Y``
	através do contêiner da tela.


**screen.xscale** |sole|

	O fator de escala original da tela X, como um número de ponto
	flutuante. Isso pode ser útil para restaurar o valor original após
	ajustar a escala ``X`` através do contêiner da tela.


**screen.yscale** |sole|

	O fator de escala original da tela ``Y``, como um número de ponto
	flutuante. Isso pode ser útil para restaurar o valor original após
	ajustar a escala Y através do contêiner da tela.


**screen.pixel_period** |sole|

	O intervalo necessário para desenhar um pixel horizontal, como um
	número de ponto flutuante em em unidades de segundos.


**screen.scan_period** |sole|

	O intervalo necessário para desenhar uma linha de varredura
	(incluindo o intervalo horizontal de apagamento), como um número de
	ponto flutuante em unidades de segundos.


**screen.frame_period** |sole|

	O intervalo necessário para desenhar um quadro completo (incluindo
	os intervalos de apagamento), como um número de ponto flutuante em
	unidades de segundos.


**screen.frame_number** |sole|

	A quantidade dos quadros da tela atual. Isso aumenta monotonicamente
	cada intervalo dos quadros.


**screen.container** |sole|

	O :ref:`contêiner do renderizador <luascript-ref-rendercontainer>`
	usado para desenhar a tela.


**screen.palette** |sole|

	O :ref:`dispositivo paleta <luascript-ref-dipalette>` é utilizado
	para traduzir os valores dos pixels para cores ou ``nil`` caso a
	tela utilize um formato de pixel de cor direta.


.. _luascript-ref-cassdev:

Dispositivo de imagem em fita cassete
-------------------------------------

|encaa| ``cassette_image_device`` do MAME que representa um mecanismo
cassete compacto normalmente usado por um computador doméstico para o
armazenamento dos programas.


Instanciação
~~~~~~~~~~~~

**manager.machine.cassettes[tag]**

	Obtém a imagem de um dispositivo cassete por tag em relação ao
	dispositivo raiz do sistema ou ``nil`` caso o dispositivo não exista
	ou caso não seja a imagem de um dispositivo cassete.


Classes base
~~~~~~~~~~~~

* :ref:`luascript-ref-device`
* :ref:`luascript-ref-diimage`


Métodos
~~~~~~~

**cassette:stop()**

	Desativa a reprodução.


**cassette:play()**

	Ativa a reprodução. O cassete tocará se o motor estiver ativado.


**cassette:forward()**

	Avança a reprodução.


**cassette:reverse()**

	Retrocede a reprodução.


**cassette:seek(tempo, de_onde)**

	Salte para a posição informada na fita.  O tempo é um número de
	ponto flutuante em unidades de segundos, em relação ao ponto
	informado no argumento de_onde. O argumento de_onde deve ser
	``"set"``, ``"cur"`` ou ``"end"`` para realizar a busca com relação
	ao início da fita, a posição atual ou o fim da fita,
	respectivamente.


Propriedades
~~~~~~~~~~~~

**cassette.is_stopped** |sole|

	Um booleano que indica se a fita está parada (ou seja, não está
	gravando e nem reproduzindo).


**cassette.is_playing** |sole|

	Um booleano que indica se a reprodução está ativada (ou seja, o
	cassete vai reproduzir se o motor estiver ativado).


**cassette.is_recording** |sole|

	Um booleano que indica se a gravação está ativada (ou seja, o
	gravador da fita vai gravar se o motor estiver ativado).


**cassette.motor_state** |lees|

	Um booleano que indica se o motor do cassete está ativado.


**cassette.speaker_state** |lees|

	Um booleano que indica se o alto-falante do cassete está ativado.


**cassette.position** |sole|

	A posição atual como um número de ponto flutuante em unidades de
	segundos com relação ao início da fita.


**cassette.length** |sole|

	A duração da fita como um número de ponto flutuante em unidades de
	segundos, ou zero (``0``) caso nenhuma imagem da fita seja montada.


.. _luascript-ref-diimage:

Dispositivos de interface de imagem
-----------------------------------

|encaa| ``device_image_interface`` do MAME que é uma mistura
implementada através dos dispositivos que podem carregar arquivos de
imagem a partir de uma mídia.


Instanciação
~~~~~~~~~~~~

**manager.machine.images[tag]**

	Obtém um dispositivo de imagem por tag em relação ao dispositivo do
	sistema raiz, ou ``nil`` caso o dispositivo não exista ou caso não
	seja um dispositivo de imagem da mídia.


Métodos
~~~~~~~

**image:load(nome_do_arquivo)**

	Carrega o arquivo informado como uma imagem de mídia. Retorna
	``nil`` caso não haja erro ou um texto descrevendo o que houve de
	errado.


**image:load_software(nome)**

	Carrega uma imagem da mídia descrita numa lista de software.
	Retorna ``nil`` caso não haja erro ou um texto descrevendo o que
	houve de errado.


**image:unload()**

	Descarrega a imagem que foi montada.


**image:create(nome_do_arquivo)**

	Cria e monta um arquivo de imagem da mídia com o nome informado.
	Retorna ``nil`` caso não haja erro ou um texto descrevendo o que
	houve de errado.


**image:display()**

	Retorna uma *string* do “front panel display” para o dispositivo,
	caso seja compatível. Isso pode ser usado para exibir as informações
	de status, como a posição atual da cabeça ou do estado do motor.


Propriedades
~~~~~~~~~~~~

**image.is_readable** |sole|

	Um booleano que indica se o dispositivo oferece suporte à leitura.


**image.is_writeable** |sole|

	Um booleano que indica se o dispositivo oferece suporte para
	gravação.


**image.must_be_loaded** |sole|

	Um booleano que indica se o dispositivo requer que uma imagem da
	mídia seja carregada para começar.


**image.is_reset_on_load** |sole|

	Um booleano que indica se o dispositivo requer uma reinicialização
	forçada para alterar as imagens da mídia (geralmente para slots de
	cartucho que contêm um hardware adicional para os chips de memória).


**image.image_type_name** |sole|

	Uma *string* para categorizar o dispositivo da mídia.


**image.instance_name** |sole|

	O nome da instância do dispositivo na configuração atual. Isso é
	usado para configurar a carga da imagem da mídia na linha de comando
	ou nos arquivos INI. Isso não é estável, pode ter um número anexado
	que pode mudar dependendo da configuração do slot.


**image.brief_instance_name** |sole|

	O nome curto da instância do dispositivo na configuração atual. Isto
	é, usado para definir a imagem da mídia que será carregada na linha
	de comando ou nos arquivos INI.  Isso não é estável, pode ter um
	número anexado que pode mudar dependendo da configuração do slot.


**image.formatlist[ ]** |sole|

	O :ref:`formato da imagem da mídia <luascript-ref-imagefmt>` são
	suportados pelo dispositivo, indexado por nome. O operador do índice
	e dos métodos ``index_of`` têm complexidade O(n); todas as outras
	operações compatíveis têm complexidade O(1).


**image.exists** |sole|

	Um booleano que indica se um arquivo de imagem da mídia está
	montado.


**image.readonly** |sole|

	Um booleano que indica se um arquivo de imagem da mídia está montado
	em mode de somente leitura.


**image.filename** |sole|

	O caminho completo para o arquivo montado da imagem da mídia ou
	``nil`` se nenhuma imagem da mídia estiver montada.

.. raw:: latex

	\clearpage


**image.crc** |sole|

	A verificação de redundância cíclica com 32 bits do conteúdo do
	arquivo da imagem montada caso a imagem não tenha sido carregada a
	partir de uma lista de software, é montado como somente leitura e
	não for um CD-ROM, caso contrário é zero (``0``).


**image.loaded_through_softlist** |sole|

	Um booleano que indica se a imagem da mídia montada foi carregada a
	partir de uma lista de software ou ``false`` caso nenhuma imagem da
	mídia tenha sido montada.


**image.software_list_name** |sole|

	O nome curto da lista de software caso a imagem da mídia montada
	tenha sido carregada a partir de uma lista de software.


**image.software_longname** |sole|

	O nome completo do item do software caso a imagem da mídia montada
	tenha sido carregada a partir de uma lista de software ou caso
	contrário, ``nil``.


**image.software_publisher** |sole|

	O editor do item do software caso a imagem da mídia montada tenha
	sido carregada a partir de uma lista de software ou caso contrário,
	``nil``.


**image.software_year** |sole|

	O ano de lançamento do item do software caso a imagem da mídia
	montada tenha sido carregada a partir de uma lista de software ou
	caso contrário, ``nil``.


**image.software_parent** |sole|

	O nome abreviado do item do software principal caso a imagem da
	mídia montada tenha sido carregada a partir de uma lista de software
	ou caso contrário, ``nil``.


**image.device** |sole|

	O :ref:`dispositivo <luascript-ref-device>` subjacente.


.. _luascript-ref-dislot:

Dispositivo de interface slot
-----------------------------

|encaa| ``device_slot_interface`` do MAME que é uma mistura
implementada através dos dispositivos que instanciam um dispositivo
herdado que foi definido pelo usuário.


Instanciação
~~~~~~~~~~~~

**manager.machine.slots[tag]**

	Obtém um dispositivo slot atavés da tag com relação ao dispositivo
	raiz do sistema ou ``nil`` caso o dispositivo não exista ou caso não
	seja um dispositivo slot.


Propriedades
~~~~~~~~~~~~

**slot.fixed** |sole|

	Um booleano que indica se este é um slot com um cartão informado
	na configuração do sistema que não possa ser alterado pelo usuário.


**slot.has_selectable_options** |sole|

	Um booleano que indica se o slot tem alguma opção selecionável pelo
	usuário (ao contrário das opções que só podem ser selecionadas
	programaticamente, normalmente para os slots fixos ou para carregar
	as imagens da mídia).


**slot.options[ ]** |sole|

	As :ref:`opções do slot <luascript-ref-slotopt>` que descrevem os
	dispositivos herdados que podem ser instanciados pelo slot,
	indexados pelo valor da opção. Os métodos ``at`` e ``index_of``
	possuem complexidade O(n); todas as outras operações compatíveis têm
	complexidade O(1).


**slot.device** |sole|

	O :ref:`dispositivo <luascript-ref-device>` subjacente.


.. _luascript-ref-distateentry:

Estado da entrada do dispositivo
--------------------------------

Envelopa a classe ``device_state_entry`` do MAME, permite acesso aos
nomes dos registos expostos por um :ref:`dispositivo
<luascript-ref-device>`. É compatível com a conversão de "string" para
exibição.


Instanciação
~~~~~~~~~~~~

**manager.machine.devices[tag].state[símbolo]**

	Obtém o estado da entrada para um determinado dispositivo através de
	um símbolo.


Propriedades
~~~~~~~~~~~~

**entry.value** |lees|

	O valor numérico do estado da entrada, seja como um número inteiro
	ou de ponto flutuante. É gerado um erro caso haja a tentativa de
	definir um valor do estado numa entrada que seja de apenas leitura.


**entry.symbol** |sole|

	O nome simbólico do estado da entrada.


**entry.visible** |sole|

	|ubis| o estado da entrada deve ser mostrada na visualização de
	registro da depuração.


**entry.writeable** |sole|

	|ubis| é possível alterar o valor do estado da entrada.


**entry.is_float** |sole|

	|ubis| o valor do estado da entrada é um número de ponto flutuante.

.. raw:: latex

	\clearpage


**entry.datamask** |sole|

	Uma máscara de bits com valores válidos de bits para o estado com
	valor inteiro das entradas.


**entry.datasize** |sole|

	O tamanho do valor subjacente em bytes para o estado com valor
	inteiro das entradas.


**entry.max_length** |sole|

	O comprimento máximo da string de exibição para o estado da entrada.


.. _luascript-ref-imagefmt:

Formato da imagem da mídia
--------------------------

|encaa| ``image_device_format`` do MAME que descreve o formato do
arquivo da mídia compatível através da :ref:`dispositivo de interface de
imagem <luascript-ref-diimage>`.


Instanciação
~~~~~~~~~~~~

**manager.machine.images[tag].formatlist[nome]**

	Obtém um formato da imagem da mídia compatível com um determinado
	dispositivo através de um nome.


Propriedades
~~~~~~~~~~~~

**format.name** |sole|

	Um nome abreviado usado para identificar o formato. Isso geralmente
	corresponde a extensão do nome do arquivo principal usado para o
	formato.


**format.description** |sole|

	O nome completo do formato.


**format.extensions[ ]** |sole|

	Produz uma tabela das extensões do nome do arquivo usados no
	formato.


**format.option_spec** |sole|

	Uma *string* que descreve as opções disponíveis durante a criação do
	formato da imagem da mídia. A *string* não se destina a ser legível
	para humanos.


.. _luascript-ref-slotopt:

Opções do slot
--------------

|encaa| ``device_slot_interface::slot_option`` do MAME que representa um
dispositivo herdado da :ref:`dispositivos de interface slot
<luascript-ref-dislot>` que podem ser instanciados para configuração.


Instanciação
~~~~~~~~~~~~

**manager.machine.slots[tag].options[nome]**

	Obtém uma opção do slot para uma determinada
	:ref:`dispositivos de interface slot <luascript-ref-dislot>`
	através do nome (ou seja, o valor usado para selecionar a opção).

Propriedades
~~~~~~~~~~~~

**option.name** |sole|

	O nome da opção do slot. Este é o valor usado para selecionar esta
	opção na linha de comando ou num arquivo INI.


**option.device_fullname** |sole|

	O nome completo da exibição do tipo do dispositivo instanciado por
	esta opção.


**option.device_shortname** |sole|

	O nome abreviado do tipo de dispositivo instanciado por esta opção.


**option.selectable** |sole|

	Um Booleano que indica se a opção pode ser selecionada pelo usuário
	(as opções que não são selecionáveis pelo usuário geralmente são
	usados para os slots fixos ou para carregar as imagens da mídia).


**option.default_bios** |sole|

	A configuração padrão da BIOS para o dispositivo instanciado usando
	esta opção, ou ``nil`` caso a BIOS informada nas definições da ROM
	do dispositivo seja usada.


**option.clock** |sole|

	A frequência do *clock* configurada para o dispositivo instanciado
	usando esta opção. Este é um número inteiro com 32 bits não
	assinado. Se os oito primeiros bits mais importantes forem
	configurados, é uma proporção da frequência do *clock* do
	dispositivo principal, com o numerador nos bits 12-23 e o
	denominador nos bits 0-11. Se os 8 bits mais importantes não
	estiverem todos configurados, a frequência será em Hertz.

.. |encaa| replace:: Encapsula a classe
.. |sole| replace:: (somente leitura)
.. |lees| replace:: (leitura e escrita)
.. |acsre| replace:: As cores são representadas no formato
.. |osvalo| replace:: Os valores dos canais estão no intervalo entre
	``0`` (transparente ou desligado) até ``255`` (opaco ou com
	intensidade total)
.. |ovdo| replace:: Os valores dos outros canais não são afetados
.. |ocvp| replace:: O contraste é um valor de ponto flutuante
.. |ubqi| replace:: Um booleano que indica se
.. |eeun| replace:: Este é um número de ponto flutuante
.. |ubis| replace:: Retorna um booleano indicando se
