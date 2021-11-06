.. _plugins-timer:

Game Play Timer Plugin
======================

O *game play timer plugin* cronometra o tempo total gasto numa
combinação entre sistema e um item da lista de programas, assim como a
quantidade de vezes que cada combinação foi iniciada. Para ver as
estatísticas, abra o menu principal (pressione :kbd:`Tab` durante a
emulação), escolha :guilabel:`Opções dos plug-ins` e então escolha
:guilabel:`Cronômetro`.

Este plugin registra o tempo real (o tempo decorrido enquanto a emulação
estiver acontecendo conforme o sistema operacional) assim como o tempo
emulado.
O tempo do relógio do sistema pode ser menor do que tempo decorrido pelo
tempo da emulação caso desligue o
:ref:`-[no]throttle <mame-commandline-nothrottle>`, use o recurso de
"avanço rápido" do MAME ou pode ser maior do que o tempo emulado
decorrido caso pause a emulação de se a emulação.

As estatísticas são armazenadas num arquivo ``timer.db`` na pasta
**timer** (consulte a opção
:ref:`homepath option <mame-commandline-homepath>`).

O arquivo é um banco de dados SQLite3.
