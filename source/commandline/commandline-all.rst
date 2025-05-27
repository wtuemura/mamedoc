.. _mame-commandline-universal:

Opções Universais de linha de comando
=====================================

.. contents:: :local:


Comandos opções e parâmetros
----------------------------

Os comandos incluem o próprio executável do **MAME**, bem como
:ref:`as várias ferramentas <mame-aditional-tools>` incluídas
no MAME.

As opções (chamadas de "verbos" na documentação original) são ações que
serão executadas em conjunto com o comando, e qualquer outra ação
auxiliar a opção (quando existir) é chamada de **parâmetro da
opção**. No português brasileiro, subentende-se que, quando falamos em
**comando**, estamos nos referindo ao comando junto com a opção (quando
for o caso). Por exemplo, no comando **mame -validate pacman**, **mame**
é o comando em si, **-validate** é a opção e **pacman** é o parâmetro
que desejamos usar com a opção **-validate**.


.. _mame-commandline-patterns:

Conjunto de instruções
----------------------

Muitos comandos são compatíveis com o uso de um *conjunto de instruções*
ou um padrão [1]_, que pode ser um sistema ou um nome abreviado do
dispositivo (como por exemplo, **a2600**, **zorba_kbd**) ou um conjunto
de instruções globais que correspondam a um dos dois como **zorba_***
por exemplo.

Dependendo do comando combinado com esse conjunto de instruções, a
correspondência dessas combinações pode equivaler a um sistema (ou
vários deles), assim como a dispositivos. É aconselhável
colocar aspas em torno dos parâmetros para evitar que o seu ambiente
tente interpretá-los de forma independente em relação aos nomes dos
arquivos desejados (por exemplo, **mame -validate "pac*"**).


.. _mame-commandline-paths:

A Nomenclatura dos arquivos e a localização das pastas
------------------------------------------------------

O MAME aceita a utilização de mais de um caminho em suas configurações,
como, por exemplo, as configurações que permitam a procura de ROMs em
diferentes locais, desde que tais configurações utilizem o símbolo
:kbd:`;` para separar cada caminho.

O MAME também consegue identificar o caminho dos locais das pastas
usando as variáveis de ambiente já existentes no seu sistema operacional 
e sua sintaxe irá depender do sistema utilizado. No Windows, por
exemplo, se a configuração **%APPDATA%\\mame\\cfg** for definida, o
MAME conseguirá ler a variável **%APPDATA%** e resolver o caminho
completo para a pasta com os dados de aplicativos do usuário.

Em sistemas do tipo UNIX, como o macOS e o Linux, que utilizam o
interpretador de comandos *Bourne Shell*, o mesmo aconteceria caso o
caminho fosse definido nas configurações como
**/home/${USER}/.mame/cfg**. Assim como o sinal de porcentagem **%** é
usado numa palavra para se definir uma variável no ambiente do
*Windows*, o sinal de til :kbd:`~` serve como um redirecionador para a
pasta home do usuário. Dessa forma, em vez de digitar o caminho
completo **/home/${USER}/.mame/cfg** é possível simplificar usando
**~/.mame/cfg**.

Note porém que o MAME só aceita interpretações de variáveis simples. Ele
MAME não reconhece expressões mais complexas compatíveis com bash, ksh,
ou zsh.

Os caminhos relativos são resolvidos a partir da pasta de trabalho
atual. Ao iniciar o MAME com um clique duplo, a pasta de trabalho
atual será aquele onde o executável do MAME estiver localizado. Se você
fizer o mesmo usando um macOS, será aberta uma janela de terminal onde o
diretório *home* será o seu diretório de trabalho.

Para obter um comportamento semelhante ao Windows Explorer no macOS,
crie um script contendo as linhas do exemplo abaixo no mesmo
diretório onde se encontra o executável do MAME. No exemplo abaixo, está
sendo usada a versão 64-bit do MAME; mude conforme necessário.

.. code-block:: bash

	#!/bin/sh
	cd "`dirname "$0"`"
	exec ./mame

Salve o script com um nome qualquer, como "**meumame**", por exemplo, na
mesma pasta do executável do MAME. Abra o terminal e torne o
script executável com o comando **chmod u+x meumame**. Ao executar
o script, uma janela do terminal será aberta e o MAME será executado,
com diretório de trabalho definido no mesmo local do script.


.. raw:: latex

	\clearpage


.. _mame-commandline-coreverbs:

Opções de ajuda e verificação
-----------------------------

.. _mame-commandline-help:

**-help** / **-h** / **-?**

	A opção exibe a versão atual do MAME e o aviso de direitos autorais.

.. code-block:: shell

		mame -help

.. _mame-commandline-validate:

**-validate** / **-valid** <*palavra-chave*>

	Executa uma validação interna em um ou mais drivers e dispositivos
	no sistema. Execute essa validação antes de enviar qualquer
	alteração para nós, visando garantir o comprimento de todas as
	regras do sistema principal.

	Se um padrão for definido, ele validará a correspondência
	predefinida do sistema em questão; caso contrário, validará todos
	os sistemas e dispositivos. Note que caso um padrão seja definido,
	ele será comparado apenas com sistemas e não com outros
	dispositivos. Não será realizada nenhuma validação com dispositivos.

	Exemplo:
		.. code-block:: shell

			mame -validate
			Driver ace100 (file apple2.cpp): 1 errors, 0 warnings
			Errors:
			Software List device 'flop525_orig': apple2_flop_orig.xml: Errors parsing software list:
			apple2_flop_orig.xml(126.2): Unknown tag: year
			apple2_flop_orig.xml(126.8): Unexpected content
			apple2_flop_orig.xml(127.2): Unknown tag: publisher


.. _mame-commandline-verifyroms:

**-verifyroms** <*palavra-chave*>

	Verifica a condição dos arquivos da imagem ROM em um determinado
	sistema. Serão verificados todos os sistemas e diretórios válidos
	que estejam dentro do **rompath** (caminho da ROM):

	Exemplo:
		.. code-block:: shell

			mame -verifyroms pacman
			romset pacman [puckman] is good
			1 romsets found, 1 were OK.

	É possível usar um asterisco ao final do nome do sistema para que
	uma lista com todos os outros sistemas relacionados ao nome do
	sistema principal e sua condição atual seja exibida, por exemplo:

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
			romset pacmaniao [pacmania] is good
			...

	Todos os sistemas e arquivos da imagem ROM serão verificados caso
	nenhum nome seja informado.

.. _mame-commandline-verifysamples:

**-verifysamples** <*palavra-chave*>

	Verifica a condição dos arquivos de amostra (**samples**)
	informados. Todos os arquivos ou diretórios que forem válidos serão
	verificados, desde que estejam configurados em **samplepath**:

	Exemplo:
		.. code-block:: shell

			mame -verifysamples 005
			sampleset 005 is good
			1 samplesets found, 1 were OK.

	É possível usar um asterisco ao final do nome do sample para que
	seja exibida uma lista com todos os outros samples relacionados ao
	nome do sample principal e sua condição atual, por exemplo:

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

**-verifysoftware** / **-vsoft** <*palavra-chave*>

	Verifica se há imagens ROM inválidas ou ausentes na lista de
	software. É predefinido que todos os drivers que possuem arquivos
	**.zip** ou diretórios válidos no **rompath** (caminho da ROM) serão
	verificados. No entanto, é possível limitar essa lista definindo um
	nome de driver específico ou combinações após o comando
	**-verifysoftware**.

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

**-verifysoftlist** / **-vlist** <*nome do catálogo de programas*>

	Verifica ROMs ausentes com base em uma lista de software
	predeterminado na pasta **hash**.
	É predefinido que a busca e a verificação serão feitas em todos os
	drivers e arquivos **.zip** em diretórios válidos no **rompath**
	(caminho da rom), no entanto, é possível filtrar essa lista usando
	uma palavra-chave ou coringa em "*softwarelistname*" após o comando
	**-verifysoftlist**. As listas estão na pasta *hash* e devem ser
	informadas sem a extensão **.xml**.

	O resultado é exatamente igual ao comando **-verifysoftware**, porém
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


.. _mame-commandline-configverbs:

Opções de configuração
----------------------

.. _mame-commandline-createconfig:

**-createconfig** / **-cc**

	Cria um arquivo **mame.ini** pré-configurado. Todas as opções de
	configuração (não verbos) descritos abaixo podem ser permanentemente
	alterados ao editar este arquivo. Consulte também o capítulo sobre
	:ref:`como criar apenas um mame.ini com as configurações de fábrica
	<advanced-tricks-mame-ini>`.

	Exemplo:
		.. code-block:: shell

			mame -cc

.. _mame-commandline-showconfig:

**-showconfig** / **-sc**

	Exibe as configurações atualmente usadas. É possível direcionar essa
	saída para um arquivo ou também é possível utilizá-lo como um
	arquivo **.ini**, como mostra o exemplo abaixo:

	Exemplo:
		.. code-block:: shell

			mame -showconfig > mame.ini

	É o mesmo que **-createconfig**.

.. _mame-commandline-showusage:

**-showusage** / **-su**

	Exibe todas as opções disponíveis no MAME que sejam compatíveis com
	o seu sistema operacional ou a versão do MAME que estiver usando.
	Cada opção é acompanhada de uma breve descrição em inglês.

	As configurações nativas do Windows, como hlsl, por exemplo, não
	estarão disponíveis, nem serão listadas nas versões SDL do
	MAME que rodam em Linux, macOS e assim por diante.

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


.. _mame-commandline-fronendverbs:

Opções para listagem
--------------------

É predefinido que todos os comandos **-list** abaixo exibam informações
na saída predefinida do sistema, que geralmente é a tela do terminal
onde o comando foi digitado. Para gravar a informação num arquivo
texto, adicione o exemplo abaixo ao final do seu comando:

	**>** *nome do arquivo*

Onde '*nome do arquivo*' é o nome do arquivo de texto que será criado
para registrar toda a saída do terminal (por exemplo, **lista.txt**).
Note que qualquer conteúdo prévio existente nesse arquivo será apagado
sem aviso prévio.
Exemplo:

	Isso cria (ou substitui, se já existir) o arquivo **lista.txt** e
	o completa com os resultados de **-listcrc puckman**. Em outras
	palavras, a lista de cada ROM usada em *Puckman* e o CRC
	para essa ROM são gravados nesse arquivo.

.. _mame-commandline-listxml:

**-listxml** / **-lx** < ``dispositivo`` | ``driver`` | ``sistema`` >

	Gera uma lista detalhada e completa de toda a informação mantida
	pelo MAME em seu banco de dados interno sobre os seus dispositivos,
	sistemas, drivers e nomes dos drivers, assim como muitas outras
	informações em formato XML. É possível limitar a saída informando
	um nome de dispositivo (**ym2203** por exemplo), um driver
	(**megadriv**, por exemplo) ou sistema (**sf2**, por exemplo).

	Geralmente, a saída deste comando é usada para redirecionar a um
	arquivo de texto que posteriormente é utilizado por outras
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
			<mame build="0.246 (mame0246-58-g3ba776d3e0b)" debug="no" mameconfig="10">
				<machine name="sf2" sourcefile="capcom/cps1.cpp">
					<description>Street Fighter II: The World Warrior (World 910522)</description>
					<year>1991</year>
					<manufacturer>Capcom</manufacturer>
				...
				</machine>
			</mame>

.. raw:: latex

	\clearpage

.. _mame-commandline-listfull:

**-listfull** / **-ll** <*palavra-chave*>

	Exibe uma lista com o nome do sistema pesquisado e a sua
	descrição:

	Exemplo:
		.. code-block:: shell

			mame -ll pacman
			Name:             Description:
			pacman            "Pac-Man (Midway)"

	É possível usar um asterisco ao final do nome do sistema para que
	seja exibida uma lista com todos os outros sistemas relacionados ao
	o nome do driver principal e suas respectivas descrições,
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

	Também é possível listar a descrição de sistemas. Infelizmente, nem
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

	Todos os sistemas ou drivers serão listados caso nenhum seja
	informado.

.. raw:: latex

	\clearpage

.. _mame-commandline-listsource:

**-listsource** / **-ls** <*palavra-chave*>

	Exibe uma lista de drivers/dispositivos dos sistemas e o nome dos
	seus respectivos arquivos fonte. Essa função é útil para identificar
	qual driver o sistema roda, o que é muito útil para o relatório de
	bugs. É predefinido que todos os sistemas e os dispositivos sejam
	listados; contudo, é possível limitar a lista por meio de um nome ou
	texto qualquer após a opção **-listsource**.

	Exemplo:
		.. code-block:: shell

			mame -ls pacman
			pacman           pacman/pacman.cpp

	Também é possível utilizar um curinga (asterisco) ao final do nome
	do sistema para que seja exibido uma lista com todos os outros
	sistemas relacionados ao nome do sistema principal, por exemplo:

	Exemplo:
		.. code-block:: shell

			mame -ls pacman*
			pacman           pacman/pacman.cpp
			pacmanbl         galaxian/galaxian.cpp
			...
			pacmania         namco/namcos1.cpp

	Todos os sistemas serão listados caso nenhuma palavra-chave seja
	informada.

.. _mame-commandline-listclones:

**-listclones** / **-lc** <*palavra-chave*>

	Exibe uma lista de clones de um determinado sistema. O MAME listará
	todos os clones existentes em seu banco de dados, mas é possível
	filtrar a lista com o uso de uma palavra-chave após o comando.

	Exemplo:
		.. code-block:: shell

			mame -lc rallyx
			Name:            Clone of:
			dngrtrck         rallyx
			rallyxa          rallyx
			rallyxm          rallyx
			rallyxmr         rallyx

	.. tip:: Consulte o capítulo :ref:`A organização do conjunto das ROMs <aboutromsets_division>`
		para saber o que significa os termos usado pelo MAME como
		"*clone*"e "*parent*".


.. raw:: latex

	\clearpage


.. _mame-commandline-listbrothers:

**-listbrothers** / **-lb** <*palavra-chave*>

	Exibe uma lista com o nome do driver, da ROM principal e dos
	parentes que compartilhem do mesmo driver do sistema que foi
	pesquisado.

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


.. _mame-commandline-listcrc:

**-listcrc** <*palavra-chave*>

	Exibe uma lista completa com CRCs de todas as imagens ROM
	que compõem um sistema, exibindo os nomes do sistema ou do
	dispositivo em um formato simples que pode ser facilmente filtrado
	por comandos como **grep**, **awk** e **sed** no Linux e macOS ou
	o `find`_ e o `findstr`_  no Windows. Se nenhuma palavra-chave for
	usada como filtro após o comando, o MAME listará *tudo* que estiver
	em seu banco de dados interno.

	Exemplo:
		.. code-block:: shell

			mame -listcrc 005
			8e68533e 1346b.cpu-u25                   005             005
			29e10a81 5092.prom-u1
			...
			1d298cb0 6331.sound-u8                   005             005

.. _mame-commandline-listroms:

**-listroms** / **-lr** <*palavra-chave*>

	Exibe uma lista com todos os arquivos ROM que fazem parte de um
	sistema ou dispositivo. A lista mostra o nome dos arquivos ROM,
	os valores CRC e SHA1, além de indicar se uma das ROMs contidas no
	arquivo está sinalizada como **BAD_DUMP**. Isso significa que o
	conteúdo extraído dessa ROM não é válido, pode conter erros, não foi
	extraído corretamente ou de maneira apropriada, não pode ser
	validado por algum motivo, etc. Se nenhuma palavra-chave for usada
	como filtro após o comando, o MAME listará **tudo** que estiver em
	seu banco de dados interno.

	Exemplo:
		.. code-block:: shell

			mame -lr 005
			ROMs required for driver "005".
			Name                                   Size Checksum
			1346b.cpu-u25                          2048 CRC(8e68533e) SHA1(a257c556d31691068ed5c991f1fb2b51da4826db)
			5092.prom-u1                           2048 CRC(29e10a81) SHA1(c4b4e6c75bcf276e53f39a456d8d633c83dcf485)
			...
			6331.sound-u8                            32 BAD CRC(1d298cb0) SHA1(bb0bb62365402543e3154b9a77be9c75010e6abc) BAD_DUMP


.. raw:: latex

	\clearpage


.. _mame-commandline-listsamples:

**-listsamples** <*palavra-chave*>

	Exibe uma lista das amostras que fazem parte de um determinado
	sistema, seus nomes ou os nomes dos dispositivos. Se nenhuma
	palavra-chave for usada como filtro após o comando, o MAME listará
	**tudo** que estiver em seu banco de dados interno.

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


.. _mame-commandline-romident:

**-romident** <*caminho\\completo\\para\\a\\rom\\desconhecida*>

	Tenta identificar os arquivos ROM desconhecidos comparando-os com
	os arquivos cadastrados no banco de dados interno do MAME que sejam
	utilizados por apenas um sistema ou que também sejam compartilhados
	por mais de um arquivo **.zip** específico. Este comando também pode
	ser usado para tentar identificar conjuntos de ROMs retirados de
	placas desconhecidas. A opção identificará os arquivos que estiverem
	compactados ou não.

	Exemplo:
		.. code-block:: shell

			mame -romident rom_desconhecida.zip
			Identifying rom_desconhecida.zip....
			pacman.6j    = pacman.6j    msheartb   Ms. Pac-Man Heart Burn
			             = pacman.6j    mspacman   Ms. Pac-Man
			...

	Ao finalizar, o comando retorna um nível de erro (errorlevel):

			* ``0``: Isso significa que todos os arquivos foram identificados;
			* ``7``: Isso significa que todos os arquivos foram identificados, exceto um ou mais arquivos não qualificados como "não-ROM";
			* ``8``: Isso significa que alguns arquivos foram identificados;
			* ``9``: Isso significa que nenhum arquivo foi identificado;

.. note::

	Apesar de o "*errorlevel*" constar na documentação oficial, o
	comando não retorna **nenhum** desses valores, pelo menos não é
	possível visualizá-los no terminal ou no prompt de comando. Ele
	retorna apenas a listagem mostrada no exemplo e nada mais.


.. raw:: latex

	\clearpage


.. _mame-commandline-listdevices:

**-listdevices** / **-ld** <*palavra-chave*>

	Exibe as especificações técnicas e todos os dispositivos conhecidos
	e conectados no sistema. Se os slots forem ocupados por
	dispositivos, todos os slots adicionais fornecidos por esses
	dispositivos ficarão visíveis com o comando **-listdevices**.

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
	respectivas opções, se estiverem disponíveis.

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

	Nem todos os itens opcionais acima estão conectados quando o
	sistema é iniciado, sendo necessário utilizar o item descrito em
	**SLOT NAME** em conjunto com o **SLOT OPTIONS**, como, por exemplo,
	para utilizar o dispositivo MIDI do seu computador. Teste com o
	exemplo abaixo:

	Exemplo:
		.. code-block:: shell

			mame x68000 -exp1 x68k_midi -midiout "o seu dispositivo MIDI"

	Para saber qual o dispositivo MIDI disponível no seu sistema,
	consulte o comando :ref:`-listmidi <mame-commandline-listmidi>`.


.. raw:: latex

	\clearpage


.. _mame-commandline-listbios:

**-listbios** <*palavra-chave*>

	Exibe uma lista das BIOS disponíveis para um determinado sistema.
	As opções da BIOS podem estar disponíveis para um sistema ou para
	quaisquer dispositivos selecionáveis via slot.
	
	Todas as BIOS de *todos* os sistemas compatíveis serão listadas caso
	nenhuma *palavra-chave* seja informada.

	Exemplo:
		.. code-block:: shell

			mame -listbios apple2 -sl2 grapplus -sl4 videoterm
			BIOS options for system Apple ][ (apple2):
				default          Original Monitor
				autostart        Autostart Monitor
			
			BIOS options for device Orange Micro Grappler+ Printer Interface (-sl2 grapplus):
				v30              ROM 3.0
				v32              ROM 3.2
			
			BIOS options for device Videx Videoterm 80 Column Display (-sl4 videoterm):
				v24_60hz         Firmware v2.4 (60 Hz)
				v24_50hz         Firmware v2.4 (50 Hz)

	Para sistemas Neo Geo AES.

	Exemplo:
		.. code-block:: shell

			mame -listbios aes
			BIOS options for system Neo-Geo AES (NTSC) (aes):
				euro             Europe MVS (Ver. 2)
				[...]
				asia-mv1c        Asia NEO-MVH MV1C
				japan            Japan MVS (Ver. 3)
				[...]
				unibios40        Universe BIOS (Hack, Ver. 4.0)
				unibios33        Universe BIOS (Hack, Ver. 3.3)
				unibios32        Universe BIOS (Hack, Ver. 3.2)
				unibios31        Universe BIOS (Hack, Ver. 3.1)
				unibios30        Universe BIOS (Hack, Ver. 3.0)
				unibios23        Universe BIOS (Hack, Ver. 2.3)
				unibios23o       Universe BIOS (Hack, Ver. 2.3, older?)
				unibios22        Universe BIOS (Hack, Ver. 2.2)
				unibios21        Universe BIOS (Hack, Ver. 2.1)
				unibios20        Universe BIOS (Hack, Ver. 2.0)
				unibios13        Universe BIOS (Hack, Ver. 1.3)
				[...]


.. raw:: latex

	\clearpage


.. _mame-commandline-listmedia:

**-listmedia** / **-lm** <*sistema*>

	Exibe uma lista de mídias ou formatos compatíveis com o sistema,
	como cartucho, cassete, disquete etc. O comando também exibe as
	extensões compatíveis com cada sistema, caso existam. Na dúvida,
	execute o comando **mame -lm sistema** para saber quais tipos de
	mídia o MAME aceita e quais delas são compatíveis com o sistema em
	questão.

	Exemplo:
		.. code-block:: shell

			mame -lm psu
			SYSTEM           MEDIA NAME       (brief)    IMAGE FILE EXTENSIONS SUPPORTED
			---------------- --------------------------- -------------------------------
			psu              memcard1         (memc1)    .mc   
			psu              memcard2         (memc2)    .mc   
			psu              quickload        (quik)     .cpe  .exe  .psf  .psx  
			psu              cdrom            (cdrm)     .chd  .cue  .toc  .nrg  .gdi  .iso


	Caso queira carregar uma ROM em um sistema como o Megadrive, por
	exemplo, use o comando
	**mame genesis -cart caminho_completo_para_a_rom**.
	Outros sistemas podem aceitar outros formatos. No caso dos sistemas
	que rodam CD-ROM, por exemplo, as opções podem ser
	**-cdrom caminho_completo_para_a_imagem** ou
	**-cdrm caminho_completo_para_a_imagem**.
	Se o sistema também aceitar cartões de memória, é possível combinar
	a opção **-cdrom caminho_completo_ para_a_imagem** com
	**-memc1 caminho_completo_para_a_imagem_do_seu_cartao_de_memoria**.


.. _mame-commandline-listsoftware:

**-listsoftware** / **-lsoft** <*sistema*>

	Exibe o conteúdo de todas as listas de software que podem ser
	utilizadas pelo sistema ou pelos sistemas (praticamente são todos os
	arquivos XML encontrados dentro da pasta **hash**).

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

**-getsoftlist** / **-glist** <*catálogo de programas*>

	Exibe o conteúdo de uma lista de software em formato XML, a mesma
	coisa que a opção **-listsoftware** acima, porém em vez do sistema,
	utiliza-se o nome existente no catálogo de programas.

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


.. _mame-commandline-osdoptions:

Opções relacionadas ao que é exibido na tela (OSD)
--------------------------------------------------

.. _mame-commandline-uimodekey:

**-uimodekey** <*tecla*>

	Tecla usada para ativar ou desativar a interface de usuário
	(abreviada como IU), e assim poder usar os controles via teclado e
	mouse o teclado na IU do MAME. A configuração predefinida é a tecla
	:kbd:`SCRLOCK` (Scroll Lock) no Windows e Linux,
	:kbd:`Forward Delete` no macOS ou **SCRLOCK** em outros sistemas.
	Use :kbd:`FN-Delete` em computadores/notebooks/laptops Macintosh que
	utilizem teclados compactos.

	Exemplo:
		.. code-block:: shell

			mame ibm5150 -uimodekey DEL


.. _mame-commandline-controllermap:

**-controller_map** / **-ctrlmap** *<nome_do_arquivo>*

	O caminho para um arquivo de texto contendo os mapeamentos do
	controle, dos botões e do direcional no formato usado pelo SDL2 e
	pelo `Steam`_, ou **none**, para usar apenas o mapeamento nativo do
	MAME. O arquivo deve usar um formato de texto compatível com ASCII e
	com terminações de linha nativas (**CRLF** no Windows, por exemplo).
	Atualmente é compatível apenas ao usar a opção
	:ref:`-joystickprovider sdljoy <mame-commandline-joystickprovider>`.

	É possível encontrar uma
	`lista de controles mapeados <https://github.com/gabomdq/SDL_GameControllerDB>`_
	pela comunidade pode ser encontrada no GitHub. Além de usar um
	editor de texto, várias ferramentas estão disponíveis para criar os
	mapeamentos dos controles, incluindo o
	`SDL2 Gamepad Mapper <https://gitlab.com/ryochan7/sdl2-gamepad-mapper/-/releases>`_
	e o SDL2 ControllerMap, que são
	`fornecidos com o SDL <https://github.com/libsdl-org/SDL/releases/latest>`_.
	Também é possível configurar o seu controle no modo "*Big Picture*"
	do `Steam`_ e copiar os mapeamentos a partir das entradas do
	**SDL_GamepadBind** no arquivo **config.vdf** encontrado na pasta
	**config** dentro da pasta de instalação do `Steam`_.

	Exemplo:
		.. code-block:: shell

			mame -controller_map gamecontrollerdb.txt sf2ce


.. _mame-commandline-backgroundinput:

**-[no]background_input**

	Define se a entrada será aceita ou se será ignorada quando o MAME
	não tiver com o foco na interface. No Windows, o **RawInput** é
	atualmente compatível com entrada de mouse e teclado. No
	**DirectInput** é compatível com entrada de mouse, teclado e
	joystick, e o **XInput** apenas com joystick. Já no SDL, o
	**XInput** é compatível com controle de jogos e joysticks. Essa
	configuração é ignorada enquanto o depurador estiver ativo.

		O valor predefinido é ``desligado``. (**-nobackground_input**).

	Examplo:
		.. code-block:: shell

			mame -background_input ssf2tb


.. raw:: latex

	\clearpage


.. _mame-commandline-uifontprovider:

**-uifontprovider** <*módulo*>

	Define a fonte que será utilizada na interface do usuário.

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
      - auto
      - 
      - sdl [#UIFPSDLWindows]_
      - none
    * - **macOS**
      - 
      - 
      - auto
      - osx
      - sdl
      - none
    * - **Linux**
      - 
      - 
      - auto
      - 
      - sdl
      - none

..  [#UIFPSDLWindows] O binário oficial do MAME para Windows não é
                     compilado com SDL, sendo necessário compilar uma
                     versão compatível para que a opção **sdl**
                     funcione.


.. _mame-commandline-keyboardprovider:

**-keyboardprovider** <*módulo*>

	Escolhe como o MAME lidará com a entrada do teclado.

		O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame c64 -keyboardprovider win32

.. tabularcolumns:: |L|C|C|C|C|C|C|

.. list-table:: Provedores compatíveis com a entrada do teclado, separados por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - auto [#KBPVAutoWindows]_
      - rawinput
      - dinput
      - win32
      - sdl [#KBPVSDLWindows]_
      - none
    * - **SDL (macOS e Linux)**
      - auto [#KBPVAutoSDL]_
      - 
      - 
      - 
      - sdl
      - none

..  [#KBPVAutoWindows] No Windows, ``auto`` tentará ``rawinput``,
                       caso contrário, usa o ``dinput``.
..  [#KBPVSDLWindows] Para ter suporte SDL no Windows é preciso
                     compilar o MAME com ``OSD=sdl``. O binário oficial
                     do MAME para Windows não é compilado com SDL. Para
                     obter mais informações consulte o capítulo
                     :ref:`compiling-MAME`.
..  [#KBPVAutoSDL] Nas versões SDL a opção ``auto`` será ``sdl``.

.. tip:: Observe que as ferramentas de emulação de teclado do modo de
          usuário, como o ``joy2key``, quase certamente exigirão o uso
          da opção **-keyboardprovider win32** nas máquinas Windows.


.. raw:: latex

	\clearpage


.. _mame-commandline-mouseprovider:

**-mouseprovider** <*módulo*>

	Escolhe como o MAME lidará com a entrada do mouse. No Windows,
	``auto`` tentará o ``rawinput``; caso contrário, retornará para
	o ``dinput``. Nas versões SDL a opção ``auto`` será ``sdl``.
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
      - auto [#MIPAutoWindows]_
      - rawinput
      - dinput
      - win32
      - sdl [#MIPSDLWindows]_
      - none
    * - **SDL (macOS and Linux)**
      - auto [#MIPAutoSDL]_
      -
      -
      -
      - sdl
      - none


..  [#MIPAutoWindows] No Windows, ``auto`` tentará o ``rawinput``, caso
                      contrário, usa o ``dinput``.
..  [#MIPSDLWindows] Para ter suporte SDL no Windows é preciso
                     compilar o MAME com ``OSD=sdl``. O binário oficial
                     do MAME para Windows não é compilado com SDL. Para
                     obter mais informações consulte o capítulo
                     :ref:`compiling-MAME`.
..  [#MIPAutoSDL] Nas versões SDL a opção ``auto`` será ``sdl``.

Example:

    .. code-block:: shell

        mame indy_4610 -mouseprovider win32


.. _mame-commandline-lightgunprovider:

**-lightgunprovider** <*módulo*>

	Escolhe como o MAME lidará com a arma de luz (*light gun*).

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
      - auto [#LGIPAutoWindows]_
      - rawinput
      - win32
      - sdl [#LGIPSDLWindows]_
      -
      - none
    * - **macOS**
      - auto [#LGIPAutoSDL]_
      -
      -
      - sdl
      -
      - none
    * - **Linux**
      - auto [#LGIPAutoSDL]_
      -
      -
      - sdl
      - x11
      - none

..  [#LGIPAutoWindows] No Windows, o ``auto`` tentará o ``rawinput``,
                       caso contrário, tentará ``win32`` ou ``none``
                       caso não encontre nenhum.
..  [#LGIPSDLWindows] Para ter suporte SDL no Windows é preciso
                      compilar o MAME com ``OSD=sdl``. O binário oficial
                      do MAME para Windows não é compilado com SDL. Para
                      obter mais informações consulte o capítulo
                      :ref:`compiling-MAME`.
..  [#LGIPAutoSDL] Nas versões SDL a opção ``auto`` será ``sdl``.


.. _mame-commandline-joystickprovider:

**-joystickprovider** <*módulo*>

	Escolhe como o MAME lidará com a entrada do joystick ou de um outro
	controle.

		O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame mk2 -joystickprovider winhybrid

.. tabularcolumns:: |L|C|C|C|C|C|C|C|

.. list-table:: Opções compatíveis com a entrada do joystick separado por plataforma
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **Microsoft Windows**
      - auto [#JIPAutoWindows]_
      - winhybrid
      - dinput
      - xinput
      - sdlgame [#JIPSDLWindows]_
      - sdljoy [#JIPSDLWindows]_
      - none
    * - **SDL**
      - auto [#JIPAutoSDL]_
      -
      -
      -
      - sdlgame
      - sdljoy
      - none


.. [#JIPAutoWindows] No Windows, a predefinição é ``winhybrid``.
.. [#JIPSDLWindows] Para ter suporte SDL no Windows é preciso
                    compilar o MAME com ``OSD=sdl``. O binário oficial
                    do MAME para Windows não é compilado com SDL. Para
                    obter mais informações consulte o capítulo
                    :ref:`compiling-MAME`.
..  [#JIPAutoSDL] Nas versões SDL a opção ``auto`` será ``sdlgame``.


**winhybrid**

	Usa o ``XInput`` para os controles compatíveis e retornando para
	``DirectInput`` para outros controles. Geralmente, essa configuração
	oferece uma melhor experiência no Windows.

**dinput**

	Usa o ``DirectInput`` para todos os controles. Isso pode ser útil
	caso você queira usar mais de quatro controles ``XInput`` ao mesmo
	tempo. Observe que os controles **LT** e **RT** são combinados com o
	uso de controles ``XInput`` via ``DirectInput``.

**xinput**

	É compatível com até quatro controles ``XInput``.

**sdlgame**

	Usa a API do controle SDL para controles com o mapeamento de
	botão/eixo disponíveis e retorna à API do joystick SDL nos
	outros controles. Fornece uma atribuição consistente dos botões, dos
	eixos e dos nomes dos controles mais populares. Use a
	:ref:`opção controller_map <mame-commandline-controllermap>` para
	fornecer mapeamentos para os controles adicionais ou substituir os
	mapeamentos já incluídos.

**sdljoy**

	Usa a API dos joystick em todos os controles de jogos.

**none**

	Ignora todos os controles de jogos.


.. raw:: latex

	\clearpage


Opções de MIDI e rede
---------------------

.. _mame-commandline-midiprovider:

**-midiprovider** <*módulo*>

	Escolhe como o MAME se comunicará com os dispositivos e aplicações
	MIDI (teclados musicais e sintetizadores, por exemplo). As opções
	compatíveis são ``pm`` para utilizar a biblioteca *PortMidi* ou
	``none`` para desativar a entrada e a saída MIDI (também é possível
	reprodizir arquivos MIDI).

		O padrão é ``auto`` (utilizará o PortMidi se estiver disponível).

	Exemplo:
		.. code-block:: shell

			mame -midiprovider none dx100 -midiin canyon.mid


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

	Informe manualmente o dispositivo MIDI de entrada de sua preferência
	caso o seu computador ou sistema utilize mais de um. O comando
	apenas funciona em sistemas compatíveis e que estejam operando
	com uma entrada MIDI. Consulte também a opção :ref:`-listslot
	<mame-commandline-listslots>` para identificar o nome do slot.
	Use aspas se o nome do dispositivo contiver espaços.

	Exemplo:
		.. code-block:: shell

			mame sistema -nome-do-slot -midiin "nome do dispositivo ou arquivo midi"

.. _mame-commandline-midiout:

**-midiout** <*nome do dispositivo*>

	Informe manualmente o dispositivo MIDI de saída de sua preferência
	caso o seu computador ou sistema utilize mais de um. O comando
	apenas funciona nos sistemas compatíveis e que estejam operando
	com uma saída MIDI. Consulte também a opção :ref:`-listslot
	<mame-commandline-listslots>` para identificar o nome do slot.
	Use aspas se o nome do dispositivo contiver espaços.

	Exemplo:
		.. code-block:: shell

			mame sistema -nome-do-slot -midiout "nome do dispositivo"

.. raw:: latex

	\clearpage


.. _mame-commandline-listnetwork:

**-listnetwork**

	Lista os adaptadores de rede disponíveis para serem utilizados com a
	emulação.

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

	.. tip:: No Windows, é necessário instalar o
		`OpenVPN <https://openvpn.net/community-downloads/>`_ mais
		recente para que o MAME possa ver os adaptadores de rede.


.. _mame-commandline-networkprovider:

**-networkprovider** <*módulo*>

	Escolhe como o MAME oferecerá comunicação de pacotes para as
	interfaces de rede emuladas (placas Ethernet, por exemplo). As
	opções suportadas são: ``taptun`` para usar "*TUN/TAP*",
	TAP-Windows ou similar, ``pcap`` (biblioteca pcap) ou ``none``
	(para desativar a comunicação nas interfaces emuladas de
	rede). As opções disponíveis dependem do seu sistema operacional.
	No Windows e no Linux as opções disponíveis são ``taptun`` e
	``none``; no macOS as opções disponíveis são ``pcap`` e ``none`` .

		O padrão é ``auto`` que usará a opção ``taptun`` caso esteja
		disponível ou retorna para ``pcap``.

	Exemplo:
		.. code-block:: shell

			mame -networkprovider pcap apple2ee -sl3 uthernet


.. raw:: latex

	\clearpage


.. _mame-commandline-osdoutput:

Opções de saída das notificações de tela
----------------------------------------

.. _mame-commandline-output:

**-output**

	Escolhe como o MAME lidará com o processamento das notificações da
	saída. É utilizado para conectar saídas externas, como uma luz de LED
	nos botões iluminados de start para os jogadores 1 e 2 em
	determinados sistemas de arcade, assim como qualquer outro tipo de
	iluminação externa, caso esteja disponível.

	Exemplo:
		.. code-block:: shell

			mame galaxian -output console
			lamp0 = 1
			lamp1 = 1
			lamp0 = 0
			lamp1 = 0

	Assim que um crédito é inserido e, se for o caso, o botão do
	Jogador 1 (1P) começar a piscar e os valores começam a alternar na
	tela. Veja como fica na máquina "Breakers":

	Exemplo:
		.. code-block:: shell

			mame breakers -output console
			digit1 = 63
			digit2 = 63
			digit3 = 63
			digit4 = 63

	Cada sistema terá a sua própria característica.

	É possível escolher entre: ``auto``, ``none``, ``console`` ou
	``network``.

		O valor predefinido para a porta de rede é **8000**.


.. raw:: latex

	\clearpage


.. _mame-commandline-configoptions:

Opções para a configuração
--------------------------

.. _mame-commandline-noreadconfig:

**-[no]readconfig** / **-[no]rc**

	Ativa ou não a leitura dos arquivos de configuração,
	é predefinido que todos eles sejam lidos em sequência e na ordem
	mostrada abaixo:

- **mame.ini**

- **<meumame>.ini**

	Caso o arquivo binário do MAME seja renomeado para **mame060.exe**,
	então o MAME carregará o aquivo **mame060.ini**.

- **debug.ini**

	Caso o depurador esteja ativado.

- **<driver>.ini**

	Com base no nome do arquivo fonte ou driver.

- **vertical.ini**

	Para sistemas com orientação vertical do monitor.

- **horizont.ini**

	Para sistemas com orientação horizontal do monitor.

- **vector.ini**

	Para sistemas com vetores apenas.

- **<parent>.ini**

	Para clones apenas, poderá ser chamado de forma recursiva.

- **<nome-do-driver-do-sistema>.ini**

	Para aplicar as opções apenas no driver do sistema, use o comando
	abaixo para saber qual o nome do driver de um determinado sistema:

	Exemplo:
		.. code-block:: shell

			mame -ls sf2
			sf2              capcom/cps1.cpp

	O nome do driver é **cps1** (sem a extensão .cpp), portanto,
	o nome do arquivo de configuração deve ser **cps1.ini**.

	Consulte o capítulo :ref:`advanced-multi-CFG` para obter mais
	informações.

	Exemplo:
		.. code-block:: shell

			mame sf2ce -norc -ctrlr sf2

	As configurações nos INIs posteriores substituem aquelas dos INIs
	anteriores.
	Então, por exemplo, caso queira desativar os efeitos de
	sobreposição nos sistemas vetoriais, é possível criar um arquivo
	**vector.ini** com a linha ``effect none`` nele, que irá
	sobrescrever qualquer valor de efeito existente no seu **mame.ini**.

			O valor predefinido é ``ligado`` (**-readconfig**).

.. raw:: latex

	\clearpage


.. _mame-commandline-nowriteconfig:

**-[no]writeconfig** / **-[no]wc**

	Grava as configurações feitas no driver do sistema num arquivo
	(driver).ini ao encerrar da emulação. O valor predefinido é
	``desativado`` (**-nowriteconfig**).

	Exemplo:
		.. code-block:: shell

			mame sf2ce -wc -ctrlr sf2


.. raw:: latex

	\clearpage


.. _mame-commandline-pathoptions:

Opções para a configuração das principais pastas
------------------------------------------------

.. _mame-commandline-homepath:

**-homepath** <*caminho*>

	Define o caminho para onde os **plugins** Lua armazenarão os
	dados. O valor predefinido é '.' (|ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -homepath D:\mame\lua


.. _mame-commandline-rompath:

**-rompath** / **-rp** / **-biospath** / **-bp** <*caminho*>

	Define o caminho completo para encontrar imagens ROM, disco rígido,
	fita cassete, etc. |epdm|. O valor predefinido é
	**roms** (|oudc| **roms** |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -rompath D:\mame\roms;D:\MSX\floppy;D:\MSX\cass


.. _mame-commandline-hashpath:

**-hashpath** / **-hash_directory** / **-hash** <*caminho*>

	Define o caminho completo para a pasta com os arquivos **hash**
	utilizados pelo *catálogo de programas* no gerenciador de arquivos.
	|epdm|. O valor predefinido é **hash** (|oudc| **hash** |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -hashpath D:\mame\hash;D:\roms\softlists


.. _mame-commandline-samplepath:

**-samplepath** / **-sp** <*caminho*>

	Define o caminho completo para os arquivos de amostras (samples).
	|epdm|. O valor predefinido é **samples** (|oudc| **samples**
	|ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -samplepath D:\mame\samples;D:\roms\samples


.. _mame-commandline-artpath:

**-artpath** <*caminho*>

	Define o caminho completo para os arquivos com as ilustrações
	gráficas (*artworks*) dos sistemas. Essas ilustrações são imagens
	que cobrem o fundo da tela e oferecem alguns efeitos interessantes.
	|epdm|. O valor predefinido é **artwork** (|oudc| **artwork**
	|ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -artpath D:\mame\artwork;D:\emu\shared-artwork


.. raw:: latex

	\clearpage


.. _mame-commandline-ctrlrpath:

**-ctrlrpath** <*caminho*>

	Define um ou mais caminhos para os arquivos de configuração dos
	controles. |epdm|. É usado em conjunto com a opção
	:ref:`ctrlr <mame-commandline-ctrlr>`.
	
		O valor predefinido é **ctrlr** (|oudc| **ctrlr** |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -ctrlrpath D:\mame\ctrlr;D:\emu\meus_controles


.. _mame-commandline-inipath:

**-inipath** <*caminho*>

	Define um ou mais caminhos onde os arquivos **.ini** podem ser
	encontrados. |epdm|.

	* No Windows a predefinição é **.;ini;ini/presets**, ou seja,
	  a primeira procura é feita na pasta atual, a segunda na
	  pasta **ini** e, por fim, na pasta **presets** dentro da
	  pasta **ini**.

	* No macOS a predefinição é
	  **$HOME/Library/Application Support/mame;$HOME/.mame;.;ini**,
	  ou seja, a primeira procura é feita na pasta **mame** dentro da
	  pasta **Application Support** do usuário atual, a segunda na pasta
	  **.mame** dentro da pasta **home** do usuário atual, então na
	  pasta raiz e, por fim, na pasta **ini**.

	* Em outras plataformas, como o Linux, a predefinição é
	  **$HOME/.mame;.;ini**, ou seja, a primeira procura é feita na
	  pasta **.mame** dentro da pasta **home** do usuário atual,
	  seguida pela pasta raiz, e por fim, pela pasta **ini**.

	::

		mame -inipath D:\mameini

.. _mame-commandline-fontpath:

**-fontpath** <*caminho*>

	Define um ou mais caminhos onde os arquivos de fonte **.bdf**
	(*Adobe Glyph Bitmap Distribution Format* ou formato de distribuição
	de mapa de bits da Adobe) possam ser encontrados.
	|epdm|. O valor predefinido é **.** (ou seja, |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -fontpath D:\mame\;D:\emu\fontes


.. _mame-commandline-cheatpath:

**-cheatpath** <*caminho*>

	Define o caminho completo para os arquivos de trapaça em formato
	**.xml**, **.zip** ou **.7z**. Quando mais de um caminho ou arquivo
	é informado, as trapaças são combinadas.
	|epdm|. O valor predefinido é **cheat** (|oudc| **cheat**, |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -cheatpath cheat;cheat_wayder


.. _mame-commandline-crosshairpath:

**-crosshairpath** <*caminho*>

	Define um ou mais caminhos onde os arquivos de mira (**crosshair**)
	possam ser encontrados. |epdm|. O valor predefinido é
	**crosshair** (|oudc| **crosshair** |ndrd|). Se uma mira for
	definida no menu, o MAME procurará por **nomedosistema\\cross#.png**,
	depois em **crosshairpath** especificado. O símbolo **#** indica o
	número do jogador.

	Caso nenhuma mira seja definida, o MAME usará a sua própria.

	Exemplo:
		.. code-block:: shell

			mame -crosshairpath D:\mame\crsshair;D:\emu\miras


.. _mame-commandline-pluginspath:

**-pluginspath** <*caminho*>

	Define um ou mais caminhos onde possam ser encontrados os plug-ins
	do Lua para o MAME. O valor predefinido é **plugins** (|oudc|
	chamado **plugins** |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -pluginspath D:\mame\plugins;D:\emu\lua


.. _mame-commandline-languagepath:

**-languagepath** <*caminho*>

	Define um ou mais caminhos onde os arquivos de tradução usados pela
	interface do usuário do MAME podem ser encontrados. O valor
	predefinido é **language** (|oudc| **language** |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -languagepath D:\mame\language;D:\emu\idiomas


.. _mame-commandline-swpath:

**-swpath** <*caminho*>

	Define um ou mais caminhos onde os arquivos avulsos dos programas
	(ROM, ISO, etc.) possam ser encontrados. O valor predefinido é
	**software** (|oudc| **software** |ndrd|).

	Exemplo:
		.. code-block:: shell

			mame -swpath D:\mame\floppy;D:\emu\discos


.. _mame-commandline-cfgdirectory:

**-cfg_directory** <*caminho*>

	Define a pasta onde os arquivos de configuração são armazenados.
	Os arquivos de configuração armazenam as customizações feitas pelo
	usuário e são lidos na inicialização do MAME ou de um sistema
	emulado. Ao encerrar o MAME, quaisquer alterações são salvas.

	Os arquivos de configuração preservam a ordem dos botões do seu
	controle ou joystick, as configurações das chaves DIP, as
	informações da contabilidade do sistema e a organização das janelas
	do depurador.

		O valor predefinido é **cfg** (|oudc| **cfg** |ndrd|). |snex|.

	Exemplo:
		.. code-block:: shell

			mame -cfg_directory D:\mame\cfg


.. raw:: latex

	\clearpage


.. _mame-commandline-nvramdirectory:

**-nvram_directory** <*caminho*>

	Define a pasta onde os arquivos **NVRAM** serão armazenados.
	Os arquivos **NVRAM** armazenam o conteúdo da **EEPROM**, memória
	RAM não volátil (NVRAM) e informações de outros dispositivos
	programáveis que utilizam esse tipo de memória. As informações são
	lidas no início da emulação e gravadas no término.

		O valor predefinido é **nvram** (|oudc| "nvram" |ndrd|). |snex|.

	Exemplo:
		.. code-block:: shell

			mame -nvram_directory D:\mame\nvram


.. _mame-commandline-inputdirectory:

**-input_directory** <*caminho*>

	Define a pasta onde os arquivos de gravação da entrada serão
	armazenados. As gravações de entrada são criadas pela opção
	**-record** e reproduzidas pela opção **-playback**. A opção
	grava todos os comandos e os acionamentos de botões que forem feitos
	durante a operação do sistema.

		O valor predefinido é **inp** (|oudc| **inp** |ndrd|). |snex|.

	Exemplo:
		.. code-block:: shell

			mame -input_directory D:\mame\inp


.. _mame-commandline-statedirectory:

**-state_directory** <*caminho*>

	Define a pasta onde os arquivos de gravação de estado serão
	armazenados. Os arquivos de estado são lidos e gravados quando
	solicitados pelo usuário ou ao usar a opção
	:ref:`-autosave <mame-commandline-noautosave>`.

		O valor predefinido é **sta** (|oudc| **sta** |ndrd|). |snex|.

	Exemplo:
		.. code-block:: shell

			mame -state_directory D:\mame\sta

.. _mame-commandline-snapshotdirectory:


**-snapshot_directory** <*caminho*>

	Define a pasta onde os arquivos de instantâneos da tela são
	armazenados quando solicitados pelo usuário.

		O valor predefinido é **snap** (|oudc| **snap** |ndrd|). |snex|.

	Exemplo:
		.. code-block:: shell

			mame -snapshot_directory D:\mame\snap


.. raw:: latex

	\clearpage


.. _mame-commandline-diffdirectory:

**-diff_directory** <*caminho*>

	Define a pasta onde os arquivos de diferencial do disco rígido
	serão armazenados. Os arquivos de diferencial armazenam qualquer
	dado que escrito de volta na imagem do disco. Isso serve para
	preservar a imagem original do disco. Esses arquivos são criados no
	início da emulação com uma imagem compactada do disco rígido.

		O valor predefinido é **diff** (|oudc| **diff** |ndrd|). |snex|.

	Exemplo:
		.. code-block:: shell

			mame -diff_directory D:\mame\diff


.. _mame-commandline-commentdirectory:

**-comment_directory** <*caminho*>

	Define a pasta onde os arquivos de comentário do depurador serão
	armazenados. Os arquivos de comentário do depurador são escritos
	pelo próprio depurador quando comentários são adicionados a um
	sistema descompilado (disassembly).

		O valor predefinido é **comments** (|oudc| **comments** |ndrd|).
		|snex|.

	Exemplo:
		.. code-block:: shell

			mame -comment_directory D:\mame\comments


.. _mame-commandline-sharedirectory:

**-share_directory** <*caminho*>

	Define a pasta que será compartilhada com o sistema ou o driver
	emulado. Por exemplo, no caso de um sistema operacional compatível,
	os arquivos colocados neste diretório serão compartilhados com o
	host emulado.

	Exemplo:
		.. code-block:: shell

			mame -share_directory D:\mame\share

.. raw:: latex

	\clearpage

Opções para a gravação e a reprodução do estado da emulação
-----------------------------------------------------------

.. _mame-commandline-norewind:

**-[no]rewind**

	Quando ativo e a emulação for paralisada, o estado da condição da
	memória toda a vez que um quadro for avançado será automaticamente
	salvo. Ao pressionar a tecla para rebobinar passo único
	(:kbd:`Shift` :kbd:`Esquerdo` + :kbd:`~`) [2]_, as
	condições de estado salvas podem ser carregadas de maneira
	consecutiva.

		O valor predefinido é ``desligado`` (**-norewind**).

	Caso o depurador esteja no estado *break*, a condição de estado
	atual é criada a cada "*step in*", "*step over*" ou "*step out*".
	Nesse modo os estados salvos podem ser carregados e rebobinados
	executando o comando **rewind** ou **rw** no depurador.

	Exemplo:
		.. code-block:: shell

			mame -norewind


.. _mame-commandline-rewindcapacity:

**-rewind_capacity** <*valor*>

	Define a capacidade de rebobinar em megabytes.
	É a quantidade total de memória que será utilizada para rebobinar
	os *savestates*. Quando a capacidade é alcança, os *savestates*
	antigos são apagados enquanto novos são capturados. Ao definir
	uma capacidade menor do que o *savestate* atual, o rebobinamento
	é desativado. Valores negativos são fixados automaticamente em
	``0``.

	Exemplo:
		.. code-block:: shell

			mame -rewind_capacity 30


.. _mame-commandline-statename:

**-statename** <*nome*>

	Descreve como o MAME deve armazenar os arquivos de estado salvos
	relativos ao caminho do "*state_directory*". <*nome*> é uma *string*
	(texto) que fornece um modelo a ser utilizado para gerar um nome de
	arquivo.

	São disponibilizadas duas substituições simples: o caractere ``/``
	representa o separador de caminho em qualquer plataforma de destino
	(inclusive mesmo no Windows); e a *string* ``%g`` representa o nome
	do driver do sistema atual.

		O valor predefinido é ``%g``, que cria uma pasta separada para
		cada sistema.

	E além disso, para os drivers que usam mídias diferentes, como
	cartões ou disquetes, é possível usar o indicador ``%d_[media]``.
	Substitua ``[media]`` pelo comutador de mídia desejado.

	Alguns exemplos:

	* Se usar o comando **mame robby -statename foo/%g%i**, as capturas
	  de tela serão salvas em **sta\\foo\\robby\\**.

	* Se usar o comando **mame nes -cart robby -statename %g/%d_cart**,
	  as capturas de tela serão salvas em **sta\\nes\\robby**.

	* Se usar o comando **mame c64 -flop1 robby -statename %g/%d_flop1/%i**,
	  as capturas de tela serão salvas como
	  **sta\\c64\\robby\\0000.png**.

.. raw:: latex

	\clearpage

.. _mame-commandline-state:

**-state** <*slot*>

	Após iniciar um sistema específico, carregue imediatamente o estado
	salvo no <*slot*>.

	Exemplo:
		.. code-block:: shell

			mame -state 1

.. _mame-commandline-noautosave:

**-[no]autosave**

	Quando ativado, cria automaticamente um arquivo com o estado atual
	do sistema ao encerrar o MAME e tenta carregá-lo automaticamente
	caso o MAME inicie novamente com o mesmo sistema. A opção só
	funciona para os sistemas compatíveis com o salvamento de
	estado.

		O valor predefinido é ``desligado`` (**-noautosave**).

	Exemplo:
		.. code-block:: shell

			mame -autosave


.. _mame-commandline-playback:

**-playback** / **-pb** <*nome do arquivo*>

	Reproduz um arquivo de gravação. Embora esse recurso não funcione de
	maneira confiável com todos os sistemas, ele pode ser usado para
	assistir a uma sessão de jogo gravada anteriormente do
	início ao fim. Para manter a consistência, apague os arquivos de
	configuração **.cfg**, NVRAM **.nv** e o cartão de memória antes de
	tentar reproduzir uma gravação. Consulte o comando
	:ref:`-record <mame-commandline-record>` para obter mais
	informações.

		O valor predefinido é ``NULO`` (sem reprodução).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -playback perfect

.. note:: Você pode ter problemas com a falta de sincronismo caso a
	configuração, a NVRAM, e o cartão de memória não coincidam com o
	original, principalmente se for usada uma versão diferente do MAME
	usada na gravação. É recomendável excluir a configuração (.cfg),
	a NVRAM (.nv) ou a pasta com o nome do sistema dentro da pasta
	**nvram** antes de iniciar uma gravação ou uma reprodução.

.. warning:: Para que a reprodução (*playback*) funcione em alguns
	sistemas onde os drivers usam **NVRAM**, como, por exemplo, os
	sistemas CPS1, CPS2 e CPS3. Manter ou não o arquivo de configuração
	nesses casos não faz diferença alguma. Então, caso pense em
	compartilhar a gravação com alguém, certifique-se de enviar junto o
	arquivo **NVRAM** do sistema em questão.

.. warning:: Em sistemas que não usam **NVRAM** como a *pacman*,
	*mspacman* dentre outras, elas também perdem o sincronismo e,
	algumas vezes, criam anomalias (bugs) apenas durante a reprodução.
	Neste caso apague o arquivo que mantém o registro de **high score**
	dentro da pasta **hi**. Se você mantém um registro de pontuações,
	faça um backup antes de apagar o arquivo.


.. raw:: latex

	\clearpage


.. _mame-commandline-exitafterplayback:

**-[no]exit_after_playback**

	O MAME encerra a emulação ao final do arquivo de reprodução se
	a opção **-playback** for usada. O padrão é não encerrar a emulação.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -playback perfect -exit_after_playback

		O valor predefinido é ``desligado`` (**-noexit_after_playback**).


.. _mame-commandline-record:

**-record** / **-rec** <*nome do arquivo*>

	Faz a gravação de todos os comandos feitos pelos usuários durante
	uma sessão e define o nome do arquivo onde esses comandos serão
	registrados. No entanto, esse recurso não funciona de maneira
	confiável com todos os sistemas.

		O valor predefinido é ``NULO`` (sem gravação).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -rec perfect

.. warning::

	Em alguns sistemas como o **neogeo** por exemplo, é preciso excluir
	a NVRAM **ANTES** de iniciar uma gravação ou a reprodução com
	:ref:`-playback <mame-commandline-playback>`. Caso contrário, a
	reprodução pode iniciar em um estágio diferente (como na série
	"*The King of Fighters*") e fazer com que a ação não corresponda ao
	que foi gravado, ou até mesmo causar uma interrupção abrupta da
	reprodução muito antes do fim. Se for iniciar a gravação do sistema
	**kof2002** por exemplo, dentro da pasta **NVRAM**, exclua a
	pasta **kof2002** ou uma pasta **kof2002_*** caso ela exista.
	Para obter mais informações, consulte :ref:`advanced-tricks-nvram`.


.. raw:: latex

	\clearpage

Opções para a gravação de áudio e vídeo
---------------------------------------

	Em alguns casos, certos sistemas alternam a resolução da tela, o que
	atrapalha a gravação de vídeo. Algumas gravações podem ficar com
	bordas pretas na tela e com o vídeo menor no meio ou em algum
	outro canto da tela. Nesses casos, use as opções
	:ref:`-noswitchres <mame-commandline-switchres>` com
	:ref:`-snapsize <mame-commandline-snapsize>`.

.. _mame-commandline-mngwrite:

**-mngwrite** <*nome do arquivo*>.mng

	Escreve cada quadro de vídeo em um arquivo <*nome do arquivo*> no
	formato MNG, produzindo uma animação da sessão.
	Note que a opção **-mngwrite** só grava quadros de vídeo, não grava
	qualquer áudio. Para gravar áudio, use a opção **-wavwrite**.
	Posteriormente, use uma ferramenta de edição para unir o áudio e o
	vídeo ou use **-aviwrite** para gravar ambos em um único arquivo.

		O valor predefinido é ``NULO`` (sem gravação).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -mngwrite ssf2tu-video.mng


.. _mame-commandline-aviwrite:

**-aviwrite** <*nome do arquivo*>.avi

	Grava todos os dados de áudio e vídeo em formato AVI sem compressão.
	É importante observar que a taxa de quadros e a resolução são sempre
	fixas. Vídeos sem compressão ocupam muito espaço, portanto é
	necessário um HD rápido (um SSD ou outro com grande velocidade de
	gravação, por exemplo) para que a gravação ocorra sem problemas.
	Para alterar a resolução do arquivo que será gravado, consulte a
	opção :ref:`-snapsize <mame-commandline-snapsize>`.

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

	Apenas grava apenas o áudio do jogo em formato PCM de 16 bits.
	Para gravar com uma taxa de amostragem diferente da predefinida
	(**48000 Hz**), consulte a opção
	:ref:`-samplerate <mame-commandline-samplerate>`.

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

	Descreve como o MAME deve nomear arquivos de captura de tela.
	Em <*nome*>, indica qual o nome que o MAME usará.

	São disponibilizadas três substituições simples:

* O caractere ``/``

	Usado como separador de caminho em qualquer plataforma inclusive no
	Windows.

* Especificador de conversão ``%g``

		Converte ``%g`` para o nome do driver que for usado.

* Especificador de conversão ``%i``

	Cria arquivos iniciando com nome **0000** e os incrementa à medida
	que novas capturas sejam criadas, O MAME incrementará o valor
	de ``%i`` para o próximo valor vazio. Se o nome omitido for igual ao
	de uma captura já existente, ela será substituído.

			O valor predefinido é ``%g/%i``.

	Para os drivers que usam mídias diferentes, como cartões ou
	disquetes, também é possível usar ``%d_[media]``.
	Substitua ``[media]`` pelo dispositivo que deseja usar.

	Alguns exemplos:

	* Se usar o comando **mame robby -snapname foo/%g%i** as
	  capturas serão salvas como **snaps\\foo\\robby0000.png**,
	  ``snaps\foo\robby0001.png`` e assim por diante.

	* Se usar o comando **mame nes -cart robby -snapname %g/%d_cart** as
	  capturas serão salvas como **snaps\\nes\\robby.png**.

	* E por fim, **mame c64 -flop1 robby -snapname %g/%d_flop1/%i**
	  estes serão salvos como **snaps\\c64\\robby\0000.png**.


.. _mame-commandline-snapsize:

**-snapsize** <*largura*> x <*altura*>

	Define um tamanho fixo para as capturas de tela e os vídeos.
	É predefinido que o MAME criará capturas de tela e vídeos na
	resolução nativa do sistema em pixels brutos. Se esta opção for
	usada, o MAME criará capturas de tela e vídeos no tamanho
	especificado, com filtro bilinear (filtro de embaçamento de pixels)
	aplicado no resultado final. Observe que, ao definir este tamanho, a
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

	Define a visualização que será utilizada nas capturas de tela e para
	gravar vídeos.

	É predefinido que ambos utilizem a primeira visualização que estiver
	disponível ou somente a da primeira tela. Ao usar esta opção, é
	possível alterar o comportamento predefinido da exibição e
	selecionar apenas a visualização que será aplicada a todas as
	capturas de tela e os vídeos.

	Observe que o <*tipo*> não precisa ser o nome exato;
	em vez disso, o MAME selecionará a primeira exibição cujo nome
	corresponda ao definido por meio do <*tipo*>. Supondo que o nome
	seja **Cabine Animada** basta usar **Cabine** ou
	**cabine**.

	Por exemplo, **-snapview native** casará a visualização
	:guilabel:`Nativa em (15:14)`, ainda que o nome não combine
	perfeitamente. O <*tipo*> também pode ser "auto", quando será
	escolhida a primeira exibição de todas que existirem.

	Nos casos em que você utiliza uma visualização com mais de uma opção
	ou que tenha nomes estranhos, nomes com caracteres não ASCII ou
	diferentes opções como mostrado no exemplo abaixo:

	* :guilabel:`XXYYZZ_01`
	* :guilabel:`XXYYZZ_02`
	* :guilabel:`XXYYZZ_03`

	 Use **-snapview XXYYZZ_03** para definir exatamente a visualização
	 desejada na sua captura.

		O valor predefinido é **internal**.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -snapview pixel


.. _mame-commandline-nosnapbilinear:

**-[no]snapbilinear**

	Especifique se o instantâneo ou vídeo deve ter filtragem bilinear
	aplicada. O filtro bilinear aplica um leve efeito de embaçamento ou
	suavização à tela, amenizando um pouco o serrilhado nos contornos
	gráficos e deixando a tela do sistema mais suave. Desligar essa
	opção pode fazer a diferença, melhorando o desempenho durante a
	gravação do vídeo ou deixando as capturas de tela com o pixel bruto.

		O valor predefinido é ``ligado`` (**-snapbilinear**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nosnapbilinear


.. raw:: latex

	\clearpage


Opções relacionadas ao desempenho e a velocidade da emulação
------------------------------------------------------------


.. _mame-commandline-noautoframeskip:

**-[no]autoframeskip** / **-[no]afs**

	Para manter a velocidade máxima de uma emulação, a quantidade de
	quadros que serão pulados é ajustada dinamicamente no sistema
	emulado. Ao ativar esta opção, ela se sobrepõe ao que for
	definido em **-frameskip**, descrito logo abaixo.

		O valor predefinido é ``desligado`` (**-noautoframeskip**).

	Exemplo:
		.. code-block:: shell

			mame gradius4 -autoframeskip

.. _mame-commandline-frameskip:

**-frameskip** / **-fs** <*quantidade*>

	Determina a quantidade de quadros que serão ignorados.
	Enquanto estiver sendo executado, ela elimina cerca de 12 quadros.
	Se o parâmetro **-frameskip 2** for definido, o MAME então exibirá
	10 de cada 12 quadros, por exemplo.

	Ao ignorar esses quadros, pode ser que se atinja a velocidade
	nativa do sistema emulado sem que haja sobrecarga no computador,
	ainda que ele não tenha um grande poder de processamento.

		O valor predefinido é não ignorar nenhum quadro (**-frameskip 0**).

	Exemplo:
		.. code-block:: shell

			mame gradius4 -frameskip 2

.. _mame-commandline-secondstorun:

**-seconds_to_run** / **-str** <*segundos*>

	Este comando pode ser usado para realizar um teste de velocidade de
	maneira automatizada. Ele instrui o MAME a interromper a emulação
	após alguns segundos. Ao combiná-lo com outras opções fixas de linha
	de comando, é possível definir um ambiente para realizar testes de
	desempenho. Ao encerrar, a opção **-str** captura a tela com o nome
	determinado pela opção :ref:`-snapname <mame-commandline-snapname>`
	dentro da pasta dos
	:ref:`instantâneos <mame-commandline-snapshotdirectory>`.

	O comando diz ao MAME para interromper a emulação após um
	tempo determinado. Esse tempo em questão não é o tempo real, e sim o
	tempo interno da emulação. Assim, se 30 segundos forem definidos,
	a parada pode demorar mais dependendo do sistema que estiver sendo
	emulado.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -str 60

.. raw:: latex

	\clearpage


.. _mame-commandline-nothrottle:

**-[no]throttle**

	Ativa ou não a função de controle de velocidade do emulador [4]_.
	Ao ativar esta opção, o MAME tenta manter o sistema rodando em
	sua velocidade nativa. Com a opção desativada, a emulação é
	executada na velocidade mais rápida possível. Dependendo das
	características do sistema emulado, o desempenho final pode
	se limitado pelo seu processador, pela sua placa de vídeo ou até
	mesmo pelo desempenho da sua memória.

		O valor predefinido é ``ligado`` (**-throttle**).

	Exemplo:
		.. code-block:: shell

			mame pacman -nothrottle


.. _mame-commandline-nosleep:

**-[no]sleep**

	Quando utilizada em conjunto com o **-throttle**, o MAME elimina
	os processos não utilizados durante a limitação de velocidade da
	emulação, melhorando o rendimento de processamento. Em outras
	palavras, permite que outros programas tenham mais tempo de CPU,
	desde que a emulação não esteja consumindo 100% dos recursos do
	processador. No entanto, essa opção pode causar uma certa
	intermitência no desempenho caso outros programas que também
	demandem processamento estejam em execução junto com o MAME.

		O valor predefinido é ``ligado`` (**-sleep**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nosleep


.. _mame-commandline-speed:

**-speed** <*fator*>

	Muda a forma como o MAME controla a velocidade da emulação, de
	modo a permitir que o sistema emulado rode em múltiplos
	da sua velocidade original.

	Um <*fator*> ``1.0`` significa que o sistema é executado á
	velocidade normal. Um fator ``0.5`` significa executar o sistema a
	metade da velocidade normal e um <*fator*> ``2.0`` significa
	executar o sistema 2 vezes mais rápido. Note que, ao alterar este
	valor, a velocidade de execução do áudio também será alterada
	proporcionalmente.

	A resolução interna da fração são dois pontos decimais, logo, o
	valor ``1.002`` será arredondado para ``1.0``.

		O valor predefinido é ``1.0``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -speed 1.25

	Quando utilizado em conjunto com a opção :ref:`-rec
	<mame-commandline-record>` é possível colocar o sistema em
	velocidade lenta, com a opção **-speed 0.3** enquanto grava. Ao
	terminar a gravação, a reprodução com a opção
	:ref:`-pb <mame-commandline-playback>` ocorrerá à velocidade normal,
	como se você tivesse jogado na velocidade nativa do sistema.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -rec perfect -speed 0.3 -sound none

	A opção **-sound none** serve para eliminar o áudio durante a
	gravação em velocidade lenta. Para mais informações, consulte
	:ref:`slowmomame <advanced-slowmomame>`.

.. raw:: latex

	\clearpage


.. _mame-commandline-norefreshspeed:

**-[no]refreshspeed** / **-[no]rs**

	Ele permite que o MAME ajuste a velocidade da emulação para que a
	taxa de atualização da primeira tela emulada não exceda a taxa de
	atualização da tela de qualquer um dos monitores do seu sistema.
	Visando evitar cortes no áudio ou efeitos colaterais indesejáveis,
	o MAME reduzirá a velocidade da emulação para 99% em casos em que,
	por exemplo, um monitor que funcione nativamente a 60 Hz e o
	sistema emulado rode a 60,6 Hz.

	Utilize esta opção caso note pequenas travadas de tela durante cenas
	de movimentação horizontal ou vertical.

		O valor predefinido é ``desligado`` (**-norefreshspeed**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -refreshspeed


.. _mame-commandline-numprocessors:

**-numprocessors** / **-np** <*auto|valor*>

	Define a quantidade de núcleos do processador que serão utilizados.
	A opção ``auto`` usará o número de núcleos informado pelo sistema
	ou pela variável de ambiente **OSDPROCESSORS**. Esse valor é
	limitado internamente para quatro vezes o número de processadores
	informado pelo seu sistema.

		O valor predefinido é ``auto``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -numprocessors 2

.. _mame-commandline-bench:

**-bench** <*n*>

	Define a quantidade de segundos de emulação em <*n*> usados para
	teste de desempenho. O comando é um atalho com o comando abaixo:

	**-str** <*n*> **-video none -sound none -nothrottle**

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -bench 300

.. _mame-commandline-lowlatency:

**-[no]lowlatency**

	Diz ao MAME para desenhar um novo quadro antes de controlar a
	velocidade de emulação (:ref:`throttling
	<mame-commandline-nothrottle>`) visando reduzir o atraso (latência)
	de resposta da entrada. Essa opção é particularmente efetiva com
	telas que variam sua taxa de atualização (Variable Refresh Rate).

	No entanto, ela pode causar um efeito colateral de despassamento ou
	problemas com o sequenciamento dos quadros, gerando instabilidades
	(especialmente em sistemas mais recentes com base 3D ou dependentes
	do 3D, assim como sistemas nos quais rodam um softwares similares ao
	sistema operacional).

		O valor predefinido é ``desligado`` (**-nolowlatency**).

	Exemplo:
		.. code-block:: shell

			mame bgaregga -lowlatency

.. raw:: latex

	\clearpage

Opções para a rotação da tela
-----------------------------

.. _mame-commandline-norotate:

**-[no]rotate**

	Gira a tela para que rla corresponda à orientação normal do sistema
	(horizontal ou vertical). Isso garante que os sistemas orientados
	vertical e horizontalmente sejam exibidos corretamente, sem a
	necessidade de girar fisicamente a tela. Caso queira manter a
	disposição da tela como ela é no arcade original, mantenha esta
	opção **desligada**.

		O valor predefinido é ``ligado`` (**-rotate**).

	Exemplo:
		.. code-block:: shell

			mame pacman -norotate

.. _mame-commandline-noror:

.. _mame-commandline-norol:

**-[no]ror**
**-[no]rol**

	Rotacione a tela do sistema para a direita **-ror** ou para a
	esquerda **-rol** em relação ao seu estado normal (caso **-rotate**
	seja definido) ou seu estado nativo (caso **-norotate** seja
	definido).

	O valor predefinido para ambas é ``desligado``
	(**-noror**, **-norol**).

	Exemplo:
		.. code-block:: shell

			mame pacman -ror
			mame pacman -rol


.. _mame-commandline-noautoror:

.. _mame-commandline-noautorol:

**-[no]autoror**
**-[no]autorol**

	Essas opções são projetadas para uso com telas giratórias que giram
	apenas em uma única direção. Se a tela girar somente no sentido
	horário, use o comando **-autorol** para garantir que o sistema
	preencha a tela horizontalmente ou verticalmente na direção
	desejada. Se a sua tela girar somente no sentido anti-horário,
	use **-autoror**.

	Exemplo:
		.. code-block:: shell

			mame pacman -autoror
			mame pacman -autorol


.. _mame-commandline-noflipx:

.. _mame-commandline-noflipy:

**-[no]flipx**
**-[no]flipy**

	Espelhe a tela do sistema horizontalmente com a opção **-flipx** ou
	verticalmente com **-flipy**. As inversões são aplicadas após as
	opções de rotação **-rotate** e rolagem **-ror/-rol**.

	O valor predefinido para ambas as opções é ``desligado``
	(**-noflipx**, **-noflipy**).

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

	Define qual tipo de saída de vídeo a ser utilizado. As opções
	descritas aqui dependem do sistema operacional utilizado e se a
	versão do MAME é SDL ou não.

**Opções geralmente disponíveis:**

.. _mame-commandline-video-bgfx:

	* **bgfx** (preferível)

	  Determina o novo renderizador acelerado por hardware. Utilize
	  esta opção caso a sua placa de vídeo seja compatível.

.. _mame-commandline-video-opengl:

	* **opengl**

	  Faz a renderização do vídeo usando `OpenGL <https://www.tecmundo.com.br/video-game-e-jogos/872-o-que-e-opengl-.htm>`_,
	  recomendado para sistemas Windows compatíveis quando as outras
	  opções causarem problemas.

	  Em sistemas não Windows, essa é a opção predefinida para a
	  renderizar a tela e para fazer a aceleração via hardware,
	  caso seja compatível com o seu sistema operacional e com a sua
	  placa de vídeo.

.. _mame-commandline-video-none:

	* **none**

	  Não exibe janelas e nem mostra nada na tela. É utilizado
	  principalmente utilizado para realizar testes de desempenho
	  (*benchmarks*),  usando apenas a CPU.

**No Windows:**

.. _mame-commandline-video-gdi:

	* **gdi**

	  Diz ao MAME para usar funções gráficas mais
	  antigas do Windows e renderizar o vídeo. Em termos de desempenho
	  é a opção mais lenta, porém é a mais compatível com as versões
	  mais antigas do Windows.

.. _mame-commandline-video-d3d:

	* **d3d** (obsoleto)

	  Diz ao MAME para renderizar a tela com o **Direct3D**. Isso produz
	  uma saída de melhor qualidade se comparada com a opção **gdi**,
	  além de permitir opções adicionais de renderização da tela e
	  aceleração gráfica via hardware.

	  É recomendável ter uma placa de vídeo mediana (2002+) ou uma placa
	  de vídeo Intel embutida, modelo *HD3000* ou superior.

	  .. note:: Essa opção já é obsoleta para um hardware mais moderno;
		prefira a opção ``bgfx`` usando o
		:ref:`bgfx_backend <advanced-bgfx-backend>` com ``d3d11`` ou a
		versão mais recente compatível com a sua placa. Caso a sua
		placa seja compatível, use ``vulkan`` para obter o melhor
		desempenho possível (isso também depende da compatibilidade
		relacionada ao desenvolvimento do MAME, do driver da sua placa
		de vídeo e do sistema operacional utilizado).

.. raw:: latex

	\clearpage

**Em outras plataformas (incluindo o SDL no Windows):**

.. _mame-commandline-video-accel:

	* **accel**

	  Diz ao MAME para, se possível, processar o vídeo usando a
	  aceleração 2D do SDL.

.. _mame-commandline-video-soft:

	* **soft**

	  A tela é renderizada por meio de software. Por não utilizar nenhum
	  tipo de aceleração de vídeo, o desempenho da emulação pode ser
	  penalizado, porém, há uma maior  compatibilidade em qualquer
	  plataforma.

* **Predefinições até a versão 0.240:**

	No Windows é ``d3d``.

	No macOS é ``opengl`` pois é quase certo que exista uma pilha
	OpenGL compatível.

	No Linux é ``opengl``.

	O valor predefinido para todos os outros sistemas é ``soft``.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -video bgfx

* **Predefinições após a versão 0.241:**

	Todos os sistemas passam a utilizar ``bgfx`` [#bgfx]_.

.. [#bgfx] https://github.com/mamedev/mame/commit/eee7d7d155d527996890a90c952f9856675c965d

.. _mame-commandline-numscreens:

**-numscreens** <*quantidade*>

	Diz ao MAME quantas telas devem ser criadas. Para a maioria dos
	sistemas, só exite uma, porém alguns sistemas originalmente usavam
	mais de uma (*como os sistemas Darius e Arcade PlayChoice-10, por
	exemplo*). Cada tela (até quatro), possui suas próprias
	configurações, taxa de proporção de tela, resolução e exibição, que
	podem ser definidas usando uma das opções abaixo.

		O valor predefinido é ``1``.

	Exemplo:
		.. code-block:: shell

			mame darius -numscreens 3
			mame pc_cntra -numscreens 2


.. _mame-commandline-window:

**-[no]window** / **-[no]w**

	Inicia a tela do MAME em uma janela em vez de na tela inteira.

		O valor predefinido é ``desligado`` (**-nowindow**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -window


.. raw:: latex

	\clearpage

.. _mame-commandline-maximize:

**-[no]maximize** / **-[no]max**

	Controla o tamanho inicial da janela. Se essa opção estiver ativada,
	a janela será exibida com o maior tamanho possível durante a
	inicialização do MAME. Com a opção desligada, a emulação terá
	início com o tamanho aproximado ao tamanho original do sistema, e a
	sua escala será em apenas um eixo quando os pixels não quadrados
	estiverem em uso. Essa opção apenas surte efeito quando a opção
	**-window** é utilizada.

		O valor predefinido é ``ligado`` (**-maximize**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -window -maximize


.. _mame-commandline-keepaspect:

**-[no]keepaspect** / **-[no]ka**

	Define se a proporção da tela deve ser mantida. Quando essa opção
	está ativa, a taxa de proporção adequada da tela do sistema é
	aplicada, geralmente 4:3 ou 3:4 para monitores CRT, dependendo da
	orientação. No entanto, muitas outras proporções de tela já foram
	usadas, como 3:2 (Nintendo Game Boy) e 5:4 para algumas estações de
	trabalho, entre outras.

	Se a tela que estiver sendo emulada ou a ilustração não preencher
	toda a tela, a imagem será centralizada com barras pretas
	adicionadas às laterais, conforme a necessidade, para ocupar os
	espaços não utilizados, seja na parte superior, inferior, esquerda
	ou direita.

	Ao desativar essa opção, a tela ou ilustração poderá ser esticada
	livremente para preencher os espaços vazios no modo janela. Em tela
	cheia, a imagem ficará distorcida e fora das proporções.

	Quando essa opção estiver ativa no Windows e o MAME estiver em modo
	janela, a proporção da tela será mantida mesmo que a janela seja
	redimensionada para tamanhos diferentes, desde que a tecla
	:kbd:`Ctrl` seja mantida pressionada durante o redimensionamento.

		O valor predefinido é ``ligado`` (**-keepaspect**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -ka

	A equipe do MAME sugere veementemente que essa opção seja mantida
	ativada. Esticar a tela do sistema além da proporção original causa
	distorções na sua aparência que vão muito além da capacidade de
	reparo dos filtros internos do MAME.


.. raw:: latex

	\clearpage


.. _mame-commandline-unevenstretch:

**-[no]unevenstretch** / **-[no]ues**

	Permite o uso de valores não inteiros para o redimensionamento da
	tela, o que pode distorcer ou esticar a imagem para preencher toda a
	tela. No entanto, há um preço a ser pago.

	O uso de valores não inteiros causa uma interferência chamada
	**aliasing** nos pixels [#aliasing]_ [#saaliasing]_. Imagine o mapa
	de um jogo feito de linhas retas com 1 pixel de largura. Quando
	ocorre o "*aliasing*", a linha que originalmente era feita com 1
	pixel de largura passa a ter 2 pixels ou mais. Essa interferência
	cria pixels onde antes não existiam, gerando distorções em **todos
	os pixels**. Abaixo, um exemplo com destaque nas regiões marcadas
	com vermelho, mas observe que o problema afeta toda a imagem.

	.. image:: images/pixel-aliasing.png
		:width: 100%
		:align: center
		:alt: pixel-aliasing


	.. raw:: html

		<p></p>


	Atualmente as pessoas sentem a necessidade de preencher toda a tela
	de uma TV 16:9 com gráficos feitos para 4:3, ainda que isso gere
	distorções em detrimento da desproporção dos gráficos.

	Esse é um assunto bem complexo, pois, apesar de todos os pixels do
	lado esquerdo estarem com os quadrados perfeitos, o que significa
	uma proporção de pixels de 1:1, também conhecido como
	`pixel perfect`_, a imagem está com as suas proporções erradas.
	Na época, os gráficos não foram desenvolvidos com os pixels no
	formato de um quadrado perfeito, e sim para terem 1 pixel mais alto
	visando às telas CRT 4:3 da época como mostra a imagem do lado
	direito.

	.. tip:: Leia mais sobre este assunto do formato de pixel na
		reportagem da página `Video Games Densetsu`_.

	Assim, apesar dos pixels estarem distorcidos na imagem da direita, a
	proporção dos gráficos está correta! Ao mesmo, apesar de os pixels
	estarem perfeitos do lado esquerdo, a proporção está errada.
	
	Com esta opção, é possível preencher a tela da sua TV 16:9 com
	gráficos desenvolvidos para uma tela 4:3, mas há distorções nos
	gráficos, que fica pior com textos.
	
	Consulte também :ref:`-aspect <mame-commandline-aspect>`, 
	:ref:`-keepaspect <mame-commandline-keepaspect>` e
	:ref:`-prescale <mame-commandline-prescale>`.

		O valor predefinido é ``ligado`` (**-unevenstretch**).

	.. raw:: latex

		\clearpage

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nounevenstretch


.. _mame-commandline-unevenstretchx:

**-[no]unevenstretchx** / **-[no]uesx**

	Permite que a proporção da tela seja desigual e que a tela ou
	janela possa ser preenchida (esticada) apenas na horizontal.

		O valor predefinido é ``ligado`` (**-unevenstretchx**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -uesx


.. _mame-commandline-unevenstretchy:

**-[no]unevenstretchy** / **-[no]uesy**

	Permite que a proporção da tela seja desigual e que a tela ou
	janela possa ser preenchida (esticada) apenas na vertical.

		O valor predefinido é ``ligado`` (**-unevenstretchy**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -uesy


.. _mame-commandline-autostretchxy:

**-[no]autostretchxy** / **-[no]asxy**

	Ao utilizar a opção **-unevenstretchx/y** a tela é esticada
	automaticamente com base na orientação nativa do sistema.

		O valor predefinido é ``desligado`` (**-noautostretchxy**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -asxy


.. _mame-commandline-intoverscan:

**-[no]intoverscan** / **-[no]ios**

	Permite que a imagem passe dos limites da tela (overscan) de alvos
	inteiros e dimensionáveis.

		O valor predefinido é ``desligado`` (**-nointoverscan**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -ios


.. _mame-commandline-intscalex:

**-[no]intscalex** / **-[no]sx** <*fator*>

	Define o fator da escala para o preenchimento e a aproximação (zoom)
	da tela na horizontal, não causando *aliasing* nos pixels quando
	utilizado sozinho ou até o fator **4.0**. Causa aliasing mínimo nos
	pixels quando utilizado em conjunto com a opção **-intscaley**.

		O valor predefinido é ``0.0`` (**-nointscalex 0.0**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -sx 1.0
			mame ssf2tu -nowindow -ka -sx 5.0 -sy 5.0

.. raw:: latex

	\clearpage

.. _mame-commandline-intscaley:

**-[no]intscaley** / **-[no]sy** <*fator*>
	Define o fator da escala para o preenchimento e a aproximação (zoom)
	da tela na vertical, não causando *aliasing* nos pixels quando
	utilizado sozinho ou até o fator **4.0**. Causa aliasing mínimo nos
	pixels quando utilizado em conjunto com a opção **-intscalex**.

			O valor predefinido é ``0.0`` (**-nointscaley 0.0**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -sy 1.0
			mame ssf2tu -nowindow -ka -sx 5.0 -sy 5.0


.. _mame-commandline-waitvsync:

**-[no]waitvsync**

	Aguarda o término do período de atualização da tela do monitor do
	seu computador antes de mostrar a imagem na tela. Caso essa opção
	esteja desligada, o MAME só irá mostrar a tela quando o quadro
	estiver pronto, mesmo que isso ocorra durante o processo de
	atualização da tela. Isso pode causar artefato de
	*screen tearing* [5]_.

	O efeito "*tearing*" não é perceptível em todos os sistemas, mas
	algumas pessoas acham o consideram desagradável, algumas mais do que
	outras.

	Os efeitos colaterais de se ativar a opção **-waitvsync** podem
	variar dependendo da combinação usada em diferentes sistemas
	operacionais e drivers de vídeo.

	No **Windows**, **-waitvsync** será bloqueado até o próximo
	apagamento de vídeo, permitindo que o MAME desenhe o próximo quadro
	e sincronizando a taxa de quadros do sistema emulado com a taxa de
	quadros nativa do monitor em uso. Apenas ative esta opção caso
	esteja utilizando o modo janela. Em tela inteira, esta opção só é
	necessária caso a opção **-triplebuffer** não remova o efeito
	*"tearing"* indesejado. neste caso, tente usar ambas as opções
	**-notriplebuffer -waitvsync**. Note que a opção **-waitvsync** não
	funciona em conjunto com a opção **-video gdi**.

	No **macOS**, **-waitvsync** não é bloqueado, mas o quadro
	completamente desenhado será exibido no próximo apagamento de vídeo
	(*VBLANK*). Isso significa que, se a taxa de quadros de um sistema
	emulado for maior do que a do seu sistema (ou do seu monitor),
	haverá uma queda periódica na velocidade dos quadros de vídeo
	emulados, resultando em pequenos travamentos durante as cenas com
	movimentos.

			O valor predefinido é ``desligado`` (**-nowaitvsync**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -waitvsync

	O **MAME SDL** funcionará nesse modo janela caso haja
	compatibilidade com o seu sistema operacional, com a sua placa de
	vídeo e os respectivos drivers.

	Para aumentar as suas chances de sucesso, rode o **MAME SDL** com a
	opção **-video opengl**.


.. raw:: latex

	\clearpage


.. _mame-commandline-syncrefresh:

**-[no]syncrefresh**

	Ativa o controle de velocidade da taxa de atualização do seu
	monitor. Isso significa que a taxa de atualização usada pelo sistema
	será ignorada, mas o código responsável pelo som tentará manter o
	sincronismo com a taxa de atualização usada pelo sistema, o que pode
	resultar em problemas com o som.

	Essa opção foi pensada para aqueles que modificaram as configurações
	da sua placa de vídeo, combinando uma opção a mais com as de
	atualização da tela. Essa opção não funciona com a opção
	**-video gdi**.

			O valor predefinido é ``desligado`` (**-nosyncrefresh**).

	Exemplo:
		.. code-block:: shell

			mame mk -syncrefresh

	.. tip::

		O syncrefresh pode ser útil para as pessoas com display
		compatível com G-Sync ou FreeSync.


.. _mame-commandline-prescale:

**-prescale** <*fator*>

	Controla a proporcionalidade da grandeza do redimensionamento do
	vídeo antes da aplicação de filtros ou shaders (texturas). Com o
	ajuste mínimo, a tela é renderizada em seu tamanho original antes de
	ser dimensionada. Com valores maiores, a tela é expandida pelo fator
	definido em <*fator*>. Isso gera imagens menos borradas com a
	opção **-video d3d** mas com perda de desempenho.

	Experimente usar **-prescale 4** ou valores maiores para atenuar um
	pouco as distorções causadas pela opção
	:ref:`-unevenstretch <mame-commandline-unevenstretch>` e para
	reduzir o efeito de "*blur*", mas lembre-se de que isso aumenta o
	processamento.

	Os valores válidos são ``1`` (mínimo) e ``8`` (máximo).

			O valor predefinido é ``1`` (**-prescale 1**).

	Funciona com todos os modos de vídeo no Windows (bgfx, d3d, etc.),
	mas nas outras plataformas funciona **APENAS** naquelas que forem
	compatíveis com o OpenGL. Não funciona com filtros
	:ref:`GLSL <mame-commandline-glglslfilter>`.

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -video d3d -prescale 3


.. _mame-commandline-filter:

**-[no]filter** / **-[no]d3dfilter** / **-[no]flt**

	Ativa o filtro bilinear, aplica um leve efeito de embaçamento ou
	suavização é aplicado à tela, amenizando um pouco o serrilhado nos
	contornos gráficos e suavizando a tela do sistema.

	Quando desativado, a imagem fica pura, com uma aparência serrilhada
	natural do sistema, e podem aparecer artefatos na tela em caso de
	redimensionamento. Se não gostar da aparência amaciada da imagem,
	tente aumentar o valor da opção **-prescale** em vez de desativar
	todos os filtros. Consulte também a opção
	:ref:`-gl_glsl_filter <mame-commandline-glglslfilter>`.

			O valor predefinido é ``ligado`` (**-filter**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -nofilter

	No Windows funciona com todos os modos de vídeo (bgfx, d3d, etc.),
	mas nas outras plataformas **apenas** aqueles compatíveis com o
	OpenGL.


.. _mame-commandline-noburnin:

**-[no]burnin**

	Monitora o brilho da tela durante a reprodução e, no final da
	emulação, gera um PNG que pode ser usado para simular um efeito
	burn-in [3]_ na tela. O PNG é criado de tal maneira que as
	áreas menos usadas da tela ficam totalmente brancas (pois as áreas a
	serem marcadas são escuras, todo o resto da tela deverá ficar um
	pouco mais iluminado).

	A intenção é que esse PNG possa ser carregado por meio de um arquivo
	de ilustração usando um valor alpha pequeno, como valores entre
	``0.1`` e ``0.2``, para se misturarem bem com o resto da tela.
	Os arquivos PNG gerados são gravados na pasta **snap** dentro da
	pasta **nome_do_sistema\burnin-<nome.da.tela>.png**.

			O valor predefinido é ``desligado`` (**-noburnin**).

	Exemplo:
		.. code-block:: shell

			mame neogeo -burnin


Opções para a configuração da tela inteira
------------------------------------------

.. _mame-commandline-switchres:

**-[no]switchres**

	Permite ou não a comutação ou a troca da resolução durante a
	emulação. Esta opção é necessária para as opções **-resolution**,
	evitando a troca das resoluções enquanto o modo de tela inteira
	estiver ativo.

	Em placas de vídeo modernas, há poucas razões para alternar as
	resoluções, a menos que o usuário esteja tentando alcançar as
	resoluções exatas dos pixels dos sistemas originais, o que exige
	ajustes consideráveis.

	Essa opção também é útil em monitores de LCD, pois eles operam com
	uma resolução fixa e as comutações da resolução às vezes são
	exageradas.

	Essa opção não funciona com a opção **-video gdi**.

			O valor predefinido é ``desligado`` (**-noswitchres**).

	Exemplo:
		.. code-block:: shell

			mame kof97 -switchres -resolution 978x720


Opções de vídeo para uso com janelas individuais
------------------------------------------------

.. _mame-commandline-screen:

**-screen[0-3]** <*display*>

	Define qual monitor físico do sistema será usado em cada janela.
	Para usar várias janelas, o valor da opção
	:ref:`-numscreens <mame-commandline-numscreens>` deve ser
	aumentado.
	O nome de cada tela do seu sistema pode ser identificado executando
	o MAME com a opção :ref:`-verbose <mame-commandline-verbose>`.
	Os nomes de cada tela geralmente estão no formato:
	No Windows, é: *\\\\.\\DISPLAYn*, e no macOS e em variantes do
	OpenGL, como Linux, por exemplo é *screenN* onde  o **n** ou **N**
	é um número do monitor conectado.

	O valor predefinido para essas opções é ``auto``.
	Isso significa que a primeira janela é colocada na primeira
	exibição, a segunda janela na segunda e assim por diante.

	Exemplo:
		.. code-block:: shell

			Windows
			mame pc_cntra -numscreens 2 -screen0 \\.\DISPLAY1 -screen1 \\.\DISPLAY2
			mame darius -numscreens 3 -screen0 \\.\DISPLAY1 -screen1 \\.\DISPLAY3 -screen2 \\.\DISPLAY2

			OpenGL (Mac, Linux, *nix)
			mame pc_cntra -numscreens 2 -screen0 screen0 -screen1 screen1
			mame darius -numscreens 3 -screen0 screen1 -screen1 screen3 -screen2 screen2


	Os parâmetros **-screen0**, **-screen1**, **-screen2** e
	**-screen3** são específicos para cada janela. Já o parâmetro
	**-screen** aplica a configuração a todas elas. As opções definidas
	para uma janela específica têm prioridade sobre as opções das outras
	janelas.


.. tip:: Utilize a opção **-verbose** para ver quais os displays
   estão disponíveis no seu sistema e qual é a sua resolução quando
   estiverem conectados.
.. note:: A partir de agora a opção de várias telas simultâneas pode
   não funcionar corretamente em alguns computadores Mac.


.. raw:: latex

	\clearpage


.. _mame-commandline-aspect:

**-aspect[0-3]** <*largura:altura*> / **-screen_aspect** <*num:den*>


	Define a proporção física do monitor para cada janela. Para usar
	várias janelas, é necessário aumentar o valor da opção
	**-numscreens**. A proporção física pode ser determinada medindo a
	largura e a altura da imagem visível da tela e definindo-as
	separadas por dois pontos.

		O valor predefinido para essas opções é ``auto``.

	Isso significa que o MAME assume que a proporção da tela é
	proporcional ao número de pixels no modo de vídeo da área de
	trabalho para cada monitor.

	Os parâmetros **-aspect0**, **-aspect1**, **-aspect2** e
	**-aspect3** são específicos para cada janela. O parâmetro
	**-aspect** se aplica à todas as janelas. As opções definidas para
	uma janela específica têm prioridade sobre as opções das outras
	janelas. Consulte
	:ref:`-unevenstretch <mame-commandline-unevenstretch>`.

	Exemplo:
		.. code-block:: shell

			mame contra -aspect 16:9
			mame pc_cntra -numscreens 2 -aspect0 16:9 -aspect1 5:4


.. _mame-commandline-resolution:

**-resolution[0-3]** <*[largura_x_altura]@[taxa de atualização]*> / **-r[0-3]** <*[largura_x_altura]@[taxa de atualização]*>

	Define a resolução exata a ser exibida. No modo de tela cheia, o
	MAME tentará usar a resolução solicitada. A largura e a altura são
	obrigatórias, e a taxa de atualização é opcional.

	Se uma dessas opções for omitida ou configurada para ``0``, o MAME
	determinará o modo automaticamente. Por exemplo, a opção
	**-resolution 640x480** forçará a resolução de 640x480, a taxa de
	atualização será escolhida pelo MAME.

	Da mesma forma, o comando **-resolution 0x0@60** obrigará que a taxa
	de atualização seja de 60 Hz, mas permitirá que o MAME escolha a
	resolução. O comando também funciona com ``auto`` e é o mesmo que
	``0x0@0``.

	No modo janela essa resolução é usada para determinar o tamanho
	máximo da janela. Essa opção também requer a utilização da opção
	:ref:`-switchres <mame-commandline-switchres>` para ativar a
	comutação de resolução juntamente com a opção **-video d3d**.

		O valor predefinido para essas opções é ``auto``.

	O parâmetro **-resolution0**, **-resolution1**, **-resolution2** e
	**-resolution3** se aplica a todas as janelas definidas.
	O parâmetro **-resolution** se aplica a todas elas.
	As opções específicas da janela substituem os valores das opções de
	todas as janelas.

	Exemplo:
		.. code-block:: shell

			mame pc_cntra -numscreens 2 -resolution0 768x720 -resolution1 640x480


.. _mame-commandline-view:

**-view[0-3]** <*nome*>

	Define a configuração da visualização inicial de cada janela.
	Note que o nome da visualização <*nome*> não precisa
	ser uma combinação exata; em vez disso, será selecionada a primeira
	exibição cujo nome corresponde a todos os caracteres especificados
	por <*nome*>.
	Por exemplo, **-view native** usa a visualização chamada
	"Native (15:14)", ainda que não seja o nome exato. Suponto que o
	nome seja **Cabine Animada** basta usar **Cabine** ou **cabine** e
	ignorando o **Animada**. O campo <*nome*> também funciona com a
	opção ``auto`` que faz com que um nome seja automaticamente
	escolhido.

		O valor predefinido para estas opções é ``auto``.

	Os parâmetros **-view0**, **-view1**, **-view2** e **-view3** se
	aplicam a todas as janelas especificadas. O parâmetro **-view** se
	aplica a todas elas.
	As opções definidas para uma janela substituem os valores das opções
	de todas as janelas.
	
	Para identificar qual o nome correto a ser utilizado com a opção
	**-view**, ao iniciar o sistema, pressione :kbd:`Tab` e vá até
	:guilabel:`Opções de Vídeo`. Escolha a visualização que mais lhe
	agrada e encerre a emulação. Na pasta **cfg**, haverá um arquivo
	de configuração com **nome_da_rom.cfg** (se usarmos o exemplo
	abaixo o nome do arquivo será **neobombe.cfg**). Abra-o em um editor
	de texto qualquer e veja, no campo :guilabel:`view`, qual a opção
	está sendo usada. Use-a na linha de comando, conforme o exemplo
	abaixo:

	Exemplo:
		.. code-block:: shell

			mame neobombe -view "Screen 0 Cropped (304x224)"


		.. tip:: Use aspas (**"**) no início e no final do nome da
			visualização, caso ele tenha espaços.


	Supondo que esta seja a sua opção de visualização preferida e caso
	queira aplicá-la a todos os sistemas deste driver, basta executar o
	comando **mame -ls neobombe** para identificá-lo. Com o nome do
	driver em mãos, crie o arquivo **neogeo.ini** dentro da pasta
	**ini\\source** e use a opção **view "Screen 0 Cropped (304x224)"**.

	Salve o arquivo e rode o sistema novamente na linha de comando sem a
	opção **-view**. Note que ele já começa com a opção selecionada de
	visualização.

.. raw:: latex

	\clearpage


Opções para uso com as ilustrações
----------------------------------

.. _mame-commandline-noartworkcrop:

**-[no]artwork_crop** / **-[no]artcrop**

	Ativa o recorte de arte somente na área da tela do sistema.
	Isso significa que sistemas com telas horizontais em modo de tela
	cheia podem exibir a sua ilustração à esquerda e à direita da tela.

	Na interface gráfica, essa opção está disponível em
	:guilabel:`Opções do vídeo` > :guilabel:`Tela #0`.

			O valor predefinido é ``desligado`` (**-noartwork_crop**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -artwork_crop

.. _mame-commandline-fallbackartwork:

**-fallback_artwork**

	Define uma ilustração alternativa caso nenhuma ilustração interna ou
	externa do layout tenha sido definida. Se houver uma ilustração para
	o sistema esteja presente ou se layout estiver incluso no driver do
	sistema, então este terá precedência.

	Exemplo:
		.. code-block:: shell

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

	Controla o nível de brilho ou de preto da tela. Essa opção não afeta
	a arte ou outras partes da imagem. Usando a interface interna do
	MAME, é possível configurar o brilho de cada tela do sistema e
	configurar o brilho de cada sistema individualmente. Ao selecionar
	valores menores (não menor que ``0.1``), a tela ficará mais escura,
	enquanto valores maiores (até ``2.0``) produzirão uma tela mais
	clara.

			O valor predefinido é ``1.0`` (**-brightness 1.0**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -brightness 0.5

.. _mame-commandline-contrast:

**-contrast** <*valor*>

	Ajusta a escala de luminância da tela. Essa opção não afeta a arte
	ou outras partes da tela. Usando a interface interna do MAME, é
	possível configurar o gamma para cada tela do sistema e para todos
	os sistemas individualmente. Essa opção define o valor inicial de
	luminância de todas as telas visíveis de todos os sistemas. Essa
	configuração oferece um ajuste linear da luminância do preto ao
	branco. Ao selecionar valores menores (não menor que ``0.1``), a
	luminância se aproxima mais do preto, enquanto valores maiores
	(até ``3.0``) a aproximam do branco.

			O valor predefinido é ``1.0`` (**-contrast 1.0**).

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

			O valor predefinido é ``1.0`` (**-gamma 1.0**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -gamma 0.8

.. _mame-commandline-pausebrightness:

**-pause_brightness** <*valor*>

	Ajusta a intensidade de brilho da tela durante a pausa.

			O valor predefinido é ``0.65`` (**-pause_brightness 0.65**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -pause_brightness 0.33

.. raw:: latex

	\clearpage


.. _mame-commandline-effect:

**-effect** <*nome do arquivo*>

	Use um arquivo **.png** como sobreposição na tela de qualquer
	sistema. Presume-se que o aquivo **.png** esteja em
	um dos diretórios raiz do :ref:`artpath <mame-commandline-artpath>`.

	Ambas as combinações horizontais e verticais dentro do arquivo
	**.png** são repetidas para cobrir toda a tela (mas nenhuma parte da
	arte externa). O arquivo é renderizado na resolução nativa do
	sistema.

	É possível adicionar o efeito de forma automática para sistemas com
	orientação horizontal ou vertical; basta criar os arquivos
	**vertical.ini** e **horizont.ini** dentro da pasta **ini**.
	No arquivo **vertical.ini** adicione a linha abaixo e salve ao
	terminar:

	Exemplo:
		.. code-block:: shell

			effect          RealScanlinesV

	Para o arquivo **horizont.ini** adicione a linha abaixo e salve ao
	terminar:

	Exemplo:
		.. code-block:: shell

			effect          RealScanlinesH

	Consulte o capítulo :ref:`Opções para a configuração
	<mame-commandline-noreadconfig>` para saber quais os arquivos
	**.ini** estão disponíveis.

	Para os modos de vídeo **-video gdi** e **-video d3d**, um pixel
	dentro do arquivo **.png** será mapeado para um pixel da tela.
	Os valores RGB de cada pixel dentro do arquivo **.png** são
	multiplicados pelos valores de RGB da tela de destino. Os arquivos
	de teste **RealScanlinesV** e **RealScanlinesH** estão disponíveis
	no `site do projeto`_.

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


	.. raw:: html

		<p></p>


	Claro que os exemplos acima são apenas exemplos e uma preferência
	estética particular. Existem diferentes outros tipos espalhados
	pela internet, e também é uma questão de gosto: há quem prefira os
	as texturas (*shaders*) que dão uma aparência muito mais convincente
	de um monitor CRT real. Para mais informações sobre esses efeitos
	consulte o capítulo :ref:`BGFX <advanced-bgfx>`,
	:ref:`HLSL <advanced-hlsl>`, :ref:`GLSL <advanced-glsl>` e a opção
	:ref:`-glsl_shader_mame <mame-commandline-glslshadermame>`.

.. raw:: latex

	\clearpage

Opções para sistemas que usem gráficos vetoriais
------------------------------------------------

.. _mame-commandline-beamwidthmin:

**-beam_width_min** <*largura*>

	Define a espessura mínima do feixe do vetor. Essa espessura varia
	entre um mínimo e um máximo à medida que a intensidade do traçado
	do vetor muda. Para desativar as alterações da largura do vetor com
	base na intensidade, defina o mesmo valor para **-beam_width_max** e
	**-beam_width_min**.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_width_min 0.1


.. _mame-commandline-beamwidthmax:

**-beam_width_max** <*largura*>

	Define a espessura máxima do feixe do vetor. Essa espessura varia
	entre um mínimo e um máximo à medida que a intensidade do traçado do
	vetor muda. Para desativar as alterações da largura do vetor com
	base na intensidade, defina o mesmo valor para **-beam_width_max** e
	**-beam_width_min**.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_width_max 2


.. _mame-commandline-beamdotsize:

**-beam_dot_size** <*tamanho*>

	Fator de escala que será aplicado ao tamanho dos pontos nos jogos
	vetoriais com ponto único. Normalmente esses são renderizados de
	acordo com a largura do feixe computado, no entanto, é comum que
	isso produza pontos difíceis de serem vistos. Esta opção aplica
	um fator de escala na largura do feixe para que esses fiquem
	mais visíveis.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_dot_size 2


.. _mame-commandline-beamintensityweight:

**-beam_intensity_weight** <*altura*>

	Define a intensidade do feixe do vetor. Esse valor determina como a
	intensidade afeta a largura. O valor ``0`` (zero) cria um mapeamento
	linear a partir da intensidade da largura. Valores negativos fazem
	com que os vetores de menor intensidade aumentem sua largura máxima
	mais rapidamente, enquanto valores positivos o fazem mais
	lentamente.

	Exemplo:
		.. code-block:: shell

			mame asteroid -beam_intensity_weight 0.5


.. _mame-commandline-flicker:

**-flicker** <*valor*>

	Simula um vetor de efeito de *tremulação* ou de oscilação da tela,
	semelhante ao que é visto em monitores desregulados, utilizados em
	jogos vetoriais. É necessário informar um valor flutuante (*float*)
	no intervalo entre ``0.00`` e ``100.00`` (``0`` = nenhum e ``100`` =
	máximo).

		O valor predefinido é ``0`` (**-flicker 0.0**).

	Exemplo:
		.. code-block:: shell

			mame asteroid -flicker 0.15

.. raw:: latex

	\clearpage


.. _mame-commandline-opengloptions:

Opções das principais características do vídeo OpenGL
-----------------------------------------------------

Essas são as opções compatíveis com a opção **-video opengl**. Caso
apareçam artefatos na tela, os desenvolvedores poderão solicitar que
você tente alterá-los. No entanto, normalmente esses valores devem ser
mantidos com seus valores originais para que se obtenha o melhor
desempenho possível.


.. _mame-commandline-glforcepow2texture:

**-[no]gl_forcepow2texture**

	Sempre utilize a potência de 2 para o tamanho das texturas.

			O valor predefinido é ``desligado``
			(**-nogl_forcepow2texture**).

.. _mame-commandline-glnotexturerect:

**-[no]gl_notexturerect**

	Não use o *OpenGL GL_ARB_texture_rectangle*

			O valor predefinido é ``ligado`` (**-gl_notexturerect**).

.. _mame-commandline-glvbo:

**-[no]gl_vbo**

	Ative o *OpenGL VBO* (Vertex Buffer Objects) caso esteja disponível.

			O valor predefinido é ``ligado`` (**-gl_vbo**).

.. _mame-commandline-glpbo:

**-[no]gl_pbo**

	Ativar o *OpenGL PBO* (Pixel Buffer Objects) caso esteja disponível.

			O valor predefinido é ``ligado`` (**-gl_pbo**).

.. raw:: latex

	\clearpage


.. _mame-commandline-openglglsl:

Opções de vídeo OpenGL GLSL
---------------------------

.. _mame-commandline-glglsl:

**-[no]gl_glsl**

	Ativar o *OpenGL GLSL* caso esteja disponível.

		O valor predefinido é ``desligado`` (**-nogl_glsl**).

	Exemplo:
		.. code-block:: shell

			mame galaxian -gl_glsl


.. _mame-commandline-glglslfilter:

**-gl_glsl_filter** <*valor*>

	Ativa a interpolação da imagem **OpenGL GLSL**, os valores
	válidos [6]_ são:

	* ``0``, Simples: método de interpolação rápida e menos precisa,
	  deixa os pixels com aparência serrilhada pois utiliza a técnica de
	  interpolação do `vizinho mais próximo`_.
	* ``1``, Bilinear: método de interpolação lento e de qualidade
	  mediana, que suaviza a transição entre as cores dos pixels,
	  deixando a imagem como um todo mais suave. Consulte também a opção
	  :ref:`-filter <mame-commandline-filter>`.
	* ``2``, Bicúbico: método de interpolação lento e mais preciso, que
	  suaviza a transição entre as cores dos pixels próximos, gerando
	  uma gradação mais suave. Também suaviza a imagem, porém não tanto
	  quanto o método bilinear.

		O valor predefinido é ``1`` (**-gl_glsl_filter 1**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -gl_glsl -gl_glsl_filter 0


.. _mame-commandline-glslshadermame:

**-glsl_shader_mame[0-9]**

	Define um efeito de textura (*shader*) OpenGL GLSL personalizada do
	MAME no slot fornecido entre ``0`` e ``9``. É possível aplicar um
	para cada slot. O MAME não vem com nenhuma textura (*shader*), mas
	alguns podem ser encontrados online, como no `mameau`_ e no
	`mameworld`_.

	Exemplo:
		.. code-block:: shell

			mame mpatrol -gl_glsl -gl_glsl_filter 0 -glsl_shader_mame0 glsl/osd/CRT-geom -resolution 992x756

		O valor predefinido é ``NULO`` (sem efeitos).


.. _mame-commandline-glslshaderscreen:

**-glsl_shader_screen[0-9]**

	Define um efeito de textura (*shader*) OpenGL GLSL personalizada do
	MAME que é escalado na tela para ser processado pela sua placa de
	vídeo no slot fornecido entre ``0`` e ``9``. Como no exemplo
	anterior, o MAME não vem com nenhuma textura (*shader*).

	Exemplo:
		.. code-block:: shell

			mame suprmrio -gl_glsl -glsl_shader_screen0 gaussx -glsl_shader_screen1 gaussy -glsl_shader_screen2 CRT-geom-halation

		O valor predefinido é ``NULO`` (sem efeitos).


.. raw:: latex

	\clearpage


.. _mame-commandline-soundoptions:

Opções para a configuração do áudio
-----------------------------------

.. _mame-commandline-samplerate:

**-samplerate** <*valor*> / **-sr** <*valor*>

	Define a taxa de amostragem do áudio. Valores menores, como
	``11025``, por exemplo, reduzem a qualidade do áudio, porém melhoram
	o desempenho da emulação. Valores maiores que ``48000``, por outro
	lado, aumentam a qualidade do áudio, mas reduzem o desempenho da
	emulação.

		.. note:: Observe que nem toda a placa de áudio suporta uma taxa
			de amostragem baixa como ``11025`` ou até mesmo taxas muitos
			mais altas que ``48000``. Consulte antes quais são os
			limites da sua placa de áudio.


		O valor predefinido é ``48000`` (**-samplerate 48000**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -samplerate 44100

.. _mame-commandline-nosamples:

**-[no]samples**

	Use arquivos de amostra, se houver. Esses arquivos são gravações
	analógicas feitas para registrar os efeitos de áudio usados por
	alguns sistemas.

		O valor predefinido é ``ligado`` (**-samples**).

	Exemplo:
		.. code-block:: shell

			mame qbert -nosamples


.. _mame-commandline-volume:

**-volume** / **-vol** <*valor*>

	Define o volume inicial. Ele pode ser alterado posteriormente usando
	a interface do usuário (consulte o capítulo :ref:`default-keys`).
	O valor do volume está definido em decibéis (**dB**); por exemplo,
	**-volume -12** iniciará a emulação com uma atenuação de **-12 dB**.
	Observe que, caso o volume seja alterado na interface do usuário,
	ele será salvo no arquivo de configuração do sistema. O valor do
	arquivo de configuração do sistema **tem prioridade** sobre as
	configurações de **volume** nos arquivos **INI**.

		O valor predefinido é ``0`` (**-volume 0**, sem atenuação com volume no máximo).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -volume -30


.. raw:: latex

	\clearpage


.. _mame-commandline-sound:

**-sound** < ``auto`` | ``dsound`` | ``sdl`` | ``coreaudio`` | ``xaudio2`` | ``portaudio`` | ``none`` >

	Defina o tipo de saída de áudio a ser usado. Ao selecionar ``none``,
	o áudio é desativado completamente, mas o hardware de áudio continua
	sendo emulado. Abaixo, estão as opções disponíveis para cada sistema
	operacional.

	As versões especiais, como o **SDLMAME** para Windows, podem usar a
	opção ``sdl`` e manter o **portaudio** desativado. O binário oficial
	do MAME para Windows não é compilado com SDL, sendo necessário
	compilar uma versão compatível para que a opção ``sdl`` funcione.

		O valor predefinido é ``dsound`` no Windows, no Mac é
		``coreaudio`` nas outras plataformas é ``sdl``.

	No Windows e no Linux a opção ``portaudio`` provavelmente oferecerá
	uma menor latência possível, enquanto no Mac a opção ``coreaudio``
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

	Nesta opção, a latência significa o tempo que o dispositivo de áudio
	demora para responder a um comando. Essa opção ajusta a quantidade
	dessa latência incorporada ao fluxo de dados de áudio.

	O comportamento exato depende do módulo de saída de áudio
	selecionado. Valores menores oferecem um menor atraso no áudio, mas
	exigem um desempenho maior do sistema. Valores maiores incrementam o
	atraso do áudio, porém ajudam a evitar o esvaziamento da memória
	intermediária (*buffer*) e as interrupções do áudio.

	Os valores válidos variam de ``0`` e ``5``, sendo ``2`` o valor
	predefinido (**-audio_latency 2**).

	Exemplo:
		.. code-block:: shell

			mame galaga -audio_latency 1


.. tip::
	| Para PortAudio, consulte :ref:`-pa_latency <mame-commandline-palatency>`.
	| O XAudio2 calcula a latência do áudio em passos de ``10ms``.
	| O DSound calcula a latência do áudio em passos de ``10ms``.
	| O CoreAudio calcula a latência do áudio em passos de ``25ms``.
	| O SDL calcula a latência do áudio em passos de ``Xms``.


.. _mame-commandline-paapi:

**-pa_api** <*interface*>

	O *PortAudio* é um novo recurso adicionado na versão `0.182`_ do
	MAME. Trata-se de uma **API** (*Application Programming Interface*),
	ou seja, uma "*Interface de Programação para Aplicações*". A API
	funciona como uma ponte, conectando aplicações ao hardware de
	maneira direta. Essa integração permite uma menor latência, pois há
	uma redução no fluxo de dados e estes são direcionados diretamente
	ao dispositivo de áudio. Com isso, o desempenho é otimizado de
	maneira geral, pois o que se economiza em processamento de áudio
	pode ser aproveitado pelo MAME em outros setores da emulação.

	Apesar de o *PortAudio* ser o que há de mais moderno em comparação
	com o *DirectSound* ou o *OpenGL Audio* e trazer muitos benefícios,
	há um ponto negativo: ele faz uso exclusivo do dispositivo de áudio.
	Isso significa que não será possível, por exemplo, escutar música ou
	qualquer outra coisa enquanto o MAME estiver rodando com o
	*PortAudio*.

	No Windows Vista ou em versões mais recentes, temos essas
	interfaces disponíveis:

	* **MME**: acrônimo para *Multimedia Extension*, criada pela
	  Microsoft para um sistema operacional pouco conhecido na época
	  chamado "*Windows with MultiMedia Extensions 1.0*", com base no
	  **Windows 3.0**. É uma das primeiras API para comunicação direta
	  com a placa de áudio. Essa interface já é obsoleta, mas ainda é
	  muito usada por questões de compatibilidade.

	* **Windows DirectSound**: é outra API introduzida pela Microsoft no
	  **Windows 95**, que adicionou uma camada de software entre a
	  aplicação e o dispositivo de som. Com ela, uma placa de som
	  poderia ter dois canais ou mais, efeitos de som 3D, aceleração de
	  áudio via hardware e a placa de som poderia ser compartilhada
	  entre diferentes aplicativos. Essa interface já é obsoleta, porém
	  ainda muito usada por questões de compatibilidade.

	* **Windows WDM-KS**: também criado pela Microsoft, foi introduzido
	  no **Windows 98** e no **Windows 2000**. O "KS" vem de "*Kernel
	  Streaming*", uma maneira ainda mais rápida de acessar o
	  dispositivo de áudio diretamente pelo núcleo do Windows. Apesar de
	  também fazer uso exclusivo do dispositivo de áudio, essa é a
	  interface mais problemática, pois é muito dependente da qualidade
	  dos drivers utilizados, gera problemas com a hibernação do Windows
	  quando há problemas com os drivers e não é a melhor opção.

	* **Windows WASAPI**: é um acrônimo para "*Windows Audio Session
	  API*", ou, em uma tradução livre, "*API da seção de áudio do
	  Windows*". Introduzido no **Windows Vista**, o *WASAPI* tem a
	  grande vantagem de poder enviar os fluxos de dados de áudio
	  diretamente para o dispositivo de áudio, sem a necessidade de
	  passar por nenhum tipo de *CODEC* (codificador/decodificador).
	  Outra característica do WASAPI é usar exclusivamente o dispositivo
	  de áudio, melhorando a latência e a qualidade do áudio.

	Para escolher qual interface usar, inicie o MAME conforme o
	exemplo abaixo:

	Exemplo:
		.. code-block:: shell

			mame -verbose -sound portaudio

	No Windows dentre as várias informações que aparecerão no terminal,
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

	No exemplo acima estão listados dois tipos de interface:
	**Windows WASAPI** e **Windows WDM-KS**. A utilização de qualquer
	uma dessas interfaces depende do driver da sua placa de áudio. Para
	definir a interface, use o nome dela entre aspas:
	**-pa_api "Windows WASAPI"** ou **-pa_api "Windows WDM-KS"**.

	Já no Linux, apesar do mesmo hardware, a lista é um pouco diferente:

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

		O valor predefinido é ``NULO`` (nenhuma interface *PortAudio*).


.. _mame-commandline-padevice:

**-pa_device** <*dispositivo*>

	Define qual dispositivo de áudio usar, conforme mostrado em
	:ref:`-pa_api <mame-commandline-paapi>`, e escolha um dos
	dispositivos listados. O nome do dispositivo fica do lado direito da
	lista e entre aspas. Usando o exemplo para o Windows, usaremos:

	Exemplo:
		.. code-block:: shell

			mame -verbose -sound portaudio -pa_api "Windows WASAPI" -pa_device "6 - SONY TV  *01 (AMD High Definition Audio Device)"

	Já para Linux e macOS, o comando também não é muito diferente para o
	mesmo dispositivo:

	Exemplo:
		.. code-block:: shell

			./mame -verbose -sound portaudio -pa_api ALSA -pa_device "HDA ATI HDMI: 0 (hw:1,3)"

	Como resultado, o MAME deverá exibir a mensagem abaixo, mostrando
	que tanto a interface quanto o dispositivo foram aceitos:

	Exemplo:
		.. code-block:: shell

			PortAudio: Using device "6 - SONY TV  *01 (AMD High Definition Audio Device)" on API "Windows WASAPI"


	O mesmo acontece com o Linux e macOS:

	Exemplo:
		.. code-block:: shell

			PortAudio: Using device "HDA ATI HDMI: 0 (hw:1,3)" on API "ALSA"
			PortAudio: Sample rate is 48000 Hz, device output latency is 8.00 ms

	Se nenhum for definido, o MAME escolherá o dispositivo padrão ou que
	estiver disponível.

		O valor predefinido é ``NULO`` (nenhum dispositivo *PortAudio*).


.. _mame-commandline-palatency:

**-pa_latency** <*segundos*>

	Escolha o tamanho em segundos da memória intermediária para a saída
	*PortAudio*. Números menores têm um menor atraso, porém valores
	muito altos podem aumentar a quantidade de cortes no áudio. Os
	valores compatíveis são apresentados em pontos decimais. Comece com
	valores como ``0.20`` e vá aumentando ou reduzindo esse valor até
	encontrar o valor apropriado para o seu hardware e sistema
	operacional.

		O valor predefinido é ``0`` (**-pa_latency 0**).

	Exemplo:
		.. code-block:: shell

			mame -verbose -sound portaudio -pa_api "Windows WASAPI" -pa_device "6 - SONY TV  *01 (AMD High Definition Audio Device)" -pa_latency 0.20

.. raw:: latex

	\clearpage


.. _mame-commandline-inputoptions:

Opções para as configurações de diferentes entradas
---------------------------------------------------

.. _mame-commandline-nocoinlockout:

**-[no]coin_lockout** / **-[no]coinlock**

	Simula o recurso "bloqueio de ficha", implementado em vários PCIs de
	jogos de arcade. Antes, cabia ao operador saber se as saídas de
	bloqueio da moeda estavam realmente conectadas aos mecanismos das
	moedas. Se esse recurso estiver ativado, as tentativas de inserir
	uma moeda enquanto o bloqueio estiver ativo falharão e uma mensagem
	será exibida na tela (no modo de depuração). Se a função estiver
	desativada, o sinal de bloqueio da moeda será ignorado.

		O valor predefinido é ``ligado`` (**-coin_lockout**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -coin_lockout

.. _mame-commandline-ctrlr:

**-ctrlr** <*controle*>

	Define um arquivo de configuração personalizada do controle,
	normalmente usado para definir novas atribuições das entradas
	predefinidas. Todas as pastas definidas em
	:ref:`ctrlr <mame-commandline-ctrlrpath>` são pesquisadas.
	Os arquivos de configuração do controle utilizam um formato similar
	ao **.cfg**, utilizado para gravar as configurações do sistema.
	Esses arquivos são criados durante a configuração dos botões do
	controle de um sistema e são gravados na pasta **cfg** como
	**nome_do_sistema.cfg**. Para mais informações, consulte os
	capítulos :ref:`ctrlrcfg` e :ref:`advanced-tricks-botões-ordem`.

		O valor predefinido é ``NULO`` (nenhum arquivo de configuração).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -ctrlr 6-botoes


.. _mame-commandline-nomouse:

**-[no]mouse**

	Define se o MAME faz uso ou não do mouse. Caso essa opção esteja
	ativa, o mouse ficará reservado para uso exclusivo do MAME até que a
	emulação seja pausada ou até que a emulação seja encerrada. A
	compatibilidade depende da configuração do seu
	:ref:`-mouseprovider <mame-commandline-mouseprovider>`.

	Observe que, se esta opção estiver desligada (**-nomouse**), a
	entrada do mouse ainda pode estar ativa, dependendo da
	entrada presente no sistema emulado e da sua
	:ref:`definição automática de entrada <mame-commandline-inputenable>`.
	Mais especificamente, o padrão é ativar a entrada do mouse quando o
	sistema emulado tiver entradas para o mouse
	(**-mouse_device mouse**), de modo que o ponteiro do seu mouse será
	capturado pelo MAME caso o sistema emulado tenha tal entrada, a
	menos que você altere a configuração através da opção
	:ref:`-mouse_device <mame-commandline-inputenable>`.

		O valor predefinido é ``desligado`` (**-nomouse**).

	Exemplo:
		.. code-block:: shell

			mame centiped -mouse


.. raw:: latex

	\clearpage


.. _mame-commandline-nojoystick:

**-[no]joystick** / **-[no]joy**

	Define se o MAME faz uso ou não de controle de jogos (joystick,
	gamepad e outras simulações de controles). A compatibilidade com os
	controles depende da configuração do seu
	:ref:`-joystickprovider <mame-commandline-joystickprovider>`.
	Se essa opção estiver ativa, o MAME perguntará sobre quais os
	controles estão atualmente conectados no sistema.

	Observe que, se esta opção estiver desligada (**-nojoystick**), a
	entrada do joystick ainda pode estar ativa, dependendo da
	entrada presente no sistema emulado e da sua
	:ref:`definição automática de entrada <mame-commandline-inputenable>`.

		O valor predefinido é ``desligado`` (**-nojoystick**).

	Exemplo:
		.. code-block:: shell

			mame mappy -joystick


.. _mame-commandline-nolightgun:

**-[no]lightgun** / **-[no]gun**

	Define se o MAME faz uso ou não de controles tipo arma de luz
	(lightgun). Observe que a maioria das armas de luz é mapeada
	para o mouse. Assim, ao usar as opções **-lightgun** e **-mouse**
	juntas, resultados inesperados podem ser obtidos.
	O suporte aos controladores da arma de luz depende das configurações
	do :ref:`-lightgunprovider <mame-commandline-lightgunprovider>`.
	Para mais informações, consulte o capítulo
	:ref:`arma-luz-funcionamento`.

	Observe que, se esta opção estiver desligada (**-nolightgun**), a
	entrada para a arma de luz ainda pode estar ativa, dependendo da
	entrada presente no sistema emulado e a sua
	:ref:`definição automática de entrada <mame-commandline-inputenable>`.

		O valor predefinido é ``desligado`` (**-nolightgun**).

	Exemplo:
		.. code-block:: shell

			mame lethalen -lightgun


.. _mame-commandline-nomultikeyboard:

**-[no]multikeyboard** / **-[no]multikey**

	Determina se o MAME diferencia entre os vários tipos de teclado
	disponíveis. Alguns sistemas podem reportar mais de um teclado; por
	padrão, os dados de todos esses teclados são combinados para que
	pareçam um só. Ao ativar essa opção, o MAME retornará quais teclas
	foram pressionadas em diferentes teclados de maneira independente.

		O valor predefinido é ``desligado`` (**-nomultikeyboard**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -multikey


.. _mame-commandline-nomultimouse:

**-[no]multimouse**

	Determina se o MAME diferencia entre os vários mouses disponíveis.
	Alguns sistemas podem reportar mais de um dispositivo de mouse; por
	padrão, os dados de todos esses mouses são combinados para que
	pareçam um só. Ao ativar esta opção, o MAME relatará o movimento e a
	pressão de botões do mouse de maneira independente, em diferentes
	mouses.

		O valor predefinido é ``desligado`` (**-nomultimouse**).

	Exemplo:
		.. code-block:: shell

			mame warlords -multimouse


.. raw:: latex

	\clearpage


.. _mame-commandline-nosteadykey:

**-[no]steadykey** / **-[no]steady**

	Alguns sistemas exigem que dois ou mais botões sejam pressionados
	exatamente ao mesmo tempo para executar movimentos ou comandos
	especiais. Devido à limitação do hardware do teclado, pode ser
	difícil ou até mesmo impossível realizar esse tipo de operação com
	um teclado comum. Essa opção seleciona diferentes modos de manuseio,
	o que torna mais fácil registrar o pressionamento simultâneo das
	teclas. Porém, tem a desvantagem de deixar a sua capacidade de
	resposta mais lenta.

		O valor predefinido é ``desligado`` (**-nosteadykey**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -steadykey


.. _mame-commandline-uiactive:

**-[no]ui_active**

	Ativa a opção para que a interface do usuário se sobreponha à do
	teclado emulado, caso esteja presente.

		O valor predefinido é ``desligado`` (**-noui_active**).

	Exemplo:
		.. code-block:: shell

			mame apple2e -ui_active


.. _mame-commandline-nooffscreenreload:

**-[no]offscreen_reload** / **-[no]reload**

	Ele controla se o MAME trata o segundo botão da arma de luz
	(*lightgun*) como um sinal para recarregá-la. Neste caso, o MAME
	reportará a posição da arma como (``0,MAX``) com o gatilho
	pressionado, o que equivale a uma recarga da arma apontada para fora
	da tela. Isso só é necessário para jogos que precisam que o usuário
	atire para fora da tela para recarregar a arma, e se a sua arma
	também não tiver essa funcionalidade.

		O valor predefinido é ``desligado`` (**-nooffscreen_reload**).

	Exemplo:
		.. code-block:: shell

			mame lethalen -offscreen_reload

.. raw:: latex

	\clearpage


.. _mame-commandline-joystickmap:

**-joystick_map** / **-joymap** <*mapa*>

	Controla como os valores do joystick analógico são mapeados para os
	controles em um joystick digital.

	Sistemas como o Pac-Man utilizam um controle digital com quatro
	posições (4-way joystick ou joystick de 4 vias), que exibe um
	comportamento inapropriado quando a diagonal é acionada: o Pac-Man
	simplesmente para nos cruzamentos do mapa, fazendo com que seja
	quase impossível jogá-lo direito ou, pelo menos, da maneira como foi
	desenvolvido para ser jogado. Outros sistemas arcade utilizam
	controles digitais do tipo *4-way* ou *8-way* (em vez de utilizarem
	controles analógicos). Assim, controles analógicos, como os
	utilizados em sistemas de voo com manches ou "*thumb sticks*"
	analógicos, precisam ser mapeados para valores correspondentes aos
	controles digitais com 4 ou 8 posições.

	Para tanto, o MAME divide o alcance do controle analógico em uma
	grade 9x9, muito semelhante ao desenho abaixo:

	.. image:: images/9x9grid.svg
		:width: 50%
		:align: center
		:alt: Grade 9x9

	Então, o MAME assume a posição do eixo do joystick (apenas os
	valores nos eixos X e Y), mapeia para esta grade e monitora a
	tradução a partir do mapa do joystick. Este parâmetro permite que
	você defina tal mapa.

	Um joystick com 8 posições, por exemplo, se assemelha à imagem
	abaixo:

	.. image:: images/8way.svg
		:width: 50%
		:align: center
		:alt: Joystick com 8 posições

	Esse mapeamento oferece uma grande margem de manobra para os ângulos
	aceitos em uma determinada direção, de modo que o controle se
	aproxime bastante da área desejada. Caso esteja um pouco fora do
	eixo central enquanto segura o controle para a esquerda, o sistema
	não reconhecerá a ação de forma adequada.

		O valor predefinido é ``auto``, o que significa que o controle
		padrão com 4, 8 posições ou um mapa diagonal para um controle
		com 4 posições é selecionado automaticamente com base nas
		informações da configuração da porta de entrada do sistema
		atual.

	Caso queira configurar a opção **-joystick_map** de forma individual
	através do **<sistema>.ini**, em vez da configuração do
	**mame.ini**, para que tais configurações afetem apenas os sistemas
	que necessitem desses mapeamentos. Para obter mais informações
	consulte o capítulo
	:ref:`Diversos arquivos de configuração <advanced-multi-CFG>`.

	Os mapeamentos são definidos como uma cadeia de caracteres e
	números. Como a grade possui 9x9, existem 81 caracteres no
	total para que seja possível definir um mapa completo. Abaixo, há um
	exemplo de um mapa para um joystick com 8 posições, que coincide com
	a imagem anterior.

	.. image:: images/joymap.svg
		:width: 100%
		:align: center
		:alt: exemplo mapa 8 posições

	Para definir um mapa com esses parâmetros, informe a cadeia de
	caracteres com as linhas separadas por um ponto (**.**) que indica o
	final de uma linha:

	Exemplo:
		.. code-block:: shell

			-joymap 777888999.777888999.777888999.444555666.444555666.444555666.111222333.111222333.111222333

	Contudo, é possível reduzir o tamanho do comando utilizando atalhos
	compatíveis com o parâmetro <*mapa*>. Se uma linha não tiver
	informações, presume-se que os dados faltantes nas colunas 5-9 sejam
	simétricos em relação à posição esquerda/direita em relação aos
	dados das colunas 0-4. O mesmo raciocínio vale para os dados que
	faltam nas colunas 0-4. A mesma lógica se aplica às linhas
	faltantes, exceto quando se assume a simetria cima/baixo.

	Ao utilizar esta forma abreviada, os 81 caracteres deste mapa podem
	ser simplificados para uma cadeia com 11 caracteres: ``7778...4445``
	(o que significa que podemos utilizar o comando
	**-joymap 7778...4445**).

	Olhando para a 1ª fileira, o ``7778`` tem apenas 4 caracteres.
	Não é possível utilizar a simetria na 5º entrada, então deduz-se
	que seja igual ao caractere anterior, '8'. O 6º caractere é
	simétrico à posição esquerda/direita em conjunto com o 4º caractere,
	resultando em um "8". O 7º caractere é simétrico com a posição
	esquerda/direita em conjunto com o 3º caractere, dando um "9" (que é
	"7" com os lados esquerdo e direito invertidos). Por fim, retorna o
	conjunto completo da linha ``777888999``.

	As carreiras dois e três estão faltando, então deduz-se que sejam
	idênticas à primeira linha. A 4ª carreira é decodificada de forma
	semelhante à 1ª, gerando ``444555666``. A quinta carreira está
	faltando, deduz-se, então, que seja a mesma que a 4ª.

	As outras três carreiras também estão faltando, então deduz-se que
	sejam espelhos do sentido cima/baixo das três primeiras, gerando as
	carreiras finais com ``111222333``.

	Em sistemas compatíveis com controles de quatro posições, o "sticky"
	(pegadiço) é importante para eliminar os problemas com as diagonais,
	ou seja, tudo o que for definido nessa área será ignorada pelo MAME.
	Geralmente, seria escolhido um mapa semelhante a este:

	.. image:: images/4way.svg
		:width: 50%
		:align: center
		:alt: Joystick com 4 posições

	Se você pressioná-lo e depois girar o controle para cima (sem passar
	pelo centro), o eixo do controle passará canto pegadiço, fazendo com
	que o movimento "pegue" ou "raspe" o manche nas diagonais, o que
	atrapalhará o movimento. Durante o movimento, o MAME interpretará
	essa posição como esquerda, ignorando a região pegadiça.
	Até que o movimento chega à posição superior do mapa, resultando no
	movimento para cima.

	O mapa ficaria então muito parecido com isso:

	.. image:: images/joymap-sticky.svg
		:width: 100%
		:align: center
		:alt: Joystick com 4 posições sticky

	Para definir um mapa com esses parâmetros ,informe a cadeia de
	caracteres com as linhas separadas por um ponto (**.**) que indica o
	final de uma linha:

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

	Caso esteja utilizando um joystick analógico, ele poderá estar um
	pouco fora de centro. O **-joystick_deadzone** informa uma folga ao longo
	de um eixo que deve ser ajustada antes que o eixo comece a mudar.
	Essa opção espera um valor flutuante (float) no intervalo entre
	``0.0`` e ``1.0``. Onde ``0`` é o centro do joystick e ``1`` é o
	limite externo.

	Em ocasiões em que o joystick aparente ser muito sensível, tente
	alterar o valor de **-joystick_deadzone** para ``0`` e o
	**-joystick_saturation** para ``1``.

		O valor predefinido é ``0.3`` (**-joystick_deadzone 0.3**).

	Exemplo:
		.. code-block:: shell

			mame sinistar -joystick_deadzone 0.3


.. _mame-commandline-joysticksaturation:

**-joystick_saturation** / **joy_saturation** / **-jsat** <*valor*>

	Caso esteja utilizando um joystick analógico, as extremidades podem
	estar um pouco fora de centro e não corresponderem às direções +/-.
	O **-joystick_saturation** define se uma folga no movimento do eixo
	será aceita até que o alcance máximo seja atingido. Essa opção
	espera um valor flutuante (float) no intervalo entre ``0.0`` até
	``1.0``. Onde  ``0`` é o centro do joystick e ``1`` é o limite
	externo.

		O valor predefinido é ``0.85`` (**-joystick_saturation 0.85**).

	Exemplo:
		.. code-block:: shell

			mame sinistar -joystick_saturation 1.0


.. _mame-commandline-joystickthreshold:

**-joystick_threshold** <*valor*> / **joy_threshold** <*valor*> / **-jthresh** <*valor*>

	Quando um eixo do *joystick* (ou outro eixo analógico absoluto) for
	atribuído a uma entrada digital, ele controla o quanto deve ser
	movido da posição neutra (ou centro) para ser considerado ativo ou
	ligado. Espera-se uma flutuação na faixa entre ``0.0`` e ``1.0``,
	sendo que ``0`` significa que qualquer movimento da posição neutra é
	considerado ativo, e ``1`` significa que apenas os limites externos
	são considerados ativos. Esse limite não é ajustado para a faixa
	entre a zona morta e o ponto de saturação. Observe que, caso um
	:ref:`mapa do joystick <mame-commandline-joystickmap>` seja
	configurado, essa configuração terá precedência sobre esta quando os
	eixos principais **X/Y** de um joystick forem atribuídos às entradas
	digitais.

		O valor predefinido é ``0.3``.

	Exemplo:
		.. code-block:: shell

			mame raiden -joystick_threshold 0.2


.. _mame-commandline-natural:

**-[no]natural**

	Permite que o usuário defina se deve ou não usar um teclado natural.
	Isso permite que o sistema funcione em modo *nativo*, dependendo da
	sua região, garantindo compatibilidade com teclados fora do padrão
	"*QWERTY*".

		O valor predefinido é ``desligado`` (**-nonatural**).

	No modo de "teclado emulado" (predefinido), o MAME traduz a
	pressão/liberação de teclas/botões do host em pressionamentos
	emulados de tecla. Ao pressionar ou soltar uma tecla ou botão
	mapeado para uma tecla emulada, o MAME pressiona ou libera a tecla
	emulada.

	No modo "teclado natural", o MAME tenta traduzir os caracteres para
	as teclas digitadas. O sistema operacional traduz pressionamentos de
	tecla a caracteres (da mesma forma que quando se digita em um editor
	de texto) e o MAME tenta traduzir esses caracteres para
	pressionamentos de tecla emulados.

**Existem várias limitações inevitáveis no modo "teclado natural":**

	* É necessário que o driver do sistema emulado ou do dispositivo de
	  teclado precisam seja compatível e tenha suporte para ele.
	* O teclado selecionado **deve** corresponder ao layout do teclado
	  selecionado no sistema operacional emulado.
	* As teclas que não produzam caracteres não serão traduzidas.
	* Segurar uma tecla até que o caractere se repita, fará com que ela
	  seja pressionada repetidamente, em vez de ser mantida
	  pressionada.
	* As sequências de chaves inativas, na melhor das hipóteses, são
	  complicadas de se usar.
	* Não funcionará se a edição do **IME** estiver envolvida como no
	  caso do chinês/japonês/coreano, por exemplo)

	Exemplo:
		.. code-block:: shell

			mame coco2 -natural


.. _mame-commandline-joystickcontradictory:

**-[no]joystick_contradictory**

	Aceita a entrada de comandos contraditórios e simultâneos no
	controle digital, como combinações simultâneas de **esquerda e
	direita** ou **cima e baixo**, por exemplo.

		O valor predefinido é ``desligado``
		(**-nojoystick_contradictory**).

	Exemplo:
		.. code-block:: shell

			mame ddr4m -joystick_contradictory


.. _mame-commandline-coinimpulse:

**-coin_impulse** *[n]*

	Define o tempo do sinal de impulso da moeda/ficha com base em *n*
	(``n<0`` desativa, ``n==0`` obedece o driver, ``0<n`` define o tempo
	em *n*).

		O valor predefinido é ``0`` (**-coin_impulse 0**).

	Exemplo:
		.. code-block:: shell

			mame contra -coin_impulse 1


.. raw:: latex

	\clearpage


.. _mame-commandline-inputenable:

Opções das entadas principais ativadas automaticamente
------------------------------------------------------

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

	Cada uma dessas opções de controle define se o ``mouse``, o
	``joystick`` ou o ``lightgun`` devem ser ativados ao executar a
	emulação de um sistema que usa uma classe específica de entradas
	analógicas. Essas opções podem definir o
	:ref:`-mouse <mame-commandline-nomouse>`, o
	:ref:`-joystick <mame-commandline-nojoystick>` ou o
	:ref:`-lightgun <mame-commandline-nolightgun>`, dependendo do tipo
	de entrada disponível no sistema emulado. Observe que essas opções
	não substituirão as configurações usadas explicitamente na linha de
	comando de **-nomouse**, **-nojoystick** ou **-nolightgun** em um
	nível de prioridade mais alto (estamos falando de um arquivo **INI**
	mais específico ou na linha de comando, por exemplo).

	Por exemplo, se você definir a opção **-paddle_device mouse**, os
	controles do mouse serão automaticamente ativados ao executar um
	jogo que tenha controles do tipo "*paddle*" (como o
	*Super Breakout*, por exemplo), mesmo que você tenha usado a opção
	**-nomouse**.

	A predefinição é ativar os controles do mouse automaticamente ao
	executar sistemas emulados com entradas do mouse
	(**-mouse_device mouse**).

	Exemplo:
		.. code-block:: shell

			mame sbrkout -paddle_device mouse

	.. Tip:: Observe que essas configurações podem substituir as opções
	         **-nomouse**, **-nojoystick** ou **-nolightgun**,
	         dependendo das entradas presentes no sistema emulado.


.. raw:: latex

	\clearpage


.. _mame-commandline-debugging:

Opções voltadas para a depuração
--------------------------------

.. _mame-commandline-verbose:

**-[no]verbose** / **-[no]v**

	Este é o **modo loquaz** [7]_, que exibe todas as informações de
	diagnóstico disponíveis. Essas informações são úteis para
	identificar qualquer tipo de problema com a sua configuração ou
	qualquer outro que possa aparecer.
	**IMPORTANTE**: para entrar em contato conosco para relatar um erro,
	rode o MAME com a opção **-verbose** e inclua essa saída ao seu
	relato.

		O valor predefinido é ``desligado`` (**-noverbose**).

	Exemplo:
		.. code-block:: shell

			mame ssf2tu -verbose


.. _mame-commandline-oslog:

**-[no]oslog**

	Escreve mensagens de diagnósticos do sistema em um arquivo
	**error.log**.

	É predefinido que as mensagens de erro sejam enviadas para a saída
	padrão, que geralmente é exibida no terminal, prompt de comando ou
	em um arquivo de log do sistema. No Windows, se um depurador estiver
	sendo usado, como o depurador do **Visual Studio** ou **WinDbg**,
	as mensagens de erros serão enviadas para ele em vez de serem
	exibidas no terminal.

		O valor predefinido é ``desligado`` (**-nooslog**).

	Exemplo:
		.. code-block:: shell

			mame mappy -oslog


.. _mame-commandline-log:

**-[no]log**

	Cria um arquivo chamado **error.log**, que contém todas as mensagens
	internas gerada pelo núcleo do MAME e pelos drivers do sistema.
	Isso pode ser usado em conjunto com a opção **-oslog** para escrever
	os dados de saída de ambos simultaneamente.

		O valor predefinido é ``desligado`` (**-nolog**).

	Exemplo:
		.. code-block:: shell

			mame mappy -log
			mame mappy -oslog -log


.. _mame-commandline-debug:

**-[no]debug** / **-[no]d**

	Ativa o depurador embutido no MAME. Ele entra em ação ao pressionar
	a tecla *til* :kbd:`~` [8]_ e a tecla de *acento grave* :kbd:`\\`
	durante a emulação. Ele também é direcionado para o depurador quando
	a emulação é redefinida, caso esta opção esteja ativa. Consulte
	:ref:`-debugger <mame-commandline-debugger>` para obter mais
	informações sobre como usar o depurador.

		O valor predefinido é ``desligado`` (**-nodebug**).

	Exemplo:
		.. code-block:: shell

			mame indy_4610 -debug

.. raw:: latex

	\clearpage


.. _mame-commandline-debugger:

**-debugger** <*módulo*>

	Escolhe o módulo que será usado para depurar o sistema quando a
	opção :ref:`-debug <mame-commandline-debug>` estiver ativada. A
	disponibilidade dos módulos de depuração depende da plataforma e
	das opções de compilação.

	Abaixo, estão os módulos compatíveis com esta opção:

	``windows``

		Depurador Win32 GUI (padrão no Windows). Compatível apenas no
		Windows.

	``qt``

		Depurador Qt GUI (padrão no Linux). Ele é compatível com
		Windows, Linux e macOS, mas é incluído apenas no Linux. Para
		torná-lo disponível no Windows ou macOS, defina a opção
		``USE_QTDEBUG=1`` ao compilar o MAME.

	``osx``

		Depurador Cocoa GUI (padrão no macOS). Compatível apenas no
		macOS.

	``imgui``

		O depurador ImgUi GUI é exibido na primeira janela do MAME.
		É preciso definir a opção :ref:`-video <mame-commandline-video>`
		como ``bgfx``. Ele é compatível com todas as plataformas que
		suportem a opção BGFX.

	``gdbstub``

		Ele atua como um servidor de depuração remota para o depurador GNU
		(GDB). O MAME suporta apenas um pequeno subconjunto emulado das
		CPUs. Utilize as opções
		:ref:`debugger_port <mame-commandline-debuggerport>` e
		:ref:`debugger_host <mame-commandline-debuggerhost>` para
		definir a porta de escuta e o endereço. É compatível com todas
		as plataformas que tenham suporte a TCP/IP.


	Examplo:
		.. code-block:: shell

			mame ambush -debug -debugger qt


.. _mame-commandline-debugscript:

**-debugscript** <*nome do arquivo*>

	Define um arquivo que conterá a lista de comandos de depuração a
	que serão executados no momento da inicialização.

		O valor predefinido é ``NULO`` (nenhum comando).

	Exemplo:
		.. code-block:: shell

			mame galaga -debugscript testscript.txt

.. raw:: latex

	\clearpage


.. _mame-commandline-updateinpause:

**-[no]update_in_pause**

	Ativa a atualização do bitmap inicial da tela enquanto o sistema
	estiver em pausa. Isso significa que a opção de retorno
	**VIDEO_UPDATE** sempre será chamada durante a pausa, o que pode ser
	útil para depurar o sistema.

		O valor predefinido é ``desligado`` (**-noupdate_in_pause**).

	Exemplo:
		.. code-block:: shell

			mame indy_4610 -update_in_pause


.. _mame-commandline-debuggerport:

**-debugger_port** <*porta*>

	Define o número da porta TCP para aceitar as conexões GDB ao usar o
	módulo de depuração do GDB (consulte a opção
	:ref:`-debugger <mame-commandline-debugger>`).

	A porta predefinida é ``23946``.

	Exemplo:
		.. code-block:: shell

			mame rfjet -debug -debugger gdbstub -debugger_port 2159


.. _mame-commandline-debuggerfont:

**-debugger_font** <*nome da fonte*> / **-dfont** <*nome da fonte*>

	Define o nome da fonte a ser usada nas janelas do depurador.

	A fonte predefinida é **Lucida Console**. Mo Mac (**Cocoa**), a
	fonte predefinida é o padrão da fonte de tamanho fixo do sistema
	(geralmente a fonte **Monaco**). A fonte padrão do Qt é
	**Courier New**.

	Exemplo:
		.. code-block:: shell

			mame marble -debug -debugger_font "Comic Sans MS"


.. _mame-commandline-debuggerfontsize:

**-debugger_font_size** <*pontos*> / **-dfontsize** <*pontos*>

	Define o tamanho da fonte a ser usada nas janelas do depurador
	em pontos.

	* O tamanho padrão da janela é de ``9`` pontos.
	* O tamanho padrão do Qt é de ``11`` pontos.
	* O tamanho padrão do Mac (**Cocoa**) é o tamanho padrão usado pelo
	  sistema.

	Exemplo:
		.. code-block:: shell

			mame marble -debug -debugger_font "Comic Sans MS" -debugger_font_size 16


.. _mame-commandline-watchdog:

**-watchdog** <*tempo*> / **-wdog** <*tempo*>

	Ativa o temporizador *watchdog* interno que vai matar o processo do
	MAME automaticamente caso o tempo de duração definido em
	<*tempo*> passe sem que haja nenhuma atualização de quadro.
	Tenha em mente que alguns sistemas ficam parados por algum tempo
	durante o carregamento da tela, então <*duration*> deve ser grande
	o suficiente para levar esse tempo extra em consideração.
	Geralmente, um valor entre ``10`` e ``30`` é suficiente.

		O valor predefinido é ``Nenhum``.

	Exemplo:
		.. code-block:: shell

			mame ibm_5150 -watchdog 30


.. raw:: latex

	\clearpage


.. _mame-commandline-debuggerhost:

**-debugger_host** <*endereço*>

	Defina o endereço IP que será utilizado para ouvir e aceitar
	conexões GDB ao usar o módulo de depuração do GDB (consulte a opção
	:ref:`-debugger <mame-commandline-debugger>`).

		O valor predefinido é ``localhost``.

	Examplo:
		.. code-block:: shell

			mame rfjet -debug -debugger gdbstub -debugger_host 0.0.0.0


.. _mame-commandline-commoptions:

Opções para a configuração da rede
----------------------------------

.. _mame-commandline-commlocalhost:

**-comm_localhost** <*endereço*>

	Definição para o endereço local. Ele pode ser um endereço
	tradicional, como ``192.168.0.1``, ou um nome de host que possa
	ser resolvido.

		O valor predefinido é ``0.0.0.0``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_localhost 192.168.1.2


.. _mame-commandline-commlocalport:

**-comm_localport** <*porta*>

	Definição da porta local. Ela pode ser qualquer porta de
	comunicação tradicional, com um valor inteiro entre ``0`` e
	``65535``.

		O valor predefinido é ``15122``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_localhost 192.168.1.2 -comm_localport 30100


.. _mame-commandline-commremotehost:

**-comm_remotehost** <*endereço*>

	Definição do endereço remoto. Ele pode ser um endereço tradicional,
	como ``192.168.0.1``, ou um nome de host que possa ser
	resolvido.

		O valor predefinido é ``0.0.0.0``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_remotehost 192.168.1.2


.. _mame-commandline-commremoteport:

**-comm_remoteport** <*porta*>

	Definição da porta remota. Ela pode ser qualquer porta de
	comunicação tradicional, como um valor inteiro *non-signed* de
	16-bit entre ``0`` e ``65535``.

		O valor predefinido é ``15122``.

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_remotehost 192.168.1.2 -comm_remoteport 30100


.. _mame-commandline-commframesync:

**-[no]comm_framesync**

	Sincroniza os quadros entre os hosts na rede.

		O valor predefinido é ``desligado`` (**-nocomm_framesync**).

	Exemplo:
		.. code-block:: shell

			mame arescue -comm_remotehost 192.168.1.3 -comm_remoteport 30100 -comm_framesync


.. raw:: latex

	\clearpage


.. _mame-commandline-miscoptions:

Opções diversas
---------------

.. _mame-commandline-drc:

**-[no]drc**

	Ativa o núcleo do DRC (recompilador dinâmico) da CPU para obter a
	velocidade máxima de emulação, se disponível.

	Na recompilação dinâmica, as instruções são traduzidas em tempo
	real, de modo a serem o mais próximas possível do sistema que está
	sendo emulado. Elas são reagrupadas em código de alto nível, que é
	então compilado na linguagem nativa do sistema hospedeiro. A grande
	vantagem dessa técnica é a melhor adequação do código gerado, o que
	resulta em melhor desempenho e eficiência durante a execução. Por
	outro lado, é necessário um poder de processamento muito maior para
	que isso seja possível.

		O valor predefinido é ``ligado`` (**-drc**).

	Exemplo:
		.. code-block:: shell

			mame ironfort -nodrc


.. _mame-commandline-drcusec:

**-[no]drc_use_c**

	Impõem o uso do DRC por meio da infraestrutura em código C.

		O valor predefinido é ``desligado`` (**-nodrc_use_c**).

	Exemplo:
		.. code-block:: shell

			mame ironfort -drc_use_c


.. _mame-commandline-drcloguml:

**-[no]drc_log_uml**

	Grava um registro descompilado DRC UML em um arquivo (log).

		O valor predefinido é ``desligado`` (**-nodrc_log_uml**).

	Exemplo:
		.. code-block:: shell

			mame ironfort -drc_log_uml


.. _mame-commandline-drclognative:

**-[no]drc_log_native**

	Grava o DRC nativo e descompilado em um arquivo log em formato
	assembler.

		O valor predefinido é ``desligado`` (**-nodrc_log_native**).

	Exemplo:
		.. code-block:: shell

			mame ironfort -drc_log_native


.. _mame-commandline-bios:

**-bios** <*nome da bios*>

	Determina qual BIOS usar no sistema a ser emulado em sistemas
	que fazem uso de uma BIOS. A opção
	:ref:`-listbios <mame-commandline-listbios>` listará todos os
	nomes disponíveis das BIOS para o sistema, assim como a opção
	:ref:`-listxml <mame-commandline-listxml>`.

	Não há valor predefinido: o MAME usará a primeira BIOS nativa
	do sistema, caso uma esteja disponível).

	Exemplo:
		.. code-block:: shell

			mame mslug -bios unibios40


.. raw:: latex

	\clearpage


.. _mame-commandline-cheat:

**-[no]cheat** / **-[no]c**

	Ativa o cardápio de trapaças, exibindo uma lista de trapaças que
	ficam armazenadas em um arquivo externo chamado **cheat.7z**.
	[#CHEAT]_ [#CHEAT2]_
	Essa opção também ativa as opções de turbo dos botões.

		O valor predefinido é ``desligado`` (**-nocheat**).

	Exemplo:
		.. code-block:: shell

			mame kof97 -cheat

..	[#CHEAT] O site `Pugsy's Cheat <http://cheat.retrogames.com/>`_ é um dos
		mais conhecidos que oferece um arquivo de trapaça para download.
..	[#CHEAT2] O site japonês
		`Wayder's Cheats <https://wayder.web.fc2.com/>`_ é um outro site
		conhecido que oferece um arquivo de trapaça para download. Para
		usar os dois juntos, consulte
		:ref:`-cheatpath <mame-commandline-cheatpath>`.


.. _mame-commandline-skipgameinfo:

**-[no]skip_gameinfo**

	Ao iniciar, faz com que o MAME não exiba a tela de informações do
	sistema.

		O valor predefinido é ``desligado`` (**-noskip_gameinfo**).

	Exemplo:
		.. code-block:: shell

			mame samsho5 -skip_gameinfo


.. _mame-commandline-uifont:

**-uifont** <*nome da fonte*>

	Define o nome da fonte ou o nome do arquivo de fonte a ser utilizado
	na interface do usuário. Se essa fonte não puder ser encontrada ou
	carregada, o MAME usará a sua própria. Em algumas plataformas, o
	<*nome da fonte*> pode ser um nome da fonte listada no sistema em
	vez do nome de arquivo com extensão **.bdf**. Para fontes com espaço
	no nome, utilize o nome entre aspas (**-uifont "nome do arquivo da
	fonte"**).

		O valor predefinido é ``default`` (O MAME usará a fonte nativa).

	Exemplo:
		.. code-block:: shell

			mame -uifont "Comic Sans MS"


.. _mame-commandline-ui:

**-ui** <*tipo*>

	Define o tipo de interface do usuário. as opções disponíveis são:

	* ``simple``, uma interface bem simplificada.
	* ``cabinet``, a mais completa.

		O valor predefinido é ``cabinet`` (**-ui cabinet**).

	Exemplo:
		.. code-block:: shell

			mame -ui simple


.. _mame-commandline-ramsize:

**-ramsize** / **-ram** <*n*>

	Permite alterar o tamanho padrão da RAM (caso haja suporte
	no sistema emulado). O valor dessa opção é ignorada em sistemas não
	compatíveis.

	Exemplo:
		.. code-block:: shell

			mame maclc -ramsize 10M -hard1 mac761.chd


.. _mame-commandline-confirmquit:

**-[no]confirm_quit**

	Remove o aviso na tela "*Tem certeza que deseja encerrar?*" ao
	pressionar a tecla :kbd:`Esc`.

		O valor predefinido é ``desligado`` (**-noconfirm_quit**).

	Exemplo:
		.. code-block:: shell

			mame pacman -confirm_quit


.. raw:: latex

	\clearpage


.. _mame-commandline-uimouse:

**-[no]ui_mouse**

	Exibe ou não o ponteiro do mouse na interface do MAME.

		O valor predefinido é ``ligado`` (**-ui_mouse**).

	Exemplo:
		.. code-block:: shell

			mame -ui_mouse


.. _mame-commandline-language:

**-language** / **-lang** <*idioma*>

	Especifique um idioma para ser usado na interface do usuário. Os
	arquivos de tradução para cada idioma estão no caminho definido em
	**languagepath**.

	Exemplo:
		.. code-block:: shell

			mame -language Portuguese_Brazil


.. _mame-commandline-nvramsave:

**-[no]nvram_save**

	Ao encerrar a emulação, o conteúdo da NVRAM é salvo. Se essa opção
	for desligada, o conteúdo gravado anteriormente não será apagado e
	qualquer alteração atual não será gravada. Quando desligado, os
	dados não serão salvos nos arquivos **.nv** associados a alguns
	tipos de programas usados em cartuchos.

		O valor predefinido é ``ligado`` (**-nvram_save**).

	Exemplo:
		.. code-block:: shell

			mame galaga88 -nonvram_save


.. raw:: latex

	\clearpage

Opções para uso com script
--------------------------

.. _mame-commandline-autobootcommand:

**-autoboot_command** / **-ab** "<*comando*>"

	Trata-se de uma cadeia de comandos que serão executados após a
	inicialização do sistema (entre aspas **" "**). Para emitir uma
	cotação para a emulação, use **"""** no comando. O uso de **\\n**
	cria uma nova linha e exibe o que foi digitado antes como comando.

	Exemplo:
		.. code-block:: shell

			mame c64 -autoboot_command "load """$""",8,1\n"


.. _mame-commandline-autobootdelay:

**-autoboot_delay** <*n*>

	Tempo de atraso (em segundos) para a opção **-autoboot_command**.

	Exemplo:
		.. code-block:: shell

			mame c64 -autoboot_delay 5 -autoboot_command "load """$""",8,1\n"


.. _mame-commandline-autobootscript:

**-autoboot_script** / **-script** <*nome_do_arquivo.lua*>

	Carrega e executa um scrit após a inicialização do sistema.

	Exemplo:
		.. code-block:: shell

			mame ibm5150 -autoboot_script myscript.lua


.. _mame-commandline-console:

**-console**

	Ativa emulador do console Lua.

		O valor predefinido é ``desligado`` (**-noconsole**).

	Exemplo:
		.. code-block:: shell

			mame ibm5150 -console


.. _mame-commandline-plugins:

**-plugins**

	Ativa o uso de plug-ins Lua, para mais informações consulte o
	capítulo :ref:`plugins`.

		O valor predefinido é ``ligado`` (**-plugins**).

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

	Permite desativar uma lista de plug-ins Lua separados por vírgula. ::

		mame alcon -noplugin cheat


.. raw:: latex

	\clearpage


.. _mame-commandline-webserver:

Opções do servidor HTTP
-----------------------

.. _mame-commandline-http:

**-http**

	Ativa o servidor HTTP.

		O valor predefinido é ``desligado`` (**-nohttp**).

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


.. [1]	Segundo o *Oxford Dictionary*, pattern significa "*arranjar
		algo de forma repetitiva, seguindo um padrão, uma padronagem*".
		Tradicionalmente "*pattern*" é traduzido como "*padrão*" porém
		fica claro que não se trata de algo igual sendo repetido,
		mas de um conjunto de instruções ou um conjunto de comandos em
		cadência que informam ao programa as opções desejadas pelo
		usuário.
.. [2]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
.. [3]	Quando uma imagem permanecia estática na tela de tubo CRT
		por muito tempo, a fina película de fósforo localizada
		trás da tela de vidro **queimava** levemente nas áreas de
		maior intensidade, deixando uma marca no lugar. Uma vez marcada,
		essa mancha ficava sobre a imagem como se fosse uma sombra e nem
		sempre era necessário que a tela estivesse ligada para que a
		mancha pudesse ser visualizada na tela.
.. [4]	O termo *throttle* em inglês significa "*parar/interromper a
		respiração através da esganadura da garganta*". Ele também pode
		para descrever a manutenção do controle da velocidade. Em
		inglês, este termo também é usado para descrever o acelerador de
		um veículo, que controla a sua velocidade.
.. [5]	Isso faz com que a metade superior da tela saia de sincronia
		com a metade inferior tela, surgindo um efeito ou um "*defeito*"
		no qual cada metade se desloca horizontalmente em lados opostos.
.. [6]	https://github.com/mamedev/mame/pull/2989/files
.. [7]	Tagarela, que verbaliza muito, falador, barulhento.
		(Nota do tradutor)
.. [8]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
..  [#OQEIU] Interface do Usuário.
..  [#aliasing]	https://en.wikipedia.org/wiki/Aliasing
..  [#saaliasing]	https://en.wikipedia.org/wiki/Spatial_anti-aliasing
.. _pixel perfect: https://tanalin.com/en/articles/integer-scaling
.. _find: https://learn.microsoft.com/pt-br/windows-server/administration/windows-commands/find
.. _findstr: https://docs.microsoft.com/pt-br/windows-server/administration/windows-commands/findstr
.. _Steam: https://store.steampowered.com
.. _Video Games Densetsu: https://vgdensetsu.tumblr.com/post/178414835138/from-chara-design-to-graphic-design-the-artists
.. _site do projeto: https://github.com/wtuemura/mamedoc/tree/master/artwork
.. _vizinho mais próximo: https://pt.wikipedia.org/wiki/Interpolação_por_vizinho_mais_próximo
.. _mameau: https://www.mameau.com/linux/mame-glsl-shaders-setup
.. _mameworld: https://www.mameworld.info/ubbthreads/showflat.php?Cat=&Number=368803&page=&view=&sb=5&o=&vc=1
.. _0.182: https://www.mamedev.org/?p=436
.. |epdm| replace:: É possível definir mais de um caminho, desde que
   estejam separados por ponto e vírgula(**;**)
.. |oudc| replace:: ou seja, uma pasta chamada
.. |snex| replace:: Se não existir, esta pasta será criada
   automaticamente.
.. |ndrd| replace:: na pasta raiz do MAME
