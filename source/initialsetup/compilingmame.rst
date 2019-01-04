.. raw:: latex

	\clearpage

.. contents:: :local:

.. _compiling-MAME:

Compilando o MAME
=================

.. _compiling-all:

Para todas as plataformas
-------------------------

*	Sempre que você estiver alterando os parâmetros de construção, (como
	alternar entre uma versão baseada em SDL e uma versão nativa do
	Windows ou adicionar ferramentas à lista de compilação) você precisa
	executar um ``make REGENIE=1`` para fazer com que todas as novas
	opções adicionais sejam incluídas nos arquivos de configuração
	responsável pela construção do executável do MAME. Caso não seja
	feito, será muito complicado identificar e localizar possíveis
	erros.

*	Caso você queira incluir as ferramentas adicionais na sua compilação
	como por exemplo, o programa *CHDMAN*, adicione a opção ``TOOLS=1``
	ao comando make, assim ``make REGENIE=1 TOOLS=1``. Isso fará com que
	o make compile todas as outras ferramentas que acompanham o MAME
	além do *CHDMAN*.

*	Você pode customizar a sua compilação escolhendo um driver em
	específico caso queira, usando a opção ``SOURCES=<driver>`` junto
	com o comando make. Por exemplo, caso queira compilar uma versão
	customizada do MAME que só rode o jogo **Pac Man**, você faz
	assim: ::

		make SOURCES=src/mame/drivers/pacman.cpp REGENIE=1

	Repare que é muito importante que é obrigatório o uso da opção
	**REGENIE** para que o make recrie todas as configurações
	necessárias durante a compilação desta versão customizada do MAME.

*	É possível usar os núcleos extras do seu processador para ajudar a
	reduzir o tempo de compilação. Isso é feito adicionando o parâmetro
	**-j** ao comando make. Observe que a quantidade máxima de núcleos
	que você pode usar fica limitado a quantidade de núcleos que o seu
	processador tiver mais um. Usando valores acima do limite do seu
	processador não faz com que a compilação fique mais rápida, além
	disso, a sobrecarga extra de processamento pode fazer com que seu
	processador superaqueça, seu sistema pode ficar mais lento e pare de
	responder, etc. Logo, a configuração ideal para se obter a melhor
	velocidade possível de compilação num processador Quad Core seria
	**make -j5**, por exemplo.

*	As instruções de depuração também podem ser adicionadas na
	compilação usando a opção *SYMBOLS=1*, embora seja totalmente
	desnecessária para a grande maioria das pessoas.

Abaixo um apanhado de tudo o que foi mostrado até o momento usando
apenas o driver do jogo **Pac Man**, com as ferramentas extras em um
computador com processador Quad Core i5 ou i7 por exemplo: ::

	make SOURCES=src/mame/drivers/pacman.cpp TOOLS=1 REGENIE=1 -j5


Para compilar o MAME em um notebook com processadores Dual Core i3 ou
i5 por exemplo: ::

	make -j3

.. _compiling-windows:

Microsoft Windows
-----------------

Aqui algumas notas voltadas especificamente para a compilação do MAME no
Windows.

*	Consulte `o site do MAME <https://mamedev.org/tools/>`_ para obter o
	kit completo de ferramentas mais recente para compilar o sua versão do
	MAME no Windows.

*	Você precisará baixar o conjunto de ferramentas desse link para
	começar. Esse kit de ferramentas são atualizados periodicamente,
	assim é **obrigatório** usar a versão mais recente deste kit para
	que seja possível compilar as novas versões do MAME.

*	Também é possível compilar o MAME usando o *Visual Studio 2017*
	(caso esteja instalado no seu PC) ao usar **make vs2017**. Esse
	comando *sempre* regenera todas as configurações de compilação logo,
	a opção **REGENIE=1** *não é necessário*.

*	As versões anteriores ao SDL *2 2.0.3* ou *2.0.4* tem problemas,
	certifique-se que você tenha a versão mais recente.

.. _compiling-fedora:

Fedora Linux
------------

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. As versões anteriores ao SDL *2 2.0.3* ou *2.0.4* tem
problemas, certifique-se que você tenha a versão mais recente. ::

	sudo dnf install gcc gcc-c++ SDL2-devel SDL2_ttf-devel libXinerama-devel qt5-qtbase-devel qt5-qttools expat-devel fontconfig-devel alsa-lib-devel

A compilação é exatamente como descrito acima para todas as Plataformas.

.. _compiling-ubuntu:

Debian e Ubuntu (incluindo dispositivos Raspberry Pi e ODROID)
--------------------------------------------------------------

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. As versões anteriores ao SDL *2 2.0.3* ou *2.0.4* tem
problemas, certifique-se que você tenha a versão mais recente. ::

	sudo apt-get install git build-essential libsdl2-dev libsdl2-ttf-dev libfontconfig-dev qt5-default

A compilação é exatamente como descrito acima para todas as Plataformas.

.. _compiling-arch:

Arch Linux
----------

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. ::

	sudo pacman -S base-devel git sdl2 gconf sdl2_ttf gcc qt5

A compilação é exatamente como descrito acima para Todas as Plataformas.

.. _compiling-macos:

Apple Mac OS X
--------------

Você precisará de alguns pré-requisitos para começar. Certifique-se de
estar no *OS X 10.9 Mavericks* ou mais recente.
É **OBRIGATÓRIO** o uso do SDL 2.0.4 para o OS X.

*	Instale o **Xcode** que você encontra no Mac App Store
*	Inicie o programa **Xcode**.
*	Será feito o download de alguns pré-requisitos adicionais.
	Deixe rodando antes de continuar.
*	Ao terminar saia do **Xcode** e abra uma janela do **Terminal**
*	Digite o comando ``xcode-select --install`` para instalar o kit
	obrigatório de ferramentas para o MAME.

Em seguida, é preciso baixar e instalar o SDL 2.

*	Vá para `este site <http://libsdl.org/download-2.0.php>`_ e baixe o
	arquivo .dmg para o *Mac OS X*.
*	Caso o arquivo .dmg não abra sozinho de forma automática, abra você
	mesmo
*	Clique no 'Macintosh HD' (ou seja lá o nome que você estiver usando
	no disco rígido do seu Mac), no painel esquerdo onde está localizado
	o **Finder**, abra a pasta **Biblioteca** e arraste o arquivo
	**SDL2.framework** na pasta **Frameworks**.

.. raw:: latex

	\clearpage

Por fim, para começar a compilar, use o Terminal para navegar até onde
você tem o código fonte do MAME (comando *cd*) e siga as instruções
normais de compilação acima para todas as Plataformas.

É possível fazer o MAME funcionar a partir da versão 10.6, porém é um
pouco mais complicado:

*	Você precisará instalar o **clang-3.7**, **ld64**, **libcxx** e o
	**python27** do MacPorts.
*	Em seguida, adicione essas opções ao seu comando make ou
	**useroptions.mak**:

|	``OVERRIDE_CC=/opt/local/bin/clang-mp-3.7``
|	``OVERRIDE_CXX=/opt/local/bin/clang++-mp-3.7``
|	``PYTHON_EXECUTABLE=/opt/local/bin/python2.7``
|	``ARCHOPTS=-stdlib=libc++``

.. _compiling-emscripten:

Javascript Emscripten e HTML
----------------------------

Primeiro, baixe e instale o **Emscripten 1.37.29** ou mais recente
segundo as instruções no `site oficial <https://kripken.github.io/emscri
pten-site/docs/getting_started/downloads.html>`_

Depois de instalar o Emscripten, será possível compilar o MAME direto,
usando a ferramenta '**emmake**'. O MAME completo é muito grande para
ser carregado numa página web de uma só vez, então é preferível que você
compile versões menores e separadas do MAME usando o parâmetro
*SOURCES*, por exemplo, faça o comando abaixo no mesmo diretório do
MAME: ::

	emmake make SUBTARGET=pacmantest SOURCES=src/mame/drivers/pacman.cpp

O parâmetro *SOURCES* deve apontar para pelo menos um arquivo de driver
*.cpp*. O comando make tentará localizar e reunir todas as dependências
para compilar o executável do MAME junto com o driver que você
definiu. No entanto porém, caso ocorra algum erro e o processo não
encontre algum arquivo, é necessário declarar manualmente um ou mais
arquivos que faltam (separados por vírgula). Por exemplo: ::

	emmake make SUBTARGET=apple2e SOURCES=src/mame/drivers/apple2e.cpp,src/mame/machine/applefdc.cpp

O valor do parâmetro *SUBTARGET* serve apenas para se diferenciar dentre
as várias compilações existente e não precisa ser definido caso não seja
necessário.

O Emscripten oferece suporte à compilação do WebAssembly com um loader
de JavaScript em vez do JavaScript inteiro, esse é o padrão em versões
mais recentes. Para ligar ou desligar o WebAssembly de modo forçado,
adicione ``WEBASSEMBLY=1`` ou ``WEBASSEMBLY=0`` ao comando make.

Outros comandos make também poderão ser usados como foi o
parâmetro **-j** que foi usado visando fazer uso da compilação
multitarefa.

Quando a compilação atinge a fase da emcc, talvez você veja uma
certa quantidade de mensagens de aviso do tipo *"unresolved symbol"*.
Até o presente momento, isso é esperado para funções relacionadas com o
OpenGL como a função "*glPointSize*". Outros podem também indicar que um
arquivo de dependência adicional precisa ser especificado na lista
*SOURCES*. Infelizmente, este processo não é automatizado e você
precisará localizar e informar o arquivo de código fonte assim como os
arquivos que contém os símbolos que estão faltando. Você também pode
ter a sorte de se safar caso ignore os avisos e continue a compilação,
desde que os códigos ausentes não sejam usados no momento da execução.

Se tudo correr bem, um arquivo. js será criado no diretório. Este
arquivo não pode ser executado sozinho, ele precisa de um loader HTML
para que ele possa ser exibido e que seja possível também passar os
parâmetros de linha de comando para o executável.

O `Projeto Emularity <https://github.com/db48x/emularity>`_ oferece tal
loader.

Existem amostras de arquivos .html nesse repositório que pode ser
editado para refletir as suas configurações pessoais e apontar o caminho
do seu arquivo js recém compilado do MAME. Abaixo está a lista dos
arquivos que você precisa colocar num servidor web:

*	O arquivo .js compilado do MAME
*	O arquivo .wasm do MAME caso você o tenha compilado com WebAssembly
*	Os arquivos .js do pacote Emularity (loader.js, browserfs.js, etc)
*	Um arquivo .zip com as ROMs do driver que você deseja rodar
	(caso haja)
*	Qualquer outro programa que você quiser rodar com o driver do MAME
*	Um loader do Emularity .html customizado para utilizar todos os
	itens acima.

Devido a restrição de segurança dos navegadores atuais, você precisa
usar um servidor web ao invés de tentar rodá-los localmente.

Caso algo dê errado e não funcione, você pode abrir o console Web do seu
navegador principal e ver qual o erro que ele mostra (por exemplo,
faltando alguma coisa, algum arquivo de ROM incorreto, etc).
Um erro do tipo "**ReferenceError: foo is not defined**" pode indicar
que provavelmente faltou informar um arquivo de código fonte na lista da
opção **SOURCES**.

.. _compiling-options:

Opções úteis
------------

Esta seção resume algumas opções úteis reconhecidas pelo makefile. Use
estas opções em conjunto com o comando make ou definindo-as como
variáveis de ambiente ou ainda adicionando-as ao prefixo do makefile.
Essas opções só funcionam caso você utilize a opção ``REGENIE=1`` sempre
que alguma configuração de compilação tenha sido modificada, note que o
*GENie* *não reconstrói automaticamente* os arquivos afetados por
modificações posteriormente usadas.

Opções gerais de compilação
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _mame-compilation-premake:

**PREFIX_MAKEFILE**

	Define um makefile a ser incluso no processo de compilação que
	contenha opções adicionais customizadas por você e que terá
	prioridade caso o mesmo seja encontrado (o nome predefinido é
	**useroptions.mak**).
	Pode ser útil caso você queira alternar entre diferentes
	configurações de compilação de forma simples e rápida.

.. _mame-compilation-build:

**BUILDDIR**

	Define diretório usado para a compilação de todos os arquivos do
	projeto, códigos fonte auxiliares que são gerados ao longo da
	configuração, arquivos objeto e bibliotecas intermediárias.
	Por predefinição, o nome deste diretório é **build**.

**REGENIE**

	Caso seja definido como **1**, faz com que toda a estrutura de
	instrução para a compilação do projeto seja regenerada, especialmente
	para o caso onde uma compilação tenha sido feita anteriormente e seja
	necessário alterar as configurações predefinidas anteriormente.

**VERBOSE**

	Caso seja definido como **1**, ativa o modo loquaz, isso faz com que
	todos os comandos usados pela ferramenta make durante a
	compilação apareçam. Essa opção é aplicada instantaneamente e não
	precisa do comando **REGENIE**.

.. raw:: latex

	\clearpage

**IGNORE_GIT**

	Caso seja definido como **1**, ignora o escaneamento da árvore de
	trabalho e não embute a revisão descritiva do git no campo da versão
	do executável.

Usando ferramentas de compilação alternativas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**OVERRIDE_CC**

	Define o compilador C/Objective-C.

**OVERRIDE_CXX**

	Define o compilador C++/Objective-C++.

**PYTHON_EXECUTABLE**

	Define o interpretador Python. Para compilar o MAME é necessário ter
	o Python versão *2.7*, *3* ou mais recente.

Recursos opcionais
~~~~~~~~~~~~~~~~~~

**TOOLS**

	Caso seja definido como **1**, as ferramentas adicionais que trabalham
	em conjunto com o emulador como ``unidasm``, ``chdman``, ``romcmp``,
	e ``srcclean`` serão compiladas.

**NO_USE_PORTAUDIO**

	Caso seja definido como **1**, desabilita a construção do módulo de
	saída de áudio PortAudio.

**USE_QTDEBUG**

	Caso seja definido como **1**, será incluso o depurador com a
	interface Qt em plataformas onde a mesma não vem previamente
	embutida como MacOS e Windows por exemplo, defina como **0** para
	desabilitar. É obrigatório a instalação das bibliotecas de
	desenvolvimento Qt assim como suas ferramentas para a compilação do
	depurador.
	Todo este processo varia de plataforma para plataforma.

Opções para compilação
~~~~~~~~~~~~~~~~~~~~~~

**NOWERROR**

	Defina como **1** para desabilitar o tratamento das mensagens de
	aviso do compilador como erro. Talvez seja necessário em
	configurações minimamente compatíveis.

**DEPRECATED**

	Defina como **0** para desabilitar as mensagens de aviso menos
	importantes/relevantes (repare que as mensagens de avisos não são
	tratadas como erro).

**DEBUG**

	Defina como **1** para habilitar as rotinas de verificações adicionais
	e diagnósticos habilitando o modo de depuração. É importante que
	saiba que essa opção tem impacto direto na performance do emulador e
	só tem utilidade para desenvolvedores, não compile o MAME com esta
	opção sem saber o que está fazendo.

.. raw:: latex

	\clearpage

**OPTIMIZE**

	Define o nível de otimização. O valor predefinido é **3** onde o
	foco é performance ao custo de um executável maior no final da
	compilação.
	Há também as seguintes opções:

		* **0**: Caso queira desabilitar a otimização e favorecendo a depuração.
		* **1**: Otimização simples sem impacto direto no tamanho final do executável nem no tempo de compilação.
		* **2**: Habilita a maioria das otimizações visando performance e tamanho reduzido.
		* **s**: Habilita apenas as otimizações que não impactem no tamanho final do executável.

	A compatibilidade destes valores dependem do compilador que esteja
	sendo usado.

.. _mame-compilation-symbols:

**SYMBOLS**

	Defina como **1** para habilitar a inclusão de símbolos adicionais
	de depuração para a plataforma que o executável está sendo
	compilado, além dos já inclusos (muitas plataformas por predefinição
	já incluem estes símbolos já com os nomes das funções).

.. _mame-compilation-symlevel:

**SYMLEVEL**

	Valor numérico que controla a quantidade de detalhes nos símbolos de
	depuração. Valores maiores facilitam a depuração ao custo do tempo
	de compilação e do tamanho final do executável. A compatibilidade
	destes valores dependem do compilador que esteja sendo usado.
	No caso do GNU GCC e similares estes valores são:
	
		* **1**: Incluí tabelas numéricas e variáveis externas.
		* **2**: Incluindo os itens descritos em **1**, incluí também as variáveis locais.
		* **3**: Incluí também definições macros.

.. _mame-compilation-strip-symbols:

**STRIP_SYMBOLS**

	Defina como **1** para que os símbolos de depuração ao invés de
	ficarem embutidos no MAME, sejam armazenado em um arquivo externo
	com extensão "**.sym**". Essa opção é útil para aliviar o tamanho
	final do MAME uma vez que **SYMLEVEL** com valores maiores que **1**
	geram uma grande quantidade de símbolos que podem ultrapassar o
	tamanho do executável final.

**ARCHOPTS**

	Opções adicionais que serão passadas ao compilador e ao lincador.
	Útil para a geração de códigos adicionais ou opções de interface
	binária de aplicação [1]_ como por exemplo a ativação de recursos
	opcionais do processador.

**ARCHOPTS_C**

	Opções adicionais que serão passadas ao compilador ao compilar
	arquivos de código fonte em linguagem C.

**ARCHOPTS_CXX**

	Opções adicionais que serão passadas ao compilador ao compilar
	arquivos de código fonte em linguagem C++.

**ARCHOPTS_OBJC**

	Opções adicionais que serão passadas ao compilador ao compilar
	arquivos de código fonte Objecive-C.

**ARCHOPTS_OBJCXX**

	Opções adicionais que serão passadas ao compilador ao compilar
	arquivos de código fonte Objecive-C++.

.. raw:: latex

	\clearpage

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
	Asio C++ do seu sistema ao invés de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_EXPAT**

	Defina como **1** caso prefira usar o analisador sintático Expat XML
	do seu sistema ao invés de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_ZLIB**

	Defina como **1** caso prefira usar a biblioteca de compressão zlib
	instalada no seu sistema ao invés de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_JPEG**

	Defina como **1** caso prefira usar a biblioteca de compressão de
	imagem libjpeg ao invés de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_FLAC**

	Defina como **1** caso prefira usar a biblioteca de compressão de
	áudio libFLAC ao invés de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_LUA**

	Defina como **1** caso prefira usar a biblioteca do interpretador
	Lua instalado no seu sistema ao invés de usar a versão fornecida
	pelo MAME.

**USE_SYSTEM_LIB_SQLITE3**

	Defina como **1** caso prefira usar a biblioteca do motor de
	pesquisa SQLITE do seu sistema ao invés de usar a versão fornecida
	pelo MAME.

**USE_SYSTEM_LIB_PORTMIDI**

	Defina como **1** caso prefira usar a biblioteca PortMidi instalada
	no seu sistema ao invés de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_PORTAUDIO**

	Defina como **1** caso prefira usar a biblioteca PortAudio do seu
	sistema ao invés de usar a versão fornecida pelo MAME.

**USE_BUNDLED_LIB_SDL2**

	Defina como **1** caso prefira usar a versão da biblioteca fornecida
	pelo MAME ao invés da versão instalada no seu sistema. Essa opção já
	vem predefinida para compilações feitas em Visual Studio e em
	versões para Android. Já para outras outras configurações, é
	preferível que seja usada a versão instalada no sistema.

.. raw:: latex

	\clearpage

**USE_SYSTEM_LIB_UTF8PROC**

	Defina como **1** caso prefira usar a biblioteca Julia utf8proc
	instalada no seu sistema ao invés de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_GLM**

	Defina como **1** caso prefira usar a biblioteca GLM OpenGL
	Mathematics do seu sistema ao invés de usar a versão fornecida pelo
	MAME.

**USE_SYSTEM_LIB_RAPIDJSON**

	Defina como **1** caso prefira usar a biblioteca Tencent RapidJSON
	do seu sistema ao invés de usar a versão fornecida pelo MAME.

**USE_SYSTEM_LIB_PUGIXML**

	Defina como **1** caso prefira usar a biblioteca pugixml do seu
	sistema ao invés de usar a versão fornecida pelo MAME.

.. _compiling-issues:

Problemas conhecidos
--------------------

Problemas relacionados com versões específicas do compilador
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	* O GNU GCC 5 há erros esporádicos no Linux onde ocorre alertas de
	  reprovação. [2]_
	  Use a opção **DEPRECATED=0** para eliminá-los.

	* O MinGW GCC 7 para Windows i386 gera erros esporádicos com alertas
	  de acesso fora dos limites. [3]_
	  Use a opção **NOWERROR=1** para eliminá-los.

	* Versões iniciais do GNU libstdc++ 6 contém uma implementação
	  ``std::unique_ptr`` quebrada. Caso encontre qualquer mensagem de
	  erro relacionado com ``std::unique_ptr`` você precisa atualizar o
	  seu libstdc++ para uma versão mais recente.

Recursos do código fonte fortify da biblioteca GNU C
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A biblioteca GNU C possui opções para realizar verificações durante a
compilação e verificações durante a execução, use ``_FORTIFY_SOURCE``
como ``1`` para habilitar o recurso. Essa opção visa melhorar a
segurança ao custo de uma pequena sobrecarga no executável. O MAME não é
um programa seguro e nós não recomendamos que o MAME seja compilado com
essa opção definida.

Algumas distribuições Linux como Gentoo e Ubuntu possuem versões
modificadas do GNU GCC que já vem com o ``_FORTIFY_SOURCE`` habilitado
com ``1``. Isso gera problemas para a maioria dos projetos e não apenas
para o MAME, pois afeta diretamente a performance do emulador, dificulta
que essas verificações adicionais sejam desabilitadas, assim como torna
difícil definir outros valores para ``_FORTIFY_SOURCE`` como ``2`` por
exemplo, que habilita verificações ainda mais restritas.
Neste caso, você deve realmente pegar no pé dos mantenedores da sua
distribuição preferida, deixando claro que você não quer que o GNU GCC
tenha comportamentos fora do padrão.

Seria melhor que essas distribuições predefinissem essa opção em seu
próprio ambiente de desenvolvimento de pacotes caso eles acreditem que
de fato, tal opção seja realmente importante, ao invés de obrigar a
todos a usarem em todo e qualquer código fonte que seja compilado no
sistema sem necessidade.

A distribuição Red Had faz da seguinte maneira, a opção
``_FORTIFY_SOURCE`` é definida apenas dentro do ambiente de compilação
dos pacotes RPM e ao invés de distribuir uma versão modificada do GNU
GCC.

.. raw:: latex

	\clearpage

Caso você encontre erros relacionados com ``bits/string_fortified.h``,
você deve antes de mais nada verificar e ter certeza se
``_FORTIFY_SOURCE`` já está configurada no ambiente ou junto com
**CFLAGS** ou **CXXFLAGS** por exemplo. É possível verificar o seu
ambiente para saber se ``_FORTIFY_SOURCE`` está predefinido com o
comando abaixo: ::

	gcc -dM -E - | grep _FORTIFY_SOURCE

Caso ``_FORTIFY_SOURCE`` já esteja predefinido com um valor diferente de
zero, é possível usar uma solução paleativa com ``-U_FORTIFY_SOURCE``.
Use em suas opções de compilação **ARCHOPTS** ou redefinindo as suas
variáveis de ambiente **CFLAGS** e **CXXFLAGS**.

.. _compiling-unusual:

Configurações para compilações não ortodoxas
--------------------------------------------

Usando libc++ no Linux
~~~~~~~~~~~~~~~~~~~~~~

O MAME pode ser compilado usando a biblioteca padrão C++ "libc++" do
projeto LLVM. Os pré-requisitos são uma instalação funcional do
clang/LLVM no seu sistema e a biblioteca de desenvolvimento libc++. No
Linux Fedora os pacotes necessários são **libcxx**, **libcxx-devel**,
**libcxxabi** e **libcxxabi-devel**. Defina os compiladores clang C e
C++ assim como o **-stdlib=libc++** nas opções do compilador C++ e seu
lincador.
O comando completo ficaria assim: ::

	env LDFLAGS=-stdlib=libc++ make OVERRIDE_CC=clang OVERRIDE_CXX=clang++ ARCHOPTS_CXX=-stdlib=libc++ ARCHOPTS_OBJCXX=-stdlib=libc++

As opções depois do comando make podem ser armazenadas em um
makefile customizado como descrito em :ref:`PREFIX_MAKEFILE
<mame-compilation-premake>`, porém o **LDFLAGS** precisa ser definido no
seu ambiente.

Usando uma instalação do GNU GCC libstdc++ que esteja fora do local tradicional no Linux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O GNU GCC pode ter sido compilado e instalado em um local diferente caso
o mantenedor do mesmo utilize a opção ``--prefix=`` junto com o comando
``configure``. Isso pode ter utilidade caso você queira compilar o MAME
em uma distribuição Linux que ainda usa a versão do GNU libstdc++ que
antecede o C++14. Caso queira compilar o MAME com uma verão alternativa
do GNU GCC que esteja instalada em seu sistema, defina o caminho
completo dos compiladores C (gcc) e C++ (g++), assim como, adicione o
caminho completo da biblioteca do seu sistema. Supondo que você tenha o
GNU GCC instalado em ``/opt/local/gcc63``, você irá usar o comando de
compilação como mostrado abaixo: ::

	make OVERRIDE_CC=/opt/local/gcc63/bin/gcc OVERRIDE_CXX=/opt/local/gcc63/bin/g++ ARCHOPTS=-Wl,-R,/opt/local/gcc63/lib64

Essas configurações podem ser armazenadas em um makefile customizado
como descrito em :ref:`PREFIX_MAKEFILE <mame-compilation-premake>` caso
você pretenda utilizá-las regularmente.


.. [1]	No Inglês ABI ou `Application Binary Interface
		<https://pt.wikipedia.org/wiki/Interface_binária_de_aplicação>`_.
		(Nota do tradutor)
.. [2]	Deprecation warnings. (Nota do tradutor)
.. [3]	Out-of-bounds access. (Nota do tradutor)
