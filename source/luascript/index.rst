.. raw:: latex

	\clearpage

.. _luascript:

INTERFACE PARA SCRIPTS LUA
==========================

.. contents:: :local:


.. _luaengine-intro:

Introdução
----------

O MAME oferece um conjunto útil de funcionalidades básicas para scripts
Lua [1]_. Estas funcionalidades apareceram inicialmente na versão **0.148**
quando uma reduzida interface Lua foi implementada. Hoje em dia, a
interface Lua é rica o suficiente para manipular os estados dos
dispositivos, acesso aos registros do CPU, ler e escrever na memória,
desenhar um painel customizado na tela, etc.

Há três maneiras de utilizar os recursos de script Lua do MAME:

* Usando o :ref:`console interativo Lua <luascript-console>`, ativado
  através da opção :ref:`-console <mame-commandline-console>`.
* Ao rodar um script via arquivo usando a opção :ref:`-autoboot_script
  <mame-commandline-autobootscript>`. A opção :ref:`-autoboot_delay
  <mame-commandline-autobootdelay>` controla quanto tempo o MAME deve
  aguardar para roda o script depois que a emulação for iniciada.
* Ao escrever :ref:`plug-ins Lua <plugins>`. Alguns já estão inclusos
  com o MAME.


Internamente, o MAME faz o uso intensivo do
`Sol3 <https://github.com/ThePhD/sol2>`_ para implementar as
funcionalidades Lua.

A API Lua ainda não é considerado estável, havendo a possibilidade de
ser alterada repentinamente sem nenhum aviso prévio. No entanto, podemos
demonstrar metodologias onde é possível saber qual a versão do API está
sendo rodada, a maioria dos objetos suporta algum nível de introspeção
durante o tempo de execução.

.. raw:: latex

	\clearpage


.. _luaengine-features:

Características
---------------

Pelo fato da API estar incompleta, abaixo uma lista parcial de recursos
disponíveis atualmente com os scripts Lua:

* Informações da sessão (versão do aplicativo, sistema atualmente
  emulado).
* Controle da sessão (iniciar, pausar, redefinir, parar).
* Ganchos de eventos (na pintura dos quadros e nos eventos do usuário).
* Introspecção dos dispositivos (listagem da árvore de dispositivos,
  enumeração da memória e registros).
* Introspecção da tela (listagem das telas, detalhes da tela, contagem
  de quadros).
* Desenho da sobreposição de tela (texto, linhas, caixas em várias
  telas).
* Leitura/escrita da memória (``8``, ``16``, ``32`` e ``64`` bits,
  ``signed`` e ``unsigned``).
* Registro e controle de estado (enumeração de estado, ``get`` e
  ``set``).


.. raw:: latex

	\clearpage


.. _luascript-api:

Referência da API
-----------------

.. toctree::
    :maxdepth: 2

    ref-common
    ref-core
    ref-devices
    ref-mem
    ref-input
    ref-render
    ref-debugger

.. raw:: latex

	\clearpage


.. _luascript-console:

Tutorial do console interativo Lua
----------------------------------

No prompt de comando ou terminal rode um jogo arcade qualquer com as
opções ``-console`` e ``-window``

First run an arcade game in MAME at the command prompt with the ``-console``
and ``-window`` para ativar o console Lua::

    $ mame -console -window SEU_SISTEMA
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

    mame 0.255
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
o jogo pausou. Em geral, os comandos não retornam informação de
confirmação e o terminal retorna apenas mensagens de erro.

Durante a execução, é possível verificar qual a sua versão do MAME com o
comando abaixo::

    [MAME]> print(emu.app_name() .. " " .. emu.app_version())
    mame 0.255

Nós agora começaremos a explorar os métodos relacionadas à tela.
Primeiro, vamos enumerar as
:ref:`telas disponíveis <luascript-ref-screendev>` no sistema::

    [MAME]> for tag, screen in pairs(manager.machine.screens) do print(tag) end
    :screen

O ``manager.machine`` é o objeto da
:ref:`maquina em execução <luascript-ref-machine>` da sessão atual que
está sendo emulada. Será utilizada com bastante frequência.
O ``screens`` são
:ref:`enumeradores de dispositivos <luascript-ref-devenum>` que geram
todas as telas do sistema; a maioria dos sistemas arcade só tem uma tela
principal. No nosso caso a única tela principal é marcada como
``:screen`` e podemos inspecioná-la mais a fundo::

    [MAME]> -- mantendo a referência para a tela principal numa variável
    [MAME]> s = manager.machine.screens[':screen']
    [MAME]> print(s.width .. 'x' .. s.height)
    320x224

Temos diferentes métodos para desenhar um painel (HUD) na tela composta
de camadas com linhas, caixas e textos::

    [MAME]> -- definimos a função para desenhar a interface e a chamamos
    [MAME]> function draw_overlay()
    [MAME]>> s:draw_text(40, 40, 'foo') -- (x0, y0, msg)
    [MAME]>> s:draw_box(20, 20, 80, 80, 0xff00ffff, 0) -- (x0, y0, x1, y1, line-color, fill-color)
    [MAME]>> s:draw_line(20, 20, 80, 80, 0xff00ffff) -- (x0, y0, x1, y1, line-color)
    [MAME]>> end
    [MAME]> draw_overlay()

Isso desenha alguns desenhos inúteis na tela. No entanto, seu painel
desaparecerá caso não seja atualizado ao sair da pausa. Para evitar
isso, é preciso registrar uma função que será chamado a cada atualização
do vídeo::

    [MAME]> emu.register_frame_done(draw_overlay, 'frame')

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

    [MAME]> cpu = manager.machine.devices[':maincpu']
    [MAME]> -- enumera, lê e escreve registros de estado
    [MAME]> for k, v in pairs(cpu.state) do print(k) end
    CURPC
    rPC
    IR
    CURFLAGS
    SSR
    D0
    [...]
    [MAME]> print(cpu.state['D0'].value)
    303
    [MAME]> cpu.state['D0'].value = 255
    [MAME]> print(cpu.state['D0'].value)
    255

::

    [MAME]> -- inspeciona a mamória
    [MAME]> for name, space in pairs(cpu.spaces) do print(name) end
    program
    cpu_space
    [MAME]> mem = cpu.spaces['program']
    [MAME]> print(mem:read_i8(0xc000))
    41

Observe que muitos objetos suportam o preenchimento automático ao
pressionar a tecla :kbd:`Tab` durante a escrita parcial de símbolos ou
da propriedade de um nome:

::

    [MAME]>print(mem:read_<TAB>
    read_direct_i8
    read_u16
    read_range
    read_direct_u16
    read_direct_i64
    read_i64
    read_i32
    read_direct_u64
    read_i8
    read_u32
    read_u8
    read_u64
    read_direct_u32
    read_direct_i16
    read_direct_i32
    read_direct_u8
    read_i16
    [MAME]>print(mem:read_direct_i8

.. [1]	Acesse o `site do projeto Lua
    <https://www.lua.org/portugues.html>`_ para obter mais informações.
