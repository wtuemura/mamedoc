Múltiplos arquivos de configuração
==================================

O MAME tem um poderoso sistema de configuração que permite ajustar as
opções de cada jogo, sistema ou até mesmo um tipo de monitor em
específico de maneira individual, porém requer um cuidado especial na
organização das configurações.

.. _advanced-multi-CFG:


A ordem de leitura dos arquivos
-------------------------------

1.		Inicialmente a linha de comando é interpretada primeiro, depois
		as configurações que *terão prioridade sobre qualquer outra
		opção que esteja no arquivo .INI*.

2.		O **MAME.INI** (ou qualquer outra plataforma que use um .INI
		como o **MESS.INI** por exemplo) são interpretadas duas vezes.
		Na primeira passada pode alterar várias configurações de
		caminho, a segunda passagem é feita para ver se há um arquivo de
		configuração válido nesse novo local (caso haja, altera as
		configurações com as informações desse arquivo).
		E o **DEBUG.INI** se estiver no modo de depuração.
		Este é um arquivo de configuração avançado que a maioria das
		pessoas não precisam sequer se preocupar com ele.

4.		Quando for apropriado, os arquivos INI específicos voltado para
		um sistema como **NEOGEO_NOSLOT.INI** ou **CPS2.INI** por
		exemplo.
		O jogo **Street Fighter Alpha** é um jogo do sistema CPS2, então
		o arquivo **CPS2.INI** será lido duas vezes.

5.		Arquivo INI de orientação do monitor (seja **HORIZONT.INI** ou
		**VERTICAL.INI**).
		O jogo Pac-Man por exemplo, usa uma configuração de monitor
		vertical, então ele leria o arquivo **VERTICAL.INI**.
		Já o jogo **Street Fighter Alpha** é um jogo com tela
		horizontal, então leria o arquivo **HORIZONT.INI**.

6.		Arquivos INI voltado para diferentes sistemas (**ARCADE.INI**,
		**CONSOLE.INI**, **COMPUTER.INI**, ou **OTHERSYS.INI**).
		Tanto o jogo **Pac-Man** quanto o jogo **Street Fighter Alpha**
		são jogos de arcade, então o arquivo a ser lido seria o
		**ARCADE.INI**.
		Já no caso de um console como o **Atari 2600**, o arquivo a ser
		lido seria o **CONSOLE.INI**.

7.		Os arquivos INI voltados para diferentes tipos de tela
		(**VECTOR.INI** para jogos vetoriais, **RASTER.INI** para jogos
		rasterizados, **LCD.INI** para jogos em LCD).
		Ambos os jogos **Pac-Man** e **Street Fighter Alpha** são jogos
		rasterizados, então o arquivo a ser lido seria o **RASTER.INI**.
		Tempest é um jogo que usa uma tela com vetores, então o arquivo
		a ser lido seria o **VECTOR.INI**.

8.		Os Arquivos INI do Códico Fonte.
		Este também é um arquivo de configuração avançado, a maioria das
		pessoas não precisam usá-lo para nada.
		O MAME tentará ler os arquivos **SOURCE/SOURCEFILE.INI** e
		**SOURCEFILE.INI** onde o sourcefile é o nome real do arquivo de
		código-fonte.
		O **mame -listsource <game>** mostrará o arquivo de código-fonte
		para um determinado nome.
		Por exemplo, o jogo **Sailor Moon** da Banpresto, **Dodonpachi**
		da Atlus e **Dangun Feveron** da Nihon System compartilham uma
		grande quantidade de hardware compatíveis entre si e são
		agrupados em um único arquivo **CAVE.C**, o que significa que
		todos eles interpretarão o arquivo **source/cave.ini**.

9.		O arquivo INI Pai.
		Se rodar o jogo **Pac-Man** por exemplo, que é um clone do jogo
		**Puck-Man**, seria então o arquivo **PUCKMAN.INI**.

10.		O arquivo INI de Driver.
		Usando o nosso exemplo anterior do Pac-Man, isso seria um
		arquivo chamado **PACMAN.INI**.


Exemplos da sequência de leitura dos arquivos
---------------------------------------------

1.		O jogo **Alcon**, que é um clone Americano do jogo
		**Slap Fight**.  (**mame alcon**)
		Linha de comando, **MAME.INI**, **VERTICAL.INI**,
		**ARCADE.INI**, **RASTER.INI**, **SLAPFGHT.INI**, e por último
		**ALCON.INI**
		(*lembre-se que os parâmetros na linha de comando tem
		preferência sobre todos os outros arquivos!*)

2.		O jogo **Super Street Fighter 2 Turbo** (**mame ssf2t**)
		Linha de comando, **MAME.INI**, **HORIZONT.INI**,
		**ARCADE.INI**, **RASTER.INI**, **CPS2.INI**, e por último
		**SSF2T.INI**
		(*lembre-se que os parâmetros na linha de comando tem
		preferência sobre todos os outros arquivos!*)


Truques para tornar a vida mais fácil
-------------------------------------

Alguns usuários podem ter um monitor montado na parede ou um monitor
rotativo, e podem querer realmente jogar jogos verticais com a tela
girada na vertical. A maneira mais fácil de fazer isso é colocar as suas
configurações de rotação no arquivo **VERTICAL.INI**, onde afetaria
apenas os jogos verticais.

[a fazer: mais exemplos práticos]
