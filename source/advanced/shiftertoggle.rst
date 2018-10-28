Desabilitando o interruptor de câmbio
=====================================


Este é um recurso avançado para lidar com o interruptor de certas
máquinas arcade antigas como a *Spy Junter* e *Outrun* que usava uma
chave de via dupla que funcionava como um câmbio de marchas. Por
predefinição esse câmbio é tratado como um interruptor. Um toque na
configuração do controle para que o câmbio alterne entre marcha alta e
baixa, com outro toque ele volta para a posição anterior. Essa pode não
ser a melhor opção se você tiver em mãos um câmbio que trabalhe como os
câmbios antigos usados nas máquinas originais.
O câmbio estará engrenado quando a chave for ligada, funcionando ao
contrário quando estiver desligada.

Observe que este recurso *não* ajudará o controle dos usuários e tão
pouco será de qualquer ajuda para jogos que tenham um câmbio com
mais de dois estados (como jogos modernos com mais de uma marcha por
exemplo).

Este recurso não é exibido através da tela do usuário pois é uma
customização extrema feita apenas pessoas que têm essa necessidade em
específico e o conhecimento para fazer o uso dela da forma correta.



Alternando o interruptor de câmbio
----------------------------------

O jogo Spy Hunter (do conjunto *spyhunt*) será usado como exemplo para
explicar as alterações necessárias. Dentro da pasta CFG há um arquivo
*.CFG* que você precisará editar como *spyhunt.cfg* por exemplo.

No MAME, comece rodando o jogo que estamos usando de exemplo, o
*spyhunt*, assim:

**mame spyhunt**.

Configure os controles da maneira que faria em outros jogos, incluindo a
configuração do câmbio. Saia do MAME e abra o arquivo .cfg do jogo no
editor de texto de sua preferência.

Dentro do arquivo *spyhunt.cfg*, você deverá encontrar as seguintes
linhas de texto de configuração para a entrada. O código de entrada
exibido no meio da configuração pode variar dependendo da posição do
controle que você tiver configurado: ::

             <port tag=":ssio:IP0" type="P1_BUTTON2" mask="16" defvalue="16">
                 <newseq type="standard">
                     JOYCODE_1_RYAXIS_NEG_SWITCH OR JOYCODE_1_RYAXIS_POS_SWITCH
                 </newseq>
             </port>


Você precisa editar a linha da porta que definirá a entrada. Para o jogo
Spy Hunter será *P1_BUTTON2*. Adicione ``toggle="no"`` no final da tag,
como mostra o exemplo abaixo: ::

             <port tag=":ssio:IP0" type="P1_BUTTON2" mask="16" defvalue="16" toggle="no">
                 <newseq type="standard">
                     JOYCODE_1_RYAXIS_NEG_SWITCH OR JOYCODE_1_RYAXIS_POS_SWITCH
                 </newseq>
             </port>


Salve e saia.
Para desabilitar, simplesmente remova a opção **toggle="no"** de cada
arquivo de .CFG que desejar.
