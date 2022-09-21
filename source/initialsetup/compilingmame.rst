.. Quebra de página para separar o capítulo
.. raw:: latex

	\clearpage

.. _compiling-MAME:

Compilando
==========

.. contents:: :local:

.. Quebra de página para separar a tabela de capítulos.
.. raw:: latex

	\clearpage


Primeiros passos
----------------

Caso nunca tenha compilado o MAME antes, não sabe por onde começar e
está completamente perdido, este documento irá te ajudar com o mínimo
necessário para que tenha sucesso na sua primeira compilação do MAME.

Antes, alguns pontos importantes:

* É necessário um compilador C++17 e suas respectivas bibliotecas, a
  versão mínima aceitável do GCC é a versão 7.2 ou mais recente, para o
  clang é necessário a versão 5 ou mais recente. O executável do MAME
  rodará com a biblioteca GNU libstdc++ versão 7.2 ou mais recente.

* A versão nativa do MAME roda no Windows, então uma grande ênfase será
  dada a compilação neste sistema operacional.

* O **git** é a melhor maneira para baixar o código fonte do MAME e
  mantê-lo atualizado. Antigamente era preciso baixar o código fonte
  do site oficial, aplicar dezenas de correções (patch) para que o
  mesmo fosse atualizado e corrigido, quando eram aplicados fora da
  ordem, geravam outros problemas.
  
  Hoje o processo é automatizado com o git, com um simples comando ele
  vai baixar todo o código fonte assim como aplicar todas as
  alterações feitas ao código de maneira organizada e bem controlada.
  
  Cada nova modificação que é enviada ao código fonte do MAME e
  autorizada pelos administradores, o servidor conta como sendo
  **1 commit** ou 1 envio.

* **make** é o comando que faz o papel do *mestre de cerimonias*, é ele
  quem vai repassar todos comandos ou opções que vierem depois dele para
  o compilador e outras ferramentas.
  
  Digite *make* no diretório raiz onde se encontra o código fonte do
  MAME para que ele leia as instruções contidas num arquivo chamado
  **Makefile** para que uma versão do MAME seja compilada, observe que
  é possível usar outras opções fazendo com que a compilação do MAME
  seja customizada e atenda as suas necessidades, como, por exemplo, se
  beneficiar das propriedades do seu processador dentre outras opções
  que será mostrada mais adiante.


  As opções devem **sempre** ser adicionadas depois do comando **make**
  como mostra o exemplo abaixo:

		``make VERBOSE=1``

  Várias outras opções podem ser adicionadas desde que estejam separadas
  por espaço, abra o arquivo **makefile** num editor de texto e veja
  quais são aquelas que estão disponíveis.

* Algumas vezes o processo de compilação é interrompido antes de chegar
  ao fim, os motivos são os mais diversos, pode ser a falta de alguma
  biblioteca, um erro de configuração em algum lugar, uma atualização do
  código fonte onde algum desenvolvedor deixou passar algo
  desapercebido, enfim, estes são problemas comuns encontrados durante a
  compilação do MAME.
  
  Caso o processo tenha parado, nos terminais linux e no MSYS2 clique na
  tecla cima do teclado para repetir o comando anterior seguido de
  **Enter**.
  Geralmente a compilação continua sem maiores problemas, porém, caso
  pare novamente no mesmo lugar, pode haver algum outro problema que
  exija a intervenção de um desenvolvedor.
  
  Se a versão que esteja tentando compilar seja a GIT, aguarde algumas
  horas ou, um dia inteiro até que os desenvolvedores resolvam o
  problema. Nestes casos não é necessário reportar o erro, pois o código
  fonte do MAME no GIT é atualizado a todo instante.

* Para que o código fonte do MAME possa ser compilado, há toda uma
  estrutura que precisa estar configurada no momento que o comando
  **make** é executado, incluindo diversos outros parâmetros de 
  compilação. Sempre que um novo parâmetro for adicionado ou removido,
  quando o código fonte de um driver for adicionado, atualizado,
  renomeado, removido e assim por diante, todos os arquivos do projeto
  responsáveis pela compilação precisam ser atualizados através da
  opção **REGENIE=1**.

.. raw:: latex

	\clearpage

* Durante o processo de compilação são gerados arquivos objetos ***.o**,
  arquivos de arquivamento ***.a** dentre vários outros, é importante
  que seja feito um **make clean** sempre após uma atualização do código
  fonte do MAME com o comando ``git pull`` quando for fazer uma
  :ref:`compilação cruzada <mame-crosscompilation>` ou quando for
  personalizar uma compilação.

  Esta opção faz com que todo o diretório **build** seja apagado, este
  diretório nada mais é do que um espaço auxiliar usado pelo processo
  de compilação.

  É possível atualizar o código fonte com o comando ``git pull`` seguido
  de um ``make REGENIE=1`` para compilar apenas os novos códigos fontes
  que foram adicionados, atualizados (etc) e aproveitar os arquivos já
  compilados, porém, algumas vezes isso pode causar erros de compilação.
  É uma boa prática fazer um **make clean** antes do **make** para
  evitar qualquer residual das compilações anteriores.

* Use dois comandos em sequência com **&&** como é mostrado abaixo:
  
		``make clean && make <opções>``
  
  Assim faz com que o segundo comando apenas seja executado quando o
  primeiro terminar. Caso a compilação pare por algum erro, tente
  repetir apenas o comando **make**.

* As opções usada pelo make podem ser adicionadas num arquivo
  **useroptions.mak**. Muito útil em casos onde a lista de opções para
  a compilação são grandes e repetitivas, dentro do arquivo as opções se
  organizam da seguinte maneira::

	OPÇÃO1=X
	OPÇÃO2=Y
	OPÇÃO3=Z

  Onde X, Y ou Z são os valores das opções usadas independente para cada
  tipo de opção, como por exemplo ``SSE2=1`` que irá se beneficiar das
  propriedades do seu processador caso ele seja compatível com as
  extensões **SSE2** e assim por diante.

* O MAME acompanha algumas ferramentas adicionais que poderão ser úteis
  em algum momento, caso queira que tais ferramentas também sejam
  compiladas junto com o MAME, adicione a opção ``TOOLS=1``. Para mais
  informações sobre cada uma dessas ferramentas e de como usá-las, veja
  :ref:`mame-aditional-tools`.

* Nas versões compiladas do git (versão GIT), a versão do MAME acompanha
  um identificador único depois da versão, por exemplo::

	./mame -help
	MAME v0.205 (mame0205-540-gc8e4dab20c)

  Onde:
  
	**mame0205** - É a versão atual do MAME.

	**540** - Indica a quantidade de **commits** ou a quantidade de
	atualizações aplicadas ao código fonte desde a última mudança de
	versão.

	**gc8e4dab20c** - São os primeiros 10 dígitos do último **commit**.

.. raw:: latex

	\clearpage

* O git mantém um controle de todos os arquivos do código fonte,
  qualquer alteração que não tenha sido feita pelos administradores a
  versão do seu MAME incluirá um identificador **dirty** no final::

	./mame -help
	MAME v0.205 (mame0205-540-gc8e4dab20c-dirty)

  O problema ocorre também caso exista algum residual antigo vindo de
  outra compilação, de não fazer um ``make clean`` antes de uma nova
  compilação, `arquivos não rastreados <https://github.com/git/git/commit/ee6fc514f2df821c2719cc49499a56ef2fb136b0>`_
  dentro do diretório de trabalho do código fonte ou até mesmo quando há
  arquivos alterados que por algum motivo não foram aplicados,
  exemplo::

	git status --short
	
	M bgfx/shaders/essl/chains/crt-geom/fs_crt-geom-deluxe.bin
	M bgfx/shaders/essl/chains/crt-geom/fs_crt-geom.bin
	...
	?? language/Afrikaans/strings.mo
	?? language/Albanian/strings.mo
	...

  A letra **M** indica que o arquivo foi alterado, já **??** indica
  os novos arquivos que foram criados. Independente do que tenha
  acontecido, execute ``git commit -a`` para aplicar estas alterações.
  
  Agora ao pedir o status do git, ele deve retornar informando que está
  tudo limpo::

	git status
	On branch master
	Your branch is up-to-date with 'origin/master'.
	nothing to commit, working tree clean

  Caso não funcione, execute a opção abaixo com todos os arquivos que
  vierem a aparecer ao fazer um **git status**::

	git checkout 3rdparty/winpcap/Lib/libpacket.a 3rdparty/winpcap/Lib/libwpcap.a

  Caso nenhum dos comando acima funcione e depois de ter absoluta
  certeza de que nada tenha sido alterado, experimente o comando
  ``git clean -d -x -f``, note que o comando vai apagar tudo o que não
  seja relacionado com o código fonte do MAME, isso incluí o seu
  **useroptions.mak** ou qualquer outro arquivo que ali esteja.
  Portanto, faça um **backup** antes de executar o comando!

  Vamos supor que o arquivo abaixo tenha sido alterado por qualquer
  motivo::

	git status
	On branch master
	Your branch is up-to-date with 'origin/master'.
	Changes not staged for commit:
	(use "git add <file>..." to update what will be committed)
	(use "git checkout -- <file>..." to discard changes in working directory)

		modified:   scripts/src/osd/sdl_cfg.lua

	no changes added to commit (use "git add" and/or "git commit -a")

  Execute o comando abaixo para restaurá-lo ao seu estado original::

	git checkout master -- scripts/src/osd/sdl_cfg.lua

.. _mame-compilation-ccache:

Acelerando uma compilação
~~~~~~~~~~~~~~~~~~~~~~~~~

Compilar todo o código fonte do MAME é um processo demorado e que
consome muitos recursos de processamento, memória e principalmente
energia elétrica. É possível acelerar todo este processo usando o
**ccache**, este programa armazena uma cópia da sua compilação, fazendo
com que apenas o código fonte que foi atualizado seja compilado, todo
o resto vem do armazenamento que o **ccache** fazendo com que a
compilação termine num tempo muito menor, estamos falando em compilar
todo o código fonte do MAME em segundos com o **ccache**, sem ele,
uma compilação pode levar horas.

Para sistemas **Ubuntu** e **Debian Linux** o comando para instalar o
**ccache** é ``sudo apt-get install ccache``, para **Arch Linux** e
**MSYS2** o comando é ``pacman -s ccache``, veja qual é a opção para o
seu sistema operacional.

A configuração é muito simples, basta usá-lo antes dos compiladores, é
mais fácil adicionar essas opções no arquivo **useroptions.mak** assim
não é necessário usar uma linha muito grande de configuração, para o
Linux a configuração ficaria assim::

	# Escolha apenas uma opção para OVERRIDE_CC e OVERRIDE_CXX
	# Remova o # da frente da opção que deseja usar.
	#
	# Compila com ccache Linux
	OVERRIDE_CC=/usr/bin/ccache gcc
	OVERRIDE_CXX=/usr/bin/ccache g++
	#
	# Compila com ccache Linux (Clang)
	# CCACHE_CPP2=yes
	# OVERRIDE_CC=/usr/bin/ccache /usr/bin/clang
	# OVERRIDE_CXX=/usr/bin/ccache /usr/bin/clang++

A configuração para Windows no MSYS2 fica assim::

	# Compila com ccache MSYS2 (Windows) 32-Bit
	# OVERRIDE_CC=/mingw32/bin/ccache /mingw32/bin/gcc
	# OVERRIDE_CXX=/mingw32/bin/ccache /mingw32/bin/g++
	#
	# Compila com ccache MSYS2 (Windows) 64-Bit
	# OVERRIDE_CC=/mingw64/bin/ccache /mingw64/bin/gcc
	# OVERRIDE_CXX=/mingw64/bin/ccache /mingw64/bin/g++
	#
	# Compila com ccache MSYS2 (Windows) 64-Bit (Clang)
	# OVERRIDE_CC=/mingw64/bin/ccache /mingw64/bin/clang
	# OVERRIDE_CXX=/mingw64/bin/ccache /mingw64/bin/clang++

Para ver a condição do armazenamento cache faça ``ccache -s``::

	cache directory                     /home/mame/.ccache
	primary config                      /home/mame/.ccache/ccache.conf
	secondary config      (readonly)    /etc/ccache.conf
	cache hit (direct)                     0
	cache hit (preprocessed)               0
	cache miss                         14278
	cache hit rate                      0.00 %
	called for link                        2
	no input file                          6
	cleanups performed                     0
	files in cache                     42927
	cache size                           4.9 GB
	max cache size                      10.0 GB

Antes de usar tenha certeza que a variável de ambiente ``USE_CCACHE``
exista e seja igual à **1**, caso não exista, defina com ``export
USE_CCACHE=1`` antes da compilação ou salve no arquivo ``~/.bashrc``
como já foi descrito em :ref:`compiling-msys2-manually`.

Para montar a sua cache basta fazer uma compilação limpa do código fonte
do MAME com ``rm -rf build/* && make -j7``, no final em **cache size**
deve aparecer o quanto foi armazenado em cache. Para aumentar o **max
cache size** edite o arquivo ``/home/mame/.ccache/ccache.conf``.

Para que o **ccache** funcione é **obrigatório** manter exatamente a
mesma configuração usada para gerar o cache, caso contrário o **ccache**
vai gerar um novo cache para essa nova configuração e assim por diante.

Veja todas as opções do **ccache** com o comando ``ccache -h``.

Caso precise usar uma nova opção para a compilação, elimine o cache
antigo com o comando ``ccache -C`` e faça uma nova compilação limpa com
todas as suas novas opções, por experiência, isso tende a manter a
rapidez da compilação, alternar opções a todo o momento tende a inflar
o cache e deixar as coisas mais lentas.

.. _compiling-practical-examples:

Exemplos práticos para todas as plataformas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O código fonte do MAME já vem preparado de forma que seja possível
compilar toda a estrutura ou apenas uma parte dela como arcades por
exemplo, consoles, portáteis ou até mesmo um sistema em específico como
Neo Geo, CPS1, CPS2; assim como consoles como Megadrive/Genesis, Super
Nintendo, Playstation e assim por diante.

Isso é útil quando temos que lidar com limitações de tamanho
do arquivo final do MAME ou caso queira apenas uma versão do MAME
bem específica.

Para compilar a versão completa do MAME faça o comando:

	**make**

Caso o seu processador tenha 5 núcleos, é possível usar os núcleos
extras do seu processador para ajudar a reduzir o tempo de compilação
com a opção ``-j``. Observe que a quantidade máxima de núcleos
disponíveis fica limitado a quantidade de núcleos que o seu processador
tiver mais um.

Usando valores acima da quantidade de núcleos do seu processador não faz
com que a compilação fique mais rápida, além disso, a sobrecarga extra
de processamento pode fazer com que seu processador superaqueça, seu
computador pode ficar mais lento, pare de responder, etc. No caso
específico de compilação no Windows, a sobrecarga tira todo os
benefícios da compilação em paralelo, nos testes realizados com Windows
10 64-bit o valor ideal foi a quantidade de núcleos **-1** ou seja, num
processador com 8 núcleos o valor ideal é **7**.

	**make -j7**

Para compilar o MAME junto com as
:ref:`ferramentas <mame-compilation-tools>`, use a opção abaixo:

	**make TOOLS=1 -j7**

Para incluir os símbolos de depuração na compilação, use a opção
**SYMBOLS=1**, opção útil caso o MAME trave por algum motivo. Para mais
informações veja :ref:`SYMBOLS <mame-compilation-symbols>`. É importante
também adicionar o nível destes símbolos, para mais informações veja
:ref:`SYMLEVEL <mame-compilation-symlevel>`. Seja qual for a versão do
MAME que esteja compilando, é uma boa prática manter ambas as opções em
todas elas. Observe que ao compilar a versão completa do MAME com os
símbolos embutidos no próprio executável extrapola o tamanho máximo do
executável permitido pelo Windows, motivo este que os símbolos precisam
ser extraídos do executável.

.. _mame-compile-add-symbols:

	**make TOOLS=1 SYMBOLS=1 SYMLEVEL=1 -j7**

Para compilar uma versão de depuração do MAME use o comando abaixo, para
mais informações veja :ref:`DEBUG <mame-compilation-debug>`:

	**make TOOLS=1 SYMBOLS=1 SYMLEVEL=1 DEBUG=1 -j7**

É possível customizar a sua compilação escolhendo um driver em
específico usando a opção ``SOURCES=<sistema>``, lembrando que é
obrigatório usar a opção **REGENIE=1** para regenerar os arquivos do
projeto caso exista uma compilação anterior, a opção **REGENIE=1** não é
necessário caso você faça um ``make clean`` antes . Caso queira compilar
uma versão customizada do MAME que só rode o jogo **Pac Man**, use o
comando abaixo:

	**make SOURCES=src/mame/pacman REGENIE=1 -j7**

O MAME também permite de maneira prática que seja possível compilar uma
versão só com sistemas ARCADE, nessa versão os portáteis, consoles,
computadores, dentre outras ficam de fora.
Caso queira uma versão arcade do MAME use o comando abaixo:

	**make SUBTARGET=arcade SYMBOLS=1 SYMLEVEL=1 -j7**

Para compilar uma versão do MAME só com consoles, use o comando abaixo:

	**make SUBTARGET=mess SYMBOLS=1 SYMLEVEL=1 -j7**

Para compilar uma versão do MAME chamada **meumame** apenas com a
família de sistemas inclusas em *Pac-Man* e *Galaxian* incluindo as
ferramentas:

	**make SUBTARGET=meumame SOURCES=src/mame/pacman,src/mame/galaxian TOOLS=1 REGENIE=1 -j7**

Caso encontre erros de lincagem dos arquivos estáticos da compilação
após a alteração das fontes, exclua estes arquivos do diretório
utilizado para a compilação do seu *subtarget*. No exemplo acima, seria
o diretório ``build/mingw-gcc/bin/x64/Release/meumame``.

Para compilar uma versão do Apple II compilando até seis arquivos fonte
em paralelo faça:

	**make SUBTARGET=appulator SOURCES=apple/apple2.cpp,apple/apple2e.cpp,apple/apple2gs.cpp REGENIE=1 -j7**

Para compilar uma versão do MAME que tire proveito da extensão SSE2 do
seu processador melhorando o desempenho, use o comando abaixo. Para
mais informações veja :ref:`SSE2 <mame-compilation-sse2>`:

	**make TOOLS=1 SYMBOLS=1 SYMLEVEL=1 SSE2=1 -j7**

É possível compilar o MAME usando todas as extensões disponíveis do seu
processador e não apenas a SSE2 desde que seja também compatível com o
compilador que estiver usando, use a opção **ARCHOPTS** com
**-march=native** no seu comando de compilação. Ao ativar estas opções
pode ou não tirar o máximo de desempenho possível do seu processador,
assim como o MAME pode ou não se beneficiar de todas elas. O comando
completo então ficaria assim, note que a opção **SSE2=1** foi removida:

	**make SYMBOLS=1 SYMLEVEL=1 ARCHOPTS=-march=native -j7**

O ponto negativo é que os binários gerados com essa opção só irão
funcionar em processadores iguais ao seu, caso compile uma versão num
processador i3 da Intel, essa versão não vai funcionar em qualquer outro
processador i7 por exemplo, o mesmo vale para os processadores da AMD.
Assim como ao ativar estas extensões o seu MAME pode apresentar algum
problema que não existe na versão oficial, logo, a sua sorte com o uso
dela pode variar bastante. Por isso saiba que oficialmente os
desenvolvedores do MAME **não apoiam** o uso dessa opção.

Execute o comando abaixo para saber quais as extensões serão ativadas
com a opção **-march=native**:

	``gcc -march=native -Q --help=target|grep enabled``

Dependendo do modelo do processador o comando retornará mais ou menos
extensões disponíveis, num processador AMD FX(tm)-8350 com 8 núcleos
o **-march=native** vai usar estas extensões do seu processador::

	-m64                        		[enabled]
	-m80387                     		[enabled]
	-m96bit-long-double         		[enabled]
	-mabm                       		[enabled]
	-maes                       		[enabled]
	-malign-stringops           		[enabled]
	-mavx                       		[enabled]
	-mbmi                       		[enabled]
	-mcx16                      		[enabled]
	-mf16c                      		[enabled]
	-mfancy-math-387            		[enabled]
	-mfentry                    		[enabled]
	-mfma                       		[enabled]
	-mfma4                      		[enabled]
	-mfp-ret-in-387             		[enabled]
	-mfxsr                      		[enabled]
	-mglibc                     		[enabled]
	-mhard-float                		[enabled]
	-mieee-fp                   		[enabled]
	-mlong-double-80            		[enabled]
	-mlwp                       		[enabled]
	-mlzcnt                     		[enabled]
	-mmmx                       		[enabled]
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
	-mstackrealign              		[enabled]
	-mtbm                       		[enabled]
	-mtls-direct-seg-refs       		[enabled]
	-mxop                       		[enabled]
	-mxsave                     		[enabled]

Apesar de ter todas essas extensões ativadas, incluindo outras
variantes do SSE como a SSE3, SSE4 e assim por diante, não espere que o
desempenho do MAME aumente de forma considerável, há sistemas onde não
se nota nada de diferente, muito pelo contrário, há perda no
desempenho, já outras podem lhe dar um desempenho considerável.

Em alguns testes a melhor média foi obtida usando apenas as opções
**SSE3=3 OPTIMIZE=03** e mais nada, apesar do padrão do MAME ser
**SSE2=1**. Novamente, essa é uma questão muito subjetiva pois depende
muitas variáveis como a configuração do seu hardware por exemplo, logo a
sua sorte pode variar bastante. É muito difícil saber com precisão se
haverá uma melhora no desempenho ou não pois o MAME depende muito do
desempenho do hardware onde ele é executado (quanto mais potente,
melhor) e do sistema operacional, dos sistemas, etc.

.. raw:: latex

	\clearpage

Podemos fazer um teste prático compilando duas versões do MAME para
rodar apenas o **pacman** usado opções diferentes::

	Opção 1
	make SOURCES=src/mame/pacman SUBTARGET=pacman SSE3=1 OPTIMIZE=3
	
	Opção 2
	make SOURCES=src/mame/pacman SUBTARGET=pacman ARCHOPTS=-march=native OPTIMIZE=3

Rodamos o nosso MAME por 90 segundos num AMD FX(tm)-8350 4 Ghz
(8 núcleos), 16 GiB de memória DDR3 1866 Mhz, AMD R7 250E 1 GiB, Windows
10 x64 usando a opção :ref:`bench <mame-commandline-bench>`:

	``pacman64.exe pacman -bench 90``

Para a **opção 1** ele retorna:

	``Average speed: 6337.43% (89 seconds)``

Para a **opção 2** nós temos:

	``Average speed: 6742.91% (89 seconds)``

Agora compilando o MAME para rodar num Linux Debian 9.7 x64, usando as
mesmas opções, o mesmo driver, o mesmo código fonte e usando exatamente
o mesmo hardware, nós temos um resultado bem diferente:

Para a **opção 1** nós temos:

	``Average speed: 8438.88% (89 seconds)``

Já a **opção 2**:

	``Average speed: 8332.99% (89 seconds)``

Ambas as versões foram compiladas usando a mesma versão do GCC **6.3.0**
do Debian, uma versão foi compilada nativamente e a outra usando
:ref:`compilação cruzada <mame-crosscompilation>`. Como é possível ver
nestes exemplos a questão de otimização do MAME não é uma ciência exata,
apesar da versão do Linux ter levado a melhor, há casos onde dependendo
do sistema escolhido, a versão do Windows leva a melhor, assim como
também há casos onde há um empate técnico, nenhum dos dois levam
vantagens significativas.

Para aqueles que se interessarem por benchmarks, `aqui tem um site
<http://www.mameui.info/Bench.htm>`_ interessante que publica de tempos
em tempos e inclusive uma versão diária do GIT, uma comparação com
diferentes sistemas e diferentes versões do MAME.

Use estas opções em conjunto com o comando make ou definindo-as como
variáveis de ambiente ou ainda adicionando-as ao seu
**useroptions.mak**. Note que o GENie não reconstrói automaticamente os
arquivos afetados por modificações posteriormente usadas.

Com o tempo e experiência, cada um irá adaptar as opções de compilação
para a sua própria necessidade, no exemplo abaixo tem um template para
o seu **useroptions.mak**::

	# Template de configuração do usuário para a compilação do MAME.
	# Altere as opções conforme a sua necessidade. Remova o # da frente
	# da opção que deseja usar.
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
	# Use a opção abaixo para compilar uma versão 64-bit do MAME, não
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

Com o arquivo acima configurado e com as opções definidas, execute o
comando ``make -j7`` que o seu MAME será compilado levando as suas
opções em consideração. A próxima seção resume algumas das opções úteis
reconhecidas pelo makefile.

.. raw:: latex

	\clearpage

.. _compiling-windows:

Microsoft Windows
-----------------

O MAME para Windows é compilado usando o ambiente MSYS2. Será necessário
o Windows 7 ou mais recente e uma instalação atualizada do MSYS2.
Recomendamos veementemente que o MAME seja compilado num sistema
64-bit, talvez seja necessário fazer ajustes para que a compilação
funcione com sistemas 32-bit.


Configurando o pacote MSYS2 já pronto
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Baixe o pacote de instalação do MSYS2 já pronto contendo todas as
  ferramentas necessárias para a compilação do MAME 
  em `MAME Build Tools <http://mamedev.org/tools/>`_.

* Descompacte em algum lugar, entre no diretório, abra o shell do
  MSYS2 (**mingw64.exe**) e aguarde ele terminar a sua configuração.

  Apesar da recomendação para atualizar as ferramentas na `documentação
  oficial <https://www.mamedev.org/tools/>`_ a  experiência mostra que
  algumas vezes essa atualização acaba quebrando a compilação do MAME de
  alguma maneira, veja por exemplo `este exemplo
  <https://github.com/mamedev/mame/issues/6248>`_, portanto, prefira
  manter a ferramenta oficial sem atualizações a não ser que seja
  extremamente necessário.

  Caso encontre algum problema veja :ref:`compiling-issues-MSYS2`. Ao
  final do processo, execute a sequência de comandos abaixo:

1.	``git config --global core.autocrlf true``
2.	``mkdir /src``
3.	``cd /src``
4.	``git clone https://github.com/mamedev/mame.git``

  O último comando irá baixar todo o código fonte do MAME para um
  diretório chamado **mame**, o caminho completo é ``/src/mame``.

.. _compiling-msys2-osd-sdl:

* Por predefinição o MAME será compilado usando interfaces nativas
  do Windows como gerenciamento de janelas, saída de áudio e vídeo,
  renderizador de fontes, etc. Em vez disso, caso queira compilar
  o MAME usando o SDL (Simple DirectMedia Layer), adicione a
  opção ``OSD=sdl`` nas opções de compilação do make. É necessário que
  seja instalado os pacotes de desenvolvimento do SDL 2 no MSYS2 da
  versão **2.0.6** ou mais recente.

  Caso queira compilar uma verção SDL (Simple DirectMedia Layer) do MAME
  para Windows em vez da versão nativa, instale os pacotes SDL com o
  comando:

  Para versões **x64** ::

	pacman -S mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf

  Para versões **x32** ::

	pacman -S mingw-w64-i686-SDL2 mingw-w64-i686-SDL2_ttf

* Por predefinição o MAME incluirá a versão nativa do depurador para
  Windows, para que também seja incluída a versão Qt do depurador, é
  necessário instalar os pacotes de desenvolvimento do Qt versão 5
  no MSYS2 e depois usar ``QTDEBUG=1`` nas opções de compilação do
  make.

.. raw:: latex

	\clearpage

.. _compiling-msys2-manually:

Preparando a instalação do MSYS2 manualmente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A versão nativa do MAME para Windows é compilada usando o ambiente
de desenvolvimento MSYS2, é necessário ter o Windows 7 ou mais recente
assim como uma versão atualizada do MSYS2. É aconselhável compilar o
MAME num sistema operacional de 64-bit, para sistemas 32-bit é
necessário fazer algumas alterações. Baixe e instale o ambiente de
desenvolvimento MSYS2 direto da página do
`MSYS2 <https://www.msys2.org/>`_.

Por fim é necessário definir as variáveis MINGW32 e MINGW64, instale o
editor de texto nano com o comando ``pacman -S nano``, após a instalação
faça ``nano ~/.bashrc`` e adicione a linha abaixo no final do
arquivo::

		export MINGW32=/mingw32 MINGW64=/mingw64

Salve o arquivo com **CTRL+O** seguido de **ENTER** e faça **CTRL+X**
para sair do editor, essas variáveis de ambiente permitem a compilação
das versões 32-bit e 64-bit do MAME. Feche e abra o terminal novamente
para que essas configurações sejam aplicadas.

Caso ocorra algum erro do tipo **GPGME error**, veja 
:ref:`compiling-issues-MSYS2`. Ao final, **feche a janela** e
reinicie o **mingw64.exe**.

* Instale os primeiros pacotes necessários para compilar o MAME com
  o comando.
  
	**pacman -S bash git make**

* Para as versões **64-bit** do MAME é necessário instalar os
  pacotes:

	**pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-python**

* Para as versões **32-bit** do MAME é necessário instalar os
  pacotes:
  
	**pacman -S mingw-w64-i686-gcc mingw-w64-i686-python**

* Para lincar usando o LLVM linker (é geralmente mais rápido que a
  versão do GNU linker), instale o pacote ``mingw-w64-x86_64-lld`` e o
  ``mingw-w64-x86_64-libc++`` para as versões 64-bit ou o pacote
  ``mingw-w64-i686-lld`` e o ``mingw-w64-i686-libc++`` para as versões
  32-bit. Para mais informações consulte :ref:`compiling-llvm`.

* Para compilar usando as interfaces portáteis do SDL **64-bit** é
  necessário instalar os pacotes:

	**pacman -S mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf**

* Para compilar usando as interfaces portáteis do SDL **32-bit** é
  necessário instalar os pacotes:

	**pacman -S mingw-w64-i686-SDL2 mingw-w64-i686-SDL2_ttf**

* Para compilar o MAME com o depurador Qt **64-bit** é preciso
  instalar o pacote:

	**pacman -S mingw-w64-x86_64-qt5**

* Para compilar o MAME com o depurador Qt **32-bit** é preciso
  instalar o pacote:

	**pacman -S mingw-w64-i686-qt5**

.. note::

	Utilize ``QTDEBUG=1`` nas opções de compilação do make para compilar
	a interface QT do depurador.

* Para gerar a documentação API do código fonte é preciso instalar
  o pacote **doxygen**.

* Para fazer a depuração do MAME é necessário instalar o **gdb**. Para
  mais informações sobre o gdb veja :ref:`compiling-using-gdb`.

.. raw:: latex

	\clearpage

É possível também utilizar estes comandos para garantir que todos os
pacotes necessários para compilar o MAME estejam disponíveis no seu
sistema, omita aqueles cuja configuração você não planeja utilizar para
compilar ou combine diversos comandos **pacman** para instalar mais de
um pacote de uma vez::

	pacman -Syu
	pacman -S curl git make
	pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-libc++ mingw-w64-x86_64-lld mingw-w64-x86_64-python
	pacman -S mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_ttf
	pacman -S mingw-w64-x86_64-qt5
	pacman -S mingw-w64-i686-gcc mingw-w64-i686-libc++ mingw-w64-i686-lld mingw-w64-i686-python
	pacman -S mingw-w64-i686-SDL2 mingw-w64-i686-SDL2_ttf
	pacman -S mingw-w64-i686-qt5

.. raw:: latex

	\clearpage

.. _compiling-issues-MSYS2:

Resolvendo possíveis problemas com o MSYS2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Em caso de erro do tipo **error: GPGME error: Invalid crypto engine**
que faz com que a atualização pare, verá que na internet há diversos
tópicos em centenas de diferentes fóruns sobre o assunto e praticamente
nenhuma solução na prática, então aqui vai a dica para este erro em
específico, caso apareçam outros, este documento será atualizado.

Edite o arquivo ``/etc/pacman.conf`` e mude
**SigLevel = Required DatabaseOptional** para **SigLevel = Never** e
salve, mantenha a tela do seu editor aberto. Vá até o diretório
``/etc/pacman.d`` e apague o diretório **gnupg**.

Abra o shell do MSYS2 (**mingw64.exe**) e digite os comandos abaixo
nesta sequência:

1. ``pacman-key --init``
2. ``pacman-key --populate msys2``
3. ``pacman-key --refresh-keys``

A atualização agora pode prosseguir com o comando ``pacman -Syu``, caso
os passos acima tenham sido seguidos corretamente, haverá um retorno
semelhante ao que é mostrado abaixo:

::

	$ pacman -Syu
	:: Sincronizando a base de dados de pacotes...
	mingw32 está atualizado
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

Pressione "Enter" e aguarde, no final do processo é importante que siga
as instruções, não saia do terminal, feche a janela e abra-a novamente.
Retorne ao seu editor de texto e mude novamente **SigLevel = Never**
para **SigLevel = Required DatabaseOptional**, salve o arquivo e feche o
editor.

Para ter certeza de que não há nenhum erro execute o comando
``pacman -Syu`` novamente::

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

Caso tenha recebido um retorno diferente ou tenha qualquer outro
problema que o impeça de fazer a atualização, verifique se não há
qualquer um `destes programas <https://cygwin.com/faq/faq.html#faq.using.bloda>`_
instalados em seu computador, caso haja, veja se é possível
desativá-los, adicionar uma regra de exclusão do diretório do MSYS2
(**c:\\mysys64** ou **c:\\mysys32**) ou até mesmo removê-los até que
você consiga montar o seu ambiente sem problemas.

Uma outra alternativa interessante seria usar um sistema virtual para
compilar o MAME ou para montar o ambiente sem qualquer erro.

.. note::

	A mesma dica acima serve também para resolver outro erro relacionado
	"chave PGP inválida" (*invalid or corrupted package (PGP
	signature)*). a solução foi apresentada por mim na parte de
	`issues do MSYS2 <https://github.com/msys2/MSYS2-packages/issues/2058#issuecomment-1252446059>`_ 
	Outros usuários também comprovaram que a solução funciona.


.. _compiling-windows-visual-studio:

Compilando com o Microsoft Visual Studio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* É possível gerar projetos compatíveis com o Visual Studio 2019 usando
  o comando **make vs2019**. É predefinido que a solução e o projeto
  serão criados no diretório ``build/projects/windows/mame/vs2019``.
  O nome do diretório **build** pode ser alterado modificando a opção
  ``BUILDDIR``.

  O comando sempre regenera as configurações, logo a opção **REGENIE=1**
  não é necessário.

* Usando a opção **MSBUILD=1** será construído a solução usando o
  *Microsoft Build Engine* após a criação dos arquivos do projeto.
  Observe que é necessário que o ambiente e os caminhos estejam
  corretamente configurados para que o Visual Studio possa encontrá-los.

* Consulte `Usando o conjunto de ferramentas Microsoft C++ na linha de
  comando <https://docs.microsoft.com/pt-br/cpp/build/building-on-the-
  command-line>`_.
  Pode ser que você ache mais fácil carregar o projeto direto na
  interface do Visual Studio do que usar **MSBUILD=1**.

* Ainda que o Visual Studio seja usado é necessário ter também o
  ambiente MSYS2 para gerar os arquivos do projeto, converter os layouts
  internos, compilar as traduções da interface, etc.

.. raw:: latex

	\clearpage

.. _compiling-msys2-observacoes:

Algumas observações sobre o ambiente MSYS2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O MSYS2 utiliza a ferramenta pacman do gerenciador de pacotes do Arch
Linux. Existe uma página no wiki do `Arch Linux
<https://wiki.archlinux.org/index.php/Pacman>`_ com informações
relevantes e que ensinam como usar a ferramenta pacman.

O ambiente MSYS2 incluí dois tipos de ferramentas: As ferramentas MSYS2
desenvolvidas para trabalhar num ambiente semelhante ao UNIX no
Windows e as ferramentas MinGW que foram desenvolvidas para trabalhar em
um ambiente Windows. As ferramentas do MSYS2 são instaladas no
``/usr/bin`` enquanto as ferramentas do MinGW são instaladas no
``/mingw64/bin`` ou ``/mingw32/bin`` sempre relativo ao diretório de
instalação do MSYS2. As ferramentas do MSYS2 trabalham melhor num
terminal do MSYS2 enquanto as ferramentas do MinGW trabalham melhor com
o prompt de comando do Windows.

É possível notar sintomas óbvios quando você roda as ferramentas certas
nos terminais errados quando não há a interatividade dos programas com
as teclas direcionais por exemplo. Caso rode o MinGW gdb ou python a
partir da janela do terminal do MSYS2 por exemplo, o histórico dos
comandos não funcionam e é bem provável que interrompa o funcionamento
dos programas anexados com o gdb. De forma similar, pode ser bem difícil
editar os arquivos com o vim do MSYS2 no prompt de comandos do Windows.

O MAME é compilado usando o compiladores do MinGW, logo, os diretórios
do MinGW são inclusos anteriormente no ambiente de compilação através do
``PATH``. Caso queira utilizar um programa interativo do MSYS2 a partir
de um shell MSYS2, pode ser que seja necessário informar os caminhos
completo para evitar a utilização das ferramentas equivalentes do MinGW.

O gdb do MSYS2 podem ter problemas para depurar programas MinGW como o
MAME. É possível obter melhores resultados ao instalar a versão do gdb
do MinGW e rodá-lo a partir do prompt de comandos do Windows para
depurar o MAME.

O GNU make é compatível com shells de ambos os estilos POSIX (como o
bash por exemplo) e o ``cmd.exe`` da Microsoft. Há um problema a ser
levado em consideração ao utilizar o ``cmd.exe`` da Microsoft pois
comando ``copy`` não verbaliza nada muito útil durante a condição da sua
ação, assim as operação de cópia são geralmente silenciosas. Prefira o
uso de ferramentas como o
`robocopy <https://docs.microsoft.com/pt-br/windows-server/administratio
n/windows-commands/robocopy>`_ que garante a integridade do arquivo do
destino e gera um relatório completo.

Não é possível realizar a compilação cruzada de uma versão 32-bit do
MAME utilizando ferramentas 64-bit do MinGW no Windows pois causa
problemas devido ao tamanho do MAME, portanto, as ferramentas 32-bit do
MinGW devem ser utilizadas. Não é possível lincar uma versão completa do
MAME 32-bit incluindo as versões SDL e o depurador Qt. Ambos os GNU
**ld** e o **ldd** ficarão sem memória gerando um arquivo final que não
funciona. Também não é possível compilar uma versão 32-bit com todos os
símbolos. O GCC pode ficar sem memória e certos arquivos de código fonte
podem extrapolar o limite de **32.768** seções impostas pelo formato
PE/COFF do objeto.

.. raw:: latex

	\clearpage

Linux
-----

.. _compiling-fedora:

Fedora Linux
~~~~~~~~~~~~

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. As versões anteriores ao SDL 2 versão **2.0.6** não possuem a
funcionalidade necessária, certifique-se que a versão mais recente
esteja instalada::

	sudo dnf install gcc gcc-c++ make python SDL2-devel SDL2_ttf-devel libXi-devel libXinerama-devel qt5-qtbase-devel qt5-qttools expat-devel fontconfig-devel alsa-lib-devel pulseaudio-libs-devel llvm

A compilação é exatamente como descrito em
:ref:`compiling-practical-examples`.

.. _compiling-ubuntu:

Debian e Ubuntu (incluindo dispositivos Raspberry Pi e ODROID)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. As versões anteriores ao SDL 2 versão **2.0.6** não possuem a
funcionalidade necessária, certifique-se que a versão mais recente
esteja instalada::

	sudo apt-get install git build-essential python3 libxi-dev libsdl2-dev libsdl2-ttf-dev libfontconfig-dev libpulse-dev qtbase5-dev lld llvm

A compilação é exatamente como descrito em
:ref:`compiling-practical-examples`

.. _compiling-arch:

Arch Linux
~~~~~~~~~~

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. ::

	sudo pacman -S base-devel git sdl2_ttf python libxinerama libpulse alsa-lib qt5-base libxi libpulse

A compilação é exatamente como descrito em
:ref:`compiling-practical-examples`

.. raw:: latex

	\clearpage

.. _compiling-macos:

Apple macOS
-----------

Alguns pré-requisitos são necessários. Certifique-se de estar no
*macOS X 10.14 Mojave* ou mais recente para Intel Macs ou macOS 11.0 Big
Sur para Apple Silicon. Será também necessário o SDL2 **2.0.6** ou mais
recente para Intel ou o **SDL2 2.0.14** no Apple Silicon. Será preciso
também instalar o Python 3 - atualmente está incluso no *Xcode command
line tools*, porém é possível instalá-lo de forma avulsa ou obtê-lo
através do gerenciador de pacotes *Homebrew package manager*.

*	Instale o **Xcode** encontrado no Mac App Store ou o
	`ADC <https://developer.apple.com/download/more/>`_ (é preciso ter o
	AppleID).
*	Para localizar a última versão do Xcode correspondente para a versão
	do seu macOS visite
	`xcodereleases.com <https://xcodereleases.com>`_.
*	Inicie o programa **Xcode**.
*	Será feito o download de alguns pré-requisitos adicionais.
	Deixe rodando antes de continuar.
*	Ao terminar saia do **Xcode** e abra uma janela do **Terminal**
*	Digite o comando ``xcode-select --install`` para instalar o kit
	obrigatório de ferramentas para compilar o MAME (também disponível
	como pacote no ADC).

Em seguida, é preciso baixar e instalar o SDL 2.

*	Vá para `este site <http://libsdl.org/download-2.0.php>`_ e baixe o
	arquivo .dmg para o *macOS*.
*	Caso o arquivo .dmg não abra sozinho de forma automática, execute-o
	manualmente.
*	Clique no 'Macintosh HD' (o HD do seu Mac), no painel esquerdo onde
	está localizado a janela do **Finder**, abra a pasta **Biblioteca**
	e arraste o arquivo **SDL2.framework** na pasta **Frameworks**. Será
	preciso se autenticado com a senha do seu usuário.

Caso ainda não tenha, obtenha o Python 3 e configure:

* Vá até o site oficial do Python, navegue nos `downloads para o macOS
  <https://www.python.org/downloads/macos/>`_, clique no link para fazer
  o download do instalador para a última versão estável (até o momento
  da atualização deste texto, seria o
  `Python 3.10.4 <https://www.python.org/ftp/python/3.10.4/python-3.10.4-macos11.pkg>`_).
* Role para baixo até a seção "Files" e baixe a versão do macOS
  (chamado “macOS 64-bit universal2 installer” ou similar).
* Depois de baixado, execute e siga as instruções de instalação.

Use o Terminal para iniciar a compilação, navegue até onde está o
código fonte do MAME (comando *cd*) e siga as instruções normais de
compilação acima para :ref:`todas as plataformas <compiling-practical-examples>`.

.. raw:: latex

	\clearpage

.. _compiling-emscripten:

Javascript Emscripten e HTML
----------------------------

Primeiro, baixe e instale o **Emscripten 2.0.25** ou mais recente
segundo as instruções no
`site oficial <https://emscripten.org/docs/getting_started/downloads.html>`_.

Depois de instalar o *Emscripten*, será possível compilar o MAME direto,
usando a ferramenta '**emmake**'. O MAME completo é muito grande para
ser carregado numa página web de uma só vez, então é preferível que seja
compilado versões menores e separadas do MAME através do parâmetro
**SOURCES**, por exemplo, faça o comando abaixo no mesmo diretório do
MAME::

	emmake make SUBTARGET=pacmantest SOURCES=src/mame/pacman

O parâmetro *SOURCES* deve apontar para pelo menos um arquivo *driver*
*\*.cpp*. O comando *make* tentará localizar e reunir todas as dependências
para compilar o executável do MAME junto com o *driver* definido. No
entanto porém, caso ocorra algum erro e o processo não encontre algum
arquivo, é necessário declarar manualmente um ou mais arquivos que
faltam (separados por vírgula). Por exemplo::

	emmake make SUBTARGET=apple2e SOURCES=src/mame/apple2e,src/devices/machine/applefdc.cpp

O valor do parâmetro *SUBTARGET* serve apenas para se diferenciar dentre
as várias compilações existente e não precisa ser definido caso não seja
necessário.

O *Emscripten* oferece suporte à compilação do *WebAssembly* com um
*loader* de *JavaScript* em vez do *JavaScript* inteiro, esse é o padrão
nas versões mais recentes. Para impor a ativação ou não do
*WebAssembly*, adicione ``WEBASSEMBLY=1`` ou ``WEBASSEMBLY=0`` ao
comando *make*, respectivamente.

Outros parâmetros para o *make* também poderão ser usados assim como foi
o **-j** para fazer o uso da compilação em *multithread*.

.. note::

		Ao pé da letra, *thread*, significa cordão ou linha. Na
		computação uma *thread* são diversas tarefas realizadas dentro
		de um processo, por exemplo, ao rodar o MAME você inicia um
		processo, dentro deste processo várias "linhas" (*threads*) são
		criadas onde cada uma delas serão lidas e processadas pelo
		processador.
		
		Então *multithread* é a capacidade do processador e do sistema
		operacional de organizar e processar diferentes processos de
		forma independente e ao mesmo tempo.

Quando a compilação atinge a fase da emcc, será exibido uma
certa quantidade de mensagens de aviso do tipo *"unresolved symbol"*.
Até o presente momento, isso é esperado para funções relacionadas com o
OpenGL como a função "*glPointSize*". Outros podem também indicar que um
arquivo de dependência adicional precisa ser especificado na lista
*SOURCES*. Infelizmente, este processo ainda não é automatizado sendo
necessário localizar e informar o arquivo de código fonte, assim como,
os arquivos que contém os símbolos que estão faltando. Pode ser que
ignorar os avisos e dar sequência na compilação funcione, desde que os
códigos ausentes não sejam usados no momento da execução.

Se tudo correr bem, um arquivo. js será criado no diretório. Este
arquivo não pode ser executado sozinho, ele precisa de um loader HTML
para que ele possa ser exibido e que seja possível também passar os
parâmetros de linha de comando para o executável.

O `Projeto Emularity <https://github.com/db48x/emularity>`_ oferece tal
loader.

.. raw:: latex

	\clearpage

Existem amostras de arquivos .html nesse repositório que pode ser
editado para refletir as suas configurações pessoais e apontar o caminho
do seu arquivo js recém compilado do MAME. Para usar o MAME num servidor
web, os arquivos abaixo são necessários:

*	O arquivo .js compilado do MAME
*	O arquivo .wasm do MAME caso tenha compilado o WebAssembly
*	Os arquivos .js do pacote Emularity (loader.js, browserfs.js, etc)
*	Um arquivo .zip com as ROMs do driver a ser rodados (caso haja)
*	Qualquer outro programa que queira rodar com o driver do MAME
*	Um loader do Emularity .html customizado para utilizar todos os
	itens acima.

Devido a restrição de segurança dos navegadores atuais, é necessário
utilizar um servidor web em vez de tentar rodá-los localmente.

Caso algo dê errado e não funcione, abra o console Web do seu
navegador principal e veja qual o erro que ele retorna (por exemplo,
faltando alguma coisa, algum arquivo de ROM incorreto, etc).
Um erro do tipo "**ReferenceError: foo is not defined**" pode indicar
que provavelmente faltou informar um arquivo de código fonte na lista da
opção **SOURCES**.

.. raw:: latex

	\clearpage


.. _compiling-options:

Opções gerais para a compilação
-------------------------------


.. _mame-compilation-premake:

**PREFIX_MAKEFILE**

  Define um arquivo *make* que será incluído no processo de compilação
  que tenha opções adicionais e que terá prioridade caso o mesmo seja
  encontrado (o nome predefinido é **useroptions.mak**).
  Pode ser útil caso queira alternar entre diferentes configurações de
  compilação de forma simples e rápida.


.. _mame-compilation-build:

**BUILDDIR**

  Define diretório usado para a compilação de todos os arquivos do
  projeto, códigos fonte auxiliares que são gerados ao longo da
  configuração, arquivos objeto e bibliotecas intermediárias.
  Por predefinição, o nome deste diretório é **build**.


.. _mame-compilation-regenie:

**REGENIE**

  Caso seja definido como **1**, faz com que toda a estrutura de
  instrução para a compilação do projeto seja regenerada, especialmente
  para o caso onde uma compilação tenha sido feita anteriormente e seja
  necessário alterar as configurações predefinidas anteriormente.


.. _mame-compilation-verbose:

**VERBOSE**

  Caso seja definido como **1**, ativa o modo loquaz, isso faz com que
  todos os comandos usados pela ferramenta make durante a
  compilação apareçam. Essa opção é aplicada instantaneamente e não
  precisa do comando **REGENIE**.


.. _mame-compilation-ignore_git:

**IGNORE_GIT**

  Caso seja definido como **1**, ignora o escaneamento da árvore de
  trabalho e não embute a revisão descritiva do git no campo da versão
  do executável.


.. _mame-compilation-targetos:

**TARGETOS**

Define o Sistema Operacional de destino, é importante deixar claro que
essa opção é desnecessária caso esteja compilando o MAME nativamente, os
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

	**Double Precision Streaming SIMD Extensions**, em resumo, são
	instruções que otimizam o desempenho em processadores
	compatíveis. Se definido como **1** o MAME terá um melhor
	desempenho segundo a `nota publicada
	<https://www.mamedev.org/?p=451>`_ no site do MAME.


.. _mame-compilation-ptr64:

**PTR64**

	Se definido como **1** define o tamanho do ponteiro em bit, assim
	sendo, gera uma versão 64-bit do executável do MAME ou 32-bit quando
	não for definido.
	Caso não haja nenhum problema durante o processo de compilação,
	haverá um executável do MAME chamado **mame.exe** para a versão
	*64-bit* ou **mame.exe** caso você tenha compilado uma versão para
	*32-bit*.

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

  Define o comando para o lincador, caso o seu ambiente esteja
  corretamente configurado não é necessário lidar com ele, mesmo em
  compilação cruzada.


.. _mame-compilation-python_executable:

**PYTHON_EXECUTABLE**

  Define o interpretador Python. Para compilar o MAME é necessário ter
  o Python versão *2.7*, Python *3* ou mais recente.


.. _mame-compilation-cross_build:

**CROSS_BUILD**

  Defina como **1** para que o lincador e o compilador fiquem isolados
  do sistema hospedeiro, opção obrigatória ao realizar uma
  :ref:`mame-crosscompilation`.


.. _mame-compilation-openmp:

**OPENMP**

  Se definido como **1**, faz uso da `paralelização implícita
  <https://www.ibm.com/developerworks/br/aix/library/au-aix-openmp-frame
  work/index.html>`_ com o `OpenMP <https://pt.wikibooks.org/wiki/Progra
  ação_Paralela_em_Arquiteturas_Multi-Core/Programação_em_OpenMP>`_.
  No MAME segundo o `FAQ oficial <https://wiki.mamedev.org/index.php/FA
  Q:Performance>`_, são adicionadas novas threads para aceleração de
  loop, trazendo um aumento de desempenho. Para fazer uso desta opção
  é necessário a instalação do ``libomp-devel`` ou ``libomp-dev``
  dependendo da sua distribuição.

.. raw:: latex

	\clearpage


Incluindo os subconjuntos dos sistemas suportados
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _mame-compilation-subtarget:

**SUBTARGET**

  Define a compilação alternativa do compilador. Algumas predefinições
  estão disponíveis em ``scripts/target/mame`` ou usando os filtros dos
  drivers do sistema em ``src/mame``. As versões alternativas criadas
  pelo usuário podem ser criadas usando **SOURCES** ou **SOURCEFILTER**.
  Os valores já predefinidos são:

		* **arcade**: Compila uma versão do MAME apenas com sistemas classificados como arcade.
		* **dummy**: Compila uma versão bem simplificada do mame com apenas o driver da Coleco.
		* **mame**: Compila uma versão do MAME com arcade, mess e virtual.
		* **mess**: Compila uma versão do MAME só com sistemas catalogados como consoles de videogame, portáteis, diferentes plataformas de computadores e calculadoras.
		* **nl**: Compila todos os drivers classificados como *netlist*.
		* **tiny**: Compila uma versão simples do MAME com alguns poucos drivers usado para testar a compilação do MAME, muito útil pois evita a obrigação de se compilar todo o código fonte do MAME para testar apenas uma modificação feita na interface por exemplo.
		* **virtual**: Compila uma versão do MAME com o VGM player e um simulador para o Pioneer LDV-1000 e o PR-8210.

  O valor do parâmetro *SUBTARGET* serve também para se diferenciar
  dentre as várias compilações existente e não precisa ser definido sem
  necessidade. No exemplo do comando abaixo:

	**make REGENIE=1 SUBTARGET=neogeo SOURCES=neogeo/neogeo.cpp -j7**

  Será criado um binário do MAME com o nome **neogeo** no Linux ou
  **neogeo.exe** no Windows.


.. _mame-compilation-sources:

**SOURCES**

  Define o arquivo com o código fonte do driver que serão inclusos na
  compilação. Geralmente são usados em conjunto com a opção
  **SUBTARGET**. Os diferentes arquivos/pastas são separados com
  vírgulas.


.. _mame-compilation-sourcefilter:

**SOURCEFILTER**

  Define um arquivo de filtro do driver do sistema. É usado normalmente
  em conjunto com a opção **SUBTARGET**.  O arquivo de filtro pode
  definir os arquivos de origem na inclusão dos drivers do sistema e
  para escolher quais os drivers individuais do sistema que serão
  inclusos ou excluídos. Há alguns exemplos de arquivos filtro dos
  drivers de sistema na pasta ``src/mame``.

.. raw:: latex

	\clearpage


.. _mame-compilation-optional-resources:

Recursos opcionais
~~~~~~~~~~~~~~~~~~


.. _mame-compilation-tools:

**TOOLS**

  Caso seja definido como **1**, as ferramentas adicionais que trabalham
  em conjunto com o emulador como ``unidasm``, ``chdman``, ``romcmp``,
  e ``srcclean`` serão compiladas.


.. _mame-compilation-nouseportaudio:

**NO_USE_PORTAUDIO**

  Caso seja definido como **1**, desativa a construção do módulo de
  saída de áudio PortAudio e sua biblioteca.


.. _mame-compilation-nousepulseaudio:

**NO_USE_PULSEAUDIO**

  Caso seja definido como **1**, desativa a construção do módulo de
  saída de áudio PortAudio e sua biblioteca no Linux.


.. _mame-compilation-usetapun:

**USE_TAPTUN**

  Caso seja definido como **1**, inclui o módulo de rede tap/tun, use
  **0** para desativar. O módulo de rede tap/tun está incluso por padrão
  no Windows e no Linux.


.. _mame-compilation-usepcap:

**USE_PCAP**

  Caso seja definido como **1**, inclui o módulo de rede pcap, use **0**
  para desativar. O módulo de rede pcap está incluso por padrão no macOS
  e no NetBSD.


.. _mame-compilation-use_qtdebug:

**USE_QTDEBUG**

  Caso seja definido como **1**, será incluso o depurador com a
  interface Qt em plataformas onde a mesma não vem previamente
  embutida como MacOS e Windows por exemplo, defina como **0** para
  desativar. É obrigatório a instalação das bibliotecas de
  desenvolvimento Qt assim como suas ferramentas para a compilação do
  depurador.
  Todo este processo varia de plataforma para plataforma.


.. _mame-compilation-nowerror:

**NOWERROR**

  Defina como **1** para desativar o tratamento das mensagens de
  aviso do compilador como erro. Talvez seja necessário em
  configurações minimamente compatíveis.


.. _mame-compilation-deprecated:

**DEPRECATED**

  Defina como **0** para desativar as mensagens de aviso menos
  importantes/relevantes (repare que as mensagens de avisos não são
  tratadas como erro).

.. raw:: latex

	\clearpage


.. _mame-compilation-debug:

**DEBUG**

  Defina como **1** para ativar as rotinas de verificações adicionais
  e diagnósticos ativando o modo de depuração. É importante que
  saiba que essa opção tem impacto direto no desempenho do emulador e
  só tem utilidade para desenvolvedores, não compile o MAME com esta
  opção sem saber o que está fazendo. Veja também
  :ref:`compiling-advanced-options-debug`.


.. _mame-compilation-optimize:

**OPTIMIZE**

  Define o nível de otimização. O valor predefinido é **3** onde o
  foco é desempenho ao custo de um executável maior no final da
  compilação.
  Há também as seguintes opções:

		* **0**: Caso queira desativar a otimização e favorecendo a depuração.
		* **1**: Otimização simples sem impacto direto no tamanho final do executável nem no tempo de compilação.
		* **2**: Ativa a maioria das otimizações visando desempenho e tamanho reduzido.
		* **3**: Este é o valor predefinido, em favor do desempenho ao custo de um executável maior.
		* **s**: Ativa apenas as otimizações que não impactem no tamanho final do executável.

  A compatibilidade destes valores dependem do compilador que esteja
  sendo usado.


.. _mame-compilation-symbols:

**SYMBOLS**

	Defina como **1** para ativar a inclusão de símbolos adicionais
	de depuração para a plataforma que o executável está sendo
	compilado, além dos já inclusos (muitas plataformas por predefinição
	já incluem estes símbolos e os nomes das respectivas funções).


.. _mame-compilation-symlevel:

**SYMLEVEL**

	Valor numérico que controla a quantidade de detalhes nos símbolos de
	depuração, valores maiores facilitam a depuração ao custo do tempo
	de compilação e do tamanho final do executável. **SYMLEVEL=1** é
	usado na versão oficial do MAME e a mínima recomendada. A
	compatibilidade destes valores dependem do compilador que esteja
	sendo usado, no caso do GNU GCC e similares, estes valores são:
	
		* **1**: Incluí tabelas numéricas e variáveis externas.
		* **2**: Incluindo os itens descritos em **1**, incluí também as variáveis locais.
		* **3**: Incluí também definições macros.


.. _mame-compilation-strip-symbols:

**STRIP_SYMBOLS**

	Defina como **1** para que os símbolos de depuração em vez de
	ficarem embutidos no MAME, sejam armazenado num arquivo externo
	com extensão "**.sym**", este arquivo é extraído na versão do
	Windows. Esta opção é útil para aliviar o tamanho final do MAME já
	que **SYMLEVEL** com valores maiores que **1** geram uma grande
	quantidade de símbolos de depuração, impactando muito no tamanho
	final do executável.

.. raw:: latex

	\clearpage


.. _mame-compilation-archopts:

**ARCHOPTS**

	Opções adicionais que serão passadas ao compilador e ao lincador.
	Útil para a geração de códigos adicionais ou opções de interface
	binária de aplicação [1]_ como por exemplo a ativação de recursos
	opcionais do processador.


.. _mame-compilation-archopts-c:

**ARCHOPTS_C**

	Opções adicionais que serão passadas ao compilador durante a
	compilação dos arquivos de código fonte em linguagem C.


.. _mame-compilation-archopts-cpp:

**ARCHOPTS_CXX**

	Opções adicionais que serão passadas ao compilador durante a
	compilação dos arquivos de código fonte em linguagem C++.


.. _mame-compilation-archopts-objc:

**ARCHOPTS_OBJC**

	Opções adicionais que serão passadas ao compilador durante a
	compilação dos arquivos de código fonte Objective-C.


.. _mame-compilation-archopts-objcxx:

**ARCHOPTS_OBJCXX**

	Opções adicionais que serão passadas ao compilador durante a
	compilação dos arquivos de código fonte Objective-C++.

Sede das bibliotecas e framework
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**SDL_INSTALL_ROOT**

	Diretório raiz onde se encontra a instalação dos arquivos de
	desenvolvimento SDL.

**SDL_FRAMEWORK_PATH**

	Caminho onde se encontra o SDL framework.

**USE_LIBSDL**

	Defina como **1** para usar a biblioteca SDL no destino onde o
	framework for predefinido.

**USE_SYSTEM_LIB_ASIO**

	Defina como **1** caso prefira usar a biblioteca I/O assíncrona
	Asio C++ do seu sistema em vez de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_EXPAT**

	Defina como **1** caso prefira usar o analisador sintático Expat XML
	do seu sistema em vez de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_ZLIB**

	Defina como **1** caso prefira usar a biblioteca de compressão zlib
	instalada no seu sistema em vez de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_JPEG**

	Defina como **1** caso prefira usar a biblioteca de compressão de
	imagem libjpeg em vez de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_FLAC**

	Defina como **1** caso prefira usar a biblioteca de compressão de
	áudio libFLAC em vez de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_LUA**

	Defina como **1** caso prefira usar a biblioteca do interpretador
	Lua instalado no seu sistema em vez de usar a versão fornecida
	pelo MAME.

**USE_SYSTEM_LIB_SQLITE3**

	Defina como **1** caso prefira usar a biblioteca do motor de
	pesquisa SQLITE do seu sistema em vez de usar a versão fornecida
	pelo MAME.

**USE_SYSTEM_LIB_PORTMIDI**

	Defina como **1** caso prefira usar a biblioteca PortMidi instalada
	no seu sistema em vez de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_PORTAUDIO**

	Defina como **1** caso prefira usar a biblioteca PortAudio do seu
	sistema em vez de usar a versão fornecida pelo MAME.

**USE_BUNDLED_LIB_SDL2**

	Defina como **1** caso prefira usar a versão da biblioteca fornecida
	pelo MAME ao invés da versão instalada no seu sistema. Essa opção já
	vem predefinida para compilações feitas em Visual Studio e em
	versões para Android. Já para outras outras configurações, é
	preferível que seja usada a versão instalada no sistema.

**USE_SYSTEM_LIB_UTF8PROC**

	Defina como **1** caso prefira usar a biblioteca Julia utf8proc
	instalada no seu sistema em vez de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_GLM**

	Defina como **1** caso prefira usar a biblioteca GLM OpenGL
	Mathematics do seu sistema em vez de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_RAPIDJSON**

	Defina como **1** caso prefira usar a biblioteca Tencent RapidJSON
	do seu sistema em vez de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_PUGIXML**

	Defina como **1** caso prefira usar a biblioteca pugixml do seu
	sistema em vez de usar a versão fornecida pelo MAME.

.. raw:: latex

	\clearpage


.. _compiling-issues:

Problemas conhecidos
--------------------

Problemas relacionados com versões específicas do compilador
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* O GCC 7 32-bit para Windows x86 gera erros esporádicos com alertas
  de acesso fora dos limites. [2]_
  Use **NOWERROR=1** nas suas opções de compilação para remediar o
  problema e não tratar avisos como se fossem erros.

* Versões iniciais do GNU libstdc++ 6 contém uma implementação
  ``std::unique_ptr`` quebrada. Caso encontre qualquer mensagem de
  erro relacionado com ``std::unique_ptr`` é necessário a atualização do
  seu libstdc++ para uma versão mais recente.

Recursos do código fonte fortify da biblioteca GNU C
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A biblioteca GNU C possui opções para realizar verificações durante a
compilação e verificações durante a execução, use ``_FORTIFY_SOURCE``
como ``1`` para ativar o recurso. Essa opção visa melhorar a
segurança ao custo de uma pequena sobrecarga no executável. O MAME não é
um programa seguro e nós não recomendamos que o MAME seja compilado com
essa opção definida.

Algumas distribuições Linux como Gentoo e Ubuntu possuem versões
modificadas do GNU GCC que já vem com o ``_FORTIFY_SOURCE`` ativado
com ``1``. Isso gera problemas para a maioria dos projetos e não apenas
para o MAME, pois afeta diretamente o desempenho do emulador, dificulta
que essas verificações adicionais sejam desativadas, assim como torna
difícil definir outros valores para ``_FORTIFY_SOURCE`` como ``2`` por
exemplo, que ativa verificações ainda mais restritas.

Neste caso, você deve realmente pegar no pé dos mantenedores da sua
distribuição preferida, deixando claro que você não quer que o GNU GCC
tenha um comportamento fora do padrão.

Seria melhor que essas distribuições predefinissem essa opção em seu
próprio ambiente de desenvolvimento de pacotes caso eles acreditem que
de fato, tal opção seja realmente importante, em vez de obrigar a
todos a usarem em todo e qualquer código fonte que seja compilado no
sistema sem necessidade.

A distribuição Red Had faz da seguinte maneira, a opção
``_FORTIFY_SOURCE`` é definida apenas dentro do ambiente de compilação
dos pacotes RPM e ao invés de distribuir uma versão modificada do GNU
GCC.

Caso encontre erros relacionados com ``bits/string_fortified.h``,
verifique e tenha certeza se ``_FORTIFY_SOURCE`` já está definido no
ambiente ou junto com **CFLAGS** ou **CXXFLAGS** por exemplo. É possível
verificar o seu ambiente com o comando abaixo::

	gcc -dM -E - < /dev/null | grep _FORTIFY_SOURCE

Caso ``_FORTIFY_SOURCE`` já esteja predefinido com um valor diferente de
zero, é possível usar uma solução paliativa com ``-U_FORTIFY_SOURCE``.
Use em suas opções de compilação **ARCHOPTS** ou redefinindo as suas
variáveis de ambiente **CFLAGS** e **CXXFLAGS**.

.. raw:: latex

	\clearpage


.. _compiling-issues-mvs:

Problemas que afetam o Microsoft Visual Studio
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A Microsoft introduziu uma nova versão do **XAudio2** com o Windows 8
que é incompatível com a versão incluída com o **DirectX** para as
versões anteriores do Windows no nível de API. As novas versões do
*Microsoft Windows SDK* incluem cabeçalhos e bibliotecas para a nova
versão do XAudio2. É predefinido que a versão alvo do Windows seja
definida para o Windows Vista (6.0) durante a compilação do MAME, o que
impede o uso desta versão dos cabeçalhos e bibliotecas do XAudio2.
Para construir o MAME com suporte ao XAudio2 usando o Microsoft Windows
SDK, você deve fazer uma das seguintes ações:

* Adicione a opção ``MODERN_WIN_API=1`` ao make ao gerar os arquivos do
  projeto do Visual Studio. Isso definirá a versão do Windows para
  Windows 8 (6.2). Os binários resultantes desta compilação, poderão não
  rodar nas versões anteriores do Windows.
* Instale o DirectX SDL e configure o projeto ``osd_windows`` para
  realizar a procura dos caminhos dos cabeçalhos e das bibliotecas do
  DirectX antes de procurar os caminhos do Microsoft Windows SDK.

O compilador MSVC produz avisos espúrios sobre as variáveis locais que
estejam não-inicializadas potencialmente. Atualmente é preciso adicionar
``NOWERROR=1`` às opções do make para gerar os arquivos do projeto do
Visual Studio. Isto impede que os avisos sejam tratados como erros.
(O MSVC parece não ter opções para controlar quais advertências
específicas serão tratadas como erro, coisa que os outros compiladores
suportam).

Há um problema ainda não resolvido com a definição do ``COM GUIDS``
duplicados na biblioteca do PortAudio quando a versão alvo do Windows
for definida para o Windows Vista (6.0) ou posterior. Para contornar
isso, adicione a opção ``NO_USE_PORTAUDIO=1`` ao gerar os arquivos do
projeto do Visual Studio. O MAME será compilado sem o suporte para a
saída de áudio através do PortAudio.


.. _compiling-issues-entry-point:

Ponto de entrada não encontrado
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Caso o seu **sdlmame.exe** mostre um erro como este ou algo
parecido::

	Não foi possível localizar o ponto de entrada do procedimento
	_ZNSt7__cxx1118basic_stringstreamIcSt11char_traitsIcESaIcEEC1Ev na
	biblioteca de vínculo dinâmico D:\MAME\sdlmame.exe.

Devido a alteração feita
`neste commit <https://github.com/mamedev/mame/commit/b0223ac413ccfb0907
be9741168b4cf43fb67fb9>`_ o executável **sdlmame.exe** é compilado de
maneira que ele busque as bibliotecas que ele precisa para funcionar no
sistema em vez de tê-las embutidas em si.

Assim o executável **sdlmame.exe** busca pelas seguintes bibliotecas,
``libgcc_s_seh-1.dll``, ``libstdc++-6.dll``, ``libwinpthread-1.dll``,
``libgomp-1.dll`` e ``SDL2.dll``, todas elas estão dentro do diretório
de instalação do seu MSYS2 ( exemplo ``C:\msys64\mingw64\bin`` ), é
possível adicionar este caminho nas variáveis de ambiente do Windows:

1.	Pressione a tecla com a bandeira do Windows ( ela é chamada
	``WINKEY`` ) junto com a tecla ``Pause``.
2.	Clique na opção chamada ``Configurações Avançadas do Sistema``.
3.	Vá em :menuselection:`Avançado --> Variáveis de Ambiente`.
4.	Selecione ``Path`` e clique em ``Editar``.
5.	Clique em ``Novo`` e adicione o caminho onde está instalado o seu
	MSYS2.
6.	No nosso exemplo seria ``C:\msys64\mingw64\bin``, clique em ``Ok``
	para finalizar e feche todas as janelas.

E aqui começa toda a confusão, caso você tenha baixado a `ferramenta de
compilação oficial do MAME <https://www.mamedev.org/tools/>`_, ela já
vem com uma versão do arquivo **libstdc++-6.dll**, porém caso você
compile o seu SDL MAME com ela e tempos depois atualize o seu MSYS2, a
versão do seu **libstdc++-6.dll** será diferente daquela que você
compilou o seu SDL MAME, ocorrendo assim o problema.

Para solucionar o problema basta que você compile uma nova versão do
MAME que fará com que este utilize a versão atualizada do arquivo
**libstdc++-6.dll**. Caso não queira lidar com variáveis de ambiente,
é possível também copiar as bibliotecas acima listadas para o diretório
onde se encontra o seu SDL MAME.

Outra maneira de corrigir o problema sem ter que alterar as variáveis de
ambiente do Windows é copiar as seguintes DLLs para a mesma pasta do seu
**sdlmame.exe**::

	libgcc_s_seh-1.dll
	libgomp-1.dll
	libstdc++-6.dll
	libwinpthread-1.dll
	SDL2.dll
	SDL2_ttf.dll

Note que até a presente versão deste texto, estas são as DLLs que a
a versão SDL do MAME pede, pode ser que num determinado momento o MAME
possa pedir outras Dlls, e se for o caso de estar faltando alguma dll,
o próprio Windows vai mostrar uma nova mensagem de erro dizendo qual a
dll que está faltando ao rodar o **sdlmame.exe**, neste caso, vá até a
pasta ``C:\msys64\mingw64\bin`` e copie a dll que falta para dentro da
pasta do MAME.

.. raw:: latex

	\clearpage

.. _compiling-unusual:

Configurações para compilações não ortodoxas
--------------------------------------------

.. _compiling-llvm:

Lincando com o LLVM linker
~~~~~~~~~~~~~~~~~~~~~~~~~~

Geralmente o LLVM linker é mais rápido que o GNU linker utilizado pelo
GCC. Isso fica mais evidente em sistemas com uma elevada sobrecarga de
operações dos arquivos do sistema (como o Microsoft Windows ou ao
compilar num disco compartilhado na rede por exemplo). Para utilizar o
LLVM linker com o GCC, tenha certeza de tê-lo instalado no seu sistema
e utilize ``-fuse-ld=lld`` nas opções do compilador, seja através da
variável de ambiente **LDFLAGS**, através da opção **LDOPTS** ou
configurando o **LDOPTS** no arquivo **useroptions.mak**), exemplo::

	LDOPTS=-fuse-ld=lld

.. note::

	Até a presente versão deste documento a opção ainda `não funciona
	<https://github.com/msys2/MINGW-packages/issues/6855>`_ caso o MAME
	seja compilado com o clang. No entanto funciona bem com o gcc
	fazendo com que todo o processo de lincagem leve apenas **segundos**
	para ser concluído se comparado com o GNU linker.

Usando libc++ no Linux
~~~~~~~~~~~~~~~~~~~~~~

O MAME pode ser compilado usando a biblioteca padrão C++ "libc++" do
projeto LLVM. Os pré-requisitos são uma instalação funcional do
clang/LLVM no seu sistema e a biblioteca de desenvolvimento libc++. No
Linux Fedora os pacotes necessários são **libcxx**, **libcxx-devel**,
**libcxxabi** e **libcxxabi-devel**. No Debian os pacotes são
**libc++1**, **libc++-dev** e **libc++abi-dev**. Defina os compiladores
clang C e C++ assim como o **-stdlib=libc++** nas opções do compilador
C++ e do seu lincador.
O comando completo ficaria assim::

	env LDFLAGS=-stdlib=libc++ make OVERRIDE_CC=clang OVERRIDE_CXX=clang++ ARCHOPTS_CXX=-stdlib=libc++ ARCHOPTS_OBJCXX=-stdlib=libc++

Ou em caso de erro, tente::

	env LDFLAGS=-stdlib=libc++ make OVERRIDE_CC=clang OVERRIDE_CXX=clang++ ARCHOPTS_OBJCXX=-stdlib=libc++ LDOPTS=-fuse-ld=lld -stdlib=libc++

As opções depois do comando make podem ser armazenadas num
makefile customizado como descrito em :ref:`PREFIX_MAKEFILE
<mame-compilation-premake>`.

Usando uma instalação do GNU GCC libstdc++ que esteja fora do local tradicional no Linux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O GNU GCC pode ter sido compilado e instalado num local diferente caso
o mantenedor do mesmo utilize a opção ``--prefix=`` junto com o comando
``configure``. Isso pode ser útil caso queira compilar o MAME numa
distribuição Linux que ainda use a versão do GNU libstdc++ que anteceda
o C++17. Caso queira compilar o MAME com uma verão alternativa
do GNU GCC que esteja instalada em seu sistema, defina o caminho
completo dos compiladores C (gcc) e C++ (g++), assim como, adicione o
caminho completo da biblioteca do seu sistema. Supondo que tenha o
GNU GCC instalado em ``/opt/local/gcc72``, use o comando de compilação
como mostrado abaixo::

	make OVERRIDE_CC=/opt/local/gcc72/bin/gcc OVERRIDE_CXX=/opt/local/gcc72/bin/g++ ARCHOPTS=-Wl,-R,/opt/local/gcc72/lib64

Essas configurações podem ser armazenadas num makefile customizado
como descrito em :ref:`PREFIX_MAKEFILE <mame-compilation-premake>` caso
pretenda utilizá-las regularmente.

.. raw:: latex

	\clearpage

O MAME travou, o que fazer?
---------------------------

Investigando e lidando com problemas comuns
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A princípio é preciso saber se a causa do problema tem origem no MAME,
se é algum bug interno ou se vem de alguma configuração externa.
A primeira coisa a se fazer é ir eliminando possíveis *culpados*, caso
tenha alterado algum tipo de configuração comece renomeando o seu
``mame.ini`` para ``_mame.ini``, isso faz com que o MAME não encontre
mais o seu arquivo de configuração use as suas configurações
predefinidas internamente.

Caso o MAME não apresente o problema com o exemplo acima, crie um novo
``mame.ini`` com o comando
**mame.exe** :ref:`-createconfig <mame-commandline-createconfig>` e
usando o editor de texto de sua preferência vá adicionando as suas
configurações uma a uma, sempre testando com o MAME cada alteração
adicionada até identificar o problema.

Supondo que o problema não tenha sido com o arquivo de configuração,
verifique se o conteúdo dos diretórios **bgfx**, **hlsl** e **hash**
foram atualizados. É comum para aqueles que compilam a sua versão do
MAME e se esquecem de atualizar o conteúdo destes diretórios no
dispositivo que estão usando ou até mesmo um outro lugar onde o MAME
esteja sendo executado. Isso porém não acontece com quem baixa a versão
já compilada do MAME do site oficial.

Experimente apagar o arquivo de configuração da último sistema que foi
rodado, fica no diretório **cfg**, apague também o arquivo de memória
que fica do diretório **nvram**. Em ambos os diretórios o nome do
arquivo ou diretório será o mesmo que o nome do sistema usado, supondo
que teve problemas com o sistema **Street Fighter Alpha**, no diretório
**nvram** apague o diretório **sfa**, no diretório **cfg**, apague o
arquivo **sfa.cfg**. Verifique se não existe nenhuma configuração
customizada dentro do diretório **ini** como **arcade.ini** ou qualquer
outro que possa ter sido criado, caso exista, experimente mover este
arquivo para um outro lugar.

É provável que depois de uma atualização da versão GIT o MAME tenha se
"*quebrado*", ao acompanhar o `desenvolvimento do MAME diariamente
<https://github.com/mamedev/mame/commits/master>`_, verá que durante
todo o dia, vários desenvolvedores estão enviando coisas novas e
melhorando aquelas que já existem. Esse é o risco de se utilizar a
versão GIT pois é uma versão instável que a qualquer momento algo pode
deixar de funcionar.

O driver de vídeo algumas vezes pode causar problemas, alguma
incompatibilidade com o Direct3D, os casos variam muito. A melhor
maneira de descartar isso é testando o MAME usando uma outra opção de
vídeo, caso esteja usando ``-video d3d`` (Windows) ou ``-video opengl``
(Linux e macOS) tente com ``-video soft``. Para outras opções veja
:ref:`-video <mame-commandline-video>`.

.. raw:: latex

	\clearpage

.. _compiling-advanced-options-debug:

A tela de travamento
~~~~~~~~~~~~~~~~~~~~

Junto aos binários do MAME existe um arquivo de símbolos, para a versão
*64-bit* será criado o arquivo **mame.sym** ou **mame.sym** para a
versão *32-bit*. Estes arquivos já vem com a versão oficial assim como
:ref:`já foi explicado <mame-compile-add-symbols>` como criá-los
durante a compilação.

Estes arquivos devem **sempre** estar junto ao executável do MAME, esse
arquivo "**.sym**" é usado para traduzir as referências usadas no
código fonte junto com os códigos de erro, para a maioria não significa
muito porém é útil para os desenvolvedores. Aqui um exemplo de um erro
que causou a parada do MAME::

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
como um código hexadecimal sem sentido, com os símbolos esses códigos
são traduzidos para algo legível e compreensível para os
desenvolvedores. Caso o MAME trave durante a emulação, uma tela
semelhante irá aparecer, copie e reporte [3]_ o erro no fórum
`MAME testers <https://mametesters.org/view_all_bug_page.php/>`_.

.. _compiling-using-gdb:

Usando o gdb
~~~~~~~~~~~~

A ideia não é oferecer um manual completo de como usar o gdb, apenas
o mínimo necessário para se obter um *stack trace* válido. No
exemplo abaixo estou usando uma versão 64-bit do MAME para Linux, porém
o procedimento é o mesmo em qualquer outra plataforma.

* Carregue o mame no gdb com o comando ``gdb mame``, irá aparecer
  algo semelhante com a tela abaixo::

	gdb mame
	GNU gdb (Debian 7.12-6) 7.12.0.20161007-git
	Copyright (C) 2016 Free Software Foundation, Inc.
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
	(gdb)

Para executar o sistema com problema execute ``run`` seguido pelos
comandos do MAME, exemplo::

	(gdb) run kof99
	Starting program: /home/mame/mame kof99
	[Thread debugging using libthread_db enabled]
	Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
	[New Thread 0x7fffe4f6c700 (LWP 21026)]
	[New Thread 0x7fffe4531700 (LWP 21027)]
	[New Thread 0x7fffe3d30700 (LWP 21028)]
	[New Thread 0x7fffe352f700 (LWP 21029)]
	[New Thread 0x7fffe2d2e700 (LWP 21030)]
	[New Thread 0x7fffe9ab5700 (LWP 21031)]
	[New Thread 0x7fffe9a74700 (LWP 21032)]

O exemplo dado foi com **kof99** porém, pode ser com qualquer outro
sistema que tenha dado problema, use a sistema até que o MAME trave,
será exibida uma tela como no exemplo abaixo ::

	Thread 1 "mame" received signal SIGSEGV, Segmentation fault.
	_int_malloc (av=av@entry=0x7ffff459fb00 <main_arena>, 
	bytes=bytes@entry=67108864) at malloc.c:3650
	3650 malloc.c: File or directry not found.

Faça o comando ``where`` para que o gdb liste as possíves causas::

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
copiadas e enviadas para os desenvolvedores, no exemplo acima ele foi
cortado entre o item #7 e #25.
Para versões do MAME baixados do site oficial, envie essas informações
para `MAME testers <https://mametesters.org/view_all_bug_page.php/>`_.
Já no caso de versões GIT, as informações devem ser enviadas para o
mamedev no `github <https://github.com/mamedev/mame/issues>`_. Lembrando
que é obrigatório que os relatórios sejam feitos em Inglês.
Para interromper o processo basta teclar **c** seguido da tecla
**ENTER**, a tela do MAME será fechada, para sair do gdb digite
**quit**.

Uma outra opção para o gdb é a utilização de interfaces que ajudam a
organizar a saída do gdb como a `GDB Dashboard
<https://github.com/cyrus-and/gdb-dashboard>`_, com ela a saída do gdb
além de ficar colorida, fica mais organizada, já são exibidos todos
os valores mais relevantes dos registros, código fonte, etc.

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


A instalação é simples, basta salvar o .gbdinit no seu home. Para que a
informação do código fonte (source) apareça como no exemplo acima, é
necessário que o caminho completo onde o MAME foi compilado ainda
exista, ou seja, depois de compilar o MAME não faça um ``make clean``,
deixe-o como está assim o gdb encontrará o que precisa.

A *GDB Dashboard* é customizável, oferece plug-ins e outras
configurações que atendam as suas necessidades caso queira se envolver
com desenvolvimento ou outras funções do gdb que não serão abordadas
aqui.

.. raw:: latex

	\clearpage

Caso nada apareça no **Source Code** em conjunto com uma mensagem de
erro::

	2509 prot_cmc.cpp File or directry not found.

Ainda dentro do gdb indique o caminho completo para o código fonte do
MAME com o comando ``directory``::

	directory /home/mame/src/mame

Da próxima vez que ocorrer algum problema o gdb saberá onde pesquisar
pelos arquivos fonte, use o comando ``list`` para testar.

.. raw:: latex

	\clearpage

.. _compiling-using-asan:

Usando o AddressSanitizer
~~~~~~~~~~~~~~~~~~~~~~~~~

Quando tudo parece perdido chega a hora de praticamente chutar o balde,
há momentos onde não há um *stack trace* ou se tem ele não é informativo
o suficiente para que os desenvolvedores tenham informações úteis.

Apesar da opção estar disponível nas configurações, ela não é publicada
e tão pouco seu uso é incentivado. Talvez a explicação seja mais simples
do que parece, ao ativar o
`AddressSanitizer <https://github.com/google/sanitizers/wiki/AddressSanitizer>`_
o MAME **rodará bem mais lento** que o normal pois o *AddressSanitizer*
é um detector de erros de memória para C/C++.

Usaremos o Debian 9.97 (stretch) como referência, serve de base para
outras distribuições e versões, adapte as configurações aqui mostradas
para as versões mais recentes caso seja necessário. Atualmente o clang
já está na versão 7, porém a versão 5 continua bem estável e é
suficiente para o nosso exemplo, caso queira testar versões mais novas,
é por sua conta e risco pois talvez hajam questões de conflitos que
precisam ser resolvidos e que não serão abordados aqui.

Como administrador crie o arquivo **clang.list**:

	``sudo touch /etc/apt/sources.list.d/clang.list``

Adicione as linha abaixo ao arquivo clang.list, o exemplo foi feito com
a versão **5.0** porém ajuste para versões mais recentes ou que sejam
compatíveis com a sua distribuição::

	# 5.0
	deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-5.0 main

Depois de um ``apt-get update`` instale com o comando::

	sudo apt-get install clang-5.0 libclang-common-5.0-dev libclang1-5.0 liblldb-5.0 lldb-5.0 python-lldb-5.0 libllvm5.0 llvm-5.0 llvm-5.0-runtime

Adicione as linhas abaixo ao arquivo ~/.bashrc do seu home:

|	``echo "export ASAN_OPTIONS=symbolize=1" >> ~/.bashrc``
|	``echo "export ASAN_SYMBOLIZER_PATH=/usr/lib/llvm-5.0/bin/llvm-symbolizer" >> ~/.bashrc``

Caso a sua distribuição seja diferente, faça o comando
``locate llvm-symbolizer`` para saber o caminho completo do seu
**llvm-symbolizer** e adicione ao **ASAN_SYMBOLIZER_PATH**.

Recarregue as configurações do seu terminal com o comando ``. .bashrc``
(ponto, espaço, ponto bashrc) ou encerre a seção e faça login novamente.

Compile o MAME como mostra o exemplo abaixo::

	make clean && make OVERRIDE_CC=/usr/bin/clang OVERRIDE_CXX=/usr/bin/clang++ OPTIMIZE=0 SYMBOLS=1 SYMLEVEL=1 SANITIZE=address -j7

.. raw:: latex

	\clearpage

Ao rodar o MAME com o sistema com problema, você terá um retorno
semelhante ao exemplo abaixo:

.. code-block:: c

	==2227==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7f6b8d4a6800 at pc 0x0000019a963e bp 0x7ffd4dd2d450 sp 0x7ffd4dd2d448
	READ of size 2 at 0x7f6b8d4a6800 thread T0
		#0 0x19a963d in sma_prot_device::kof99_decrypt_68k(unsigned char*) /home/mame/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/prot_sma.cpp:426:24
		#1 0x15e7b10 in neogeo_sma_kof99_cart_device::decrypt_all(unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int) /home/mame/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/sma.cpp:75:14
		#2 0x15e7cd5 in non-virtual thunk to neogeo_sma_kof99_cart_device::decrypt_all(unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int, unsigned char*, unsigned int) /home/mame/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/sma.cpp
		#3 0x6232c5 in neogeo_cart_slot_device::late_decrypt_all() /home/mame/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/slot.h:327:48
	...
	SUMMARY: AddressSanitizer: heap-buffer-overflow /home/mame/build/projects/sdl/mame/gmake-linux-clang/../../../../../src/devices/bus/neogeo/prot_sma.cpp:426:24 in sma_prot_device::kof99_decrypt_68k(unsigned char*)
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
.. [2]	Out-of-bounds access. (Nota do tradutor)
.. [3]	Pedimos a gentileza de relatar os problemas encontrados em
		Inglês. (Nota do tradutor)
