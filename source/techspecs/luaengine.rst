.. raw:: latex

	\clearpage

.. _luaengine:

Usando scripts Lua
==================

.. contents:: :local:


.. _luaengine-intro:

Introdução
----------

Agora é possível controlar o MAME externamente usando scripts Lua [1]_.
Essa funcionalidade apareceu inicialmente na versão **0.148**, quando o
``luaengine`` foi implementado. Hoje em dia, a interface Lua é rica o
suficiente para manipular os estados dos dispositivos, acesso aos
registros do CPU, ler e escrever a memória, desenhar um painel
customizado na tela, etc.

Internamente, para implementar este recurso, o MAME faz o uso intensivo
do `Sol3 <https://github.com/ThePhD/sol2>`_. A ideia é expor muitos dos
recursos internos de forma mais transparente possível.

Aqui fica o alerta: A API Lua ainda não é considerado estável, havendo a
possibilidade de ser alterada sem nenhum aviso prévio. No entanto,
podemos demonstrar metodologias onde é possível saber qual a versão do
API está sendo rodada e a maioria dos objetos suportados por tempo de
execução que você pode utilizar.


.. _luaengine-features:

Características
---------------

Pelo fato da API estar incompleta, abaixo uma lista parcial de recursos
disponíveis atualmente com os scripts Lua:

-  os metadados do sistema (versão do programa, o sistema emulado no momento, detalhes da ROM).
-  controle do sistema (iniciar, pausar, redefinir, interromper).
-  ganchos do sistema (pintura em cima do frame e nos eventos do usuário).
-  introspeção dos dispositivos (enumeração da árvore dos dispositivos, memória e registros).
-  introspeção das telas (listagem de telas, detalhes da tela, contagem dos quadros).
-  desenho de sobreposição na tela (texto, linhas, caixas em diversas telas).
-  leitura/escrita da memória (``8``, ``16``, ``32`` e ``64`` bits, *signed* e *unsigned*).
-  controle dos estados e dos registros (enumeração dos estados, *get* e *set*).

Várias classes estão documentadas na página
:ref:`Lua class reference <luareference>`.


.. _luaengine-usage:

Utilização
----------

O MAME suporta o carregamento de scripts Lua, seja ele digitado no
console interativo ou se for carregado como um arquivo externo. Para
usar o console, rode o MAME usando o comando ``-console``, será mostrado
um *prompt* de comando com um ``[MAME]>`` onde é possível interagir e
digitar o seu script.

Use o comando ``-autoboot_script`` para carregar um script. Por
predefinição, o carregamento do script pode ser atrasado em alguns
poucos segundos, essa predefinição pode ser substituída com a opção 
``-autoboot_delay``.

Para controlar a execução do seu código é possível usar uma abordagem do
tipo *loop-bases* ou *event-based*. Não encorajamos o uso deste último
devido ao alto consumo de recursos e que faz o controle do fluxo de
continuidade desnecessariamente complicado. Em vez disso, sugerimos o
registro de ganchos personalizados que poderão ser invocados num evento
específico (como a cada renderização do quadro por exemplo).

Demonstração passo a passo
--------------------------

Rode o MAME num terminal para ter acesso ao console Lua::

    $ mame -console SEU_SISTEMA
           /|  /|    /|     /|  /|    _______
          / | / |   / |    / | / |   /      /
         /  |/  |  /  |   /  |/  |  /  ____/
        /       | /   |  /       | /  /_
       /        |/    | /        |/  __/
      /  /|  /|    /| |/  /|  /|    /____
     /  / | / |   / |    / | / |        /
    / _/  |/  /  /  |___/  |/  /_______/
             /  /
            / _/

    mame 0.250
    Copyright (C) Nicola Salmoria and the MAME team

    Lua 5.4
    Copyright (C) Lua.org, PUC-Rio

    [MAME]>

Neste ponto, o seu jogo provavelmente pode estar sendo executado,
use o comando abaixo para pausá-lo:

::

    [MAME]> emu.pause()
    [MAME]>

Mesmo sem qualquer tipo de retorno no console, é possível notar que
o jogo parou. Em geral, os comandos não retornam informação de
confirmação o terminal retorna mensagens de erro apenas.

Durante a execução é possível verificar qual a versão do MAME sendo
rodada no momento com o comando abaixo::

    [MAME]> print(emu.app_name() .. " " .. emu.app_version())
    mame 0.250

Nós agora começaremos a explorar os métodos relacionadas à tela.
Primeiro, vamos enumerar as telas disponíveis::

    [MAME]> for tag, screen in pairs(manager.machine.screens) do print(tag) end
    :screen

O ``manager.machine`` é o objeto da :ref:`luareference-core-machine`
para a sua sessão atual da emulação. Será usada com bastante frequência.
O **screens** são :ref:`luareference-dev-enum` que produz todas as telas
no sistema; a maioria dos sistemas arcade só tem uma tela principal.
No nosso caso a única tela principal é marcada como ``:screen`` e
podemos inspecioná-la mais a fundo::

    [MAME]> -- mantendo a referência para a tela principal numa variável
    [MAME]> s = manager.machine.screens[":screen"]
    [MAME]> print(s.width .. "x" .. s.height)
    320x224

Temos diferentes métodos para desenhar um painel (HUD) na tela composta
de linhas, caixas e textos::

    [MAME]> -- definimos a função para desenhar a interface e a chamamos
    [MAME]> function draw_hud()
    [MAME]>> s:draw_text(40, 40, "foo") -- (x0, y0, msg)
    [MAME]>> s:draw_box(20, 20, 80, 80, 0xff00ffff, 0) -- (x0, y0, x1, y1, line-color, fill-color)
    [MAME]>> s:draw_line(20, 20, 80, 80, 0xff00ffff) -- (x0, y0, x1, y1, line-color)
    [MAME]>> end
    [MAME]> draw_hud()

Isso desenha alguns desenhos inúteis na tela. No entanto, seu painel
desaparecerá caso não seja atualizado ao sair da pausa. Para evitar
isso, registre o gancho a ser chamado em cada quadro desenhado::

    [MAME]> emu.register_frame_done(draw_hud, "frame")

Todas as cores são no formato ARGB (8 bit por canal), enquanto a origem
da tela geralmente corresponde ao canto superior esquerdo da tela (0,0).

Da mesma forma para telas, é possível inspecionar todos os dispositivos
conectados num sistema::

    [MAME]> for tag, device in pairs(manager.machine.devices) do print(tag) end
    :audiocpu
    :maincpu
    :saveram
    :screen
    :palette
    [...]

Em alguns casos, também é possível inspecionar e manipular a memória
e o estado::

    [MAME]> cpu = manager.machine.devices[":maincpu"]
    [MAME]> -- enumera, lê e escreve registros de estado
    [MAME]> for k, v in pairs(cpu.state) do print(k) end
    D5
    SP
    A4
    A3
    D0
    PC
    [...]
    [MAME]> print(cpu.state["D0"].value)
    303
    [MAME]> cpu.state["D0"].value = 255
    [MAME]> print(cpu.state["D0"].value)
    255

::

    [MAME]> -- inspeciona a mamória
    [MAME]> for name, space in pairs(cpu.spaces) do print(name) end
    program
    [MAME]> mem = cpu.spaces["program"]
    [MAME]> print(mem:read_i8(0xc000))
    41

.. [1]	Acesse o `site do projeto Lua
		<https://www.lua.org/portugues.html>`_ para maiores informações.
		(Nota do tradutor)
