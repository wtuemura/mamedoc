.. _plugins-hiscore:

Hiscore Support Plugin
======================

Este plug-in salva e restaura o placar dos jogos que originalmente não
salvavam tais pontuações na memória não volátil.
Observe que este plug-in altera diretamente o conteúdo da memória sem
qualquer coordenação com o software que está sendo emulado, portanto,
altera o seu comportamento e pode ter efeitos indesejáveis, quebrando a
jogabilidade ou fazendo com que o software que está sendo emulado no
momento, trave.

O plugin inclui um arquivo **hiscore.dat** que contém as informações
de como salvar e restaurar o placar nos sistemas compatíveis. Este
arquivo deve ser mantido atualizado quando as definições do sistema
mudarem no MAME.

O placar pode ser salvo automaticamente ao encerrar a emulação ou
segundos depois que o placar for atualizado na memória. Para alterar a
configuração pressione :kbd:`Tab` durante a emulação e vá em
:guilabel:`Opções do plugin` --> :guilabel:`Hiscore Support` e altere as
opções do :guilabel:`Save scores`. Altere as opções destacando-a e
usando as teclas :kbd:`←` / :kbd:`→` na interface do usuário ou clicando
nas setas.

Um arquivo com o nome da ROM e a extensão ``.hi`` ficam gravados no
diretório **hiscore** dento da pasta de dados do plug-in, consulte a
opção :ref:`homepath <mame-commandline-homepath>`). O conteúdo do
arquivo tem o formato JSON.
