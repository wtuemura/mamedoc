.. _plugins-timecode:

Timecode Recorder Plugin
========================

O plug-in *timecode recorder* faz a gravação do tempo em código num
arquivo texto em conjunto com a gravação dos comandos do jogador que
serve na assistência das pessoas que gravam as partidas dos jogos. Este
registro de tempo é feito *apenas* durante a gravação destes comandos.
O arquivo de registro possui o mesmo nome que o arquivo de gravação dos
comandos mas com a extensão ``.timecode``. Utilize as opções
:ref:`-record <mame-commandline-record>` e
:ref:`-input_directory <mame-commandline-inputdirectory>` para registrar
os comandos e para definir o destino destes arquivos.

O atalho padrão para a gravação do código de tempo é :kbd:`F12`. É
possível alterar esta configuração no menu de configuraçao do plug-in
(escolha :guilabel:`Opções dos plug-ins` a partir do menu principal
durante a emulação e escolha :guilabel:`Timecode Recorder`).

As configurações do plug-in ficam armazenadas no arquivo ``plugin.cfg``
no formato JSON dentro da pasta **timecode** na pasta raiz do MAME
(consulte a opção :ref:`-homepath <mame-commandline-homepath>`).
