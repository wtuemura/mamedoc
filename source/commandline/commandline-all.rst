.. _universal-command-line:

Opções Universais para a linha de comando
=========================================

.. _mame-commandline-paths:

Nome dos arquivos e a localização dos diretórios
------------------------------------------------

O MAME aceita a utilização de mais de um caminho nas suas configurações,
como por exemplo, as configurações que permitam a pesquisa de ROMs em
diferentes locais, desde que tais configurações utilizem ``;`` para
separar cada caminho.

O MAME consegue também identificar o caminho dos locais dos diretórios
usando as variáveis de ambiente já existente no seu sistema e sua
sintaxe irá depender do sistema operacional a ser usado. No Windows por
exemplo, caso a configuração **%APPDATA%\mame\cfg** seja definida, o
MAME conseguirá ler a variável **%APPDATA%** e resolver o caminho
completo para o diretório de dados de aplicativos do usuário.

Em sistemas estilo UNIX como macOS e Linux que utilizam o interpretador
de comandos Bourne Shell, aconteceria o mesmo caso o caminho seja
definido nas configurações como **/home/${USER}/.mame/cfg**. Assim como
o sinal de porcentagem **%** é usado em uma palavra para se definir uma
variável no ambiente do Windows, o sinal de til ``~`` serve como um
redirecionador para o diretório home do usuário, assim em vez de se
digitar o caminho completo **/home/${USER}/.mame/cfg** é possível
possível simplificar usando **~/.mame/cfg**.

Note porém que o MAME só aceita interpretações de variáveis simples, o
MAME não reconhece expressões mais complexas compatíveis com Bash, ksh,
ou zsh.

Os caminhos relativos são resolvidos a partir do diretório de trabalho
atual. Caso inicie o MAME com um clique duplo, o diretório de trabalho
atual será aquele onde estiver o executável do MAME. Caso faça o mesmo
usando um macOS, será aberto uma janela de terminal onde o seu diretório
home será o seu diretório de trabalho.

Caso queira um comportamento semelhante ao Windows Explorer no macOS,
crie um script que contenha as linhas do exemplo abaixo no mesmo
diretório onde se encontra o executável do MAME, no exemplo abaixo está
sendo usada a versão 64-bit do MAME, mude conforme necessário. ::

	#!/bin/sh
	cd "`dirname "$0"`"
	exec ./mame64

Salve o script com um nome qualquer como **meumame** por exemplo no
mesmo diretório do executável do MAME, abra o seu terminal e torne o
script executável com o comando **chmod u+x meumame**, agora ao executar
o script, uma janela do terminal se abrirá, o MAME será executado e o
diretório de trabalho será definido no mesmo local do script.

Conjunto de instruções
----------------------

Muitos comandos são compatíveis com o uso de um *conjunto de instruções*
ou um padrão [1]_, que pode ser um sistema ou um nome abreviado do
dispositivo (como por exemplo, **a2600**, **zorba_kbd**) ou um conjunto
de instruções globais que correspondam a um dos dois como ``zorba_*``
por exemplo.

Dependendo do comando que foi combinado com este conjunto de
instruções, a correspondência dessas combinações podem equiparar um
sistema ou sistemas e dispositivos. É aconselhável colocar aspas em
torno dos seus arranjos para evitar que o seu ambiente tente
interpretá-los de forma independente em relação aos nomes dos arquivos
que desejamos usar (por exemplo, ``mame -validate "pac\*"``).

Opções de ajuda e verificação
-----------------------------

.. _mame-commandline-help:

**-help** / **-h** / **-?**

	Exibe a versão atual do MAME e o aviso de direitos autorais. ::

		mame64 -help

.. _mame-commandline-validate:

**-validate** / **-valid** [<*palavra chave a ser pesquisada*>]

	Executa validação interna em um ou mais drivers e dispositivos
	no sistema. Execute isso antes de enviar qualquer alterações para
	nós visando garantir qualquer tipo de violação em nenhuma das
	regras do sistema principal.

	Caso um padrão seja definido, ele validará a correspondência
	predefinida do sistema em questão, caso contrário, validará todos
	os sistemas e dispositivos. Note que caso um padrão seja definido,
	este será comparado apenas com sistemas e não com outros
	dispositivos, nenhum tipo de validação será realizada com
	dispositivos. ::

		mame64 -validate
		Driver ace100 (file apple2.cpp): 1 errors, 0 warnings
		Errors:
		Software List device 'flop525_orig': apple2_flop_orig.xml: Errors parsing software list:
		apple2_flop_orig.xml(126.2): Unknown tag: year
		apple2_flop_orig.xml(126.8): Unexpected content
		apple2_flop_orig.xml(127.2): Unknown tag: publisher

.. raw:: latex

	\clearpage

.. _mame-commandline-verifyroms:

**-verifyroms** [<*palavra chave a ser pesquisada*>]

	Verifica a condição dos arquivos de imagem ROM em uma determinada
	máquina. Serão verificados todas as máquinas e diretórios válidos
	que estejam dentro do ``rompath`` (caminho da rom): ::

		mame64 -verifyroms pacman
		romset pacman [puckman] is good
		1 romsets found, 1 were OK.

	É possível usar um asterisco ao final do nome da máquina para que
	seja exibido uma lista com todas as outras máquinas relacionadas com
	o nome da máquina principal e a sua condição atual, exemplo: ::

		mame64 -verifyroms pacman*
		romset pacman [puckman] is good
		romset pacmanbl [puckman] is good
		...
		pacmanfm    : pm1-1.7f (32 bytes) - NEEDS REDUMP
		pacmanfm    : pm1-4.4a (256 bytes) - NEEDS REDUMP
		romset pacmanfm [puckman] is best available
		...
		pacmaniao   : pac-mania_111187.sound0 (65536 bytes) - NOT FOUND
		romset pacmaniao [pacmania] is bad
		...

	Todas as máquinas e arquivos de imagem ROM serão verificadas caso
	nenhum nome seja informado.

.. _mame-commandline-verifysamples:

**-verifysamples** [<*palavra chave a ser pesquisada*>]

	Verifica a condição dos arquivos **samples** informado. Todos os
	arquivos samples ou diretórios válidos serão verificados desde que
	estejam configurados em ``samplepath``: ::

		mame64 -verifysamples 005
		sampleset 005 is good
		1 samplesets found, 1 were OK.

	É possível usar um asterisco ao final do nome do sample para que
	seja exibido uma lista com todos os outros samples relacionados com
	o nome do sample principal e a sua condição atual, exemplo: ::

		mame64 -verifysamples armora*
		sampleset armora is good
		sampleset armorap [armora] is good
		sampleset armorar [armora] is good
		3 samplesets found, 3 were OK.

	Todas os samples serão listados caso nenhum nome seja informado.

.. raw:: latex

	\clearpage

.. _mame-commandline-verifysoftware:

**-verifysoftware** / **-vsoft** [<*palavra chave a ser pesquisada*>]

	Verifica se há imagens ROM inválidas ou ausentes na lista de
	software. Por predefinição, todos os drivers que possuem arquivos
	``.zip`` ou diretórios válidos no rompath (caminho da rom) serão
	verificados, no entanto, é possível limitar essa lista definindo um
	nome de driver específico ou *combinações* após o comando
	``-verifysoftware``. ::

		mame64 -vsoft x68000
		romset x68k_flop:2069ad is good
		romset x68k_flop:3takun is good
		romset x68k_flop:38mankk is good
		romset x68k_flop:4thunit is good
		...
		0000 romsets found in 1 software lists, 0000 romsets were OK.

.. _mame-commandline-verifysoftlist:

**-verifysoftlist** / **-vlist** [<*nome da lista de software*>]

	Verifica ROMs ausentes com base em uma lista de software
	predeterminado na pasta **hash**.
	É predefinido que a busca e a verificação será feita em todos os
	drivers e arquivos ``.zip`` em diretórios válidos no *rompath*
	(caminho da rom), no entanto, é possível filtrar essa lista usando
	uma palavra chave ou coringa em "*softwarelistname*" após o comando
	``-verifysoftlist``. As listas estão na pasta *hash* e devem ser
	informadas sem a extensão ``.xml``.

	O resultado é exatamente igual ao comando ``-verifysoftware``, porém
	usando uma lista de software. ::

		mame64 -vsoft x68k_flop
		romset x68k_flop:2069ad is good
		romset x68k_flop:3takun is good
		romset x68k_flop:38mankk is good
		romset x68k_flop:4thunit is good
		...
		0000 romsets found in 1 software lists, 0000 romsets were OK.

.. raw:: latex

	\clearpage

Opções de configuração
----------------------

.. _mame-commandline-createconfig:

**-createconfig** / **-cc**

	Cria um arquivo ``mame.ini`` pré-configurado. Todas as opções de
	configuração (não verbos) descritos abaixo podem ser permanentemente
	alterados, basta editar este arquivo de configuração. ::

		mame64 -cc

.. _mame-commandline-showconfig:

**-showconfig** / **-sc**

	Exibe as configurações atualmente usadas. É possível direcionar essa
	saída para um arquivo ou também é possível utilizá-lo como um
	arquivo ``.ini``, como mostra o exemplo abaixo: ::

		mame -showconfig > mame.ini

	É o mesmo que **-createconfig**.

.. _mame-commandline-showusage:

**-showusage** / **-su**

	Exibe todas as opções disponíveis no MAME que sejam compatíveis com
	o seu sistema operacional ou a versão do MAME que estiver usando,
	cada opção será acompanhada de um breve descritivo (em inglês).

	As configurações nativas do Windows como hlsl por exemplo, não
	estarão disponíveis, tão pouco serão listadas nas versões SDL do
	MAME que rodem em Linux, macOS e assim por diante.

	Todas as opções aparecem comentadas. ::

		mame64 -su
		Usage:  mame64 [machine] [media] [software] [options]
		
		Options:
		
		#
		# CORE CONFIGURATION OPTIONS
		#
		-readconfig          enable loading of configuration files
		-writeconfig         write configuration to (driver).ini on exit
		#
		# CORE SEARCH PATH OPTIONS
		#
		-homepath            path to base folder for plugin data (read/write)
		-rompath             path to ROM sets and hard disk images

.. raw:: latex

	\clearpage

Opções para listagem
--------------------

É predefinido que todos os comandos ``-list`` abaixo, exibam informações
na saída predefinida do sistema, geralmente é a tela do terminal onde
o comando foi digitado. Caso queira gravar a informação em um arquivo
texto, adicione o exemplo abaixo ao final do seu comando:

	**>]** *nome do arquivo*

Onde '*nome do arquivo*' é o nome do arquivo texto que será criado para
registrar toda a saída do terminal (por exemplo, *lista.txt*). Note que
qualquer conteúdo prévio que exista dentro deste arquivo será apagado
sem qualquer aviso prévio.
Exemplo:

	Isso cria (ou sobrescreve se já existir) o arquivo ``lista.txt`` e
	completa o arquivo com os resultados de ``-listcrc puckman``.
	Em outras palavras, a lista de cada ROM usada em Puckman e o CRC
	para essa ROM é gravada nesse arquivo.

.. _mame-commandline-listxml:

**-listxml** / **-lx** < ``dispositivo`` | ``sistema`` | ``máquina`` >

	Gera uma lista detalhada e completa de toda a informação que o MAME
	mantém em seu banco de dados interno sobre os seus dispositivos,
	sistemas, máquinas, nome do driver assim como muitas outras
	informações em formato XML. A sua saída pode ser limitada informando
	um nome de dispositivo (**ym2203** por exemplo), um sistema
	(**megadriv** por exemplo) ou máquina (**sf2** por exemplo).

	Geralmente a saída deste comando é usado para ser redirecionado em
	um arquivo texto que posteriormente é utilizado por outras
	ferramentas como :ref:`gerenciadores de ROMs
	<advanced-tricks-dat-sistema>` e interfaces intermediárias
	:ref:`front-ends <frontends>`.

	Caso utilize o MAME com o PowerShell da Microsoft, leia também
	:ref:`Redirecionamento com o PowerShell da Microsoft
	<advanced-tricks-powershell-redirect>`.

	.. code-block:: xml

		mame64 -lx sf2
		<?xml version="1.0"?>
		<!DOCTYPE mame [
		<!ELEMENT mame (machine+)>
		<mame build="0.222 (mame0222-82-g6bdc7cc979f)" debug="no" mameconfig="10">
			<machine name="sf2" sourcefile="cps1.cpp">
				<description>Street Fighter II: The World Warrior (World 910522)</description>
				<year>1991</year>
				<manufacturer>Capcom</manufacturer>
			...
			</machine>
		</mame>

.. raw:: latex

	\clearpage

.. _mame-commandline-listfull:

**-listfull** / **-ll** [<*palavra chave a ser pesquisada*>]

	Exibe uma lista com o nome da máquina pesquisada e a sua
	descrição: ::

		mame64 -ll pacman
		Name:             Description:
		pacman            "Pac-Man (Midway)"

	É possível usar um asterisco ao final do nome da máquina para que seja
	exibido uma lista com todas as outras máquinas relacionadas com o
	nome da máquina principal e as suas respectivas descrições,
	exemplo: ::

		mame64 -ll pacman*
		Name:             Description:
		pacman            "Pac-Man (Midway)"
		pacmanbl          "Pac-Man (Galaxian hardware, set 1)"
		pacmanbla         "Pac-Man (Galaxian hardware, set 2)"
		pacmanblb         "Pac-Man (Moon Alien 'AL-10A1' hardware)"
		...

	É possível também listar a descrição de sistemas, infelizmente nem
	todos os sistemas possuem descrições disponíveis ainda, exemplo: ::

		mame64 -ll neogeo*
		Name:             Description:
		neogeo            "Neo-Geo MV-6F"
		neogeo_cart_slot  "Neo Geo Cartridge Slot"
		...
		
		mame64 -ll genesis*
		Name:             Description:
		genesis           "Genesis (USA, NTSC)"
		genesis_tmss      "Genesis (USA, NTSC, with TMSS chip)"
		genesisp          "Genesis"
		...
		
		mame64 -ll snes*
		Name:             Description:
		snes              "Super Nintendo Entertainment System / Super Famicom (NTSC)"
		snes4sl           "SNES 4 Slot arcade switcher"
		snespal           "Super Nintendo Entertainment System (PAL)"
		...

	Todas as máquinas ou sistemas serão listados caso nenhum nome seja
	informado.

.. raw:: latex

	\clearpage

.. _mame-commandline-listsource:

**-listsource** / **-ls** [<*palavra chave a ser pesquisada*>]

	Exibe uma lista de drivers/dispositivos dos sistemas e o nome dos
	seus respectivos arquivos fonte. Útil para identificar qual driver o
	sistema roda, muito útil para o relatório de bugs. É predefinido que
	todos os sistemas e os dispositivos sejam listados; contudo, é
	possível limitar a lista através de um nome ou texto qualquer após a
	opção **-listsource**. ::

		mame64 -ls pacman
		pacman           pacman.cpp

	É possível também utilizar um curinga (asterisco) ao final do nome
	da máquina para que seja exibido uma lista com todas as outras
	máquinas que estejam relacionadas com o nome da máquina principal,
	exemplo: ::

		mame64 -ls pacman*
		pacman           pacman.cpp
		pacmanbl         galaxian.cpp
		...
		pacmania         namcos1.cpp

	Todas as máquinas serão listadas caso nenhuma palavra chave seja
	informada.

.. _mame-commandline-listclones:

**-listclones** / **-lc** [<*palavra chave a ser pesquisada*>]

	Exibe uma lista de clones de uma determinada máquina. O MAME irá
	listar todos os clones em seu banco de dados porém a lista pode
	ser filtrada com o uso de uma palavra chave após o comando.
	Exemplo: ::

		mame64 -lc rallyx
		Name:            Clone of:
		dngrtrck         rallyx
		rallyxa          rallyx
		rallyxm          rallyx
		rallyxmr         rallyx

.. _mame-commandline-listbrothers:

**-listbrothers** / **-lb** [<*palavra chave a ser pesquisada*>]

	Exibe uma lista com o nome do driver, da ROM principal e parentes
	que compartilhem do mesmo driver da máquina pesquisada. Exemplo: ::

		mame64 -lb 005
		Source file:         Name:            Parent:
		segag80r.cpp         005
		segag80r.cpp         astrob
		segag80r.cpp         astrob1          astrob
		segag80r.cpp         astrob2          astrob
		segag80r.cpp         astrob2a         astrob
		segag80r.cpp         astrob2b         astrob
		segag80r.cpp         astrobg          astrob
		segag80r.cpp         monsterb
		segag80r.cpp         monsterb2        monsterb
		segag80r.cpp         pignewt
		segag80r.cpp         pignewta         pignewt
		segag80r.cpp         sindbadm
		segag80r.cpp         spaceod
		segag80r.cpp         spaceod2         spaceod

.. raw:: latex

	\clearpage

.. _mame-commandline-listcrc:

**-listcrc** [<*palavra chave a ser pesquisada*>]...]

	Exibe uma lista completa com CRCs de todas as imagens ROM
	que compõem uma máquina, nomes de sistema ou dispositivo em um
	formato simples que pode ser facilmente filtrado por comandos como
	``grep``, ``awk`` e ``sed`` no Linux e macOS ou
	`findstr <https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/findstr>`_ no Windows.
	Caso nenhuma palavra chave seja usada como filtro após o comando,
	o MAME irá listar *tudo* que estiver em seu banco de dados interno.
	Exemplo: ::

		mame64 -listcrc 005
		8e68533e 1346b.cpu-u25                   005             005
		29e10a81 5092.prom-u1
		...
		1d298cb0 6331.sound-u8                   005             005

.. _mame-commandline-listroms:

**-listroms** / **-lr** [<*palavra chave a ser pesquisada*>]

	Exibe uma lista com todos os arquivos ROM que fazem parte de uma
	máquina ou dispositivo. A lista mostra o nome dos arquivos ROM,
	os valores CRC e SHA1, assim como mostra também se uma das ROMs
	contidas no arquivo estão sinalizadas como **BAD_DUMP**.
	Isso significa que o conteúdo extraído não é válido, pode conter
	erro, não foi extraído de forma correta ou de forma apropriada,
	por algum motivo não pode ser validada, etc. Caso nenhuma palavra
	chave seja usada como filtro após o comando, o MAME irá listar
	*tudo* que estiver em seu banco de dados interno. Exemplo: ::

		mame64 -lr 005
		ROMs required for driver "005".
		Name                                   Size Checksum
		1346b.cpu-u25                          2048 CRC(8e68533e) SHA1(a257c556d31691068ed5c991f1fb2b51da4826db)
		5092.prom-u1                           2048 CRC(29e10a81) SHA1(c4b4e6c75bcf276e53f39a456d8d633c83dcf485)
		...
		6331.sound-u8                            32 BAD CRC(1d298cb0) SHA1(bb0bb62365402543e3154b9a77be9c75010e6abc) BAD_DUMP

.. _mame-commandline-listsamples:

**-listsamples** [<*palavra chave a ser pesquisada*>]

	Exibe uma lista das amostras que fazem parte de uma determinada
	máquina, nomes de sistema ou nome de dispositivos. Caso nenhum termo
	seja usado como filtro depois do comando, *todos* os resultados dos
	sistemas e dispositivos serão exibidos. Exemplo: ::

		mame64 -listsamples 005
		Samples required for driver "005".
		lexplode
		sexplode
		dropbomb
		shoot
		missile
		helicopt
		whistle

.. raw:: latex

	\clearpage

.. _mame-commandline-romident:

**-romident** [<*caminho\\completo\\para\\a\\rom\\a\\desconhecida*>]

	Tenta identificar os arquivos ROM desconhecidos comparando-o com
	os arquivos cadastrados no banco de dados interno do MAME que sejam
	utilizados por apenas uma máquina ou que também sejam
	compartilhados por mais de um arquivo ``.zip`` específico. Este
	comando também pode ser usado para tentar identificar conjuntos de
	ROM retirados de placas desconhecidas. A opção vai identificar os
	arquivos compactados ou não. Exemplo: ::
	
		mame64 -romident rom_desconhecida.zip
		Identifying rom_desconhecida.zip....
		pacman.6j           = pacman.6j             msheartb   Ms. Pac-Man Heart Burn
		                    = pacman.6j             mspacman   Ms. Pac-Man
		...
		                    = pacman.5e             puckmod    Puck Man (Japan set 2)
	
	Ao finalizar, o comando retorna níveis de erro (errorlevel):

		* 0: significa que todos os arquivos foram identificados
		* 7: significa que todos os arquivos foram identificados, exceto um ou mais arquivos não qualificados como "não-ROM"
		* 8: significa que alguns arquivos foram identificados
		* 9: significa que nenhum arquivo foi identificado

.. note::

	Apesar do "errorlevel" constar na documentação oficial, o
	comando não retorna **nenhum** destes valores, pelo menos não é
	visível no terminal ou linha de comando. O comando retorna apenas a
	listagem mostrada no exemplo.

.. _mame-commandline-listdevices:

**-listdevices** / **-ld** [<*palavra chave a ser pesquisada*>]

	Exibe as especificações técnicas e todos os dispositivos conhecidos
	e conectados na máquina. Caso os slots sejam populados por
	dispositivos, todos os slots adicionais que esses dispositivos
	fornecerem ficarão visíveis com ``-listdevices`` também. Exemplo: ::

		mame64 -ld x68000
		Driver x68000 (X68000):
		<root>                       X68000
		adpcm_outl                   Volume Filter
		adpcm_outr                   Volume Filter
		crtc                         IX0902/IX0903 VINAS CRTC @ 38.86 MHz
		exp1                         Sharp X680x0 expansion slot
		exp2                         Sharp X680x0 expansion slot
		flop_list                    Software List
		gfxdecode                    gfxdecode
		gfxpalette                   palette
		hd63450                      Hitachi HD63450 DMAC @ 10.00 MHz
		keyboard                     RS232 Port
		x68k                         Sharp X68000 Keyboard
		lspeaker                     Speaker
		maincpu                      Motorola MC68000 @ 10.00 MHz
		mc68901                      Motorola MC68901 MFP @ 4.00 MHz
		...
		ym2151                       Yamaha YM2151 OPM @ 4.00 MHz

.. raw:: latex

	\clearpage

.. _mame-commandline-listslots:

**-listslots** / **-lslot** [<*sistema*>]

	Exibe uma lista com todos os slots disponíveis para o sistema e suas
	respectivas opções, caso estejam disponíveis. Exemplo: ::

		mame64 -lslot x68000
		SYSTEM           SLOT NAME        SLOT OPTIONS     SLOT DEVICE NAME
		---------------- ---------------- ---------------- ----------------------------
		x68000           keyboard         x68k             Sharp X68000 Keyboard
		
		                 upd72065:0       525hd            5.25" high density floppy drive
		
		                 upd72065:1       525hd            5.25" high density floppy drive
		
		                 upd72065:2       525hd            5.25" high density floppy drive
		
		                 upd72065:3       525hd            5.25" high density floppy drive
		
		                 exp1             cz6bs1           Sharp CZ-6BS1 SCSI-1
		                                  neptunex         Neptune-X
		                                  x68k_midi        X68000 MIDI Interface
		
		                 exp2             cz6bs1           Sharp CZ-6BS1 SCSI-1
		                                  neptunex         Neptune-X
		                                  x68k_midi        X68000 MIDI Interface

	Nem todos os itens opcionais acima estão conectados quando a
	máquina é iniciada, sendo necessário que o item descrito em
	**SLOT NAME** seja utilizado em conjunto com o **SLOT OPTIONS**,
	como por exemplo, para utilizar o dispositivo MIDI do seu computador
	faça: ::

		mame64 x68000 -exp1 x68k_midi -midiout "o seu dispositivo MIDI"

	Para saber qual o dispositivo MIDI disponível no seu sistema,
	consulte o comando :ref:`-listmidi <mame-commandline-listmidi>`.

.. _mame-commandline-listmedia:

**-listmedia** / **-lm** [<*sistema*>]

	Exibe uma lista de compatibilidade de mídia para cada sistema, como
	cartucho, cassete, disquete, etc. O comando também exibe as
	extensões conhecidas para cada sistema, caso elas existam.
	Exemplo: ::

		mame64 -lm genesis
		SYSTEM           MEDIA NAME       (brief)    IMAGE FILE EXTENSIONS SUPPORTED
		---------------- --------------------------- -------------------------------
		genesis          cartridge        (cart)     .smd  .bin  .md   .gen

.. raw:: latex

	\clearpage

.. _mame-commandline-listsoftware:

**-listsoftware** / **-lsoft** [<*sistema*>]

	Exibe o conteúdo de todas as listas de software que podem ser
	utilizadas pelo sistema ou pelos sistemas (praticamente são todos os
	arquivos XML que estão dentro do diretório **hash**).

	.. code-block:: xml

		mame64 -lsoft x68000
		<?xml version="1.0"?>
		<!DOCTYPE softwarelists [
		<!ELEMENT softwarelists (softwarelist*)>
			<!ELEMENT softwarelist (software+)>
				<!ATTLIST softwarelist name CDATA #REQUIRED>
				...
					<software name="sf2ce">
					<description>Street Fighter II' Champion Edition</description>
					<year>1993</year>
					...
				</software>
			</softwarelist>
		</softwarelists>

.. _mame-commandline-getsoftlist:

**-getsoftlist** / **-glist** [<*lista do software*>]

	Exibe o conteúdo de uma lista de software em formato XML, exatamente
	mesma coisa que ``-listsoftware`` acima, porém em vez do sistema se
	utiliza o nome da lista de software.

	.. code-block:: xml

		mame64 -glist msx1_cass
		<?xml version="1.0"?>
		<!DOCTYPE softwarelists [
		<!ELEMENT softwarelists (softwarelist*)>
			<!ELEMENT softwarelist (software+)>
				<!ATTLIST softwarelist name CDATA #REQUIRED>
				...
					<software name="albatex1">
					<description>Albatross - Extended Course 1 (Jpn)</description>
					<year>1986</year>
					...
				</software>
			</softwarelist>
		</softwarelists>

.. raw:: latex

	\clearpage

.. _osd-commandline-options:

Opções relacionadas ao que é exibido na tela (OSD)
--------------------------------------------------

.. _mame-commandline-uimodekey:

**-uimodekey** [<*tecla*>]

	Tecla usada para ativar ou desativar os controles de teclado do
	MAME. A configuração predefinida é **SCRLOCK** no Windows,
	**Forward Delete** no macOS ou **SCRLOCK** em outros sistemas como
	Linux por exemplo. Use **FN-Delete** em computadores/notebooks
	Macintosh que usem teclados compactos. ::

		mame64 ibm5150 -uimodekey DEL

.. _mame-commandline-uifontprovider:

**-uifontprovider**

	Define a fonte que será renderizada na Interface do Usuário. O
	binário oficial do MAME para Windows não é compilado com SDL, sendo
	necessário compilar uma versão compatível para que a opção ``sdl``
	funcione.
	O valor predefinido é **auto**. ::

		mame64 ajax -uifontprovider dwrite

.. tabularcolumns:: |L|C|C|C|C|C|C|

.. list-table:: Provedores compatíveis da fonte para a IU [#OQEIU]_ separado por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - win
      - dwrite
      - none
      - auto
      - 
      - sdl
    * - **macOS**
      - 
      - 
      - none
      - auto
      - osx
      - sdl
    * - **Linux**
      - 
      - 
      - none
      - auto
      - 
      - sdl


.. _mame-commandline-keyboardprovider:

**-keyboardprovider**

	Escolhe como o MAME lidará com a entrada do teclado. No Windows,
	**auto** tentará o **rawinput**, caso contrário retornará para
	**dinput**. O binário oficial do MAME para Windows não é compilado
	com SDL, sendo necessário compilar uma versão compatível para que a
	opção ``sdl`` funcione.
	O valor predefinido é **auto**. ::

		mame64 c64 -keyboardprovider win32

.. tabularcolumns:: |L|C|C|C|C|C|C|

.. list-table:: Provedores compatíveis com a entrada do teclado separado por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - auto [#KBPAutoWindows]_.
      - rawinput
      - dinput
      - win32
      - none
      - sdl
    * - **SDL (macOS e Linux)**
      - auto
      - 
      - 
      - 
      - none
      - sdl
    * - **Linux**
      - auto
      - 
      - 
      - 
      - none
      - sdl


.. raw:: latex

	\clearpage

.. _mame-commandline-mouseprovider:

**-mouseprovider**

	Escolhe como o MAME lidará com a entrada do mouse. No Windows,
	**auto** tentará o **rawinput**, caso contrário retornará para
	**dinput**. Nas versões SDL, o **auto** será predefinido como
	**sdl**.
	O binário oficial do MAME para Windows não é compilado com SDL,
	sendo necessário compilar uma versão compatível para que a opção
	``sdl`` funcione.
	O valor predefinido é **auto**. ::

		mame64 indy_4610 -mouseprovider win32

.. tabularcolumns:: |L|C|C|C|C|C|C|

.. list-table:: Opções compatíveis com a entrada do mouse separado por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - auto
      - rawinput
      - dinput
      - win32
      - none
      - sdl
    * - **SDL (macOS e Linux)**
      - auto
      - 
      - 
      - 
      - none
      - sdl
    * - **Linux**
      - auto
      - 
      - 
      - 
      - none
      - sdl


.. _mame-commandline-lightgunprovider:

**-lightgunprovider**

	Escolhe como o MAME lidará com a arma de luz (*light gun*). No
	Windows, **auto** tentará **rawinput**, caso contrário retornará
	para **win32** ou **none** caso não encontre nenhum.
	No SDL/Linux o **auto** é predefinido como **x11** ou **none**
	caso não encontre nenhum. Em outro tipo de SDL o **auto** será
	predefinido para **none**.

	O valor predefinido é **auto**. ::

		mame64 lethalen -lightgunprovider x11

.. tabularcolumns:: |L|C|C|C|C|C|C|

.. list-table:: Opções compatíveis com a entrada para a arma de luz separado por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - auto
      - rawinput
      - win32
      - none
      - 
    * - **macOS**
      - auto
      - 
      - 
      - none
      - 
    * - **Linux**
      - auto
      - 
      - 
      - none
      - x11

.. raw:: latex

	\clearpage

.. _mame-commandline-joystickprovider:

**-joystickprovider**

	Escolhe como o MAME lidará com a entrada do joystick. Repare que no
	controle do Microsoft X-Box 360 e X-Box One, eles funcionarão melhor
	com **winhybrid** ou **xinput**. A opção do controle *winhybrid*
	suporta uma mistura de DirectInput e Xinput ao mesmo tempo.
	No SDL, **auto** será predefinido para **sdl**. O binário oficial do
	MAME para Windows não é compilado com SDL, sendo necessário compilar
	uma versão compatível para que a opção ``sdl`` funcione.

	O valor predefinido é **auto**. ::

		mame64 mk2 -joystickprovider winhybrid

.. tabularcolumns:: |L|C|C|C|C|C|C|

.. list-table:: Opções compatíveis com a entrada do joystick separado por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - auto
      - winhybrid
      - dinput
      - xinput
      - none
      - sdl
    * - **SDL**
      - auto
      - 
      - 
      - 
      - none
      - sdl


Opções de MIDI e rede
---------------------

.. _mame-commandline-listmidi:

**-listmidi**

	Exibe uma lista dos nomes dos dispositivos MIDI disponíveis para
	serem utilizados durante a emulação. ::

		mame64 -listmidi
		MIDI output ports:
		Microsoft MIDI Mapper (default)
		CoolSoft MIDIMapper
		Microsoft GS Wavetable Synth
		VirtualMIDISynth #1

.. _mame-commandline-midiin:

**-midiin** [<*nome do dispositivo*>]

	Informe manualmente o dispositivo MIDI de entrada da sua preferência
	caso o seu computador ou sistema utilize mais de um. O comando
	apenas funciona nas máquinas compatíveis e que estejam funcionando
	com uma entrada MIDI. Consulte também a opção :ref:`-listslot
	<mame-commandline-listslots>` para identificar o nome do slot.
	Caso o nome do dispositivo tenha espaço, use aspas. ::

		mame64 sistema -nome-do-slot -midiin "nome do dispositivo"

.. _mame-commandline-midiout:

**-midiout** [<*nome do dispositivo*>]

	Informe manualmente o dispositivo MIDI de saída da sua preferência
	caso o seu computador ou sistema utilize mais de um. O comando
	apenas funciona nas máquinas compatíveis e que estejam funcionando
	com uma entrada MIDI. Consulte também a opção :ref:`-listslot
	<mame-commandline-listslots>` para identificar o nome do slot.
	Caso o nome do dispositivo tenha espaço, use aspas. ::

		mame64 sistema -nome-do-slot -midiout "nome do dispositivo"

.. _mame-commandline-listnetwork:

**-listnetwork**

	Cria uma lista de adaptadores de rede disponíveis que possam ser
	usados com a emulação.

.. raw:: latex

	\clearpage

Opções de saída das notificações de tela
----------------------------------------

.. _mame-commandline-output:

**-output**

	Escolhe como o MAME lidará com o processamento das notificações da
	saída. É utilizado para conectar saídas externas como uma luz de LED
	dos botões iluminados de start para os jogadores 1 e 2 em
	determinadas máquinas arcade, assim como qualquer outro tipo de
	iluminação externa caso esteja disponível. ::

		mame64 galaxian -output console
		lamp0 = 1
		lamp1 = 1
		lamp0 = 0
		lamp1 = 0

	Tão logo um crédito seja inserido e se for o caso do botão do
	Jogador 1 (1P) começar a piscar os valores começaram a alternar na
	tela.

	Aqui no caso da máquina "Breakers": ::

		mame64 breakers -output console
		digit1 = 63
		digit2 = 63
		digit3 = 63
		digit4 = 63

	Cada máquina terá a sua própria característica.

	É possível escolher entre: **auto**, **none**, **console** ou
	**network**.

		O valor predefinido para a porta de rede é **8000**.


.. raw:: latex

	\clearpage

Opções para a configuração
--------------------------

.. _mame-commandline-noreadconfig:

**-[no]readconfig** / **-[no]rc**

	Ativa ou não a leitura dos arquivos de configuração,
	é predefinido que todos os arquivos de configuração sejam lidos em
	sequência, como mostra a lista abaixo:

- **mame.ini**

- **<meumame>.ini**

	Caso o arquivo binário do MAME seja renomeado para **mame060.exe**,
	então o MAME carregará o aquivo ``mame060.ini``.

- **debug.ini**

	Caso o depurador esteja habilitado.

- **<driver>.ini**

	Com base no nome do arquivo fonte ou driver.

- **vertical.ini**

	Para sistemas com orientação vertical do monitor.

- **horizont.ini**

	Para sistemas com orientação horizontal do monitor.

- **arcade.ini**

	Para sistemas adicionados no código fonte com a macro ``GAME()``.

- **console.ini**

	Para sistemas adicionados no código fonte com a macro ``CONS()``.

- **computer.ini**

	Para sistemas adicionados no código fonte com a macro ``COMP()``.

- **othersys.ini**

	Para sistemas adicionados no código fonte com a macro ``SYST()``.

- **vector.ini**

	Para sistemas com vetores apenas.

- **<parent>.ini**

	Para clones apenas, poderá ser chamado de forma recursiva.

- **<systemname>.ini**

	Veja mais em :ref:`advanced-multi-CFG` para mais detalhes. ::

		mame64 sf2ce -norc -ctrlr sf2

	As configurações nos INIs posteriores substituem aquelas dos INIs
	anteriores.
	Então, por exemplo, caso queira desabilitar os efeitos de
	sobreposição nos sistemas vetoriais, é possível criar um arquivo
	``vector.ini`` com a linha **effect none** nele, ele irá
	sobrescrever qualquer valor de efeito existente no seu ``mame.ini``.

		O valor predefinido é **Ligado** (**-readconfig**)

.. raw:: latex

	\clearpage

.. _mame-commandline-nowriteconfig:

**-[no]writeconfig** / **-[no]wc**

	Grava as configurações feitas no driver da máquina em um arquivo
	(driver).ini ao encerrar da emulação. O valor predefinido é
	**Desligado** (**-nowriteconfig**). ::

		mame64 sf2ce -wc -ctrlr sf2


.. raw:: latex

	\clearpage

Opções para a configuração dos diretórios principais
----------------------------------------------------

.. _mame-commandline-homepath:

**-homepath** [<*caminho*>]

	Define o caminho para onde os **plugins** Lua armazenarão os
	dados. O valor predefinido é '.' (no diretório raiz do MAME). ::

		mame64 -homepath D:\mame\lua


.. _mame-commandline-rompath:

**-rompath** / **-rp** / **-biospath** / **-bp** [<*caminho*>]

	Define o caminho completo para encontrar imagens ROM, disco rígido,
	fita cassete, etc. Mais de um caminho podem ser definidos desde que
	estejam separados por ponto e vírgula. O valor predefinido é
	**roms** (isto é, um diretório chamado **roms** no diretório raiz do
	MAME). ::

		mame64 -rompath D:\mame\roms;D:\MSX\floppy;D:\MSX\cass


.. _mame-commandline-hashpath:

**-hashpath** / **-hash_directory** / **-hash** [<*caminho*>]

	Define o caminho completo para a pasta com os arquivos **hash** que
	é usado pela *lista de software* no gerenciador de arquivos. Mais de
	um caminho podem ser definidos desde que estejam separados por ponto
	e vírgula. O valor predefinido é **hash** (isto é, um diretório chamado
	**hash** no diretório raiz do MAME). ::

		mame64 -hashpath D:\mame\hash;D:\roms\softlists


.. _mame-commandline-samplepath:

**-samplepath** / **-sp** [<*caminho*>]

	Define o caminho completo para os arquivos de amostras (samples).
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é **samples** (isto é, um
	diretório chamado **samples** no diretório raiz do MAME). ::

		mame64 -samplepath D:\mame\samples;D:\roms\samples


.. _mame-commandline-artpath:

**-artpath** [<*caminho*>]

	Define o caminho completo para os arquivos com as ilustrações
	gráficas (*artworks*) das máquinas. Essas ilustrações são imagens
	que cobrem o fundo da tela e oferecem alguns efeitos interessantes.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é **artwork** (isto é,
	um diretório chamado **artwork** no diretório raiz do MAME). ::

		mame64 -artpath D:\mame\artwork;D:\emu\shared-artwork


.. _mame-commandline-ctrlrpath:

**-ctrlrpath** [<*caminho*>]

	Define o caminho completo para os arquivos de configuração
	específico para controle. Mais de um caminho podem ser definidos
	desde que estejam separados por ponto e vírgula. O valor predefinido
	é **ctrlr** (isto é, um diretório chamado **ctrlr** no diretório
	raiz do MAME). ::

		mame64 -ctrlrpath D:\mame\ctrlr;D:\emu\meus_controles


.. raw:: latex

	\clearpage

.. _mame-commandline-inipath:

**-inipath** [<*caminho*>]

	Define um ou mais caminhos onde os arquivos ``.ini`` possam ser
	encontrados. Mais de um caminho podem ser definidos desde que
	estejam separados por ponto e vírgula.

	* No Windows a predefinição é ``.;ini;ini/presets``, traduzindo,
	  a primeira pesquisa é feita no diretório atual, a segunda no
	  diretório **ini** e finalmente no diretório **presets** dentro do
	  diretório **ini**.

	* No macOS a predefinição é
	  ``$HOME/Library/Application Support/mame;$HOME/.mame;.;ini``,
	  traduzindo, pesquisa no diretório **mame** dentro do diretório
	  **Application Support** do usuário atual, depois no diretório
	  **.mame** dentro do diretório **home** do usuário atual, depois no
	  diretório raiz e então no diretório **ini**.

	* Em outras plataformas onde se incluem o Linux, a predefinição é
	  ``$HOME/.mame;.;ini``, traduzindo, procura pelo diretório
	  **.mame** no diretório **home** do usuário atual, seguido pelo
	  diretório raiz e finalmente no diretório **ini**.

	::

		mame64 -inipath D:\mameini

.. _mame-commandline-fontpath:

**-fontpath** [<*caminho*>]

	Define um ou mais caminhos onde os arquivos de fonte ``.bdf``
	(*Adobe Glyph Bitmap Distribution Format*) possam ser encontrados.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é ‘.’ (isto é, no diretório
	raiz do MAME). ::

		mame64 -fontpath D:\mame\;D:\emu\fontes


.. _mame-commandline-cheatpath:

**-cheatpath** [<*caminho*>]

	Define o caminho completo para os arquivos de trapaça em formato
	``.xml``.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é **cheat** (isto é, uma
	pasta chamada **cheat**, localizada no diretório raiz do MAME). ::

		mame64 -cheatpath D:\mame\cheat;D:\emu\trapaças


.. _mame-commandline-crosshairpath:

**-crosshairpath** [<*caminho*>]

	Define um ou mais caminhos onde os arquivos de mira **crosshair**
	possam ser encontrados. Mais de um caminho podem ser definidos desde
	que estejam separados por ponto e vírgula. O valor predefinido é
	**crosshair** (isto é, um diretório chamado **crosshair** no
	diretório raiz do MAME). Caso uma mira seja definida no menu, o MAME
	procurará por ``nomedosistema\\cross#.png``, em seguida no
	**crosshairpath** especificado onde **#** é o número do jogador.

	Caso nenhuma mira seja definida, o MAME usará a sua própria. ::

		mame64 -crosshairpath D:\mame\crsshair;D:\emu\miras


.. _mame-commandline-pluginspath:

**-pluginspath** [<*caminho*>]

	Define um ou mais caminhos onde possam ser encontrados os plug-ins
	do Lua para o MAME. O valor predefinido é **plugins** (isto é, um
	diretório chamado **plugins** no diretório raiz do MAME). ::

		mame64 -pluginspath D:\mame\plugins;D:\emu\lua


.. raw:: latex

	\clearpage

.. _mame-commandline-languagepath:

**-languagepath** [<*caminho*>]

	Define um ou mais caminhos onde possam ser encontrados os arquivos
	de tradução que o MAME usa na Interface do Usuário. O valor
	predefinido é **language** (isto é, um diretório chamado
	**language** no diretório raiz do MAME). ::

		mame64 -languagepath D:\mame\language;D:\emu\idiomas


.. _mame-commandline-swpath:

**-swpath** [<*caminho*>]

	Define um ou mais caminhos onde possam ser encontrados os
	arquivos de programas avulsos (software). O valor predefinido é
	**software** (isto é, um diretório chamado **software** no
	diretório raiz do MAME). ::

		mame64 -swpath D:\mame\software;D:\emu\discos


.. _mame-commandline-cfgdirectory:

**-cfg_directory** [<*caminho*>]

	Define o diretório onde os arquivos de configuração são armazenados.
	Os arquivos de configuração armazenam as customizações feitas pelo
	usuário e são lidas na inicialização do MAME ou de uma máquina
	emulada, depois quaisquer alterações são salvas ao encerrar o MAME.

	Os arquivos de configuração preservam as configurações da ordem dos
	botões do seu controle ou joystick, configurações das chaves DIP,
	informações da contabilidade da máquina e a organização das janelas
	do depurador.

	O valor predefinido é **cfg** (isto é, um diretório com o nome
	**cfg** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente. ::

		mame64 -cfg_directory D:\mame\cfg

.. _mame-commandline-nvramdirectory:

**-nvram_directory** [<*caminho*>]

	Define o diretório onde os arquivos **NVRAM** são armazenados.
	Os arquivos **NVRAM** armazenam o conteúdo da **EEPROM**, memória
	RAM não volátil (NVRAM) e informações de outros dispositivos
	programáveis que fazem uso deste tipo de memória. As informações são
	lidas no início da emulação e gravadas ao encerrar.

	O valor predefinido é **nvram** (isto é, um diretório com nome
	"nvram" no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente. ::

		mame64 -nvram_directory D:\mame\nvram

.. _mame-commandline-inputdirectory:

**-input_directory** [<*caminho*>]

	Define o diretório onde os arquivos de gravação da entrada são
	armazenados. As gravações da entrada são criadas através da opção
	**-record** e reproduzidas através da opção **-playback**. A opção
	grava todos os comando e acionamentos de botões que forem feitos
	durante a operação da máquina.

	O valor predefinido é **inp** (ou seja, um diretório de nome
	**inp** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente. ::

		mame64 -input_directory D:\mame\inp


.. raw:: latex

	\clearpage

.. _mame-commandline-statedirectory:

**-state_directory** [<*caminho*>]

	Define o diretório onde os arquivos de gravação de estado são
	armazenados. Os arquivos de estado são lidos e gravados mediante a
	solicitação do usuário ou ao usar a opção ``-autosave``.

	O valor predefinido é **sta** (isto é, um diretório de nome
	**sta** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente. ::


		mame64 -state_directory D:\mame\sta

.. _mame-commandline-snapshotdirectory:

**-snapshot_directory** [<*caminho*>]

	Define o diretório onde os arquivos de instantâneos da tela são
	armazenados quando solicitado pelo usuário.

	O valor predefinido é **snap** (isto é, um diretório chamado
	**snap** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente. ::


		mame64 -snapshot_directory D:\mame\snap

.. _mame-commandline-diffdirectory:

**-diff_directory** [<*caminho*>]

	Define o diretório onde os arquivos de diferencial do disco rígido
	são armazenados. Os arquivos de diferencial armazenam qualquer dado
	que é escrito de volta na imagem do disco, isso serve para preservar
	a imagem de disco original. Os arquivos são criados no inicio da
	emulação com uma imagem compactada do disco rígido.

	O valor predefinido é **diff** (isto é, um diretório chamado
	**diff** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente. ::

		mame64 -diff_directory D:\mame\diff


.. _mame-commandline-commentdirectory:

**-comment_directory** [<*caminho*>]

	Define o diretório onde os arquivos de comentário do depurador são
	armazenados. Os arquivos de comentário do depurador são escritos
	pelo depurador quando comentários são adicionados em um sistema
	desmontado (disassembly).

	O valor predefinido é **comments** (isto é, um diretório chamado
	**comments** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente. ::

		mame64 -comment_directory D:\mame\comments


.. raw:: latex

	\clearpage

Opções para a gravação e a reprodução do estado da emulação
-----------------------------------------------------------

.. _mame-commandline-norewind:

**-[no]rewind**

	Quando ativo e a emulação for paralisada, automaticamente é salvo o
	estado da condição da memória toda a vez que um quadro for avançado.
	O rebobinamento das condições de estado que foram salvas podem ser
	carregadas de forma consecutiva ao pressionar a tecla de atalho para
	rebobinar passo único (*Shift Esquerdo + til*) [2]_.

	O valor predefinido é **Desligado** (**-norewind**).

	Caso o depurador esteja no estado *break*, a condição de estado
	atual é criada a cada 'step in', *step over* ou caso ocorra um
	*step out*. Nesse modo os estados salvos podem ser carregados e
	rebobinados executando o comando *rewind* ou *rw* no depurador. ::

		mame64 -norewind


.. _mame-commandline-rewindcapacity:

**-rewind_capacity** [<*valor*>]

	Define a capacidade de rebobinar em megabytes.
	É a quantidade total de memória que será usada para rebobinar
	savestates. Quando a capacidade alcança o limite, os antigos
	savestates são apagados enquanto novos são capturados. Definindo uma
	capacidade menor do que o savestate atual, desabilita o
	rebobinamento. Os valores negativos são automaticamente fixados em
	0. ::

		mame64 -rewind_capacity 30


.. _mame-commandline-statename:

**-statename** [<*nome*>]

	Descreve como o MAME deve armazenar os arquivos de estado salvos
	relativo ao caminho do state_directory. [<*nome*>] é uma string que
	fornece um modelo a ser usado usado para gerar um nome de arquivo.

	São disponibilizadas duas substituições simples: o caractere ``/``
	representa o separador de caminho em qualquer plataforma de destino
	(até mesmo no Windows); a string ``%g`` representa o nome do driver
	do sistema atual.

	O valor predefinido é ``%g``, que cria uma pasta separada para cada
	sistema.

	Em adição ao que foi dito acima, para os drivers que usem mídias
	diferentes, como cartões ou disquetes, é possível usar o indicador
	``%d_[media]``. Substitua ``[media]`` pelo comutador de mídia
	desejado.

	Alguns exemplos:

	* Caso use ``mame robby -statename foo/%g%i`` os instantâneos serão
	  salvos em **sta\\foo\\robby\\**.

	* Caso use ``mame nes -cart robby -statename %g/%d_cart``
	  os instantâneos serão salvos em **sta\\nes\\robby**.

	* Caso use ``mame c64 -flop1 robby -statename %g/%d_flop1/%i``
	  estes serão salvos como **sta\\c64\\robby\\0000.png**.

.. raw:: latex

	\clearpage

.. _mame-commandline-state:

**-state** [<*slot*>]

	Depois de iniciar um sistema determinado, fará com que o estado
	salvo no [<*slot*>] seja carregado imediatamente. ::

		mame64 -state 1

.. _mame-commandline-noautosave:

**-[no]autosave**

	Quando ativado, cria automaticamente um arquivo com a condição atual
	do sistema ao encerrar o MAME e automaticamente tenta recarregá-lo
	caso o MAME inicie novamente com o mesmo sistema. Isto só funciona
	para o driver dos sistemas compatíveis que suportam o salvamento da
	sua condição atual.

	O valor predefinido é **Desligado** (**-noautosave**). ::

		mame64 -autosave

.. raw:: latex

	\clearpage

.. _mame-commandline-playback:

**-playback** / **-pb** [<*nome do arquivo*>]

	Faz a reprodução de um arquivo de gravação. Esse recurso não
	funciona de maneira confiável com todos os sistemas, mas pode ser
	usado para assistir a uma sessão de jogo gravada anteriormente do
	início ao fim. Para tornar as coisas consistentes, apague os
	arquivos de configuração ``.cfg``, NVRAM ``.nv`` e o cartão de
	memória.

	O valor predefinido é **NULO** (sem reprodução). ::

		mame64 ssf2tu -playback perfect

.. note:: 

	Você pode ter problemas com a falta de sincronismo caso a
	configuração, a NVRAM, e o cartão de memória não coincidam com o
	original, inclusive caso seja utilizado uma versão do MAME muito
	diferente daquela usada na gravação. É recomendável que a
	configuração (.cfg), a NVRAM (.nv) ou o diretório com o nome da
	máquina dentro do diretório **nvram** sejam excluídos antes de
	iniciar uma gravação ou uma reprodução.


.. _mame-commandline-exitafterplayback:

**-[no]exit_after_playback**

	O MAME encerra a emulação ao final do arquivo de reprodução caso
	seja usado em conjunto com a opção **-playback**. É predefinido que
	o MAME não encerre a emulação.

	O valor predefinido é **Desligado** (**-noexit_after_playback**) ::

		mame64 ssf2tu -playback perfect -exit_after_playback

.. _mame-commandline-record:

**-record** / **-rec** [<*nome do arquivo*>]

	Faz a gravação de todos comandos feitos pelo usuários durante uma
	seção e define o nome do arquivo onde será registrado todos esses
	comandos durante uma seção.
	Esse recurso não funciona de forma confiável com todos os sistemas.

	O valor predefinido é **NULO** (sem gravação). ::

		mame64 ssf2tu -rec perfect

.. _mame-commandline-recordtimecode:

**-record_timecode**

	Diz ao MAME para criar um arquivo de **timecode**. Ele contém uma
	linha com os tempos decorridos a cada pressão da tecla de atalho
	(*O valor predefinido é F12*). Esta opção funciona apenas quando o
	modo de gravação está ativo (opção ``-record``). O arquivo é salvo
	na pasta *inp*. É predefinido que nenhum arquivo de timecode seja
	gravado. ::

		mame64 ssf2tu -rec perfect -record_timecode

.. raw:: latex

	\clearpage

Opções para a gravação de áudio e vídeo
---------------------------------------

	Há casos onde certas máquinas alternam a resolução da tela
	atrapalhando a gravação de vídeo, algumas gravações podem ficar com
	um tamanho de tela todo preto com um vídeo menor no meio ou em algum
	outro canto da tela, use essas duas opções caso isso aconteça,
	:ref:`-noswitchres <mame-commandline-switchres>` com
	:ref:`-snapsize <mame-commandline-snapsize>`.

.. _mame-commandline-mngwrite:

**-mngwrite** [<*nome do arquivo*>].mng

	Escreve cada quadro de vídeo em um arquivo [<*nome do arquivo*>] no
	formato MNG, produzindo uma animação da sessão.
	Note que ``-mngwrite`` só grava quadros de vídeo, não grava qualquer
	áudio, use a opção ``-wavwrite`` para gravar o áudio e
	posteriormente use uma ferramenta de edição de áudio qualquer para
	unir os dois, ou use **-aviwrite** para gravar áudio e vídeo em um
	único arquivo.

	O valor predefinido é **NULO** (sem gravação). ::

		mame64 ssf2tu -mngwrite ssf2tu-video.mng

.. _mame-commandline-aviwrite:

**-aviwrite** [<*nome do arquivo*>].avi

	Grava todos os dados de áudio e vídeo em formato AVI sem compressão,
	note que a taxa de quadros e a resolução são sempre fixas. Vídeos
	sem compressão ocupam muito espaço assim como, para que a gravação
	ocorra sem problemas é necessário um HDD rápido. Para alterar a
	resolução do arquivo que será gravado, consulte a opção
	:ref:`-snapsize <mame-commandline-snapsize>`.

	Talvez seja mais prático gravar os seus comandos com
	:ref:`-record <mame-commandline-record>` e
	depois fazer o vídeo com
	:ref:`-aviwrite <mame-commandline-aviwrite>` combinado com
	:ref:`-playback <mame-commandline-playback>` e
	:ref:`-exit_after_playback <mame-commandline-exitafterplayback>`.

	O valor predefinido é **NULO** (sem gravação). ::

		mame64 ssf2tu -pb perfect -aviwrite ssf2tu.avi -exit_after_playback


.. _mame-commandline-wavwrite:

**-wavwrite** [<*nome do arquivo*>].wav

	Grava apenas o áudio da seção em formato PCM 16 bits. Para gravar
	com uma taxa de amostragem diferente da predefinida (**48000 Hz**),
	consulte a opção :ref:`-samplerate <mame-commandline-samplerate>`.

	O valor predefinido é **NULO** (sem gravação). ::

		mame64 ssf2tu -wavwrite audio.wav

.. raw:: latex

	\clearpage

Opções para instantâneos de tela
--------------------------------

.. _mame-commandline-snapname:

**-snapname** [<*nome*>]

	Descreve como MAME deve nomear arquivos de instantâneos de tela.
	[<*nome*>] será o guia que o MAME usará para nomear o arquivo.

	São disponibilizadas três substituições simples:

* O caractere ``/``

	Usado como separador de caminho em qualquer plataforma inclusive no
	Windows.

* Especificador de conversão ``%g``

		Converte ``%g`` para o nome do driver que for usado.

* Especificador de conversão ``%i``

	Cria arquivos iniciando com nome ``0000`` e os incrementa enquanto
	novos instantâneos forem sendo criados, O MAME incrementará o valor
	de ``%i`` para o próximo vazio, caso ele seja omitido, os
	instantâneos existentes com o mesmo nome serão gravados por cima.

		O valor predefinido é **%g/%i**

	Para os drivers que usam mídias diferentes, como cartões ou
	disquetes, também é possível usar ``%d_[media]``.
	Substitua ``[media]`` pelo dispositivo que deseja usar.

	Alguns exemplos:

	* Caso use ``mame64 robby -snapname foo/%g%i`` os instantâneos
	  serão salvos como ``snaps\foo\robby0000.png``,
	  ``snaps\foo\robby0001.png`` e assim por diante.

	* Caso use ``mame nes -cart robby -snapname %g/%d_cart`` os
	  instantâneos serão salvos como ``snaps\nes\robby.png``.

	* No caso deste outro exemplo,
	  ``mame64 c64 -flop1 robby -snapname %g/%d_flop1/%i`` estes serão
	  salvos como ``snaps\c64\robby\0000.png``.

.. _mame-commandline-snapsize:

**-snapsize** [<*largura*>]x[<*altura*>]

	Define um tamanho fixo para os instantâneos e vídeos.
	É predefinido que o MAME criará instantâneos, assim como os vídeos,
	na resolução original do sistema em pixels brutos. Caso use
	esta opção, o MAME criará instantâneos e vídeos no tamanho
	determinado, com filtro bilinear (filtro de embaçamento de pixels)
	aplicado no resultado final. Observe que ao definir este tamanho a
	tela não gira automaticamente caso o sistema seja orientado
	verticalmente.

	O valor predefinido é **auto**. ::

		mame64 ssf2tu -snapsize 640x480

.. raw:: latex

	\clearpage

.. _mame-commandline-snapview:

**-snapview** [<*tipo*>]

	Define a exibição a ser usada ao renderizar instantâneos e vídeos.

	É predefinido que ambos usem uma exibição especial *interna*, que
	renderize uma captura instantânea separada por tela ou renderize
	os vídeos somente da primeira tela. Ao usar esta opção, é possível
	alterar o comportamento predefinido de exibição e selecionar apenas
	uma exibição que será aplicada a todos os instantâneos e vídeos.

	Observe que o [<*tipo*>] não precisa ser uma combinação perfeita,
	em vez disso, ele selecionará a primeira exibição cujo nome
	corresponda a todos os caracteres definidos por [<*tipo*>].

	Por exemplo, ``-snapview native`` irá casar a visualização
	"Nativa em (15:14)" ainda que não seja uma combinação ideal.
	O [<*tipo*>] também pode ser "auto" onde será escolhida a primeira
	exibição de todas as telas presentes.

	O valor predefinido é **internal**. ::

		mame64 ssf2tu -snapview pixel

.. _mame-commandline-nosnapbilinear:

**-[no]snapbilinear**

	Especifique se o instantâneo ou vídeo deve ter filtragem bilinear
	aplicada, o filtro bilinear aplica um leve efeito de embaçamento ou
	suavização à tela, amenizando um pouco o serrilhado nos contornos
	gráficos e suavizando a tela do sistema. Desligar essa opção pode
	fazer a diferença melhorando a performance durante a gravação do
	vídeo.

	O valor predefinido é **Ligado** (**-snapbilinear**). ::

		mame64 ssf2tu -nosnapbilinear

.. raw:: latex

	\clearpage

Opções relacionadas a performance e a velocidade da emulação
------------------------------------------------------------

.. _mame-commandline-noautoframeskip:

**-[no]autoframeskip** / **-[no]afs**

	Para que se mantenha a velocidade máxima de uma emulação, ajusta
	dinamicamente no sistema emulado a quantidade de quadros que
	serão pulados. Ativando esta opção ela se sobrepõem ao que for
	definido em **-frameskip** descrito logo abaixo.

	O valor predefinido é **Desligado** (**-noautoframeskip**). ::

		mame64 gradius4 -autoframeskip

.. _mame-commandline-frameskip:

**-frameskip** / **-fs** [<*level*>]

	Determina o valor do salto dos quadros. Ela elimina cerca de 12
	quadros enquanto estiver sendo executado. Por exemplo, caso seja
	definido ``-frameskip 2`` o MAME então exibirá 10 de cada 12
	quadros.

	Ao pular estes quadros, pode ser que se atinja a velocidade
	nativa do sistema emulado sem que haja sobrecarga no seu computador
	ainda que ele não tenha um grande poder de processamento.

	O valor predefinido é não pular nenhum quadro (**-frameskip 0**). ::

		mame64 gradius4 -frameskip 2

.. _mame-commandline-secondstorun:

**-seconds_to_run** / **-str** [<*segundos*>]

	Este comando pode ser usado para realizar um teste de velocidade de
	forma automatizada. O comando diz ao MAME para para interromper a
	emulação depois de alguns segundos. Ao combinar com outras opções
	fixas de linha de comando é possível definir um ambiente para
	realizar testes de performance. Ao encerrar, a opção ``-str``
	faz com que seja gravado um instantâneo da tela chamado *final.png*
	no diretório de
	:ref:`instantâneos <mame-commandline-snapshotdirectory>`.

	O comando diz ao MAME para interromper a emulação depois de um
	tempo determinado, o tempo em questão não é o tempo real e sim o
	tempo interno da emulação, assim, caso seja definido 30 segundos,
	pode ser que dependendo da máquina que esteja sendo emulada, a parada
	só venha a acontecer depois de algum tempo.

	Este comando também é útil para a realização de benchmarks e testes
	de automação. Ao combinar esta opção com algumas outras, é possível
	construir uma estrutura de testes de performance do MAME.
	Adicionalmente a opção ``-str``, faz também que ao final do tempo
	seja criado um instantâneo de tela chamado **final.png** dentro da
	pasta de
	:ref:`instantâneos <mame-commandline-snapshotdirectory>`. ::

		mame64 ssf2tu -str 60

.. _mame-commandline-nothrottle:

**-[no]throttle**

	Ativa ou não a função de controle de velocidade do emulador [4]_.
	Ao ativar esta opção, o MAME tenta manter o sistema rodando em
	sua velocidade nativa, com a opção desabilitada a emulação é
	executada na velocidade mais rápida possível. Dependendo das
	características do sistema emulado, a performance final pode
	limitada pelo seu processador, placa de vídeo ou até mesmo pela
	performance final da sua memória.

	O valor predefinido é **Ligado** (**-throttle**). ::

		mame64 pacman -nothrottle

.. _mame-commandline-nosleep:

**-[no]sleep**

	Quando utilizada em conjunto com ``-throttle`` o MAME elimina
	os processos não utilizados durante a limitação de velocidade da
	emulação melhorando o rendimento de processamento. Em outras
	palavras, permite que outros programas tenham mais tempo de CPU
	assumindo que a emulação não esteja consumindo 100% dos recursos do
	processador. Esta opção pode causar uma certa intermitência na
	performance caso outros programas que também demandem processamento
	estejam rodando junto com o MAME.

	O valor predefinido é **Ligado** (**-sleep**). ::

		mame64 ssf2tu -nosleep


.. _mame-commandline-speed:

**-speed** [<*fator*>]

	Muda a maneira que o MAME controla a velocidade da emulação de
	maneira que seja possível que o sistema emulado rode em múltiplos
	da sua velocidade original.

	Um [<*fator*>] **1.0** significa rodar o sistema em velocidade normal.
	Já um fator **0.5** significa rodar o sistema na metade da
	velocidade normal e um [<*fator*>] **2.0** significa rodar o sistema
	2x acima da sua velocidade normal. Note que ao mudar este valor a
	velocidade de execução do áudio irá mudar proporcionalmente também.

	A resolução interna da fração são dois pontos decimais, logo o
	valor **1.002** será arredondado para **1.0**.

	O valor predefinido é **1.0**. ::

		mame64 ssf2tu -speed 1.25

	Quando utilizado em conjunto com :ref:`-rec
	<mame-commandline-record>` é possível colocar o máquina em
	velocidade lenta como ``-speed 0.3`` enquanto grava. Ao terminar, a
	reprodução com a opção :ref:`-pb <mame-commandline-playback>`
	ocorrerá em velocidade normal, exemplo: ::

		mame64 ssf2tu -rec perfect -speed 0.3 -sound none

	A opção ``-sound none`` serve para eliminar o áudio durante a
	gravação em câmera lenta. Para mais informações, consulte
	:ref:`slowmomame <advanced-slowmomame>`.

.. _mame-commandline-norefreshspeed:

**-[no]refreshspeed** / **-[no]rs**

	Permite ao MAME ajustar a velocidade da emulação para que a taxa de
	atualização da primeira tela emulada não exceda o menor valor da
	taxa de atualização da tela de qualquer um dos monitores do seu
	sistema.
	Visando evitar cortes no áudio ou efeitos colaterais indesejáveis, o
	MAME irá reduzir a velocidade da emulação para 99% em casos onde por
	exemplo, um monitor que funcione nativamente a 60 Hz e o sistema
	emulado rode a 60.6 Hz.

	Utilize esta opção caso note pequenas travadas de tela durante cenas
	de movimentação horizontal ou vertical.

	O valor predefinido é **Desligado** (**-norefreshspeed**). ::

		mame64 ssf2tu -refreshspeed

.. raw:: latex

	\clearpage

.. _mame-commandline-numprocessors:

**-numprocessors** / **-np** [<*auto|valor*>]

	Define a quantidade de núcleos do processador que serão utilizados.
	A opção **auto** usará a quantidade de núcleos informada pelo seu
	sistema ou pela variável de ambiente **OSDPROCESSORS**. Este valor é
	limitado internamente para quatro vezes o número dos processadores
	informado pelo seu sistema.

	O valor predefinido é **auto**. ::

		mame64 ssf2tu -numprocessors 2

.. _mame-commandline-bench:

**-bench** [<*n*>]

	Define a quantidade de segundos de emulação em [<*n*>] usado para
	teste de performance, o comando é um atalho com comando abaixo:

	**-str** [<*n*>] **-video none -sound none -nothrottle** ::

		mame64 ssf2tu -bench 300

.. _mame-commandline-lowlatency:

**-[no]lowlatency**

	Diz ao MAME para desenhar um novo quadro antes de controlar a
	velocidade de emulação (:ref:`throttling
	<mame-commandline-nothrottle>`) visando reduzir o atraso (latência)
	de resposta da entrada. Esta opção é particularmente efetiva com
	telas com variação em sua taxa de atualização (Variable
	Refresh Rate).

	Esta opção pode causar um efeito colateral de despassamento ou
	problemas com o sequenciamento dos quadros gerando instabilidades
	(especialmente em sistemas mais recentes com base 3D ou dependentes
	do 3D, assim como sistemas onde rodam um software similar ao
	sistema operacional).

	O valor predefinido é **-nolowlatency**. ::

		mame64 bgaregga -lowlatency

.. raw:: latex

	\clearpage

Opções para a rotação da tela
-----------------------------

.. _mame-commandline-norotate:

**-[no]rotate**

	Gira a tela para corresponder ao seu estado normal do sistema
	(horizontal / vertical). Isso garante que os sistemas vertical e
	horizontalmente orientados sejam exibidos corretamente sem que haja
	a necessidade de girar fisicamente a sua tela. Caso queira manter a
	disposição da tela como ela é no arcade original, mantenha esta
	opção **DESLIGADA**.

	O valor predefinido é **Ligado** (**-rotate**). ::

		mame64 pacman -norotate

.. _mame-commandline-noror:

.. _mame-commandline-norol:

**-[no]ror**
**-[no]rol**

	Rotacione a tela do sistema para a direita ``-ror`` ou para a
	esquerda ``-rol`` em relação ao seu estado normal caso ``-rotate``
	seja definido ou seu estado nativo caso ``-norotate`` seja
	definido.

	O valor predefinido para ambas é **Desligado**
	(**-noror** **-norol**). ::

		mame64 pacman -ror
		mame64 pacman -rol

.. _mame-commandline-noautoror:

.. _mame-commandline-noautorol:

**-[no]autoror**
**-[no]autorol**

	Essas opções são projetadas para uso com telas giratórias que giram
	apenas em uma única direção. Caso a tela gire somente no sentido
	horário, use o comando ``-autorol`` para garantir que o sistema
	encha a tela horizontalmente ou verticalmente em uma das direções
	desejadas. Caso a sua tela gire somente no sentido anti-horário,
	use ``-autoror``. ::

		mame64 pacman -autoror
		mame64 pacman -autorol

.. _mame-commandline-noflipx:

.. _mame-commandline-noflipy:

**-[no]flipx**
**-[no]flipy**

	Espelhe a tela do sistema horizontalmente ``-flipx`` ou
	verticalmente ``-flipy``. As inversões são aplicadas depois que as
	opções de rotação ``-rotate`` e rolagem ``-ror/-rol`` forem
	aplicadas.

	O valor predefinido para ambas as opções é **Desligado**
	(**-noflipx** **-noflipy**). ::

		mame64 pacman -flipx
		mame64 pacman -flipy


.. raw:: latex

	\clearpage

Opções para a configuração de vídeo
-----------------------------------

.. _mame-commandline-video:

**-video** [<*bgfx|gdi|d3d|opengl|soft|accel|none*>]

	Define qual tipo de saída de vídeo usar. As opções aqui descritas
	dependem do sistema operacional utilizado e se a versão do MAME é
	uma versão SDL ou não.

**Opções geralmente disponíveis:**

.. _mame-commandline-video-bgfx:

	* **bgfx**

	  Determina o novo renderizador acelerado por hardware.

.. _mame-commandline-video-opengl:

	* **opengl**

	  Faz a renderização do vídeo usando `OpenGL <https://www.tecmundo.com.br/video-game-e-jogos/872-o-que-e-opengl-.htm>`_,
	  use em sistemas Windows compatíveis quando por algum motivo a opção
	  ``d3d`` causar problemas.

	  Em sistemas não Windows, essa é a opção responsável para que a
	  renderização da tela aconteça através de aceleração por hardware,
	  caso seja compatível com o seu sistema operacional.

.. _mame-commandline-video-none:

	* **none**

	  Não exibe janelas e nem mostra nada na tela. É principalmente
	  utilizado para realizar testes de performance (*benchmarks*)
	  usando apenas a CPU.

**No Windows:**

.. _mame-commandline-video-gdi:

	* **gdi**

	  Diz ao MAME para renderizar o vídeo usando funções gráficas mais
	  antigas do Windows.
	  Em termos de performance é a opção mais lenta porém a mais
	  compatível com as versões os sistemas Windows mais antigos.

.. _mame-commandline-video-d3d:

	* **d3d**

	  Diz ao MAME para renderizar a tela com o **Direct3D**.
	  Isso produz uma saída com uma melhor qualidade se comparada com a
	  opção que o **gdi** assim como permite opções adicionais de
	  renderização da tela e aceleração gráfica via hardware.

	  É recomendável ter uma placa de vídeo mediana (2002+)
	  ou uma placa de vídeo Intel embutida modelo *HD3000* ou superior.

**Em outras plataformas (incluindo o SDL no Windows):**

.. _mame-commandline-video-accel:

	* **accel**

	  Diz ao MAME para, se possível, processar o vídeo usando a
	  aceleração 2D do SDL.

.. _mame-commandline-video-soft:

	* **soft**

	  Faz com que a tela seja renderizada através de software.
	  Por não usar nenhum tipo de aceleração de vídeo, a performance da
	  emulação pode ser penalizada, porém favorecendo uma melhor
	  compatibilidade em qualquer plataforma.

* **Predefinições:**

	No Windows é **d3d**.

	No Mac OS X é **opengl** pois é quase certo que exista uma pilha
	OpenGL compatível.

	O valor predefinido para todos os outros sistemas é **soft**. ::

		mame64 ssf2tu -video bgfx

.. raw:: latex

	\clearpage


.. _mame-commandline-numscreens:

**-numscreens** [<*count*>]

	Diz ao MAME quantas telas devem ser criadas. Para a maioria dos
	sistemas só exite uma, porém alguns sistemas originalmente usavam
	mais de uma (*como as máquinas Darius e máquinas Arcade
	PlayChoice-10 por exemplo*). Cada tela (até 4), possem as suas
	próprias configurações, taxa de proporção de tela, resolução e
	exibição, que podem ser definidas usando as opções abaixo.

	O valor predefinido é **1**. ::

		mame64 darius -numscreens 3
		mame64 pc_cntra -numscreens 2


.. _mame-commandline-window:

**-[no]window** / **-[no]w**

	Inicia a tela do MAME em uma janela em vez da tela inteira.

	O valor predefinido é **Desligado** (**-nowindow**). ::

		mame64 ssf2tu -window


.. _mame-commandline-maximize:

**-[no]maximize** / **-[no]max**

	Controla o tamanho inicial da janela. Caso esta opção seja ativada,
	durante a inicialização do MAME a janela será exibida com o maior
	tamanho possível. Com a opção desligada, a emulação terá início com
	o tamanho aproximado ao tamanho original do sistema, a sua escala
	será em apenas um eixo quando os pixeis não quadrados estiverem em
	uso. Esta opção apenas surte efeito quando a opção **-window** é
	utilizada.

	O valor predefinido é **Ligado** (**-maximize**). ::

		mame64 ssf2tu -window -maximize


.. _mame-commandline-keepaspect:

**-[no]keepaspect** / **-[no]ka**

	Faz com que a proporção de tela seja mantida. Quando essa opção está
	ativa, a taxa de proporção adequada da tela do sistema é aplicada,
	geralmente 4:3 ou 3:4 para monitores CRT dependendo da orientação,
	no entanto muitas outras proporções de tela já foram usadas como 3:2
	(Nintendo Game Boy), 5:4 para algumas workstation assim como vários
	outros.

	Caso a tela que estiver sendo emulada ou ilustração não preencher
	toda a tela por completo, a imagem será centralizada com barras
	pretas adicionadas as laterais conforme a necessidade para ocupar os
	espaços não utilizados, sejam eles em cima ou em baixo assim como
	na esquerda ou na direita.

	Ao desativar essa opção a tela ou ilustração poderá ser esticada
	livremente para preencher os espaços vazios no modo janelado. Em
	tela cheia a imagem ficará distorcida e fora das proporções.

	Quando essa opção estiver ativa no Windows e o MAME estiver em modo
	janelado, a proporção de tela será mantido mesmo que 
	a janela seja redimensionada para diferente tamanhos, caso mantenha
	a tecla **Control** ou **Ctrl** pressionada durante
	redimensionamento da janela, a proporção será mantida.

	O valor predefinido é **Ligado** (**-keepaspect**). ::

		mame64 ssf2tu -ka

	A equipe do MAME, sugere veementemente que se mantenha esta opção
	ativada. Esticando a tela do sistema além da proporção original
	vai causar distorções na aparência do sistema que vai muito além da
	capacidade de reparo dos filtros internos do MAME.

.. raw:: latex

	\clearpage


.. _mame-commandline-unevenstretch:

**-[no]unevenstretch** / **-[no]ues**

	Permite que valores não inteiros possam ser usados para o
	redimensionamento da tela. Isso determina se os pixels que
	formam a imagem serão ou não distorcidos/esticados durante o
	processo de redimensionamento.

	O uso de valores não inteiros geram uma interferência chamada
	**aliasing** nos pixels [#aliasing]_ [#saaliasing]_. Imagine o mapa
	de um jogo feito de linhas retas com 1 pixel de largura, quando
	ocorre o aliasing a linha que originalmente era feita com 1 pixel de
	largura passa a ter 2 pixels ou mais, essa interferência cria pixels
	aonde antes não existiam gerando distorções em **todos os pixels**.
	Abaixo com destaque em vermelho fica fácil visualizar apensar do
	problema afetar toda a imagem.

	.. image:: images/pixel-aliasing.png
		:width: 100%
		:align: center
		:alt: pixel-aliasing

	Atualmente as pessoas sentem a necessidade de preencher toda a tela
	de uma TV 16:9 com gráficos feitos para 4:3 ainda que isso gere
	distorções ao custo da desproporção dos gráficos.

	Este é um assunto bem complexo pois apesar dos pixels do lado
	esquerdo estarem todos com um formato quadrado perfeito (proporção
	1:1), a imagem está fora da proporção pois na época os gráficos não
	foram criados com os pixels no formato de um quadrado perfeito como
	mostra a imagem do lado esquerdo e sim com 1 pixel mais alto.

	Assim, apesar dos pixels estarem distorcidos na imagem da direita a
	proporção dos gráficos está correta! Ao mesmo tempo que apesar dos
	pixels estarem perfeitos do lado esquerdo a proporção do gráfico
	está errada. Consulte :ref:`-aspect <mame-commandline-aspect>` e
	:ref:`-keepaspect <mame-commandline-keepaspect>`

	O valor predefinido é **Ligado** (**-unevenstretch**). ::

		mame64 ssf2tu -nounevenstretch


.. _mame-commandline-unevenstretchx:

**-[no]unevenstretchx** / **-[no]uesx**

	Permite que a relação de aspecto da tela seja desigual e que a tela
	ou janela possa ser preenchida (esticada) apenas na horizontal.

	O valor predefinido é **Ligado** (**-unevenstretchx**). ::

		mame64 ssf2tu -uesx


.. _mame-commandline-unevenstretchy:

**-[no]unevenstretchy** / **-[no]uesy**

	Permite que a relação de aspecto da tela seja desigual e que a tela
	ou janela possa ser preenchida (esticada) apenas na vertical.

	O valor predefinido é **Ligado** (**-unevenstretchy**). ::

		mame64 ssf2tu -uesy


.. _mame-commandline-autostretchxy:

**-[no]autostretchxy** / **-[no]asxy**

	Aplica a opção **-unevenstretchx/y** automaticamente com base na
	orientação nativa da fonte.

	O valor predefinido é **Desligado** (**-noautostretchxy**). ::

		mame64 ssf2tu -asxy


.. _mame-commandline-intoverscan:

**-[no]intoverscan** / **-[no]ios**

	Permite que a imagem passe dos limites da tela (overscan) de alvos
	inteiros e dimensionáveis.

	O valor predefinido é **Desligado** (**-nointoverscan**). ::

		mame64 ssf2tu -ios


.. _mame-commandline-intscalex:

**-[no]intscalex** / **-[no]sx** [<*fator*>]

	Define o fator da escala para o preenchimento e a aproximação (zoom)
	da tela na horizontal **não causa aliasing nos pixels**.

	O valor predefinido é **0.0** (**-nointscalex 0.0**). ::

		mame64 ssf2tu -sx 1.0


.. _mame-commandline-intscaley:

**-[no]intscaley** / **-[no]sy** [<*fator*>]

	Define o fator da escala para o preenchimento e a aproximação (zoom)
	da tela na vertical **não causa aliasing nos pixels**.

	O valor predefinido é **0.0** (**-nointscaley 0.0**). ::

		mame64 ssf2tu -sy 1.0

.. raw:: latex

	\clearpage


.. _mame-commandline-waitvsync:

**-[no]waitvsync**

	Aguarda acabar o período de atualização da tela do monitor do seu
	computador antes de começar a desenhar na tela. Caso esta opção
	esteja desligada, o MAME só irá desenhar na tela quando o quadro
	estiver pronto, mesmo que seja durante o processo de atualização de
	tela. Isso pode causar artefato de *screen tearing* [5]_.

	O efeito "tearing" não é perceptível em todos os sistemas, porém
	algumas pessoas acham o efeito desagradável, algumas mais do que as
	outras.

	Os efeitos colaterais de se ativar a opção ``-waitvsync`` podem
	variar dependendo da combinação usada em diferentes sistemas
	operacionais e drivers de vídeo.

	No **Windows**, ``-waitvsync`` será bloqueado até o próximo
	apagamento de vídeo, permitindo que o MAME desenhe o próximo quadro,
	sincronizando a taxa de quadros da máquina emulada com a taxa de
	quadros nativa do monitor que estiver sendo usado no Windows, apenas
	ative esta opção caso esteja utilizando o modo janelado. Em tela
	inteira esta opção só é necessária caso a opção ``-triplebuffer``
	não remova o indesejado efeito "tearing", neste caso, tente usar as
	duas opções juntas ``-notriplebuffer -waitvsync``. Note que a opção
	``-waitvsync`` não vai funcionar em conjunto com a opção
	``-video gdi``.

	No **macOS**, ``-waitvsync`` não é bloqueado, contudo o quadro
	completamente desenhado será exibido no próximo apagamento de vídeo
	(vblank). Isso quer dizer que caso um sistema emulado tenha uma taxa
	de quadros maior do que a do seu sistema (ou do seu monitor), haverá
	uma queda periódica na velocidade dos quadros de vídeo emulados
	resultando em pequenos travamentos durante as cenas com movimentos.

	O valor predefinido é **Desligado** (**-nowaitvsync**). ::

		mame64 ssf2tu -waitvsync

	O **MAME SDL** funcionará com essa opção em modo janelado caso haja
	compatibilidade com o seu sistema operacional, da sua placa de vídeo
	e respectivos drivers.

	Rode o **MAME SDL** com a opção ``-video opengl`` para aumentar as
	suas chances de sucesso.


.. _mame-commandline-syncrefresh:

**-[no]syncrefresh**

	Ativa o controle de velocidade da taxa de atualização do seu
	monitor. Isso significa que a taxa de atualização usada pelo sistema
	é ignorada, porém, o código responsável pelo som tentará manter o
	sincronismo com a taxa de atualização usada pelo sistema, assim
	haverá problemas com o som.

	Esta opção foi pensada naqueles que modificaram as configurações da
	sua placa de vídeo, combinando uma opção a mais com as de
	atualização da tela. Esta opção não funciona com a opção
	``-video gdi``.

	O valor predefinido é **Desligado** (**-nosyncrefresh**). ::

		mame64 mk -syncrefresh

.. raw:: latex

	\clearpage


.. _mame-commandline-prescale:

**-prescale** [<*fator*>]

	Controla a proporcionalidade de redimensionamento da grandeza do
	vídeo antes da aplicação de filtros ou shaders. No ajuste mínimo
	a tela é renderizada no seu tamanho original antes de ser
	dimensionada. Com valores maiores a tela é expandida pelo fator
	definido em [<*fator*>]. Isso gera imagens menos borradas com a
	opção ``-video d3d`` ao custo da perda de alguma performance.

	Os valores válidos são **1** (mínimo) e **8** (máximo).

	O valor predefinido é **1**.

	Funciona com todos os modos de vídeo no Windows (bgfx, d3d, etc) e
	nas outras plataformas **APENAS** aquelas que forem compatíveis com
	o OpenGL. ::

		mame64 ssf2tu -video d3d -prescale 3


.. _mame-commandline-filter:

**-[no]filter** / **-[no]d3dfilter** / **-[no]flt**

	Ativa o filtro bilinear, aplica um leve efeito de embaçamento ou
	suavização à tela, amenizando um pouco o serrilhado nos contornos
	gráficos e suavizando a tela do sistema.

	Quando desabilitado terá uma imagem pura e com aparência mais
	serrilhada, esta opção também ocasiona artefatos na tela em caso de
	redimensionamento. Caso não goste da aparência filtrada e amaciada
	da imagem, tente incrementar o valor da opção ``-prescale`` ao em
	vez de desabilitar todos os filtros. Veja também
	:ref:`-gl_glsl_filter <mame-commandline-glglslfilter>`.

	O valor predefinido é **Ligado** (**-filter**). ::

		mame64 ssf2tu -nofilter

	No Windows funciona com todos os modos de vídeo (bgfx, d3d, etc),
	nas outras plataformas **APENAS** aquelas compatíveis com OpenGL.


.. _mame-commandline-noburnin:

**-[no]burnin**

	Monitora o brilho da tela durante a reprodução e no final da
	emulação, gera um PNG que pode ser usado para simular um efeito
	burn-in [3]_ na tela. O PNG é criado de tal maneira que as
	áreas menos usadas da tela ficam totalmente brancas (pois as áreas a
	serem marcadas são escuras, todo o resto da tela deverá ficar um
	pouco mais iluminada).

	A intenção é que este PNG possa ser carregado através de um arquivo
	de ilustração usando um valor alpha pequeno como valores entre
	**0.1** e **0.2** que se misturam bem com o resto da tela.
	Os arquivos PNG gerados são gravados no diretório snap dentro do
	``systemname/burnin-<nome.da.tela>.png``.

	O valor predefinido é **Desligado** (**-noburnin**). ::

		mame64 neogeo -burnin

.. raw:: latex

	\clearpage


Opções para a configuração da tela inteira
------------------------------------------

.. _mame-commandline-switchres:

**-[no]switchres**

	Permite ou não a comutação ou a troca da resolução durante a
	emulação. Esta opção é necessária para as opções ``-resolution``
	evitando a troca das resoluções enquanto estiver no modo de tela
	inteira.

	Em placas de vídeo modernas, há poucas razões para alternar as
	resoluções, a menos que esteja tentando alcançar as resoluções
	"exatas" dos pixels dos sistemas originais, o que exige ajustes
	significativos.

	Útil também em monitores de LCD, uma vez que eles rodam com uma
	resolução fixa e as comutações da resolução algumas vezes são
	exageradas.

	Essa opção não funciona com a opção ``-video gdi``.

	O valor predefinido é **Desligado** (**-noswitchres**). ::

		mame64 kof97 -switchres -resolution 978x720

.. raw:: latex

	\clearpage


Opções de vídeo para uso com janelas individuais
------------------------------------------------

.. _mame-commandline-screen:

**-screen[0-3]** <*display*>

	Define qual monitor físico do sistema usar em cada janela.
	Para usar várias janelas, o valor da opção
	:ref:`-numscreens <mame-commandline-numscreens>` deverá ter sido
	aumentado.
	O nome de cada exibição em seu sistema pode ser determinado
	executando o MAME com a opção :ref:`-verbose
	<mame-commandline-verbose>`.
	Os nomes de exibição geralmente estão no formato: *\\\\.\DISPLAYn*,
	onde **n** é um número do monitor conectado.

	O valor predefinido para essas opções é **auto**.
	O que significa que a primeira janela é colocada na primeira
	exibição, a segunda janela na segunda exibição e assim por
	diante. ::

		mame64 pc_cntra -numscreens 2 -screen0 \\.\DISPLAY1 -screen1 \\.\DISPLAY2
		mame64 darius -numscreens 3 -screen0 \\.\DISPLAY1 -screen1 \\.\DISPLAY3 -screen2 \\.\DISPLAY2

	Os parâmetros ``-screen0``, ``-screen1``, ``-screen2``, ``-screen3``
	aplicam-se as janelas definidas. O parâmetro **screen** se aplica
	a todas as janelas.
	As opções definidas da janela substituem os valores da opções de
	todas as janelas.

.. note:: Utilize a opção **-verbose** para exibir quais os displays
          estão disponíveis no seu sistema e qual a sua resolução quando
          estiverem conectados.
.. note:: A partir de agora a opção de várias telas simultâneas podem
          não funcionar corretamente em alguns computadores Mac.


.. _mame-commandline-aspect:

**-aspect[0-3]** <*largura:altura*> / **-screen_aspect** <*num:den*>


	Define a proporção física do monitor para cada janela. Para usar
	várias janelas, é necessário aumentar o valor da opção
	**-numscreens**.
	A proporção física pode ser determinada medindo a largura e a altura
	da imagem da tela visível e definindo-as separadas por dois pontos.

		O valor predefinido para essas opções é **auto**.

	Significa que o MAME assume que a proporção de tela é proporcional
	ao número de pixels no modo de vídeo da área de trabalho para cada
	monitor.

	O parâmetro ``-aspect0``, ``-aspect1``, ``-aspect2`` e ``-aspect3``
	se aplica a todas as janelas definidas. O parâmetro ``-aspect`` se
	aplica a todas as janelas.
	As opções definidas da janela substituem os valores da opções de
	todas as janelas. Consulte :ref:`-unevenstretch
	<mame-commandline-unevenstretch>`. ::

		mame64 contra -aspect 16:9
		mame64 pc_cntra -numscreens 2 -aspect0 16:9 -aspect1 5:4


.. _mame-commandline-resolution:

**-resolution[0-3]** <*largura_x_altura[@taxa de atualização]*> / **-r[0-3]** <*largura_x_altura[@taxa de atualização]*>

	Define a resolução exata a ser exibida. No modo de tela cheia o MAME
	tentará usar a resolução solicitada. A largura e a altura são
	obrigatórias, a taxa de atualização é opcional.

	Caso seja omitido ou configurado para **0**, o MAME determinará o
	modo automaticamente. Por exemplo, a opção ``-resolution 640x480``
	forçará a resolução de 640x480 porém o MAME escolherá a taxa de
	atualização por conta própria.

	Da mesma forma que ``-resolution 0x0@60`` obrigará que a taxa de
	atualização seja de 60 Hz, mas permite que o MAME escolha a
	resolução. O comando também funciona com "*auto*" e é equivalente a
	*0x0@0*.

	No modo janelado essa resolução é usada para determinar o tamanho
	máximo para a janela. Essa opção também requer que seja usada a
	opção :ref:`-switchres <mame-commandline-switchres>` para ativar a
	comutação de resolução em conjunto com a opção **-video d3d**.

		O valor predefinido para essas opções é **auto**.

	O parâmetro ``-resolution0``, ``-resolution1``, ``-resolution2`` e
	``-resolution3`` se aplica a todas as janelas definidas.
	O parâmetro ``-resolution`` se aplica a todas as janelas.
	As opções específicas da janela substituem os valores da opções de
	todas as janelas. ::

		mame64 pc_cntra -numscreens 2 -resolution0 768x720 -resolution1 640x480


.. _mame-commandline-view:

**-view[0-3]** <*nome*>

	Define a configuração da visualização inicial de cada janela.
	Note que o nome de visualização [<*nome*>] não precisa
	ser uma combinação exata, em vez disso, será selecionado a primeira
	exibição cujo nome corresponde a todos os caracteres especificados
	por [<*nome*>].
	Por exemplo, ``-view native`` representa uma visualização
	"Native (15:14)", ainda que não seja uma correspondência perfeita.
	O campo [<*nome*>] também funciona com a opção ``auto`` fazendo com
	que um nome seja automaticamente escolhido.

		O valor predefinido para estas opções é **auto**.

	Os parâmetros ``-view0``, ``-view1``, ``-view2`` e ``-view3`` se
	aplicam a todas as janelas especificadas. O parâmetro ``-view`` se
	aplica a todas as janelas.
	As opções definidas para a janela substituem os valores da opções de
	todas as janelas. ::

		mame64 ssf2tu -view native

.. raw:: latex

	\clearpage


Opções para uso com as ilustrações
----------------------------------

.. _mame-commandline-noartworkcrop:

**-[no]artwork_crop** / **-[no]artcrop**

	Ativa o recorte de arte somente na área da tela do sistema.
	Significa que sistemas que tenham telas com orientação horizontal
	rodando em tela cheia possam exibir a sua ilustração do lado
	esquerdo e direito da tela.

	Essa opção também está disponível através da interface gráfica na
	parte das opções de vídeo.

	O valor predefinido é **Desligado** (**-noartwork_crop**). ::

		mame64 ssf2tu -artwork_crop

.. _mame-commandline-fallbackartwork:

**-fallback_artwork**

	Define uma ilustração alternativa caso nenhuma ilustração interna ou
	externa do layout seja definida. Caso a ilustração para o sistema
	esteja presente ou o seu layout esteja incluso no driver do sistema,
	então este terá precedência. ::

		mame64 coco -fallback_artwork suprmrio

.. _mame-commandline-overrideartwork:

**-override_artwork**

	Define uma ilustração para substituir a ilustração interna ou a
	ilustração externa do layout. ::

		mame64 galaga -override_artwork puckman

.. raw:: latex

	\clearpage

Opções para os ajustes de imagem da tela
----------------------------------------

.. _mame-commandline-brightness:

**-brightness** [<*valor*>]

	Controla o valor de brilho ou nível de preto da tela.
	Essa opção não afeta a arte ou outras partes da tela. Usando a
	interface interna do MAME, é possível configurar o brilho para cada
	tela do sistema e para todos os sistemas individualmente.
	Ao selecionar valores menores (não menor que **0.1**) produzirá uma
	tela mais escura, enquanto valores maiores até **2.0** produzirão
	uma tela mais clara.

	O valor predefinido é **1.0**. ::

		mame64 ssf2tu -brightness 0.5

.. _mame-commandline-contrast:

**-contrast** [<*valor*>]

	Controla o contraste da tela ou os nível de branco da tela.
	Essa opção não afeta a arte ou outras partes da tela. Usando a
	interface interna do MAME, é possível configurar o brilho para cada
	tela do sistema e para todos os sistemas individualmente.
	Essa opção define o valor inicial de todas as telas visíveis de
	todos os sistemas.
	Selecionando valores (não menor que **0.1**) produzirá uma tela mais
	apagada, enquanto valores maiores até **2.0** produzirão uma tela
	mais saturada.

	O valor predefinido é **1.0**. ::

		mame64 ssf2tu -contrast 0.5

.. _mame-commandline-gamma:

**-gamma** [<*valor*>]

	Controle de gamma, ajusta a escala de luminância da tela. Essa opção
	não afeta a arte ou outras partes da tela. Usando a interface
	interna do MAME, é possível configurar o gamma para cada tela do
	sistema e para todos os sistemas individualmente. Essa opção define
	o valor inicial de todas as telas visíveis de todos os sistemas.
	Essa configuração oferece um ajuste de luminância linear de preto
	para o branco. Ao selecionar valores menores (até **0.1**)
	trará a luminância mais para o preto, enquanto valores maiores
	(até **3.0**) empurrarão essa luminância para o branco.

	O valor predefinido é **1.0**. ::

		mame64 ssf2tu -gamma 0.8

.. _mame-commandline-pausebrightness:

**-pause_brightness** [<*valor*>]

	Faz o controle do nível de brilho durante a pausa.

	O valor predefinido é **0.65**. ::

		mame64 ssf2tu -pause_brightness 0.33

.. raw:: latex

	\clearpage


.. _mame-commandline-effect:

**-effect** [<*nome do arquivo*>]

	Define um único arquivo ``.png`` que será usado como sobreposição na
	tela de qualquer sistema. Presume-se que o aquivo ``.png`` esteja em
	um dos diretórios raiz do :ref:`artpath <mame-commandline-artpath>`.

	Ambas as combinações horizontais e verticais dentro do arquivo
	``.png`` é repetido para cobrir toda a tela (mas nenhuma parte da
	arte externa). Ela é renderizada na resolução nativa do sistema.

	É possível adicionar o efeito de forma automática para máquinas com
	orientação horizontal e vertical, basta criar os arquivos
	**vertical.ini** e **horizont.ini** dentro do diretório **ini**.
	No arquivo ``vertical.ini`` adicione a linha abaixo e salve ao
	terminar: ::

		effect          RealScanlinesV

	Para o arquivo ``horizont.ini`` adicione a linha abaixo e salve ao
	terminar: ::

		effect          RealScanlinesH

	Consulte :ref:`Opções para a configuração
	<mame-commandline-noreadconfig>` para saber quais os arquivos
	``.ini`` estão disponíveis.

	Para os modos de vídeo ``-video gdi`` e ``-video d3d`` significa que
	um pixel dentro do ``.png`` será mapeado para um pixel da sua tela.
	Os valores RGB de cada pixel dentro do ``.png`` são multiplicados
	com os valores de RGB da tela de destino.

	O valor predefinido é **none** ou nenhum efeito. ::

		Para efeito Horizontal
		mame64 ssf2tu -effect RealScanlinesH
		
		Para efeito Vertical
		mame64 bgaregga -effect RealScanlinesV

	.. image:: images/effect-scanlines.png
		:width: 100%
		:align: center
		:alt: efeito-scanline

	Claro que os exemplos acima são apenas exemplos, existem diferentes
	outros tipos espalhados pela internet e também é uma questão de
	gosto, há quem prefira os **shaders** que dão uma aparência muito
	convincente de um monitor CRT. Para mais informações sobre estes
	efeitos consulte :ref:`BGFX <advanced-bgfx>`,
	:ref:`HLSL <advanced-hlsl>`, :ref:`GLSL <advanced-glsl>` e a opção
	:ref:`-glsl_shader_mame <mame-commandline-glslshadermame>`.

.. raw:: latex

	\clearpage

Opções para máquinas que usem gráficos vetoriais
------------------------------------------------

.. _mame-commandline-beamwidthmin:

**-beam_width_min** [<*largura*>]

	Define a espessura mínima do feixe do vetor. ::

		mame64 asteroid -beam_width_min 0.1


.. _mame-commandline-beamwidthmax:

**-beam_width_max** [<*largura*>]

	Define a espessura máxima do feixe do vetor. ::

		mame64 asteroid -beam_width_max 2


.. _mame-commandline-beamintensityweight:

**-beam_intensity_weight** [<*altura*>]

	Define a intensidade do feixe do vetor. ::

		mame64 asteroid -beam_intensity_weight 0.5

.. _mame-commandline-flicker:

**-flicker** [<*valor*>]

	Simula um vetor de efeito de *tremulação* ou oscilação da tela
	semelhante aos monitores desregulados usados nos jogos vetoriais.
	Essa opção espera um valor flutuante (float) no intervalo
	entre **0.00** e **100.00** (**0** = nenhum e **100** = máximo).

	O valor predefinido é **0**. ::

		mame64 asteroid -flicker 0.15

.. raw:: latex

	\clearpage

Opções para a depuração de vídeo OpenGL
---------------------------------------

Essas são as opções compatíveis com ``-video opengl``.
Caso note artefatos renderizados na tela, poderá ser solicitado
pelos desenvolvedores que você tente alterá-los, porém normalmente estes
valores devem ser mantidos com seus valores originais para que se
obtenha a melhor performance possível.

.. _mame-commandline-glforcepow2texture:

**-[no]gl_forcepow2texture**

	Sempre utilize a potência de 2 para o tamanhos das texturas.

		O valor predefinido é **Desligado**
		(**-nogl_forcepow2texture**).

.. _mame-commandline-glnotexturerect:

**-[no]gl_notexturerect**

	Não use o *OpenGL GL_ARB_texture_rectangle*

		O valor predefinido é **Ligado** (**-gl_notexturerect**).

.. _mame-commandline-glvbo:

**-[no]gl_vbo**

	Ative o *OpenGL VBO* (Vertex Buffer Objects) caso esteja disponível.

		O valor predefinido é **Ligado** (**-gl_vbo**).

.. _mame-commandline-glpbo:

**-[no]gl_pbo**

	Ativar o *OpenGL PBO* (Pixel Buffer Objects) caso esteja disponível.

		O valor predefinido é **Ligado** (**-gl_pbo**).

.. raw:: latex

	\clearpage

Opções de vídeo OpenGL GLSL
---------------------------

.. _mame-commandline-glglsl:

**-[no]gl_glsl**

	Ativar o *OpenGL GLSL* caso esteja disponível.

	O valor predefinido é **Desligado** (**-nogl_glsl**). ::

		mame64 galaxian -gl_glsl


.. _mame-commandline-glglslfilter:

**-gl_glsl_filter** [<*valor*>]

	Habilita a interpolação da imagem **OpenGL GLSL**, os valores
	válidos [6]_ são:

	* **0**, Simples: Método de interpolação rápida e menos precisa que
	  deixa os pixels de forma serrilhada pois utiliza a técnica de
	  interpolação do
	  `vizinho mais próximo <https://pt.wikipedia.org/wiki/Interpolação_por_vizinho_mais_próximo>`_.
	* **1**, Bilinear: Método de interpolação lenta e de qualidade
	  mediana, suaviza a transição entre as cores dos pixels deixando a
	  imagem mais suavizada como um todo. Veja também
	  :ref:`-filter <mame-commandline-filter>`.
	* **2**, Bicúbico: Método de interpolação lenta e mais precisa,
	  suaviza a transição entre as cores dos pixels próximos gerando uma
	  gradação mais suave. Também suaviza a imagem porém nem tanto como
	  o método bilinear.

	O valor predefinido é **1** (**-gl_glsl_filter 1**). ::

		mame64 ssf2tu -gl_glsl -gl_glsl_filter 0

.. _mame-commandline-glslshadermame:

|	**-glsl_shader_mame0**
|	**-glsl_shader_mame1**
|	...
|	**-glsl_shader_mame9**

	Define um efeito shader personalizado do OpenGL GLSL do MAME no
	slot fornecido entre (*0-9*). É possível aplicar um para a cada
	slot. O MAME não incluí nenhum shader por alguns podem ser
	encontrados online, como no
	`mameau <https://www.mameau.com/linux/mame-glsl-shaders-setup/>`_ e
	no `mameworld <https://www.mameworld.info/ubbthreads/showflat.php?Cat=&Number=368803&page=&view=&sb=5&o=&vc=1>`_. ::

		mame64 mpatrol -gl_glsl -gl_glsl_filter 0 -glsl_shader_mame0 glsl/osd/CRT-geom -resolution 992x756


.. _mame-commandline-glslshaderscreen:

| **-glsl_shader_screen0**
| **-glsl_shader_screen1**
| ...
| **-glsl_shader_screen9**

	Define um efeito shader personalizado do OpenGL GLSL do MAME que for
	escalada na tela para ser processada através da sua placa de vídeo
	no slot fornecido entre (0-9). Como no exemplo anterior, o MAME não
	incluí nenhum shader. ::

		mame64 suprmrio -gl_glsl -glsl_shader_screen0 gaussx -glsl_shader_screen1 gaussy -glsl_shader_screen2 CRT-geom-halation


.. _mame-commandline-glglslvidattr:

**-gl_glsl_vid_attr**

	Ative o manuseio do GLSL em OpenGL de brilho e contraste.
	Melhor desempenho do sistema RGB.

	O valor predefinido é **Ligado** (**-gl_glsl_vid_attr**). ::

		mame64 pacman -gl_glsl -gl_glsl_vid_attr off

.. raw:: latex

	\clearpage

Opções para a configuração do áudio
-----------------------------------

.. _mame-commandline-samplerate:

**-samplerate** [<*valor*>] / **-sr** [<*valor*>]

	Define a taxa de amostragem do áudio. Valores menores como 11025 por
	exemplo, reduzem a qualidade da áudio porém a performance da
	emulação melhora.
	Valores maiores que 48000, aumentam a qualidade do áudio ao custo da
	perda de performance da emulação.

	O valor predefinido é **48000** (**-samplerate 48000**). ::

		mame64 ssf2tu -samplerate 44100

.. _mame-commandline-nosamples:

**-[no]samples**

	Usar arquivos de amostras caso estejam disponíveis. Esses arquivos
	são gravações de efeitos de áudio usados por algumas máquinas.

	O valor predefinido é **Ligado** (**-samples**). ::

		mame64 qbert -nosamples

.. _mame-commandline-volume:

**-volume** / **-vol** [<*valor*>]

	Define o volume inicial. Pode ser alterado posteriormente usando
	a interface do usuário.
	O valor do volume está definido em decibéis (dB): Por exemplo,
	``-volume -12`` começará com uma atenuação de **-12 dB** no volume
	do áudio.

	O valor predefinido é **0** (**-volume 0**). ::

		mame64 ssf2tu -volume -30

.. _mame-commandline-sound:

**-sound** <``auto`` | ``dsound`` | ``sdl`` | ``coreaudio`` | ``xaudio2`` | ``portaudio`` | ``none``>

	Define qual o tipo de saída de áudio usar, Ao usar **none** desativa
	o áudio completamente porém o hardware de áudio continua sendo
	emulado. Abaixo as opções disponíveis para cada sistema operacional.

	As versões especiais como o **SDLMAME** para Windows, pode usar a
	opção **sdl** e ter o **portaudio** desabilitado. O binário oficial
	do MAME para Windows não é compilado com SDL, sendo necessário
	compilar uma versão compatível para que a opção ``sdl`` funcione.

	O valor predefinido é **dsound** no Windows, no Mac é
	**coreaudio** nas outras plataformas é **sdl**.

	No Windows e no Linux a opção **portaudio** provavelmente dará uma
	menor latência possível, enquanto no Mac a opção **coreaudio**
	oferecerá os melhores resultados. ::

		mame64 sf2tu -sound portaudio

.. tabularcolumns:: |L|C|C|C|C|C|

.. list-table:: Opções disponíveis para cada versão separado por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - auto
      - dsound
      - xaudio2
      - portaudio
      - none
    * - **macOS**
      - auto
      - coreaudio
      - sdl
      - portaudio
      - none
    * - **SDL**
      - auto
      - portaudio
      - sdl
      - none
      - 

.. raw:: latex

	\clearpage

.. _mame-commandline-audiolatency:

**-audio_latency** [<*valor*>]

	Nesta opção, latência significa o tempo que o dispositivo de áudio
	demora para responder a um comando. Essa opção ajusta a quantidade
	dessa latência incorporada ao fluxo de dados de áudio.

	O comportamento exato depende do módulo da saída de áudio
	selecionada.
	Os valores menores oferecem um menor atraso no áudio enquanto exige
	um desempenho maior do seu sistema. Valores maiores incrementam o
	atraso do áudio porém ajudam a evitar o esvaziamento da memória
	intermediária (buffer) e as interrupções do áudio. ::

		mame64 galaga -audio_latency 1

.. note::

	| Para PortAudio, consulte :ref:`-pa_latency <mame-commandline-pa_latency>`.
	| O XAudio2 calcula a latência do áudio com passos de 10ms.
	| O DSound calcula a latência do áudio com passos de 10ms.
	| O CoreAudio calcula a latência do áudio com passos de 25ms.
	| O SDL calcula a latência do áudio com passos de Xms.

.. raw:: latex

	\clearpage

.. _mame-commandline-pa_api:

**-pa_api** [<*interface*>]

	PortAudio é um novo recurso adicionado na versão `0.182
	<https://www.mamedev.org/?p=436>`_ do MAME, o PortAudio é um API,
	"*Application Programming Interface*" ou em uma tradução livre
	"*Interface de Programação para Aplicações*". O API funciona como
	uma ponte conectando aplicações ao hardware de forma direta. Essa
	integração permite uma menor latência por haver uma redução no fluxo
	de dados e por estes dados de áudio serem direcionados diretamente
	ao dispositivo áudio, a performance é otimizada de maneira geral
	pois o que se salva em processamento no áudio pode ser aproveitado
	pelo MAME em outros setores da emulação.

	Apesar do PortAudio ser o que há de mais moderno em comparação com o
	DirectSound ou OpenGL Audio e trazer muitos benefícios, há um ponto
	negativo, o PortAudio faz o uso exclusivo do dispositivo de áudio.
	Isso significa que não será possível por exemplo, escutar música ou
	qualquer outra coisa enquanto o MAME estiver rodando com PortAudio.

	No Windows Vista ou mais recente nós temos essas interfaces:

	* **MME**: É um acrônimo para *Multimedia Extension* criada pela
	  Microsoft para um sistema operacional pouco conhecido na época
	  chamado "*Windows with MultiMedia Extensions 1.0*" com base no
	  Windows 3.0, é um dos primeiros API para comunicação direta com a
	  placa de áudio. Essa interface já é obsoleta porém ainda muito
	  usada por questões de compatibilidade.

	* **Windows DirectSound**: É um outro API introduzido pela Microsoft
	  no Windows 95 que adicionou uma camada de software entre a
	  aplicação e o dispositivo de som. Com ele uma placa de som poderia
	  ter dois canais ou mais, efeitos de som 3D foi uma novidade na
	  época, aceleração de áudio via hardware, a placa de som poderia
	  ser compartilhada entre diferentes aplicativos. Essa interface já
	  é obsoleta porém ainda muito usada por questões de
	  compatibilidade.

	* **Windows WASAPI**: É um acrônimo para "*Windows Audio Session
	  API*" ou em uma tradução livre, "*API de Seção de Áudio do
	  Windows*". Foi introduzido no Windows Vista, a grande vantagem do
	  WASAPI é poder enviar os fluxos de dados de áudio direto para o
	  dispositivo de áudio sem ter que passar por nenhum tipo de CODEC.
	  Outra característica do WASAPI é ter o uso exclusivo do
	  dispositivo de áudio melhorando a latência assim como a qualidade
	  do áudio.

	* **Windows WDM-KS**: É um acrônimo para "*Windows Driver Model*"
	  também criado pela Microsoft e introduzido no Windows 98 e Windows
	  2000. O KS vem de "*Kernel Streaming*" uma maneira ainda mais
	  rápida de acessar o dispositivo de áudio de forma direta através
	  do cerne (kernel) do Windows. Apesar de também fazer uso exclusivo
	  do dispositivo de áudio essa é a interface mais problemática pois
	  ela é muito dependente da qualidade dos drivers usados, gera
	  problemas com a hibernação do Windows quando há problemas com os
	  drivers, a melhor opção é ficar com o Windows WASAPI.

	Para escolher qual interface usar, inicie o mame como mostra o
	exemplo abaixo: ::

		mame64 -verbose -sound portaudio

	No Windows dentre as várias informações que aparecerão no terminal
	as mais relevantes para nós serão estas: ::

		PortAudio: API Windows WASAPI has 10 devices
		PortAudio: Windows WASAPI: "6 - SONY TV  *01 (AMD High Definition Audio Device)" (default)
		PortAudio: Windows WASAPI: "Alto-falantes (ASUS Xonar Essence STX Audio Device)"
		PortAudio: Windows WASAPI: "S/PDIF Pass-through Device (ASUS Xonar Essence STX Audio Device)"
		PortAudio: Windows WASAPI: "Alto-falantes (2- Blackmagic Audio)"
		PortAudio: Windows WASAPI: "Aux (ASUS Xonar Essence STX Audio Device)"
		PortAudio: Windows WASAPI: "Entrada (2- Blackmagic Audio)"
		PortAudio: Windows WASAPI: "Entrada (ASUS Xonar Essence STX Audio Device)"
		PortAudio: Windows WASAPI: "Wave (ASUS Xonar Essence STX Audio Device)"
		PortAudio: Windows WASAPI: "Stereo Mix (ASUS Xonar Essence STX Audio Device)"
		PortAudio: Windows WASAPI: "Microfone (ASUS Xonar Essence STX Audio Device)"

		PortAudio: API Windows WDM-KS has 12 devices
		PortAudio: Windows WDM-KS: "Output (AMD HD Audio HDMI out #5)" (default)
		PortAudio: Windows WDM-KS: "Input (ASUS Xonar Essence STX Audio)"
		PortAudio: Windows WDM-KS: "Entrada (ASUS Xonar Essence STX Audio)"
		PortAudio: Windows WDM-KS: "Aux (ASUS Xonar Essence STX Audio)"
		PortAudio: Windows WDM-KS: "Microfone (ASUS Xonar Essence STX Audio)"
		PortAudio: Windows WDM-KS: "Speakers (ASUS Xonar Essence STX Audio)"
		PortAudio: Windows WDM-KS: "SPDIF Out (ASUS Xonar Essence STX Digital)"
		PortAudio: Windows WDM-KS: "Wave (ASUS Xonar Essence STX Audio Wave In)"
		PortAudio: Windows WDM-KS: "Input (Blackmagic WDM Capture)"
		PortAudio: Windows WDM-KS: "Output ()"
		PortAudio: Windows WDM-KS: "Speakers ()"
		PortAudio: Windows WDM-KS: "Entrada ()"

	No exemplo acima estão listados dois exemplos de interface,
	**Windows WASAPI** e **Windows WDM-KS**. O uso de qualquer uma
	destas interfaces depende do driver da sua placa de som. Para
	definir a interface use o nome dela entre aspas
	``-pa_api "Windows WASAPI"`` ou ``-pa_api "Windows WDM-KS"``.

	Já no Linux nós temos uma lista um pouco diferente ainda que
	estejamos usando o mesmo hardware acima: ::

		PortAudio: API ALSA has 15 devices
		PortAudio: ALSA: "Xonar STX: Multichannel (hw:0,0)"
		PortAudio: ALSA: "Xonar STX: Digital (hw:0,1)"
		PortAudio: ALSA: "HDA ATI HDMI: 0 (hw:1,3)"
		PortAudio: ALSA: "HDA ATI HDMI: 1 (hw:1,7)"
		PortAudio: ALSA: "HDA ATI HDMI: 2 (hw:1,8)"
		PortAudio: ALSA: "HDA ATI HDMI: 3 (hw:1,9)"
		PortAudio: ALSA: "HDA ATI HDMI: 4 (hw:1,10)"
		PortAudio: ALSA: "HDA ATI HDMI: 5 (hw:1,11)"
		PortAudio: ALSA: "sysdefault"
		PortAudio: ALSA: "front"
		PortAudio: ALSA: "iec958"
		PortAudio: ALSA: "spdif"
		PortAudio: ALSA: "pulse"
		PortAudio: ALSA: "dmix"
		PortAudio: ALSA: "default" (default)
		PortAudio: API OSS has 0 devices
		PortAudio: Unable to find specified API or device or none set, reverting to default
		PortAudio: Using device "default" on API "ALSA"
		PortAudio: Sample rate is 48000 Hz, device output latency is 8.67 ms
		PortAudio: Allowed additional buffering latency is 30.00 ms/1440 frames

	O valor predefinido é **NULO** (Nenhuma interface PortAudio).

.. raw:: latex

	\clearpage

.. _mame-commandline-pa_device:

**-pa_device** [<*dispositivo*>]

	Define qual o dispositivo de áudio usar, assim como mostrado em
	:ref:`-pa_api <mame-commandline-pa_api>`, escolha um dos
	dispositivos listados. O nome do dispositivo fica do lado direito da
	lista e entre aspas. Usando o exemplo para o Windows nós usaremos: ::

		mame64 -verbose -sound portaudio -pa_api "Windows WASAPI" -pa_device "6 - SONY TV  *01 (AMD High Definition Audio Device)"

	Já para Linux o comando também não é muito diferente para o mesmo
	dispositivo: ::

		./mame64 -verbose -sound portaudio -pa_api ALSA -pa_device "HDA ATI HDMI: 0 (hw:1,3)"

	Como resultado o MAME deverá exibir a mensagem abaixo mostrando que
	tanto a interface quanto o dispositivo foram aceitos: ::

		PortAudio: Using device "6 - SONY TV  *01 (AMD High Definition Audio Device)" on API "Windows WASAPI"

	E aqui o mesmo para Linux: ::

		PortAudio: Using device "HDA ATI HDMI: 0 (hw:1,3)" on API "ALSA"
		PortAudio: Sample rate is 48000 Hz, device output latency is 8.00 ms

	Caso nenhum seja definido o MAME escolherá o dispositivo padrão ou
	que estiver disponível.

	O valor predefinido é **NULO** (Nenhuma dispositivo PortAudio).

.. _mame-commandline-pa_latency:

**-pa_latency** [<*segundos*>]

	Escolha o tamanho em segundos da memória intermediária para a saída
	do PortAudio. Números menores tem um menor atraso porém aumenta os
	cortes no som. Os números em pontos decimais são compatíveis. Tente
	começar com valores como **0.20** aumentando ou reduzindo o valor
	até encontrar o valor correto que funcione melhor com o seu hardware
	e o seu Sistema Operacional.

	O valor predefinido é **0**. ::

		mame64 -verbose -sound portaudio -pa_api "Windows WASAPI" -pa_device "6 - SONY TV  *01 (AMD High Definition Audio Device)" -pa_latency 0.20

.. raw:: latex

	\clearpage

Opções para as configurações de diferentes entradas
---------------------------------------------------

.. _mame-commandline-nocoinlockout:

**-[no]coin_lockout** / **-[no]coinlock**

	Permite a simulação do recurso "bloqueio de ficha" implementado em
	vários PCBs de jogos de arcade. Cabia ao operador saber se as saídas
	de bloqueio da moeda estavam realmente conectadas aos mecanismos das
	moedas. Se esse recurso estiver ativado, as tentativas de inserir
	uma moeda enquanto o bloqueio estiver ativo falharão e exibirão uma
	mensagem na tela (no modo de depuração). Caso esta função esteja
	desativada, o sinal de bloqueio da moeda será ignorado.

	O valor predefinido é **Ligado** (**-coin_lockout**). ::

		mame64 ssf2tu -coin_lockout

.. _mame-commandline-ctrlr:

**-ctrlr** [<*controle*>]

	Permite que arquivos ``.cfg`` seja carregados no diretório definido
	em **ctrlrpath** com as configurações customizadas para controles,
	outras informações que ali estiverem serão ignoradas. Estes arquivos
	são criados durante a configuração dos botões do controle de uma
	máquina, estas configurações são gravadas no diretório **cfg** como
	(nome_da_maquina).cfg. Para mais informações, consulte o capítulo
	:ref:`advanced-tricks-botões-ordem`.

	O valor predefinido é **NULO** (nenhum arquivo de controle). ::

		mame64 ssf2tu -ctrlr 6-botoes


.. _mame-commandline-nomouse:

**-[no]mouse**

	Controla se o MAME faz uso ou não dos controladores do mouse.
	Se estiver ligado, o mouse ficará reservado para uso exclusivo do
	MAME até que a emulação seja pausada ou que a a emulação seja
	encerrada.

	O valor predefinido é **Desligado** (**-nomouse**). ::

		mame64 centiped -mouse


.. _mame-commandline-nojoystick:

**-[no]joystick** / **-[no]joy**

	Controla se o MAME usa ou não os controles do joystick/gamepad.
	Se estiver ligado o MAME perguntará ao *DirectInput* sobre quais
	controles estão conectados atualmente.

	O valor predefinido é **Desligado** (**-nojoystick**). ::

		mame64 mappy -joystick


.. _mame-commandline-nolightgun:

**-[no]lightgun** / **-[no]gun**

	Controla se o MAME usa ou não os controles da arma de luz
	(lightgun). Observe que a maioria das armas de luz são mapeadas
	para o mouse, assim, ao se usar ambas as opções ``-lightgun`` e
	``-mouse`` juntos, isso pode poderá trazer resultados inesperados.
	Para mais informações, consulte o capítulo
	:ref:`arma-luz-funcionamento`.

	O valor predefinido é **Desligado** (**-nolightgun**). ::

		mame64 lethalen -lightgun

.. raw:: latex

	\clearpage


.. _mame-commandline-nomultikeyboard:

**-[no]multikeyboard** / **-[no]multikey**

	Determina se o MAME diferencia entre os vários teclados disponíveis.
	Alguns sistemas podem reportar mais de um teclado; por padrão, os
	dados de todos esses teclados são combinados para que pareçam um só.
	Ativando essa opção permitirá que o MAME retorne quais teclas foram
	pressionadas em diferentes teclados de maneira independente.

	O valor predefinido é **Desligado** (**-nomultikeyboard**). ::

		mame64 ssf2tu -multikey


.. _mame-commandline-nomultimouse:

**-[no]multimouse**

	Determina se o MAME diferencia entre os vários mouses disponíveis.
	Alguns sistemas podem reportar mais de um dispositivo de mouse;
	por padrão, os dados de todos esses mouses são combinados para que
	pareçam um só. Ativando esta opção fará com que o MAME relate o
	movimento e o pressionar de botões do mouse em diferentes mouses de
	maneira independente.

	O valor predefinido é **Desligado** (**-nomultimouse**). ::

		mame64 warlords -multimouse


.. _mame-commandline-nosteadykey:

**-[no]steadykey** / **-[no]steady**

	Alguns sistemas exigem que dois ou mais botões sejam pressionados
	exatamente ao mesmo tempo para realizar movimentos ou comandos
	especiais. Devido a limitação do hardware do teclado, pode ser
	difícil ou até mesmo impossível de realizar usando um teclado comum.
	Essa opção seleciona diferentes modos de manuseio o que torna mais
	fácil registrar o pressionamento simultâneo das teclas, porém tem a
	desvantagem de deixar a sua capacidade de resposta mais lenta.

	O valor predefinido é **Desligado** (**-nosteadykey**). ::

		mame64 ssf2tu -steadykey


.. _mame-commandline-uiactive:

**-[no]ui_active**

	Habilita a opção para que a interface do usuário se sobreponha a do
	teclado emulado caso esteja presente.

	O valor predefinido é **Desligado** (**-noui_active**). ::

		mame64 apple2e -ui_active


.. _mame-commandline-nooffscreenreload:

**-[no]offscreen_reload** / **-[no]reload**

	Controla se o MAME trata o segundo botão da arma de luz
	(lightgun) como um sinal para recarregar a arma. Neste caso, o MAME
	reportará a posição da arma como (**0,MAX**) com o gatilho
	pressionado, o que é o equivalente a uma recarga da arma com ela
	apontada para fora da tela. Isso só é necessário para jogos que
	precisam que o usuário atire para fora da tela para recarregar a
	arma e se também a sua arma não tiver essa funcionalidade.

	O valor predefinido é **Desligado** (**-nooffscreen_reload**). ::

		mame64 lethalen -offscreen_reload

.. raw:: latex

	\clearpage


.. _mame-commandline-joystickmap:

**-joystick_map** / **-joymap** [<*mapa*>]

	Controla como mapear os valores analógicos do controle (joystick)
	para o controle (joystick) digital. O MAME aceita qualquer dado
	analógico de todos os controles. Para controles analógicos de
	verdade, os valores precisam ser mapeados para valores de controles
	digitais com 4 direções ou 8 direções.

	Para fazer isso o MAME divide o alcance do valor analógico numa
	grade de 9x9. Então usa a posição do eixo (para eixos X e Y apenas),
	mapeia para essa grade e procura compatibilizar a tradução para um
	mapa de controle conhecido, este parâmetro permite especificar o
	mapa.

	O valor predefinido é **auto** o que significa que um mapa diagonal
	de 4 ou 8 direções, ou um mapa diagonal 4 direções é selecionado
	automaticamente com base na configuração da porta de entrada do
	sistema atual.

	Estes mapas são definidos como uma sequência de números e
	caracteres. Sabendo que a grade é de 9x9, há um total de 81
	caracteres necessários para definir um mapa completo.
	Abaixo está um exemplo de um mapa para um controle (joystick) com
	8 direções:

		+-------------+---------------------------------------------------------------------------------+
		| | 777888999 |                                                                                 |
		| | 777888999 | | Note que os dígitos numéricos correspondem às chaves                          |
		| | 777888999 | | em um teclado numérico. Então o '7' mapeia para cima + esquerda, o '4' mapeia |
		| | 444555666 | | para a esquerda, o '5' mapeia para o neutro, etc. Em adição aos valores       |
		| | 444555666 | | numéricos, é possível especificar o caractere 's',                            |
		| | 444555666 | | que significa 'pegajoso' . Neste caso, o valor do                             |
		| | 111222333 | | mapa é o mesmo que foi da última vez que um valor não pegajoso                |
		| | 111222333 | | foi lido.                                                                     |
		| | 111222333 |                                                                                 |
		+-------------+---------------------------------------------------------------------------------+

	Para definir o mapa para este parâmetro, é possível usar uma cadeia
	destas linhas separadas por um '.' (que indica o fim de uma
	linha), dessa maneira:

	``-joymap 777888999.777888999.777888999.444555666.444555666.444555666.111222333.111222333.111222333``

	No entanto, isso pode ser reduzido usando vários atalhos compatíveis
	com o parâmetro [<*map*>]. Caso as informações sobre uma linha estejam
	ausentes, presume-se que os dados ausentes nas colunas 5-9 são
	simétricos da esquerda/direita com os dados da coluna 0-4; qualquer
	dados ausentes das colunas 0-4, assume-se então que estas serão
	cópias dos dados anteriores. A mesma lógica se aplica a linhas
	ausentes, exceto que a simetria cima/baixo seja assumida.

	Usando essas abreviações o mapa com 81 caracteres pode ser
	simplesmente definido por essas 11 cadeias de caracteres:
	``-joymap 7778...4445``

	Olhando para a primeira linha, ``7778`` são apenas 4 caracteres
	longos.
	A 5º entrada não pode usar valores simétricos então assume-se que
	seja igual ao valor anterior, '8'. O 6º caractere é esquerda/direita
	em simetria com o 4º caractere, resultando em '8'. O 7º caractere é
	esquerda/direita em simétrica com o 3º caractere, resultando em '9'
	(que é '7' invertido com esquerda/direita). Eventualmente isso
	resulta numa cadeia de ``777888999`` na linha.

	A segunda e a terceira linhas estão ausentes, portanto, elas são
	consideradas idênticas à primeira linha. A quarta linha decodifica
	de forma semelhante à primeira linha, produzindo ``444555666``.
	A quinta linha está faltando, então é assumido como sendo o mesmo
	que o quarto.

	As três linhas restantes também estão faltando, então elas são
	consideradas os espelhos cima/baixo das três primeiras linhas, dando
	três linhas finais de ``111222333``.


.. _mame-commandline-joystickdeadzone:

**-joystick_deadzone** / **-joy_deadzone** / **-jdz** [<*valor*>]

	Caso jogue com um joystick analógico ele poderá estar um pouco
	fora de centro. O ``-joystick_deadzone`` informa uma folga ao longo
	de um eixo que você deve mover antes que o eixo comece a mudar.
	Essa opção espera um valor flutuante (float) no intervalo entre
	**0.0** e **1.0**. Onde **0** é o centro do joystick e **1** o
	limite externo.

	O valor predefinido é **0.3** (**-joystick_deadzone 0.3**). ::

		mame64 sinistar -joystick_deadzone 0.45


.. _mame-commandline-joysticksaturation:

**-joystick_saturation** / **joy_saturation** / **-jsat** [<*valor*>]

	Caso jogue com um joystick analógico as extremidades podem
	estar um pouco fora e podem não corresponder nas direções + /.
	O ``-joystick_saturation`` define se uma folga no movimento do eixo
	será aceita até que se atinja o alcance máximo. Essa opção espera um
	valor flutuante (float) no intervalo entre **0.0** até **1.0** onde
	**0** é o centro do joystick e **1** é o limite externo.

	O valor predefinido é **0.85** (**-joystick_saturation 0.85**). ::

		mame64 sinistar -joystick_saturation 1.0


.. _mame-commandline-natural:

**-natural**

	Permite que o usuário defina se deve ou não usar um teclado natural.
	Isso permite que o seu sistema em um modo *nativo* dependendo da sua
	região, permitindo compatibilidade para teclados fora do padrão
	"QWERTY".

	O valor predefinido é **Desligado** (**-nonatural**).

	No modo de "teclado emulado" (predefinido) o MAME traduz o
	pressionamento/liberação de teclas/botões do host para
	pressionamentos emulados de tecla. Ao pressionar/soltar uma
	tecla/botão mapeado para uma tecla emulada, o MAME pressiona/libera
	a tecla emulada.

	No modo "teclado natural", o MAME tenta traduzir os caracteres para
	as teclas digitadas. O sistema operacional traduz pressionamentos
	de tecla a caracteres (da mesma forma quando se digita em um
	editor de texto) e o MAME tenta traduzir esses caracteres para
	pressionamentos de tecla emulados.

.. raw:: latex

	\clearpage

**Existem várias limitações inevitáveis no modo "teclado natural":**

	* O driver do sistema emulado ou do dispositivo de teclado precisam
	  ser compatíveis e haver suporte para eles.
	* O teclado selecionado **deve** corresponder ao layout do teclado
	  selecionado no sistema operacional emulado!
	* As teclas que não produzam caracteres não podem ser traduzidas.
	* Segurar uma tecla até que o caractere se repitam fará com que a
	  tecla emulada seja pressionada repetidamente em vez de ser mantida
	  pressionada.
	* As sequências de chaves inativas na melhor das hipóteses, são
	  complicadas de se usar.
	* Não funcionará se a edição do **IME** estiver envolvida como
	  Chinês/Japonês/Coreano por exemplo)

	::

		mame64 coco2 -natural


.. _mame-commandline-joystickcontradictory:

**-joystick_contradictory**

	Aceita a entrada de comandos contraditórios e simultâneos no
	controle digital como **Esquerda e Direita** ou **Cima e Baixo** ao
	mesmo tempo.

	O valor predefinido é **Desligado**
	(**-nojoystick_contradictory**) ::

		mame64 ddr4m -joystick_contradictory


.. _mame-commandline-coinimpulse:

**-coin_impulse** *[n]*

	Define o tempo de impulso da moeda com base em *n* (``n<0``
	desabilita, ``n==0`` obedeça o driver, ``0<n`` defina o tempo em
	*n*).

	O valor predefinido é **0** (**-coin_impulse 0**). ::

		mame64 contra -coin_impulse 1


.. raw:: latex

	\clearpage

Opções de entrada habilitadas automaticamente
---------------------------------------------

.. _mame-commandline-paddledevice:

**-paddle_device** / **-paddle**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

.. _mame-commandline-adstickdevice:

**-adstick_device** / **-adstick**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

.. _mame-commandline-pedaldevice:

**-pedal_device** / **-pedal**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

.. _mame-commandline-dialdevice:

**-dial_device** / **-dial**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

.. _mame-commandline-trackballdevice:

**-trackball_device** / **-trackball**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

.. _mame-commandline-lightgundevice:

**-lightgun_device**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

.. _mame-commandline-positionaldevice:

**-positional_device**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

.. _mame-commandline-mousedevice:

**-mouse_device**

	Opções válidas ``none`` | ``keyboard`` | ``mouse`` | ``lightgun`` | ``joystick``

	Cada uma dessas opções de controle são habilitadas automaticamente
	para o mouse, controle (joystick) ou arma de luz (lightgun)
	dependendo de uma classe em particular de controle analógico para um
	sistema em particular. Por exemplo, caso seja definida a opção
	``-paddle mouse``, então qualquer jogo que tenha um remo ou pá como
	controle será automaticamente configurado para ser usado com o mouse
	como se a opção ``-mouse`` tivesse sido definida.

	Observe que estes controles sobrescrevem as opções
	:ref:`-[no]mouse <mame-commandline-nomouse>`,
	:ref:`-[no]joystick <mame-commandline-nojoystick>`, etc. ::

		mame64 sbrkout -paddle_device mouse


.. raw:: latex

	\clearpage

Opções voltadas para a depuração
--------------------------------

.. _mame-commandline-verbose:

**-[no]verbose** / **-[no]v**

	Este é o **modo loquaz** [7]_, exibe todas as informações de
	diagnósticos disponíveis.
	Essas informações são úteis para apurar qualquer tipo de problemas
	com a sua configuração ou qualquer outra que possa aparecer.
	IMPORTANTE: favor rodar com ``mame -verbose`` e incluir a
	saída junto caso queira entrar em contato conosco para relatar um
	erro.

	O valor predefinido é **Desligado** (**-noverbose**). ::

		mame64 ssf2tu -verbose


.. _mame-commandline-oslog:

**-[no]oslog**

	Escreve um arquivo error.log com mensagens de diagnósticos do
	sistema caso um esteja presente.

	É predefinido que as mensagens de erro sejam enviadas para a saída
	padrão, geralmente é exibido no terminal, prompt de comando ou em um
	arquivo de log de sistema. No Windows, caso um depurador esteja
	sendo usado como o depurador do Visual Studio ou WinDbg, as
	mensagens de erros serão enviadas para estes em vez de serem exibidas
	no terminal.

	O valor predefinido é **Desligado** (**-nooslog**). ::

		mame64 mappy -oslog


.. _mame-commandline-log:

**-[no]log**

	Cria um arquivo chamado error.log que contém todos os registros de
	mensagens internas gerada pelo cerne do MAME e drivers de sistema.
	Isso pode ser usado ao mesmo tempo que ``-oslog`` para escrever os
	dados de saída de ambos ao mesmo tempo.

	O valor predefinido é **Desligado** (**-nolog**). ::

		mame64 mappy -log
		mame64 mappy -oslog -log


.. _mame-commandline-debug:

**-[no]debug** / **-[no]d**

	Habilita o depurador embutido no MAME. É predefinido que o depurador
	entre em ação ao pressionar a tela til (**~**) [8]_ durante a
	emulação.
	Ele também entra em ação imediatamente ao iniciar a emulação.

	O valor predefinido é **Desligado** (**-nodebug**). ::

		mame64 indy_4610 -debug


.. _mame-commandline-debugscript:

**-debugscript** [<*nome do arquivo*>]

	Define um arquivo que vai conter a lista de comandos de depuração a
	serem executados no momento da inicialização.

	O valor predefinido é **NULO** (nenhum comando). ::

		mame64 galaga -debugscript testscript.txt

.. raw:: latex

	\clearpage


.. _mame-commandline-updateinpause:

**-[no]update_in_pause**

	Ativa a atualização do bitmap inicial da tela enquanto o sistema
	estiver pausado. Isso significa que a opção de retorno
	**VIDEO_UPDATE** sempre será chamada durante a pausa, o que pode ser
	útil durante a depuração.

	O valor predefinido é **Desligado** (**-noupdate_in_pause**). ::

		mame64 indy_4610 -update_in_pause


.. _mame-commandline-debuggerport:

**-debugger_port** [<*valor*>]

	Define uma porta a ser usada pelo gdbstub debugger. Para usar,
	execute o ``gdb`` e faça o comando
	``target remote localhost:23946``.

	A porta predefinida é **23946**. ::

		mame64 indy_4610 -debugger_port 23999


.. _mame-commandline-debuggerfont:

**-debugger_font** [<*nome da fonte*>] / **-dfont** [<*nome da fonte*>]

	Define o nome da fonte a ser usada nas janelas do depurador.

	A fonte predefinida da janela é **Lucida Console**.
	A fonte predefinida do Mac (**Cocoa**) é o padrão de fonte de
	tamanho fixo do sistema (geralmente a fonte **Monaco**).
	A fonte padrão do Qt é **Courier New**. ::

		mame64 marble -debug -debugger_font "Comic Sans MS"


.. _mame-commandline-debuggerfontsize:

**-debugger_font_size** [<*pontos*>] / **-dfontsize** [<*pontos*>]

	Define o tamanho da fonte a ser usada nas janelas do depurador
	em pontos.

	O tamanho padrão da janela é de **9** pontos.
	O tamanho padrão do Qt é de **11** pontos.
	O tamanho padrão do Mac (**Cocoa**) é o tamanho padrão usado pelo
	sistema. ::

		mame64 marble -debug -debugger_font "Comic Sans MS" -debugger_font_size 16


.. _mame-commandline-watchdog:

**-watchdog** [<*tempo*>] / **-wdog** [<*tempo*>]

	Habilita o temporizador watchdog interno que vai automaticamente
	matar o processo do MAME caso o tempo de duração definido em
	[<*tempo*>] passe caso não haja nenhuma atualização de quadro.
	Tenha em mente que alguns sistemas ficam parados por algum tempo
	durante o carregamento da tela, então [<*duration*>] deve ser grande
	o suficiente para levar esse tempo extra em consideração.
	Geralmente, um valor entre **10** e **30** segundos devem ser
	suficientes.

	Nenhum watchdog vem habilitado. ::

		mame64 ibm_5150 -watchdog 30


.. raw:: latex

	\clearpage

Opções para a configuração da rede
----------------------------------

.. _mame-commandline-commlocalhost:

**-comm_localhost** [<*endereço*>]

	Definição para o endereço local. Este pode ser um endereço
	tradicional ``xxx.xxx.xxx.xxx`` ou um nome do host que possa ser
	resolvido

	O valor predefinido é **0.0.0.0** ::

		mame64 arescue -comm_localhost 192.168.1.2


.. _mame-commandline-commlocalport:

**-comm_localport** [<*porta*>]

	Definição da porta local. Esta pode ser qualquer porta de
	comunicação tradicional como um valor inteiro (**0-65535**).

	O valor predefinido é **15122**. ::

		mame64 arescue -comm_localhost 192.168.1.2 -comm_localport 30100


.. _mame-commandline-commremotehost:

**-comm_remotehost** [<*endereço*>]

	Definição do endereço remoto. Este pode ser um endereço tradicional
	``xxx.xxx.xxx.xxx`` ou um nome de host que possa ser resolvido.

	O valor predefinido é **0.0.0.0** ::

		mame64 arescue -comm_remotehost 192.168.1.2


.. _mame-commandline-commremoteport:

**-comm_remoteport** [<*porta*>]

	Definição da porta remota. Esta pode ser qualquer porta de
	comunicação tradicional como um valor inteiro *non-signed* com
	16-bit (**0-65535**).

	O valor predefinido é **15122**. ::

		mame64 arescue -comm_remotehost 192.168.1.2 -comm_remoteport 30100


.. _mame-commandline-commframesync:

**-[no]comm_framesync**

	Sincroniza os quadros entre os hosts na rede.

	O valor predefinido é **Desligado** (**-nocomm_framesync**). ::

		mame64 arescue -comm_remotehost 192.168.1.3 -comm_remoteport 30100 -comm_framesync


.. raw:: latex

	\clearpage

Opções diversas
---------------

.. _mame-commandline-drc:

**-[no]drc**

	Ativa o núcleo o DRC (recompilador dinâmico) da CPU visando uma
	velocidade máxima de emulação, caso esteja disponível.

	Na recompilação dinâmica as instruções são traduzidas em tempo real
	e mais próxima possível do sistema que está sendo emulado com
	instruções reagrupadas em código de alto nível que então é compilado
	na linguagem nativa do sistema hospedeiro. A grande vantagem desta
	técnica é a melhor adequação do código gerado refletindo num melhor
	desempenho e eficiência durante a execução. Por outro lado a
	penalidade para se atingir uma melhor performance e desempenho
	reside na necessidade de um grande poder de processamento, muito
	maior do que o sistema que está sendo emulado.

	O valor predefinido é **Ligado** (**-drc**). ::

		mame64 ironfort -nodrc


.. _mame-commandline-drcusec:

**-drc_use_c**

	Impor o uso do DRC usando a infra-estrutura em código C.

	O valor predefinido é **Desligado** (**-nodrc_use_c**). ::

		mame64 ironfort -drc_use_c


.. _mame-commandline-drcloguml:

**-drc_log_uml**

	Grave um registro descompilado DRC UML em um arquivo de registro
	(log).

	O valor predefinido é (**-nodrc_log_uml**). ::

		mame64 ironfort -drc_log_uml


.. _mame-commandline-drclognative:

**-drc_log_native**

	Grave o DRC nativo e descompilado num registro de log em formato
	assembler.

	O valor predefinido é **Desligado** (**-nodrc_log_native**). ::

		mame64 ironfort -drc_log_native


.. _mame-commandline-bios:

**-bios** [<*biosname*>]

	Determina qual BIOS usar no sistema a ser emulado em sistemas
	que fazem uso de uma BIOS. A saída ``-listxml`` listará todos os
	nomes das BIOS disponíveis para o sistema.

	Não há valor predefinido (O MAME usará a primeira BIOS nativa
	do sistema que for encontrada, caso uma esteja disponível). ::

		mame64 mslug -bios unibios40


.. _mame-commandline-cheat:

**-[no]cheat** / **-[no]c**

	Ativa o cardápio de trapaças, exibindo uma lista de trapaças que
	ficam armazenadas em um arquivo externo chamado **cheat.7z**.
	Essa opção também habilita as opções de turbo dos botões.

	O valor predefinido é **Desligado** (**-nocheat**). ::

		mame64 kof97 -cheat


.. _mame-commandline-skipgameinfo:

**-[no]skip_gameinfo**

	Ao iniciar, faz com que o MAME não exiba a tela de informações do
	sistema da máquina.

	O valor predefinido é **Desligado** (**-noskip_gameinfo**). ::

		mame64 samsho5 -skip_gameinfo


.. _mame-commandline-uifont:

**-uifont** [<*nome da fonte*>]

	Define o nome da fonte ou um nome do arquivo de fonte a ser usada na
	interface do usuário. Caso esta fonte não possa ser encontrada ou
	não puder ser carregada, o MAME usará a sua própria fonte embutida.
	Em algumas plataformas o [<*nome da fonte*>] (nome da fonte) pode ser
	um nome da fonte do sistema em vez de um arquivo fonte com extensão
	``.bdf``. Para o nome das fontes que tem espaço utilize o nome entre
	aspas (``-uifont "nome do arquivo da fonte"``).

	O valor predefinido é **default** (O MAME usará a fonte nativa). ::

		mame64 -uifont "Comic Sans MS"


.. raw:: latex

	\clearpage

.. _mame-commandline-ui:

**-ui** [<*tipo*>]

	Define o tipo de interface do usuário a ser usada, as opções ficam
	entre **simple** ou **cabinet**.

	O valor predefinido é **Cabinet** (**-ui cabinet**). ::

		mame64 -ui simple


.. _mame-commandline-ramsize:

**-ramsize** / **-ram** [<*n*>]

	Permite que seja alterado o tamanho padrão da RAM (caso exista suporte
	para tanto no driver). ::

		./mame64 maclc -ramsize 32M -hard1 mac761.chd


.. _mame-commandline-confirmquit:

**-confirm_quit**

	Remove o aviso na tela "*Confirmar Sair*" antes de encerrar.

	O valor predefinido é **Desligado** (**-noconfirm_quit**). ::

		mame64 pacman -confirm_quit


.. _mame-commandline-uimouse:

**-ui_mouse**

	Exibe o ponteiro do mouse na interface do usuário do MAME.

	O valor predefinido é **sem mouse** (**-noui_mouse**). ::

		mame64 -ui_mouse


.. _mame-commandline-language:

**-language** / **-lang** [<*idioma*>]

	Especifique um idioma para ser usado na interface do usuário, os
	arquivos de tradução para cada idioma estão no caminho definido em
	**languagepath**. ::

		mame64 -language Portuguese_Brazil


.. _mame-commandline-nvramsave:

**-[no]nvram_save** / **-[no]nvwrite**

	Salva o conteúdo da NVRAM ao encerrar a emulação. Caso essa opção seja
	desligada, o conteúdo que foi gravado anteriormente não será apagado
	e qualquer alteração atual não será gravada. Ao desabilitar essa
	função suprime incondicionalmente o salvamento de arquivos .nv
	associados com alguns tipos de programas usados em cartuchos.

	O valor predefinido é **Ligado** (**-nvram_save**) ::

		mame64 galaga88 -nonvram_save


.. raw:: latex

	\clearpage

Opções para uso com script
--------------------------

.. _mame-commandline-autobootcommand:

**-autoboot_command** / **-ab** "[<*comando*>]"

	Cadeia de comandos que serão executados após a inicialização da
	máquina (entre aspas " "). Para emitir uma cotação para a
	emulação, use """ no comando. Usando **\\n** irá criar uma nova
	linha, emitindo o que foi digitado antes como comando. ::

		mame64 c64 -autoboot_command "load """$""",8,1\n"


.. _mame-commandline-autobootdelay:

**-autoboot_delay** [<*n*>]

	Tempo de atraso (em segundos) para o **-autoboot_command**. ::

		mame64 c64 -autoboot_delay 5 -autoboot_command "load """$""",8,1\n"


.. _mame-commandline-autobootscript:

**-autoboot_script** / **-script** [<*nome_do_arquivo.lua*>]

	Carrega e executa um scrit após a inicialização da máquina. ::

		mame64 ibm5150 -autoboot_script myscript.lua


.. _mame-commandline-console:

**-console**

	Habilita emulador do Console Lua.

	O valor predefinido é **Desligado** (**-noconsole**) ::

		mame64 ibm5150 -console


.. _mame-commandline-plugins:

**-plugins**

	Habilita o uso de plug-ins Lua.

	O valor predefinido é **Ligado** (**-plugins**) ::

		mame64 apple2e -plugins


.. _mame-commandline-plugin:

**-plugin** [<*apelido do plugin*>]

	Permite o uso de uma lista de plug-ins Lua separados por vírgula. ::

		mame64 alcon -plugin cheat,discord,autofire


.. _mame-commandline-noplugin:

**-noplugin** [<*apelido do plugin*>]

	Permite desabilitar uma lista de plug-ins Lua separados por vírgula. ::

		mame64 alcon -noplugin cheat


.. raw:: latex

	\clearpage

Opções do servidor HTTP
-----------------------

.. _mame-commandline-http:

**-http**

	Habilita o servidor de HTTP.

	O valor predefinido é **Desligado** (**-nohttp**) ::

		mame64 -http

	.. note:: Até a última versão deste documento o comando não
              funciona.


.. _mame-commandline-httpport:

**-http_port** [<*port*>]

	Define uma porta para o servidor HTTP.

	O valor predefinido é **8080**. ::

		mame64 apple2 -http -http_port 6502

	.. note:: Até a última versão deste documento o comando não
              funciona.


.. _mame-commandline-httproot:

**-http_root** [<*diretório raíz*>]

	Define a pasta raíz para os documentos do servidor HTTP.

	O valor predefinido é **web**. ::

		mame64 apple2 -http -http_port 6502 -http_root c:\users\me\appleweb\root

	.. note:: Até a última versão deste documento o comando não
              funciona.


.. [1]	**Pattern**, segundo o *Oxford Dictionary* significa arranjar
		algo de forma repetitiva, seguindo um padrão, uma padronagem.
		Tradicionalmente "*pattern*" é traduzido como "*padrão*" porém
		fica claro que não estamos falando de algo igual sendo repetido,
		mas de um conjunto de instruções ou um conjunto de comandos em
		cadência que está informando ao programa as opções que o usuário
		deseja usar. (Nota do tradutor)
.. [2]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
.. [3]	Quando uma imagem ficava estática em uma tela de tubo CRT
		durante muito tempo, a fina película de fósforo que fica por de
		trás da tela de vidro sofria uma leve **queima** nas regiões de
		maior intensidade ficando uma marca no lugar. Uma vez marcada,
		essa mancha ficava sobre a imagem como se fosse uma sombra e nem
		sempre era necessário que a tela estivesse ligada para que a
		mancha pudesse ser visualizada na tela. (Nota do tradutor)
.. [4]	O termo *throttle* no Inglês significa *parar/interromper a
		respiração através da esganadura da garganta*. O termo então
		significa manter o controle do fluxo da velocidade. Em Inglês
		este termo também é usado para descrever o acelerador de um
		veículo, onde o *acelerador* faz o controle da velocidade do
		mesmo. (Nota do tradutor)
.. [5]	Faz com que a metade da parte de cima da tela saia de
		sincronismo com a outra metade da parte de baixo da tela,
		surgindo um efeito ou um "*defeito*" onde cada metade se
		deslocam horizontalmente para lados opostos. (Nota do tradutor)
.. [6]	https://github.com/mamedev/mame/pull/2989/files
.. [7]	Tagarela, que verbaliza muito, falador, barulhento.
		(Nota do tradutor)
.. [8]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
..  [#OQEIU] Interface do Usuário.
..  [#KBPAutoWindows] A opção ``auto`` no Windows tentará utilizar a
		``rawinput``, caso contrário retorna para ``dinput``.
..  [#KBIPAutoSDL] A opção ``auto`` no SDL é predefinido como ``sdl``.
..  [#aliasing]	https://en.wikipedia.org/wiki/Aliasing
..  [#saaliasing]	https://en.wikipedia.org/wiki/Spatial_anti-aliasing
