.. raw:: latex

	\clearpage


.. _mame-othertools:

Outras ferramentas incluídas com o MAME
=======================================


ledutil.exe/ledutil.sh
----------------------

No Microsoft Windows o ledutil.exe pode ser usado para controlar as luzes
led do seu teclado para espelhar aquelas luzes presentes nos primeiros
jogos de arcade como o Asteroids por exemplo.

Para ativar essa funcionalidade inicie o **ledutil.exe** da linha de
comando. Rode o comando **ledutil.exe -kill** para interrompê-lo.

Nas plataformas SDLMAME como o macOS e Linux, o **ledutil.sh** poderá
ser usado. Use o comando **ledutil.sh -a** para que ele seja fechado
automaticamente ao sair do SDLMAME.


.. _mame-othertools-dev:

Ferramentas voltadas ao desenvolvimento 
=======================================


.. _mame-othertools-pngcmp:

pngcmp
------

Essa ferramenta é usada em teste de regressão ao comparar instantâneos
PNG vindos de um script teste **runtest.cmd** encontrado nos arquivos de
código-fonte. Esse script só funciona no Windows.


.. _mame-othertools-nltool:

nltool
------

Componente de conversão discreto.


.. _mame-othertools-nlwav:

nlwav
-----

Componente discreto de conversão e ferramenta de teste.


.. _mame-othertools-jedutil:

jedutil
-------

Ferramenta útil para extração de **PAL**/**PLA**/**PLD**/**GAL**.
Ele pode converter entre o formato JED padrão da indústria e o formato
binário compactado proprietário do MAME, pode mostrar também equações
lógicas para os tipos de dispositivos que conhecem tal lógica interna.


.. _mame-othertools-ldresample:

ldresample
----------

Essa ferramenta comprime novamente os dados de vídeo para laserdisc e
VHS.


.. _mame-othertools-ldverify:

ldverify
--------

Essa ferramente é usada para comparar imagens de laserdisc ou VHS CHD
vinda de uma fonte AVI.


.. _mame-othertools-romcmp:

romcmp
------

Esta ferramenta é utilizada para realizar comparações de dados básicos e
verificações de integridade em "*dumps*" binários. Com a opção -h, ela
também pode ser utilizada para calcular as funções de "*hash*".


.. _mame-othertools-unidasm:

unidasm
-------

Disassembler universal para muitas das arquiteturas compatíveis com o
MAME.


