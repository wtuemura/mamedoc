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
dados forem requeridos.

É preciso que o plug-in de layout esteja ativo para que os scripts
possam ser usados. Por exemplo, use este comando para rodar **BWB Double
Take** com o script Lua ativo no layout::

    mame64 -plugins -plugin layout v4dbltak

Adicione esta configuração em um arquivo ``v4dbltak.ini`` dentro do
diretório **ini** para que esta mesma configuração sempre seja utilizada
quando o sistema for iniciado.

Para mais informações consulte o capítulo :ref:`advanced-multi-CFG`.

.. raw:: latex

	\clearpage

.. _layscript-examples:

Exemplos práticos
-----------------

Antes de entrarmos de cabeça nos detalhes técnicos do seu
funcionamento, começaremos com alguns exemplos usando o script Lua.

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

Há dois joysticks, um usado por ambos os jogadores em um gabinete
vertical ou o primeiro jogador em um gabinete tipo coquetel e um usado
para o segundo jogador em um gabinete tipo coquetel. Observe que os
interruptores para o primeiro joystick estão divididos entre as duas
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
        <!-- caso o plug-in do layout não esteja ativo, nós avisaremos ao usuário  -->
        <!-- desenha apenas quando o seu estado for 1, define o seu estado predefinido para 1 assim o aviso fica visível inicialmente -->
        <element name="warning" defstate="1">
            <text state="1" string="Esta visualização precisa que o plug-in do layout esteja ativo." />
        </element>
        <!-- exibindo a tela e o joystick em um gabinete tipo coquetel -->
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
                        -- neste caso, é o principal controlador da máquina espial
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

.. raw:: latex

	\clearpage

O layout tem um elemento ``script`` contendo o script Lua que é invocado
como uma função através do plugin de layout durante o carregamento do
arquivo de layout. A visualização do layout foi construída neste ponto,
porém o sistema emulado ainda não terminou de ser iniciado. Não é seguro
acessar as entradas e as saídas neste momento. A variável chave no
ambiente do script é ``file`` que dá ao script o acesso ao seu arquivo
de layout.

Nós fornecemos uma função que será invocada depois que as tags no
arquivo de layout tiverem sido resolvidas. Neste ponto, o sistema
emulado terá concluído a sua inicialização. Esta função realiza as
seguintes tarefas:

* Monitora a entrada das duas portas E/S do jogador. As portas E/S podem
  ser monitoradas através das tags relacionadas com o dispositivo que
  fizer com que o arquivo de layout seja carregado.
* Monitora os dois itens usados pela tela exibindo o estado do joystick.
  As visualizações podem ser monitoradas através do nome (o valor
  do atributo ``name`` por exemplo), e os itens que estiverem entre
  ``view`` e que possuam um ID (o valor do atributo ``id`` por exemplo).
* Fornece uma função que será invocada antes que os itens sejam
  renderizados na tela.
* Oculta o aviso que lembra o usuário para ativar o plugin do layout ao
  definir o estado do elemento para o item com 0 (o componente do texto
  só é desenhado quando o estado do elemento for 1).

A função que é invocada antes dos itens de visualização são renderizados
na tela, lê as entradas do jogador e embaralha os bits na ordem
necessária pelo elemento joystick.
