.. Quebra de página para separar o capítulo dos anteriores (PDF)
.. raw:: latex

	\clearpage

.. _compiling-MAME:

Compilando o MAME
=================

.. contents:: :local:

.. raw:: latex

	\clearpage


Primeiros passos
~~~~~~~~~~~~~~~~

Se você nunca compilou o MAME antes, não sabe por onde começar e está
completamente perdido, este documento o ajudará com o mínimo necessário
para ter sucesso em sua primeira compilação.

Antes, porém, alguns pontos importantes:

* É necessário um compilador C++20 e suas respectivas bibliotecas. Para
  o GCC, a versão mínima aceitável é a 11 ou uma mais recente. Já o
  Clang requer a versão 13 ou superior. O executável do MAME funcionará
  com as bibliotecas GNU libstdc++ e libc++, ambas na versão 11 ou
  superior. Deve-se evitar a versão inicial de qualquer grande
  lançamento do GCC. Se você quiser compilar o MAME com o GCC 12, por
  exemplo, prefira utilizar a versão 12.1 ou mais recente.
* A versão nativa do MAME roda no Windows; portanto, a compilação nesse
  sistema operacional receberá grande ênfase.
* O Git é a melhor maneira de baixar o código-fonte do MAME e mantê-lo
  atualizado. Antigamente, era necessário baixar o código-fonte do site
  oficial e aplicar dezenas de correções para atualizá-lo e corrigi-lo.
  Se aplicadas fora da ordem correta, essas correções geravam outros
  problemas.
  
  Hoje, o processo é automatizado pelo Git: um simples comando faz com
  que todo o código-fonte seja baixado e todas as alterações feitas no
  código sejam aplicadas de maneira organizada e controlada.

  Cada nova modificação enviada ao código-fonte do MAME e autorizada
  pelos administradores é contabilizada como um commit por envio.
* Para clonar o código fonte do MAME use o comando:

	.. code-block:: shell

		git clone https://github.com/mamedev/mame.git

  Para baixar uma versão específica de lançamento use o comando:

	.. code-block:: shell

		git checkout mame0287

	.. note:: Ao baixar o código-fonte sem especificar a versão, você
	   baixará uma versão de desenvolvimento. As versões de
	   desenvolvimento podem não compilar e apresentar problemas. Por
	   isso, prefira baixar e compilar as versões de lançamento, a não
	   ser que você saiba o que está fazendo.
	.. tip:: Use o comando a seguir para redefinir o git e baixar as
	   últimas atualizações:

	.. code-block:: shell

		git switch -

* O comando **make** é o mestre de cerimônias: ele repassa todos os
  comandos ou opções que vierem depois dele para o compilador e outras
  ferramentas.
  Digite **make** no diretório raiz onde se encontra o código-fonte do
  MAME para que ele leia as instruções contidas em um arquivo chamado
  **Makefile** e inicie a compilação do MAME. É possível usar outras
  opções para customizar a compilação do MAME e atendê-lo melhor, como
  aproveitar as propriedades do seu processador, entre outras opções que
  serão mostradas mais adiante.

  As opções devem sempre ser adicionadas após o comando make, conforme
  mostrado no exemplo a seguir:

	.. code-block:: shell

		make VERBOSE=1

	.. tip:: Adicione as opções sempre depois do comando **make**.
	   É possível adicionar várias outras opções, desde que estejam
	   separadas por espaços. Abra o arquivo **makefile** em um editor
	   de texto e veja quais opções estão disponíveis.

* Às vezes, o processo de compilação é interrompido antes de terminar
  por diversos motivos, como a falta de alguma biblioteca, um erro de
  configuração ou uma atualização do código-fonte em que algum
  desenvolvedor deixou algo passar despercebido. Esses são problemas
  comuns encontrados durante a compilação do MAME.

  Se o processo parar nos terminais Linux e MSYS2, clique na tecla
  direcional :kbd:`↑` (cima) do teclado para repetir o comando anterior,
  seguido de :kbd:`Enter`. Geralmente a compilação continua sem maiores
  problemas. Porém, se ela parar no mesmo lugar novamente, pode haver
  algum outro problema que exija a intervenção de um desenvolvedor.

  Se não for uma versão de lançamento, não é necessário reportar o erro,
  pois o código-fonte do MAME no GitHub é atualizado constantemente.
  Aguarde algumas horas ou um dia inteiro até que os desenvolvedores
  resolvam o problema.
* Para que o código-fonte do MAME possa ser compilado, é necessária toda
  uma estrutura de configuração completa no momento da execução do
  comando **make**, incluindo diversos outros parâmetros de compilação.
  Sempre que um novo parâmetro for adicionado ou removido ou quando o
  código-fonte de um driver for adicionado, atualizado, renomeado,
  removido, todos os arquivos do projeto responsáveis pela
  compilação devem ser atualizados por meio da opção ``REGENIE=1``.
* Durante o processo de compilação, são gerados arquivos de objeto com
  a extensão ***.o**, arquivos de arquivamento com a extensão ***.a**,
  entre vários outros. É importante executar o comando **make clean**
  sempre que houver uma atualização do código-fonte do MAME com o
  comando **git pull**, ao realizar uma
  :ref:`compilação cruzada <mame-crosscompilation>` ou ao personalizar
  uma compilação.

  Essa opção apaga todo o diretório **build**, que nada mais é do que um
  espaço auxiliar utilizado pelo processo de compilação.

  É possível atualizar o código-fonte com o comando **git pull** seguido
  de **make REGENIE=1** para compilar apenas os novos códigos-fonte
  adicionados ou atualizados e aproveitar os arquivos já compilados.
  Porém, algumas vezes, isso pode causar erros de compilação. Por isso,
  é uma boa prática fazer um **make clean** antes do **make** para
  evitar qualquer resíduo das compilações anteriores.
* Para usar dois comandos em sequência, use o caractere **&&** entre
  os comandos, como mostrado abaixo:

	.. code-block:: shell

		make clean && make <opções> -j5

  
  Dessa forma, o segundo comando será executado apenas quando o primeiro
  terminar. Se a compilação parar devido a algum erro, tente repetir
  apenas o comando **make**.
* As opções usadas pelo **make** podem ser adicionadas a um arquivo
  chamado ``useroptions.mak``. Esse recurso é muito útil quando a lista
  de opções para a compilação é grande e repetitiva. No arquivo, as
  opções são organizadas da seguinte maneira:

	.. code-block:: text

		OPÇÃO1=X
		OPÇÃO2=Y
		OPÇÃO3=Z

  X, Y ou Z são os valores das opções usadas, independentemente para
  cada tipo de opção. Por exemplo, ``SSE2=1`` aproveitará as
  propriedades do seu processador se ele for compatível com as extensões
  SSE2, e assim por diante.
* O MAME vem com algumas ferramentas adicionais que poderão ser úteis
  em algum momento. Se quiser que essas ferramentas também sejam
  compiladas junto com o MAME, adicione a opção ``TOOLS=1``. Para mais
  informações sobre cada uma dessas ferramentas e sobre como usá-las,
  consulte o capítulo :ref:`mame-aditional-tools`.
* Nas versões compiladas do Git, a versão do MAME é acompanhada
  por um identificador único após a versão, por exemplo:

	.. code-block::

		./mame -help
		0.287 (mame0287-82-gcdea363c3ea)

  Onde:
  
	**mame0287** - É a versão do MAME.

	**82** - Indica a quantidade de **commits** ou a quantidade de
	atualizações aplicadas ao código-fonte desde o último lançamento.

	**gcdea363c3ea** - São os 12 primeiros dígitos do último **commit**.

* O Git mantém o controle de todos os arquivos de código-fonte.
  Qualquer alteração não feita pelos administradores incluirá um
  identificador "*dirty*" no final da versão do MAME compilada por você.

	.. code-block::

		./mame -help
		0.287 (mame0287-82-gcdea363c3ea-dirty)

  O problema também ocorre se houver resíduos de compilações anteriores,
  se não for feito um um **make clean** antes de uma nova compilação,
  se houver *arquivos não rastreados*  dentro do diretório de trabalho
  do código-fonte ou se, por algum motivo, os arquivos alterados
  não forem aplicados:

	.. code-block:: shell

		git status --short
		
		M bgfx/shaders/essl/chains/crt-geom/fs_crt-geom-deluxe.bin
		M bgfx/shaders/essl/chains/crt-geom/fs_crt-geom.bin
		...
		?? language/Afrikaans/strings.mo
		?? language/Albanian/strings.mo
		...

  A letra **M** indica que o arquivo foi alterado, e o símbolo **??**
  indica os novos arquivos criados. Independentemente do que tenha
  acontecido, execute o comando ``git commit -a`` para aplicar essas
  alterações.
  
  Ao solicitar o status do Git, ele deve retornar a informação que está
  tudo limpo:

	.. code-block::

		git status
		On branch master
		Your branch is up-to-date with 'origin/master'.
		nothing to commit, working tree clean

  Se não funcionar, execute o comando abaixo com todos os arquivos que
  aparecerem após o comando **git status**, por exemplo:

	.. code-block:: shell

		git checkout 3rdparty/winpcap/Lib/libpacket.a 3rdparty/winpcap/Lib/libwpcap.a

  Seja qual for o motivo, se houver muitos arquivos alterados e
  você não quiser ou não tiver tempo para lidar com eles, experimente o
  comando ``git clean -d -x -f``. Ele **apagará tudo** o que não estiver
  relacionado ao código-fonte do MAME, **incluindo o seu
  useroptions.mak** ou qualquer outro arquivo que esteja ali e não faça
  parte do projeto. Portanto, faça um backup antes de executá-lo!

  Vamos supor que você alterou o arquivo abaixo:

	.. code-block:: shell

		git status
		On branch master
		Your branch is up-to-date with 'origin/master'.
		Changes not staged for commit:
		(use "git add <file>..." to update what will be committed)
		(use "git checkout -- <file>..." to discard changes in working directory)

			modified:   scripts/src/osd/sdl_cfg.lua

		no changes added to commit (use "git add" and/or "git commit -a")

  Para restaurá-lo à versão do Git, execute o comando a seguir:

	.. code-block:: shell

		git checkout master -- scripts/src/osd/sdl_cfg.lua


  .. raw:: latex

  	\clearpage


.. _mame-compilation-ccache:

Acelerando a compilação
~~~~~~~~~~~~~~~~~~~~~~~

Compilar todo o código-fonte do MAME é um processo demorado e que
consome muitos recursos de processamento e memória, além de energia
elétrica. É possível acelerar todo esse processo usando o
`ccache`_. Em resumo, ele mantém cópias dos arquivos compilados que
não foram alterados e atualiza apenas os que foram, economizando tempo
na compilação. Com o **ccache**, é possível compilar todo o código-fonte
do MAME em minutos (após a primeira compilação completa); sem ele, uma
compilação pode levar horas, dependendo da capacidade de processamento
do equipamento utilizado.

Para os sistemas Ubuntu e Debian Linux, o comando para instalar o
**ccache** é **sudo apt install ccache**. Para Arch Linux e MSYS2,
o comando é **pacman -S ccache**. Verifique qual é a opção para o seu
sistema operacional. Edite o seu **~/.bashrc** e adicione na última
linha ``export USE_CCACHE=1``. Para aplicar a configuração, faça:

	.. code-block:: shell

		. ~/.bashrc

A configuração é muito simples: edite o seu arquivo **useroptions.mak**,
para não ser necessário usar uma linha de configuração muito grande.
No Linux, a configuração seria a seguinte:

	.. code-block:: shell

		# Escolha apenas uma opção para OVERRIDE_CC e OVERRIDE_CXX
		# Remova o # da frente da opção que deseja usar.
		#
		# Compila com ccache Linux
		#OVERRIDE_CC=/usr/lib/ccache/gcc
		#OVERRIDE_CXX=/usr/lib/ccache/g++
		#
		# Compila com ccache Linux (Clang)
		CCACHE_CPP2=yes
		OVERRIDE_CC=/usr/lib/ccache/clang
		OVERRIDE_CXX=/usr/lib/ccache/clang++

Já a configuração para MSYS2 no Windows fica assim:

	.. code-block:: shell

		# Compila com ccache MSYS2 (Windows) 32 bits
		# OVERRIDE_CC=/mingw32/lib/ccache/gcc
		# OVERRIDE_CXX=/mingw32/lib/ccache/g++
		#
		# Compila com ccache MSYS2 (Windows) 64 bits
		# OVERRIDE_CC=/mingw64/lib/ccache/gcc
		# OVERRIDE_CXX=/mingw64/lib/ccache/g++
		#
		# Compila com ccache MSYS2 (Windows) 64 bits (Clang)
		CCACHE_CPP2=yes
		OVERRIDE_CC=/clang64/lib/ccache/bin/clang
		OVERRIDE_CXX=/clang64/lib/ccache/bin/clang++


.. raw:: latex

	\clearpage

.. tip:: Se o executável **/clang64/lib/ccache/bin/clang** não existir, 
   instale o pacote **mingw-w64-clang-x86_64-ccache** com o comando
   **pacman -S mingw-w64-clang-x86_64-ccache.**

Para ver a condição do armazenamento cache faça **ccache -sv**:

	.. code-block:: shell

		cache directory                     /home/seu_usuário/.ccache
		primary config                      /home/seu_usuário/.ccache/ccache.conf
		secondary config                    /etc/ccache.conf
		
		Cacheable calls:     3533 / 35558 ( 9.94%)
		  Hits:              2299 /  3533 (65.07%)
		  Direct:            2285 /  2299 (99.39%)
		  Preprocessed:        14 /  2299 ( 0.61%)
		  Misses:            1234 /  3533 (34.93%)
		Uncacheable calls:  32025 / 35558 (90.06%)
		  [...]
		Successful lookups:
		  Direct:            2285 /  3533 (64.68%)
		  Preprocessed:        14 /  1248 ( 1.12%)
		Local storage:
		  Cache size (GiB):   0.0
		  Files:             2401
		  Hits:              2299 /  3533 (65.07%)
		  Misses:            1234 /  3533 (34.93%)
		  Reads:             7066
		  Writes:            2482


Para montar a sua cache, basta compilar o código-fonte do MAME com o
comando:

.. code-block:: shell

	make clean && rm -rf build && make -j3

No final, em **cache size**, deve aparecer o quanto foi armazenado em
cache. Para aumentar o tamanho máximo do cache (max cache size) edite o
arquivo **/home/seu_usuário/.ccache/ccache.conf**.

Evite alterar as configurações de compilação o tempo todo, caso
contrário, o **ccache** gerará um novo cache para cada nova
configuração.

Veja todas as opções do **ccache** com o comando ``ccache -h``.

.. note:: Caso utilize o **ccache**, não é recomendável usar valores
   muito altos de **-j**, pois isso resulta em uma quantidade maior
   de perdas (*misses*) em comparação com os acertos (*hits*). Nos
   testes que realizei, o valor **-j3** gerou muito mais acertos do que
   perdas. Use o valor que você quiser se não for usar o **ccache**.


.. raw:: latex

	\clearpage


.. _compiling-practical-examples:

Exemplos práticos para todas as plataformas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O código-fonte do MAME já está preparado para que seja possível compilar
toda a sua estrutura ou apenas uma parte dela, como consoles, portáteis
ou até mesmo um sistema específico, como Neo Geo, CPS1, CPS2, ou
consoles, como Megadrive/Genesis, Super Nintendo, Playstation, entre
outros.

Isso é útil quando há limitações de tamanho do arquivo final do MAME ou
quando se deseja uma versão muito específica.

Para compilar a versão completa do MAME, execute o seguinte comando:

	.. code-block:: shell

		make

Se o seu processador tiver cinco núcleos, por exemplo, use a opção
``-j``,  para compartilhar o trabalho de compilação com os núcleos
extras e ajudar a reduzir o tempo de compilação. Atenção: a quantidade
máxima de núcleos disponíveis é limitada à quantidade de
núcleos do seu processador mais um.

Valores acima da quantidade de núcleos do seu processador não tornam
a compilação mais rápida; pelo contrário: a sobrecarga extra de
processamento pode fazer com que o seu processador superaqueça, deixando
o seu computador mais lento e pode fazer com que ele pare de responder.
No caso específico da compilação no Windows, a sobrecarga anula todos os
benefícios da compilação em paralelo. Nos testes realizados com o
Windows 10 de 64 bits, o valor ideal foi a quantidade de núcleos **menos
um**. Ou seja, um processador com oito núcleos deve usar **-j7** para
compilar em *multithread*:

	.. code-block:: shell

		make -j7

.. tip:: Ao pé da letra, "*thread*" significa "fio" ou "linha". Na
   computação, uma *thread* é uma tarefa realizada dentro de um
   processo. Ao executar o MAME, por exemplo, é iniciado um processo, e
   dentro desse processo são criadas várias "linhas" ("*threads*"),
   sendo que cada uma delas será lida e processada pelo processador.
   Então, "*multithread*" é a capacidade do processador e do sistema
   operacional de organizar e processar diferentes tarefas em paralelo,
   otimizando o desempenho e reduzindo o tempo de processamento.

Para compilar o MAME junto com as
:ref:`ferramentas <mame-compilation-tools>`, use a opção abaixo:

	.. code-block:: shell

		make TOOLS=1 -j7


.. _mame-compile-symbols:

Símbolos
--------

Para incluí-los na compilação, use a opção ``SYMBOLS=1``, o que é útil
caso o MAME trave por algum motivo. Para mais informações consulte
:ref:`SYMBOLS <mame-compilation-symbols>`. É importante também adicionar
o nível desses símbolos. Para mais informações consulte :ref:`SYMLEVEL
<mame-compilation-symlevel>`. Independentemente da versão do MAME que
estiver compilando, é uma boa prática manter ambas as opções. Ao
compilar a versão completa do MAME com os símbolos embutidos no próprio
executável, observe que o tamanho máximo permitido pelo Windows é
extrapolado, motivo pelo qual os símbolos precisam ser extraídos do
executável.

	.. code-block:: shell

		make TOOLS=1 SYMBOLS=1 SYMLEVEL=1 -j7

Para compilar uma versão de depuração do MAME, use o comando abaixo.
Para mais informações, consulte :ref:`DEBUG <mame-compilation-debug>`:

	.. code-block:: shell

		make TOOLS=1 SYMBOLS=1 SYMLEVEL=1 DEBUG=1 -j7


.. _mame-compile-sources:

Sources
-------

É possível personalizar a compilação selecionando um driver específico
com a opção ``SOURCES=<sistema>``. É importante lembrar que se houver
uma compilação anterior, é obrigatório usar a opção ``REGENIE=1`` para
regenerar os arquivos do projeto. Essa opção não é necessária se você
executar um ``make clean`` antes. Para compilar uma versão personalizada
do MAME que execute apenas o jogo Pac-Man, use o comando a seguir:

	.. code-block:: shell

		make SOURCES=src/mame/pacman/pacman.cpp REGENIE=1 -j7


.. _mame-compile-subtarget:

Subtarget
---------

O MAME também permite compilar uma versão só com sistemas arcade de
maneira prática. Nessa versão, os portáteis, consoles, computadores etc.
ficam de fora. Para obter uma versão arcade do MAME, use o comando
a seguir:

	.. code-block:: shell

		make SUBTARGET=arcade SYMBOLS=1 SYMLEVEL=1 -j7

.. note:: Não é mais possível usar ``SUBTARGET=arcade`` pois essa opção
   foi removida.

Para compilar uma versão do MAME só com consoles, use o comando a
seguir:

	.. code-block:: shell

		make SUBTARGET=mess SYMBOLS=1 SYMLEVEL=1 -j7

Para compilar um MAME apenas com os drivers de *Pac-Man* e *Galaxian*,
bem como as ferramentas:

	.. code-block:: shell

		make SOURCES=src/mame/pacman/pacman.cpp,src/mame/galaxian/galaxian.cpp TOOLS=1 REGENIE=1 -j7

Para compilar uma versão do Apple II, compile até seis arquivos fonte
em paralelo, fazendo o comando a seguir:

	.. code-block:: shell

		make SUBTARGET=appulator SOURCES=apple/apple2.cpp,apple/apple2e.cpp,apple/apple2gs.cpp REGENIE=1 -j7

Para compilar uma versão do MAME que tire proveito da extensão SSE2 do
seu processador e melhore o desempenho, use o comando a seguir. Para
mais informações consulte :ref:`SSE2 <mame-compilation-sse2>`:

	.. code-block:: shell

		make TOOLS=1 SYMBOLS=1 SYMLEVEL=1 SSE2=1 -j7

É possível compilar o MAME usando todas as extensões disponíveis do seu
processador, não apenas SSE2, desde que o compilador utilizado seja
compatível. Para isso, use a opção ``ARCHOPTS`` com a opção:
``-march=native`` no comando de compilação. Ao ativar essas opções, é
possível obter o máximo de desempenho do seu processador, e o MAME
também se beneficiará. O comando completo ficaria assim: note que a
opção ``SSE2=1`` foi removida:

	.. code-block:: shell

		make SYMBOLS=1 SYMLEVEL=1 ARCHOPTS=-march=native -j7

O ponto negativo é que os binários gerados com essa opção só
funcionarão em processadores iguais ao seu. Se você compilar uma versão
em um processador i3 da Intel, por exemplo, ela não funcionará em
qualquer outro processador i7. O mesmo vale para os processadores da
AMD. Ao ativar essas extensões, o seu MAME pode apresentar problemas
que não existem na versão oficial; portanto, a sua sorte com o uso delas
pode variar bastante. Por isso, saiba que os desenvolvedores
oficiais do MAME **não apoiam** o uso dessa opção.

Execute o comando a seguir para saber quais extensões compatíveis com o
seu processador serão ativadas com a opção ``-march=native``:

	.. code-block:: shell

		gcc -march=native -Q --help=target|grep enabled

Dependendo do modelo do processador o comando retornará mais ou menos
extensões disponíveis, num processador AMD FX(tm)-8350 com 8 núcleos
o **-march=native** vai usar estas extensões do seu processador:

	.. code-block:: shell

		-m128bit-long-double        		[enabled]
		-m64                        		[enabled]
		-m80387                     		[enabled]
		-mabm                       		[enabled]
		-maes                       		[enabled]
		-malign-stringops           		[enabled]
		-mavx                       		[enabled]
		-mavx256-split-unaligned-store 		[enabled]
		-mbmi                       		[enabled]
		-mcrc32                     		[enabled]
		-mcx16                      		[enabled]
		-mdirect-extern-access      		[enabled]
		-mf16c                      		[enabled]
		-mfancy-math-387            		[enabled]
		-mfma                       		[enabled]
		-mfma4                      		[enabled]
		-mfp-ret-in-387             		[enabled]
		-mfxsr                      		[enabled]
		-mglibc                     		[enabled]
		-mhard-float                		[enabled]
		-mieee-fp                   		[enabled]
		-mlong-double-80            		[enabled]
		-mlzcnt                     		[enabled]
		-mmmx                       		[enabled]
		-mmwait                     		[enabled]
		-mpartial-vector-fp-math    		[enabled]
		-mpclmul                    		[enabled]
		-mpopcnt                    		[enabled]
		-mprfchw                    		[enabled]
		-mpush-args                 		[enabled]
		-mred-zone                  		[enabled]
		-msahf                      		[enabled]
		-msse                       		[enabled]
		-msse2                      		[enabled]
		-msse3                      		[enabled]
		-msse4                      		[enabled]
		-msse4.1                    		[enabled]
		-msse4.2                    		[enabled]
		-msse4a                     		[enabled]
		-mssse3                     		[enabled]
		-mstv                       		[enabled]
		-mtbm                       		[enabled]
		-mtls-direct-seg-refs       		[enabled]
		-mxop                       		[enabled]
		-mxsave                     		[enabled]

Mesmo com todas essas extensões ativadas, incluindo outras variantes
do SSE, como a SSE3 e SSE4 por exemplo, não espere um aumento
considerável no desempenho do MAME. Em alguns sistemas, não se nota
diferença alguma, enquanto em outros há perda de desempenho.

Em alguns testes, a melhor média foi obtida usando apenas as opções
``SSE3=1 OPTIMIZE=03``, apesar do padrão do MAME ser ``SSE2=1``.
Mais uma vez, essa é uma questão bastante subjetiva, pois está sujeita
a uma série de variáveis, como a configuração do seu hardware, por
exemplo. Portanto, o desempenho pode variar bastante. É muito difícil
saber com precisão se haverá uma melhora no desempenho, pois o MAME
depende do proder de processamento do hardware em que é executado
(quanto mais potente, melhor) e do sistema operacional.

Podemos fazer um teste prático compilando duas versões do MAME para
executar apenas o pacman com opções diferentes.

	.. code-block:: shell

		Opção 1
		make SOURCES=src/mame/pacman/pacman.cpp SUBTARGET=pacman SSE3=1 OPTIMIZE=3
		
		Opção 2
		make SOURCES=src/mame/pacman/pacman.cpp SUBTARGET=pacman ARCHOPTS=-march=native OPTIMIZE=3

Executamos o nosso MAME por 90 segundos em um AMD FX(tm)-8350 de 4 Ghz
(8 núcleos), com 16 GiB de memória DDR3 de 1866 Mhz, AMD R7 250E 1 GiB,
Windows 10 x64 usando a opção :ref:`bench <mame-commandline-bench>`:

	.. code-block:: shell

		pacman64.exe pacman -bench 90

Para a **opção 1** ele retorna:

	.. code-block:: shell

		Average speed: 6337.43% (89 seconds)

Para a **opção 2** nós temos:

	.. code-block:: shell

		Average speed: 6742.91% (89 seconds)

Com o tempo e a experiência, cada um adaptará as opções de compilação
à sua própria necessidade. Abaixo, há um modelo para o seu
**useroptions.mak**:

	.. code-block:: shell

		# Esse é o modelo de configuração do usuário para a compilação
		# do MAME. Altere as opções conforme a sua necessidade. Remova o
		# "#"da frente da opção desejada.
		#
		# Para compilações que usem o Clang
		# <- Clang ->
		#OVERRIDE_CC=/usr/bin/clang
		#OVERRIDE_CXX=/usr/bin/clang++
		#
		# Só use em ÚLTIMO CASO! Para depuração apenas!
		#-SANITIZE=address
		#<- Clang ->
		#
		# Para compilar o MAME com apenas uma maquina em especifico.
		#SOURCES=src/mame/neogeo
		#
		# Para incluir símbolos de depuração (obrigatório)
		SYMBOLS=1
		SYMLEVEL=1
		#
		# <- Compilação cruzada ->
		# Para compilar o MAME para o Windows usando o Linux por exemplo.
		#TARGETOS=windows
		#STRIP_SYMBOLS=1
		# Use a opção abaixo para compilar uma versão 64 bits do MAME, não
		# precisa ser definido para compilações normais.
		#PTR64=1
		#
		# <- Compilação cruzada ->
		#
		# Caso queira compilar uma versão tiny apenas para teste.
		#SUBTARGET=tiny
		#
		# Caso queira uma versão ARCADE do MAME
		#SUBTARGET=arcade
		#
		# <- Opções Relacionados com a CPU ->
		# SSE2
		SSE2=1
		#
		# SSE3
		#SSE3=1
		#
		# Nível de otimização.
		# 0 Desativa a otimização favorecendo a depuração.
		# 1 Otimização simples sem impacto direto no tamanho final do executável.
		# 2 Ativa a maioria das otimizações visando desempenho e tamanho reduzido.
		# 3 Máxima otimização ao custo de um tamanho final maior. (padrão)
		# s Ativa apenas as otimizações que não impactem no tamanho final.
		OPTIMIZE=3
		#
		# Essa opção ativa todas as extensões do seu processador, se for usar
		# não use as opções SSE2 e SSE3.
		#ARCHOPTS=-march=native
		# <- Opções Relacionados com a CPU ->
		#
		# Acelera a lincagem final do executável
		LDOPTS=-fuse-ld=lld
		OVERRIDE_AR=llvm-ar
		#
		# A opção abaixo pode melhorar o desempenho mas também pode
		# causar problemas com alguns sistemas. USE COM CUIDADO. 
		# ARCHOPTS=-march=native -O3
		#
		# Nova configuração
		EMULATOR=1

Com o arquivo acima configurado e com as opções definidas, execute o
comando ``make -j7`` que o seu MAME será compilado levando as suas
opções em consideração.

.. note:: Uma nova configuração foi adicionada pelo `MAMEDev em
   31/12/2023`_  consulte :ref:`EMULATOR <mame-compilation-emulator>`.


.. raw:: latex

	\clearpage

.. _compiling-windows:

Microsoft Windows
~~~~~~~~~~~~~~~~~

O MAME para Windows é compilado usando o ambiente MSYS2. Para isso,
você precisará de uma versão de 64 bits do Windows 10 1809 ou posterior,
bem como de uma instalação razoavelmente atualizada do MSYS2. Para
compilar para ARM de 64 bits (AArch64), é necessário um sistema ARM de
64 bits com o Windows 11 ou uma versão mais recente.

* Por padrão, o MAME é compilado usando interfaces nativas do sistema
  operacional Windows para gerenciamento de janelas, saída de
  áudio/vídeo, renderização de fontes etc. Se preferir usar as
  interfaces portáteis do SDL (Simple DirectMedia Layer), adicione
  ``OSD=sdl`` às opções de compilação. O binário principal do emulador
  terá o prefixo "sdl" anexado (por exemplo, "sdlmame.exe"). Também é
  necessário instalar os pacotes MSYS2 para o SDL 2.0.14 ou uma versão
  mais recente.
* O MAME incluirá o depurador nativo do Windows por padrão. Para
  incluir também o depurador Qt portátil, adicione ``USE_QTDEBUG=1`` às
  opções de compilação. Também será necessário instalar os pacotes
  MSYS2 para o Qt 6.


.. _compiling-msys2-observacoes:

Algumas observações sobre o ambiente de desenvolvimento MSYS2
-------------------------------------------------------------

O MSYS2 utiliza a ferramenta **pacman** do Arch Linux para o
gerenciamento de pacotes. No `wiki do Arch Linux`_, há uma página com
informações úteis sobre o uso do pacman.

O ambiente do MSYS2 inclui dois tipos de ferramentas: as ferramentas
MSYS2, que foram projetadas para funcionarem em um ambiente semelhante
ao UNIX sobre o Windows, e as ferramentas MinGW, que foram projetadas
para funcionarem em um ambiente mais parecido com o Windows. As
ferramentas MSYS2 são instaladas em **/usr/bin** e as ferramentas MinGW
são instaladas em **/ucrt64/bin**, **/clangarm64/bin** e
**/clang64/bin** (em relação ao diretório de instalação do MSYS2). As
ferramentas MSYS2 funcionam melhor em um terminal MSYS2 e as ferramentas
MinGW funcionam melhor em um prompt de comando da Microsoft.

O sintoma mais evidente disso é que as teclas de seta não funcionam em
programas interativos se forem executados no tipo errado de terminal. A
execução do MinGW gdb ou do Python em uma janela de terminal MSYS2 fará
com que o histórico de comandos não funcione, e talvez não seja possível
interromper um programa anexado ao gdb. Da mesma forma, pode ser difícil
editar com o Vim do MSYS2 em uma janela do prompt de comando da
Microsoft.

Como o MAME é compilado com compiladores MinGW, os diretórios MinGW
são incluídos anteriormente na variável de ambiente PATH nos ambientes
de compilação. Se você quiser usar um programa interativo do MSYS2 a
partir de um shell do MSYS2, talvez seja necessário especificar
o caminho absoluto para garantir que o equivalente do MinGW não seja
utilizado em seu lugar.

O MSYS2 gdb pode ter dificuldade para depurar programas MinGW, como o
MAME. Para obter melhores resultados, instale a versão MinGW do
gdb e execute-a em uma janela do prompt de comando da Microsoft para
depurar o MAME.

O GNU Make é compatível com shells no estilo POSIX, como o bash, bem
como com o shell cmd.exe da Microsoft. No entanto, ao usar o cmd.exe, o
comando de cópia não fornece um código de saída útil. Consequentemente,
as tarefas de cópia de arquivos podem falhar silenciosamente. Isso pode
fazer com que sua compilação pareça bem-sucedida, embora produza
resultados incorretos. O comando que realiza a lincagem do MAME excede o
comprimento máximo de comando suportado pelo cmd.exe, portanto, não é
possível realizar uma compilação completa do MAME. Portanto,
recomendamos que você **não instale** as versões MinGW do GNU Make e, em
vez disso, use a versão do MSYS2 do pacote make.


.. raw:: latex

	\clearpage


Uma compilação completa do MAME que inclua símbolos de número de linha
excede o limite de tamanho imposto pelo formato de arquivo PE (*Portable
Executable*), portanto não pode ser executada. As soluções alternativas
incluem usar apenas um subconjunto dos sistemas compatíveis com o MAME,
extrair os símbolos para um arquivo separado, remover os símbolos em
excesso do executável do MAME ou compilar o MAME com o clang e a opção
de colocar os símbolos em arquivos PDB externos.

.. warning:: Não é mais possível compilar uma versão de 32 bits do MAME.


.. _compiling-msys2-manually:

Preparando a instalação do MSYS2 manualmente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O MAME é compilado para Windows utilizando uma instalação padrão do
MSYS2, à qual são adicionados pacotes adicionais para fornecer as
ferramentas de desenvolvimento necessárias para a compilação do MAME.
Estas instruções pressupõem que você esteja familiarizado com o MSYS2 e
com o gerenciador de pacotes **pacman**.

.. tip:: Para instalar um pacote use ``pacman -S nome_do_pacote``.

* Instele ambiente de desenvolvimento MSYS2 da `página oficial do MSYS2
  <https://www.msys2.org/>`_;
* Instale os pacotes necessários para compilar o MAME. No mínimo, você
  precisará do **bash**, do **git** e do **make**:
  
	.. code-block:: shell

		pacman -S bash git make

* Para depuração, instale o **gdb**:

	.. code-block:: shell

		pacman -S gdb

* Para criar a documentação HTML para usuários e desenvolvedores, você
  precisará instalar os pacotes para o ambiente **CLANG64**:

	.. code-block:: shell
  
		pacman -S mingw-w64-clang-x86_64-librsvg \
		mingw-w64-clang-x86_64-python-sphinx \
		mingw-w64-clang-x86_64-python-sphinx_rtd_theme \
		mingw-w64-clang-x86_64-python-sphinxcontrib-svg2pdfconverter``

  Ou alternativamente os seguintes pacotes para o ambiente
  **CLANGARM64**:

	.. code-block:: shell

		pacman -S mingw-w64-clang-aarch64-librsvg \
		mingw-w64-clang-aarch64-python-sphinx \
		mingw-w64-clang-aarch64-python-sphinx_rtd_theme \
		mingw-w64-clang-aarch64-python-sphinxcontrib-svg2pdfconverter


.. raw:: latex

	\clearpage


* Use o ambiente **UCRT64** para gerar a documentação em PDF, instale os
  pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-ucrt-x86_64-texlive-latex-extra \
		mingw-w64-ucrt-x86_64-texlive-fonts-recommended``

  Para o ambiente **CLANG64** instale os pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-clang-x86_64-texlive-latex-extra \
		mingw-w64-clang-x86_64-texlive-fonts-recommended

  Você deve utilizar o ambiente **UCRT64** or **CLANG64** para compilar
  a documentação PDF pois as ferramentas TeX Live atualmente não
  funciona com o ambiente **CLANGARM64**;
* Instale também o pacote:

	.. code-block:: shell

		pacman -S mingw-w64-x86_64-doxygen

* Se você pretende recompilar os shaders do bgfx e o analisador GLSL,
  você precisará instalar o **bison**:

	.. code-block:: shell

		pacman -S bison

Os pacotes adicionais dependem da arquitetura da CPU para qual você
estiver compilando.


.. raw:: latex

	\clearpage


**64-bit x86-64 (libstdc++/UCRT)**

* Instale os pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-ucrt-x86_64-gcc \
		mingw-w64-ucrt-x86_64-python

* Para utilizar o compilador Clang, instale o pacote:

	.. code-block:: shell

		mingw-w64-ucrt-x86_64-clang

* Para utilizar o lincador LLVM e o arquivador (é geralmente muito mais
  rápido que o *GNU linker* e o arquivador padrão), você precisará dos
  pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-ucrt-x86_64-lld \
		mingw-w64-ucrt-x86_64-llvm-tools \
		mingw-w64-x86_64-llvm \
		mingw-w64-ucrt-x86_64-libc++

* Para compilar usando as interfaces portáteis do SDL, você precisará
  dos pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-ucrt-x86_64-SDL2 \
		mingw-w64-ucrt-x86_64-SDL2_ttf

* Para compilar o depurador QT, você precisará do pacote:

	.. code-block:: shell

		mingw-w64-ucrt-x86_64-qt6-base

* Para iniciar um shell Bash configurado com os caminhos e as variáveis
  de ambiente corretos, abra o executável **ucrt64.exe** que está na
  pasta de instalação do **msys64** ou use o atalho do **MSYS2 UCRT64**
  no menu Iniciar já com as configurações e as variaveis de ambiente
  prontas.

**64-bit x86-64 (libc++/UCRT)**

* Instale os pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-clang-x86_64-clang \
		mingw-w64-clang-x86_64-python \
		mingw-w64-clang-x86_64-gcc-compat

* Para utilizar o lincador LLVM e o arquivador (é geralmente muito mais
  rápido que o GNU linker e o arquivador padrão), você precisará dos
  pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-clang-x86_64-lld \
		mingw-w64-clang-x86_64-llvm-tools \
		mingw-w64-clang-x86_64-llvm \
		mingw-w64-clang-x86_64-libc++

* Para compilar usando as interfaces portáteis do SDL, você precisará
  dos pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-clang-x86_64-SDL2 \
		mingw-w64-clang-x86_64-SDL2_ttf

* Para compilar o depurador QT, você precisará do pacote:

	.. code-block:: shell

		pacman -S mingw-w64-clang-x86_64-qt6-base

* Para iniciar um shell Bash configurado com os caminhos e as variáveis
  de ambiente corretos, abra o executável **clang64.exe** que está na
  pasta de instalação do **msys64** ou use o atalho do **MSYS2
  CLANG64**.

**64-bit ARM (libc++/UCRT)**

* Instale os pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-clang-aarch64-clang \
		mingw-w64-clang-aarch64-python \
		mingw-w64-clang-aarch64-gcc-compat

* Para utilizar o lincador LLVM e o arquivador (é geralmente muito mais
  rápido que o *GNU linker* e o arquivador padrão), você precisará dos
  pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-clang-aarch64-lld \
		mingw-w64-clang-aarch64-llvm-tools \
		mingw-w64-clang-aarch64-llvm \
		mingw-w64-clang-aarch64-libc++

* Para compilar usando as interfaces portáteis do SDL, você precisará
  dos pacotes:

	.. code-block:: shell

		pacman -S mingw-w64-clang-aarch64-SDL \
		mingw-w64-clang-aarch64-SDL2_ttf

* Para compilar o depurador QT, você precisará do pacote:

	.. code-block:: shell

		pacman -S mingw-w64-clang-aarch64-qt6-base

* Para iniciar um shell Bash configurado com os caminhos e as variáveis
  de ambiente corretos, abra o executável **clangarm64.exe** que está na
  pasta de instalação do **msys64** ou use o atalho do **MSYS2
  CLANGARM64**.


.. raw:: latex

	\clearpage


**32-bit x86**

Não é mais possível compilar uma versão do MAME para x86 de 32 bits em
um ambiente MSYS2. As versões mais recentes do GCC para 32 bits excedem
o espaço de endereço disponível ao compilar as classes de espaço de
endereço e as ligações Lua do MAME. Além disso, o MSYS2 não oferece mais
pacotes LLVM e Clang de 32 bits para x86. Para compilar o MAME para
sistemas x86 de 32 bits, use um ambiente que permita a compilação
cruzada para um alvo de 32 bits com ferramentas de 64 bits. Por exemplo,
use um ambiente MinGW em um sistema Linux.

**Configuração do ambiente**

* Ainda no terminal, abra o arquivo **~/.bashrc** com um editor de texto
  (por exemplo, **nano ~/.bashrc**) e adicione as informações abaixo ao
  final do arquivo:
  
	.. code-block:: shell

		export MINGW64=/mingw64
		export CLANG64=/clang64

.. note:: Para editar o arquivo **.bashrc** no Windows, ele fica em
   **pasta_instalação_MSYS2\\home\\seu_usuario**. Por exemplo,
   **D:\\msys64\\home\\wellington**.

.. _compiling-msys2-osd-sdl:

* Por padrão, o MAME é compilado usando as interfaces nativas
  do Windows, como o gerenciamento de janelas, a saída de áudio e de
  vídeo e o renderizador de fontes. No entanto, se você quiser compilar
  o MAME usando o `SDL`_ (Simple DirectMedia Layer), use a
  opção ``OSD=sdl`` como uma das opções de compilação do make.
  É necessário instalar os pacotes de desenvolvimento do SDL 2 no MSYS2
  a partir da versão **2.0.14** ou mais recente.

  Para compilar uma versão SDL do MAME para Windows, instale os pacotes
  a seguir:

	.. code-block:: shell

		pacman -S mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf

* O MAME inclui a versão nativa do depurador para Windows por padrão.
  Para incluir a versão Qt do depurador, é necessário instalar
  os pacotes de desenvolvimento do Qt 6 no MSYS2 e usar a opção
  ``QTDEBUG=1`` como uma das opções de compilação do make.

.. note:: Caso ocorra algum erro do tipo **GPGME error**, consulte o
   capítulo :ref:`compiling-issues-MSYS2`. Ao final, **feche a janela**
   e execute novamente o **mingw64.exe**.

* Para fazer a depuração do MAME é necessário instalar o **gdb**:

	.. code-block:: shell

		pacman -S mingw-w64-x86_64-gdb

.. note:: Para mais informações sobre o gdb, conculte o capítulo
   :ref:`compiling-using-gdb`.


.. _compiling-issues-MSYS2:

Resolvendo possíveis problemas com o MSYS2
------------------------------------------

Se ocorrer o erro **GPGME error: Invalid crypto engine**, que faz com
que a atualização pare, você verá que há diversos tópicos sobre o
assunto em centenas de fóruns na internet, mas nenhuma solução prática.
Então, aqui está a solução para esse erro em específico. Este documento
será atualizado caso apareçam outros problemas.

* Edite o arquivo **/etc/pacman.conf** com qualquer editor de texto.
* Altere a opção **SigLevel = Required DatabaseOptional** para
  **SigLevel = Never**. e salve;
* Mantenha a tela do seu editor aberto;
* Vá até o diretório **/etc/pacman.d** e apague o diretório **gnupg**.

Abra o shell do MSYS2 (**mingw64.exe**) e digite os comandos a seguir
em sequência:

1. **pacman-key --init**
2. **pacman-key --populate msys2**
3. **pacman-key --refresh-keys**

Com os passos acima seguidos corretamente, a atualização pode prosseguir
com o comando **pacman -Syu**. Se tudo tiver sido feito corretamente,
será exibido um retorno semelhante ao mostrado abaixo:

	.. code-block:: shell

		$ pacman -Syu
		:: Sincronizando a base de dados de pacotes...
		mingw64 está atualizado
		msys está atualizado
		mame está atualizado
		:: Starting core system upgrade...
		não há nada a fazer
		:: Iniciando atualização completa do sistema...
		resolvendo dependências...
		procurando por pacotes conflitantes...
		
		Pacotes (69) bash-completion-2.8-2  brotli-1.0.7-1  bsdcpio-3.3.3-3
				bsdtar-3.3.3-3  ca-certificates-20180409-1  coreutils-8.30-1
				curl-7.63.0-1  dash-0.5.10.2-1  dtc-1.4.7-1  file-5.35-1
				gawk-4.2.1-2  gcc-libs-7.4.0-1  glib2-2.54.3-1  gnupg-2.2.12-1
				grep-3.0-2  heimdal-libs-7.5.0-3  icu-62.1-1  info-6.5-2
				less-530-1  libarchive-3.3.3-3  libargp-20110921-2
				libassuan-2.5.2-1  libcrypt-2.1-2  libcurl-7.63.0-1
				libexpat-2.2.6-1  libffi-3.2.1-3  libgcrypt-1.8.4-1
				libgnutls-3.6.5-1  libgpg-error-1.33-1  libgpgme-1.12.0-1
				libhogweed-3.4.1-1  libidn2-2.0.5-1  libksba-1.3.5-1
				liblz4-1.8.3-1  liblzma-5.2.4-1  liblzo2-2.10-2  libnettle-3.4.1-1
				libnghttp2-1.35.1-1  libnpth-1.6-1  libopenssl-1.1.1.a-1
				libp11-kit-0.23.14-1  libpcre-8.42-1  libpcre16-8.42-1
				libpcre2_8-10.32-1  libpcre32-8.42-1  libpcrecpp-8.42-1
				libpcreposix-8.42-1  libpsl-0.20.2-1  libreadline-7.0.005-1
				libsqlite-3.21.0-4  libssh2-1.8.0-2  libunistring-0.9.10-1
				libutil-linux-2.32.1-1  libxml2-2.9.8-1  m4-1.4.18-2
				ncurses-6.1.20180908-1  nettle-3.4.1-1  openssl-1.1.1.a-1
				p11-kit-0.23.14-1  pcre-8.42-1  pinentry-1.1.0-2  pkgfile-19-1
				rebase-4.4.4-1  sed-4.7-1  time-1.9-1  ttyrec-1.0.8-2
				util-linux-2.32.1-1  wget-1.20-2  xz-5.2.4-1
		
		Tamanho total download:    36,91 MiB
		Tamanho total instalado:  206,90 MiB
		Alteração no tamanho:    61,49 MiB
		
		Continuar a instalação? [S/n]

Pressione a tecla :kbd:`Enter` e aguarde. Para ter certeza de que não há
erros. Execute o comando **pacman -Syu** novamente:

	.. code-block:: shell

		$ pacman -Syu
		:: Sincronizando a base de dados de pacotes...
		mingw32 está atualizado
		mingw64 está atualizado
		msys está atualizado
		mame está atualizado
		:: Starting core system upgrade...
		não há nada a fazer
		:: Iniciando atualização completa do sistema...
		não há nada a fazer

Se você recebeu um retorno diferente ou enfrentou outro problema que
o(a) impeça de fazer a atualização, verifique se não há
nenhum
`desses programas <https://cygwin.com/faq/faq.html#faq.using.bloda>`_
instalados em seu computador. Se houver, veja se é possível
desativá-los, adicionar uma regra de exclusão do diretório do
MSYS2 (**c:\\mysys64** ou **c:\\mysys32**) ou até mesmo removê-los, até
que você consiga montar o seu ambiente sem problemas.

Uma alternativa interessante seria usar um sistema virtual para compilar
o MAME ou montar o ambiente sem erros.

.. note:: A mesma dica acima também serve para resolver outro erro
   relacionado, "chave PGP inválida" (*invalid or corrupted package (PGP
   signature)*). Eu postei a solução em
   `issues do MSYS2 <https://github.com/msys2/MSYS2-packages/issues/2058#issuecomment-1252446059>`_ .
.. tip:: Ao atualizar a ferramenta fornecida pelo MAMEDev (incluindo o
   GCC e o Clang), podem ser exibidos erros sobre "*arquivos PCH
   inválidos*" ou não encontrados. Nesse caso, use a opção
   ``PRECOMPILE=0`` na linha de comando ou adicione-a ao seu arquivo
   **useroptions.mak**. Em seguida execute:
   ``make clean && make -j6`` para limpar a compilação antiga e compilar
   tudo desde o início. Se os problemas persistirem, aguarde a
   atualização do repositório, pois os desenvolvedores podem estar
   trabalhando na resolução do problema.


.. raw:: latex

	\clearpage


.. _compiling-windows-visual-studio:

Compilando com o Microsoft Visual Studio
----------------------------------------

* É possível gerar projetos compatíveis com o Visual Studio 2019 usando
  o comando ``make vs2019``. A solução e o projeto serão criados, por
  padrão, no diretório ``build/projects/windows/mame/vs2019``.
  O nome do diretório **build** pode ser alterado ao alterar a opção
  ``BUILDDIR``;

  O comando sempre regenera os projetos, portanto a opção ``REGENIE=1``
  **não é necessária**.

* Com a opção ``MSBUILD=1``, a solução será construída usando o
  *Microsoft Build Engine* após a criação dos arquivos do projeto.
  É necessário que o ambiente e os caminhos estejam corretament
  configurados para que o Visual Studio possa encontrá-los;

* Consulte a documentação `Usando o conjunto de ferramentas Microsoft
  C++ na linha de comando <https://docs.microsoft.com/pt-br/cpp/build/building-on-the-command-line>`_.
  Talvez você ache mais fácil carregar o projeto diretamente na
  interface do Visual Studio do que usar a opção ``MSBUILD=1``;

* Mesmo utilizando o Visual Studio, é necessário ter também o ambiente
  MSYS2 para gerar os arquivos do projeto, converter os layouts
  internos, compilar as traduções da interface etc.


.. raw:: latex

	\clearpage


Linux
~~~~~

.. _compiling-fedora:

Fedora Linux
------------

Antes de prosseguir, certifique-se de que os pré-requisitos tenham
sido atendidos em sua distribuição Linux. As versões anteriores ao
`SDL`_ 2 **2.0.14** não possuem a funcionalidade necessária. Portanto,
verifique se a versão mais recente está instalada:

	.. code-block:: shell

		sudo dnf install gcc gcc-c++ make python SDL2-devel SDL2_ttf-devel libXi-devel libXinerama-devel qt6-qtbase-devel qt6-qttools expat-devel fontconfig-devel alsa-lib-devel pulseaudio-libs-devel

Para usar ferramentas `LLVM`_ mais eficientes para arquivar bibliotecas
estáticas e fazer a lincagem, é preciso instalar os pacotes a seguir:

	.. code-block:: shell

		sudo dnf install lld llvm

A compilação deve ser feita exatamente como foi descrito em
:ref:`compiling-practical-examples`.


.. _compiling-ubuntu:

Debian e Ubuntu (incluindo dispositivos Raspberry Pi e ODROID)
--------------------------------------------------------------

Antes de prosseguir, certifique-se de que os pré-requisitos tenham
sido atendidos em sua distribuição Linux. As versões anteriores ao
`SDL`_ 2 **2.0.14** não possuem a funcionalidade necessária. Portanto,
verifique se a versão mais recente está instalada:

	.. code-block:: shell

		sudo apt install git git-lfs build-essential python3 libxi-dev libsdl2-dev libsdl2-ttf-dev libfontconfig-dev libpulse-dev qtbase6-dev qtchooser qt6-qmake qtbase6-dev-tools gettext

Para usar ferramentas `LLVM`_ mais eficientes para arquivar bibliotecas
estáticas e fazer a lincagem, é preciso instalar os pacotes a seguir:

	.. code-block:: shell

		sudo apt-get install lld llvm

A compilação deve ser feita exatamente como foi descrito em
:ref:`compiling-practical-examples`.


.. _compiling-arch:

Arch Linux
----------
Antes de prosseguir, certifique-se de que os pré-requisitos tenham
sido atendidos:

	.. code-block:: shell

		sudo pacman -S base-devel git sdl2_ttf python libxinerama libpulse alsa-lib qt6-base libxi libpulse

A compilação deve ser feita exatamente como foi descrito em
:ref:`compiling-practical-examples`.

.. raw:: latex

	\clearpage

.. _compiling-macos:

Apple macOS
~~~~~~~~~~~
Antes de prosseguir, certifique-se de que os pré-requisitos tenham
sido atendidos. Verifique se você está usando o macOS 11.0 Big
Sur ou uma versão mais recente. Também é necessário ter a versão
**2.0.14** ou mais recente do `SDL`_ 2 e instalar o Python 3,
que atualmente está incluído nas ferramentas de linha de comando do
Xcode. No entanto, também é possível instalar uma versão autônoma ou
obtê-la por meio do gerenciador de pacotes Homebrew.

* Instale o **Xcode** encontrado na *Mac App Store* ou o
  `ADC <https://developer.apple.com/download/more/>`_ (para isso, é
  necessário ter um **Apple ID**);
* Para encontrar a versão mais recente do Xcode correspondente à versão
  do seu macOS, visite o site `xcodereleases.com`_;
* Então, inicie o programa **Xcode**;
* Serão baixados alguns pré-requisitos adicionais. Deixe o processo em
  execução antes de continuar;
* Ao terminar, encerre o **Xcode** e abra uma janela do **Terminal**;
* Digite o comando ``xcode-select --install`` para instalar o kit de
  ferramentas necessário para compilar o MAME (também disponível como
  pacote no ADC).

Em seguida, é preciso baixar e instalar o `SDL`_ 2.

* Acesse a página de download do `SDL`_ 2 e baixe o arquivo ``.dmg``
  para o **macOS**;
* Caso o arquivo ``.dmg`` não abra automaticamente, execute-o
  manualmente;
* No painel esquerdo, onde está localizada a janela do Finder, clique
  em **Macintosh HD** (o HD do seu Mac), depois em **Biblioteca** e, por
  fim, arraste o arquivo **SDL2.framework** para a pasta **Frameworks**.
  Será necessário fazer login com a senha do seu usuário.

Se ainda não tiver, obtenha o Python 3 e configure-o.

* Acesse o site oficial do Python, navegue até a seção de `downloads
  para o macOS`_ e clique no link para baixar o instalador da última
  versão estável (até o momento da atualização deste texto, seria
  o `Python 3.13.1`_);
* Role a página até a seção "Files" e baixe a versão para macOS (chamada
  de "**macOS 64 bits universal2 installer**" ou similar);
* Após o download, execute-o e siga as instruções de instalação.

Use o Terminal para iniciar a compilação, navegue até a pasta onde o
código-fonte do MAME está localizado (comando ``cd pasta_do_mame``) e
siga as instruções de compilação descritas em
:ref:`compiling-practical-examples`.


.. raw:: latex

	\clearpage


.. _compiling-emscripten:

Javascript Emscripten e HTML
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Primeiro, baixe e instale o **Emscripten 3.1.74** ou a versão mais
recente, conforme as instruções do `site oficial
<https://emscripten.org/docs/getting_started/downloads.html>`_.

Após a instalação, será possível compilar o MAME diretamente,
usando a ferramenta "**emmake**". Como o MAME completo é muito grande
para ser carregado de uma só vez em uma página da web, então compile
apenas os drivers separados do MAME por meio do parâmetro **SOURCES**.
Para mais informações, consulte a seção :ref:`mame-compile-sources`. Por
exemplo, execute o comando a seguir no mesmo diretório do MAME:

	.. code-block:: shell

		emmake make SUBTARGET=pacmantest SOURCES=src/mame/pacman

O parâmetro ``SOURCES`` deve apontar para pelo menos um arquivo
*driver.cpp*. O comando *make* tentará localizar e reunir todas as
dependências para compilar o executável do MAME junto com o *driver*
especificado. No entanto, se houver algum erro e o processo não
encontrar algum arquivo, será necessário declarar manualmente os
arquivos faltantes (separados por vírgula). Por exemplo:

	.. code-block:: shell

		emmake make SUBTARGET=apple2e SOURCES=src/mame/apple2e,src/devices/machine/applefdc.cpp

O valor do parâmetro ``SUBTARGET`` serve apenas para diferenciar as
várias compilações existentes, por tanto não precisa ser definido caso
não seja necessário.

O *Emscripten* oferece suporte à compilação do *WebAssembly* com um
carregador (*loader*) de JavaScript, em vez de executar o JavaScript
inteiro, o que é o padrão nas versões mais recentes. Para ativar ou
desativar o *WebAssembly*, adicione o parâmetro **WEBASSEMBLY=1** ou
**WEBASSEMBLY=0** ao comando make, respectivamente.

Outros parâmetros para o comando make também podem ser usados, como o
**-j**, para usar a compilação em *multithread*.

Quando a compilação atinge a fase da *emcc*, são exibidas algumas
mensagens de aviso do tipo "*unresolved symbol*". Até o momento, isso é
esperado para funções relacionadas ao OpenGL, como a função
"*glPointSize*". Outras mensagens podem indicar a necessidade de se
especificar um arquivo de dependência adicional na lista do parâmetro
**SOURCES**. Infelizmente, esse processo ainda não é automatizado: é
necessário localizar e informar o arquivo de código-fonte, bem como os
arquivos que contêm os símbolos em falta. Ignorar os avisos e dar
sequência à compilação pode funcionar, desde que os códigos ausentes não
sejam utilizados no momento da execução.

Se tudo correr bem, um arquivo **.js** será criado no diretório. Ele não
pode ser executado sozinho: é necessário um *loader* HTML para que
possa ser exibido e para que seja possível passar os parâmetros de linha
de comando para o executável.

O `Projeto Emularity <https://github.com/db48x/emularity>`_ oferece tal
*loader*.

.. raw:: latex

	\clearpage

Nesse repositório, existem amostras de arquivos **.html** nesse
repositório que podem ser editadas para refletir suas configurações
pessoais e apontar o caminho do seu arquivo JS recém-compilado do MAME.
Para usar o MAME em um servidor web, são necessários os arquivos a
seguir:

* O arquivo **.js** compilado do MAME;
* O arquivo **.wasm** do MAME caso você tenha compilado o WebAssembly;
* Os arquivos **.js** do pacote Emularity (loader.js, browserfs.js,
  etc.);
* Um arquivo **.zip** contendo as ROMs do driver que será executado,
  caso existam;
* Qualquer outro programa que se queira executar com o driver do MAME;
* Um *loader* do Emularity para carregar o **.html** personalizado e
  utilizar todos os itens acima.

Por causa da restrição de segurança dos navegadores atuais, é preciso
usar um servidor web, em vez de tentar executá-lo localmente.

Se algo der errado, abra o console Web do seu navegador
principal e veja qual erro é retornado (por exemplo, se falta algo ou se
algum arquivo de ROM está incorreto). Dependendo do seu navegador, essa
opção está disponível ao clicar com o botão direito na página e
selecinar :guilabel:`Inspecionar`. Um erro do tipo
"**ReferenceError: foo is not defined**" pode indicar que um arquivo de
código-fonte foi esquecido na lista de parâmetros **SOURCES**.


.. raw:: latex

	\clearpage


.. _compiling-options:

Opções gerais para a compilação
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. _mame-compilation-premake:

Opções
------

**PREFIX_MAKEFILE**

  Define um arquivo *make* que será incluído no processo de compilação
  com opções adicionais e que terá prioridade caso seja encontrado (o
  nome predefinido é **useroptions.mak**). Isso pode ser útil caso você
  queira alternar entre diferentes configurações de compilação de
  maneira simples e rápida.


.. _mame-compilation-build:

**BUILDDIR**

  Define o diretório usado para a compilação de todos os arquivos do
  projeto, códigos-fonte auxiliares gerados durante a configuração,
  arquivos objeto e bibliotecas intermediárias. Por padrão, o nome deste
  diretório é **build**.


.. _mame-compilation-regenie:

**REGENIE**

  |sefo| ``1``, toda a estrutura de instrução para a
  compilação do projeto será regenerada, especialmente se uma compilação
  tiver sido feita anteriormente e for necessário alterar as
  configurações predefinidas.


.. _mame-compilation-verbose:

**VERBOSE**

  |sefo| ``1``, ativa o modo loquaz, fazendo com que todos os
  comandos usados pela ferramenta make durante a compilação sejam
  exibidos. Essa opção é aplicada instantaneamente e não requer o uso
  do parâmetro ``REGENIE``.


.. _mame-compilation-ignore_git:

**IGNORE_GIT**

  |sefo| ``1``, ignora-se o escaneamento da árvore de trabalho e não se
  embute a revisão descritiva do Git no campo da versão do executável,
  ou seja, ao usar a opção ``-version``, não haverá nenhuma versão do
  commit, apenas a versão do MAME, exemplo ``0.xxx (mame0xxx)`` em vez
  de 0.xxx (mame0xxx-yyy-zzz).


.. _mame-compilation-targetos:

**TARGETOS**

Define o sistema operacional de destino. É importante deixar claro que
essa opção é desnecessária caso esteja compilando o MAME nativamente. Os
valores válidos são:

	* ``android`` (Android)

	* ``asmjs`` (Emscripten/asm.js)

	* ``freebsd`` (FreeBSD)

	* ``netbsd`` (NetBSD)

	* ``openbsd`` (OpenBSD)

	* ``pnacl`` (Native Client - PNaCl)

	* ``linux`` (Linux)

	* ``ios`` (iOS)

	* ``macosx`` (OSX)

	* ``windows`` (Windows)

	* ``haiku`` (Haiku)

	* ``solaris`` (Solaris SunOS)

	* ``steamlink`` (Steam Link)

	* ``rpi`` (Raspberry Pi)

	* ``ci20`` (Creator-Ci20)


.. _mame-compilation-sse2:

**SSE2**

  Double Precision Streaming SIMD Extensions, em resumo, são instruções
  que otimizam o desempenho em processadores compatíveis. Segundo a
  `nota publicada <https://www.mamedev.org/?p=451>`_ no site do MAME, o
  MAME terá um melhor desempenho se for definido como ``1``.


.. _mame-compilation-ptr64:

**PTR64**

  |sefo| ``1``, o tamanho do ponteiro é definido em bit, gerando uma
  versão 64 bits do executável do MAME ou 32 bits, quando não for
  definido.


.. raw:: latex

	\clearpage

.. _mame-compilation-alternate-tools:

Usando ferramentas de compilação alternativas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. _mame-compilation-override_cc:

**OVERRIDE_CC**

  Define o compilador C/Objective-C avulso ou para um compilador voltado
  para um sistema em específico. 


.. _mame-compilation-override_cxx:

**OVERRIDE_CXX**

  Define o compilador C++/Objective-C++ avulso ou para um compilador
  voltado para um sistema em específico.


.. _mame-compilation-override_ld:

**OVERRIDE_LD**

  Define o comando para o lincador. Caso o seu ambiente esteja
  corretamente configurado, não será necessário lidar com ele, mesmo em
  compilação cruzada.


.. _mame-compilation-override_ar:

**OVERRIDE_AR**

  Estabelece o comando do compactador de bibliotecas estáticas.


.. _mame-compilation-python_executable:

**PYTHON_EXECUTABLE**

  Define o interpretador Python. Para compilar o MAME é necessário ter
  o Python na versão **2.7**, **3** ou mais recente.


.. _mame-compilation-cross_build:

**CROSS_BUILD**

  |sefo| ``1`` para que o lincador e o compilador fiquem isolados do
  sistema hospedeiro, opção obrigatória ao realizar uma
  :ref:`mame-crosscompilation`.


.. _mame-compilation-openmp:

**OPENMP**

  |sefo| ``1``, faz uso da `paralelização implícita`_ com o `OpenMP`_.
  De acordo com o `FAQ oficial do MAME`_ em "*Does MAME benefit from
  SMP*", são adicionadas novas *threads* para aceleração de *loops*, o
  que aumenta o desempenho. Para fazer uso desta opção, é necessário
  instalar o pacote **libomp-devel** ou o **libomp-dev**, dependendo da
  sua distribuição.

.. warning:: O MAME não é totalmente compatível com essa opção, assim
   sendo, use por sua conta e risco.

.. raw:: latex

	\clearpage


Incluindo os subconjuntos dos sistemas suportados
-------------------------------------------------

.. _mame-compilation-subtarget:

**SUBTARGET**

  Define a compilação alternativa do compilador. Algumas predefinições
  estão disponíveis em **scripts/target/mame** ou por meio dos filtros
  dos drivers do sistema em **src/mame**. As versões alternativas
  criadas pelo usuário podem ser feitas usando o parâmetro ``SOURCES``
  ou ``SOURCEFILTER``. Os valores já predefinidos são:

		* **dummy**: compila uma versão bem simplificada do MAME com apenas um driver.
		* **mame**: compila uma versão normal do MAME.
		* **tiny**: compila uma versão simples do MAME com alguns poucos drivers.

  O valor do parâmetro ``SUBTARGET`` serve também para se diferenciar
  dentre as várias compilações existente e não precisa ser definido sem
  necessidade. No exemplo do comando abaixo:

	.. code-block:: shell

		make REGENIE=1 SUBTARGET=neogeo SOURCES=neogeo/neogeo.cpp -j7

  Será criado um binário do MAME com o nome **neogeo** no Linux ou
  **neogeo.exe** no Windows.


.. _mame-compilation-sources:

**SOURCES**

  Define o arquivo com o código-fonte do driver que será incluído na
  compilação. Geralmente, essa opção é usada em conjunto com o
  parâmetro ``SUBTARGET``. Os diferentes arquivos/pastas são separados
  por vírgulas.


.. _mame-compilation-sourcefilter:

**SOURCEFILTER**

  Define um arquivo de filtro do driver do sistema. É normalmente usado
  em conjunto com o parâmetro ``SUBTARGET``. O arquivo de filtro pode
  definir os arquivos de origem a serem incluídos nos drivers do sistema
  e escolher quais drivers individuais serão incluídos ou excluídos. Há
  alguns exemplos de arquivos de filtro dos drivers de sistema na pasta
  **src/mame**.


.. raw:: latex

	\clearpage


.. _mame-compilation-optional-resources:

Recursos opcionais
------------------

.. _mame-compilation-tools:

**TOOLS**

  |sefo| ``1``, além do executável do MAME, serão compiladas ferramentas
  adicionais que trabalham em conjunto com o emulador, como **unidasm**,
  **chdman**, **romcmp** e **srcclean**, entre outras. Para compilar
  apenas as ferramentas, utilize os parâmetros ``TOOLS=1 EMULATOR=0``.


.. _mame-compilation-emulator:

**EMULATOR**

  |sefo| ``1``, todo o código-fonte será compilado e o executável do
  MAME será gerado. Se for definido como 0, apenas uma parte do
  código-fonte será compilada, sem o executável do MAME.

.. _mame-compilation-nouseopengl:

**NO_OPENGL**

  |sefo| ``1``, desativa a compilação do módulo de saída de vídeo
  opengl.

.. _mame-compilation-nouseportaudio:

**NO_USE_PORTAUDIO**

  |sefo| ``1``, desativa a construção do módulo de saída de áudio
  *PulseAudio* e a sua biblioteca no Linux.


.. _mame-compilation-nousepulseaudio:

**NO_USE_PULSEAUDIO**

  |sefo| ``1``, desativa a construção do módulo de saída de áudio
  *PortAudio* e a sua biblioteca no Linux.


.. _mame-compilation-usewayland:

**USE_WAYLAND**

  |sefo| ``1``, inclui suporte do MAME ao `Wayland`_ à saída de vídeo
  bgfx.

.. note::
   Para compilar o MAME com esta opção, é preciso instalar o pacote
   ``libwayland-egl-backend-dev`` ou equivalente no seu sistema
   operacional.


.. _mame-compilation-usetapun:

**USE_TAPTUN**

  |sefo| ``1``, o módulo de rede TAP/TUN é incluído; use ``0`` para
  desativá-lo. Por padrão, o módulo de rede TAP/TUN está incluso no
  Windows e no Linux.


.. _mame-compilation-usepcap:

**USE_PCAP**

  |sefo| ``1``, o módulo de rede pcap é incluído, use ``0``
  para desativá-lo. Por padrão, o módulo de rede pcap está incluso no
  macOS e no NetBSD.


.. _mame-compilation-use_qtdebug:

**USE_QTDEBUG**

  |sefo| ``1``, o depurador com a interface Qt será incluído em
  plataformas onde ela não vem previamente embutida, como MacOS e
  Windows, por exemplo. Defina como ``0`` para desativá-lo.
  É obrigatória a instalação das bibliotecas de desenvolvimento Qt, bem
  como as suas ferramentas, para a compilação do depurador. Todo esse
  processo varia de plataforma para plataforma.


.. raw:: latex

	\clearpage


Opções de compilação
--------------------


.. _mame-compilation-nowerror:

**NOWERROR**

  |sefo| ``1``, desativa o tratamento das mensagens de aviso do
  compilador como erro. Talvez seja necessário em configurações
  minimamente compatíveis.


.. _mame-compilation-deprecated:

**DEPRECATED**

  |sefo| ``0``, desativa as mensagens de aviso menos importantes ou
  relevantes (repare que as mensagens de aviso não são tratadas como
  erro).


.. _mame-compilation-debug:

**DEBUG**

  |sefo| ``1``, ativa as rotinas de verificação e diagnóstico
  adicionais, assim como, o modo de depuração. É importante saber que
  essa opção impacta diretamente o desempenho do emulador e é útil
  apenas para desenvolvedores. Não compile o MAME com esta opção sem
  saber exatamente o que está fazendo. Consulte também 
  :ref:`compiling-advanced-options-debug`.


.. _mame-compilation-optimize:

**OPTIMIZE**

  Esse parâmetro define o nível de otimização. O valor predefinido é
  ``3``, e o foco é o desempenho, mesmo que o executável final fique
  maior. Há também as seguintes opções:

		* ``0``: Se quiser desativar a otimização e favorecer a depuração;
		* ``1``: Otimização simples sem impacto direto no tamanho final do executável (nem no tempo de compilação);
		* ``2``: Ativa a maioria das otimizações visando desempenho e tamanho reduzido;
		* ``3``: Este é o valor predefinido. Favorece do desempenho ao custo de um executável maior;
		* ``s``: Ativa apenas as otimizações que não impactem no tamanho final do executável.

  A compatibilidade destes valores depende do compilador utilizado.


.. _mame-compilation-symbols:

**SYMBOLS**

  |sefo| ``1``, ativaa a inclusão de símbolos adicionais de depuração
  para a plataforma que o executável está sendo compilado, além dos já
  inclusos (muitas plataformas por predefinição já incluem estes
  símbolos e os nomes das respectivas funções).


.. _mame-compilation-symlevel:

**SYMLEVEL**

  Esse valor numérico controla a quantidade de informações dos símbolos
  de depuração. Valores maiores facilitam a depuração, mas aumentam o
  tempo de compilação e o tamanho final do executável. O parâmetro
  ``SYMLEVEL=1`` é usado na versão oficial do MAME e na mínima
  recomendada. A compatibilidade destes valores depende do compilador
  utilizado. No caso do GNU GCC e similares, esses valores são:

		* ``1``: Incluí tabelas numéricas e variáveis externas;
		* ``2``: Incluí os itens descritos em ``1``. Também são incluídas as variáveis locais;
		* ``3``: Incluí os itens descritos em ``2``. Também são incluídas as definições de macros.


.. _mame-compilation-strip-symbols:

**STRIP_SYMBOLS**

  |sefo| ``1``, os símbolos de depuração, em vez de ficarem embutidos no
  MAME, sejam armazenados em um arquivo externo com extensão "**.sym**".
  Esse arquivo é extraído na versão do Windows. Essa opção é útil para
  reduzir o tamanho final do MAME, já que ao utilizar o parâmetro
  ``SYMLEVEL`` com valores maiores que ``1`` gera uma grande quantidade
  de símbolos de depuração, impactando significativamente no tamanho
  final do executável.


.. raw:: latex

	\clearpage

.. _mame-compilation-pdbsymbols:

**PDB_SYMBOLS**

	|sefo| ``1``, gera símbolos no formato CodeView em arquivos PDB
	separados. Isso permite a depuração no nível do código-fonte com
	o Microsoft Visual Studio ou o WinDbg. Essa opção também pode ser
	utilizada com outras ferramentas que carregam símbolos de arquivos
	PDB, como as ferramentas de análise de desempenho Intel VTune e AMD
	µProf, mas ela só é compatível para compilações MinGW que utilizam o
	compilador Clang e o vinculador LLVM (LLD). Ela só tem efeito se a
	opção ``SYMBOLS`` estiver definida para um valor diferente de zero.


.. _mame-compilation-archopts:

**ARCHOPTS**

	Opções adicionais que serão passadas ao compilador e ao lincador.
	Essa opção é útil para a geração de códigos adicionais ou de opções
	de interface binária de aplicação [1]_, como a ativação de recursos
	opcionais do processador.


.. _mame-compilation-archopts-c:

**ARCHOPTS_C**

	Semelhante ao parâmetro anterior, mas, para a compilação de arquivos
	de código-fonte em linguagem C.


.. _mame-compilation-archopts-cpp:

**ARCHOPTS_CXX**

	Semelhante ao parâmetro anterior, mas, para a compilação de arquivos
	de código-fonte em linguagem C++.


.. _mame-compilation-archopts-objc:

**ARCHOPTS_OBJC**

	Semelhante ao parâmetro anterior, mas, para a compilação de arquivos
	de código-fonte em Objective-C.


.. _mame-compilation-archopts-objcxx:

**ARCHOPTS_OBJCXX**

	Semelhante ao parâmetro anterior, mas, para a compilação de arquivos
	de código-fonte em Objective-C++.


Sede das bibliotecas e framework
--------------------------------

**SDL_INSTALL_ROOT**

  Informe o caminho completo do diretório raiz onde se encontra a
  instalação dos arquivos de desenvolvimento SDL.


**SDL_FRAMEWORK_PATH**

  Informe o caminho completo do diretório raiz onde se encontra o SDL
  framework.


**USE_LIBSDL**

  |sefo| ``1``, prefira usar a biblioteca SDL |doce|.


**USE_SYSTEM_LIB_ASIO**

  |sefo| ``1``, prefira usar a biblioteca I/O assíncrona Asio C++
  |doce|.


**USE_SYSTEM_LIB_EXPAT**

  |sefo| ``1``, prefira usar o analisador sintático Expat XML |doce|.


.. raw:: latex

	\clearpage


**USE_SYSTEM_LIB_ZLIB**

  |sefo| ``1``, prefira usar a biblioteca de compressão zlib |doce|.


**USE_SYSTEM_LIB_JPEG**

  |sefo| ``1``, prefira usar a biblioteca de compressão de imagem
  libjpeg |doce|.


**USE_SYSTEM_LIB_FLAC**

  |sefo| ``1``, prefira usar a biblioteca de compressão de áudio
  libFLAC |doce|.


**USE_SYSTEM_LIB_LUA**

  |sefo| ``1``, prefira usar a biblioteca do interpretador Lua |doce|.


**USE_SYSTEM_LIB_SQLITE3**

  |sefo| ``1``, prefira usar a biblioteca do motor de pesquisa SQLITE
  |doce|.


**USE_SYSTEM_LIB_PORTMIDI**

  |sefo| ``1``, prefira usar a biblioteca PortMidi |doce|.


**USE_SYSTEM_LIB_PORTAUDIO**

  |sefo| ``1``, prefira usar a biblioteca PortAudio |doce|.


**USE_SYSTEM_LIB_UTF8PROC**

  |sefo| ``1``, prefira usar a biblioteca Julia utf8proc |doce|.


**USE_SYSTEM_LIB_GLM**

  |sefo| ``1``, prefira usar a biblioteca GLM OpenGL Mathematics
  |doce|.


**USE_SYSTEM_LIB_RAPIDJSON**

  |sefo| ``1``, prefira usar a biblioteca Tencent RapidJSON
  |doce|.


**USE_SYSTEM_LIB_PUGIXML**

  |sefo| ``1``, caso prefira usar a biblioteca pugixml |doce|.

.. raw:: latex

	\clearpage


.. _compiling-issues:

Problemas conhecidos
~~~~~~~~~~~~~~~~~~~~

Recursos do código-fonte fortify da biblioteca GNU C
----------------------------------------------------

A biblioteca GNU C oferece opções para realizar verificações tanto
durante a compilação quanto durante a execução. Para ativar o recurso,
use o parâmetro **_FORTIFY_SOURCE=1**. Embora essa opção melhore a
segurança, ela causa uma pequena sobrecarga no executável. O MAME não é
um programa seguro, portanto não recomendamos compilar o MAME com esse
parâmetro definido.

Algumas distribuições Linux, como Gentoo e Ubuntu, possuem versões
alteradas do GNU GCC que já vêm com o parâmetro ativado. Isso não
apenas gera problemas para o MAME, como também para a maioria dos
projetos, pois afeta diretamente o desempenho do emulador, dificulta a
desativação dessas verificações adicionais e torna difícil definir
outros valores para o parâmetro, como o valor 2, que ativa verificações
ainda mais restritas.

Nesse caso, é pressionar pressionar os mantenedores da sua distribuição
preferida, deixando claro que você não deseja que o GNU GCC tenha um
comportamento fora do padrão.

Seria melhor que essas distribuições predefinissem essa opção em seu
próprio ambiente de desenvolvimento de pacotes, caso acreditem que ela
seja realmente importante, em vez de obrigar todos a utilizá-la em
todo e qualquer código-fonte compilado no sistema, sem necessidade.

A distribuição Red Hat faz da seguinte maneira: o parâmetro
**_FORTIFY_SOURCE** é definido apenas no ambiente de compilação
dos pacotes RPM, e não é distribuída uma versão alterada do GNU GCC.

Se encontrar erros relacionados ao arquivo **bits/string_fortified.h**,
verifique se o parâmetro **_FORTIFY_SOURCE** já está definido no
ambiente ou junto às variáveis **CFLAGS** ou **CXXFLAGS**, por exemplo.
É possível verificar o ambiente com o comando a seguir:

	.. code-block:: shell

		gcc -dM -E - < /dev/null | grep _FORTIFY_SOURCE

Caso o parâmetro **_FORTIFY_SOURCE** já esteja predefinido com um valor
diferente de zero, é possível utilizar uma solução paliativa com o
comando **-U_FORTIFY_SOURCE**. Use-o em seu parâmetro de compilação
**ARCHOPTS** ao redefinir suas variáveis de ambiente **CFLAGS** e
**CXXFLAGS**.


Problemas que afetam o MinGW clang
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O Clang e o LLVM do MinGW podem apresentar erros espúrios de símbolos
indefinidos ao vincular símbolos no formato CodeView com altos níveis de
detalhamento. Se encontrar erros de símbolos indefinidos ao lincar
usando a opção **PDB_SYMBOLS=1** para produzir símbolos no formato CodeView,
tente usar também a opção **SYMLEVEL=1** para reduzir o nível de
detalhe dos símbolos (as tabelas com os números de linha ainda serão
incluídas, mas as variáveis locais serão omitidas).


.. _compiling-issues-mvs:

Problemas que afetam o Microsoft Visual Studio
----------------------------------------------

O compilador MSVC emite avisos incorretos sobre variáveis locais não
inicializadas. Atualmente, é necessário adicionar o parâmetro
**NOWERROR=1** às opções no comando make para gerar os arquivos do
projeto do Visual Studio. Isso impede que os avisos sejam tratados como
erros pois o MSVC não parece ter opções para controlar quais
advertências específicas serão tratadas como erro, ao contrário dos
outros compiladores.


.. raw:: latex

	\clearpage


.. _compiling-issues-entry-point:

Ponto de entrada não encontrado
-------------------------------

Caso o seu **sdlmame.exe** mostre um erro como este ou algo
parecido:

	.. code-block:: text

		Não foi possível localizar o ponto de entrada do procedimento
		_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEC1Ev na
		biblioteca de vínculo dinâmico D:\MAME\sdlmame.exe.

Devido à alteração feita
`neste commit <https://github.com/mamedev/mame/commit/b0223ac413ccfb0907
be9741168b4cf43fb67fb9>`_, o executável **sdlmame.exe** é compilado de
maneira que ele busque as bibliotecas de que ele precisa para funcionar
no sistema em vez de tê-las embutidas em si.

Assim o executável **sdlmame.exe** busca as seguintes bibliotecas,
``libgcc_s_seh-1.dll``, ``libstdc++-6.dll``, ``libwinpthread-1.dll``,
``libgomp-1.dll`` e ``SDL2.dll``. Todas elas estão dentro do diretório
de instalação do seu MSYS2 (exemplo **D:\\msys64\\mingw64\\bin**). É
possível adicionar este caminho nas variáveis de ambiente do Windows
usando o procedimento abaixo:

1. Pressione a tecla com a bandeira do Windows (ela é chamada
   :kbd:`WINKEY`) junto com a tecla :kbd:`Pause`;
2. Clique na opção chamada :guilabel:`Configurações Avançadas do
   Sistema`;
3. Vá em :menuselection:`Avançado --> Variáveis de Ambiente`;
4. Selecione **Path**, clique em **Editar**;
5. Clique em **Novo** e adicione o caminho onde está instalado o seu
   MSYS2;
6. No nosso exemplo é **D:\msys64\\mingw64\\bin**, clique em
   :guilabel:`Ok` para finalizar e feche todas as janelas.

E aqui começa toda a confusão: se você baixou a `ferramenta de
compilação oficial do MAME`_, ela já vem com uma versão do arquivo
**libstdc++-6.dll**. Porém, se você compilar o seu SDL MAME com ela e,
tempos depois, atualizar o seu MSYS2, a versão do seu libstdc++-6.dll
será diferente daquela que você compilou o seu SDL MAME, e o problema
ocorrerá.

Para solucionar o problema, basta compilar uma nova versão do MAME,
que utilizará a versão atualizada do arquivo libstdc++-6.dll. Se não
quiser lidar com variáveis de ambiente, é possível também copiar as
bibliotecas listadas acima para o diretório onde se encontra o seu SDL
MAME.

Outra maneira de corrigir o problema sem alterar as variáveis de
ambiente do Windows é copiar as seguintes DLLs para a mesma pasta do seu
**sdlmame.exe**:

	.. code-block:: text

		libgcc_s_seh-1.dll
		libgomp-1.dll
		libstdc++-6.dll
		libwinpthread-1.dll
		SDL2.dll
		SDL2_ttf.dll

Observe que, até a presente versão deste texto, essas são as DLLs
solicitadas pela versão SDL do MAME. No entanto, é possível que o MAME
solicite outras DLLs em determinado momento. Se alguma DLL estiver
faltando, o próprio Windows exibirá uma mensagem de erro informando qua
DLL está ausente ao executar o sdlmame.exe. Nesse caso, vá até a
pasta **C:\\msys64\\mingw64\\bin** e copie a DLL faltante para dentro
da pasta do MAME.

	.. note:: Após o commit `21defbe`_ a lincagem estática com o SDL3
	   foi corrigida.


.. _compiling-unusual:

Configurações para compilações não ortodoxas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _compiling-llvm:

Lincando com o LLVM linker
--------------------------

Geralmente, o LLVM linker é mais rápido que o GNU linker utilizado pelo
GCC. Isso fica mais evidente em sistemas com uma elevada sobrecarga de
operações de arquivos do sistema, como o Microsoft Windows, ou ao
compilar em um disco compartilhado na rede, por exemplo. Para utilizar o
*LLVM linker* com o GCC, certifique-se de tê-lo instalado em seu sistema
e utilize o parâmetro ``OVERRIDE_AR=llvm-ar`` nas opções do compilador,
por exemplo:

	.. code-block:: shell

		OVERRIDE_AR=llvm-ar


Usando libc++ no Linux
----------------------

O MAME pode ser compilado usando a biblioteca padrão C++ "libc++" do
projeto LLVM. Para isso, é necessário ter uma instalação funcional do
clang/LLVM no sistema e a biblioteca de desenvolvimento libc++. No
Linux Fedora, os pacotes necessários são: **libcxx**, **libcxx-devel**,
**libcxxabi** e **libcxxabi-devel**. No Debian, os pacotes são:
**libc++1**, **libc++-dev** e **libc++abi-dev**. Defina os compiladores
como sendo ``clang`` para C e ``clang++`` para C++, assim como o
``-stdlib=libc++`` nas opções do compilador C++ e do seu lincador. O
comando completo ficará assim:

	.. code-block:: shell

		env LDFLAGS=-stdlib=libc++ make OVERRIDE_CC=clang OVERRIDE_CXX=clang++ ARCHOPTS_CXX=-stdlib=libc++ ARCHOPTS_OBJCXX=-stdlib=libc++

Ou em caso de erro, tente:

	.. code-block:: shell

		env LDFLAGS=-stdlib=libc++ make OVERRIDE_CC=clang OVERRIDE_CXX=clang++ ARCHOPTS_OBJCXX=-stdlib=libc++ LDOPTS=-fuse-ld=lld -stdlib=libc++

As opções depois do comando make, podem ser armazenadas em um
makefile personalizado como descrito em :ref:`PREFIX_MAKEFILE
<mame-compilation-premake>`.


Usando uma instalação do GNU GCC libstdc++ que esteja fora do local tradicional no Linux
----------------------------------------------------------------------------------------

É possível que o GNU GCC tenha sido compilado e instalado em um local
diferente caso o responsável pela compilação utilize a opção
``--prefix=`` juntamente com o comando configure. Isso pode ser útil
caso você queira compilar o MAME em uma distribuição Linux que ainda use
a versão do GNU libstdc++ anterior ao C++20. Para compilar o MAME com
uma versão alternativa do GNU GCC instalada no sistema, é necessário
definir o caminho completo dos compiladores C (gcc) e C++ (g++), bem
como o caminho completo da biblioteca do sistema. Supondo que o GNU GCC
esteja instalado em **/opt/local/gcc72**, use o comando de compilação
como mostrado abaixo:

	.. code-block:: shell

		make OVERRIDE_CC=/opt/local/gcc72/bin/gcc OVERRIDE_CXX=/opt/local/gcc72/bin/g++ ARCHOPTS=-Wl,-R,/opt/local/gcc72/lib64

Essas configurações podem ser armazenadas em um makefile personalizado
como descrito em :ref:`PREFIX_MAKEFILE <mame-compilation-premake>` caso
pretenda utilizá-las regularmente..


.. raw:: latex

	\clearpage

O MAME travou, o que fazer?
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Investigando e lidando com problemas comuns
-------------------------------------------

A princípio, é preciso saber se a causa do problema está no MAME, se é
algum bug interno ou se vem de alguma configuração externa. A primeira
coisa a se fazer é eliminar possíveis *culpados*. Se você alterou algum
tipo de configuração, comece renomeando o seu **mame.ini** para
**_mame.ini**. Isso faz com que o MAME não encontre mais o seu arquivo
de configuração e use as configurações predefinidas internamente. outra
maneira de fazer isso é executar o MAME via linha de comando usando a
opção :ref:`-norc <mame-commandline-noreadconfig>`. Exemplo:

.. code-block:: shell

	mame -norc -rompath caminho_minhas_roms -window

Se o problema persistir, crie um novo **mame.ini** com o comando:

.. code-block:: shell

	mame.exe -createconfig

Adicione uma a uma as suas configurações no editor de texto de sua
preferência, sempre testando com o MAME cada alteração adicionada até
identificar o problema.

Supondo que o problema não tenha sido com o arquivo de configuração,
verifique se as pastas **bgfx**, **hlsl** e **hash** foram atualizadas.
Isso é comum entre aqueles que compilam sua própria versão
do MAME e se esquecem de atualizar o conteúdo dessas pastas no
dispositivo que estão usando ou até mesmo em outro lugar onde o MAME
esteja sendo executado. Isso, porém, não acontece com quem baixa a
versão já compilada do MAME do site oficial.

Experimente apagar o arquivo de configuração do último sistema
executado, que fica na pasta **cfg**, e também o arquivo de memória
da pasta **nvram**. Em ambas as pastas, o nome do arquivo ou a
pasta será a mesma que o nome do sistema usado. Supondo que houve
problemas com o sistema *Street Fighter Alpha*, apague a pasta
**sfa** na pasta *nvram** e o arquivo **sfa.cfg** na pasta cfg.
Verifique se não existe nenhuma configuração personalizada dentro da
pasta **ini**. Caso exista, experimente mover este arquivo para
um outro lugar.

É provável que, após uma atualização da versão GIT, o MAME tenha se
"quebrado". Ao acompanhar o `desenvolvimento do MAME diariamente`_, você
verá que, durante todo o dia, vários desenvolvedores estão enviando
novos commits com melhorias e correções. Esse é o risco de se utilizar a
versão GIT, pois se trata de uma versão instável, e a qualquer momento
algo pode deixar de funcionar.

O driver de vídeo pode causar problemas, como incompatibilidade com o
Direct3D, e os casos variam muito. A melhor maneira de descartar isso é
testar o MAME usando uma outra opção de vídeo. Se estiver usando a opção
``-video d3d`` (Windows) ou ``-video`` opengl (Linux e macOS), tente
a opção ``-video`` soft. Para outras opções, consulte
:ref:`-video <mame-commandline-video>`.


.. raw:: latex

	\clearpage


.. _compiling-advanced-options-debug:

A tela de travamento
--------------------

Junto aos binários do MAME existe um arquivo de símbolos chamado
**mame.sym**. Esses arquivos já vêm com a versão oficial, e sua criação
durante a compilação :ref:`já foi explicada <mame-compile-symbols>`.

Esses arquivos devem sempre estar junto ao executável do MAME. O arquivo
"**.sym**" é usado para traduzir as referências usadas no código-fonte
junto com os códigos de erro. Embora a maioria não compreenda muito,
esse recurso é útil para os desenvolvedores. Aqui está um exemplo de um
erro que causou a parada do MAME:

	.. code-block:: shell

		Exception at EIP=00000000 (something_state::something()+0x0000): ACCESS VIOLATION
		While attempting to read memory at 00000000
		-----------------------------------------------------
		EAX=00000000 EBX=0fffffff ECX=0fffffff EDX=00000000
		ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
		-----------------------------------------------------
		Stack crawl:
		0012abcd: 00123456 (something_state::something()+0x0000)
		0034ef01: 00789abc (something_state::something()+0x0000)
		E a listagem continua
		...

Sem o arquivo de símbolos o ``something_state::something`` apareceria
como um código hexadecimal sem sentido. Com os símbolos, esses códigos
são traduzidos para algo legível e compreensível para os
desenvolvedores. Caso o MAME trave durante a emulação, uma tela
semelhante aparecerá. Copie e reporte [2]_ o erro no fórum
`MAME testers`_.


.. _compiling-using-gdb:

Usando o gdb
------------

A ideia não é oferecer um manual completo sobre como usar o gdb, mas
apenas o mínimo necessário para se obter um stack trace válido. No
exemplo abaixo, estou usando uma versão de 64 bits do MAME para Linux,
mas o procedimento é o mesmo em qualquer outra plataforma.

Carregue o MAME no GDB com o comando **gdb mame**, e você verá algo
semelhante à tela abaixo:

	.. code-block:: shell

		gdb mame
		GNU gdb (Debian 15.2-1) 15.2
		Copyright (C) 2024 Free Software Foundation, Inc.
		License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
		This is free software: you are free to change and redistribute it.
		There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
		and "show warranty" for details.
		This GDB was configured as "x86_64-linux-gnu".
		Type "show configuration" for configuration details.
		For bug reporting instructions, please see:
		<http://www.gnu.org/software/gdb/bugs/>.
		Find the GDB manual and other documentation resources online at:
		<http://www.gnu.org/software/gdb/documentation/>.
		For help, type "help".
		Type "apropos word" to search for commands related to "word"...
		Reading symbols from mame...done.
		>>>

Para iniciar o sistema com problema, execute ``run`` seguido das opções
do MAME, exemplo:

	.. code-block:: shell

		(gdb) run kof99
		Starting program: /home/seu_usuário/mame kof99
		[Thread debugging using libthread_db enabled]
		Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
		[New Thread 0x7fffe4f6c700 (LWP 21026)]
		[New Thread 0x7fffe4531700 (LWP 21027)]
		[New Thread 0x7fffe3d30700 (LWP 21028)]
		[New Thread 0x7fffe352f700 (LWP 21029)]
		[New Thread 0x7fffe2d2e700 (LWP 21030)]
		[New Thread 0x7fffe9ab5700 (LWP 21031)]
		[New Thread 0x7fffe9a74700 (LWP 21032)]

O exemplo dado foi com **kof99**, mas pode ser com qualquer outro sistema
que tenha apresentado problema. Use o sistema até que o MAME trave,
quando será exibida uma tela como a do exemplo abaixo:

	.. code-block:: shell

		Thread 1 "mame" received signal SIGSEGV, Segmentation fault.
		_int_malloc (av=av@entry=0x7ffff459fb00 <main_arena>, 
		bytes=bytes@entry=67108864) at malloc.c:3650
		3650 malloc.c: File or directry not found.

Faça o comando **where** para que o gdb liste as possíveis causas:

	.. code-block:: shell

		(gdb) where
		#0  _int_malloc (av=av@entry=0x7ffff459fb00 <main_arena>, 
		bytes=bytes@entry=67108864) at malloc.c:3650
		#1  0x00007ffff4280f64 in __GI___libc_malloc (bytes=67108864) at malloc.c:2928
		#2  0x00007ffff4d7c7a8 in operator new(unsigned long) ()
		from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
		#3  0x000055555cd4f0f3 in __gnu_cxx::new_allocator<unsigned char>::allocate ()
			at /usr/include/c++/6/ext/new_allocator.h:104
		#4  std::allocator_traits<std::allocator<unsigned char> >::allocate ()
			at /usr/include/c++/6/bits/alloc_traits.h:436
		#5  std::_Vector_base<unsigned char, std::allocator<unsigned char> >::_M_allocate () at /usr/include/c++/6/bits/stl_vector.h:170
		#6  std::_Vector_base<unsigned char, std::allocator<unsigned char> >::_M_create_storage () at /usr/include/c++/6/bits/stl_vector.h:185
		#7  std::_Vector_base<unsigned char, std::allocator<unsigned char> >::_Vector_base () at /usr/include/c++/6/bits/stl_vector.h:136
		...
		#25 0x00005555591df406 in main () at ../../../../../src/osd/sdl/sdlmain.cpp:217

O comando acima é suficiente para gerar informações que podem ser
copiadas e enviadas para os desenvolvedores. No exemplo acima, ele foi
cortado entre o item #7 e #25. Para versões do MAME baixadas do site
oficial, envie essas informações para o grupo `MAME testers`_. Já no
caso de versões GIT, as informações devem ser enviadas para o `mamedev
no GitHub`_. Lembre-se de que os relatórios devem ser feitos
obrigatoriamente em inglês. Para interromper o processo, basta
pressionar :kbd:`C` e depois :kbd:`Enter`; a tela do MAME será fechada.
Para sair do GDB, digite **quit**.

Uma outra opção para o GDB é a utilização de interfaces que ajudam a
organizar a saída do GDB, como a `GDB Dashboard`_. Com ela, a saída do
GDB fica colorida e mais organizada, exibindo todos os valores mais
relevantes dos registros, código-fonte etc.


.. raw:: latex

	\clearpage


.. code-block:: shell

		  ─── Output/messages ────────────────────────────────────────────────────────────
		  ─── Assembly ───────────────────────────────────────────────────────────────────
		0x0000555555e33409 ? mov    %rsi,-0x70(%rbp)
		0x0000555555e3340d ? mov    %edx,-0x74(%rbp)
		0x0000555555e33410 ? mov    %ecx,-0x78(%rbp)
		0x0000555555e33413 ? lea    -0x39(%rbp),%rax
		0x0000555555e33417 ? mov    %rax,%rdi
		0x0000555555e3341a ? callq  0x5555558de53e <std::allocator<unsigned char>::allocator()>
		0x0000555555e3341f ? mov    -0x74(%rbp),%ecx
		  ─── Expressions ────────────────────────────────────────────────────────────────
		  ─── History ────────────────────────────────────────────────────────────────────
		  ─── Memory ─────────────────────────────────────────────────────────────────────
		  ─── Registers ──────────────────────────────────────────────────────────────────
		rax 0x0000555558945ef0     rbx 0x0000555555e45bbd     rcx 0x0000000000000000 
		rdx 0x0000000004000000     rsi 0x00007fff9ffff010     rdi 0x0000555558945ef0 
		rbp 0x00007fffffff5900     rsp 0x00007fffffff5870      r8 0x0000000000000001 
		r9 0x0000000000000001     r10 0x0000000000000000     r11 0x0000000000000000 
		r12 0x0000000000080000     r13 0x0000000000080000     r14 0x00007fffd10e7010 
		r15 0x0000000001000000     rip 0x0000555555e33413  eflags [ IF ]             
		cs 0x00000033              ss 0x0000002b              ds 0x00000000         
		es 0x00000000              fs 0x00000000              gs 0x00000000         
		  ─── Source ─────────────────────────────────────────────────────────────────────
		499 
		500 
		501 void cmc_prot_device::gfx_decrypt(uint8_t* rom, uint32_t rom_size, int extra_xor)
		502 {
		503     int rpos;
		504     std::vector<uint8_t> buf(rom_size);
		505 
		506     // Data xor
		507     for (rpos = 0; rpos < rom_size/4; rpos++)
		508     {
		509         decrypt(&buf[4*rpos+0], &buf[4*rpos+3], rom[4*rpos+0], rom[4*rpos+3], type0_t03, type0_t12, type1_t03, rpos, (rpos>>8) & 1);
		  ─── Stack ──────────────────────────────────────────────────────────────────────
		[0] from 0x0000555555e33413 in cmc_prot_device::gfx_decrypt at ../../../../../src/devices/bus/neogeo/prot_cmc.cpp:504
		(no arguments)
		[1] from 0x0000555555e3392c in cmc_prot_device::cmc42_gfx_decrypt at ../../../../../src/devices/bus/neogeo/prot_cmc.cpp:566
		(no arguments)
		[+]
		  ─── Threads ────────────────────────────────────────────────────────────────────
		[1] id 2509 name neogeo64 from 0x0000555555e33413 in cmc_prot_device::gfx_decrypt at ../../../../../src/devices/bus/neogeo/prot_cmc.cpp:504
		  ────────────────────────────────────────────────────────────────────────────────

A instalação é simples: basta salvar o **.gbdinit** em sua pasta
pessoal. Para que a informação do código-fonte (source) apareça como no
exemplo acima, é necessário que o caminho completo onde o MAME foi
compilado ainda exista. Ou seja, depois de compilar o MAME, não faça um
**make clean**; deixe-o como está, assim o gdb encontrará o que precisa.

A *GDB Dashboard* é personalizável, oferece plug-ins e outras
configurações que atendam às suas necessidades caso queira se envolver
com o desenvolvimento ou outras funções do gdb que não serão abordadas
aqui.


.. raw:: latex

	\clearpage

Se nada aparecer no Source Code junto com uma mensagem de erro:

.. code-block:: shell

	2509 prot_cmc.cpp File or directry not found.

Ainda dentro do gdb indique o caminho completo para o código-fonte do
MAME com o comando ``directory``:

.. code-block:: shell

	directory /home/seu_usuário/src/mame

Outra maneira de facilitar é copiando apenas o arquivo do código-fonte
para a mesma pasta do MAME, assim você não precisa usar o **directory**.


.. _compiling-using-asan:

Usando o AddressSanitizer
-------------------------

Quando tudo parece perdido, chega a hora de praticamente chutar o balde.
Há momentos em que não há um *stack trace*, ou se há, não é informativo
o suficiente para que os desenvolvedores tenham informações úteis.

Apesar de a opção estar disponível nas configurações, ela não é
publicada, nem seu uso é incentivado. Talvez a explicação seja mais
simples do que parece: ao ativar o `AddressSanitizer`_, o MAME rodará
bem mais lento, pois o AddressSanitizer é um detector de erros de
memória para C/C++.

Instale com o comando:

	.. code-block:: shell

		sudo apt-get install clang-19 libclang-common-19-dev libclang1-19 liblldb-19 lldb-19 python3-lldb-19 libllvm19 llvm-19 llvm-19-tools

Rode os comandos abaixo para adicionar as configurações ao arquivo
``~/.bashrc``:

	.. code-block:: shell

		echo "export ASAN_OPTIONS=symbolize=1" >> ~/.bashrc
		echo "export ASAN_SYMBOLIZER_PATH=/usr/lib/llvm-19/bin/llvm-symbolizer" >> ~/.bashrc


Caso a sua distribuição seja diferente, faça o comando
``locate llvm-symbolizer`` para saber o caminho completo do seu
**llvm-symbolizer** e adicione ao **ASAN_SYMBOLIZER_PATH**.

Recarregue as configurações do seu terminal com o comando:

	.. code-block:: shell

		. .bashrc

Ou encerre a seção e faça login novamente. Compile o MAME como mostra o
exemplo abaixo:

	.. code-block:: shell

		make clean && make OVERRIDE_CC=/usr/bin/clang OVERRIDE_CXX=/usr/bin/clang++ OPTIMIZE=0 SYMBOLS=1 SYMLEVEL=1 SANITIZE=address DEBUG=1 -j7

.. raw:: latex

	\clearpage

Ao rodar o MAME com o sistema com problema, você terá um retorno
semelhante ao exemplo abaixo:

.. code-block:: shell

		==2227==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7f6b8d4a6800 at pc 0x0000019a963e bp 0x7ffd4dd2d450 sp 0x7ffd4dd2d448
		READ of size 2 at 0x7f6b8d4a6800 thread T0
			#0 0x19a963d in sma_prot_device::kof99_decrypt_68k(unsigned char*) /home/seu_usuário/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/prot_sma.cpp:426:24
			#1 0x15e7b10 in neogeo_sma_kof99_cart_device::decrypt_all(unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int) /home/seu_usuário/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/sma.cpp:75:14
			#2 0x15e7cd5 in non-virtual thunk to neogeo_sma_kof99_cart_device::decrypt_all(unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int) /home/seu_usuário/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/sma.cpp
			#3 0x6232c5 in neogeo_cart_slot_device::late_decrypt_all() /home/seu_usuário/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/slot.h:327:48
		...
		SUMMARY: AddressSanitizer: heap-buffer-overflow /home/seu_usuário/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/prot_sma.cpp:426:24 in sma_prot_device::kof99_decrypt_68k(unsigned char*)
		Shadow bytes around the buggy address:
		0x0fedf1a8ccb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		0x0fedf1a8ccc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		0x0fedf1a8ccd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		0x0fedf1a8cce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		0x0fedf1a8ccf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
		=>0x0fedf1a8cd00:[fa]fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
		0x0fedf1a8cd10: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
		0x0fedf1a8cd20: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
		0x0fedf1a8cd30: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
		0x0fedf1a8cd40: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
		0x0fedf1a8cd50: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
		Shadow byte legend (one shadow byte represents 8 application bytes):
		Addressable:           00
		Partially addressable: 01 02 03 04 05 06 07 
		Heap left redzone:       fa
		Freed heap region:       fd
		Stack left redzone:      f1
		Stack mid redzone:       f2
		Stack right redzone:     f3
		Stack after return:      f5
		Stack use after scope:   f8
		Global redzone:          f9
		Global init order:       f6
		Poisoned by user:        f7
		Container overflow:      fc
		Array cookie:            ac
		Intra object redzone:    bb
		ASan internal:           fe
		Left alloca redzone:     ca
		Right alloca redzone:    cb
		==2227==ABORTING

.. [1]	No Inglês ABI ou `Application Binary Interface
		<https://pt.wikipedia.org/wiki/Interface_binária_de_aplicação>`_.
		(Nota do tradutor)
.. [2]	Pedimos a gentileza de relatar os problemas encontrados em
		Inglês. (Nota do tradutor)
.. _Wayland: https://wayland.freedesktop.org/
.. _MAMEDEv em 31/12/2023: https://github.com/mamedev/mame/commit/d5340b8be45db2815a6ce152813d991efa93d54f
.. _DirectX SDK: https://www.microsoft.com/en-US/download/details.aspx?id=6812
.. _arquivos não rastreados: https://github.com/git/git/commit/ee6fc514f2df821c2719cc49499a56ef2fb136b0
.. _ccache: https://ccache.dev/
.. _AddressSanitizer: https://github.com/google/sanitizers/wiki/AddressSanitizer
.. _SDL: https://www.libsdl.org
.. _MSYS2: https://www.msys2.org
.. _Arch Linux: https://wiki.archlinux.org/index.php/Pacman
.. _LLVM: https://llvm.org
.. _xcodereleases.com: https://xcodereleases.com
.. _downloads para o macOS: https://www.python.org/downloads/macos
.. _Python 3.13.1: https://www.python.org/downloads/release/python-3131
.. |sefo| replace:: Se for definido como
.. _paralelização implícita: https://pt.wikipedia.org/wiki/OpenMP
.. _OpenMP: https://www.openmp.org/
.. _FAQ oficial do MAME: https://wiki.mamedev.org/index.php/FAQ:Performance
.. |doce| replace:: do seu sistema em vez de usar a versão que acompanha o MAME
.. _ferramenta de compilação oficial do MAME: https://www.mamedev.org/tools/
.. _desenvolvimento do MAME diariamente: https://github.com/mamedev/mame/commits/master
.. _MAME testers: https://mametesters.org/view_all_bug_page.php
.. _mamedev no github: https://github.com/mamedev/mame/issues
.. _GDB Dashboard: https://github.com/cyrus-and/gdb-dashboard
.. _wiki do Arch Linux: https://wiki.archlinux.org/index.php/Pacman
.. _21defbe: https://github.com/mamedev/mame/commit/21defbea953c36bba6eeec5ea6f7cf6d3cd310d8
