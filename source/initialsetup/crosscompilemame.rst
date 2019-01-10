.. raw:: latex

	\clearpage

Compilação cruzada
==================

Definição
---------

Compilação cruzada [1]_ é o processo de poder compilar um executável
numa plataforma diferente da qual ela se destina. Como usar o ambiente
Linux para compilar um programa que rode no Windows, Mac ou qualquer
outra plataforma compatível com o MAME.
Nas instruções a seguir iremos  configurar um ambiente de compilação
cruzada em uma plataforma Linux para compilar uma versão do MAME voltada
para o Microsoft Windows, apesar do processo abaixo ser voltado para
Windows, ele pode servir também de modelo para que você possa compilar o
MAME para outras plataformas compatíveis além do Windows.

Vantagens
---------

Dentre as várias vantagens é possível citar as mais relevantes:

*	Transformar o código fonte em linguagem de máquina consome muitos
	recursos e em geral a plataforma de destino pode não ter todos os
	recursos disponíveis em comparação com computador que está sendo
	usando para compilar, como por exemplo, poder de processamento,
	memória, etc.

*	Ainda que você utilize o mesmo computador com dois sistemas
	operacionais instalados como o Linux e o Windows no mesmo
	computador, o tempo que você leva para compilar uma versão do MAME
	para o Linux é muito menor do que compilar uma versão nativa do
	MAME no Windows. Compilar uma versão do MAME para Linux leva em
	torno de 30 minutos para mais ou para menos dependendo do poder de
	processamento do seu computador, compilando o mesmo código fonte do
	MAME, na mesma máquina com o Windows, usando a mesma versão do *gcc*
	e *g++*, a tarefa pode levar algumas *horas* [2]_ ainda que você tenha um
	computador mais recente.

*	Ao utilizar o processo de compilação cruzada, o tempo final de
	compilação leva aproximadamente o mesmo tempo que a versão nativa do
	Linux fazendo com que você ganhe tempo e economize recursos, afinal
	de contas, manter o processador a 100% compilando o código fonte por
	cerca de 30 minutos é uma coisa, fazer exatamente a mesma coisa
	gastando algumas horas além de ser uma perda de tempo, a sua conta
	de energia pode ficar um pouco mais cara no final do mês.

*	Assim o motivo principal para adotar a compilação cruzada é a
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
procedimento será semelhante bastando que você escolha o conjuntos de
pacotes apropriados para a plataforma que você deseja compilar.
O comando abaixo vai instalar ferramentas adicionais além das quais já
foram descritas na seção :ref:`compiling-ubuntu`, note que o
comando abaixo é formado por uma linha só: ::

	sudo aptitude install binutils-mingw-w64-x86-64 g++-mingw-w64 g++-mingw-w64-x86-64 gcc-mingw-w64 gcc-mingw-w64-base gcc-mingw-w64-x86-64 gobjc++-mingw-w64 mingw-w64 mingw-w64-common mingw-w64-tools mingw-w64-x86-64-dev win-iconv-mingw-w64-dev

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

Precisamos disponibilizar as variáveis **MINGW64** e **MINGW32** no
ambiente, elas são necessárias para que os scripts usados para a
compilação do MAME saibam onde encontrá-los.
Não é necessário usar o *sudo* para o comando abaixo pois você deseja
aplicar a variável no ambiente da sua conta comum, não use uma conta com
poderes administrativos. É mais fácil criar uma conta comum apenas para
ser utilizada para compilar o MAME.

|	``echo "export MINGW64="/usr/x86_64-w64-mingw32"" >> ~/.bashrc``
|	``echo "export MINGW32="/usr/i686-w64-mingw32"" >> ~/.bashrc``

Recarregue as configurações do seu terminal com o comando ``. .bashrc``
(ponto, espaço, ponto bashrc) ou saia e retorne à sua conta. É
necessário aferir a configuração para que se tenha certeza de que as
variáveis estão definidas no ambiente corretamente fazendo o comando
abaixo:

|	``$ echo $MINGW64``
|	``/usr/x86_64-w64-mingw32``
|	``$ echo $MINGW32``
|	``/usr/i686-w64-mingw32``

Caso o seu ambiente não tenha retornado nada, tenha certeza de que as
instruções acima foram seguidas corretamente, se a sua distribuição
Linux - ou outra distribuição - utiliza o arquivo ``.bashrc``, caso não
utilize, verifique no manual da sua distribuição qual arquivo de
configuração ela utiliza para armazenar as variáveis do ambiente e onde
ele se localiza.

.. A nice and clean way to do a page break, this case for latex and PDF
   only.
.. raw:: latex

	\clearpage

Compilando o MAME para Windows no Linux
---------------------------------------

Para compilar uma versão *64-bit* do MAME para o **Windows**, execute o
comando abaixo, lembrando que o comando deve ser executado de dentro da
pasta raiz [4]_ do código fonte do MAME: ::

	make clean && make TARGETOS=windows SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1

Caso você queira compilar uma versão *32-bit* do MAME faça o comando
abaixo: ::

	make clean && make TARGETOS=windows SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1

Assim como na compilação nativa, você pode adicionar a opção **-j** no
final do comando visando acelerar o processo de compilação usando os
núcleos do seu processador como já foi explicado com mais detalhes no
capítulo :ref:`compiling-mame`: ::

	make clean && make TARGETOS=windows SYMBOLS=1 SYMLEVEL=1 STRIP_SYMBOLS=1 SSE2=1 PTR64=1 -j5

Abaixo estão as descrições resumidas das opções usadas:

**make**

	Executa o comando de compilação do código fonte.

**clean**

	Apaga todo o diretório :ref:`build <mame-compilation-build>`.

**TARGETOS**

	Define o Sistema Operacional de destino, é importante deixar claro
	que essa opção é desnecessária caso esteja compilando o MAME
	nativamente, os valores válidos são:

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

.. raw:: latex

	\clearpage

**SYMBOLS=1**

	Veja :ref:`SYMBOLS <mame-compilation-symbols>`

**SYMLEVEL=1**

	Veja :ref:`SYMLEVEL <mame-compilation-symlevel>`

**STRIP_SYMBOLS=1**

	Veja :ref:`STRIP_SYMBOLS <mame-compilation-strip-symbols>`

**SSE2=1**

	**Double Precision Streaming SIMD Extensions**, em resumo, são
	instruções que otimizam o desempenho em processadores
	compatíveis. O MAME terá uma melhor performance quando essa
	opção é utilizada durante a compilação.
	Assim informa a `nota publicada
	<https://www.mamedev.org/?p=451>`_ no site do MAME.

**PTR64=1**

	Define o tamanho do ponteiro em bit, assim sendo, gera uma versão
	64-bit do executável do MAME ou 32-bit quando não for definido.

Caso não haja nenhum problema durante o processo de compilação, você
terá um executável do MAME chamado **mame64.exe** para a versão *64-bit*
ou **mame.exe** caso você tenha compilado uma versão para *32-bit*.

Lidando com alguns problemas comuns
-----------------------------------

Junto com estes binários será criado também um arquivo de símbolos,
para a versão *64-bit* será criado o arquivo **mame64.sym** ou
**mame.sym** para a versão *32-bit*. Estes arquivos devem **sempre**
estar junto com o executável do MAME, pois em caso de algum erro crítico
durante a emulação, esse arquivo "**.sym**" é usado para traduzir as
referências usadas no código fonte junto com os códigos de erro, muito
útil para os desenvolvedores. Aqui um exemplo de um erro que causou a
parada do MAME: ::

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
como um código hexadecimal, com a ajuda do arquivo de símbolos esses
códigos são traduzidos para algo legível e compreensível para os
desenvolvedores. Caso o MAME trave durante a emulação, uma tela
semelhante irá aparecer, copie e reporte [5]_ o erro no fórum
`MAME testers <https://mametesters.org/view_all_bug_page.php/>`_.

Algumas vezes o processo de compilação é interrompido antes de chegar ao
fim, os motivos são os mais diversos, pode ser a falta de alguma
biblioteca, erro de configuração em algum lugar, uma atualização do
código fonte onde algum desenvolvedor deixou passar algo desapercebido,
enfim, se você está encarando a tarefa de compilar o seu próprio MAME,
"*problema*" é algo que você deve estar preparado caso ocorra.

A primeira coisa a se prestar atenção é ver no terminal, console ou
*prompt de comando* que você estiver usando, qual o erro que fez todo o
processo parar, para compilar novamente a partir do ponto que a
compilação parou, tudo o que você precisa fazer é repetir o comando de
compilação sem o **make clean &&** no começo. 

Observe que caso você esteja atualizando o código fonte direto do
`repositório GIT do MAME <https://github.com/mamedev/mame>`_, é
necessário que você SEMPRE faça um **make clean** antes de compilar
um novo binário, independente da plataforma.

Geralmente o processo continua sem maiores problemas, porém caso o
processo pare novamente no mesmo lugar, pode haver algum outro problema
como a falta de alguma biblioteca, incompatibilidade com alguma coisa,
etc.
Caso esteja usando a versão "GIT" ao invés da versão final do MAME,
saiba que a versão "GIT" sofre várias atualizações ao longo do dia e por
isso aguarde algumas horas, atualize novamente o código fonte e tente
outra vez.

.. [1]	Cross compiling no Inglês. (Nota do tradutor)
.. [2]	Todo o processo no meu computador leva cerca de 4 horas, AMD FX
		tm-8350, 16GiB de memória DDR3. (Nota do tradutor)
.. [3]	IEEE é conhecido no Brasil como `Instituto de Engenheiros
		Eletricistas e Eletrônicos <https://pt.wikipedia.org/wiki/Instituto_de_Engenheiros_Eletricistas_e_Eletrônicos>`_. (Nota do tradutor)
.. [4]	Fica no mesmo diretório onde existe um arquivo chamado
		**makefile**. (Nota do tradutor)
.. [5]	Pedimos a gentileza de relatar os problemas encontrados em
		Inglês. (Nota do tradutor)