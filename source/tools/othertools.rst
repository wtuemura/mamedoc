Outras ferramentas que acompanham o MAME
========================================


ledutil.exe/ledutil.sh
----------------------

No Microsoft Windows o ledutil.exe pode ser usado para controlar as luzes
led do seu teclado para espelhar aquelas luzes presentes nos primeiros
jogos de arcade como o Asteroids por exemplo.

Para ativar essa funcionalidade inicie o **ledutil.exe** da linha de
comando. Rode o comando **ledutil.exe -kill** para interrompê-lo.

Nas plataformas SDLMAME como o Mac OS X e Linux, o **ledutil.sh** poderá
ser usado. Use o comando **ledutil.sh -a** para que ele seja fechado
automaticamente ao sair do SDLMAME.


Ferramentas voltadas ao desenvolvimento 
=======================================


pngcmp
------

Essa ferramenta é usada em teste de regressão ao comparar instantâneos
PNG vindos de um script teste **runtest.cmd** encontrado nos arquivos de
código fonte. Esse script só funciona no Windows.


nltool
------

Componente de conversão discreto. A maioria dos usuários não precisam
lidar com ele. 

nlwav
-----

Componente discreto de conversão e ferramente de teste. A maioria dos
usuários não precisam lidar com ele. 


jedutil
-------

Ferramenta útil para extração de **PAL**/**PLA**/**PLD**/**GAL**.
Ele pode converter entre o formato JED padrão da indústria e o formato
binário compactado proprietário do MAME, pode mostrar também equações
lógicas para os tipos de dispositivos que conhecem tal lógica interna.
A maioria dos usuários não precisam lidar com ele. 


ldresample
----------

Essa ferramenta comprime novamente os dados de vídeo para laserdisc e
VHS. A maioria dos usuários não precisam lidar com ele. 


ldverify
--------

Essa ferramente é usada para comparar imagens de laserdisc ou VHS CHD
vinda de uma fonte AVI. A maioria dos usuários não precisam lidar com
ele. 

unidasm
-------

Disassembler universal para muitas das arquiteturas compatíveis com o
MAME. A maioria dos usuários não precisam lidar com ele. 