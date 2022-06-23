.. raw:: latex

	\clearpage

.. _advanced-slowmomame:

MAME em câmera lenta
====================

O **Slow Motion Mame** ou **slowmomame** é uma condição em que o tempo 
de emulação do MAME seja atrasado de forma que este fique em câmera
lenta, fazendo com que a emulação passe a trabalhar quase que quadro a
quadro. A utilidade do slowmomame é voltada para exibição de jogadas
mais arriscadas, tomadas de decisão rápidas uma vez que a emulação está
em câmera lenta o usuário tem tempo de sobra para reagir a tiros, golpes
e sistemas no estilo BEMANI da Konami.

Neste modo e dependendo do sistema, o jogador leva em média cerca de 1
hora para concluir uma única fase, no entanto, o resultado final de todo
este esforço é `uma jogabilidade perfeita
<https://www.youtube.com/watch?v=LzUDlJtyEkA>`_.

Abordaremos agora como atrasar o tempo de emulação do MAME para que essa
condição seja atingida, uma delas é editando o código fonte, a segunda
maneira é utilizando uma interface lenta e a última é através de
configuração usando a opção :ref:`-speed <mame-commandline-speed>`.

Alterando o código fonte
~~~~~~~~~~~~~~~~~~~~~~~~

Antes de prosseguir é importante que saiba como :ref:`compilar o MAME
<compiling-MAME>`, com um editor de texto abra o arquivo
``src/emu/sound.cpp`` e procure pela linha: ::

	#define VERBOSE         (0)

Altere o valor de **0** para **1** e adicione a opção ``DEBUG=1`` às
suas opções de compilação ou ao seu arquivo ``useroptions.mak`` e inicie
a compilação. Geralmente não há a necessidade de se compilar todo o
código fonte do MAME com essas alterações pois como já sabemos o MAME
abrange muito mais do que sistemas arcade e consoles. Prefira usar a
opção ``SUBTARGET=arcade`` para compilar apenas os sistemas arcades ou
então defina apenas o driver do sistema que deseja usar com o comando
``SOURCES=caminho do driver``.

Por exemplo, caso queira saber qual a ROM responsável pelo sistema
**DDR Max - Dance Dance Revolution 6th Mix** use o comando: ::

	mame "DDR Max"
	ddrmax            DDR Max - Dance Dance Revolution 6th Mix (G*B19 VER. JAA)    (Konami, 2001)

Com o nome da ROM em mãos, **ddrmax**, podemos descobrir qual o driver
responsável por ele usando o comando
:ref:`-listsource / -ls <mame-commandline-listsource>`, exemplo: ::

	mame -ls ddrmax
	ddrmax           ksys573.cpp

Com o nome do driver em mãos, use-o com com a opção ``SOURCES``, como
por exemplo, ``SOURCES=src/mame/drivers/ksys573.cpp`` ou
``SOURCES=src\mame\drivers\ksys573.cpp`` caso esteja usando o Windows.

Abaixo uma sugestão de linha de comando para a compilação do MAME: ::

	make SUBTARGET=arcade DEBUG=1 -j5

Ou usando **SOURCES**: ::

	make SOURCES=src/mame/drivers/ksys573.cpp DEBUG=1 -j5

Ao final da compilação renomeie o executável e se for o caso, o
respectivo arquivo ***.syn**, para um outro nome qualquer como
**slowmo** por exemplo. Para rodar um sistema enquanto grava, use o
comando::

	slowmo ddrmax -aviwrite ddrmax.avi

Repare que o terminal será inundado com mensagens de depuração sempre
que houver som, isso deixa o MAME tão ocupado que o sistema passa a
rodar quadro a quadro na tela ao mesmo tempo que toda a ação, áudio e
vídeo é gravado no arquivo **ddrmax.avi** dentro do diretório **snap**.

Usando uma interface lenta
~~~~~~~~~~~~~~~~~~~~~~~~~~

Diferente do capítulo anterior, neste caso não há a necessidade de
recompilar o MAME, abra o seu ``mame.ini`` e altere o caminho do
**snapshot_directory** para um driver lento, como um HDD externo via
**USB1**, um leitor de cartão lento e assim por diante. Devido a
lentidão do destino, o MAME ficará ocupado esperando a gravação do
arquivo ***.avi** resultando num gameplay em câmera lenta.

Usando a opção speed
~~~~~~~~~~~~~~~~~~~~

Aqui também não há a necessidade de recompilar o MAME, porém se consegue
no máximo uma redução de velocidade em torno de 10 fps e não é possível
gravar um arquivo ***.avi** durante o gameplay sendo necessário que se
jogue uma vez e só depois seja possível a gravação do ***.avi**.

Execute o sistema com o comando: ::

	mame -speed 0.2 -rec dance.inp -sound none ddrmax

Neste estágio o som não é necessário pois estamos gravando apenas os
comandos, ao terminar pressione **ESQ** para encerrar a emulação e
gravar o arquivo ``dance.inp``, agora execute o comando abaixo: ::

	mame -pb dance.inp -aviwrite ddrmax.avi ddrmax

O MAME executará todos os comandos gravados em ``dance.inp`` ao mesmo
tempo em que grava o vídeo. A jogabilidade não chega a ser tão precisa,
mas nada que uma pouco de prática não resolva. Nos links abaixo é
possível ver uma pequena demonstração de como fica a jogabilidade usando
a opção ``-speed``.

|	https://www.youtube.com/watch?v=JaX2EYJKiJA
|	https://www.youtube.com/watch?v=6HSrrd1Vf2M
|	https://www.youtube.com/watch?v=MxktlN9moGs
|

Para os mais interessados, recomendo a pesquisa do termo
`TAS <http://tasvideos.org/>`_ no YouTube.
