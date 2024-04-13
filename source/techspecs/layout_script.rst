.. raw:: latex

	\clearpage

.. _layscript:

Usando scripts no layout do MAME
================================

.. contents:: :local:


.. _layscript-intro:

Introdução
----------

Os arquivos de layout do MAME podem incorporar scripts Lua para
aprimorar a sua funcionalidade. Embora haja muito que você possa fazer
com componentes desenhados de forma condicional e a animação dos
parâmetros, algumas coisas só podem ser feitas através de scripts. O
MAME usa um modelo baseado em eventos. Os scripts podem fornecer funções
que serão chamadas após determinados eventos ou quando determinados
dados forem necessários.

É preciso que o :ref:`layout plugin <plugins-layout>` esteja ativo.
Por exemplo, use este comando para rodar **BWB Double Take** com o
script Lua ativo no layout é possível usar este comando::

    mame -plugins -plugin layout v4dbltak

Adicione esta configuração num arquivo ``v4dbltak.ini`` dentro do
diretório **ini** para que a configuração do layout e do plug-in sempre
seja utilizada quando o sistema for iniciado. Consulte :ref:`plugins`
para mais informações.

Consulte também o capítulo :ref:`advanced-multi-CFG`.

.. raw:: latex

	\clearpage

.. _layscript-examples:

Exemplos práticos
-----------------

Antes de entrarmos de cabeça nos detalhes técnicos do seu
funcionamento, começaremos com alguns exemplos usando os aprimoramentos
do script Lua. É importante que você tenha conhecimento prévio de como
sistema de ilustrações (*artwork*) do MAME funciona, assim como, um
conhecimento básico de como criar scripts Lua. Para mais obter mais
informações sobre os arquivos de layout consulte :ref:`layfile`, para
descrições detalhadas das classes Lua usadas pelo MAME consulte
:ref:`luascript`.

Espial: joystick dividido entre as portas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vejamos estas definições das entradas para o **Espial**:

.. code-block:: C++

    PORT_START("IN1")
    PORT_BIT( 0x01, IP_ACTIVE_HIGH, IPT_START1 )
    PORT_BIT( 0x02, IP_ACTIVE_HIGH, IPT_START2 )
    PORT_BIT( 0x04, IP_ACTIVE_HIGH, IPT_JOYSTICK_LEFT )  PORT_8WAY PORT_COCKTAIL
    PORT_BIT( 0x08, IP_ACTIVE_HIGH, IPT_JOYSTICK_RIGHT ) PORT_8WAY PORT_COCKTAIL
    PORT_BIT( 0x10, IP_ACTIVE_HIGH, IPT_JOYSTICK_UP )    PORT_8WAY PORT_COCKTAIL
    PORT_BIT( 0x20, IP_ACTIVE_HIGH, IPT_JOYSTICK_DOWN )  PORT_8WAY
    PORT_BIT( 0x40, IP_ACTIVE_HIGH, IPT_JOYSTICK_DOWN )  PORT_8WAY PORT_COCKTAIL
    PORT_BIT( 0x80, IP_ACTIVE_HIGH, IPT_BUTTON2 ) PORT_COCKTAIL

    PORT_START("IN2")
    PORT_BIT( 0x01, IP_ACTIVE_HIGH, IPT_UNKNOWN )
    PORT_BIT( 0x02, IP_ACTIVE_HIGH, IPT_COIN1 )
    PORT_BIT( 0x04, IP_ACTIVE_HIGH, IPT_UNKNOWN )
    PORT_BIT( 0x08, IP_ACTIVE_HIGH, IPT_JOYSTICK_RIGHT ) PORT_8WAY
    PORT_BIT( 0x10, IP_ACTIVE_HIGH, IPT_JOYSTICK_UP )    PORT_8WAY
    PORT_BIT( 0x20, IP_ACTIVE_HIGH, IPT_BUTTON1 ) PORT_COCKTAIL
    PORT_BIT( 0x40, IP_ACTIVE_HIGH, IPT_BUTTON1 )
    PORT_BIT( 0x80, IP_ACTIVE_HIGH, IPT_JOYSTICK_LEFT )  PORT_8WAY

Há dois joysticks, um usado por ambos os jogadores num gabinete
vertical ou o primeiro jogador num gabinete tipo coquetel e um usado
para o segundo jogador num gabinete tipo coquetel. Observe que os
interruptores para o primeiro joystick está dividido entre as duas
portas de E/S.

Não há sintaxe no arquivo de layout para construir o estado do elemento
usando bits das diversas portas de E/S. Também é inconveniente se cada
joystick precisar ser definido como um elemento a parte porque os bits
para os interruptores não estão dispostos da mesma maneira.

.. raw:: latex

	\clearpage

Podemos superar estas limitações usando um script Lua para ler as
entradas do jogador e definir o estado dos elementos nos itens:

.. code-block:: XML

    <?xml version="1.0"?>
    <mamelayout version="2">
        <!-- o elemento para desenhar um joystick -->
        <!-- cima = 1 (bit 0), baixo = 2 (bit 1), esquerda = 4 (bit 2), direita = 8 (bit 3) -->
        <element name="stick" defstate="0">
            <image state="0x0" file="stick_c.svg" />
            <image state="0x1" file="stick_u.svg" />
            <image state="0x9" file="stick_ur.svg" />
            <image state="0x8" file="stick_r.svg" />
            <image state="0xa" file="stick_dr.svg" />
            <image state="0x2" file="stick_d.svg" />
            <image state="0x6" file="stick_dl.svg" />
            <image state="0x4" file="stick_l.svg" />
            <image state="0x5" file="stick_ul.svg" />
        </element>
        <!-- caso o plug-in do layout não esteja ativo, nós avisaremos o usuário -->
        <!-- desenha apenas quando o seu estado for 1, define o seu estado predefinido para 1 assim o aviso fica visível inicialmente -->
        <element name="warning" defstate="1">
            <text state="1" string="Esta ilustração precisa que o plug-in do layout esteja ativo." />
        </element>
        <!-- exibindo a tela e o joystick num gabinete tipo coquetel -->
        <view name="Joystick Display">
            <!-- desenha a tela com a proporção correta -->
            <screen index="0">
                <bounds x="0" y="0" width="4" height="3" />
            </screen>
            <!-- primeiro joystick, o atributo id permite que o script encontre o item -->
            <!-- sem vínculos, o estado será definido pelo script -->
            <element id="joy_p1" ref="stick">
                <!-- posição abaixo da tela -->
                <bounds xc="2" yc="3.35" width="0.5" height="0.5" />
            </element>
            <!-- segundo joystick, o atributo id permite que o script encontre o item  -->
            <!-- sem vínculos, o estado será definido pelo script -->
            <element id="joy_p2" ref="stick">
                <!-- a tela é invertida em 180º para o segundo jogador -->
                <orientation rotate="180" />
                <!-- posição acima da tela -->
                <bounds xc="2" yc="-0.35" width="0.5" height="0.5" />
            </element>
            <!-- item com texto de aviso que também possui um atributo id para que o script o encontre -->
            <element id="warning" ref="warning">
                <!-- posição fora da tela próximo da parte de baixo -->
                <bounds x="0.2" y="2.6" width="3.6" height="0.2" />
            </element>
        </view>
        <!-- o conteúdo do elemento do script que será invocado como uma função pelo plug-in do layout -->
        <!-- use um bloco CDATA para evitar a necessidade da utilização dos símbolos "maior que", "menor que" e sinais tironianos -->
        <script><![CDATA[
            -- o arquivo é um objeto do arquivo do layout
            -- define uma função que será invocada depois de resolver as tags
            file:set_resolve_tags_callback(
                    function ()
                        -- file.device é o dispositivo que causou a leitura do layout
                        -- neste caso, é o principal controlador do sistema espial
                        -- consulta as duas portas E/S que precisamos ler
                        local in1 = file.device:ioport("IN1")
                        local in2 = file.device:ioport("IN2")

                        -- consulta os itens view para exibir o estado do joystick
                        local p1_stick = file.views["Joystick Display"].items["joy_p1"]
                        local p2_stick = file.views["Joystick Display"].items["joy_p2"]

                        -- consulte a função que será chamada antes de adicionar os itens que serão exibidos no destino
                        file.views["Joystick Display"]:set_prepare_items_callback(
                                function ()
                                    -- faz a leitura da entrada das portas E/S dos dois jogadores
                                    local in1_val = in1:read()
                                    local in2_val = in2:read()

                                    -- define a condição do elemento para o primeiro joystick
                                    p1_stick:set_state(
                                            ((in2_val & 0x10) >> 4) |   -- muda cima a partir do IN2 com bit 4 para bit 0
                                            ((in1_val & 0x20) >> 4) |   -- muda baixo a partir do IN1 com bit 5 para bit 1
                                            ((in2_val & 0x80) >> 5) |   -- muda esquerda a partir do IN2 com bit 7 para bit 2
                                            (in2_val & 0x08))           -- direita está em IN2 com bit 3

                                    -- define a condição do elemento para o primeiro joystick
                                    p2_stick:set_state(
                                            ((in1_val & 0x10) >> 4) |   -- muda cima a partir do IN1 com bit 4 para bit 0
                                            ((in1_val & 0x40) >> 5) |   -- muda baixo a partir do IN1 com bit 6 para bit 1
                                            (in1_val & 0x04) |          -- esquerda está em IN1 com bit 2
                                            (in1_val & 0x08))           -- direita está em IN1 com bit 3
                                end)

                        -- se estivermos com o script rodando, esconde o aviso
                        file.views["Joystick Display"].items["warning"]:set_state(0)
                    end)
        ]]></script>
    </mamelayout>

O layout tem um elemento ``script`` contendo o script Lua que é invocado
como uma função através do plug-in **Layout** durante o carregamento do
arquivo do layout. A visualização do layout foi construída neste ponto,
porém o sistema emulado ainda não terminou de ser iniciado. Não é seguro
acessar as entradas e as saídas neste momento. A variável chave no
ambiente do script é ``file`` que dá ao script o acesso ao seu
:ref:`arquivo de layout <luascript-ref-renderlayfile>`.

Nós fornecemos uma função que será invocada depois que as tags no
arquivo de layout tiverem sido resolvidas. Neste ponto, o sistema
emulado terá concluído a sua inicialização. Esta função realiza as
seguintes tarefas:

* Monitora a entrada das duas :ref:`portas E/S <luascript-ref-ioport>`
  do jogador. As portas E/S podem ser monitoradas através das *tags*
  relacionadas com o dispositivo que  fizer com que o arquivo de layout
  seja carregado.
* Monitora os :ref:`dois itens <luascript-ref-renderlayitem>` usados
  pela tela exibindo o estado do joystick.
  As visualizações podem ser monitoradas através do nome (o valor
  do atributo ``name`` por exemplo), e os itens que estiverem entre
  ``view`` e que possuam um ID (o valor do atributo ``id`` por exemplo).
* Fornece uma função que será invocada antes que os itens sejam
  renderizados na tela.
* Oculta o aviso que lembra o usuário para ativar o plug-in do layout ao
  definir o estado do elemento para o item com ``0`` (o componente do
  texto só é desenhado quando o estado do elemento for ``1``).

A função que é invocada antes dos itens de visualização são renderizados
na tela, lê as entradas do jogador e embaralha os bits na ordem
necessária pelo elemento joystick.

.. _layscript-examples-starwars:

Star Wars: animação com dois eixos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Faremos um layout que mostra a posição do manche de voo para o Star Wars
da Atari. As portas de entrada são simples, cada eixo analógico produz
um valor na faixa entre 0x00(0) a 0xff(255), inclusive:

.. code-block:: C++

    PORT_START("STICKY")
    PORT_BIT( 0xff, 0x80, IPT_AD_STICK_Y ) PORT_SENSITIVITY(70) PORT_KEYDELTA(30)

    PORT_START("STICKX")
    PORT_BIT( 0xff, 0x80, IPT_AD_STICK_X ) PORT_SENSITIVITY(50) PORT_KEYDELTA(30)

E aqui temos o nosso layout:

.. code-block:: XML

    <?xml version="1.0"?>
    <mamelayout version="2">

        <!-- um quadrado com uma borda branca com 1% da sua largura -->
        <element name="outline">
            <rect><bounds x="0.00" y="0.00" width="1.00" height="0.01" /></rect>
            <rect><bounds x="0.00" y="0.99" width="1.00" height="0.01" /></rect>
            <rect><bounds x="0.00" y="0.00" width="0.01" height="1.00" /></rect>
            <rect><bounds x="0.99" y="0.00" width="0.01" height="1.00" /></rect>
        </element>

        <!-- um retângulo com 10% da linha vertical da sua largura até o meio -->
        <element name="line">
            <!-- use um retângulo transparente para impor as dimensões do elemento -->
            <rect>
                <bounds x="0" y="0" width="0.1" height="1" />
                <color alpha="0" />
            </rect>
            <!-- está é a linha branca que está visível -->
            <rect><bounds x="0.045" y="0" width="0.01" height="1" /></rect>
        </element>

        <!-- o traçado de um quadrado com uma borda interna com 20% e com linhas com 10% do comprimento e da largura do elemento -->
        <element name="box">
            <!-- use um retângulo transparente para impor as dimensões do elemento -->
            <rect>
                <bounds x="0" y="0" width="0.1" height="0.1" />
                <color alpha="0" />
            </rect>
            <!-- desenha o traçado de um quadrado -->
            <rect><bounds x="0.02" y="0.02" width="0.06" height="0.01" /></rect>
            <rect><bounds x="0.02" y="0.07" width="0.06" height="0.01" /></rect>
            <rect><bounds x="0.02" y="0.02" width="0.01" height="0.06" /></rect>
            <rect><bounds x="0.07" y="0.02" width="0.01" height="0.06" /></rect>
        </element>

        <!-- caso o plug-in do layout não esteja ativo, nós avisaremos o usuário -->
        <!-- desenha apenas quando o seu estado for 1, define o seu estado predefinido para 1 assim o aviso fica visível inicialmente -->
        <element name="warning" defstate="1">
            <text state="1" string="Esta ilustração precisa que o plug-in do layout esteja ativo." />
        </element>

        <!-- visualização exibindo o manche e a sua posição na tela -->
        <view name="Analog Control Display">
            <!-- desenha a tela com a correta relação de aspecto -->
            <screen index="0">
                <bounds x="0" y="0" width="4" height="3" />
            </screen>

            <!-- desenha o traçado de um quadrado branco do lado inferior direito da tela -->
            <!-- o script utiliza o tamanho deste item para determinar os limites do seu movimento -->
            <element id="outline" ref="outline">
                <bounds x="4.1" y="1.9" width="1.0" height="1.0" />
            </element>

            <!-- linha vertical para exibir os dados recebidos do eixo X -->
            <element id="vertical" ref="line">
                <!-- o elemento desenha uma linha vertical, sem a necessidade de rotacioná-lo -->
                <orientation rotate="0" />
                <!-- centralize horizontalmente no quadrado usando toda a sua altura -->
                <bounds x="4.55" y="1.9" width="0.1" height="1" />
            </element>

            <!-- linha horizontal para exibir os dados recebidos do eixo Y -->
            <element id="horizontal" ref="line">
                <!-- rotaciona o elemento em 90º para obter uma linha horizontal -->
                <orientation rotate="90" />
                <!-- centraliza verticalmente no quadrado, usando toda a largura -->
                <bounds x="4.1" y="2.35" width="1" height="0.1" />
            </element>

            <!-- desenhar uma pequena caixa na intersecção das linhas verticais e horizontais -->
            <element id="box" ref="box">
                <bounds x="4.55" y="2.35" width="0.1" height="0.1" />
            </element>

            <!-- desenha um texto de aviso próximo da parte de baixo da tela -->
            <element id="warning" ref="warning">
                <bounds x="0.2" y="2.6" width="3.6" height="0.2" />
            </element>
        </view>

        <!-- o conteúdo do elemento do script será invocado como uma função pelo plug-in layout -->
        <!-- use um bloco CDATA para evitar a necessidade da utilização dos símbolos "maior que", "menor que" e sinais tironianos -->
        <script><![CDATA[
            -- o arquivo é o objeto do arquivo de layout
            -- define a função para ser invocada depois de resolver as tags
            file:set_resolve_tags_callback(
                    function ()
                        -- file.device é o dispositivo que fez com que o layout fosse carregado
                        -- neste caso, é o condutor principal do sistema starwars
                        -- localize as entradas dos eixos analógicos
                        local x_input = file.device:ioport("STICKX")
                        local y_input = file.device:ioport("STICKY")

                        -- localize o esboço do item
                        local outline_item = file.views["Analog Control Display"].items["outline"]

                        -- variáveis para manter o estado através das chamadas
                        local outline_bounds    -- a delineação do esboço do quadrado
                        local width, height     -- largura e altura dos itens animados
                        local x_scale, y_scale  -- relação das unidades dos eixos para renderizar as coordenadas
                        local x_pos, y_pos      -- exibe as posições para os itens animados

                        -- define uma função que será invocada quando as dimensões da visualização forem recalculadas
                        -- isso pode acontecer quando a janela for redimensionada ou as opções de escala forem alteradas
                        file.views["Analog Control Display"]:set_recomputed_callback(
                                function ()
                                    -- obtém a delineação do esboço do quadrado
                                    outline_bounds = outline_item.bounds
                                    -- animação dos itens, use 10% da largura e altura do quadrado
                                    width = outline_bounds.width * 0.1
                                    height = outline_bounds.height * 0.1
                                    -- calcula as proporções das unidades do eixo para renderizar as coordenadas
                                    -- animação dos itens, deixe 90% da largura e altura para o limite do movimento
                                    -- o limite do percurso de cada eixo fica em 0xff
                                    x_scale = outline_bounds.width * 0.9 / 0xff
                                    y_scale = outline_bounds.height * 0.9 / 0xff
                                end)

                        -- define uma função para ser invocada antes de adicionar a visualização dos itens no destino renderizado
                        file.views["Analog Control Display"]:set_prepare_items_callback(
                                function ()
                                    -- lê os eixos analógicos, eixo Y invertido como zero está na parte de baixo
                                    local x = x_input:read() & 0xff
                                    local y = 0xff - (y_input:read() & 0xff)
                                    -- converte os valores recebidos para as coordenadas do layout
                                    -- usa a quina superior esquerda do quadrado delineado como a sua origem
                                    x_pos = outline_bounds.x0 + (x * x_scale)
                                    y_pos = outline_bounds.y0 + (y * y_scale)
                                end)

                        -- define uma função para fornecer os limites da linha vertical
                        file.views["Analog Control Display"].items["vertical"]:set_bounds_callback(
                                function ()
                                    -- renderize a delineação de um novo objeto (começando como uma unidade quadrada)
                                    local result = emu.render_bounds()
                                    -- define esquerda, cima, largura e altura
                                    result:set_wh(
                                            x_pos,                  -- posição X calculada para os itens animados
                                            outline_bounds.y0,      -- delineação do topo do quadrado
                                            width,                  -- 10% da largura do quadrado delineado
                                            outline_bounds.height)  -- altura total do quadrado delineado
                                    return result
                                end)

                        -- define uma nova função para informar a delineação da linha horizontal
                        file.views["Analog Control Display"].items["horizontal"]:set_bounds_callback(
                                function ()
                                    -- renderize a delineação de um novo objeto (começando como uma unidade quadrada)
                                    local result = emu.render_bounds()
                                    -- define esquerda, cima, largura e altura
                                    result:set_wh(
                                            outline_bounds.x0,      -- esquerda do quadrado delineado
                                            y_pos,                  -- posição Y calculada para os itens animados
                                            outline_bounds.width,   -- lartura total do quadrado delineado
                                            height)                 -- 10% da altura do quadrado delineado
                                    return result
                                end)

                        -- define uma nova função para informar a delineação da caixa entre a interseção das linhas
                        file.views["Analog Control Display"].items["box"]:set_bounds_callback(
                                function ()
                                    -- renderize uma nova delineação de objeto (começando como uma unidade quadrada)
                                    local result = emu.render_bounds()
                                    -- define esquerda, cima, largura e altura
                                    result:set_wh(
                                            x_pos,                  -- posição X calculada para os itens animados
                                            y_pos,                  -- posição Y calculada para os itens animados
                                            width,                  -- 10% da largura do quadrado delineado
                                            height)                 -- 10% da altura do quadrado delineado
                                    return result
                                end)

                        -- oculta o aviso uma vez que se chagamos até aqui, o escript já está rodando
                        file.views["Analog Control Display"].items["warning"]:set_state(0)
                    end)
        ]]></script>

    </mamelayout>

O layout possui um elemento ``script`` contendo o script Lua que será
invocado como uma função através do plug-in **Layout** quando o arquivo
de layout for carregado. Isto ocorre após a construção das visualizações
do layout, mas antes que o sistema emulado tenha concluído a sua
inicialização. O objeto do :ref:`arquivo do layout
<luascript-ref-renderlayfile>` é fornecido ao script através da
variável ``file``.

Nós oferecemos uma função que será invocada depois que as tags no
arquivo do layout forem resolvidas. Esta função faz o seguinte:

* Monitora o recebimento de dados da :ref:`entrada
  <luascript-ref-ioport>` do eixo analógico.
* Monitora o :ref:`item visualizado <luascript-ref-renderlayitem>` que
  traça o contorno da área onde a posição do manche é exibido.
* Declara algumas variáveis para manter os valores calculados através
  das chamadas das funções.
* Fornece a função para ser invocada quando a visualização das dimensões
  tenham sido recalculadas.
* Fornece a função para ser invocada antes de adicionar os itens
  visíveis ao contêiner durante a renderização do quadro.
* Fornece as funções que definirão os limites para os itens animados.
* Esconde o aviso que alerta o usuário para ativar o plug-in **Layout**
  ao definir a condição do elemento para o item como ``0`` (o componente
  do texto só é desenhado quando o estado do elemento for ``1``).

A visualização é monitorada através do nome (pelo valor do seu atributo
``name``) e os itens dentro da visualização são monitoradas através do
ID (com o valor dos seus respectivos atributos ``id``).

As dimensões de visualização do layout são recalculadas em resposta a
vários eventos, incluindo o redimensionamento da janela, entrando ou
saindo do modo de tela cheia, alternando a visibilidade das coleções dos
itens e mudando o zoom para a configuração da área da tela. Quando isso
acontece, precisamos atualizar os nossos fatores de tamanho e da escala
da animação. Obtemos os limites do quadrado onde a posição do manche é
exibido, calculamos o tamanho dos itens animados e calculamos as
proporções das unidades do eixo para renderizar as coordenadas do alvo
para cada direção. É mais eficiente fazer estes cálculos somente caso os
resultados mudem.

Antes dos itens de visualização serem adicionados no destino da
renderização, lemos as entradas do eixo analógico e convertemos os
valores da posição em coordenadas para a animação dos os itens. A
entrada do eixo Y usa valores maiores para apontar para cima, então
precisamos inverter o valor subtraindo-o de ``0xff`` (``255``).
Adicionamos nas coordenadas do canto superior esquerdo do quadrado onde
estamos exibindo a posição do manche. Fazemos isso uma vez cada vez que
o layout for desenhado por questões de eficiência já que podemos usar os
valores para todos os três itens animados.

Finalmente, fornecemos limites para a animação dos itens quando
necessário. Estas funções precisam retornar os objetos "render_bounds"
dando a posição e o tamanho dos itens como coordenadas do alvo que serão
renderizados.

Como os elementos da linha vertical e da linha horizontal movem-se cada
um apenas num único eixo, seria possível animá-los usando os
recursos de animação do arquivo de layout. Na verdade apenas a caixa na
interseção da linha precisa de um script. É feito totalmente com script
para fins ilustrativos.

.. raw:: latex

	\clearpage


.. _layscript-environment:

O ambiente do script layout
---------------------------

O ambiente Lua é oferecido pelo plug-in **Layout**. É bem reduzido,
oferecendo apenas o mínimo necessário:

* O ``file`` oferecendo o objeto do :ref:`arquivo de layout
  <luascript-ref-renderlayfile>` do script.
  Possui uma propriedade ``device`` para saber quem foi qual foi o
  :ref:`dispositivo <luascript-ref-device>` responsável para que o
  layout fosse carregado e uma propriedade ``views`` para conseguir as
  :ref:`exibições do layout <luascript-ref-renderlayview>` (indexadas
  através do nome).
* A função ``machine`` que oferece ao MAME a informação sobre a
  :ref:`máquina em execução <luascript-ref-machine>` no momento.
* As funções ``emu.device_enumerator``, ``emu.palette_enumerator``,
  ``emu.screen_enumerator``, ``emu.cassette_enumerator``,
  ``emu.image_enumerator`` e ``emu.slot_enumerator`` para obter as
  interfaces de dispositivos específicos.
* As funções  ``emu.attotime``, ``emu.render_bounds`` e
  ``emu.render_color`` que criam os objetos
  :ref:`attotime <luascript-ref-attotime>`,
  :ref:`bounds <luascript-ref-renderbounds>` e
  :ref:`cores <luascript-ref-rendercolor>`.
* ``emu.bitmap_ind8``, ``emu.bitmap_ind16``, ``emu.bitmap_ind32``,
  ``emu.bitmap_ind64``, ``emu.bitmap_yuy16``, ``emu.bitmap_rgb32`` e
  objetos ``emu.bitmap_argb32`` para criar
  :ref:`bitmaps <luascript-ref-bitmap>`.
* As funções ``emu.render_bounds`` e o ``emu.render_color`` criam os
  limites e as cores dos objetos.
* As funções ``emu.print_verbose``, ``emu.print_error``,
  ``emu.print_warning``, ``emu.print_info`` e o ``emu.print_debug`` são
  usadas para diagnósticos.
* Padrão Lua, funções ``tonumber``, ``tostring``, ``pairs`` e
  ``ipairs``, assim como objetos ``table`` ``string`` para manipular
  strings, tabelas e os outros contêineres.
* Função Lua ``print`` para gerar texto no console.


.. _layscript-events:

Os eventos do layout
--------------------

O script do layout do MAME usa um modelo com base em eventos. Os scripts
podem fornecer funções que serão invocadas após a ocorrência dos
eventos ou quando os dados forem solicitados. Há três níveis de
eventos: do arquivo do layout, da visualização do layout e do item de
visualização de layout.

.. _layscript-events-file:

Os eventos do arquivo layout
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Os eventos do arquivo do layout é aplicado no arquivo como um todo e não
numa visualização individualmente.

**Resolve as tags**

    ``file:set_resolve_tags_callback(cb)``

	É invocado após o sistema que está sendo emulado ter terminado a
	sua inicialização, as tags do layout que forem recebidas tenham
	sido resolvidas e as invocações retornadas tenham sido configuradas.
	Este é um bom momento para consultar as entradas e configurar os
	manipuladores dos eventos do item de visualização.

	O |callback|  não retorna nenhum valor e também não aceita
	parâmetros. |handler|.

.. raw:: latex

	\clearpage

.. _layscript-events-view:

Os eventos de visualização do layout
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Os eventos da visualização do Layout sem aplicam para uma visualização
individual.

**Prepara os itens**

    ``view:set_prepare_items_callback(cb)``

	É invocado antes que a renderização de visualização dos itens sejam
	adicionados no destino em preparação para conceber o quadro de
	vídeo.

	O |callback|  não retorna nenhum valor e também não aceita
	parâmetros. |handler|.

**Carga prévia**

    ``view:set_preload_callback(cb)``

	É invocado após a carga prévia dos elementos visíveis da
	visualização. Isso pode acontecer quando a visualização é
	selecionada pela primeira vez durante a seção ou caso o usuário
	alterne a exibição da coleção de um elemento. Esteja ciente que isto
	pode ser invocado várias vezes durante uma seção, evite a repetição
	de tarefas onerosas ao sistema.

	O |callback|  não retorna nenhum valor e não também aceita nenhum
	parâmetro. |handler|.

**O recálculo das dimensões**

    ``view:set_recomputed_callback(cb)``

	É invocado quando as visualizações forem recalculadas. Isso acontece
	em várias situações, inclusive quando a janela for redimensionada,
	entrando ou saindo do modo de tela cheia, alternando as
	visualizações de um item numa coleção e alterando as configurações
	de rotação e zoom da tela. Caso esteja animando a posição dos itens
	visualizados, este é um bom momento para calcular os fatores de
	escala e posição.

	O |callback|  não retorna nenhum valor e não também aceita nenhum
	parâmetro. |handler|.


**Atualizações do ponteiro**

    ``view:set_pointer_updated_callback(cb)``

	É invocado quando o ponteiro ingressar, se mover ou altera o estado
	do botão na exibição.

	São passados nove argumentos para a função de |callback|:

	* O tipo do ponteiro como uma *string*. Os valores válidos são
	  ``mouse``, ``pen``, ``touch`` ou ``unknown`` que não se alterará
	  durante a vida do ponteiro.
	* A ID do ponteiro. Este será um inteiro não negativo que não se
	  alterará durante a vida do ponteiro. Os valores da ID podem ser
	  recicladas de maneira "*agressiva*".
	* A ID do dispositivo. Para grupos de ponteiros para reconhecer
	  gestos multitoque.
	* A posição horizontal nas coordenadas do layout.
	* A posição vertical nas coordenadas do layout.
	* Uma máscara de bits que representa os botões que foram liberados
	  nesta atualização.
	* Uma máscara de bits que representa os botões pressionados no
	  momento. O botão primário é o bit menos importante.
	* Uma máscara de bits que representa os botões que foram
	  pressionados nesta atualização. O botão primário é o bit menos
	  importante.
	* Uma máscara de bits que representa os botões que foram liberados
	  nesta atualização. O botão primário é o bit menos importante.
	* A contagem de cliques. É positivo para ações com clique simultâneo
	  ou negativo se um clique for transformado numa retenção (clicar e
	  manter) ou arraste (clicar e arrastar)).

	O |callback| não retorna nenhum valor. |handler|.


**O ponteiro esquerdo**

    ``view:set_pointer_left_callback(cb)``

	É invocado quando um ponteiro deixa a exibição normalmente. Após
	receber este evento, a ID do ponteiro pode ser reutilizada com um
	novo ponteiro.

	São passados sete argumentos para a função de |callback|:

	* O tipo do ponteiro como uma *string*. Os valores válidos são
	  ``mouse``, ``pen``, ``touch`` ou ``unknown`` que não se alterará
	  durante a vida do ponteiro.
	* A ID do ponteiro. Este será um inteiro não negativo que não se
	  alterará durante a vida do ponteiro. Os valores da ID podem ser
	  recicladas de maneira "*agressiva*".
	* A ID do dispositivo. Para grupos de ponteiros para reconhecer
	  gestos multitoque.
	* A posição horizontal nas coordenadas do layout.
	* A posição vertical nas coordenadas do layout.
	* Uma máscara de bits que representa os botões que foram liberados
	  nesta atualização. O botão primário é o bit menos importante.
	* A contagem de cliques. É positivo para ações com clique simultâneo
	  ou negativo se um clique for transformado numa retenção (clicar e
	  manter) ou arraste (clicar e arrastar)). Se aplica apenas ao botão
	  primário.

	O |callback| não retorna nenhum valor. |handler|.


**Abortando o ponteiro**

	``view:set_pointer_aborted_callback(cb)``

	É invocado quando um ponteiro deixa a exibição de maneira anormal.
	Após receber este evento, a ID do ponteiro pode ser reutilizada com
	um novo ponteiro.

	São passados sete argumentos para a função de |callback|:

	* O tipo do ponteiro como uma *string*. Os valores válidos são
	  ``mouse``, ``pen``, ``touch`` ou ``unknown`` que não se alterará
	  durante a vida do ponteiro.
	* A ID do ponteiro. Este será um inteiro não negativo que não se
	  alterará durante a vida do ponteiro. Os valores da ID podem ser
	  recicladas de maneira "*agressiva*".
	* A ID do dispositivo. Para grupos de ponteiros para reconhecer
	  gestos multitoque.
	* A posição horizontal nas coordenadas do layout.
	* A posição vertical nas coordenadas do layout.
	* Uma máscara de bits que representa os botões que foram liberados
	  nesta atualização. O botão primário é o bit menos importante.
	* A contagem de cliques. É positivo para ações com clique simultâneo
	  ou negativo se um clique for transformado numa retenção (clicar e
	  manter) ou arraste (clicar e arrastar)). Se aplica apenas ao botão
	  primário.

	O |callback| não retorna nenhum valor. |handler|.

**Esquecendo os ponteiros**

	``view:set_forget_pointers_callback(cb)``

	É invocado quando a visualização deve parar de processar a entrada
	do ponteiro. Isso pode ocorrer em várias situações, incluindo:

	* Quando o usuário ativar um menu.
	* Quando a configuração da visualização for alterada.
	* Quando a visualização for desativada.


.. raw:: latex

	\clearpage

.. _layscript-events-item:

O evento de visualização dos itens do layout
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O retorno da visualização dos itens do layout se aplicam aos itens
individuais dentro da visualização. Eles são usados para sobrescrever a
condição predefinida do elemento do item, o estado de animação, limites
e o comportamento da cor.

**Obtém o estado do elemento**

    ``item:set_element_state_callback(cb)``

	Define um |callback| para obter o estado dos itens. Este controla
	como o elemento do item é desenhado, para componentes que mudam a
	aparência dependendo do seu estado para desenhar os componentes de
	forma condicional e o limite, cor da animação dos componentes. Não
	tente acessar o ``element_state`` dos itens a partir do |callback|
	pois pois isso resultará numa repetição infinita.

	O |callback|  não retorna nenhum valor e também não aceita
	parâmetros. Use ``nil`` como um argumento para restaurar o estado do
	manipulador do evento (com base nos atributos XML dos itens).

**Obtém o estado da animação**

    ``item:set_animation_state_callback(cb)``

	Define um |callback| para obter o estado de animação do item. É
	utilizado para as animações dos limites e das cores da animação. Não
	tente acessar o ``animation_state`` do item a partir do |callback|
	pois ocorrerá uma recorrência infinita.

	O |callback|  deve retornar um número inteiro e também não aceita
	nenhum parâmetro. Use ``nil`` como um argumento para restaurar o
	estado original do manipulador do evento de animação (com base nos
	atributos XML dos itens e do sub-elemento ``animate``).

**Obtém os limites do item**

    ``item:set_bounds_callback(cb)``

	Define um |callback| para obter os limites do item (a sua posição e
	o seu tamanho). Não tente acessar o ``bounds`` do item a partir do
	|callback| pois ocorrerá uma recorrência infinita.

	O |callback|  deve retornar os limites da renderização do objeto
	representando os limites do item em coordenadas do seu destino
	(geralmente criado ao invocar o ``emu.render_bounds``) e também não
	aceita nenhum parâmetro. Use ``nil`` como um argumento para
	restaurar o limite original do manipulador do evento (com base no
	estado de animação do item e do sub-elemento ``bounds``).

**Obtém a cor do item**

    ``item:set_color_callback(cb)``

	Define um |callback| para obter a cor de um item (a textura da cor
	do elemento multiplicado por esta cor)

	O |callback|  deve retornar a renderização da cor do objeto
	representando a cor ARGB (geralmente criado ao invocar o
	``emu.render_color``) e também não aceita parâmetros. Use ``nil``
	como um argumento para restaurar a cor original do manipulador do
	evento (com base no estado de animação do item e do sub-elemento
	``color``).


.. raw:: latex

	\clearpage

**Obtém o tamanho da rolagem horizontal do item da janela**

    ``item:set_scroll_size_x_callback(cb)``

	Define um |callback| para obter o tamanho da rolagem horizontal do
	item da janela. Isto permite que o script controle o quanto do
	elemento será exibido pelo item. Não tente acessar a propriedade
	``scroll_size_x`` do item a partir do |callback|, pois isso
	resultará numa repetição infinita.

	O |callback|  deve retornar um número de ponto flutuante
	representando o tamanho horizontal da janela como uma proporção da
	largura dos elementos associados e não aceita quaisquer parâmetros.
	Um valor ``1.0`` exibirá a largura total do elemento; valores
	menores exibem as partes com uma proporção menor do elemento. Use
	``nil`` como um argumento para restaurar o tamanho padrão da rolagem
	horizontal da janela (com base no sub-elemento ``xscroll``).

**Obtém o tamanho da rolagem vertical do item da janela**

    ``item:set_scroll_size_y_callback(cb)``

	Define um |callback| para obter o tamanho da rolagem vertical do
	item da janela. Isto permite que o script controle o quanto do
	elemento será exibido pelo item. Não tente acessar a propriedade
	``scroll_size_y`` do item a partir do |callback|, pois isso
	resultará numa repetição infinita.

	O |callback|  deve retornar um número de ponto flutuante
	representando o tamanho vertical da janela como uma proporção da
	altura dos elementos associados e não aceita quaisquer parâmetros.
	Um valor ``1.0`` exibirá a altura total do elemento; valores
	menores exibem as partes com uma proporção menor do elemento. Use
	``nil`` como um argumento para restaurar o tamanho padrão da rolagem
	vertical da janela (com base no sub-elemento ``yscroll``).

**Obtém a posição da rolagem horizontal do item**

    ``item:set_scroll_pos_x_callback(cb)``

	Define um |callback| para obter a posição da rolagem horizontal do
	item. Isto permite que o script controle qual parte do elemento seja
	exibido pelo item. Não tente acessar a propriedade ``scroll_pos_x``
	do item a partir do |callback|, pois isso resultará numa repetição
	infinita.

	O |callback|  deve retornar um número de ponto flutuante e não
	aceita parâmetros. Um valor ``0.0`` alinha a borda esquerda do
	elemento com a borda esquerda do item; valores maiores deslocam para
	à direita. Use ``nil`` como um argumento para restaurar o
	manipulador da posição da rolagem horizontal padrão (com base nas
	ligações no sub-elemento ``xscroll``).

**Obtém a posição da rolagem vertical do item**

    ``item:set_scroll_pos_y_callback(cb)``

	Define um |callback| para obter a posição da rolagem vertical do
	item. Isto permite que o script controle qual parte do elemento seja
	exibido pelo item. Não tente acessar a propriedade ``scroll_pos_y``
	do item a partir do |callback|, pois isso resultará numa repetição
	infinita.

	O |callback|  deve retornar um número de ponto flutuante e não
	aceita parâmetros. Um valor ``0.0`` alinha a borda superior do
	elemento com a borda superior do item; valores maiores deslocam para
	baixo. Use ``nil`` como um argumento para restaurar o manipulador da
	posição da rolagem vertical padrão (com base nas ligações no
	sub-elemento ``yscroll``).


.. raw:: latex

	\clearpage


.. _layscript-events-element:

Eventos de elementos de layout
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Os eventos de elementos de layout se aplicam à definição de um elemento
visual individual.

**Draw**

    ``element:set_draw_callback(cb)``

    Defina um |callback| para um desenho adicional após os componentes
    do elemento serem desenhados. Isso oferece controle direto ao script
    sobre a textura final ao desenhar o elemento.

    O |callback| recebe dois argumentos, o estado do elemento (um número
    inteiro) e um bitmap ARGB com 32 bits no tamanho desejado. O
    |callback| não deve tentar redimensionar o bitmap. |handler|.


.. |handler| replace:: Use ``nil`` como um argumento para remover o
   manipulador do evento
.. |callback| replace:: retorno de chamada
