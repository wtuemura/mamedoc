.. raw:: latex

	\clearpage

.. _mame-crosscompilation:

Compilação cruzada
==================

Definição
---------

Compilação cruzada [1]_ é o processo de poder compilar um executável
numa plataforma diferente da qual ela se destina. Como usar o ambiente
Linux para compilar um programa que rode no Windows, Mac ou qualquer
outra plataforma compatível com o MAME.
Nas instruções a seguir iremos  configurar um ambiente de compilação
cruzada numa plataforma Linux para compilar uma versão do MAME voltada
para o Microsoft Windows, apesar do processo abaixo ser voltado para
Windows, ele pode servir também de modelo para compilar o MAME em outras
plataformas compatíveis além do Windows.

Vantagens
---------

Dentre as várias vantagens é possível citar as mais relevantes:

*	Transformar o código fonte em linguagem de máquina consome muitos
	recursos e em geral a plataforma de destino pode não ter todos os
	recursos disponíveis em comparação com computador que está sendo
	usando para compilar, como por exemplo, poder de processamento,
	memória, etc.

*	Ainda que seja utilizado o mesmo computador com dois sistemas
	operacionais instalados como o Linux e o Windows, o tempo gasto para
	compilar uma versão do MAME para o Linux é muito menor do que
	compilar a mesma versão no Windows. Compilar uma versão do MAME para
	Linux leva em torno de 30 minutos para mais ou para menos dependendo
	do poder de processamento do seu computador, compilando o mesmo
	código fonte na mesma máquina, com o Windows, usando a mesma versão
	do *gcc* e *g++*, a tarefa pode levar algumas *horas* [2]_ ainda que
	tenha um computador mais recente.

*	Ao utilizar o processo de compilação cruzada, o tempo final de
	compilação leva aproximadamente o mesmo tempo que a versão nativa do
	Linux, ganhando tempo e economizando recursos, afinal de contas,
	manter o processador a 100% compilando o código fonte por cerca de
	30 minutos é uma coisa, fazer exatamente a mesma coisa gastando
	algumas horas além de ser uma perda de tempo, a sua conta de energia
	pode ficar um pouco mais cara no final do mês.

*	Assim, o motivo principal para adotar a compilação cruzada é a
	economia de tempo e recursos.

Preparando o ambiente
---------------------

A plataforma usada neste exemplo foi o *Debian 9*, porém pode ser
qualquer outro, a vantagem do Debian é que ela é uma distribuição muito
estável do sistema operacional Linux, por causa disso, o Debian não
utiliza a última versão de nenhum software como o gcc por exemplo.
Geralmente ela fica alguma versões para trás do último lançamento
encontrado na internet pois o foco é a estabilidade ao invés de
empacotar a última versão do que quer que seja.

Precisamos instalar os pacotes abaixo para compilar binários voltados ao
sistema Windows, para outros sistemas operacionais ou dispositivos, o
procedimento será semelhante contanto que seja escolhido o conjuntos de
pacotes apropriados para a plataforma desejada.

.. raw:: latex

	\clearpage

Debian e Ubuntu
~~~~~~~~~~~~~~~

O comando abaixo vai instalar ferramentas adicionais além das quais já
foram descritas na seção :ref:`compiling-ubuntu`, note que o
comando abaixo é formado por uma linha só: ::

	sudo aptitude install binutils-mingw-w64-x86-64 g++-mingw-w64 g++-mingw-w64-x86-64 gcc-mingw-w64 gcc-mingw-w64-base gcc-mingw-w64-x86-64 gobjc++-mingw-w64 mingw-w64 mingw-w64-common mingw-w64-tools mingw-w64-x86-64-dev win-iconv-mingw-w64-dev

.. note::

	No Debian 11 (e talvez mais recentes) não é preciso instalar o
	pacote ``win-iconv-mingw-w64-dev``.

Como estamos fazendo uma compilação entre plataformas é necessário
usar a versão POSIX para o **gcc**, **ar** e **g++**, o POSIX vem de
*Interface Portável entre Sistemas Operacionais* que é regida pela
norma `IEEE 1003 <https://standards.ieee.org/standard/1003_1-2017.html>`_ [3]_.
Para configurar os atalhos do **gcc**, **ar** e **g++** voltado para
a criação de binários para a plataforma **64-bit** faça os comandos
abaixo no terminal, note que **cada** comando *sudo* é formado por uma
linha só: ::

	sudo ln -s /usr/bin/x86_64-w64-mingw32-g++-posix /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-g++
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc-ar-posix /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc-ar
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc-posix /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc

Já para a plataforma **32-bit** faremos estes comandos, note que
**cada** comando *sudo* é formado por uma linha só: ::

	sudo ln -s /usr/bin/i686-w64-mingw32-g++-posix /usr/i686-w64-mingw32/bin/i686-w64-mingw32-g++
	sudo ln -s /usr/bin/i686-w64-mingw32-gcc-ar-posix /usr/i686-w64-mingw32/bin/i686-w64-mingw32-gcc-ar
	sudo ln -s /usr/bin/i686-w64-mingw32-gcc-6.3-posix /usr/i686-w64-mingw32/bin/i686-w64-mingw32-gcc

Fedora Linux
~~~~~~~~~~~~

Instale os seguintes pacotes: ::

	sudo dnf install mingw64-binutils mingw64-cpp mingw64-gcc mingw64-gcc-c++ mingw64-gcc-objc mingw64-gcc-objc++  mingw64-fontconfig mingw64-win-iconv mingw64-winpthreads mingw64-winpthreads-static

Seguido dos comandos abaixo: ::

	sudo ln -s /usr/bin/x86_64-w64-mingw32-g++ /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-g++
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc-ar /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc-ar
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc

.. raw:: latex

	\clearpage

Configurando as variáveis de ambiente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As variáveis **MINGW64** e **MINGW32** são necessárias para que os
scripts usados para a compilação do MAME saibam onde encontrá-los.
**Não use sudo** para o comando abaixo pois queremos aplicá-las nas
variáveis de ambiente da nossa conta comum e não numa conta com
poderes administrativos::

	echo "export MINGW64="/usr/x86_64-w64-mingw32"" >> ~/.bashrc
	echo "export MINGW32="/usr/i686-w64-mingw32"" >> ~/.bashrc

Recarregue as configurações do seu terminal com o comando ``. .bashrc``
(ponto, espaço, ponto bashrc) ou saia e retorne à sua conta. É
necessário aferir a configuração para que se tenha certeza de que as
variáveis estão definidas no ambiente corretamente fazendo o comando
abaixo::

	$ echo $MINGW64 && echo $MINGW32
	/usr/x86_64-w64-mingw32
	/usr/i686-w64-mingw32

Caso o seu ambiente não tenha retornado nada, tenha certeza de que as
instruções acima foram seguidas corretamente, se a sua distribuição
Linux - ou outra distribuição - utiliza o arquivo ``.bashrc``, caso não
utilize, verifique no manual da sua distribuição qual arquivo de
configuração ela utiliza para armazenar as variáveis do ambiente e onde
ele se localiza.

Compilando o MAME para Windows no Linux
---------------------------------------

Para compilar uma versão *64-bit* do MAME para o **Windows**, execute o
comando abaixo, lembrando que o comando deve ser executado de dentro da
pasta raiz [4]_ do código fonte do MAME: ::

	make clean && make TARGETOS=windows CROSS_BUILD=1 SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1

Para compilar uma versão *32-bit* do MAME faça o comando abaixo: ::

	make clean && make TARGETOS=windows CROSS_BUILD=1 SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1

Assim como na compilação nativa, é possível adicionar a opção **-j** no
final do comando visando acelerar o processo de compilação usando os
núcleos do seu processador como já foi explicado com mais detalhes no
capítulo :ref:`compiling-mame`: ::

	make clean && make TARGETOS=windows CROSS_BUILD=1 SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1 -j5

.. raw:: latex

	\clearpage

Compilando o MAME SDL para Windows no Linux
-------------------------------------------

Caso queira compilar uma versão SDL do MAME instale as estes pacotes
mingw do SDL2, ``SDL2-static``, ``SDL2_ttf`` e ``SDL2``.

Debian e Ubuntu
~~~~~~~~~~~~~~~

Infelizmente será necessário compilar estes pacotes manualmente e no
momento não iremos cobrir este assunto aqui porém lembre-se que é
possível compilar esta versão do MAME SDL usando o :ref:`MINGW no Windows
<compiling-msys2-osd-sdl>`!

Basta compilar usando a opção ``OSD=sdl`` na sua linha de comando,
exemplo: ::

	make clean && make OSD=sdl SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 -j5

Ao final da compilação será gerado um arquivo **sdlmame.exe**.

Fedora Linux
~~~~~~~~~~~~

::

	sudo dnf install mingw64-SDL2_ttf mingw64-SDL2 mingw64-SDL2-static

Agora use a opção ``OSD=sdl`` como mostra o exemplo abaixo para versões
32-bit: ::

	make clean && make TARGETOS=windows CROSS_BUILD=1 OSD=sdl SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 -j5

Para versões 64-bit: ::

	make clean && make TARGETOS=windows CROSS_BUILD=1 OSD=sdl SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1 -j5

Ao final da compilação será gerado um arquivo **sdlmame.exe**.

.. [1]	Cross compiling no Inglês. (Nota do tradutor)
.. [2]	Todo o processo no meu computador leva cerca de 4 horas, AMD FX
		tm-8350, 16GiB de memória DDR3. (Nota do tradutor)
.. [3]	IEEE é conhecido no Brasil como `Instituto de Engenheiros
		Eletricistas e Eletrônicos <https://pt.wikipedia.org/wiki/Instituto_de_Engenheiros_Eletricistas_e_Eletrônicos>`_. (Nota do tradutor)
.. [4]	Fica no mesmo diretório onde existe um arquivo chamado
		**makefile**. (Nota do tradutor)
