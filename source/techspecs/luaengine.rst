.. raw:: latex

	\clearpage

Usando Scripts LUA com o MAME
=============================

Introdução
----------

Agora é possível controlar o MAME externamente usando scripts LUA [1]_.
Essa funcionalidade apareceu inicialmente na versão 0.148, quando o
``luaengine`` foi implementado. Hoje em dia, a interface LUA é rica o
suficiente para deixar você inspecionar e manipular os estados dos
dispositivos, acesso aos registros do CPU, ler e escrever a memória,
desenhar um painel customizado na tela.

Internamente, o MAME faz o uso intensivo de ``luabridge`` para
implementar esse recurso: a ideia é expor muitos dos recursos internos
de forma mais transparente possível.

Aqui fica o alerta: A API LUA ainda não é considerada estável havendo a
possibilidade de ser alterada sem nenhum aviso prévio. No entanto,
podemos demonstrar metodologias para que você saiba qual a versão do
API está rodando e quais os objetos são os mais usados durante a
execução.

Características
---------------

Pelo fato da API estar incompleta, abaixo uma lista parcial de recursos
disponíveis atualmente com os scripts LUA:

-  metadata de máquina (versão do app, rom atual, descrição da rom)
-  controle da máquina (iniciar, pausar, resetar, parar)
-  ganchos da máquina (pinta em cima do frame e nos eventos de usuário)
-  introspeção dos dispositivos (enumeração da árvore dos dispositivos, memória e registros)
-  introspeção das telas (listagem de telas, descritivos, contagem de quadros)
-  desenho de um painel (HUD) na tela (texto, linhas, caixas em múltiplas telas)
-  leitura/escrita de memória (8/16/32/64 bits, signed e unsigned)
-  controle de estados e registros (enumeração dos estados, obter e definir)

Uso
---

O MAME suporta o carregamento de scripts LUA (>= 5.3), seja ele escrito
no console interativo ou se for carregado como um arquivo externo. Para
usar o console, rode o mame usando o comando **-console**, você será
apresentado a um prompt de comando com um ``>``, onde será possível
redigir o seu script.

Use o comando **-autoboot_script** para carregar um script. Por
predefinição o carregamento do script pode ser atrasado em alguns poucos
segundos, essa predefinição pode ser substituída com o comando 
**-autoboot_delay**.

Para controlar a execução do seu código, você pode usar uma abordagem do
tipo *loop-bases* ou *event-based*. Não encorajamos o uso deste último
devido ao alto consumo de recursos e faz a continuidade de controle
desnecessariamente complicada. Em vez disso, sugerimos o registro de
ganchos personalizados que poderão ser invocados em um evento específico
(como a cada renderização de quadro por exemplo).

Demonstração passo a passo
--------------------------

Rode o MAME num terminal para ter acesso ao console Lua:

::

    $ mame -console YOUR_ROM
         _/      _/    _/_/    _/      _/  _/_/_/_/
       _/_/  _/_/  _/    _/  _/_/  _/_/  _/
      _/  _/  _/  _/_/_/_/  _/  _/  _/  _/_/_/
     _/      _/  _/    _/  _/      _/  _/
    _/      _/  _/    _/  _/      _/  _/_/_/_/
    mame v0.195
    Copyright (C) Nicola Salmoria and the MAME team

    Lua 5.3
    Copyright (C) Lua.org, PUC-Rio

    [MAME]>

Neste ponto, o seu jogo provavelmente pode estar sendo executado,
use o comando abaixo para pausá-lo:

::

    [MAME]> emu.pause()
    [MAME]>

Mesmo sem qualquer tipo de retorno no console, você deve ter notado que
o jogo parou. Em geral, os comandos não retornam informação de
confirmação o terminal retorna mensagens de erro apenas.

Você pode verificar durante a execução, qual a versão do MAME que
você está rodando com o comando abaixo:

::

    [MAME]> print(emu.app_name() .. " " .. emu.app_version())
    mame 0.195

Nós agora começaremos a explorar os métodos relacionadas à tela.
Primeiro, vamos enumerar as telas disponíveis:

::

    [MAME]> for i,v in pairs(manager:machine().screens) do print(i) end
    :screen

**manager:machine()** este é o objeto raiz da sua máquina atualmente em
execução: será usada com bastante frequência. **screens** é uma tabela
com todas as telas disponíveis; a maioria das máquinas tem apenas uma
tela principal. No nosso caso, a tela principal e única é marcada como
**:screen**, e podemos inspecioná-la mais a fundo:

::

    [MAME]> -- vamos definir um atalho para a tela principal
    [MAME]> s = manager:machine().screens[":screen"]
    [MAME]> print(s:width() .. "x" .. s:height())
    320x224

Temos diferentes métodos para desenhar um painel (HUD) na tela composta
de linhas, caixas e textos:

::

    [MAME]> -- definimos a função para desenhar a interface e a chamamos
    [MAME]> function draw_hud()
    [MAME]>> s:draw_text(40, 40, "foo"); -- (x0, y0, msg)
    [MAME]>> s:draw_box(20, 20, 80, 80, 0, 0xff00ffff); -- (x0, y0, x1, y1, fill-color, line-color)
    [MAME]>> s:draw_line(20, 20, 80, 80, 0xff00ffff); -- (x0, y0, x1, y1, line-color)
    [MAME]>> end
    [MAME]> draw_hud();

Isso desenha alguns desenhos inúteis na tela. No entanto, seu painel
desaparecerá caso não seja atualizado ao sair da pausa. Para evitar
isso, registre o gancho a ser chamado em cada quadro desenhado:

::

    [MAME]> emu.register_frame_done(draw_hud, "frame")

Todas as cores são no formato ARGB (32b unsigned), enquanto a origem da
tela geralmente corresponde ao canto superior esquerdo da tela (0,0).

Da mesma forma para telas, você pode inspecionar todos os dispositivos
conectados em uma máquina:

::

    [MAME]> for k,v in pairs(manager:machine().devices) do print(k) end
    :audiocpu
    :maincpu
    :saveram
    :screen
    :palette
    [...]

Em alguns casos, você também pode inspecionar e manipular a memória
e o estado:

::

    [MAME]> cpu = manager:machine().devices[":maincpu"]
    [MAME]> -- enumera, lê e escreve registros de estado
    [MAME]> for k,v in pairs(cpu.state) do print(k) end
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
    [MAME]> for k,v in pairs(cpu.spaces) do print(k) end
    program
    [MAME]> mem = cpu.spaces["program"]
    [MAME]> print(mem:read_i8(0xC000))
    41

.. [1]	Acesse o `site do projeto LUA
		<https://www.lua.org/portugues.html>`_ para maiores informações.
		(Nota do tradutor)