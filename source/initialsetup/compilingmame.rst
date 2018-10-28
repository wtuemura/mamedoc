.. _compiling-MAME:

Compilando o MAME
=================


Para todas as plataformas
-------------------------

*	Sempre que você estiver alterando os parâmetros de construção, (como
	alternar entre uma versão baseada em SDL e uma versão nativa do
	Windows ou adicionar ferramentas à lista de compilação) você precisa
	executar um **make REGENIE=1** para fazer com que todas as novas
	opções adicionais sejam incluídas nos arquivos de configuração
	responsável pela construção do executável do MAME. Caso não seja
	feito, será muito complicado identificar e localizar possíveis
	erros.

*	Caso você queira incluir as ferramentas adicionais na sua compilação
	como por exemplo, o programa *CHDMAN*, adicione a opção **TOOLS=1**
	ao comando make, assim **make REGENIE=1 TOOLS=1**. Isso fará com que
	o make compile todas as outras ferramentas que acompanham o MAME
	além do *CHDMAN*.

*	Você pode customizar a sua compilação escolhendo um driver em
	específico caso queira, usando a opção *SOURCES=<driver>* junto com
	o comando make. Por exemplo, caso queira compilar uma versão
	customizada do MAME que só rode o jogo **Pac Man**, você faz assim
	**make SOURCES=src/mame/drivers/pacman.cpp REGENIE=1**, note que é
	muito importante não se esquecer da opção obrigatória **REGENIE**
	para que o make recrie todas as configurações necessárias durante a
	compilação desta versão customizada do MAME.

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

Aqui alguns exemplos somando tudo o que foi mostrado até agora para
reconstruir o MAME com apenas o driver do jogo **Pac Man**, com as
ferramentas extras em um computador com processador Quad Core (i5 ou i7
por exemplo):

	``make SOURCES=src/mame/drivers/pacman.cpp TOOLS=1 REGENIE=1 -j5``


Reconstruindo o MAME em um notebook com processadores Dual Core (i3 ou i5 por exemplo):

	``make -j3``


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


Fedora Linux
------------

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. As versões anteriores ao SDL *2 2.0.3* ou *2.0.4* tem
problemas, certifique-se que você tenha a versão mais recente.

	``sudo dnf install gcc gcc-c++ SDL2-devel SDL2_ttf-devel
	libXinerama-devel qt5-qtbase-devel qt5-qttools expat-devel
	fontconfig-devel alsa-lib-devel``

A compilação é exatamente como descrito acima para todas as Plataformas.

.. _compiling-MAME-Debian:

Debian e Ubuntu (incluindo dispositivos Raspberry Pi e ODROID)
--------------------------------------------------------------

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar. As versões anteriores ao SDL *2 2.0.3* ou *2.0.4* tem
problemas, certifique-se que você tenha a versão mais recente.

	``sudo apt-get install git build-essential libsdl2-dev
	libsdl2-ttf-dev libfontconfig-dev qt5-default``

A compilação é exatamente como descrito acima para todas as Plataformas.


Arch Linux
----------

Alguns pré-requisitos precisam ser atendidos na sua distro antes de
continuar.

	``sudo pacman -S base-devel git sdl2 gconf sdl2_ttf gcc qt5``

A compilação é exatamente como descrito acima para Todas as Plataformas.


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

Por fim, para começar a compilar, use o Terminal para navegar até onde
você tem o código fonte do MAME (comando *cd*) e siga as instruções
normais de compilação acima para todas as Plataformas.

É possível fazer o MAME funcionar a partir da versão 10.6, porém é um
pouco mais complicado:

*	Você precisará instalar o **clang-3.7**, **ld64**, **libcxx** e o
	**python27** do MacPorts.
*	Em seguida, adicione essas opções ao seu comando make ou
	useroptions.mak:

|	``OVERRIDE_CC=/opt/local/bin/clang-mp-3.7``
|	``OVERRIDE_CXX=/opt/local/bin/clang++-mp-3.7``
|	``PYTHON_EXECUTABLE=/opt/local/bin/python2.7``
|	``ARCHOPTS=-stdlib=libc++``



Javascript Emscripten e HTML
----------------------------

Primeiro, baixe e instale o **Emscripten 1.37.29** ou mais recente
segundo as instruções no `site oficial <https://kripken.github.io/emscri
pten-site/docs/getting_started/downloads.html>`_

Depois de instalar o Emscripten, será possível compilar o MAME direto,
usando a ferramenta '**emmake**'. O MAME completo é muito grande para
ser carregado numa página web de uma só vez, então é preferível que você
compile versões menores e separadas do MAME usando o parâmetro
*SOURCES*, por exemplo, faça o comando abaixo no mesmo diretório do MAME:

	``emmake make SUBTARGET=pacmantest SOURCES=src/mame/drivers/pacman.cpp``

O parâmetro *SOURCES* deve apontar para pelo menos um arquivo de driver
*.cpp*. O comando make tentará localizar e reunir todas as dependências
para compilar o executável do MAME junto com o driver que você
definiu. No entanto porém, caso ocorra algum erro e o processo não
encontre algum arquivo, é necessário declarar manualmente um ou mais
arquivos que faltam (separados por vírgula). Por exemplo:

|	``emmake make SUBTARGET=apple2e SOURCES=src/mame/drivers/apple2e.cpp,src/mame/machine/applefdc.cpp``

O valor do parâmetro *SUBTARGET* serve apenas para se diferenciar dentre
as várias compilações existente e não precisa ser definido caso não seja
necessário.

O Emscripten oferece suporte à compilação do WebAssembly com um loader
de JavaScript em vez do JavaScript inteiro, esse é o padrão em versões
mais recentes. Para ligar ou desligar o WebAssembly de modo forçado,
adicione **WEBASSEMBLY=1** ou **WEBASSEMBLY=0** ao comando make.

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
