
.. raw:: latex

	\clearpage

.. _default-keys:

Teclas já predefinidas
======================

Aqui um pequeno resumo de todas as teclas já pré-configuradas, consulte
o capítulo :ref:`Cardápio de opções <mamemenu>` para ver a lista
completa de todas as teclas. Todas as teclas podem ser configuradas
através da interface do usuário.


================  ===============================================================================
Tecla             | Ação
----------------  -------------------------------------------------------------------------------
**Escape**        | Encerra a emulação.
**5**             | Insere crédito nas máquinas do tipo Arcade.
**1**             | Inicia a partida para o jogador 1 (Player 1).
**2**             | Inicia a partida para o jogador 2 (Player 2).
**Tab**           | Exibe um cardápio que dá acesso a diferentes configurações.
**~**             | Exibe opções configuráveis na parte de baixo da tela, use as seguintes teclas para
                  | controlá-las:
                  |
                  | * **Cima** - selecione o parâmetro anterior para modificar
                  | * **Baixo** - selecione o próximo parâmetro para modificar
                  | * **Esquerda** - reduz o valor do parâmetro selecionado
                  | * **Direita** - incrementa o valor do parâmetro selecionado
                  | * **Enter** - zera o valor do parâmetro para seu valor inicial
                  | * **Control+Esquerda** - reduz o valor em passos de *10x*
                  | * **Shift+Esquerda** - reduz o valor em passos de *0.1x*
                  | * **Alt+Esquerda** - reduz o valor pela menor quantidade
                  | * **Control+Direita** - incrementa o valor em passos de *10x*
                  | * **Shift+Direita** - incrementa o valor em passos de *0.1x*
                  | * **Alt+Right** - incrementa o valor pela menor quantidade
                  |
                  | Se você estiver rodando com a opção **-debug**, esta tecla envia um 'break' para
                  | a emulação.
**P**             | Pausa o jogo.
**Shift+P**       | Enquanto estiver pausado, avança para o próximo quadro. Caso a opção retroceder
                  | esteja ativa, será capturado um novo estado de retrocesso, assim como este também
                  | será salvo.
**Shift+~**       | Enquanto estiver pausado, carrega o estado de salvamento de retrocesso mais recente.
**F1**            | Inicia o processo de auditoria das ROMs que estão marcadas como não disponíveis.
**Shift+F1**      | Inicia o processo de auditoria das ROMs de todas as máquinas existentes.
**F2**            | Modo de serviço para jogos que seja compatíveis.
**F3**            | Reinicia o jogo.
**Shift+F3**      | Executa uma "reinicialização forçada", fechando e reiniciando a emulação do zero.
                  | Este produz um reinicio mais limpo e completo do que pressionar apenas o F3.
**LCtrl+F3**      | [APENAS SDL] - Alterna o alongamento irregular.
**F4**            | Exibe a paleta GFX decodificada e os *tilemaps* dos jogos. Pressione **F4** novamente para sair.
                  |
                  | Paleta / modo tabela de cores (color table):
                  |  * **[ ]** - alterna entre os modos paleta e tabela de cores
                  |  * **Cima/Baixo** - role uma linha de cada vez para cima e para baixo
                  |  * **Page Up/Page Down** - desloca uma página de cada vez para cima e para baixo
                  |  * **Home/End** - ir para o topo ou final da lista
                  |  * **-/+** - aumenta ou reduz a quantidade de cores por linha
                  |  * **0** - restaura a quantidade predefinida de cores por linha
                  |  * **Enter** - altera para o visualizador gráfico entre os modos **paleta**, **gráficos** e **tilemaps**
                  |
                  | Modo gráfico:
                  |  * **[ ]** - alterna entre diferentes conjuntos de gráficos
                  |  * **Cima/Baixo** - role uma linha de cada vez para cima e para baixo
                  |  * **Page Up/Page Down** - desloca uma página de cada vez para cima e para baixo
                  |  * **Home/End** - ir para o topo ou final da lista
                  |  * **Esquerda/Direita** - altera a cor que está sendo exibida
                  |  * **R** - rotacione os blocos em *90º* no sentido horário
                  |  * **-/+** - aumenta/reduz a quantidade de blocos por linha
                  |  * **0** - restaura a quantidade predefinida dos *tiles* por linha
                  |  * **Enter** - alterna para o visualizador de tilemap
                  |
                  | Modo Tilemap: [1]_ [2]_
                  |  * **[ ]** - alterna entre diferentes tilemaps
                  |  * **Cima/Baixo/Esquerda/Direita** - role *8 pixels* por vez
                  |  * **Shift+Cima/Baixo/Esquerda/Direita** - role *1 pixel* por vez
                  |  * **Control+Cima/Baixo/Esquerda/Direita** - role *64 pixels* por vez
                  |  * **R** - rotacionar o ângulo de visão do tilemap em *90º* no sentido horário
                  |  * **-/+** - aumenta/reduz o fator de zoom
                  |  * **0** - amplie os pequenos *tilemaps* para preencher toda a tela
                  |  * **Enter** - altera para o modo paleta de cores ou tabela de cores
                  |
**LCtrl+F4**      | [**APENAS SDL**] - Alterna a relação de aspecto da tela.
**LCtrl+F5**      | [**APENAS SDL**] - Alterna o Filtro.
**Alt+Ctrl+F5**   | [**APENAS MS WINDOWS**] - Alterna o processamento HLSL final
**F6**            | Alterna o modo de trapaça (caso o MAME seja iniciado com a opção **-cheat**)
**LCtrl+F6**      | Reduz a proporção da escala preliminar
**F7**            | Ler a gravação de estado. Você será solicitado a pressionar uma tecla para
                  | determinar qual a gravação de estado você deseja carregar.
                  |
                  | Observe que uma grande quantidade de drivers não são compatíveis com este
                  | recurso. Você receberá um alerta ao tentar executar essa função com um
                  | driver que não seja compatível.
                  |
**LCtrl+F7**      | Aumenta a Proporção de Escala Preliminar
**Shift+F7**      | Cria uma gravação de estado. Precisa pressionar uma tecla a mais para
                  | identificar o estado, semelhante a opção de carregamento acima.
**F8**            | Reduz o salto de quadro.
**F9**            | Aumenta o pulo de quadro.
**F10**           | Alterna o afogador de velocidade.
**F11**           | Alterna o indicador de velocidade.
**Shift+F11**     | Alterna indicador interno de perfil (caso tenha sido compilado com).
**Alt+F11**       | Grava vídeo renderizado com filtros HLSL.
**F12**           | Salva um print da tela.
**Alt Gr+F12**    | Tira um print da tela usando filtros HLSL.
**Insert**        | [**APENAS MS WINDOWS, NÃO SDL**] Avanço rápido.
                  | Enquanto a tecla estiver pressionada, roda o jogo com
                  | o afogador desligado e com o pulo de quadros no máximo.
**Page DN**       | [**APENAS SDL**] Avanço rápido.
                  | Enquanto a tecla estiver pressionada, roda o jogo com o afogador de velocidade
                  | desligado e com o pulo de quadros no máximo.
**Alt+ENTER**     | Alterna entre o modo janela e de tela inteira.
**Scroll Lock**   | Mapeamento padrão para **-uimodekey**.
                  |
                  | Essa tecla permite que os usuários ativem ou desativem o teclado emulado
                  | em máquinas que precisam. Todas as emulações que precisam de teclados emulados
                  | começarão nesse modo e você só poderá acessar
                  | a IU (pressionando TAB), depois de pressionar essa tecla primeiro.
                  | Você pode mudar a condição inicial do teclado emulado como demonstrado
                  | logo abaixo com mais detalhes usando a opção **-ui_active**.
================  ===============================================================================

.. raw:: latex

	\clearpage

Comparativo entre os mapas de teclado
=====================================

QWERTY US (104 Teclas)
~~~~~~~~~~~~~~~~~~~~~~

.. image:: images/QWERTY_US(104).svg
    :width: 100%
    :align: center
    :alt: QWERTY US (104)

QWERTY ABNT-2 (107 Teclas)
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. image:: images/QWERTY_pt_BR-ABNT2(107).svg
    :width: 100%
    :align: center
    :alt: QWERTY ABNT-2 (107)

.. [1] Nem todos as máquinas possuem gráficos *tilemap* decodificados.
.. [2] **tilemaps** são como pequenos recortes ou pedaços usados para montar a imagem do jogo.

