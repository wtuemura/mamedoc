Timer Plugin
============

O *timer plugin* cronometra o tempo total gasto numa combinação de
sistema e um item da lista de programas, assim como a quantidade de
vezes que cada combinação foi iniciada. Para ver as estatísticas,
abra o menu principal (pressione :kbd:`Tab` durante a emulação),
escolha :guilabel:`Opções dos plug-ins` e então escolha
:guilabel:`Cronômetro`.

Observe que este plugin registra o tempo real e não o tempo emulado.
Ou seja, ele registra a duração em tempo real decorrida enquanto a
emulação está sendo executada conforme o sistema operacional. Isso pode
ser menor do que o decorrimento do tempo emulado caso desligue o
:ref:`-[no]throttle <mame-commandline-nothrottle>`, use o recurso de
"avanço rápido" do MAME ou pode ser maior do que o tempo emulado
decorrido caso pause a emulação de se a emulação.

As estatísticas são armazenadas num arquivo ``timer.db`` na pasta
**timer** (consulte a opção
:ref:`homepath option <mame-commandline-homepath>`).

O arquivo é um banco de dados SQLite3.
