Múltiplos arquivos de configuração
==================================

O MAME tem um poderoso sistema de configuração que permite ajustar as
opções de cada jogo, sistema ou até mesmo um tipo de monitor em
específico de maneira individual, porém requer um cuidado especial na
organização das configurações.

.. _advanced-multi-CFG:

A ordem da leitura dos arquivos
-------------------------------

1.		Inicialmente a linha de comando é interpretada primeiro, depois
		as configurações que *terão prioridade sobre qualquer outra
		opção que esteja no arquivo *.ini*.

2.		O ``mame.ini`` (ou qualquer outra plataforma que use um *.ini*
		como o ``mess.ini`` por exemplo) são interpretadas duas vezes.
		Na primeira passada pode alterar várias configurações de
		caminho, a segunda passagem é feita para ver se há um arquivo de
		configuração válido nesse novo local (caso haja, altera as
		configurações com as informações desse arquivo).
		E o ``debug.ini`` se estiver no modo de depuração.
		Este é um arquivo de configuração avançado que a maioria das
		pessoas não precisam sequer se preocupar com ele.

4.		Quando for apropriado, os arquivos *ini* específicos voltado para
		um sistema como ``neogeo_noslot.ini`` ou ``cps2.ini`` por
		exemplo.
		O jogo **Street Fighter Alpha** é um jogo do sistema CPS2, então
		o arquivo ``cps2.ini`` será lido duas vezes.

5.		Arquivo INI de orientação do monitor (seja ``horizont.ini`` ou
		``vertical.ini``).
		O jogo Pac-Man por exemplo, usa uma configuração de monitor
		vertical, então ele leria o arquivo ``vertical.ini``.
		Já o jogo **Street Fighter Alpha** é um jogo com tela
		horizontal, então leria o arquivo ``horizont.ini``.

6.		Arquivos INI voltado para diferentes sistemas (``arcade.ini``,
		``console.ini``, ``computer.ini``, ou ``othersys.ini``).
		Tanto o jogo **Pac-Man** quanto o jogo **Street Fighter Alpha**
		são jogos de arcade, então o arquivo a ser lido seria o
		``arcade.ini``.
		Já no caso de um console como o **Atari 2600**, o arquivo a ser
		lido seria o ``console.ini``.

7.		Os arquivos INI voltados para diferentes tipos de tela
		(``vector.ini`` para jogos vetoriais, ``raster.ini`` para jogos
		rasterizados, ``lcd.ini`` para jogos em LCD).
		Ambos os jogos **Pac-Man** e **Street Fighter Alpha** são jogos
		rasterizados, então o arquivo a ser lido seria o ``raster.ini``.
		Tempest é um jogo que usa uma tela com vetores, então o arquivo
		a ser lido seria o ``vector.ini``.

8.		Os Arquivos *.ini* do código fonte.
		Este também é um arquivo de configuração avançado, a maioria das
		pessoas não precisam usá-lo para nada.
		O MAME tentará ler os arquivos ``source/sourcefile.ini`` e
		``sourcefile.ini`` onde o *sourcefile* é o nome real do arquivo
		de código-fonte.
		O **mame -listsource <game>** mostrará o arquivo de código-fonte
		para um determinado nome.
		Por exemplo, o jogo **Sailor Moon** da Banpresto, **Dodonpachi**
		da Atlus e **Dangun Feveron** da Nihon System compartilham uma
		grande quantidade de hardware compatíveis entre si e são
		agrupados em um único arquivo **cave.c**, o que significa que
		todos eles interpretarão o arquivo ``source/cave.ini``.

9.		O arquivo *.ini* Pai.
		Se rodar o jogo **Pac-Man** por exemplo, que é um clone do jogo
		**Puck-Man**, seria então o arquivo ``puckman.ini``.

10.		O arquivo *.ini* de Driver.
		Usando o nosso exemplo anterior do Pac-Man, isso seria um
		arquivo chamado ``pacman.ini``.

Exemplos da sequência de leitura dos arquivos
---------------------------------------------

	O jogo **Alcon**, que é um clone Americano do jogo **Slap Fight**
	(**mame alcon**):

	* ``mame.ini``, ``vertical.ini``, ``arcade.ini``, ``raster.ini``,
	  ``slapfght.ini`` e por último ``alcon.ini``.

	O jogo **Super Street Fighter 2 Turbo** (**mame ssf2t**):

	* ``mame.ini``, ``horizont.ini``, ``arcade.ini``, ``raster.ini``,
	  ``cps2.ini`` e por último ``ssf2t.ini``

	Lembre-se que os parâmetros na linha de comando tem preferência
	sobre todos os outros arquivos!

Truques para tornar a vida mais fácil
-------------------------------------

Alguns usuários podem ter um monitor montado na parede ou um monitor
rotativo, e podem querer realmente jogar jogos verticais com a tela
girada na vertical. A maneira mais fácil de fazer isso é colocar as suas
configurações de rotação no arquivo ``vertical.ini``, onde afetaria
apenas os jogos verticais.

[a fazer: mais exemplos práticos]
