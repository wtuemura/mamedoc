.. raw:: latex

	\clearpage

.. _mame-crosscompilation:

Compilação cruzada
==================

Definição
~~~~~~~~~

A compilação cruzada [1]_ é o processo de compilar um executável em uma
plataforma diferente daquela para a qual ele se destina. A seguir,
veremos como usar o ambiente Linux para compilar um programa que rode no
Windows, Mac ou qualquer outra plataforma compatível com o MAME. Nas
instruções a seguir, configuraremos um ambiente de compilação cruzada no
Linux para compilar uma versão do MAME voltada para o Microsoft Windows.
Apesar de o processo a seguir ser voltado para o Windows, ele pode
servir também de modelo para compilar o MAME em outras plataformas
compatíveis.


Vantagens
~~~~~~~~~

Dentre as várias vantagens é possível citar as mais relevantes:

* Transformar o código-fonte em linguagem de máquina consome muitos
  recursos, e a plataforma de destino geralmente não tem todos os
  recursos disponíveis no computador usado para compilar, como poder de
  processamento e memória;
* Ainda que o mesmo computador com dois sistemas operacionais
  instalados, como Linux e Windows, seja utilizado, o tempo gasto para
  compilar uma versão do MAME para Linux é muito menor do que para
  compilar a mesma versão no Windows. Compilar uma versão do MAME para
  o Linux leva cerca de 30 minutos, podendo variar para mais ou para
  menos, dependendo do poder de processamento do computador. Compilando
  o mesmo código-fonte no mesmo hardware, com o Windows, usando a mesma
  versão do GCC e G++, a tarefa pode levar algumas horas [2]_.
* Com a compilação cruzada, o tempo final de compilação é
  aproximadamente o mesmo da versão nativa do Linux, economizando tempo
  e recursos. Manter o processador a 100% compilando o código-fonte por
  cerca de 30 minutos é uma coisa; fazer exatamente a mesma coisa por
  algumas horas a mais é uma perda de tempo e pode encarecer a conta de
  energia no final do mês.
* Assim, o principal motivo para adotar a compilação cruzada é a
  economia de tempo e recursos.


Preparando o ambiente
---------------------

Neste exemplo, a plataforma utilizada foi o Debian, mas pode ser
qualquer outra. A vantagem do Debian é que se trata de uma distribuição
muito estável do sistema operacional Linux. Por esse motivo, o Debian
não utiliza a última versão de nenhum software, como o GCC, por exemplo.
Geralmente, ele fica algumas versões atrás do último lançamento
encontrado na internet, pois o foco é a estabilidade, e não empacotar a
última versão de qualquer software.

Para compilar binários voltados ao sistema Windows, precisamos instalar
os pacotes abaixo. Para outros sistemas operacionais ou dispositivos, o
procedimento será semelhante, desde que sejam escolhidos os conjuntos de
pacotes apropriados para a plataforma desejada.


.. raw:: latex

	\clearpage


Debian e Ubuntu
---------------

O comando a seguir instalara ferramentas adicionais, além das descritas
na seção :ref:`compiling-ubuntu`. Note que o comando a seguir é formado
por uma linha só:

.. code-block:: shell

	sudo apt install g++-mingw-w64-x86-64-posix
	gcc-mingw-w64-x86-64-posix
	gcc-mingw-w64-x86-64-posix-runtime
	gobjc++-mingw-w64-x86-64-posix
	gobjc-mingw-w64-x86-64-posix
	binutils-mingw-w64-x86-64
	mingw-w64-common mingw-w64-tools mingw-w64-x86-64-dev

Como estamos fazendo uma compilação entre plataformas, é necessário
usar a versão POSIX para o **gcc**, **ar** e **g++**. O POSIX vem de
*Interface Portável entre Sistemas Operacionais*, regida pela
norma `IEEE 1003 <https://standards.ieee.org/standard/1003_1-2017.html>`_ [3]_.
Para configurar os atalhos do **gcc**, **ar** e **g++**, faça os
comandos a seguir no terminal, note que **cada** comando *sudo* ocupa
uma linha inteira:

.. code-block:: shell

	sudo ln -s /usr/bin/x86_64-w64-mingw32-g++-posix /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-g++
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc-ar-posix /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc-ar
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc-posix /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc

.. warning:: Não é mais possível compilar uma versão de 32 bits do MAME.


Fedora Linux
------------

Instale os seguintes pacotes:

.. code-block:: shell

	sudo dnf install mingw64-binutils mingw64-cpp mingw64-gcc mingw64-gcc-c++ mingw64-gcc-objc mingw64-gcc-objc++  mingw64-fontconfig mingw64-win-iconv mingw64-winpthreads mingw64-winpthreads-static

Seguido dos comandos abaixo:

.. code-block:: shell

	sudo ln -s /usr/bin/x86_64-w64-mingw32-g++ /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-g++
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc-ar /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc-ar
	sudo ln -s /usr/bin/x86_64-w64-mingw32-gcc /usr/x86_64-w64-mingw32/bin/x86_64-w64-mingw32-gcc

.. raw:: latex

	\clearpage

Configurando as variáveis de ambiente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A variável **MINGW64** é necessária para que os scripts utilizados na
compilação do MAME saibam onde encontrá-los. O comando abaixo **não
deve** ser executado com o **sudo**, pois nosso objetivo é aplicá-lo no
ambiente da nossa conta comum, e não em uma conta com privilégios de
administrador:

.. code-block:: shell

	echo "export MINGW64="/usr/x86_64-w64-mingw32"" >> ~/.bashrc

Recarregue as configurações do seu terminal com o comando ``. .bashrc``
ou saia e retorne à sua conta. É necessário verificar a configuração
para ter certeza de que a variável esteja definida corretamente no
ambiente, executando o comando a seguir:

.. code-block:: shell

	$ echo $MINGW64
	/usr/x86_64-w64-mingw32

Se o seu ambiente não retornar nada, verifique se as instruções acima
foram seguidas corretamente. Se a sua distribuição Linux — ou outra
distribuição — utilizar o arquivo ``.bashrc``, verifique no manual da
sua distribuição de qual arquivo de configuração ela utiliza para
armazenar as variáveis do ambiente e onde ele se localiza.


Compilando o MAME para Windows no Linux
---------------------------------------

Para iniciar a compilação do MAME para o **Windows**, execute o comando
a seguir, lembrando que ele deve ser executado dentro da pasta raiz [4]_
do código-fonte do MAME:

.. code-block:: shell

	make clean && make TARGETOS=windows CROSS_BUILD=1 SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1

Assim como na compilação nativa, é possível adicionar a opção **-j** no
final do comando para acelerar o processo de compilação usando os
núcleos do seu processador, conforme explicado com mais detalhes no
capítulo :ref:`compiling-mame`:

.. code-block:: shell

	make clean && make TARGETOS=windows CROSS_BUILD=1 SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1 -j5

.. raw:: latex

	\clearpage

Compilando o MAME SDL para Windows no Linux
-------------------------------------------

Para compilar uma versão SDL do MAME instale os pacotes descritos no
capítulo :ref:`compiling-ubuntu`.

Debian e Ubuntu
---------------

Infelizmente, será necessário compilar esses pacotes manualmente, e não
abordaremos esse assunto aqui. Porém, lembre-se de que é possível
compilar essa versão do MAME SDL usando o :ref:`MINGW no Windows
<compiling-msys2-osd-sdl>`!

Adicione a opção ``OSD=sdl`` na sua linha de comando, exemplo:

.. code-block:: shell

	make clean && make OSD=sdl TARGETOS=windows CROSS_BUILD=1 SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 -j5

Ao final da compilação será gerado um arquivo **sdlmame.exe**.

Fedora Linux
------------

Instale os pacotes a seguir:

.. code-block:: shell

	sudo dnf install mingw64-SDL2_ttf mingw64-SDL2 mingw64-SDL2-static

Use a opção ``OSD=sdl`` como mostra o exemplo a seguir:

.. code-block:: shell

	make clean && make TARGETOS=windows CROSS_BUILD=1 OSD=sdl SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1 -j5

O processo de compilação será concluído com a criação de um arquivo
chamado **sdlmame.exe**.


.. [1]	Cross compiling no Inglês. (Nota do tradutor)
.. [2]	Todo o processo no meu computador leva cerca de 4 horas, AMD FX
		tm-8350, 16GiB de memória DDR3. (Nota do tradutor)
.. [3]	IEEE é conhecido no Brasil como `Instituto de Engenheiros
		Eletricistas e Eletrônicos <https://pt.wikipedia.org/wiki/Instituto_de_Engenheiros_Eletricistas_e_Eletrônicos>`_. (Nota do tradutor)
.. [4]	Fica no mesmo diretório onde existe um arquivo chamado
		**makefile**. (Nota do tradutor)
