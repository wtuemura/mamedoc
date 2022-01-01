.. _universal-command-line:

Opções Universais para a linha de comando
=========================================

.. contents:: :local:

.. _mame-commandline-paths:

Nome dos arquivos e a localização dos diretórios
------------------------------------------------

Nativa em (O MAME aceita a utilização de mais de um caminho nas suas
configurações, como por exemplo, as configurações que permitam a
pesquisa das ROMs em diferentes locais, desde que tais configurações
utilizem :kbd:`;` para separar cada caminho.

O MAME consegue também identificar o caminho dos locais dos diretórios
usando as variáveis de ambiente já existente no seu sistema e sua
sintaxe irá depender do sistema operacional a ser usado. No Windows por
exemplo, caso a configuração **%APPDATA%\\mame\\cfg** seja definida, o
MAME conseguirá ler a variável **%APPDATA%** e resolver o caminho
completo para o diretório de dados de aplicativos do usuário.

Em sistemas estilo UNIX como macOS e Linux que utilizam o interpretador
de comandos *Bourne Shell*, aconteceria o mesmo caso o caminho seja
definido nas configurações como **/home/${USER}/.mame/cfg**. Assim como
o sinal de porcentagem **%** é usado numa palavra para se definir uma
variável no ambiente do *Windows*, o sinal de til :kbd:`~` serve como um
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
	exec ./mame

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

		mame -help

.. _mame-commandline-validate:

**-validate** / **-valid** <*palavra chave*>

	Executa uma validação interna num ou mais drivers e dispositivos
	no sistema. Execute isso antes de enviar qualquer alterações para
	nós visando garantir qualquer tipo de violação em nenhuma das
	regras do sistema principal.

	Caso um padrão seja definido, ele validará a correspondência
	predefinida do sistema em questão, caso contrário, validará todos
	os sistemas e dispositivos. Note que caso um padrão seja definido,
	este será comparado apenas com sistemas e não com outros
	dispositivos, nenhum tipo de validação será realizada com
	dispositivos.

	Exemplo:
		.. code-block:: shell

			mame -validate
			Driver ace100 (file apple2.cpp): 1 errors, 0 warnings
			Errors:
			Software List device 'flop525_orig': apple2_flop_orig.xml: Errors parsing software list:
			apple2_flop_orig.xml(126.2): Unknown tag: year
			apple2_flop_orig.xml(126.8): Unexpected content
			apple2_flop_orig.xml(127.2): Unknown tag: publisher

.. raw:: latex

	\clearpage

.. _mame-commandline-verifyroms:

**-verifyroms** <*palavra chave*>

	Verifica a condição dos arquivos de imagem ROM numa determinada
	máquina. Serão verificados todas as máquinas e diretórios válidos
	que estejam dentro do ``rompath`` (caminho da rom):

	Exemplo:
		.. code-block:: shell

			mame -verifyroms pacman
			romset pacman [puckman] is good
			1 romsets found, 1 were OK.

	É possível usar um asterisco ao final do nome da máquina para que
	seja exibido uma lista com todas as outras máquinas relacionadas com
	o nome da máquina principal e a sua condição atual, exemplo:

	Exemplo:
		.. code-block:: shell

			mame -verifyroms pacman*
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

**-verifysamples** <*palavra chave*>

	Verifica a condição dos arquivos **samples** informado. Todos os
	arquivos samples ou diretórios válidos serão verificados desde que
	estejam configurados em ``samplepath``:

	Exemplo:
		.. code-block:: shell

			mame -verifysamples 005
			sampleset 005 is good
			1 samplesets found, 1 were OK.

	É possível usar um asterisco ao final do nome do sample para que
	seja exibido uma lista com todos os outros samples relacionados com
	o nome do sample principal e a sua condição atual, exemplo:

	Exemplo:
		.. code-block:: shell

			mame -verifysamples armora*
			sampleset armora is good
			sampleset armorap [armora] is good
			sampleset armorar [armora] is good
			3 samplesets found, 3 were OK.

	Todas os samples serão listados caso nenhum nome seja informado.

.. raw:: latex

	\clearpage

.. _mame-commandline-verifysoftware:

**-verifysoftware** / **-vsoft** <*palavra chave*>

	Verifica se há imagens ROM inválidas ou ausentes na lista de
	software. Por predefinição, todos os drivers que possuem arquivos
	``.zip`` ou diretórios válidos no rompath (caminho da rom) serão
	verificados, no entanto, é possível limitar essa lista definindo um
	nome de driver específico ou *combinações* após o comando
	``-verifysoftware``.

	Exemplo:
		.. code-block:: shell

			mame -vsoft x68000
			romset x68k_flop:2069ad is good
			romset x68k_flop:3takun is good
			romset x68k_flop:38mankk is good
			romset x68k_flop:4thunit is good
			...
			0000 romsets found in 1 software lists, 0000 romsets were OK.

.. _mame-commandline-verifysoftlist:

**-verifysoftlist** / **-vlist** <*nome da lista de programa*>

	Verifica ROMs ausentes com base numa lista de software
	predeterminado na pasta **hash**.
	É predefinido que a busca e a verificação será feita em todos os
	drivers e arquivos ``.zip`` em diretórios válidos no *rompath*
	(caminho da rom), no entanto, é possível filtrar essa lista usando
	uma palavra chave ou coringa em "*softwarelistname*" após o comando
	``-verifysoftlist``. As listas estão na pasta *hash* e devem ser
	informadas sem a extensão ``.xml``.

	O resultado é exatamente igual ao comando ``-verifysoftware``, porém
	usando uma lista de software.

	Exemplo:
		.. code-block:: shell

			mame -vsoft x68k_flop
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
	alterados, basta editar este arquivo de configuração.

	Exemplo:
		.. code-block:: shell

			mame -cc

.. _mame-commandline-showconfig:

**-showconfig** / **-sc**

	Exibe as configurações atualmente usadas. É possível direcionar essa
	saída para um arquivo ou também é possível utilizá-lo como um
	arquivo ``.ini``, como mostra o exemplo abaixo:

	Exemplo:
		.. code-block:: shell

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

	Todas as opções aparecem comentadas.

	Exemplo:
		.. code-block:: shell

			mame -su
			Usage:  mame [machine] [media] [software] [options]
			
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
o comando foi digitado. Caso queira gravar a informação num arquivo
texto, adicione o exemplo abaixo ao final do seu comando:

	**>** *nome do arquivo*

Onde '*nome do arquivo*' é o nome do arquivo texto que será criado para
registrar toda a saída do terminal (por exemplo, ``lista.txt``). Note
que qualquer conteúdo prévio que exista dentro deste arquivo será
apagado sem qualquer aviso prévio.
Exemplo:

	Isso cria (ou sobrescreve se já existir) o arquivo ``lista.txt`` e
	completa o arquivo com os resultados de ``-listcrc puckman``.
	Em outras palavras, a lista de cada ROM usada em *Puckman* e o CRC
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

	Exemplo
		.. code-block:: xml

			mame -lx sf2
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

**-listfull** / **-ll** <*palavra chave*>

	Exibe uma lista com o nome da máquina pesquisada e a sua
	descrição:

	Exemplo:
		.. code-block:: shell

			mame -ll pacman
			Name:             Description:
			pacman            "Pac-Man (Midway)"

	É possível usar um asterisco ao final do nome da máquina para que seja
	exibido uma lista com todas as outras máquinas relacionadas com o
	nome da máquina principal e as suas respectivas descrições,
	exemplo:

	Exemplo:
		.. code-block:: shell

			mame -ll pacman*
			Name:             Description:
			pacman            "Pac-Man (Midway)"
			pacmanbl          "Pac-Man (Galaxian hardware, set 1)"
			pacmanbla         "Pac-Man (Galaxian hardware, set 2)"
			pacmanblb         "Pac-Man (Moon Alien 'AL-10A1' hardware)"
			...

	É possível também listar a descrição de sistemas, infelizmente nem
	todos os sistemas possuem descrições disponíveis ainda, exemplo:

	Exemplo:
		.. code-block:: shell

			mame -ll neogeo*
			Name:             Description:
			neogeo            "Neo-Geo MV-6F"
			neogeo_cart_slot  "Neo Geo Cartridge Slot"
			...
			
			mame -ll genesis*
			Name:             Description:
			genesis           "Genesis (USA, NTSC)"
			genesis_tmss      "Genesis (USA, NTSC, with TMSS chip)"
			genesisp          "Genesis"
			...
			
			mame -ll snes*
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

**-listsource** / **-ls** <*palavra chave*>

	Exibe uma lista de drivers/dispositivos dos sistemas e o nome dos
	seus respectivos arquivos fonte. Útil para identificar qual driver o
	sistema roda, muito útil para o relatório de bugs. É predefinido que
	todos os sistemas e os dispositivos sejam listados; contudo, é
	possível limitar a lista através de um nome ou texto qualquer após a
	opção **-listsource**.

	Exemplo:
		.. code-block:: shell

			mame -ls pacman
			pacman           pacman.cpp

	É possível também utilizar um curinga (asterisco) ao final do nome
	da máquina para que seja exibido uma lista com todas as outras
	máquinas que estejam relacionadas com o nome da máquina principal,
	exemplo:

	Exemplo:
		.. code-block:: shell

			mame -ls pacman*
			pacman           pacman.cpp
			pacmanbl         galaxian.cpp
			...
			pacmania         namcos1.cpp

	Todas as máquinas serão listadas caso nenhuma palavra chave seja
	informada.

.. _mame-commandline-listclones:

**-listclones** / **-lc** <*palavra chave*>

	Exibe uma lista de clones de uma determinada máquina. O MAME irá
	listar todos os clones em seu banco de dados porém a lista pode
	ser filtrada com o uso de uma palavra chave após o comando.
	Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -lc rallyx
			Name:            Clone of:
			dngrtrck         rallyx
			rallyxa          rallyx
			rallyxm          rallyx
			rallyxmr         rallyx

.. _mame-commandline-listbrothers:

**-listbrothers** / **-lb** <*palavra chave*>

	Exibe uma lista com o nome do driver, da ROM principal e parentes
	que compartilhem do mesmo driver da máquina pesquisada. Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -lb 005
			Source file:         Name:            Parent:
			segag80r.cpp         005
			segag80r.cpp         astrob
			segag80r.cpp         astrob1          astrob
			segag80r.cpp         astrob2          astrob
			segag80r.cpp         astrob2a         astrob
			segag80r.cpp         astrob2b         astrob


.. raw:: latex

	\clearpage

.. _mame-commandline-listcrc:

**-listcrc** <*palavra chave*>...]

	Exibe uma lista completa com CRCs de todas as imagens ROM
	que compõem uma máquina, nomes de sistema ou dispositivo num
	formato simples que pode ser facilmente filtrado por comandos como
	``grep``, ``awk`` e ``sed`` no Linux e macOS ou
	`findstr <https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/findstr>`_ no Windows.
	Caso nenhuma palavra chave seja usada como filtro após o comando,
	o MAME irá listar *tudo* que estiver em seu banco de dados interno.
	Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -listcrc 005
			8e68533e 1346b.cpu-u25                   005             005
			29e10a81 5092.prom-u1
			...
			1d298cb0 6331.sound-u8                   005             005

.. _mame-commandline-listroms:

**-listroms** / **-lr** <*palavra chave*>

	Exibe uma lista com todos os arquivos ROM que fazem parte de uma
	máquina ou dispositivo. A lista mostra o nome dos arquivos ROM,
	os valores CRC e SHA1, assim como mostra também se uma das ROMs
	contidas no arquivo estão sinalizadas como **BAD_DUMP**.
	Isso significa que o conteúdo extraído não é válido, pode conter
	erro, não foi extraído de forma correta ou de forma apropriada,
	por algum motivo não pode ser validada, etc. Caso nenhuma palavra
	chave seja usada como filtro após o comando, o MAME irá listar
	**tudo** que estiver em seu banco de dados interno. Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -lr 005
			ROMs required for driver "005".
			Name                                   Size Checksum
			1346b.cpu-u25                          2048 CRC(8e68533e) SHA1(a257c556d31691068ed5c991f1fb2b51da4826db)
			5092.prom-u1                           2048 CRC(29e10a81) SHA1(c4b4e6c75bcf276e53f39a456d8d633c83dcf485)
			...
			6331.sound-u8                            32 BAD CRC(1d298cb0) SHA1(bb0bb62365402543e3154b9a77be9c75010e6abc) BAD_DUMP

.. _mame-commandline-listsamples:

**-listsamples** <*palavra chave*>

	Exibe uma lista das amostras que fazem parte de uma determinada
	máquina, nomes de sistema ou nome de dispositivos. Caso nenhum termo
	seja usado como filtro depois do comando, *todos* os resultados dos
	sistemas e dispositivos serão exibidos. Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -listsamples 005
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

**-romident** <*caminho\\completo\\para\\a\\rom\\desconhecida*>

	Tenta identificar os arquivos ROM desconhecidos comparando-o com
	os arquivos cadastrados no banco de dados interno do MAME que sejam
	utilizados por apenas uma máquina ou que também sejam
	compartilhados por mais de um arquivo ``.zip`` específico. Este
	comando também pode ser usado para tentar identificar conjuntos de
	ROM retirados de placas desconhecidas. A opção vai identificar os
	arquivos compactados ou não. Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -romident rom_desconhecida.zip
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

**-listdevices** / **-ld** <*palavra chave*>

	Exibe as especificações técnicas e todos os dispositivos conhecidos
	e conectados na máquina. Caso os slots sejam populados por
	dispositivos, todos os slots adicionais que esses dispositivos
	fornecerem ficarão visíveis com ``-listdevices`` também. Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -ld x68000
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
			...


.. raw:: latex

	\clearpage


.. _mame-commandline-listslots:

**-listslots** / **-lslot** <*sistema*>

	Exibe uma lista com todos os slots disponíveis para o sistema e suas
	respectivas opções, caso estejam disponíveis. Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -lslot x68000
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
	faça:

	Exemplo:
		.. code-block:: shell

			mame x68000 -exp1 x68k_midi -midiout "o seu dispositivo MIDI"

	Para saber qual o dispositivo MIDI disponível no seu sistema,
	consulte o comando :ref:`-listmidi <mame-commandline-listmidi>`.


.. raw:: latex

	\clearpage


.. _mame-commandline-listmedia:

**-listmedia** / **-lm** <*sistema*>

	Exibe uma lista de mídias ou formatos compatíveis com o sistema como
	cartucho, cassete, disquete, etc. O comando também exibe as
	extensões compatíveis como cada sistema caso elas existam, na
	dúvida, execute o comando ``mame -lm sistema`` para saber quais os
	tipo de mídia o MAME aceita e quais delas são compatíveis com o
	sistema em questão.
	Exemplo:

	Exemplo:
		.. code-block:: shell

			mame -lm psu
			SYSTEM           MEDIA NAME       (brief)    IMAGE FILE EXTENSIONS SUPPORTED
			---------------- --------------------------- -------------------------------
			psu              memcard1         (memc1)    .mc   
			psu              memcard2         (memc2)    .mc   
			psu              quickload        (quik)     .cpe  .exe  .psf  .psx  
			psu              cdrom            (cdrm)     .chd  .cue  .toc  .nrg  .gdi  .iso


	Caso queira carregar uma ROM num sistema como o Megadrive por
	exemplo faça ``mame genesis -cart caminho_para_a_rom``. Outros
	sistemas podem aceitar outros formatos, no caso dos sistemas que
	rodem CD-ROM por exemplo, a opção pode ser
	``-cdrom caminho_para_a_imagem`` ou ``-cdrm caminho_para_a_imagem``, 
	caso o sistema também aceite cartões de memória (memory card), é
	possível combinar a opção ``-cdrom caminho_para_a_imagem`` com
	``-memc1 caminho_para_a_imagem``.


.. _mame-commandline-listsoftware:

**-listsoftware** / **-lsoft** <*sistema*>

	Exibe o conteúdo de todas as listas de software que podem ser
	utilizadas pelo sistema ou pelos sistemas (praticamente são todos os
	arquivos XML que estão dentro do diretório ``hash``).

	Exemplo:
		.. code-block:: xml

			mame -lsoft x68000
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


.. raw:: latex

	\clearpage


.. _mame-commandline-getsoftlist:

**-getsoftlist** / **-glist** <*lista de programa*>

	Exibe o conteúdo de uma lista de software em formato XML, exatamente
	mesma coisa que ``-listsoftware`` acima, porém em vez do sistema se
	utiliza o nome da lista de programa.

	Exemplo:
		.. code-block:: xml

			mame -glist msx1_cass
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

**-uimodekey** <*tecla*>

	Tecla usada para ativar ou desativar os controles de teclado do
	MAME. A configuração predefinida é **SCRLOCK** no Windows,
	**Forward Delete** no macOS ou **SCRLOCK** em outros sistemas como
	Linux por exemplo. Use **FN-Delete** em computadores/notebooks
	Macintosh que usem teclados compactos.

	Exemplo:
		.. code-block:: shell

			mame ibm5150 -uimodekey DEL

.. _mame-commandline-uifontprovider:

**-uifontprovider** <*módulo*>

	Define a fonte que será renderizada na Interface do Usuário. O
	binário oficial do MAME para Windows não é compilado com SDL, sendo
	necessário compilar uma versão compatível para que a opção ``sdl``
	funcione.
	O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame ajax -uifontprovider dwrite

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

**-keyboardprovider** <*módulo*>

	Escolhe como o MAME lidará com a entrada do teclado. No Windows,
	``auto`` tentará o **rawinput**, caso contrário retornará para
	**dinput**. O binário oficial do MAME para Windows não é compilado
	com SDL, sendo necessário compilar uma versão compatível para que a
	opção ``sdl`` funcione.

	Observe que a emulação do teclado em modo de usuário para
	ferramentas como joy2key irá certamente precisar da opção
	``-keyboardprovider win32`` no Windows.

	O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame c64 -keyboardprovider win32

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

**-mouseprovider** <*módulo*>

	Escolhe como o MAME lidará com a entrada do mouse. No Windows,
	``auto`` tentará o **rawinput**, caso contrário retornará para
	**dinput**. Nas versões SDL, o ``auto`` será predefinido como
	**sdl**.
	O binário oficial do MAME para Windows não é compilado com SDL,
	sendo necessário compilar uma versão compatível para que a opção
	``sdl`` funcione.
	O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame indy_4610 -mouseprovider win32

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

**-lightgunprovider** <*módulo*>

	Escolhe como o MAME lidará com a arma de luz (*light gun*). No
	Windows, ``auto`` tentará **rawinput**, caso contrário retornará
	para **win32** ou **none** caso não encontre nenhum.
	No SDL/Linux o ``auto`` é predefinido como **x11** ou **none**
	caso não encontre nenhum. Em outro tipo de SDL o ``auto`` será
	predefinido para **none**.

	O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame lethalen -lightgunprovider x11

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

**-joystickprovider** <*módulo*>

	Escolhe como o MAME lidará com a entrada do joystick. Repare que no
	controle do Microsoft X-Box 360 e X-Box One, eles funcionarão melhor
	com **winhybrid** ou **xinput**. A opção do controle *winhybrid*
	suporta uma mistura de DirectInput e Xinput ao mesmo tempo.
	No SDL, ``auto`` será predefinido para **sdl**. O binário oficial do
	MAME para Windows não é compilado com SDL, sendo necessário compilar
	uma versão compatível para que a opção ``sdl`` funcione.

	O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame mk2 -joystickprovider winhybrid

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
	serem utilizados durante a emulação.

	Exemplo:
		.. code-block:: shell

			mame -listmidi
			MIDI output ports:
			Microsoft MIDI Mapper (default)
			CoolSoft MIDIMapper
			Microsoft GS Wavetable Synth
			VirtualMIDISynth #1

.. _mame-commandline-midiin:

**-midiin** <*nome do dispositivo*>

	Informe manualmente o dispositivo MIDI de entrada da sua preferência
	caso o seu computador ou sistema utilize mais de um. O comando
	apenas funciona nas máquinas compatíveis e que estejam funcionando
	com uma entrada MIDI. Consulte também a opção :ref:`-listslot
	<mame-commandline-listslots>` para identificar o nome do slot.
	Caso o nome do dispositivo tenha espaço, use aspas.

	Exemplo:
		.. code-block:: shell

			mame sistema -nome-do-slot -midiin "nome do dispositivo ou arquivo midi"

.. _mame-commandline-midiout:

**-midiout** <*nome do dispositivo*>

	Informe manualmente o dispositivo MIDI de saída da sua preferência
	caso o seu computador ou sistema utilize mais de um. O comando
	apenas funciona nas máquinas compatíveis e que estejam funcionando
	com uma entrada MIDI. Consulte também a opção :ref:`-listslot
	<mame-commandline-listslots>` para identificar o nome do slot.
	Caso o nome do dispositivo tenha espaço, use aspas.

	Exemplo:
		.. code-block:: shell

			mame sistema -nome-do-slot -midiout "nome do dispositivo"

.. raw:: latex

	\clearpage


.. _mame-commandline-listnetwork:

**-listnetwork**

	Lista os adaptadores de redes que estiverem disponíveis para serem
	utilizados com a emulação.

	Exemplo:
		.. code-block:: shell

			No Windows
			mame -listnetwork
				Available network adapters:
				Conexão Local
			
			No Linux
			mame -listnetwork
				Available network adapters:
				TAP/TUN Device

	.. note::

		No Windows, é necessário instalar o
		`OpenVPN <https://openvpn.net/community-downloads/>`_ mais
		recente para que o MAME possa ver os adaptadores de rede.

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
	iluminação externa caso esteja disponível.

	Exemplo:
		.. code-block:: shell

			mame galaxian -output console
			lamp0 = 1
			lamp1 = 1
			lamp0 = 0
			lamp1 = 0

	Tão logo um crédito seja inserido e se for o caso do botão do
	Jogador 1 (1P) começar a piscar os valores começaram a alternar na
	tela.

	Aqui no caso da máquina "Breakers":

	Exemplo:
		.. code-block:: shell

			mame breakers -output console
			digit1 = 63
			digit2 = 63
			digit3 = 63
			digit4 = 63

	Cada máquina terá a sua própria característica.

	É possível escolher entre: ``auto``, ``none``, ``console`` ou
	``network``.

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

	Caso o depurador esteja ativado.

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

.. raw:: latex

	\clearpage

- **<nome-do-driver-da-máquina>.ini**

	Para que as opções sejam aplicadas apenas no driver da máquina, para
	saber qual o nome do driver de uma determinada máquina faça o
	comando:

	Exemplo:
		.. code-block:: shell

			mame sf2 -ls
			sf2              cps1.cpp

	O nome do driver é **cps1**, logo, o arquivo deve ser nomeado como
	``cps1.ini``.

	Veja mais em :ref:`advanced-multi-CFG` para mais detalhes.

	Exemplo:
		.. code-block:: shell

			mame sf2ce -norc -ctrlr sf2

	As configurações nos INIs posteriores substituem aquelas dos INIs
	anteriores.
	Então, por exemplo, caso queira desabilitar os efeitos de
	sobreposição nos sistemas vetoriais, é possível criar um arquivo
	``vector.ini`` com a linha **effect none** nele, ele irá
	sobrescrever qualquer valor de efeito existente no seu ``mame.ini``.

		O valor predefinido é ``Ligado`` (``-readconfig``).


.. _mame-commandline-nowriteconfig:

**-[no]writeconfig** / **-[no]wc**

	Grava as configurações feitas no driver da máquina num arquivo
	(driver).ini ao encerrar da emulação. O valor predefinido é
	``Desligado`` (``-nowriteconfig``).

	Exemplo:
		.. code-block:: shell

			mame sf2ce -wc -ctrlr sf2


.. raw:: latex

	\clearpage

Opções para a configuração dos diretórios principais
----------------------------------------------------

.. _mame-commandline-homepath:

**-homepath** <*caminho*>

	Define o caminho para onde os **plugins** Lua armazenarão os
	dados. O valor predefinido é '.' (no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -homepath D:\mame\lua


.. _mame-commandline-rompath:

**-rompath** / **-rp** / **-biospath** / **-bp** <*caminho*>

	Define o caminho completo para encontrar imagens ROM, disco rígido,
	fita cassete, etc. Mais de um caminho podem ser definidos desde que
	estejam separados por ponto e vírgula. O valor predefinido é
	``roms`` (isto é, um diretório chamado **roms** no diretório raiz do
	MAME).

	Exemplo:
		.. code-block:: shell

			mame -rompath D:\mame\roms;D:\MSX\floppy;D:\MSX\cass


.. _mame-commandline-hashpath:

**-hashpath** / **-hash_directory** / **-hash** <*caminho*>

	Define o caminho completo para a pasta com os arquivos **hash** que
	é usado pela *lista de software* no gerenciador de arquivos. Mais de
	um caminho podem ser definidos desde que estejam separados por ponto
	e vírgula. O valor predefinido é ``hash`` (isto é, um diretório
	chamado **hash** no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -hashpath D:\mame\hash;D:\roms\softlists


.. _mame-commandline-samplepath:

**-samplepath** / **-sp** <*caminho*>

	Define o caminho completo para os arquivos de amostras (samples).
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é ``samples`` (isto é, um
	diretório chamado **samples** no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -samplepath D:\mame\samples;D:\roms\samples


.. _mame-commandline-artpath:

**-artpath** <*caminho*>

	Define o caminho completo para os arquivos com as ilustrações
	gráficas (*artworks*) das máquinas. Essas ilustrações são imagens
	que cobrem o fundo da tela e oferecem alguns efeitos interessantes.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é ``artwork`` (isto é,
	um diretório chamado **artwork** no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -artpath D:\mame\artwork;D:\emu\shared-artwork


.. raw:: latex

	\clearpage


.. _mame-commandline-ctrlrpath:

**-ctrlrpath** <*caminho*>

	Define um ou mais caminhos para os arquivos de configuração dos
	controles. Mais de um caminho pode ser definido desde que estejam
	separados por ponto e vírgula. É usado em conjunto com a opção
	``-ctrlr``.
	
	O valor predefinido é ``ctrlr`` (isto é, um diretório chamado
	**ctrlr** no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -ctrlrpath D:\mame\ctrlr;D:\emu\meus_controles


.. _mame-commandline-inipath:

**-inipath** <*caminho*>

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

		mame -inipath D:\mameini

.. _mame-commandline-fontpath:

**-fontpath** <*caminho*>

	Define um ou mais caminhos onde os arquivos de fonte ``.bdf``
	(*Adobe Glyph Bitmap Distribution Format*) possam ser encontrados.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é ``.`` (isto é, no
	diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -fontpath D:\mame\;D:\emu\fontes


.. _mame-commandline-cheatpath:

**-cheatpath** <*caminho*>

	Define o caminho completo para os arquivos de trapaça em formato
	``.xml``.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula. O valor predefinido é ``cheat`` (isto é, uma
	pasta chamada **cheat**, localizada no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -cheatpath D:\mame\cheat;D:\emu\trapaças


.. _mame-commandline-crosshairpath:

**-crosshairpath** <*caminho*>

	Define um ou mais caminhos onde os arquivos de mira **crosshair**
	possam ser encontrados. Mais de um caminho podem ser definidos desde
	que estejam separados por ponto e vírgula. O valor predefinido é
	``crosshair`` (isto é, um diretório chamado **crosshair** no
	diretório raiz do MAME). Caso uma mira seja definida no menu, o MAME
	procurará por ``nomedosistema\cross#.png``, em seguida no
	**crosshairpath** especificado onde **#** é o número do jogador.

	Caso nenhuma mira seja definida, o MAME usará a sua própria.

	Exemplo:
		.. code-block:: shell

			mame -crosshairpath D:\mame\crsshair;D:\emu\miras


.. _mame-commandline-pluginspath:

**-pluginspath** <*caminho*>

	Define um ou mais caminhos onde possam ser encontrados os plug-ins
	do Lua para o MAME. O valor predefinido é ``plugins`` (isto é, um
	diretório chamado **plugins** no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -pluginspath D:\mame\plugins;D:\emu\lua


.. _mame-commandline-languagepath:

**-languagepath** <*caminho*>

	Define um ou mais caminhos onde possam ser encontrados os arquivos
	de tradução que o MAME usa na Interface do Usuário. O valor
	predefinido é **language** (isto é, um diretório chamado
	**language** no diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -languagepath D:\mame\language;D:\emu\idiomas


.. _mame-commandline-swpath:

**-swpath** <*caminho*>

	Define um ou mais caminhos onde possam ser encontrados arquivos
	avulsos dos programas (rom, iso, etc). O valor predefinido é
	``software`` (isto é, um diretório chamado **software** no
	diretório raiz do MAME).

	Exemplo:
		.. code-block:: shell

			mame -swpath D:\mame\floppy;D:\emu\discos


.. _mame-commandline-cfgdirectory:

**-cfg_directory** <*caminho*>

	Define o diretório onde os arquivos de configuração são armazenados.
	Os arquivos de configuração armazenam as customizações feitas pelo
	usuário e são lidas na inicialização do MAME ou de uma máquina
	emulada, depois quaisquer alterações são salvas ao encerrar o MAME.

	Os arquivos de configuração preservam as configurações da ordem dos
	botões do seu controle ou joystick, configurações das chaves DIP,
	informações da contabilidade da máquina e a organização das janelas
	do depurador.

	O valor predefinido é ``cfg`` (isto é, um diretório com o nome
	**cfg** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente.

	Exemplo:
		.. code-block:: shell

			mame -cfg_directory D:\mame\cfg


.. raw:: latex

	\clearpage


.. _mame-commandline-nvramdirectory:

**-nvram_directory** <*caminho*>

	Define o diretório onde os arquivos **NVRAM** são armazenados.
	Os arquivos **NVRAM** armazenam o conteúdo da **EEPROM**, memória
	RAM não volátil (NVRAM) e informações de outros dispositivos
	programáveis que fazem uso deste tipo de memória. As informações são
	lidas no início da emulação e gravadas ao encerrar.

	O valor predefinido é ``nvram`` (isto é, um diretório com nome
	"nvram" no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente.

	Exemplo:
		.. code-block:: shell

			mame -nvram_directory D:\mame\nvram


.. _mame-commandline-inputdirectory:

**-input_directory** <*caminho*>

	Define o diretório onde os arquivos de gravação da entrada são
	armazenados. As gravações da entrada são criadas através da opção
	**-record** e reproduzidas através da opção **-playback**. A opção
	grava todos os comando e acionamentos de botões que forem feitos
	durante a operação da máquina.

	O valor predefinido é ``inp`` (ou seja, um diretório de nome
	**inp** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente.

	Exemplo:
		.. code-block:: shell

			mame -input_directory D:\mame\inp


.. _mame-commandline-statedirectory:

**-state_directory** <*caminho*>

	Define o diretório onde os arquivos de gravação de estado são
	armazenados. Os arquivos de estado são lidos e gravados mediante a
	solicitação do usuário ou ao usar a opção
	:ref:`-autosave <mame-commandline-noautosave>`.

	O valor predefinido é ``sta`` (isto é, um diretório de nome
	**sta** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente.

	Exemplo:
		.. code-block:: shell

			mame -state_directory D:\mame\sta

.. _mame-commandline-snapshotdirectory:


**-snapshot_directory** <*caminho*>

	Define o diretório onde os arquivos de instantâneos da tela são
	armazenados quando solicitado pelo usuário.

	O valor predefinido é ``snap`` (isto é, um diretório chamado
	**snap** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente.

	Exemplo:
		.. code-block:: shell

			mame -snapshot_directory D:\mame\snap


.. raw:: latex

	\clearpage


.. _mame-commandline-diffdirectory:

**-diff_directory** <*caminho*>

	Define o diretório onde os arquivos de diferencial do disco rígido
	são armazenados. Os arquivos de diferencial armazenam qualquer dado
	que é escrito de volta na imagem do disco, isso serve para preservar
	a imagem de disco original. Os arquivos são criados no inicio da
	emulação com uma imagem compactada do disco rígido.

	O valor predefinido é ``diff`` (isto é, um diretório chamado
	**diff** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente.

	Exemplo:
		.. code-block:: shell

			mame -diff_directory D:\mame\diff


.. _mame-commandline-commentdirectory:

**-comment_directory** <*caminho*>

	Define o diretório onde os arquivos de comentário do depurador são
	armazenados. Os arquivos de comentário do depurador são escritos
	pelo depurador quando comentários são adicionados num sistema
	desmontado (disassembly).

	O valor predefinido é ``comments`` (isto é, um diretório chamado
	**comments** no diretório raiz do MAME). Caso este diretório não
	exista, ele será criado automaticamente.

	Exemplo:
		.. code-block:: shell

			mame -comment_directory D:\mame\comments


.. _mame-commandline-sharedirectory:

**-share_directory** <*caminho*>

	Define o diretório que será compartilhado com a máquina ou o sistema
	que está sendo emulado. Por exemplo, no caso de um sistema
	operacional compatível, os arquivos que forem colocados neste
	diretório será compartilhado com o host emulado.

	Exemplo:
		.. code-block:: shell

			mame -share_directory D:\mame\share

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
	rebobinar passo único (:kbd:`Shift` :kbd:`Esquerdo` + :kbd:`~`) [2]_.

	O valor predefinido é ``Desligado`` (``-norewind``).

	Caso o depurador esteja no estado *break*, a condição de estado
	atual é criada a cada *step in*, *step over* ou caso ocorra um
	*step out*. Nesse modo os estados salvos podem ser carregados e
	rebobinados executando o comando *rewind* ou *rw* no depurador.

	Exemplo:
		.. code-block:: shell

			mame -norewind


.. _mame-commandline-rewindcapacity:

**-rewind_capacity** <*valor*>

	Define a capacidade de rebobinar em megabytes.
	É a quantidade total de memória que será usada para rebobinar
	os *savestates*. Quando a capacidade alcança o limite, os antigos
	*savestates* são apagados enquanto novos são capturados. Definindo
	uma capacidade menor do que o *savestate* atual, desabilita o
	rebobinamento. Os valores negativos são automaticamente fixados em
	``0``.

	Exemplo:
		.. code-block:: shell

			mame -rewind_capacity 30


.. _mame-commandline-statename:

**-statename** <*nome*>

	Descreve como o MAME deve armazenar os arquivos de estado salvos
	relativo ao caminho do *state_directory*. <*nome*> é uma *string*
	que fornece um modelo a ser usado usado para gerar um nome de
	arquivo.

	São disponibilizadas duas substituições simples: o caractere ``/``
	representa o separador de caminho em qualquer plataforma de destino
	(até mesmo no Windows); a *string* ``%g`` representa o nome do
	driver do sistema atual.

	O valor predefinido é ``%g``, que cria uma pasta separada para cada
	sistema.

	Em adição ao que foi dito acima, para os drivers que usem mídias
	diferentes, como cartões ou disquetes, é possível usar o indicador
	``%d_[media]``. Substitua ``[media]`` pelo comutador de mídia
	desejado.

	Alguns exemplos:

	* Caso use ``mame robby -statename foo/%g%i`` as capturas da tela
	  serão salvos em **sta\\foo\\robby\\**.

	* Caso use ``mame nes -cart robby -statename %g/%d_cart``
	  os instantâneos serão salvos em **sta\\nes\\robby**.

	* Caso use ``mame c64 -flop1 robby -statename %g/%d_flop1/%i``
	  estes serão salvos como **sta\\c64\\robby\\0000.png**.

.. raw:: latex

	\clearpage

.. _mame-commandline-state:

**-state** <*slot*>

	Depois de iniciar um sistema determinado, fará com que o estado
	salvo no <*slot*> seja carregado imediatamente.

	Exemplo:
		.. code-block:: shell

			mame -state 1

.. _mame-commandline-noautosave:

**-[no]autosave**

	Quando ativado, cria automaticamente um arquivo com a condição atual
	do sistema ao encerrar o MAME e automaticamente tenta recarregá-lo
	caso o MAME inicie novamente com o mesmo sistema. A opção só
	funciona para os sistemas que sejam compatíves com o salvamento do
	seu estado.

	O valor predefinido é ``Desligado`` (``-noautosave``).

	Exemplo:
		.. code-block:: shell

			mame -autosave


.. _mame-commandline-playback:

**-playback** / **-pb** <*nome do arquivo*>

	Faz a reprodução de um arquivo de gravação. Esse recurso não
	funciona de maneira confiável com todos os sistemas, mas pode ser
	usado para assistir a uma sessão do jogo gravado anteriormente do
	início ao fim. Para tornar as coisas consistentes, apague os
	arquivos de configuração ``.cfg``, NVRAM ``.nv`` e o cartão de
	memória.

	O valor predefinido é ``NULO`` (sem reprodução).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -playback perfect

.. note:: 

	Você pode ter problemas com a falta de sincronismo caso a
	configuração, a NVRAM, e o cartão de memória não coincidam com o
	original, inclusive caso seja utilizado uma versão do MAME muito
	diferente daquela usada na gravação. É recomendável que a
	configuração (.cfg), a NVRAM (.nv) ou o diretório com o nome da
	máquina dentro do diretório **nvram** sejam excluídos antes de
	iniciar uma gravação ou uma reprodução.

.. warning::

	Para que o playback funcione em algumas máquinas de alguns drivers,
	elas precisam da **NVRAM** como por exemplo a CPS1, a CPS2 e a CPS3,
	manter ou não o arquivo de configuração nestes casos não faz a menor
	diferença. Então caso você vá compartilhar a gravação com alguém,
	tenha certeza de enviar o arquivo **NVRAM** da máquina em questão.

.. warning::

	Em máquinas que não usam **NVRAM** como a packman, mspackman e
	talvez outras, elas também perdem o sincronismo e algumas vezes
	criam anomalias (bugs) apenas durante a reprodução, neste caso
	apague o arquivo que mantém o registro do **high score** dentro do
	diretório **hi**. Caso você mantenha um registro de pontuações, faça
	um backup antes de apagar o arquivo.

.. raw:: latex

	\clearpage

.. _mame-commandline-exitafterplayback:

**-[no]exit_after_playback**

	O MAME encerra a emulação ao final do arquivo de reprodução caso
	seja usado em conjunto com a opção **-playback**. É predefinido que
	o MAME não encerre a emulação.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -playback perfect -exit_after_playback

	O valor predefinido é ``Desligado`` (``-noexit_after_playback``).


.. _mame-commandline-record:

**-record** / **-rec** <*nome do arquivo*>

	Faz a gravação de todos comandos feitos pelo usuários durante uma
	seção e define o nome do arquivo onde será registrado todos esses
	comandos durante uma seção.
	Esse recurso não funciona de forma confiável com todos os sistemas.

	O valor predefinido é ``NULO`` (sem gravação).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -rec perfect


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

**-mngwrite** <*nome do arquivo*>.mng

	Escreve cada quadro de vídeo num arquivo <*nome do arquivo*> no
	formato MNG, produzindo uma animação da sessão.
	Note que ``-mngwrite`` só grava quadros de vídeo, não grava qualquer
	áudio, use a opção ``-wavwrite`` para gravar o áudio e
	posteriormente use uma ferramenta de edição de áudio qualquer para
	unir os dois, ou use ``-aviwrite`` para gravar áudio e vídeo num
	único arquivo.

	O valor predefinido é ``NULO`` (sem gravação).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -mngwrite ssf2tu-video.mng


.. _mame-commandline-aviwrite:

**-aviwrite** <*nome do arquivo*>.avi

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

	O valor predefinido é ``NULO`` (sem gravação).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -pb perfect -exit_after_playback -aviwrite ssf2tu.avi


.. _mame-commandline-wavwrite:

**-wavwrite** <*nome do arquivo*>.wav

	Grava apenas o áudio da seção em formato PCM 16 bits. Para gravar
	com uma taxa de amostragem diferente da predefinida (**48000 Hz**),
	consulte a opção :ref:`-samplerate <mame-commandline-samplerate>`.

	O valor predefinido é ``NULO`` (sem gravação).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -wavwrite audio.wav

.. raw:: latex

	\clearpage

Opções para a captura da tela
-----------------------------

.. _mame-commandline-snapname:

**-snapname** <*nome*>

	Descreve como MAME deve nomear arquivos de instantâneos de tela.
	<*nome*> será o guia que o MAME usará para nomear o arquivo.

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

		O valor predefinido é ``%g/%i``.

	Para os drivers que usam mídias diferentes, como cartões ou
	disquetes, também é possível usar ``%d_[media]``.
	Substitua ``[media]`` pelo dispositivo que deseja usar.

	Alguns exemplos:

	* Caso use ``mame robby -snapname foo/%g%i`` os instantâneos
	  serão salvos como ``snaps\foo\robby0000.png``,
	  ``snaps\foo\robby0001.png`` e assim por diante.

	* Caso use ``mame nes -cart robby -snapname %g/%d_cart`` os
	  instantâneos serão salvos como ``snaps\nes\robby.png``.

	* No caso deste outro exemplo,
	  ``mame c64 -flop1 robby -snapname %g/%d_flop1/%i`` estes serão
	  salvos como ``snaps\c64\robby\0000.png``.

.. _mame-commandline-snapsize:

**-snapsize** <*largura*> x <*altura*>

	Define um tamanho fixo para os instantâneos e vídeos.
	É predefinido que o MAME criará instantâneos, assim como os vídeos,
	na resolução original do sistema em pixels brutos. Caso use
	esta opção, o MAME criará instantâneos e vídeos no tamanho
	determinado, com filtro bilinear (filtro de embaçamento de pixels)
	aplicado no resultado final. Observe que ao definir este tamanho a
	tela não gira automaticamente caso o sistema seja orientado
	verticalmente.

	O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -snapsize 640x480

.. raw:: latex

	\clearpage


.. _mame-commandline-snapview:

**-snapview** <*tipo*>

	Define a visualização que será utilizada nas capturas da tela e para
	gravar os vídeos.

	É predefinido que ambos utilizem a primeira visualização que estiver
	disponível ou somente da primeira tela. Ao usar esta opção é
	possível alterar o comportamento predefinido da exibição e
	selecionar apenas a visualização que será aplicada em todos os
	instantâneos e vídeos.

	Observe que o <*tipo*> não precisa ser o nome exato,
	em vez disso, o MAME selecionará a primeira exibição cujo nome
	corresponda com o que for definido através do <*tipo*>, suponto
	que o nome seja **Cabine Animada** basta usar **Cabine** ou
	**cabine**.

	Por exemplo, ``-snapview native`` irá casar a visualização
	:guilabel:`Nativa em (15:14)` ainda que o nome não combine
	perfeitamente. O <*tipo*> também pode ser "auto" onde será escolhida
	a primeira exibição de todas que existirem.

	O valor predefinido é ``internal``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -snapview pixel


.. _mame-commandline-nosnapbilinear:

**-[no]snapbilinear**

	Especifique se o instantâneo ou vídeo deve ter filtragem bilinear
	aplicada, o filtro bilinear aplica um leve efeito de embaçamento ou
	suavização à tela, amenizando um pouco o serrilhado nos contornos
	gráficos e suavizando a tela do sistema. Desligar essa opção pode
	fazer a diferença melhorando o desempenho durante a gravação do
	vídeo.

	O valor predefinido é ``Ligado`` (``-snapbilinear``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nosnapbilinear

.. raw:: latex

	\clearpage

Opções relacionadas ao desempenho e a velocidade da emulação
------------------------------------------------------------


.. _mame-commandline-noautoframeskip:

**-[no]autoframeskip** / **-[no]afs**

	Para que se mantenha a velocidade máxima de uma emulação, ajusta
	dinamicamente no sistema emulado a quantidade de quadros que
	serão pulados. Ativando esta opção ela se sobrepõem ao que for
	definido em **-frameskip** descrito logo abaixo.

	O valor predefinido é ``Desligado`` (``-noautoframeskip``).

	Exemplo:
		.. code-block:: shell

			mame gradius4 -autoframeskip

.. _mame-commandline-frameskip:

**-frameskip** / **-fs** <*quantidade*>

	Determina a quantidade de quadros que são ignorados. Ela elimina
	cerca de 12 quadros enquanto estiver sendo executado. Caso seja
	definido ``-frameskip 2`` o MAME então exibirá 10 de cada 12
	quadros por exemplo.

	Ao ignorar estes quadros, pode ser que se atinja a velocidade
	nativa do sistema emulado sem que haja sobrecarga no seu computador
	ainda que ele não tenha um grande poder de processamento.

	O valor predefinido é não ignorar nenhum quadro (``-frameskip 0``).

	Exemplo:
		.. code-block:: shell

			mame gradius4 -frameskip 2

.. _mame-commandline-secondstorun:

**-seconds_to_run** / **-str** <*segundos*>

	Este comando pode ser usado para realizar um teste de velocidade de
	forma automatizada. O comando diz ao MAME para para interromper a
	emulação depois de alguns segundos. Ao combinar com outras opções
	fixas de linha de comando é possível definir um ambiente para
	realizar testes de desempenho. Ao encerrar, a opção ``-str``
	fará uma captura da tela com o nome determinado pela opção
	:ref:`-snapname <mame-commandline-snapname>`.

	O comando diz ao MAME para interromper a emulação depois de um
	tempo determinado, o tempo em questão não é o tempo real e sim o
	tempo interno da emulação, assim, caso seja definido 30 segundos,
	pode ser que dependendo da máquina que esteja sendo emulada, a parada
	só venha a acontecer depois de algum tempo.

	Este comando também é útil para a realização de benchmarks e testes
	de automação. Ao combinar esta opção com algumas outras, é possível
	construir uma estrutura de testes de desempenho do MAME.
	Adicionalmente a opção ``-str``, faz também que ao final do tempo
	seja criado uma captura da tela determinado pela opção ``-snapname``
	dentro da pasta dos
	:ref:`instantâneos <mame-commandline-snapshotdirectory>`.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -str 60

.. raw:: latex

	\clearpage


.. _mame-commandline-nothrottle:

**-[no]throttle**

	Ativa ou não a função de controle de velocidade do emulador [4]_.
	Ao ativar esta opção, o MAME tenta manter o sistema rodando em
	sua velocidade nativa, com a opção desabilitada a emulação é
	executada na velocidade mais rápida possível. Dependendo das
	características do sistema emulado, o desempenho final pode
	limitada pelo seu processador, placa de vídeo ou até mesmo pelo
	desempenho final da sua memória.

	O valor predefinido é ``Ligado`` (``-throttle``).

	Exemplo:
		.. code-block:: shell

			mame pacman -nothrottle


.. _mame-commandline-nosleep:

**-[no]sleep**

	Quando utilizada em conjunto com ``-throttle`` o MAME elimina
	os processos não utilizados durante a limitação de velocidade da
	emulação melhorando o rendimento de processamento. Em outras
	palavras, permite que outros programas tenham mais tempo de CPU
	assumindo que a emulação não esteja consumindo 100% dos recursos do
	processador. Esta opção pode causar uma certa intermitência no
	desempenho caso outros programas que também demandem processamento
	estejam rodando junto com o MAME.

	O valor predefinido é ``Ligado`` (``-sleep``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nosleep


.. _mame-commandline-speed:

**-speed** <*fator*>

	Muda a maneira que o MAME controla a velocidade da emulação de
	maneira que seja possível que o sistema emulado rode em múltiplos
	da sua velocidade original.

	Um <*fator*> ``1.0`` significa rodar o sistema em velocidade normal.
	Já um fator **0.5** significa rodar o sistema na metade da
	velocidade normal e um <*fator*> ``2.0`` significa rodar o sistema
	2x acima da sua velocidade normal. Note que ao mudar este valor a
	velocidade de execução do áudio irá mudar proporcionalmente também.

	A resolução interna da fração são dois pontos decimais, logo o
	valor **1.002** será arredondado para ``1.0``.

	O valor predefinido é ``1.0``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -speed 1.25

	Quando utilizado em conjunto com :ref:`-rec
	<mame-commandline-record>` é possível colocar o máquina em
	velocidade lenta como ``-speed 0.3`` enquanto grava. Ao terminar, a
	reprodução com a opção :ref:`-pb <mame-commandline-playback>`
	ocorrerá em velocidade normal, exemplo:

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -rec perfect -speed 0.3 -sound none

	A opção ``-sound none`` serve para eliminar o áudio durante a
	gravação em câmera lenta. Para mais informações, consulte
	:ref:`slowmomame <advanced-slowmomame>`.

.. raw:: latex

	\clearpage


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

	O valor predefinido é ``Desligado`` (``-norefreshspeed``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -refreshspeed


.. _mame-commandline-numprocessors:

**-numprocessors** / **-np** <*auto|valor*>

	Define a quantidade de núcleos do processador que serão utilizados.
	A opção ``auto`` usará a quantidade de núcleos informada pelo seu
	sistema ou pela variável de ambiente **OSDPROCESSORS**. Este valor é
	limitado internamente para quatro vezes o número dos processadores
	informado pelo seu sistema.

	O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -numprocessors 2

.. _mame-commandline-bench:

**-bench** <*n*>

	Define a quantidade de segundos de emulação em <*n*> usado para
	teste de desempenho, o comando é um atalho com comando abaixo:

	**-str** <*n*> **-video none -sound none -nothrottle**

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -bench 300

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

	O valor predefinido é ``-nolowlatency``.

	Exemplo:
		.. code-block:: shell

			mame bgaregga -lowlatency

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

	O valor predefinido é ``Ligado`` (``-rotate``).

	Exemplo:
		.. code-block:: shell

			mame pacman -norotate

.. _mame-commandline-noror:

.. _mame-commandline-norol:

**-[no]ror**
**-[no]rol**

	Rotacione a tela do sistema para a direita ``-ror`` ou para a
	esquerda ``-rol`` em relação ao seu estado normal caso ``-rotate``
	seja definido ou seu estado nativo caso ``-norotate`` seja
	definido.

	O valor predefinido para ambas é ``Desligado``
	(``-noror** **-norol``).

	Exemplo:
		.. code-block:: shell

			mame pacman -ror
			mame pacman -rol


.. _mame-commandline-noautoror:

.. _mame-commandline-noautorol:

**-[no]autoror**
**-[no]autorol**

	Essas opções são projetadas para uso com telas giratórias que giram
	apenas numa única direção. Caso a tela gire somente no sentido
	horário, use o comando ``-autorol`` para garantir que o sistema
	encha a tela horizontalmente ou verticalmente numa das direções
	desejadas. Caso a sua tela gire somente no sentido anti-horário,
	use ``-autoror``.

	Exemplo:
		.. code-block:: shell

			mame pacman -autoror
			mame pacman -autorol


.. _mame-commandline-noflipx:

.. _mame-commandline-noflipy:

**-[no]flipx**
**-[no]flipy**

	Espelhe a tela do sistema horizontalmente ``-flipx`` ou
	verticalmente ``-flipy``. As inversões são aplicadas depois que as
	opções de rotação ``-rotate`` e rolagem ``-ror/-rol`` forem
	aplicadas.

	O valor predefinido para ambas as opções é ``Desligado``
	(``-noflipx`` ``-noflipy``).

	Exemplo:
		.. code-block:: shell

			mame pacman -flipx
			mame pacman -flipy


.. raw:: latex

	\clearpage

Opções para a configuração de vídeo
-----------------------------------

.. _mame-commandline-video:

**-video** < ``bgfx`` | ``gdi`` | ``d3d`` | ``opengl`` | ``soft`` | ``accel`` | ``none`` >

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
	  utilizado para realizar testes de desempenho (*benchmarks*)
	  usando apenas a CPU.

**No Windows:**

.. _mame-commandline-video-gdi:

	* **gdi**

	  Diz ao MAME para renderizar o vídeo usando funções gráficas mais
	  antigas do Windows.
	  Em termos de desempenho é a opção mais lenta porém a mais
	  compatível com as versões os sistemas Windows mais antigos.

.. _mame-commandline-video-d3d:

	* **d3d**

	  Diz ao MAME para renderizar a tela com o **Direct3D**.
	  Isso produz uma saída com uma melhor qualidade se comparada com a
	  opção que o **gdi** assim como permite opções adicionais de
	  renderização da tela e aceleração gráfica via hardware.

	  É recomendável ter uma placa de vídeo mediana (2002+)
	  ou uma placa de vídeo Intel embutida modelo *HD3000* ou superior.

.. raw:: latex

	\clearpage

**Em outras plataformas (incluindo o SDL no Windows):**

.. _mame-commandline-video-accel:

	* **accel**

	  Diz ao MAME para, se possível, processar o vídeo usando a
	  aceleração 2D do SDL.

.. _mame-commandline-video-soft:

	* **soft**

	  Faz com que a tela seja renderizada através de software.
	  Por não usar nenhum tipo de aceleração de vídeo, o desempenho da
	  emulação pode ser penalizada, porém favorecendo uma melhor
	  compatibilidade em qualquer plataforma.

* **Predefinições:**

	No Windows é **d3d**.

	No macOS é **opengl** pois é quase certo que exista uma pilha
	OpenGL compatível.

	O valor predefinido para todos os outros sistemas é **soft**.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -video bgfx


.. _mame-commandline-numscreens:

**-numscreens** <*quantidade*>

	Diz ao MAME quantas telas devem ser criadas. Para a maioria dos
	sistemas só exite uma, porém alguns sistemas originalmente usavam
	mais de uma (*como as máquinas Darius e máquinas Arcade
	PlayChoice-10 por exemplo*). Cada tela (até 4), possem as suas
	próprias configurações, taxa de proporção de tela, resolução e
	exibição, que podem ser definidas usando as opções abaixo.

	O valor predefinido é ``1``.

	Exemplo:
		.. code-block:: shell

			mame darius -numscreens 3
			mame pc_cntra -numscreens 2


.. _mame-commandline-window:

**-[no]window** / **-[no]w**

	Inicia a tela do MAME numa janela em vez da tela inteira.

	O valor predefinido é ``Desligado`` (``-nowindow``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -window


.. _mame-commandline-maximize:

**-[no]maximize** / **-[no]max**

	Controla o tamanho inicial da janela. Caso esta opção seja ativada,
	durante a inicialização do MAME a janela será exibida com o maior
	tamanho possível. Com a opção desligada, a emulação terá início com
	o tamanho aproximado ao tamanho original do sistema, a sua escala
	será em apenas um eixo quando os pixeis não quadrados estiverem em
	uso. Esta opção apenas surte efeito quando a opção **-window** é
	utilizada.

	O valor predefinido é ``Ligado`` (``-maximize``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -window -maximize


.. raw:: latex

	\clearpage


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
	livremente para preencher os espaços vazios no modo janela. Em
	tela cheia a imagem ficará distorcida e fora das proporções.

	Quando essa opção estiver ativa no Windows e o MAME estiver em modo
	janela, a proporção de tela será mantido mesmo que 
	a janela seja redimensionada para diferente tamanhos, caso mantenha
	a tecla **Control** ou **Ctrl** pressionada durante
	redimensionamento da janela, a proporção será mantida.

	O valor predefinido é ``Ligado`` (``-keepaspect``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -ka

	A equipe do MAME, sugere veementemente que se mantenha esta opção
	ativada. Esticando a tela do sistema além da proporção original
	vai causar distorções na aparência do sistema que vai muito além da
	capacidade de reparo dos filtros internos do MAME.

.. raw:: latex

	\clearpage


.. _mame-commandline-unevenstretch:

**-[no]unevenstretch** / **-[no]ues**

	Permite que valores não inteiros possam ser usados para o
	redimensionamento da tela, isso faz com que a imagem possa ter uma
	forma mais distorcida ou esticada para que ela preencha toda a
	tela, porém há um preço a ser pago.

	O uso de valores não inteiros geram uma interferência chamada
	**aliasing** nos pixels [#aliasing]_ [#saaliasing]_. Imagine o mapa
	de um jogo feito de linhas retas com 1 pixel de largura, quando
	ocorre o "*aliasing*" a linha que originalmente era feita com 1
	pixel de largura passa a ter 2 pixels ou mais, essa interferência
	cria pixels aonde antes não existiam gerando distorções em **todos
	os pixels**. Abaixo um exemplo com destaque nas regiões marcadas com
	vermelho, porém nota-se que o problema afeta toda a imagem.

	.. image:: images/pixel-aliasing.png
		:width: 100%
		:align: center
		:alt: pixel-aliasing

	Atualmente as pessoas sentem a necessidade de preencher toda a tela
	de uma TV 16:9 com gráficos feitos para 4:3 ainda que isso gere
	distorções ao custo da desproporção dos gráficos.

	Este é um assunto bem complexo pois, apesar de todos os pixels do
	lado esquerdo estarem com os quadrados perfeitos, o que significa
	uma proporção dos pixels de 1:1, também conhecido como
	`pixel perfect <https://tanalin.com/en/articles/integer-scaling/>`_,
	a imagem está com as suas proporções erradas, na época os gráficos
	não foram desenvolvidos com os pixels no formato de um quadrado
	perfeito e sim para terem 1 pixel mais alto visando as telas CRT 4:3
	da época como mostra a imagem do lado direito.

	Assim, apesar dos pixels estarem distorcidos na imagem da direita a
	proporção dos gráficos está correta! Ao mesmo tempo que apesar dos
	pixels estarem perfeitos do lado esquerdo a proporção do gráfico
	está errada.
	
	Com esta opção é possível preencher a tela da sua TV 16:9 com
	gráficos desenvolvidos para uma tela 4:3 ao custo de distorções nos
	gráficos e isso fica pior ainda com textos.
	
	Consulte também :ref:`-aspect <mame-commandline-aspect>`, 
	:ref:`-keepaspect <mame-commandline-keepaspect>` e
	:ref:`-prescale <mame-commandline-prescale>`.

	O valor predefinido é ``Ligado`` (``-unevenstretch``).

	.. raw:: latex

		\clearpage

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nounevenstretch


.. _mame-commandline-unevenstretchx:

**-[no]unevenstretchx** / **-[no]uesx**

	Permite que a relação de aspecto da tela seja desigual e que a tela
	ou janela possa ser preenchida (esticada) apenas na horizontal.

	O valor predefinido é ``Ligado`` (``-unevenstretchx``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -uesx


.. _mame-commandline-unevenstretchy:

**-[no]unevenstretchy** / **-[no]uesy**

	Permite que a relação de aspecto da tela seja desigual e que a tela
	ou janela possa ser preenchida (esticada) apenas na vertical.

	O valor predefinido é ``Ligado`` (``-unevenstretchy``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -uesy


.. _mame-commandline-autostretchxy:

**-[no]autostretchxy** / **-[no]asxy**

	Aplica a opção **-unevenstretchx/y** automaticamente com base na
	orientação nativa da fonte.

	O valor predefinido é ``Desligado`` (``-noautostretchxy``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -asxy


.. _mame-commandline-intoverscan:

**-[no]intoverscan** / **-[no]ios**

	Permite que a imagem passe dos limites da tela (overscan) de alvos
	inteiros e dimensionáveis.

	O valor predefinido é ``Desligado`` (``-nointoverscan``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -ios


.. _mame-commandline-intscalex:

**-[no]intscalex** / **-[no]sx** <*fator*>

	Define o fator da escala para o preenchimento e a aproximação (zoom)
	da tela na horizontal, não causa aliasing nos pixels quando usado
	sozinho ou até o fator **4.0**. Causa aliasing mínimo nos pixels
	quando utilizado em conjunto com intscaley

	O valor predefinido é ``0.0`` (``-nointscalex 0.0``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -sx 1.0
			mame ssf2tu -nowindow -ka -sx 5.0 -sy 5.0

.. raw:: latex

	\clearpage

.. _mame-commandline-intscaley:

**-[no]intscaley** / **-[no]sy** <*fator*>

	Define o fator da escala para o preenchimento e a aproximação (zoom)
	da tela na vertical, não causa aliasing nos pixels quando usado
	sozinho ou até o fator **4.0**. Causa aliasing mínimo nos pixels
	quando utilizado em conjunto com intscalex.

	O valor predefinido é ``0.0`` (``-nointscaley 0.0``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -sy 1.0
			mame ssf2tu -nowindow -ka -sx 5.0 -sy 5.0


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
	ative esta opção caso esteja utilizando o modo janela. Em tela
	inteira esta opção só é necessária caso a opção ``-triplebuffer``
	não remova o indesejado efeito *"tearing"*, neste caso, tente usar
	as duas opções juntas ``-notriplebuffer -waitvsync``. Note que a
	opção ``-waitvsync`` não vai funcionar em conjunto com a opção
	``-video gdi``.

	No **macOS**, ``-waitvsync`` não é bloqueado, contudo o quadro
	completamente desenhado será exibido no próximo apagamento de vídeo
	(vblank). Isso quer dizer que caso um sistema emulado tenha uma taxa
	de quadros maior do que a do seu sistema (ou do seu monitor), haverá
	uma queda periódica na velocidade dos quadros de vídeo emulados
	resultando em pequenos travamentos durante as cenas com movimentos.

	O valor predefinido é ``Desligado`` (``-nowaitvsync``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -waitvsync

	O **MAME SDL** funcionará com essa opção em modo janela caso haja
	compatibilidade com o seu sistema operacional, da sua placa de vídeo
	e respectivos drivers.

	Rode o **MAME SDL** com a opção ``-video opengl`` para aumentar as
	suas chances de sucesso.


.. raw:: latex

	\clearpage


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

	O valor predefinido é ``Desligado`` (``-nosyncrefresh``).

	Exemplo:
		.. code-block:: shell

			mame mk -syncrefresh

	.. note::

		O syncrefresh pode ser útil para as pessoas com display
		compatível com G-Sync ou FreeSync.


.. _mame-commandline-prescale:

**-prescale** <*fator*>

	Controla a proporcionalidade da grandeza do redimensionamento do
	vídeo antes da aplicação de filtros ou shaders. No ajuste mínimo
	a tela é renderizada no seu tamanho original antes de ser
	dimensionada. Com valores maiores a tela é expandida pelo fator
	definido em <*fator*>. Isso gera imagens menos borradas com a
	opção ``-video d3d`` ao custo da perda de algum desempenho.

	Experimente ``-prescale 4`` ou valores maiores para amenizar um
	pouco as distorções causadas pela opção
	:ref:`-unevenstretch <mame-commandline-unevenstretch>`.

	Os valores válidos são ``1`` (mínimo) e ``8`` (máximo).

	O valor predefinido é ``1``.

	Funciona com todos os modos de vídeo no Windows (bgfx, d3d, etc),
	nas outras plataformas funciona **APENAS** naquelas que forem
	compatíveis com o OpenGL. Não funciona com filtros
	:ref:`GLSL <mame-commandline-glglslfilter>`.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -video d3d -prescale 3


.. _mame-commandline-filter:

**-[no]filter** / **-[no]d3dfilter** / **-[no]flt**

	Ativa o filtro bilinear, aplica um leve efeito de embaçamento ou
	suavização à tela, amenizando um pouco o serrilhado nos contornos
	gráficos e suavizando a tela do sistema.

	Quando desabilitado terá uma imagem pura e com aparência mais
	serrilhada, esta opção também ocasiona artefatos na tela em caso de
	redimensionamento. Caso não goste da aparência amaciada da imagem,
	tente incrementar o valor da opção ``-prescale`` em vez de desativar
	todos os filtros. Consulte também a opção
	:ref:`-gl_glsl_filter <mame-commandline-glglslfilter>`.

	O valor predefinido é ``Ligado`` (``-filter``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nofilter

	No Windows funciona com todos os modos de vídeo (bgfx, d3d, etc),
	nas outras plataformas **APENAS** aquelas compatíveis com OpenGL.


.. raw:: latex

	\clearpage


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
	``0.1`` e ``0.2`` que se misturam bem com o resto da tela.
	Os arquivos PNG gerados são gravados no diretório snap dentro do
	``systemname/burnin-<nome.da.tela>.png``.

	O valor predefinido é ``Desligado`` (``-noburnin``).

	Exemplo:
		.. code-block:: shell

			mame neogeo -burnin


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

	O valor predefinido é ``Desligado`` (``-noswitchres``).

	Exemplo:
		.. code-block:: shell

			mame kof97 -switchres -resolution 978x720

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
	O nome de cada tela do seu sistema pode ser identificado executando
	o MAME com a opção :ref:`-verbose <mame-commandline-verbose>`.
	Os nomes de cada tela geralmente estão no formato: *\\\\.\\DISPLAYn*
	no Windows e *screenN* no macOS e variantes do OpenGL como o Linux
	por exemplo, o **n** ou **N** é um número do monitor que estiver
	conectado.

	O valor predefinido para estas opções é ``auto``.
	O que significa que a primeira janela é colocada na primeira
	exibição, a segunda janela na segunda e assim por diante.

	Exemplo:
		.. code-block:: shell

			Windows
			mame pc_cntra -numscreens 2 -screen0 \\.\DISPLAY1 -screen1 \\.\DISPLAY2
			mame darius -numscreens 3 -screen0 \\.\DISPLAY1 -screen1 \\.\DISPLAY3 -screen2 \\.\DISPLAY2

			OpenGL (Mac, Linux, *nix)
			mame pc_cntra -numscreens 2 -screen0 screen0 -screen1 screen1
			mame darius -numscreens 3 -screen0 screen1 -screen1 screen3 -screen2 screen2


	Os parâmetros ``-screen0``, ``-screen1``, ``-screen2``, ``-screen3``
	são específicos para cada janela. Já o parâmetro ``-screen`` aplica
	a configuração à todas as janelas.
	As opções definidas para uma janela específica tem prioridade sobre
	às opções das outras janelas.


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

		O valor predefinido para essas opções é ``auto``.

	Significa que o MAME assume que a proporção de tela é proporcional
	ao número de pixels no modo de vídeo da área de trabalho para cada
	monitor.

	O parâmetro ``-aspect0``, ``-aspect1``, ``-aspect2`` e ``-aspect3``
	são específicos para cada janela. O parâmetro ``-aspect`` se aplica
	à todas as janelas.
	As opções definidas para uma janela específica tem prioridade sobre
	às opções das outras janelas. Consulte :ref:`-unevenstretch
	<mame-commandline-unevenstretch>`.

	Exemplo:
		.. code-block:: shell

			mame contra -aspect 16:9
			mame pc_cntra -numscreens 2 -aspect0 16:9 -aspect1 5:4

.. raw:: latex

	\clearpage


.. _mame-commandline-resolution:

**-resolution[0-3]** <*[largura_x_altura]@[taxa de atualização]*> / **-r[0-3]** <*[largura_x_altura]@[taxa de atualização]*>

	Define a resolução exata a ser exibida. No modo de tela cheia o MAME
	tentará usar a resolução solicitada. A largura e a altura são
	obrigatórias, a taxa de atualização é opcional.

	Caso seja omitido ou configurado para ``0``, o MAME determinará o
	modo automaticamente. Por exemplo, a opção ``-resolution 640x480``
	forçará a resolução de 640x480 porém o MAME escolherá a taxa de
	atualização por conta própria.

	Da mesma forma que ``-resolution 0x0@60`` obrigará que a taxa de
	atualização seja de 60 Hz, mas permite que o MAME escolha a
	resolução. O comando também funciona com "*auto*" e é equivalente a
	*0x0@0*.

	No modo janela essa resolução é usada para determinar o tamanho
	máximo para a janela. Essa opção também requer que seja usada a
	opção :ref:`-switchres <mame-commandline-switchres>` para ativar a
	comutação de resolução em conjunto com a opção **-video d3d**.

		O valor predefinido para essas opções é ``auto``.

	O parâmetro ``-resolution0``, ``-resolution1``, ``-resolution2`` e
	``-resolution3`` se aplica a todas as janelas definidas.
	O parâmetro ``-resolution`` se aplica a todas as janelas.
	As opções específicas da janela substituem os valores da opções de
	todas as janelas.

	Exemplo:
		.. code-block:: shell

			mame pc_cntra -numscreens 2 -resolution0 768x720 -resolution1 640x480


.. _mame-commandline-view:

**-view[0-3]** <*nome*>

	Define a configuração da visualização inicial de cada janela.
	Note que o nome de visualização <*nome*> não precisa
	ser uma combinação exata, em vez disso, será selecionado a primeira
	exibição cujo nome corresponde a todos os caracteres especificados
	por <*nome*>.
	Por exemplo, ``-view native`` representa uma visualização
	"Native (15:14)", ainda que não seja o nome exato, suponto que o
	nome seja **Cabine Animada** basta usar **Cabine** ou **cabine**.
	O campo <*nome*> também funciona com a opção ``auto`` fazendo com
	que um nome seja automaticamente escolhido.

		O valor predefinido para estas opções é ``auto``.

	Os parâmetros ``-view0``, ``-view1``, ``-view2`` e ``-view3`` se
	aplicam a todas as janelas especificadas. O parâmetro ``-view`` se
	aplica a todas as janelas.
	As opções definidas para a janela substituem os valores da opções de
	todas as janelas.
	
	Para identificar qual o nome correto para ser utilizado com a opção
	``-view``, ao iniciar a máquina pressione **TAB** e vá em
	**Opções de Vídeo**, escolha a visualização que mais lhe agrada e
	encerre a emulação. No diretório **cfg** haverá um arquivo de
	configuração com **nomedarom.cfg** (se usarmos o exemplo abaixo o
	nome do arquivo será ``neobombe.cfg``), abra-o num editor de texto
	qualquer, no campo **view** veja qual a opção está sendo usada e
	use-a na linha de comando como mostra o exemplo abaixo:

	Exemplo:
		.. code-block:: shell

			mame neobombe -view "Screen 0 Cropped (304x224)"

	Supondo que esta seja a sua opção de visualização preferida e caso
	queira que ela seja aplicada a todas as máquinas deste driver, no
	nosso caso, basta fazer o comando ``mame -ls neobombe`` para
	identificá-lo. Com o nome do driver em mãos crie o arquivo
	``neogeo.ini`` dentro do diretório **ini/source** e use a opção
	``view "Screen 0 Cropped (304x224)"``.

	Salve o arquivo e rode a máquina novamente sem a opção ``-view``,
	note que ela já começa com a opção de visualização selecionada.

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

	O valor predefinido é ``Desligado`` (``-noartwork_crop``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -artwork_crop

.. _mame-commandline-fallbackartwork:

**-fallback_artwork**

	Define uma ilustração alternativa caso nenhuma ilustração interna ou
	externa do layout seja definida. Caso a ilustração para o sistema
	esteja presente ou o seu layout esteja incluso no driver do sistema,
	então este terá precedência. ::

		mame coco -fallback_artwork suprmrio

.. _mame-commandline-overrideartwork:

**-override_artwork**

	Define uma ilustração para substituir a ilustração interna ou a
	ilustração externa do layout.

	Exemplo:
		.. code-block:: shell

			mame galaga -override_artwork puckman

.. raw:: latex

	\clearpage

Opções para os ajustes de imagem da tela
----------------------------------------

.. _mame-commandline-brightness:

**-brightness** <*valor*>

	Controla o valor de brilho ou nível de preto da tela.
	Essa opção não afeta a arte ou outras partes da tela. Usando a
	interface interna do MAME, é possível configurar o brilho para cada
	tela do sistema e para todos os sistemas individualmente.
	Ao selecionar valores menores (não menor que ``0.1``) produzirá uma
	tela mais escura, enquanto valores maiores até ``2.0`` produzirão
	uma tela mais clara.

	O valor predefinido é ``1.0``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -brightness 0.5

.. _mame-commandline-contrast:

**-contrast** <*valor*>

	Controla o contraste da tela ou os nível de branco da tela.
	Essa opção não afeta a arte ou outras partes da tela. Usando a
	interface interna do MAME, é possível configurar o brilho para cada
	tela do sistema e para todos os sistemas individualmente.
	Essa opção define o valor inicial de todas as telas visíveis de
	todos os sistemas.
	Selecionando valores (não menor que ``0.1``) produzirá uma tela mais
	apagada, enquanto valores maiores até ``2.0`` produzirão uma tela
	mais saturada.

	O valor predefinido é ``1.0``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -contrast 0.5

.. _mame-commandline-gamma:

**-gamma** <*valor*>

	Controle de gamma, ajusta a escala de luminância da tela. Essa opção
	não afeta a arte ou outras partes da tela. Usando a interface
	interna do MAME, é possível configurar o gamma para cada tela do
	sistema e para todos os sistemas individualmente. Essa opção define
	o valor inicial de todas as telas visíveis de todos os sistemas.
	Essa configuração oferece um ajuste de luminância linear de preto
	para o branco. Ao selecionar valores menores (até ``0.1``)
	trará a luminância mais para o preto, enquanto valores maiores
	(até **3.0**) empurrarão essa luminância para o branco.

	O valor predefinido é ``1.0``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -gamma 0.8

.. _mame-commandline-pausebrightness:

**-pause_brightness** <*valor*>

	Faz o controle do nível de brilho durante a pausa.

	O valor predefinido é ``0.65``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -pause_brightness 0.33

.. raw:: latex

	\clearpage


.. _mame-commandline-effect:

**-effect** <*nome do arquivo*>

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
	terminar:

	Exemplo:
		.. code-block:: shell

			effect          RealScanlinesV

	Para o arquivo ``horizont.ini`` adicione a linha abaixo e salve ao
	terminar:

	Exemplo:
		.. code-block:: shell

			effect          RealScanlinesH

	Consulte :ref:`Opções para a configuração
	<mame-commandline-noreadconfig>` para saber quais os arquivos
	``.ini`` estão disponíveis.

	Para os modos de vídeo ``-video gdi`` e ``-video d3d`` significa que
	um pixel dentro do ``.png`` será mapeado para um pixel da sua tela.
	Os valores RGB de cada pixel dentro do ``.png`` são multiplicados
	com os valores de RGB da tela de destino. Ambos os arquivos
	``RealScanlinesV`` e ``RealScanlinesH`` estão disponíveis no `site
	do projeto <https://github.com/wtuemura/mamedoc/tree/master/artwork>`_.

	O valor predefinido é ``none`` ou nenhum efeito.

	Exemplo:
		.. code-block:: shell

			Para efeito Horizontal
			mame ssf2tu -effect RealScanlinesH
			
			Para efeito Vertical
			mame bgaregga -effect RealScanlinesV

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

**-beam_width_min** <*largura*>

	Define a espessura mínima do feixe do vetor. Esta espessura varia
	entre mínimo e máximo à medida que a intensidade do traçado do vetor
	muda. Para desativar as alterações da largura do vetor com base na
	intensidade, defina o mesmo valor para ``-beam_width_max`` e
	``-beam_width_min``.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_width_min 0.1


.. _mame-commandline-beamwidthmax:

**-beam_width_max** <*largura*>

	Define a espessura máxima do feixe do vetor. Esta espessura varia
	entre mínimo e máximo à medida que a intensidade do traçado do vetor
	muda. Para desativar as alterações da largura do vetor com base na
	intensidade, defina o mesmo valor para ``-beam_width_max`` e
	``-beam_width_min``.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_width_max 2


.. _mame-commandline-beamdotsize:

**-beam_dot_size** <*tamanho*>

	Fator de escala que será aplicado ao tamanho dos pontos nos jogos
	vetoriais com ponto único. Normalmente estes são renderizados de
	acordo com a largura do feixe computado, no entanto, é comum que
	isto produza pontos que sejam difíceis de se ver. Esta opção aplica
	um fator de escala no topo da largura do feixe para que estes fiquem
	mais visíveis.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_dot_size 2


.. _mame-commandline-beamintensityweight:

**-beam_intensity_weight** <*altura*>

	Define a intensidade do feixe do vetor. Este valor determina como
	a intensidade afeta a sua largura, o valor ``0`` (zero) cria um
	mapeamento linear a partir da intensidade da sua largura. Os valores
	negativos fazem com que os vetores com menor intensidade aumentem a
	sua largura máxima de forma mais rápida, enquanto valores positivos
	o farão de forma mais lenta.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_intensity_weight 0.5


.. _mame-commandline-flicker:

**-flicker** <*valor*>

	Simula um vetor de efeito de *tremulação* ou oscilação da tela
	semelhante aos monitores desregulados usados nos jogos vetoriais.
	Essa opção espera um valor flutuante (float) no intervalo
	entre ``0.00`` e ``100.00`` (``0`` = nenhum e ``100`` = máximo).

	O valor predefinido é ``0``.

	Exemplo:
		.. code-block:: shell

			mame asteroid -flicker 0.15

.. raw:: latex

	\clearpage

Opções para a depuração de vídeo OpenGL
---------------------------------------

Essas são as opções compatíveis com ``-video opengl``.
Caso note artefatos renderizados na tela, poderá ser solicitado
pelos desenvolvedores que você tente alterá-los, porém normalmente estes
valores devem ser mantidos com seus valores originais para que se
obtenha a melhor desempenho possível.

.. _mame-commandline-glforcepow2texture:

**-[no]gl_forcepow2texture**

	Sempre utilize a potência de 2 para o tamanhos das texturas.

		O valor predefinido é ``Desligado``
		(``-nogl_forcepow2texture``).

.. _mame-commandline-glnotexturerect:

**-[no]gl_notexturerect**

	Não use o *OpenGL GL_ARB_texture_rectangle*

		O valor predefinido é ``Ligado`` (``-gl_notexturerect``).

.. _mame-commandline-glvbo:

**-[no]gl_vbo**

	Ative o *OpenGL VBO* (Vertex Buffer Objects) caso esteja disponível.

		O valor predefinido é ``Ligado`` (``-gl_vbo``).

.. _mame-commandline-glpbo:

**-[no]gl_pbo**

	Ativar o *OpenGL PBO* (Pixel Buffer Objects) caso esteja disponível.

		O valor predefinido é ``Ligado`` (``-gl_pbo``).

.. raw:: latex

	\clearpage

Opções de vídeo OpenGL GLSL
---------------------------

.. _mame-commandline-glglsl:

**-[no]gl_glsl**

	Ativar o *OpenGL GLSL* caso esteja disponível.

	O valor predefinido é ``Desligado`` (``-nogl_glsl``).

	Exemplo:
		.. code-block:: shell

			mame galaxian -gl_glsl


.. _mame-commandline-glglslfilter:

**-gl_glsl_filter** <*valor*>

	Ativa a interpolação da imagem **OpenGL GLSL**, os valores
	válidos [6]_ são:

	* ``0``, Simples: Método de interpolação rápida e menos precisa que
	  deixa os pixels de forma serrilhada pois utiliza a técnica de
	  interpolação do
	  `vizinho mais próximo <https://pt.wikipedia.org/wiki/Interpolação_por_vizinho_mais_próximo>`_.
	* ``1``, Bilinear: Método de interpolação lenta e de qualidade
	  mediana, suaviza a transição entre as cores dos pixels deixando a
	  imagem mais suavizada como um todo. Veja também
	  :ref:`-filter <mame-commandline-filter>`.
	* ``2``, Bicúbico: Método de interpolação lenta e mais precisa,
	  suaviza a transição entre as cores dos pixels próximos gerando uma
	  gradação mais suave. Também suaviza a imagem porém nem tanto como
	  o método bilinear.

	O valor predefinido é ``1`` (``-gl_glsl_filter 1``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -gl_glsl -gl_glsl_filter 0

.. _mame-commandline-glslshadermame:

|	**-glsl_shader_mame0**
|	**-glsl_shader_mame1**
|	...
|	**-glsl_shader_mame9**

	Define um efeito shader personalizado do OpenGL GLSL do MAME no
	slot fornecido entre (``0-9``). É possível aplicar um para a cada
	slot. O MAME não incluí nenhum shader por alguns podem ser
	encontrados online, como no
	`mameau <https://www.mameau.com/linux/mame-glsl-shaders-setup/>`_ e
	no `mameworld <https://www.mameworld.info/ubbthreads/showflat.php?Cat=&Number=368803&page=&view=&sb=5&o=&vc=1>`_.

	Exemplo:
		.. code-block:: shell

			mame mpatrol -gl_glsl -gl_glsl_filter 0 -glsl_shader_mame0 glsl/osd/CRT-geom -resolution 992x756


.. _mame-commandline-glslshaderscreen:

| **-glsl_shader_screen0**
| **-glsl_shader_screen1**
| ...
| **-glsl_shader_screen9**

	Define um efeito shader personalizado do OpenGL GLSL do MAME que for
	escalada na tela para ser processada através da sua placa de vídeo
	no slot fornecido entre (``0-9``). Como no exemplo anterior, o MAME
	não incluí nenhum shader.

	Exemplo:
		.. code-block:: shell

			mame suprmrio -gl_glsl -glsl_shader_screen0 gaussx -glsl_shader_screen1 gaussy -glsl_shader_screen2 CRT-geom-halation


.. _mame-commandline-glglslvidattr:

**-gl_glsl_vid_attr**

	Ative o manuseio do GLSL em OpenGL de brilho e contraste.
	Melhor desempenho do sistema RGB.

	O valor predefinido é ``Ligado`` (``-gl_glsl_vid_attr``).

	Exemplo:
		.. code-block:: shell

			mame pacman -gl_glsl -gl_glsl_vid_attr off

.. raw:: latex

	\clearpage

Opções para a configuração do áudio
-----------------------------------

.. _mame-commandline-samplerate:

**-samplerate** <*valor*> / **-sr** <*valor*>

	Define a taxa de amostragem do áudio. Valores menores como ``11025``
	por exemplo, reduzem a qualidade da áudio porém o desempenho da
	emulação melhora.
	Valores maiores que ``48000``, aumentam a qualidade do áudio ao
	custo da perda do desempenho da emulação.

	O valor predefinido é ``48000`` (``-samplerate 48000``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -samplerate 44100

.. _mame-commandline-nosamples:

**-[no]samples**

	Usar arquivos de amostras caso estejam disponíveis. Esses arquivos
	são gravações de efeitos de áudio usados por algumas máquinas.

	O valor predefinido é ``Ligado`` (``-samples``).

	Exemplo:
		.. code-block:: shell

			mame qbert -nosamples

.. _mame-commandline-nocompressor:

**-[no]compressor**

	Ativa a compressão do áudio. Ele reduz temporariamente o volume
	total quando a saída do áudio é acionada de forma excessiva.

	O valor predefinido é ``Ligado`` (``-compressor``).

	Exemplo:
		.. code-block:: shell

			mame popeye -nocompressor

.. _mame-commandline-volume:

**-volume** / **-vol** <*valor*>

	Define o volume inicial. Pode ser alterado posteriormente usando
	a interface do usuário.
	O valor do volume está definido em decibéis (dB): Por exemplo,
	``-volume -12`` começará com uma atenuação de **-12 dB** no volume
	do áudio.

	O valor predefinido é ``0`` (``-volume 0``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -volume -30

.. _mame-commandline-speakerreport:

**-speaker_report** <*valor*>

	Imprime um relatório na tela dizendo se houve ou não um ceifamento
	ou *"clipping"* da onda gerada pela saída de áudio no alto-falante.
	Este ceifamento causa distorções no áudio devido a saturação do
	sinal, tornando as curvas de uma onda senoide numa onda quadrada.
	
	Os valores válidos são:

	* **nível 1**: relate apenas se houve clipping.
	* **nível 2**: relate a máxima geral, ainda que não haja qualquer clipping.
	* **nível 3**: imprima uma lista detalhada de todos os momento que houveram clipping.
	* **nível 4**: imprima uma lista detalhada de tudo.

	O valor predefinido é ``Desligado``.

	Exemplo:
		.. code-block:: shell

			mame robocop -speaker_report 2
			Speaker ":mono" - max = 51586 (gain *= 0.635) - clipped in 30/735 (4%) buckets

	.. note:: Este comando não tem utilidade prática para o usuário,
	          serve apenas como uma ferramenta para os desenvolvedores
	          do MAME.

.. _mame-commandline-sound:

**-sound** < ``auto`` | ``dsound`` | ``sdl`` | ``coreaudio`` | ``xaudio2`` | ``portaudio`` | ``none`` >

	Define qual o tipo de saída de áudio usar, Ao usar ``none`` desativa
	o áudio completamente porém o hardware de áudio continua sendo
	emulado. Abaixo as opções disponíveis para cada sistema operacional.

	As versões especiais como o **SDLMAME** para Windows, pode usar a
	opção ``sdl`` e ter o **portaudio** desabilitado. O binário oficial
	do MAME para Windows não é compilado com SDL, sendo necessário
	compilar uma versão compatível para que a opção ``sdl`` funcione.

	O valor predefinido é ``dsound`` no Windows, no Mac é
	``coreaudio`` nas outras plataformas é ``sdl``.

	No Windows e no Linux a opção ``portaudio`` provavelmente dará uma
	menor latência possível, enquanto no Mac a opção ``coreaudio``
	oferecerá os melhores resultados.

	Exemplo:
		.. code-block:: shell

			mame sf2tu -sound portaudio

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


.. _mame-commandline-audiolatency:

**-audio_latency** <*valor*>

	Nesta opção, latência significa o tempo que o dispositivo de áudio
	demora para responder a um comando. Essa opção ajusta a quantidade
	dessa latência incorporada ao fluxo de dados de áudio.

	O comportamento exato depende do módulo da saída de áudio
	selecionada.
	Os valores menores oferecem um menor atraso no áudio enquanto exige
	um desempenho maior do seu sistema. Valores maiores incrementam o
	atraso do áudio porém ajudam a evitar o esvaziamento da memória
	intermediária (buffer) e as interrupções do áudio.

	Os valores válidos ficam entre ``0`` e ``5``, o valor predefinido é
	``2``.

	Exemplo:
		.. code-block:: shell

			mame galaga -audio_latency 1

.. raw:: latex

	\clearpage

.. note::

	| Para PortAudio, consulte :ref:`-pa_latency <mame-commandline-pa_latency>`.
	| O XAudio2 calcula a latência do áudio com passos de ``10ms``.
	| O DSound calcula a latência do áudio com passos de ``10ms``.
	| O CoreAudio calcula a latência do áudio com passos de ``25ms``.
	| O SDL calcula a latência do áudio com passos de ``10ms``.


.. _mame-commandline-pa_api:

**-pa_api** <*interface*>

	*PortAudio* é um novo recurso adicionado na versão `0.182
	<https://www.mamedev.org/?p=436>`_ do MAME, o *PortAudio* é uma
	*API*, "*Application Programming Interface*" ou numa tradução livre
	"*Interface de Programação para Aplicações*". A *API* funciona como
	uma ponte conectando aplicações ao hardware de forma direta. Essa
	integração permite uma menor latência por haver uma redução no fluxo
	de dados e por estes dados de áudio serem direcionados diretamente
	ao dispositivo áudio, o desempenho é otimizado de maneira geral
	pois o que se salva em processamento no áudio pode ser aproveitado
	pelo MAME em outros setores da emulação.

	Apesar do *PortAudio* ser o que há de mais moderno em comparação com
	o *DirectSound* ou *OpenGL Audio* e trazer muitos benefícios, há um
	ponto negativo, o *PortAudio* faz o uso exclusivo do dispositivo de
	áudio.
	Isso significa que não será possível por exemplo, escutar música ou
	qualquer outra coisa enquanto o MAME estiver rodando com
	*PortAudio*.

	No Windows Vista ou mais recente nós temos essas interfaces:

	* **MME**: É um acrônimo para *Multimedia Extension* criada pela
	  Microsoft para um sistema operacional pouco conhecido na época
	  chamado "*Windows with MultiMedia Extensions 1.0*" com base no
	  **Windows 3.0**, é um dos primeiros API para comunicação direta
	  com a placa de áudio. Essa interface já é obsoleta porém ainda
	  muito usada por questões de compatibilidade.

	* **Windows DirectSound**: É uma outra *API* introduzida pela
	  *Microsoft* no **Windows 95** que adicionou uma camada de software
	  entre a aplicação e o dispositivo de som. Com ele uma placa de som
	  poderia ter dois canais ou mais, efeitos de som 3D foi uma
	  novidade na época, aceleração de áudio via hardware, a placa de
	  som poderia ser compartilhada entre diferentes aplicativos. Essa
	  interface já é obsoleta porém ainda muito usada por questões de
	  compatibilidade.

	* **Windows WASAPI**: É um acrônimo para "*Windows Audio Session
	  API*" ou numa tradução livre, "*API da seção de áudio do
	  Windows*". Foi introduzido no **Windows Vista**, a grande vantagem
	  do *WASAPI* é poder enviar os fluxos de dados de áudio direto para
	  o dispositivo de áudio sem ter que passar por nenhum tipo de
	  *CODEC* (codificador / decodificador).
	  Outra característica do *WASAPI* é ter o uso exclusivo do
	  dispositivo de áudio melhorando a latência assim como a qualidade
	  do áudio.

	* **Windows WDM-KS**: É um acrônimo para "*Windows Driver Model*"
	  também criado pela *Microsoft* e introduzido no **Windows 98** e
	  no **Windows 2000**. O *KS* vem de "*Kernel Streaming*" uma
	  maneira ainda mais rápida de acessar o dispositivo de áudio de
	  forma direta através do cerne (kernel) do *Windows*. Apesar de
	  também fazer uso exclusivo do dispositivo de áudio essa é a
	  interface mais problemática pois ela é muito dependente da
	  qualidade dos drivers usados, gera problemas com a hibernação do
	  *Windows* quando há problemas com os drivers, a melhor opção é
	  ficar com o *Windows WASAPI*.

	Para escolher qual interface usar, inicie o mame como mostra o
	exemplo abaixo:

	Exemplo:
		.. code-block:: shell

			mame -verbose -sound portaudio

	No Windows dentre as várias informações que aparecerão no terminal
	as mais relevantes para nós serão estas:

	Exemplo:
		.. code-block:: shell

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
	estejamos usando o mesmo hardware acima:

	Exemplo:
		.. code-block:: shell

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

	O valor predefinido é ``NULO`` (Nenhuma interface *PortAudio*).


.. _mame-commandline-pa_device:

**-pa_device** <*dispositivo*>

	Define qual o dispositivo de áudio usar, assim como mostrado em
	:ref:`-pa_api <mame-commandline-pa_api>`, escolha um dos
	dispositivos listados. O nome do dispositivo fica do lado direito da
	lista e entre aspas. Usando o exemplo para o Windows nós usaremos:

	Exemplo:
		.. code-block:: shell

			mame -verbose -sound portaudio -pa_api "Windows WASAPI" -pa_device "6 - SONY TV  *01 (AMD High Definition Audio Device)"

	Já para Linux o comando também não é muito diferente para o mesmo
	dispositivo:

	Exemplo:
		.. code-block:: shell

			./mame -verbose -sound portaudio -pa_api ALSA -pa_device "HDA ATI HDMI: 0 (hw:1,3)"

	Como resultado o MAME deverá exibir a mensagem abaixo mostrando que
	tanto a interface quanto o dispositivo foram aceitos:

	Exemplo:
		.. code-block:: shell

			PortAudio: Using device "6 - SONY TV  *01 (AMD High Definition Audio Device)" on API "Windows WASAPI"

	E aqui o mesmo para Linux:

	Exemplo:
		.. code-block:: shell

			PortAudio: Using device "HDA ATI HDMI: 0 (hw:1,3)" on API "ALSA"
			PortAudio: Sample rate is 48000 Hz, device output latency is 8.00 ms

	Caso nenhum seja definido o MAME escolherá o dispositivo padrão ou
	que estiver disponível.

	O valor predefinido é ``NULO`` (Nenhuma dispositivo *PortAudio*).

.. raw:: latex

	\clearpage

.. _mame-commandline-pa_latency:

**-pa_latency** <*segundos*>

	Escolha o tamanho em segundos da memória intermediária para a saída
	do PortAudio. Números menores tem um menor atraso porém aumenta os
	cortes no som. Os números em pontos decimais são compatíveis. Tente
	começar com valores como **0.20** aumentando ou reduzindo o valor
	até encontrar o valor correto que funcione melhor com o seu hardware
	e o seu Sistema Operacional.

	O valor predefinido é ``0``.

	Exemplo:
		.. code-block:: shell

			mame -verbose -sound portaudio -pa_api "Windows WASAPI" -pa_device "6 - SONY TV  *01 (AMD High Definition Audio Device)" -pa_latency 0.20

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

	O valor predefinido é ``Ligado`` (``-coin_lockout``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -coin_lockout

.. _mame-commandline-ctrlr:

**-ctrlr** <*controle*>

	Define um arquivo de configuração personalizada do controle,
	normalmente usado para definir novas atribuições das entradas
	predefinidas. Todos os diretórios definidos em ``ctrlrpath`` são
	pesquisados. Os arquivos de configuração do controle utilizam um
	formato similar ao ``.cfg`` que é utilizado para gravar as
	configurações do sistema. Estes arquivos são criados durante a
	configuração dos botões do controle de uma máquina, estas
	configurações são gravadas no diretório **cfg** como
	(nome_da_maquina).cfg. Para mais informações, consulte o capítulo
	:ref:`ctrlrcfg` e o capítulo :ref:`advanced-tricks-botões-ordem`.

	O valor predefinido é ``NULO`` (nenhum arquivo de configuração).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -ctrlr 6-botoes


.. _mame-commandline-nomouse:

**-[no]mouse**

	Controla se o MAME faz uso ou não dos controladores do mouse.
	Se estiver ligado, o mouse ficará reservado para uso exclusivo do
	MAME até que a emulação seja pausada ou que a a emulação seja
	encerrada.

	O valor predefinido é ``Desligado`` (``-nomouse``).

	Exemplo:
		.. code-block:: shell

			mame centiped -mouse


.. _mame-commandline-nojoystick:

**-[no]joystick** / **-[no]joy**

	Controla se o MAME usa ou não os controles do joystick/gamepad.
	Se estiver ligado o MAME perguntará ao *DirectInput* sobre quais
	controles estão conectados atualmente.

	O valor predefinido é ``Desligado`` (``-nojoystick``).

	Exemplo:
		.. code-block:: shell

			mame mappy -joystick


.. raw:: latex

	\clearpage


.. _mame-commandline-nolightgun:

**-[no]lightgun** / **-[no]gun**

	Controla se o MAME usa ou não os controles da arma de luz
	(lightgun). Observe que a maioria das armas de luz são mapeadas
	para o mouse, assim, ao se usar ambas as opções ``-lightgun`` e
	``-mouse`` juntos, isso pode poderá trazer resultados inesperados.
	Para mais informações, consulte o capítulo
	:ref:`arma-luz-funcionamento`.

	O valor predefinido é ``Desligado`` (``-nolightgun``).

	Exemplo:
		.. code-block:: shell

			mame lethalen -lightgun


.. _mame-commandline-nomultikeyboard:

**-[no]multikeyboard** / **-[no]multikey**

	Determina se o MAME diferencia entre os vários teclados disponíveis.
	Alguns sistemas podem reportar mais de um teclado; por padrão, os
	dados de todos esses teclados são combinados para que pareçam um só.
	Ativando essa opção permitirá que o MAME retorne quais teclas foram
	pressionadas em diferentes teclados de maneira independente.

	O valor predefinido é ``Desligado`` (``-nomultikeyboard``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -multikey


.. _mame-commandline-nomultimouse:

**-[no]multimouse**

	Determina se o MAME diferencia entre os vários mouses disponíveis.
	Alguns sistemas podem reportar mais de um dispositivo de mouse;
	por padrão, os dados de todos esses mouses são combinados para que
	pareçam um só. Ativando esta opção fará com que o MAME relate o
	movimento e o pressionar de botões do mouse em diferentes mouses de
	maneira independente.

	O valor predefinido é ``Desligado`` (``-nomultimouse``).

	Exemplo:
		.. code-block:: shell

			mame warlords -multimouse


.. _mame-commandline-nosteadykey:

**-[no]steadykey** / **-[no]steady**

	Alguns sistemas exigem que dois ou mais botões sejam pressionados
	exatamente ao mesmo tempo para realizar movimentos ou comandos
	especiais. Devido a limitação do hardware do teclado, pode ser
	difícil ou até mesmo impossível de realizar usando um teclado comum.
	Essa opção seleciona diferentes modos de manuseio o que torna mais
	fácil registrar o pressionamento simultâneo das teclas, porém tem a
	desvantagem de deixar a sua capacidade de resposta mais lenta.

	O valor predefinido é ``Desligado`` (``-nosteadykey``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -steadykey


.. raw:: latex

	\clearpage


.. _mame-commandline-uiactive:

**-[no]ui_active**

	Ativa a opção para que a interface do usuário se sobreponha a do
	teclado emulado caso esteja presente.

	O valor predefinido é ``Desligado`` (``-noui_active``).

	Exemplo:
		.. code-block:: shell

			mame apple2e -ui_active


.. _mame-commandline-nooffscreenreload:

**-[no]offscreen_reload** / **-[no]reload**

	Controla se o MAME trata o segundo botão da arma de luz
	(lightgun) como um sinal para recarregar a arma. Neste caso, o MAME
	reportará a posição da arma como (**0,MAX**) com o gatilho
	pressionado, o que é o equivalente a uma recarga da arma com ela
	apontada para fora da tela. Isso só é necessário para jogos que
	precisam que o usuário atire para fora da tela para recarregar a
	arma e se também a sua arma não tiver essa funcionalidade.

	O valor predefinido é ``Desligado`` (``-nooffscreen_reload``).

	Exemplo:
		.. code-block:: shell

			mame lethalen -offscreen_reload

.. raw:: latex

	\clearpage


.. _mame-commandline-joystickmap:

**-joystick_map** / **-joymap** <*mapa*>

	Controla como os valores do joystick analógico são mapeados para os
	controles num joystick digital.

	Sistemas como o Pac-Man utilizam um controle digital com quatro
	posições (4-way joystick) que exibe um comportamento inapropriado
	quando a diagonal é acionada, o Pac-Man simplesmente para nos
	cruzamentos do mapa fazendo com que seja quase que impossível
	jogá-lo direito ou pelo menos, da maneira que ele foi desenvolvido
	para ser jogado. Outras máquinas arcade utilizam controles digitais
	do tipo 4-way ou 8-way (em vez de utilizarem controles analógicos),
	assim para controles analógicos como os utilizados em máquinas de
	voo com manches ou thumb sticks analógicos, estes precisam ser
	mapeados para valores correspondentes aos controles digitais
	com 4 ou 8 posições.

	Para tanto o MAME divide o alcance do controle analógico numa grade
	com 9x9 muito semelhante ao desenho abaixo:

	.. image:: images/9x9grid.svg
		:width: 50%
		:align: center
		:alt: Grade 9x9

	O MAME então toma a posição do eixo do joystick (apenas os valores
	nos eixos X e Y), mapeia para esta grade e então monitora a tradução
	a partir do mapa do joystick. Este parâmetro permite que você defina
	tal mapa.

	Como por exemplo, um joystick com 8 posições geralmente se assemelha
	com a imagem abaixo:

	.. image:: images/8way.svg
		:width: 50%
		:align: center
		:alt: Joystick com 8 posições

	Este mapeamento oferece uma grande margem de manobra para os ângulos
	aceitos numa determinada direção, assim sendo bem próximo da área
	da direção desejada. Sem isso, caso esteja um pouco fora do eixo
	central enquanto segura o controle para a esquerda, a máquina não
	vai reconhecer a ação de forma adequada.

	O valor predefinido é ``auto``, significa que o controle padrão com
	4, 8 posições ou um mapa diagonal para um controle com 4 posições é
	selecionado de forma automática com base na informação da
	configuração da porta de entrada do sistema atual.

	Caso queira configurar a opção ``-joystick_map`` de forma individual
	através do ``<sistema>.ini`` em vez da configuração do ``mame.ini``
	para que tais configurações afetem apenas os sistemas que precisem
	destes mapeamentos, consulte a seção :ref:`Múltiplos arquivos de
	configuração <advanced-multi-CFG>` para mais detalhes.

	Os mapeamentos são definidos como uma cadeia de caracteres e
	números. Uma vez que a grade possui 9x9, existem 81 caracteres no
	total para que seja possível definir um mapa completo. Abaixo é um
	exemplo de um mapa para um joystick com 8 posições que coincide com
	a imagem anterior.

	.. image:: images/joymap.svg
		:width: 100%
		:align: center
		:alt: exemplo mapa 8 posições

	Para definir um mapa com estes parâmetros informe a cadeia de
	caracteres com as linhas separadas por um ponto '.' (que indica o
	final de uma linha):

	Exemplo:
		.. code-block:: shell

			-joymap 777888999.777888999.777888999.444555666.444555666.444555666.111222333.111222333.111222333


	Contudo é possível reduzir o tamanho do comando utilizando-se de
	atalhos compatíveis com o parâmetro <*mapa*>. Caso falte uma
	informação sobre uma linha, se deduz então que qualquer dado
	que falte nas colunas 5-9 sejam simétricos com a posição
	esquerda/direita em relação com os dados das colunas 0-4; assim
	como, qualquer dado que falte nas colunas 0-4 é deduzido que sejam
	cópias dos dados anteriores. A mesma lógica se aplica para as
	linhas faltantes, exceto quando se assume a simetria cima/baixo.

	Ao utilizar esta forma abreviada os 81 caracteres deste mapa podem
	ser simplificados para uma cadeia com 11 caracteres: 7778...4445 (
	significa que podemos utilizar o comando **-joymap 7778...4445**)

	Olhando na primeira fileira, o 7778 tem o comprimento de apenas 4
	caracteres. Não é possível utilizar a simetria na 5ª entrada,
	se deduz então que seja igual ao caractere anterior, '8'. O 6º
	caractere é simétrico com a posição esquerda/direita em conjunto com
	o 4º caractere, dando um '8'. O 7º caractere é simétrico com a
	posição esquerda/direita em conjunto com o 3º caractere, dando um
	'9' (que é '7' com os lados esquerdo/direito invertido). Por fim,
	retorna o conjunto completo da linha **777888999**.

	As carreiras dois e três estão faltando, se deduz então que sejam
	idênticos à 1ª linha. A 4ª carreira é decodificada de forma
	semelhante à 1ª gerando 444555666. A 5ª carreira está faltando,
	se deduz então que seja a mesma que a 4ª.

	O resto das 3 carreiras também estão faltando, então deduz-se que
	sejam espelhos do sentido cima/baixo das 3 primeiras carreiras,
	gerando as carreiras finais com 111222333.

	Em máquinas compatíveis com controles com 4 posições, o "sticky"
	(pegadiço) se torna importante para evitar problemas com as
	diagonais. Geralmente seria escolhido um mapa semelhante com este:

	.. image:: images/4way.svg
		:width: 50%
		:align: center
		:alt: Joystick com 4 posições

	Significa que caso pressione esquerda e então role o controle para
	cima (sem passar pelo centro), o eixo do controle passará por
	aquela parte pegadiça do canto do controle fazendo com que o
	movimento "pegue" ou "raspe" o manche nas diagonais atrapalhando o
	movimento. Durante o movimento o MAME irá ler esta posição pegadiça
	como **esquerda** pois é a última posição não pegadiça que foi
	recebida. Até que o movimento chega até a posição **cima** do mapa
	até finalmente resultar no movimento para cima.

	O mapa então ficaria muito parecido com isso:

	.. image:: images/joymap-sticky.svg
		:width: 100%
		:align: center
		:alt: Joystick com 4 posições sticky

	Para definir um mapa com estes parâmetros informe a cadeia de
	caracteres com as linhas separadas por um ponto '.' (que indica o
	final de uma linha):

	Exemplo:
		.. code-block:: shell

			-joymap s8888888s.4s88888s6.44s888s66.444555666.444555666.444555666.44s222s66.4s22222s6.s2222222s

	Assim como antes, por causa da simetria entre cima, baixo, esquerda
	e direita, podemos reduzir o comando para:

	Exemplo:
		.. code-block:: shell

			-joymap s8.4s8.44s8.4445


.. _mame-commandline-joystickdeadzone:

**-joystick_deadzone** / **-joy_deadzone** / **-jdz** <*valor*>

	Caso jogue com um joystick analógico ele poderá estar um pouco
	fora de centro. O ``-joystick_deadzone`` informa uma folga ao longo
	de um eixo que você deve mover antes que o eixo comece a mudar.
	Essa opção espera um valor flutuante (float) no intervalo entre
	``0.0`` e ``1.0``. Onde ``0`` é o centro do joystick e ``1`` o
	limite externo.

	Em ocasiões onde o joystick aparente ser muito sensível, tente
	alterar o valor do ``joystick_deadzone`` para ``0`` e o
	``joystick_saturation`` para ``1``.

	O valor predefinido é ``0.3`` (``-joystick_deadzone 0.3``).

	Exemplo:
		.. code-block:: shell

			mame sinistar -joystick_deadzone 0.45


.. _mame-commandline-joysticksaturation:

**-joystick_saturation** / **joy_saturation** / **-jsat** <*valor*>

	Caso jogue com um joystick analógico as extremidades podem
	estar um pouco fora e podem não corresponder nas direções + /.
	O ``-joystick_saturation`` define se uma folga no movimento do eixo
	será aceita até que se atinja o alcance máximo. Essa opção espera um
	valor flutuante (float) no intervalo entre ``0.0`` até ``1.0`` onde
	``0`` é o centro do joystick e ``1`` é o limite externo.

	O valor predefinido é ``0.85`` (``-joystick_saturation 0.85``).

	Exemplo:
		.. code-block:: shell

			mame sinistar -joystick_saturation 1.0


.. _mame-commandline-natural:

**-natural**

	Permite que o usuário defina se deve ou não usar um teclado natural.
	Isso permite que o seu sistema num modo *nativo* dependendo da sua
	região, permitindo compatibilidade para teclados fora do padrão
	"QWERTY".

	O valor predefinido é ``Desligado`` (``-nonatural``).

	No modo de "teclado emulado" (predefinido) o MAME traduz o
	pressionamento/liberação de teclas/botões do host para
	pressionamentos emulados de tecla. Ao pressionar/soltar uma
	tecla/botão mapeado para uma tecla emulada, o MAME pressiona/libera
	a tecla emulada.

	No modo "teclado natural", o MAME tenta traduzir os caracteres para
	as teclas digitadas. O sistema operacional traduz pressionamentos
	de tecla a caracteres (da mesma forma quando se digita num
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

		mame coco2 -natural


.. _mame-commandline-joystickcontradictory:

**-joystick_contradictory**

	Aceita a entrada de comandos contraditórios e simultâneos no
	controle digital como **Esquerda e Direita** ou **Cima e Baixo** ao
	mesmo tempo.

	O valor predefinido é ``Desligado``
	(``-nojoystick_contradictory``).

	Exemplo:
		.. code-block:: shell

			mame ddr4m -joystick_contradictory


.. _mame-commandline-coinimpulse:

**-coin_impulse** *[n]*

	Define o tempo de impulso da moeda com base em *n* (``n<0``
	desabilita, ``n==0`` obedeça o driver, ``0<n`` defina o tempo em
	*n*).

	O valor predefinido é ``0`` (``-coin_impulse 0``).

	Exemplo:
		.. code-block:: shell

			mame contra -coin_impulse 1


.. raw:: latex

	\clearpage

Opções Automaticamente Ativas das Entadas Principais
----------------------------------------------------

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

	Cada uma dessas opções de controle são ativadas automaticamente
	para o mouse, controle (joystick) ou arma de luz (lightgun)
	dependendo de uma classe em particular de controle analógico para um
	sistema em particular. Por exemplo, caso seja definida a opção
	``-paddle mouse``, então qualquer jogo que tenha um remo ou pá como
	controle será automaticamente configurado para ser usado com o mouse
	como se a opção ``-mouse`` tivesse sido definida.

	Observe que estes controles sobrescrevem as opções
	:ref:`-[no]mouse <mame-commandline-nomouse>`,
	:ref:`-[no]joystick <mame-commandline-nojoystick>`, etc.

	Exemplo:
		.. code-block:: shell

			mame sbrkout -paddle_device mouse


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

	O valor predefinido é ``Desligado`` (``-noverbose``).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -verbose


.. _mame-commandline-oslog:

**-[no]oslog**

	Escreve um arquivo error.log com mensagens de diagnósticos do
	sistema caso um esteja presente.

	É predefinido que as mensagens de erro sejam enviadas para a saída
	padrão, geralmente é exibido no terminal, prompt de comando ou num
	arquivo de log de sistema. No *Windows*, caso um depurador esteja
	sendo usado como o depurador do *Visual Studio* ou *WinDbg*, as
	mensagens de erros serão enviadas para estes em vez de serem exibidas
	no terminal.

	O valor predefinido é ``Desligado`` (``-nooslog``).

	Exemplo:
		.. code-block:: shell

			mame mappy -oslog


.. _mame-commandline-log:

**-[no]log**

	Cria um arquivo chamado error.log que contém todos os registros de
	mensagens internas gerada pelo cerne do MAME e drivers de sistema.
	Isso pode ser usado ao mesmo tempo que ``-oslog`` para escrever os
	dados de saída de ambos ao mesmo tempo.

	O valor predefinido é ``Desligado`` (``-nolog``).

	Exemplo:
		.. code-block:: shell

			mame mappy -log
			mame mappy -oslog -log


.. _mame-commandline-debug:

**-[no]debug** / **-[no]d**

	Ativa o depurador embutido no MAME. É predefinido que o depurador
	entre em ação ao pressionar a tecla *til* :kbd:`~` [8]_ e
	*acento grave* :kbd:`\`` durante a emulação.
	Ele também entra direto no depurador depois que a emulação é
	redefinida, caso esta opção esteja ativa. Consulte
	:ref:`-debugger <mame-commandline-debugger>` para obter mais
	informações de como usar o depurador.

	O valor predefinido é ``Desligado`` (``-nodebug``).

	Exemplo:
		.. code-block:: shell

			mame indy_4610 -debug

.. raw:: latex

	\clearpage


.. _mame-commandline-debugger:

**-debugger** <*módulo*>

	Escolhe o módulo que será usado para depurar o sistema quando a
	opção :ref:`-debug <mame-commandline-debug>` estiver ligada. A
	disponibilidade dos módulos de depuração dependem da plataforma e
	das opções de compilação.

	Estes são os módulos compatíveis com esta opção:

	``windows``

		Depurador Win32 GUI (padrão no Windows). Compatível apenas no
		Windows.

	``qt``

		Depurador Qt GUI (padrão no Linux). É compatível no Windows,
		Linux e macOS, porém é incluído apenas no Linux. Defina a opção
		``USE_QTDEBUG=1`` ao compilar o MAME para tornar disponível no
		Windows ou macOS.

	``osx``

		Depurador Cocoa GUI (padrão no macOS). Compatível apenas no
		macOS.

	``imgui``

		O depurador ImgUi GUI é exibido na primeira janela do MAME.
		É preciso que a opção :ref:`-video <mame-commandline-video>`
		esteja definido como ``bgfx``. É compatível com todas as
		plataformas que suportem a opção BGFX.

	``gdbstub``

		Funciona como um servidor de depuração remota para o depurador
		GNU GDB. Apenas um pequeno conjunto emulado das CPUs são
		compatíveis. Use a opção :ref:`-debugger_port <mame-commandline-debuggerport>`
		para definir a porta na interface de rede. É compatível com
		todas as plataformas com suporte a TCP/IP.

	Examplo:
		.. code-block:: shell

			mame ambush -debug -debugger qt


.. _mame-commandline-debugscript:

**-debugscript** <*nome do arquivo*>

	Define um arquivo que vai conter a lista de comandos de depuração a
	serem executados no momento da inicialização.

	O valor predefinido é ``NULO`` (nenhum comando).

	Exemplo:
		.. code-block:: shell

			mame galaga -debugscript testscript.txt

.. raw:: latex

	\clearpage


.. _mame-commandline-updateinpause:

**-[no]update_in_pause**

	Ativa a atualização do bitmap inicial da tela enquanto o sistema
	estiver pausado. Isso significa que a opção de retorno
	**VIDEO_UPDATE** sempre será chamada durante a pausa, o que pode ser
	útil durante a depuração.

	O valor predefinido é ``Desligado`` (``-noupdate_in_pause``).

	Exemplo:
		.. code-block:: shell

			mame indy_4610 -update_in_pause


.. _mame-commandline-debuggerport:

**-debugger_port** <*valor*>

	Define uma porta a ser usada pelo gdbstub debugger. Para usar,
	execute o ``gdb`` e faça o comando
	``target remote localhost:23946``.

	A porta predefinida é ``23946``.

	Exemplo:
		.. code-block:: shell

			mame indy_4610 -debugger_port 23999


.. _mame-commandline-debuggerfont:

**-debugger_font** <*nome da fonte*> / **-dfont** <*nome da fonte*>

	Define o nome da fonte a ser usada nas janelas do depurador.

	A fonte predefinida da janela é **Lucida Console**.
	A fonte predefinida do Mac (**Cocoa**) é o padrão de fonte de
	tamanho fixo do sistema (geralmente a fonte **Monaco``).
	A fonte padrão do Qt é **Courier New**.

	Exemplo:
		.. code-block:: shell

			mame marble -debug -debugger_font "Comic Sans MS"


.. _mame-commandline-debuggerfontsize:

**-debugger_font_size** <*pontos*> / **-dfontsize** <*pontos*>

	Define o tamanho da fonte a ser usada nas janelas do depurador
	em pontos.

	O tamanho padrão da janela é de ``9`` pontos.
	O tamanho padrão do Qt é de ``11`` pontos.
	O tamanho padrão do Mac (**Cocoa**) é o tamanho padrão usado pelo
	sistema.

	Exemplo:
		.. code-block:: shell

			mame marble -debug -debugger_font "Comic Sans MS" -debugger_font_size 16


.. _mame-commandline-watchdog:

**-watchdog** <*tempo*> / **-wdog** <*tempo*>

	Ativa o temporizador watchdog interno que vai automaticamente
	matar o processo do MAME caso o tempo de duração definido em
	<*tempo*> passe caso não haja nenhuma atualização de quadro.
	Tenha em mente que alguns sistemas ficam parados por algum tempo
	durante o carregamento da tela, então <*duration*> deve ser grande
	o suficiente para levar esse tempo extra em consideração.
	Geralmente, um valor entre ``10`` e ``30`` segundos devem ser
	suficientes.

	O valor predefinido é ``Nenhum``.

	Exemplo:
		.. code-block:: shell

			mame ibm_5150 -watchdog 30


.. raw:: latex

	\clearpage

Opções para a configuração da rede
----------------------------------

.. _mame-commandline-commlocalhost:

**-comm_localhost** <*endereço*>

	Definição para o endereço local. Este pode ser um endereço
	tradicional ``xxx.xxx.xxx.xxx`` ou um nome do host que possa ser
	resolvido

	O valor predefinido é ``0.0.0.0``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_localhost 192.168.1.2


.. _mame-commandline-commlocalport:

**-comm_localport** <*porta*>

	Definição da porta local. Esta pode ser qualquer porta de
	comunicação tradicional como um valor inteiro (``0-65535``).

	O valor predefinido é ``15122``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_localhost 192.168.1.2 -comm_localport 30100


.. _mame-commandline-commremotehost:

**-comm_remotehost** <*endereço*>

	Definição do endereço remoto. Este pode ser um endereço tradicional
	``xxx.xxx.xxx.xxx`` ou um nome de host que possa ser resolvido.

	O valor predefinido é ``0.0.0.0``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_remotehost 192.168.1.2


.. _mame-commandline-commremoteport:

**-comm_remoteport** <*porta*>

	Definição da porta remota. Esta pode ser qualquer porta de
	comunicação tradicional como um valor inteiro *non-signed* com
	16-bit (``0-65535``).

	O valor predefinido é ``15122``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_remotehost 192.168.1.2 -comm_remoteport 30100


.. _mame-commandline-commframesync:

**-[no]comm_framesync**

	Sincroniza os quadros entre os hosts na rede.

	O valor predefinido é ``Desligado`` (``-nocomm_framesync``).

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_remotehost 192.168.1.3 -comm_remoteport 30100 -comm_framesync


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
	desempenho e eficiência durante a execução. Por outro lado, é
	preciso um poder de processamento muito maior para que isso seja
	possível.

	O valor predefinido é ``Ligado`` (``-drc``).

	Exemplo:
		.. code-block:: shell

			mame ironfort -nodrc


.. _mame-commandline-drcusec:

**-drc_use_c**

	Impor o uso do DRC usando a infra-estrutura em código C.

	O valor predefinido é ``Desligado`` (``-nodrc_use_c``).

	Exemplo:
		.. code-block:: shell

			mame ironfort -drc_use_c


.. _mame-commandline-drcloguml:

**-drc_log_uml**

	Grave um registro descompilado DRC UML num arquivo de registro
	(log).

	O valor predefinido é (``-nodrc_log_uml``).

	Exemplo:
		.. code-block:: shell

			mame ironfort -drc_log_uml


.. _mame-commandline-drclognative:

**-drc_log_native**

	Grave o DRC nativo e descompilado num registro de log em formato
	assembler.

	O valor predefinido é ``Desligado`` (``-nodrc_log_native``).

	Exemplo:
		.. code-block:: shell

			mame ironfort -drc_log_native


.. _mame-commandline-bios:

**-bios** <*nome da bios*>

	Determina qual BIOS usar no sistema a ser emulado em sistemas
	que fazem uso de uma BIOS. A saída ``-listxml`` listará todos os
	nomes das BIOS disponíveis para o sistema.

	Não há valor predefinido (O MAME usará a primeira BIOS nativa
	do sistema que for encontrada, caso uma esteja disponível).

	Exemplo:
		.. code-block:: shell

			mame mslug -bios unibios40


.. raw:: latex

	\clearpage


.. _mame-commandline-cheat:

**-[no]cheat** / **-[no]c**

	Ativa o cardápio de trapaças, exibindo uma lista de trapaças que
	ficam armazenadas num arquivo externo chamado ``cheat.7z``.
	Essa opção também ativa as opções de turbo dos botões.

	O valor predefinido é ``Desligado`` (``-nocheat``).

	Exemplo:
		.. code-block:: shell

			mame kof97 -cheat


.. _mame-commandline-skipgameinfo:

**-[no]skip_gameinfo**

	Ao iniciar, faz com que o MAME não exiba a tela de informações do
	sistema da máquina.

	O valor predefinido é ``Desligado`` (``-noskip_gameinfo``).

	Exemplo:
		.. code-block:: shell

			mame samsho5 -skip_gameinfo


.. _mame-commandline-uifont:

**-uifont** <*nome da fonte*>

	Define o nome da fonte ou um nome do arquivo de fonte a ser usada na
	interface do usuário. Caso esta fonte não possa ser encontrada ou
	não puder ser carregada, o MAME usará a sua própria fonte embutida.
	Em algumas plataformas o <*nome da fonte*> (nome da fonte) pode ser
	um nome da fonte do sistema em vez de um arquivo fonte com extensão
	``.bdf``. Para o nome das fontes que tem espaço utilize o nome entre
	aspas (``-uifont "nome do arquivo da fonte"``).

	O valor predefinido é ``default`` (O MAME usará a fonte nativa).

	Exemplo:
		.. code-block:: shell

			mame -uifont "Comic Sans MS"


.. _mame-commandline-ui:

**-ui** <*tipo*>

	Define o tipo de interface do usuário, as opções ficam
	entre ``simple`` a mais simples ou ``cabinet`` que é a mais
	completa.

	O valor predefinido é ``Cabinet`` (``-ui cabinet``).

	Exemplo:
		.. code-block:: shell

			mame -ui simple


.. _mame-commandline-ramsize:

**-ramsize** / **-ram** <*n*>

	Permite que seja alterado o tamanho padrão da RAM (caso exista suporte
	para tanto no driver).

	Exemplo:
		.. code-block:: shell

			mame maclc -ramsize 10M -hard1 mac761.chd


.. _mame-commandline-confirmquit:

**-confirm_quit**

	Remove o aviso na tela "*Tem certeza que deseja encerrar?*" ao
	pressionar a tecla :kbd:`Esc`.

	O valor predefinido é ``Desligado`` (``-noconfirm_quit``).

	Exemplo:
		.. code-block:: shell

			mame pacman -confirm_quit


.. raw:: latex

	\clearpage


.. _mame-commandline-uimouse:

**-ui_mouse**

	Exibe o ponteiro do mouse na interface do usuário do MAME.

	O valor predefinido é ``sem mouse`` (``-noui_mouse``).

	Exemplo:
		.. code-block:: shell

			mame -ui_mouse


.. _mame-commandline-language:

**-language** / **-lang** <*idioma*>

	Especifique um idioma para ser usado na interface do usuário, os
	arquivos de tradução para cada idioma estão no caminho definido em
	**languagepath**.

	Exemplo:
		.. code-block:: shell

			mame -language Portuguese_Brazil


.. _mame-commandline-nvramsave:

**-[no]nvram_save** / **-[no]nvwrite**

	Salva o conteúdo da NVRAM ao encerrar a emulação. Caso essa opção seja
	desligada, o conteúdo que foi gravado anteriormente não será apagado
	e qualquer alteração atual não será gravada. Ao desabilitar essa
	função suprime incondicionalmente o salvamento de arquivos .nv
	associados com alguns tipos de programas usados em cartuchos.

	O valor predefinido é ``Ligado`` (``-nvram_save``).

	Exemplo:
		.. code-block:: shell

			mame galaga88 -nonvram_save


.. raw:: latex

	\clearpage

Opções para uso com script
--------------------------

.. _mame-commandline-autobootcommand:

**-autoboot_command** / **-ab** "<*comando*>"

	Cadeia de comandos que serão executados após a inicialização da
	máquina (entre aspas " "). Para emitir uma cotação para a
	emulação, use """ no comando. Usando **\\n** irá criar uma nova
	linha, emitindo o que foi digitado antes como comando.

	Exemplo:
		.. code-block:: shell

			mame c64 -autoboot_command "load """$""",8,1\n"


.. _mame-commandline-autobootdelay:

**-autoboot_delay** <*n*>

	Tempo de atraso (em segundos) para o **-autoboot_command**.

	Exemplo:
		.. code-block:: shell

			mame c64 -autoboot_delay 5 -autoboot_command "load """$""",8,1\n"


.. _mame-commandline-autobootscript:

**-autoboot_script** / **-script** <*nome_do_arquivo.lua*>

	Carrega e executa um scrit após a inicialização da máquina.

	Exemplo:
		.. code-block:: shell

			mame ibm5150 -autoboot_script myscript.lua


.. _mame-commandline-console:

**-console**

	Ativa emulador do Console Lua.

	O valor predefinido é ``Desligado`` (``-noconsole``).

	Exemplo:
		.. code-block:: shell

			mame ibm5150 -console


.. _mame-commandline-plugins:

**-plugins**

	Ativa o uso de plug-ins Lua, para mais informações consulte o
	capítulo :ref:`plugins`.

	O valor predefinido é ``Ligado`` (``-plugins``).

	Exemplo:
		.. code-block:: shell

			mame apple2e -plugins


.. _mame-commandline-plugin:

**-plugin** <*apelido do plugin*>

	Permite o uso de uma lista de plug-ins Lua separados por vírgula,
	para mais informações consulte o capítulo :ref:`plugins`.

	Exemplo:
		.. code-block:: shell

			mame alcon -plugin cheat,discord,autofire


.. _mame-commandline-noplugin:

**-noplugin** <*apelido do plugin*>

	Permite desabilitar uma lista de plug-ins Lua separados por vírgula. ::

		mame alcon -noplugin cheat


.. raw:: latex

	\clearpage

Opções do servidor HTTP
-----------------------

.. _mame-commandline-http:

**-http**

	Ativa o servidor de HTTP.

	O valor predefinido é ``Desligado`` (``-nohttp``).

	Exemplo:
		.. code-block:: shell

			mame -http

	.. note:: Até a última versão deste documento o comando não
              funciona.


.. _mame-commandline-httpport:

**-http_port** <*porta*>

	Define uma porta para o servidor HTTP.

	O valor predefinido é ``8080``.

	Exemplo:
		.. code-block:: shell

			mame apple2 -http -http_port 6502

	.. note:: Até a última versão deste documento o comando não
              funciona.


.. _mame-commandline-httproot:

**-http_root** <*diretório raíz*>

	Define a pasta raíz para os documentos do servidor HTTP.

	O valor predefinido é ``web``.

	Exemplo:
		.. code-block:: shell

			mame apple2 -http -http_port 6502 -http_root c:\users\me\appleweb\root

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
.. [3]	Quando uma imagem ficava estática numa tela de tubo CRT
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
