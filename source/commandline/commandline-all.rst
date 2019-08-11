.. _universal-command-line:

Opções Universais para a linha de comando
=========================================

.. _mame-commandline-paths:

Nome dos arquivos e a localização dos diretórios
------------------------------------------------

O MAME aceita o uso de mais de um caminho em suas configurações, como
por exemplo, configurações que permitam a pesquisa de ROMs em diferentes
locais, desde que tais configurações utilizem ``;`` para separar cada
caminho.

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
redirecionador para o diretório home do usuário, assim ao invés de se
digitar o caminho completo **/home/${USER}/.mame/cfg** é possível
possível simplificar usando **~/.mame/cfg**.

Note porém que o MAME só aceita interpretações de variáveis simples, o
MAME não reconhece expressões mais complexas compatíveis com Bash, ksh,
ou zsh.

Os caminhos relativos são resolvidos a partir do diretório de trabalho
atual. Caso você inicie o MAME com um clique duplo, o diretório de
trabalho atual será aquele onde estiver o executável do MAME. Caso faça
o mesmo usando um macOS, será aberto uma janela de terminal onde o seu
diretório home será o seu diretório de trabalho.

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

Muitos comandos suportam o uso de um *conjunto de instruções* [1]_, que
pode ser um sistema ou um nome abreviado do dispositivo (por exemplo,
**a2600**, **zorba_kbd**) ou um conjunto de instruções globais que
correspondam a um dos dois como ``zorba_*`` por exemplo.

Dependendo do comando com o qual você esteja combinando este conjunto de
instruções, a correspondência dessas combinações podem equiparar um
sistema ou sistemas e dispositivos. É aconselhável colocar aspas em
torno dos seus arranjos para evitar que o seu ambiente tente
interpretá-los de forma independente em relação aos nomes dos arquivos
que desejamos usar (por exemplo, ``mame -validate "pac\*"``).

Opções de ajuda e verificação
-----------------------------

.. _mame-commandline-help:

**-help** / **-h** / **-?**

	Exibe a versão atual do MAME e o aviso de direitos autorais.

.. _mame-commandline-validate:

**-validate** / **-valid** [<*pattern*>]

	Executa validação interna em um ou mais drivers e dispositivos
	no sistema. Execute isso antes de enviar qualquer alterações para
	nós visando garantir que você não tenha violado qualquer uma das
	regras do sistema principal.

	Caso um padrão seja definido, ele validará a correspondência
	predefinida do sistema em questão, caso contrário, validará todos
	os sistemas e dispositivos. Note que caso um padrão seja definido,
	este será comparado apenas com sistemas e não com outros
	dispositivos, nenhum tipo de validação será realizada com
	dispositivos.

.. _mame-commandline-verifyroms:

**-verifyroms** [<*pattern*>]

	Verifica se há imagens ROM inválidas ou ausentes. É predefinido que
	todos os drivers que possuam arquivos ``.zip`` ou diretórios válidos
	no rompath (caminho da rom) sejam verificados, no entanto, você pode
	limitar essa lista se usar um termo como filtro após o comando
	``-verifyroms``.

.. _mame-commandline-verifysamples:

**-verifysamples** [<*pattern*>]

	Verifica se há amostras inválidas ou ausentes. É predefinido que
	todos os drivers que possuem arquivos ``.zip`` ou diretórios válidos
	no samplepath sejam verificados no caminho da pasta onde os arquivos
	de amostras se encontram, no entanto, você pode filtrar essa lista
	caso use uma palavra chave ou coringa após o comando
	``-verifysamples``.

.. _mame-commandline-verifysoftware:

**-verifysoftware** / **-vsoft** [<*pattern*>]

	Verifica se há imagens ROM inválidas ou ausentes na lista de
	software. Por predefinição, todos os drivers que possuem arquivos
	``.zip`` ou diretórios válidos no rompath (caminho da rom) serão
	verificados, no entanto, você pode limitar essa lista definindo um
	nome de driver específico ou *combinações* após o comando
	``-verifysoftware``.

.. _mame-commandline-verifysoftlist:

**-verifysoftlist** / **-vlist** [*softwarelistname*]

	Verifica ROMs ausentes com base em uma lista de software
	predeterminado na pasta **hash**.
	É predefinido que a busca e a verificação será feita em todos os
	drivers e arquivos ``.zip`` em diretórios válidos no *rompath*
	(caminho da rom), no entanto, você pode filtrar essa lista usando
	uma palavra chave ou coringa em "*softwarelistname*" após o comando
	``-verifysoftlist``. As listas estão na pasta *hash* e devem ser
	informadas sem a extensão ``.xml``.

Opções de configuração
----------------------

.. _mame-commandline-createconfig:

**-createconfig** / **-cc**

	Cria um arquivo ``mame.ini`` pré-configurado. Todas as opções de
	configuração (não verbos) descritos abaixo podem ser permanentemente
	alterados, basta editar este arquivo de configuração.

.. _mame-commandline-showconfig:

**-showconfig** / **-sc**

	Exibe as configurações atualmente usadas. Caso você direcione isso
	para um arquivo, você também pode utilizá-lo como um arquivo
	``.ini``, como mostra o exemplo abaixo:

		**mame -showconfig > mame.ini**

	É o mesmo que **-createconfig**.

.. _mame-commandline-showusage:

**-showusage** / **-su**

	Exibe todas as opções disponíveis no MAME que sejam compatíveis com
	o seu sistema operacional ou a versão do MAME que estiver usando,
	cada opção será acompanhada de um breve descritivo (em inglês).

	As configurações nativas do Windows como hlsl por exemplo, não
	estarão disponíveis, tão pouco serão listadas nas versões SDL do
	MAME que rodem em Linux, macOS e assim por diante.

Opções para listagem
--------------------

É predefinido que todos os comandos ``-list`` abaixo, exibam informações
na saída predefinida do sistema, geralmente é a tela do terminal onde
você digitou o comando. Caso queira gravar a informação em um arquivo
texto, adicione o exemplo abaixo ao final do seu comando:

	**>** *nome do arquivo*

Onde '*nome do arquivo*' é o nome do arquivo texto onde você deseja
fazer o registro da saída (por exemplo, *lista.txt*). Note que qualquer
conteúdo prévio que exista dentro deste arquivo será apagado.
Exemplo:

	Isso cria (ou sobrescreve se já existir) o arquivo ``lista.txt`` e
	completa o arquivo com os resultados de ``-listcrc puckman``.
	Em outras palavras, a lista de cada ROM usada em Puckman e o CRC
	para essa ROM é gravada nesse arquivo.

.. _mame-commandline-listxml:

**-listxml** / **-lx** [<*pattern*>]

	Lista detalhes abrangentes de todos os sistemas e drivers
	suportados em formato XML. A saída é bastante longa, então é melhor
	redirecionar toda a saída para um arquivo. É predefinido que todos
	os sistemas sejam listados, no entanto, você pode filtrar essa lista
	caso use uma palavra chave ou coringa após o comando ``-listxml``.

.. _mame-commandline-listfull:

**-listfull** / **-ll** [<*pattern*>]

	Exibe uma lista com o nome da ROM e as suas respectivas descrições
	para cada máquinas.
	É predefinido que tudo seja listado, no entanto, você pode filtrar
	essa lista se usar um nome de máquina, jogo ou coringa após o
	comando ``-listfull``.

.. _mame-commandline-listsource:

**-listsource** / **-ls** [<*pattern*>...]

	Exibe uma lista dos drivers e todas as ROMs relacionado como o
	mesmo. Útil para localizar em qual driver está uma determinada ROM,
	como por exemplo ``mame64.exe pacman* -ls`` útil para relatar bugs.
	É predefinido que todos os sistemas sejam listados, no entanto, você
	pode filtrar essa lista caso use uma palavra chave ou coringa após o
	comando ``-listsource``.

.. _mame-commandline-listclones:

**-listclones** / **-lc** [<*pattern*>]

	Exibe uma lista de clones. É predefinido que todos os clones sejam
	listados, no entanto, você pode filtrar essa lista caso use uma
	palavra chave ou coringa após o comando ``-listclones``. O MAME irá
	irá exibir uma lista de clones dos sistemas ou qualquer outro clone
	que combine com a palavra chave caso uma seja usada.

.. _mame-commandline-listbrothers:

**-listbrothers** / **-lb** [<*pattern*>]

	Exibe uma lista de '*irmãos*', ou melhor, outros conjuntos que
	compartilham do mesmo driver que o nome do sistema pesquisado.

.. _mame-commandline-listcrc:

**-listcrc** [<*pattern*>...]

	Exibe uma lista completa de CRCs de todas as imagens ROM
	que compõem uma máquina, nomes de sistema ou dispositivo.
	Caso nenhum termo seja usado depois do comando, *todos* os
	resultados dos sistemas e dispositivos serão exibidos.

.. _mame-commandline-listroms:

**-listroms** / **-lr** [<*pattern*>]

	Exibe uma lista de todas as imagens contidas em uma ROM que fazem
	parte de uma máquina ou dispositivo. Pode ser filtrado caso seja
	usado um nome de sistema, dispositivos ou máquina. Caso nenhuma
	palavra chave seja usada como filtro após o comando, *todos* os
	resultados referente aos sistemas e dispositivos serão exibidos.

.. _mame-commandline-listsamples:

**-listsamples** [<*pattern*>]

	Exibe uma lista das amostras que fazem parte de uma determinada
	máquina, nomes de sistema ou nome de dispositivos. Caso nenhum termo
	seja usado como filtro depois do comando, *todos* os resultados dos
	sistemas e dispositivos serão exibidos.

.. _mame-commandline-romident:

**-romident** [*caminho\\completo\\para\\a\\rom\\a\\ser\\conferida.zip*]

	Tenta identificar os arquivos ROM conhecidos pelo MAME e que sejam
	compartilhados ou que também sejam usados por outras máquinas no
	arquivo ou diretório ``.zip`` determinado. Este comando pode ser
	usado para tentar identificar conjuntos de ROM retirados de placas
	desconhecidas.
	Na saída, o nível de erro é retornado como um dos seguintes:

		* 0: significa que todos os arquivos foram identificados
		* 7: significa que todos os arquivos foram identificados, exceto um ou mais arquivos não qualificados como "não-ROM"
		* 8: significa que alguns arquivos foram identificados
		* 9: significa que nenhum arquivo foi identificado

.. _mame-commandline-listdevices:

**-listdevices** / **-ld** [<*pattern*>]

	Exibe uma lista de todos os dispositivos conhecidos e conectados
	em uma determinada máquina como especificação de CPU, som, vídeo,
	tela, etc. Caso os slots sejam populados por dispositivos, todos os
	slots adicionais que esses dispositivos fornecerem ficarão visíveis
	com ``-listdevices`` também.
	Por exemplo, caso você instale um controlador de disquete em um
	PC, este listará os slots da unidade de disco.

.. _mame-commandline-listslots:

**-listslots** / **-lslot** [<*pattern*>]

	Mostra os slots disponíveis e as opções para cada slot caso
	estejam disponíveis. Usado principalmente pelo MAME para
	permitir o controle plug-and-play de placas internas, assim
	como os PCs que precisam de vídeo, som e outras placas de
	expansão.

		Caso os slots estejam populados com dispositivos, todos os slots
		adicionais que esses dispositivos fornecerem ficarão visíveis
		com **-listslots** também. Por exemplo, caso você instale um
		controlador de disquete em um PC, este listará os slots da
		unidade de disco.

		O nome do slot (por exemplo, **ctrl1**) pode ser usado a partir
		da linha de comando (``-ctrl1`` neste caso)

.. _mame-commandline-listmedia:

**-listmedia** / **-lm** [<*pattern*>]

	Liste a mídia disponível para uso do sistema. Isso inclui tipos
	de mídia como cartucho, cassete, disquete e mais. Extensões de
	arquivo comumente conhecidas também são suportadas.

.. _mame-commandline-listsoftware:

**-listsoftware** / **-lsoft** [<*pattern*>]

	Mostre na tela a lista de software completa que pode ser
	usadas através de um determinado termo ou sistema. Observe que
	isso é simplesmente um copiar/colar do arquivo .XML que reside
	na pasta HASH e que pode ser usada.

.. _mame-commandline-getsoftlist:

**-getsoftlist** / **-glist** [<*pattern*>]

        Postagens para exibir na tela uma listas de software específicos
        que correspondem ao nome do sistema fornecido.

.. raw:: latex

	\clearpage

.. _osd-commandline-options:

Opções relacionadas ao que é exibido na tela (OSD)
--------------------------------------------------

.. _mame-commandline-uimodekey:

**-uimodekey** [*keystring*]

	Tecla usada para ativar ou desativar os controles de teclado do
	MAME. A configuração predefinida é **SCRLOCK** no Windows,
	**Forward Delete** no macOS ou **SCRLOCK** em outros sistemas como
	Linux por exemplo. Use **FN-Delete** em computadores/notebooks
	Macintosh que usem teclados compactos.


.. _mame-commandline-uifontprovider:

**-uifontprovider**

	Define a fonte a ser renderizada na Interface do Usuário

	* No Windows, você pode escolher entre: **win**, **dwrite**, **none**
	  ou **auto**.

	* No Mac, você pode escolher entre: **osx**, **none** ou **auto**

	* Em outras plataformas você pode escolher entre: **sdl**, **none**
	  ou **auto**.

		O valor predefinido é **auto**

.. _mame-commandline-keyboardprovider:

**-keyboardprovider**

	Escolhe como o MAME lidará com o teclado.

	* No Windows, você pode escolher entre: **auto**, **rawinput**,
	  **dinput**, **win32**, ou **none**.
	* No SDL, você pode escolher entre: **auto**, **sdl**, **none**

		O valor predefinido é **auto**.

		No Windows, **auto** tentará o **rawinput**, caso contrário
		retornará para **dinput**. No SDL, o auto será predefinido como
		**sdl**.

.. _mame-commandline-mouseprovider:

**-mouseprovider**

	Escolhe como o MAME lidará com o mouse.

	* No Windows, você pode escolher entre: **auto**, **rawinput**,
	  **dinput**, **win32**, or **none**.
	* No SDL, você pode escolher entre: **auto**, **sdl**, **none**

		O valor predefinido é **auto**.

		No Windows, **auto** tentará o **rawinput**, caso contrário
		retornará para **dinput**. No SDL, o **auto** será predefinido
		como **sdl**.

.. _mame-commandline-lightgunprovider:

**-lightgunprovider**

	Escolhe como o MAME lidará com a arma de luz (*light gun*).

	* No Windows, você pode escolher entre: **auto**, **rawinput**,
	  **win32**, ou **none**.
	* No SDL, você pode escolher entre: **auto**, **x11**, **none**.

		O valor predefinido é **auto**.

		No Windows, **auto** tentará **rawinput**, caso contrário
		retornará para **win32** ou **none** caso não encontre nenhum.
		No SDL/Linux, **auto** é predefinido como **x11** ou **none**
		caso não encontre nenhum.
		Em outro tipo de SDL, **auto** será predefinido para **none**.

.. _mame-commandline-joystickprovider:

**-joystickprovider**

	Escolhe como o MAME lidará com o joystick.

	* No Windows, você pode escolher entre: **auto**, **winhybrid**,
	  **dinput**, **xinput**, ou **none**.
	* No SDL, você pode escolher entre: **auto**, **sdl**, **none**.

		O valor predefinido é **auto**.

		No Windows **auto** será predefinido para **dinput**.

	Repare que no controle do Microsoft X-Box 360 e X-Box One, eles
	funcionarão melhor com **winhybrid** ou **xinput**. A opção de
	controle *winhybrid* suporta uma mistura de DirectInput e Xinput ao
	mesmo tempo.
	No SDL, **auto** será predefinido para **sdl**.

Opções de MIDI e rede
---------------------

.. _mame-commandline-listmidi:

**-listmidi**

	Cria uma lista de dispositivos MIDI I/O disponíveis que possam ser
	usados com a emulação.

.. _mame-commandline-listnetwork:

**-listnetwork**

	Cria uma lista de adaptadores de rede disponíveis que possam ser
	usados com a emulação.

Opções de saída das notificações de tela
----------------------------------------

.. _mame-commandline-output:

**-output**

	Escolhe como o MAME lidará com o processamento de notificações de
	saída.

	Você pode escolher entre: **auto**, **none**, **console** ou
	**network**.

		O valor predefinido para a porta de rede é **8000**.


Opções para a configuração
--------------------------

.. _mame-commandline-noreadconfig:

**-[no]readconfig** / **-[no]rc**

	Habilita ou não a leitura dos arquivos de configuração,
	é predefinido que todos os arquivos de configuração sejam lidos em
	sequência como mostra a lista abaixo:

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

	Veja mais em :ref:`advanced-multi-CFG` para mais detalhes.

	As configurações nos INIs posteriores substituem aquelas dos INIs
	anteriores.
	Então, por exemplo, se você quiser desabilitar os efeitos de
	sobreposição nos sistemas vetoriais, você pode criar um arquivo
	``vector.ini`` com a linha **effect none** nele, ele irá
	sobrescrever qualquer valor de efeito que você tenha em seu
	``mame.ini``.

		O valor predefinido é **Ligado** (**-readconfig**).

.. _mame-commandline-nowriteconfig:

**-[no]writeconfig** / **-[no]wc**

	Grava as configurações feitas no driver da máquina em um arquivo
	(driver).ini ao sair da emulação.

		O valor predefinido é **Desligado** (**-nowriteconfig**).

Opções para a configuração dos diretórios principais
----------------------------------------------------

.. _mame-commandline-homepath:

**-homepath** <*caminho*>

	Define o caminho para onde os **plugins** Lua armazenarão dados.

		O valor predefinido é '.' (no diretório raiz do MAME).

.. _mame-commandline-rompath:

**-rompath** / **-rp** / **-biospath** / **-bp** <*caminho*>

	Define o caminho completo para encontrar imagens ROM, disco rígido,
	fita cassete, etc. Mais de um caminho podem ser definidos desde que
	estejam separados por ponto e vírgula.

		O valor predefinido é **roms** (isto é, um diretório chamado
		**roms** no diretório raiz do MAME).

.. _mame-commandline-hashpath:

**-hashpath** / **-hash_directory** / **-hash** <*caminho*>

	Define o caminho completo para a pasta com os arquivos **hash** que
	é usado pela *lista de software* no gerenciador de arquivos. Mais de
	um caminho podem ser definidos desde que estejam separados por ponto
	e vírgula.

		O valor predefinido é **hash** (isto é, um diretório chamado
		**hash** no diretório raiz do MAME).

.. raw:: latex

	\clearpage

.. _mame-commandline-samplepath:

**-samplepath** / **-sp** <*caminho*>

	Define o caminho completo para os arquivos de amostras (samples).
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula.

		O valor predefinido é **samples** (isto é, um diretório chamado
		**samples** no diretório raiz do MAME).

.. _mame-commandline-artpath:

**-artpath** <*caminho*>

	Define o caminho completo para os arquivos com as ilustrações
	gráficas (*artworks*) das máquinas. Essas ilustrações são imagens
	que cobrem o fundo da tela e oferecem alguns efeitos interessantes.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula.

		O valor predefinido é **artwork** (isto é, um diretório chamado
		**artwork** no diretório raiz do MAME).

.. _mame-commandline-ctrlrpath:

**-ctrlrpath** <*caminho*>

	Define o caminho completo para os arquivos de configuração
	específico para controle. Mais de um caminho podem ser definidos
	desde que estejam separados por ponto e vírgula.

		O valor predefinido é **ctrlr** (isto é, um diretório chamado
		**ctrlr** no diretório raiz do MAME).

.. _mame-commandline-inipath:

**-inipath** <*caminho*>

	Define um ou mais caminhos onde os arquivos ``.ini`` possam ser
	encontrados. Mais de um caminho podem ser definidos desde que
	estejam separados por ponto e vírgula.

	* No Windows a predefinição é ``.;ini;ini/presets``, tradzindo,
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

.. _mame-commandline-fontpath:

**-fontpath** <*caminho*>

	Define um ou mais caminhos onde os arquivos de fonte ``.bdf``
	(*Adobe Glyph Bitmap Distribution Format*) possam ser encontrados.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula.

		O valor predefinido é ‘.’ (isto é, no diretório raiz do MAME).

.. _mame-commandline-cheatpath:

**-cheatpath** <*caminho*>

	Define o caminho completo para os arquivos de trapaça em formato
	``.xml``.
	Mais de um caminho podem ser definidos desde que estejam separados
	por ponto e vírgula.

		O valor predefinido é **cheat** (isto é, uma pasta chamada
		**cheat**, localizada no diretório raiz do MAME).

.. raw:: latex

	\clearpage

.. _mame-commandline-crosshairpath:

**-crosshairpath** <*caminho*>

	Define um ou mais caminhos onde os arquivos de mira **crosshair**
	possam ser encontrados. Mais de um caminho podem ser definidos desde
	que estejam separados por ponto e vírgula.

		O valor predefinido é **crosshair** (isto é, um diretório
		chamado **crosshair** no diretório raiz do MAME). Caso uma mira
		seja definida no menu, o MAME procurará por
		``nomedosistema\\cross#.png``, em seguida no **crosshairpath**
		especificado onde **#** é o número do jogador.

		Caso nenhuma mira seja definida, o MAME usará a sua própria.

.. _mame-commandline-pluginspath:

**-pluginspath** <*caminho*>

	Define um ou mais caminhos onde possam ser encontrados os plug-ins
	do Lua para o MAME.

		O valor predefinido é **plugins** (isto é, um diretório chamado
		**plugins** no diretório raiz do MAME).

.. _mame-commandline-languagepath:

**-languagepath** <*caminho*>

	Define um ou mais caminhos onde possam ser encontrados os arquivos
	de tradução que o MAME usa na Interface do Usuário.

		O valor predefinido é **language** (isto é, um diretório chamado
		**language** no diretório raiz do MAME).

.. _mame-commandline-swpath:

**-swpath** <*caminho*>

		Define um ou mais caminhos onde possam ser encontrados os
		arquivos de programas avulsos (software).

		O valor predefinido é **software** (isto é, um diretório chamado
		**software** no diretório raiz do MAME).

.. _mame-commandline-cfgdirectory:

**-cfg_directory** <*caminho*>

	Define o diretório onde os arquivos de configuração são armazenados.
	Os arquivos de configuração armazenam as customizações feitas pelo
	usuário e são lidas na inicialização do MAME ou de uma máquina
	emulada, depois quaisquer alterações são salvas ao sair do MAME.

	Os arquivos de configuração preservam as configurações da ordem dos
	botões do seu controle ou joystick, configurações das chaves DIP,
	informações da contabilidade da máquina e a organização das janelas
	do depurador.

		O valor predefinido é **cfg** (isto é, um diretório com o nome
		**cfg** no diretório raiz do MAME). Caso este diretório não
		exista, ele será criado automaticamente.

.. _mame-commandline-nvramdirectory:

**-nvram_directory** <*caminho*>

	Define o diretório onde os arquivos **NVRAM** são armazenados.
	Os arquivos **NVRAM** armazenam o conteúdo da **EEPROM**, memória
	RAM não volátil (NVRAM) e informações de outros dispositivos
	programáveis que fazem uso deste tipo de memória. As informações são
	lidas no início da emulação e gravadas ao sair.

		O valor predefinido é **nvram** (isto é, um diretório com nome
		"nvram" no diretório raiz do MAME). Caso este diretório não
		exista, ele será criado automaticamente.

.. _mame-commandline-inputdirectory:

**-input_directory** <*caminho*>

	Define o diretório onde os arquivos de gravação de entrada são
	armazenados. As gravações de entrada são criadas através da opção
	**-record** e reproduzidas através da opção **-playback**.

		O valor predefinido é **inp** (ou seja, um diretório de nome
		**inp** no diretório raiz do MAME). Caso este diretório não
		exista, ele será criado automaticamente.

.. _mame-commandline-statedirectory:

**-state_directory** <*caminho*>

	Define o diretório onde os arquivos de gravação de estado são
	armazenados. Os arquivos de estado são lidos e gravados mediante a
	solicitação do usuário ou ao usar a opção ``-autosave``.

		O valor predefinido é **sta** (isto é, um diretório de nome
		**sta** no diretório raiz do MAME). Caso este diretório não
		exista, ele será criado automaticamente.

.. _mame-commandline-snapshotdirectory:

**-snapshot_directory** <*caminho*>

	Define o diretório onde os arquivos de instantâneos da tela são
	armazenados quando solicitado pelo usuário.

		O valor predefinido é **snap** (isto é, um diretório chamado
		**snap** no diretório raiz do MAME). Caso este diretório não
		exista, ele será criado automaticamente.

.. _mame-commandline-diffdirectory:

**-diff_directory** <*caminho*>

	Define o diretório onde os arquivos de diferencial do disco rígido
	são armazenados. Os arquivos de diferencial armazenam qualquer dado
	que é escrito de volta na imagem do disco, isso serve para preservar
	a imagem de disco original. Os arquivos são criados no inicio da
	emulação com uma imagem compactada do disco rígido.

		O valor predefinido é **diff** (isto é, um diretório chamado
		**diff** no diretório raiz do MAME). Caso este diretório não
		exista, ele será criado automaticamente.

.. _mame-commandline-commentdirectory:

**-comment_directory** <*caminho*>

	Define o diretório onde os arquivos de comentário do depurador são
	armazenados. Os arquivos de comentário do depurador são escritos
	pelo depurador quando comentários são adicionados em um sistema
	desmontado (disassembly).

		O valor predefinido é **comments** (isto é, um diretório chamado
		**comments** no diretório raiz do MAME). Caso este diretório não
		exista, ele será criado automaticamente.

.. raw:: latex

	\clearpage

Opções para a gravação e a reprodução do estado da emulação
-----------------------------------------------------------

.. _mame-commandline-norewind:

**-[no]rewind**

	Quando ativo e a emulação for pausada, automaticamente é salvo o
	estado da condição da memória toda a vez que um quadro for avançado.
	O rebobinamento das condições de estado que foram salvas podem ser
	carregadas de forma consecutiva ao pressionar a tecla de atalho para
	rebobinar passo único (*Shift Esquerdo + til*) [2]_.

		O valor predefinido é **Desligado** (**-norewind**).

	Caso o depurador esteja no estado *break*, a condição de estado
	atual é criada a cada 'step in', *step over* ou caso ocorra um
	*step out*. Nesse modo os estados salvos podem ser carregados e
	rebobinados executando o comando *rewind* ou *rw* no depurador.

.. _mame-commandline-rewindcapacity:

**-rewind_capacity** <*valor*>

	Define a capacidade de rebobinar em megabytes.
	É a quantidade total de memória que será usada para rebobinar
	savestates. Quando a capacidade alcança o limite, os antigos
	savestates são apagados enquanto novos são capturados. Definindo uma
	capacidade menor do que o savestate atual, desabilita o
	rebobinamento. Os valores negativos são automaticamente fixados em
	0.

.. _mame-commandline-statename:

**-statename** <*name*>

	Descreve como o MAME deve armazenar os arquivos de estado salvos
	relativo ao caminho do state_directory. <*name*> é uma string que
	fornece um modelo a ser usado usado para gerar um nome de arquivo.

	São disponibilizadas duas substituições simples: o caractere ``/``
	representa o separador de caminho em qualquer plataforma de destino
	(até mesmo no Windows); a string ``%g`` representa o nome do driver
	do sistema atual.

	O valor predefinido é ``%g``, que cria uma pasta separada para cada
	sistema.

	Em adição ao que foi dito acima, para os drivers que usem mídias
	diferentes, como cartões ou disquetes, você também pode usar o
	indicador ``%d_[media]``. Substitua ``[media]`` pelo comutador de
	mídia que você deseja usar.

	Alguns exemplos:

	* Caso use ``mame robby -statename foo/%g%i`` os instantâneos serão
	  salvos em **sta\\foo\\robby\\**.

	* Caso você use ``mame nes -cart robby -statename %g/%d_cart``
	  os instantâneos serão salvos em **sta\\nes\\robby**.

	* Caso você use ``mame c64 -flop1 robby -statename %g/%d_flop1/%i``
	  estes serão salvos como **sta\\c64\\robby\\0000.png**.

.. _mame-commandline-state:

**-state** <*slot*>

	Depois de iniciar um sistema determinado, fará com que o estado
	salvo no <*slot*> seja carregado imediatamente.

.. _mame-commandline-noautosave:

**-[no]autosave**

	Quando ativado, cria automaticamente um arquivo de estado ao sair do
	MAME e automaticamente tenta recarregá-lo caso o MAME inicie
	novamente com o mesmo sistema. Isso só funciona para sistemas que
	habilitaram explicitamente o suporte a estado de salvamento em seu
	driver.

		O valor predefinido é **Desligado** (**-noautosave**).

.. raw:: latex

	\clearpage

.. _mame-commandline-playback:

**-playback** / **-pb** <*nome_do_arquivo*>

	Faz a reprodução de um arquivo de gravação. Esse recurso não
	funciona de maneira confiável com todos os sistemas, mas pode ser
	usado para assistir a uma sessão de jogo gravada anteriormente do
	início ao fim. Para tornar as coisas consistentes, você deve apagar
	os arquivos de configuração ``.cfg``, NVRAM ``.nv`` e o cartão de
	memória.

		O valor predefinido é **NULO** (sem reprodução).

.. _mame-commandline-exitafterplayback:

**-[no]exit_after_playback**

	O MAME encerra a emulação ao final do arquivo de playback se usado
	em conjunto com a opção **-playback**. É predefinido que o MAME
	não encerre a emulação.

		O valor predefinido é **Desligado** (**-noexit_after_playback**)

.. _mame-commandline-record:

**-record** / **-rec** <*nome_do_arquivo*>

	Faz a gravação de todos comandos feitos pelo usuários durante uma
	seção e define o nome do arquivo onde será registrado todos esses
	comandos durante uma seção.
	Esse recurso não funciona de forma confiável com todos os sistemas.

		O valor predefinido é **NULO** (sem gravação).

.. _mame-commandline-recordtimecode:

**-record_timecode**

	Diz ao MAME para criar um arquivo de *timecode*. Ele contém uma linha
	com os tempos decorridos a cada pressão da tecla de atalho
	(*O valor predefinido é F12*). Esta opção funciona apenas quando o modo de
	gravação está ativado (opção ``-record``). O arquivo é salvo na
	pasta *inp*. É predefinido que nenhum arquivo de timecode seja
	gravado.

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

**-mngwrite** <*nome_do_arquivo*>.mng

	Escreve cada quadro de vídeo em um arquivo <*nome_do_arquivo*> no
	formato MNG, produzindo uma animação da sessão.
	Note que ``-mngwrite`` só grava quadros de vídeo, não grava qualquer
	áudio, use a opção ``-wavwrite`` para gravar o áudio e
	posteriormente use uma ferramenta de edição de áudio qualquer para
	unir os dois, ou use **-aviwrite** para gravar áudio e vídeo em um
	único arquivo.

		O valor predefinido é **NULO** (sem gravação).

.. _mame-commandline-aviwrite:

**-aviwrite** <*nome_do_arquivo*>.avi

	Grava todos os dados de áudio e vídeo em formato AVI sem compressão,
	note que a taxa de quadros e a resolução são sempre fixas. Vídeos
	sem compressão ocupam muito espaço assim como, para que a gravação
	ocorra sem problemas é necessário um HDD rápido.

	Talvez seja mais prático gravar os seus comandos com
	:ref:`-record <mame-commandline-record>` e
	depois fazer o vídeo com
	:ref:`-aviwrite <mame-commandline-aviwrite>` combinado com
	:ref:`-playback <mame-commandline-playback>` e
	:ref:`-exit_after_playback <mame-commandline-exitafterplayback>`.

		O valor predefinido é **NULO** (sem gravação).

.. _mame-commandline-aviio:

**-aviio**

	Define o formato de compressão e conversão do arquivo AVI. A ser
	implementado em uma versão futura do MAME.

		Não há valor predefinido ainda.

.. _mame-commandline-wavwrite:

**-wavwrite** <*nome_do_arquivo*>.wav

	Grava apenas o áudio da seção em formato PCM 16 bits.

		O valor predefinido é **NULO** (sem gravação).

.. raw:: latex

	\clearpage

Opções para instantâneos de tela
--------------------------------

.. _mame-commandline-snapname:

**-snapname** <*name*>

	Descreve como MAME deve nomear arquivos de instantâneos de tela.
	<*name*> será o guia que o MAME usará para nomear o arquivo.

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
	disquetes, você também pode usar ``%d_[media]``.
	Substitua ``[media]`` pelo dispositivo que deseja usar.

	Alguns exemplos:

	* Caso use ``mame.exe robby -snapname foo/%g%i`` os instantâneos
	  serão salvos como ``snaps\foo\robby0000.png``,
	  ``snaps\foo\robby0001.png`` e assim por diante.

	* Caso use ``mame nes -cart robby -snapname %g/%d_cart`` os
	  instantâneos serão salvos como ``snaps\nes\robby.png``.

	* No caso deste outro exemplo,
	  ``mame.exe c64 -flop1 robby -snapname %g/%d_flop1/%i`` estes serão
	  salvos como ``snaps\c64\robby\0000.png``.

.. _mame-commandline-snapsize:

**-snapsize** <*largura*>x<*altura*>

	Define um tamanho fixo para os instantâneos e vídeos.
	É predefinido que o MAME criará instantâneos, assim como os vídeos,
	na resolução original do sistema em pixels brutos. Caso você use
	esta opção, o MAME criará instantâneos e vídeos no tamanho que você
	determinou, com filtro bilinear (filtro de embaçamento de pixels)
	aplicado no resultado final. Observe que ao definir este tamanho a
	tela não gira automaticamente caso o sistema seja orientado
	verticalmente.

		O valor predefinido é **auto**.

.. raw:: latex

	\clearpage

.. _mame-commandline-snapview:

**-snapview** <*nome*>

	Define a exibição a ser usada ao renderizar instantâneos e vídeos.

	É predefinido que ambos usem uma exibição especial *interna*, que
	renderize uma captura instantânea separada por tela ou renderize
	os vídeos somente da primeira tela. Ao usar essa opção, você
	pode alterar esse comportamento predefinido de exibição e
	selecionar apenas uma exibição que será aplicada a todos os
	instantâneos e vídeos.

	Observe que <*nome*> não precisa ser uma combinação perfeita,
	ao invés disso, ele selecionará a primeira exibição cujo nome
	corresponda a todos os caracteres definidos por <*nome*>.

	Por exemplo, ``-snapview native`` irá casar a visualização
	"Nativa em (15:14)" ainda que não seja uma combinação ideal.
	O <*nome*> também pode ser "auto" onde será escolhida a primeira
	exibição de todas as telas presentes.

		O valor predefinido é **internal**.

.. _mame-commandline-nosnapbilinear:

**-[no]snapbilinear**

	Especifique se o instantâneo ou vídeo deve ter filtragem bilinear
	aplicada, o filtro bilinear aplica um leve efeito de embaçamento ou
	suavização à tela, amenizando um pouco o serrilhado nos contornos
	gráficos e suavizando a tela do sistema. Desligar essa opção pode
	fazer a diferença melhorando a performance durante a gravação do
	vídeo.

		O valor predefinido é **Ligado** (**-snapbilinear**).

.. raw:: latex

	\clearpage

Opções relacionadas a performance e a velocidade da emulação
------------------------------------------------------------

.. _mame-commandline-noautoframeskip:

**-[no]autoframeskip** / **-[no]afs**

	Para que se mantenha a velocidade máxima de uma emulação, ajusta
	dinamicamente no sistema emulado a quantidade de quadros que
	serão pulados. Habilitando essa opção ela se sobrepõem ao que for
	definido em **-frameskip** descrito logo abaixo.

		O valor predefinido é **Desligado** (**-noautoframeskip**).

.. _mame-commandline-frameskip:

**-frameskip** / **-fs** <*level*>

	Determina o valor de pulo de quadros. Ela elimina cerca de 12
	quadros enquanto estiver sendo executado. Por exemplo, se você
	definir ``-frameskip 2`` então MAME irá exibir 10 de cada 12
	quadros.

	Ao pular estes quadros, pode ser que se atinja a velocidade
	nativa do sistema emulado sem que haja sobrecarga no seu computador
	ainda que ele não tenha um grande poder de processamento.

		O valor predefinido é não pular nenhum quadro
		(**-frameskip 0**).

.. _mame-commandline-secondstorun:

**-seconds_to_run** / **-str** <*segundos*>

	Este comando pode ser usado para realizar um teste de velocidade de
	forma automatizada. O comando diz ao MAME para para interromper a
	emulação depois de alguns segundos. Ao combinar com outras opções
	fixas de linha de comando você pode definir um ambiente para
	realizar testes de performance. Em adição, ao sair, a opção ``-str``
	faz com que seja gravado um instantâneo da tela chamado *final.png*
	no diretório de
	:ref:`instantâneos <mame-commandline-snapshotdirectory>`.

	O comando diz ao MAME para interromper a emulação depois de um
	tempo determinado, o tempo em questão não é o tempo real e sim o
	tempo interno da emulação, assim, caso você defina 30 segundos, pode
	ser que dependendo da máquina que esteja sendo emulada, a parada
	só venha a acontecer depois de algum tempo.

	Este comando também é útil para a realização de benchmarks e testes
	de automação. Ao combinar esta opção com algumas outras, é possível
	construir uma estrutura de testes de performance do MAME.
	Adicionalmente a opção ``-str``, faz também que ao final do tempo
	seja criado um instantâneo de tela chamado **final.png** dentro da
	pasta de :ref:`instantâneos <mame-commandline-snapshotdirectory>`.

.. _mame-commandline-nothrottle:

**-[no]throttle**

	Ativa ou não a função de controle de velocidade do emulador [4]_.
	Ao habilitar esta opção, o MAME tenta manter o sistema rodando em
	sua velocidade nativa, com a opção desabilitada a emulação é
	executada na velocidade mais rápida possível. Dependendo das
	características do sistema emulado, a performance final pode
	limitada pelo seu processador, placa de vídeo ou até mesmo pela
	performance final da sua memória.

		O valor predefinido é **Ligado** (**-throttle**).

.. _mame-commandline-nosleep:

**-[no]sleep**

	Permite que o MAME devolva tempo de CPU ao sistema quando
	estiver rodando com ``-throttle``. Isso permite que outros programas
	tenham mais tempo de CPU, assumindo que a emulação não esteja
	consumindo 100% dos recursos do processador. Essa opção pode causar
	uma certa intermitência na performance caso outros programas também
	demandem processamento estejam rodando junto com o MAME.

		O valor predefinido é **Ligado** (**-sleep**).

.. raw:: latex

	\clearpage

.. _mame-commandline-speed:

**-speed** <*factor*>

	Muda a maneira que o MAME controla a velocidade da emulação de
	maneira que seja possível que o sistema emulado rode em múltiplos
	da sua velocidade original.

	Um <*fator*> **1.0** significa rodar o sistema em velocidade normal.
	Já um fator **0.5** significa rodar o sistema na metade da
	velocidade normal e um <*fator*> **2.0** significa rodar o sistema
	2x acima da sua velocidade normal. Note que ao mudar este valor a
	velocidade de execução do áudio irá mudar proporcionalmente também.

	A resolução interna da fração são dois pontos decimais, então o
	valor **1.002** será arredondada para **1.0**.

		O valor predefinido é **1.0**.

.. _mame-commandline-norefreshspeed:

**-[no]refreshspeed** / **-[no]rs**

	Permite ao MAME ajustar a velocidade da primeira tela emulada do
	sistema de maneira que não exceda a menor velocidade da taxa de
	atualização de tela de qualquer uma das telas do sistema emulado.
	Visando evitar cortes no áudio ou efeitos colaterais indesejáveis, o
	MAME irá reduzir a velocidade da emulação para 99% em casos onde por
	exemplo, um monitor que funcione nativamente a 60 Hz e o sistema
	emulado rode a 60.6 Hz.

		O valor predefinido é **Desligado** (**-norefreshspeed**).

.. _mame-commandline-numprocessors:

**-numprocessors** / **-np** <*auto|valor*>

	Define a quantidade de núcleos do processador a serem usados.
	A opção **auto** usará a quantidade de núcleos informada pelo seu
	sistema ou pela variável de ambiente **OSDPROCESSORS**. Este valor é
	limitado internamente para quatro vezes o número de processadores
	informado pelo seu sistema.

		O valor predefinido é **auto**.

.. _mame-commandline-bench:

**-bench** <*n*>

	Define a quantidade de segundos de emulação em [*n*] usado para
	teste de performance, o comando é um atalho com comando abaixo:

		**-str** <*n*> **-video none -sound none -nothrottle**

.. raw:: latex

	\clearpage

Opções para a rotação da tela
-----------------------------

.. _mame-commandline-norotate:

**-[no]rotate**

	Gira a tela para corresponder ao seu estado normal do sistema
	(horizontal / vertical). Isso garante que os sistemas vertical e
	horizontalmente orientados sejam exibidos corretamente sem que haja
	a necessidade de girar fisicamente a sua tela.

		O valor predefinido é **Ligado** (**-rotate**).


.. _mame-commandline-noror:

.. _mame-commandline-norol:

**-[no]ror**
**-[no]rol**

	Rotacione a tela do sistema para a direita ``-ror`` ou para a
	esquerda ``-rol`` em relação ao seu estado normal caso ``-rotate``
	seja definido ou seu estado nativo caso ``-norotate`` seja
	definido.

		O valor predefinido para ambas é **Desligado**
		(**-noror** **-norol**).


.. _mame-commandline-noautoror:

.. _mame-commandline-noautorol:

**-[no]autoror**
**-[no]autorol**

	Essas opções são projetadas para uso com telas giratórias que giram
	apenas em uma única direção. Caso a tela gire somente no sentido
	horário, use o comando ``-autorol`` para garantir que o sistema
	encha a tela horizontalmente ou verticalmente em uma das direções
	que você pode manipular. Caso a sua tela gire somente no sentido
	anti-horário, use ``-autoror``.

.. _mame-commandline-noflipx:

.. _mame-commandline-noflipy:

**-[no]flipx**
**-[no]flipy**

	Espelhe a tela do sistema horizontalmente (``-flipx``) ou
	verticalmente (``-flipy``). As inversões são aplicadas depois que as
	opções de rotação ``-rotate`` e rolagem ``-ror/-rol`` forem
	aplicadas.

		O valor predefinido para ambas as opções é **Desligado**
		(**-noflipx** **-noflipy**).

.. raw:: latex

	\clearpage

Opções para a configuração de vídeo
-----------------------------------

.. _mame-commandline-video:

**-video** <*bgfx|gdi|d3d|opengl|soft|accel|none*>

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

	  É recomendável que você tenha uma placa de vídeo mediana (2002+)
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

		O valor predefinido para todos os outros sistemas é **soft**.

.. raw:: latex

	\clearpage

.. _mame-commandline-numscreens:

**-numscreens** <*count*>

	Diz ao MAME quantas telas devem ser criadas. Para a maioria dos
	sistemas só exite uma, porém alguns sistemas originalmente usavam
	mais de uma (*como as máquinas Darius e máquinas Arcade
	PlayChoice-10 por exemplo*). Cada tela (até 4), possem as suas
	próprias configurações, taxa de proporção de tela, resolução e
	exibição, que podem ser definidas usando as opções abaixo.

		O valor predefinido é **1**.

.. _mame-commandline-window:

**-[no]window** / **-[no]w**

	Faz o MAME exibir a tela em uma janela ou em uma tela inteira.

		O valor predefinido é **Desligado** (**-nowindow**).

.. _mame-commandline-maximize:

**-[no]maximize** / **-[no]max**

	Controla o tamanho inicial da janela no modo de janelado. Caso seja
	ativado, ao iniciar o MAME a janela será configurada para o tamanho
	máximo suportado. Caso esteja desativado, a janela será exibida no
	menor tamanho suportado. Esta opção só tem efeito quando a opção
	**-window** for usada.

		O valor predefinido é **Ligado** (**-maximize**).

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
	janelado, a proporção de tela será mantido mesmo que você
	redimensione a janela para diferentes tamanhos, caso mantenha a
	tecla **Control** ou **Ctrl** pressionada enquanto redimensiona a
	janela, a proporção será mantida.

		O valor predefinido é **Ligado** (**-keepaspect**).

	A equipe do MAME, veementemente sugere que você mantenha a opção
	habilitada. Esticando a tela do sistema além da proporção original
	vai causar distorções na aparência do sistema que vai muito além da
	capacidade de reparo dos filtros.

.. _mame-commandline-unevenstretch:

**-[no]unevenstretch** / **-[no]ues**

	Permite que a proporção da tela seja desigual e que a tela ou janela
	possa ser preenchida na horizontal ou vertical.

		O valor predefinido é **Ligado** (**-unevenstretch**).

.. raw:: latex

	\clearpage

.. _mame-commandline-unevenstretchx:

**-[no]unevenstretchx** / **-[no]uesx**

	Permite que a proporção da tela seja desigual e que a tela ou janela
	possa ser preenchida apenas na horizontal.

		O valor predefinido é **Ligado** (**-unevenstretchx**).

.. _mame-commandline-unevenstretchy:

**-[no]unevenstretchx** / **-[no]uesy**

	Permite que a proporção da tela seja desigual e que a tela ou janela
	possa ser preenchida apenas na vertical.

		O valor predefinido é **Ligado** (**-unevenstretchy**).

.. _mame-commandline-autostretchxy:

**-[no]autostretchxy** / **-[no]asxy**

	Aplica a opção **-unevenstretchx/y** automaticamente com base na
	orientação nativa da fonte.

		O valor predefinido é **Ligado** (**-noautostretchxy**).

.. _mame-commandline-intoverscan:

**-[no]intoverscan** / **-[no]ios**

	Permite que a imagem passe dos limites da tela (overscan) de alvos
	inteiros e dimensionáveis.

		O valor predefinido é **Ligado** (**-nointoverscan**).

.. _mame-commandline-intscalex:

**-[no]intscalex** / **-[no]sx**

	Define o fator de escala horizontal.

		O valor predefinido é **Ligado** (**-nointscalex**).

.. _mame-commandline-intscaley:

**-[no]intscaley** / **-[no]sy**

	Define o fator de escala vertical.

		O valor predefinido é **Ligado** (**-nointscaley**).

.. _mame-commandline-waitvsync:

**-[no]waitvsync**

	Aguarda acabar o período de atualização da tela do monitor do seu
	computador antes de começar a desenhar na tela. Caso esta opção
	esteja desligada, o MAME só irá desenhar na tela com tempo
	posterior ou até mesmo durante um ciclo de atualização de tela. Isso
	pode causar um *screen tearing* [5]_.

	O efeito "tearing" não é perceptível em todos os sistemas, porém
	algumas pessoas acham o efeito desagradável, algumas mais do que as
	outras.
	Saiba que ao ativar esta opção você desperdiçará preciosos ciclos
	de CPU enquanto se espera o tempo certo para desenhar na tela
	fazendo com que a performance no geral seja comprometida.

	Apenas utilize esta opção caso você esteja jogando em modo janelado.

	Em modo de tela cheia a opção só será necessária caso a opção
	``-triplebuffer`` não remova o indesejado efeito *tearing*, neste
	caso, tente usar as duas opções juntas
	``-notriplebuffer -waitvsync``.
	A opção ``-waitvsync`` não funciona com ``-video gdi``.

		O valor predefinido é **Desligado** (**-nowaitvsync**).

	O **MAME SDL** funcionará com essa opção em modo janelado, caso haja
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
	haverá problemas com o som. Essa opção foi pensada naqueles que
	modificaram as configurações da sua placa de vídeo, combinando uma
	opção a mais com as de atualização de tela.
	Essa opção não funciona com a opção ``-video gdi``.

		O valor predefinido é **Desligado** (**-nosyncrefresh**).

.. _mame-commandline-prescale:

**-prescale** <*quantidade*>

	Controla o tamanho das imagens na tela enquanto são repassadas para
	o sistema gráfico de redimensionamento. No ajuste mínimo de **1**, a
	tela é renderizada no seu tamanho original antes de ser
	dimensionada. Com valores maiores a tela é expandida pelo fator
	definido em <*quantidade*> antes de ser dimensionado. Isso gera imagens
	menos borradas com a opção ``-video d3d`` ao custo da perda de
	alguma performance.

		O valor predefinido é **1**.

	Funciona com todos os modos de vídeo no Windows (bgfx, d3d, etc) e
	nas outras plataformas **APENAS** aquelas que forem compatíveis com
	o OpenGL.

.. _mame-commandline-filter:

**-[no]filter** / **-[no]d3dfilter** / **-[no]flt**

	O filtro bilinear, aplica um leve efeito de embaçamento ou
	suavização à tela, amenizando um pouco o serrilhado nos contornos
	gráficos e suavizando a tela do sistema.

	Quando desabilitado você terá uma imagem pura e com aparência mais
	serrilhada e também ocasiona artefatos na tela em caso de
	dimensionamento. Caso não goste da aparência filtrada e amaciada da
	imagem, tente incrementar o valor da opção ``-prescale`` ao invés de
	desabilitar todos os filtros.

		O valor predefinido é **Ligado** (**-filter**).

	No Windows funciona com todos os modos de vídeo (bgfx, d3d, etc),
	nas outras plataformas **APENAS** aquelas compatíveis com OpenGL.

.. _mame-commandline-noburnin:

**-[no]burnin**

	Rastreia o brilho da tela durante a reprodução e no final da
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

		O valor predefinido é **Desligado** (**-noburnin**).

.. raw:: latex

	\clearpage

Opções para a configuração da tela inteira
------------------------------------------

.. _mame-commandline-switchres:

**-[no]switchres**

	Permite ou não a comutação ou troca da resolução. Esta opção é
	necessária para as opções ``-resolution`` evitando a troca das
	resoluções enquanto estiver no modo de tela inteira.

	Em placas de vídeo modernas, há poucas razões para alternar as
	resoluções a menos que você esteja tentando alcançar as resoluções
	"exatas" dos pixels dos sistemas originais, o que exige ajustes
	significativos.

	Útil também em monitores de LCD, uma vez que eles rodam com uma
	resolução fixa e as comutações da resolução algumas vezes são
	exageradas.

	Essa opção não funciona com a opção ``-video gdi``.

		O valor predefinido é **Desligado** (**-noswitchres**).


Opções de vídeo para uso com janelas individuais
------------------------------------------------

.. _mame-commandline-screen:

NOTA: **A partir de agora a opção de várias telas simultâneas podem não
funcionar corretamente em alguns computadores Mac.**

|	**-screen** <*display*>
|	**-screen0** <*display*>
|	**-screen1** <*display*>
|	**-screen2** <*display*>
|	**-screen3** <*display*>


	Define qual o monitor físico em seu sistema você deseja que cada
	janela use por padrão. Para usar várias janelas, você deve ter
	aumentado o valor da opção :ref:`-numscreens
	<mame-commandline-numscreens>`.
	O nome de cada exibição em seu sistema pode ser determinado
	executando o MAME com a opção :ref:`-verbose
	<mame-commandline-verbose>`.
	Os nomes de exibição geralmente estão no formato: *\\\\.\DISPLAYn*,
	onde **n** é um número do monitor conectado.

		O valor predefinido para essas opções é **auto**.
		O que significa que a primeira janela é colocada na primeira
		exibição, a segunda janela na segunda exibição e assim por
		diante.

	Os parâmetros ``-screen0``, ``-screen1``, ``-screen2``, ``-screen3``
	aplicam-se as janelas definidas. O parâmetro **screen** se aplica
	a todas as janelas.
	As opções definidas da janela substituem os valores da opções de
	todas as janelas.

.. _mame-commandline-aspect:

|	**-aspect** <*largura:altura*> / **-screen_aspect** <*num:den*>
|	**-aspect0** <*largura:altura*>
|	**-aspect1** <*largura:altura*>
|	**-aspect2** <*largura:altura*>
|	**-aspect3** <*largura:altura*>

	Define a proporção física do monitor para cada janela. Para usar
	várias janelas, você deve ter aumentado o valor da opção
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
	todas as janelas.

.. _mame-commandline-resolution:

|	**-resolution** <*larguraxaltura[@refresh]*> / **-r** <*larguraxaltura[@refresh]*>
|	**-resolution0** <*larguraxaltura[@refresh]*> / **-r0** <*larguraxaltura[@refresh]*>
|	**-resolution1** <*larguraxaltura[@refresh]*> / **-r1** <*larguraxaltura[@refresh]*>
|	**-resolution2** <*larguraxaltura[@refresh]*> / **-r2** <*larguraxaltura[@refresh]*>
|	**-resolution3** <*larguraxaltura[@refresh]*> / **-r3** <*larguraxaltura[@refresh]*>

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
	todas as janelas.

.. _mame-commandline-view:

|	**-view** <*nome*>
|	**-view0** <*nome*>
|	**-view1** <*nome*>
|	**-view2** <*nome*>
|	**-view3** <*nome*>
|

	Define a configuração da visualização inicial de cada janela.
	Note que o nome de visualização <*nome*> não precisa
	ser uma combinação exata, em vez disso, será selecionado a primeira
	exibição cujo nome corresponde a todos os caracteres especificados
	por <*nome*>.
	Por exemplo, ``-view native`` corresponderá à visualização
	"Native (15:14)", mesmo que não seja uma correspondência perfeita.
	O valor funciona com a opção ``auto`` também e solicita que o MAME
	execute uma seleção predefinida.

		O valor predefinido para essas opções é **auto**.

	Os parâmetros ``-view0``, ``-view1``, ``-view2`` e ``-view3`` se
	aplicam a todas as janelas especificadas. O parâmetro ``-view`` se
	aplica a todas as janelas.
	As opções definidas para a janela substituem os valores da opções de
	todas as janelas.

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

		O valor predefinido é **Desligado** (**-noartwork_crop**).

.. _mame-commandline-fallbackartwork:

**-fallback_artwork**

	Define uma ilustração alternativa caso nenhuma ilustração interna ou
	externa de layout seja definida.

.. _mame-commandline-overrideartwork:

**-override_artwork**

	Define uma ilustração para sobrepor a ilustração interna ou externa
	de layout.

.. raw:: latex

	\clearpage

Opções para os ajustes de imagem da tela
----------------------------------------

.. _mame-commandline-brightness:

**-brightness** <*valor*>

	Controla o valor de brilho ou nível de preto da tela.
	Essa opção não afeta a arte ou outras partes da tela. Usando a
	interface interna do MAME, você pode configurar o brilho para cada
	tela do sistema e para todos os sistemas individualmente.
	Ao selecionar valores menores (não menor que **0.1**) produzirá uma
	tela mais escura, enquanto valores maiores até **2.0** produzirão
	uma tela mais clara.

		O valor predefinido é **1.0**.

.. _mame-commandline-contrast:

**-contrast** <*valor*>

	Controla o contraste da tela ou os nível de branco da tela.
	Essa opção não afeta a arte ou outras partes da tela. Usando a
	interface interna do MAME, você pode configurar o brilho para cada
	tela do sistema e para todos os sistemas individualmente.
	Essa opção define o valor inicial de todas as telas visíveis de
	todos os sistemas.
	Selecionando valores (não menor que **0.1**) produzirá uma tela mais
	apagada, enquanto valores maiores até **2.0** produzirão uma tela
	mais saturada.

		O valor predefinido é **1.0**.

.. _mame-commandline-gamma:

**-gamma** <*valor*>

	Controle de gamma, ajusta a escala de luminância da tela. Essa opção
	não afeta a arte ou outras partes da tela. Usando a interface
	interna do MAME, você pode configurar o gamma para cada tela do
	sistema e para todos os sistemas individualmente. Essa opção define
	o valor inicial de todas as telas visíveis de todos os sistemas.
	Essa configuração oferece um ajuste de luminância linear de preto
	para o branco. Ao selecionar valores menores (até **0.1**)
	trará a luminância mais para o preto, enquanto valores maiores
	(até **3.0**) empurrarão essa luminância para o branco.

		O valor predefinido é **1.0**.

.. _mame-commandline-pausebrightness:

**-pause_brightness** <*valor*>

	Faz o controle do nível de brilho durante a pausa.

		O valor predefinido é **0.65**.

.. _mame-commandline-effect:

**-effect** <*nome_do_arquivo*>

	Define um único arquivo ``.png`` que será usado como sobreposição na
	tela de qualquer sistema. Presume-se que o aquivo ``.png`` esteja em
	um dos diretórios raiz do :ref:`artpath <mame-commandline-artpath>`.

	Ambas as combinações horizontais e verticais dentro do arquivo
	``.png`` é repetido para cobrir toda a tela (mas nenhuma parte da
	arte externa). Ela é renderizada na resolução nativa do sistema.

	Para os modos de vídeo ``-video gdi`` e ``-video d3d`` significa que
	um pixel dentro do ``.png`` será mapeado para um pixel da sua tela.
	Os valores RGB de cada pixel dentro do ``.png`` são multiplicados
	com os valores de RGB da tela de destino.

		O valor predefinido é **none** ou nenhum efeito.

.. raw:: latex

	\clearpage

Opções para máquinas que usem gráficos vetoriais
------------------------------------------------

.. _mame-commandline-beamwidthmin:

**-beam_width_min** <*largura*>

	Define a espessura mínima do feixe do vetor.

.. _mame-commandline-beamwidthmax:

**-beam_width_max** <*largura*>

	Define a espessura máxima do feixe do vetor.

.. _mame-commandline-beamintensityweight:

**-beam_intensity_weight** <*altura*>

	Define a intensidade do feixe do vetor.

.. _mame-commandline-flicker:

**-flicker** <*valor*>

	Simula um vetor de efeito de *tremulação* ou oscilação da tela
	semelhante aos monitores desregulados usados nos jogos vetoriais.
	Essa opção espera um valor flutuante (float) no intervalo
	entre **0.00** e **100.00** (**0** = nenhum e **100** = máximo).

		O valor predefinido é **0**.

.. raw:: latex

	\clearpage

Opções para a depuração de vídeo OpenGL
---------------------------------------

Essas são as opções compatíveis com ``-video opengl``.
Caso você note artefatos renderizados na tela, poderá ser solicitado
pelos desenvolvedores que você tente alterá-los, porém normalmente esses
os valores devem ser mantidos em seus valores originais para que se
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

		O valor predefinido é **Desligado** (**-nogl_glsl**).

.. _mame-commandline-glglslfilter:

**-gl_glsl_filter**

	Habilite a filtragem *OpenGL GLSL* em vez da filtragem FF
	*0-simples, 1-bilinear, 2-bicúbica*

		O valor predefinido é **1** (**-gl_glsl_filter 1**).

.. _mame-commandline-glslshadermame:

|	**-glsl_shader_mame0**
|	**-glsl_shader_mame1**
|	...
|	**-glsl_shader_mame9**

	O shader personalizado do OpenGL GLSL configura o bitmap do MAME no
	slot fornecido entre (*0-9*). É possível aplicar um para a cada slot.

	A ser feito: Descrever mais detalhes sobre a utilização em algum
	momento no futuro. Veja:
	http://forums.bannister.org/ubbthreads.php?ubb=showflat&Number=100988#Post100988 para maiores informações.



.. _mame-commandline-glslshaderscreen:

| **-glsl_shader_screen0**
| **-glsl_shader_screen1**
| ...
| **-glsl_shader_screen9**
|

	O shader personalizado de tela do OpenGL GLSL configura o bitmap do
	MAME no slot fornecido entre (0-9).

	A ser feito: Descrever mais detalhes sobre a utilização em algum
	momento no futuro. Veja:

	http://forums.bannister.org/ubbthreads.php?ubb=showflat&Number=100988#Post100988 para maiores informações.


.. _mame-commandline-glglslvidattr:

**-gl_glsl_vid_attr**

	Ative o manuseio do GLSL em OpenGL de brilho e contraste.
	Melhor desempenho do sistema RGB.

		O valor predefinido é **Ligado** (**-gl_glsl_vid_attr**).

.. raw:: latex

	\clearpage

Opções para a configuração do áudio
-----------------------------------

.. _mame-commandline-samplerate:

**-samplerate** <*valor*> / **-sr** <*valor*>

	Define a taxa de amostragem do áudio. Valores menores como 11025 por
	exemplo, reduzem a qualidade da áudio porém a performance da
	emulação melhora.
	Valores maiores que 48000, aumentam a qualidade do áudio ao custo da
	perda de performance da emulação.

		O valor predefinido é **48000** (**-samplerate 48000**).

.. _mame-commandline-nosamples:

**-[no]samples**

	Usar arquivos de amostras caso estejam disponíveis. Esses arquivos
	são gravações de efeitos de áudio usados por algumas máquinas.

		O valor predefinido é **Ligado** (**-samples**).

.. _mame-commandline-volume:

**-volume** / **-vol** <*valor*>

	Define o volume inicial. Pode ser alterado posteriormente usando
	a interface do usuário.
	O valor do volume está definido em decibéis (dB): Por exemplo,
	``-volume -12`` começará com uma atenuação de **-12 dB** no volume
	do áudio.

		O valor predefinido é **0** (**-volume 0**).

.. _mame-commandline-sound:

**-sound** <``auto`` | ``dsound`` | ``sdl`` | ``coreaudio`` | ``xaudio2`` | ``portaudio`` | ``none``>

	Define qual o tipo de saída de áudio usar, Ao usar **none** desativa
	o áudio completamente porém o hardware de áudio continua sendo
	emulado. Abaixo as opções disponíveis para cada sistema operacional:

	+---------+------+-----------+---------+-----------+------+
	| Windows | auto | dsound    | xaudio2 | portaudio | none |
	+---------+------+-----------+---------+-----------+------+
	| macOS   | auto | coreaudio | sdl     | portaudio | none |
	+---------+------+-----------+---------+-----------+------+
	| SDL     | auto | portaudio | sdl     | none      |      |
	+---------+------+-----------+---------+-----------+------+


	Versões especiais como o **SDLMAME** para Windows, pode usar a opção
	**sdl** e ter o **portaudio** desabilitado.

		O valor predefinido é **dsound** no Windows, no Mac é
		**coreaudio** nas outras plataformas é **sdl**.

	No Windows e no Linux a opção **portaudio** provavelmente dará uma
	menor latência possível, enquanto no Mac a opção **coreaudio**
	oferecerá os melhores resultados.

.. _mame-commandline-audiolatency:

**-audio_latency** <*valor*>

	Nesta opção, latência significa o tempo que o dispositivo de áudio
	demora para responder a um comando. Essa opção ajusta a quantidade
	dessa latência incorporada ao fluxo de dados de áudio.

	É predefinido que o MAME tente manter a memória intermediária (buffer)
	do áudio DirectSound cheio entre 1/5 e 2/5.
	Em alguns sistemas, isso poderá ficar muito próximo do limite, o que
	ocasiona em algumas vezes, um som ruim. Fazendo ajustes no valor da
	latência é possível melhorar esse problema.

		O valor predefinido é **1** (significando inferior=1/5 e
		superior=2/5). Para manter a memória intermediária sempre cheia
		entre 2/5 e 3/5, defina o valor para **2**
		(``-audio_latency 2``).
		Caso exagere nesse valor, como **4** por exemplo, será possível
		notar um atraso significativo no áudio.

.. raw:: latex

	\clearpage

.. _mame-commandline-pa_api:

**-pa_api** <*interface*>

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

		mame.exe -verbose -sound portaudio

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

.. _mame-commandline-pa_device:

**-pa_device** <*dispositivo*>

	Define qual o dispositivo de áudio usar, assim como mostrado em
	:ref:`-pa_api <mame-commandline-pa_api>`, escolha um dos
	dispositivos listados. O nome do dispositivo fica do lado direito da
	lista e entre aspas. Usando o exemplo para o Windows nós usaremos: ::

		mame64.exe -verbose -sound portaudio -pa_api "Windows WASAPI" -pa_device "6 - SONY TV  *01 (AMD High Definition Audio Device)"

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

**-pa_latency** <*segundos*>

	Faz o ajuste de latência (atraso) do áudio, similar ao
	:ref:`-audio_latency <mame-commandline-audiolatency>`

		O valor predefinido é **0**.

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

		O valor predefinido é **Ligado** (**-coin_lockout**).

.. _mame-commandline-ctrlr:

**-ctrlr** <*controle*>

	Permite que você carregue arquivos ``.cfg`` no diretório definido em
	**ctrlrpath** com as configurações customizadas para controles,
	outras informações que ali estiverem serão ignoradas. Estes arquivos
	são criados quando você configura os botões do controle de uma
	máquina, essas configurações são gravadas no diretório **cfg** como
	(nome_da_maquina).cfg.


		O valor predefinido é **NULO** (nenhum arquivo de controle).

.. _mame-commandline-nomouse:

**-[no]mouse**

	Controla se o MAME faz uso ou não dos controladores do mouse.
	Se estiver ligado o mouse ficará reservado para uso exclusivo do
	MAME até que você saia ou pause a emulação.

		O valor predefinido é **Desligado** (**-nomouse**).

.. _mame-commandline-nojoystick:

**-[no]joystick** / **-[no]joy**

	Controla se o MAME usa ou não os controles do joystick/gamepad.
	Se estiver ligado o MAME perguntará ao *DirectInput* sobre quais
	controles estão conectados atualmente.

		O valor predefinido é **Desligado** (**-nojoystick**).

.. _mame-commandline-nolightgun:

**-[no]lightgun** / **-[no]gun**

	Controla se o MAME usa ou não os controles da pistola de luz
	(lightgun). Observe que a maioria das pistolas de luz são mapeadas
	para o mouse, assim, ao se usar ambas as opções ``-lightgun`` e
	**-mouse** juntos, isso pode poderá trazer resultados inesperados.

		O valor predefinido é **Desligado** (**-nolightgun**).

.. _mame-commandline-nomultikeyboard:

**-[no]multikeyboard** / **-[no]multikey**

	Determina se o MAME diferencia entre os vários teclados disponíveis.
	Alguns sistemas podem reportar mais de um teclado; por padrão, os
	dados de todos esses teclados são combinados para que pareçam um só.
	Ativando essa opção permitirá que o MAME retorne quais teclas foram
	pressionadas em diferentes teclados de maneira independente.

		O valor predefinido é **Desligado** (**-nomultikeyboard**).

.. _mame-commandline-nomultimouse:

**-[no]multimouse**

	Determina se o MAME diferencia entre os vários mouses disponíveis.
	Alguns sistemas podem reportar mais de um dispositivo de mouse;
	por padrão, os dados de todos esses mouses são combinados para que
	pareçam um só. Ativando esta opção fará com que o MAME relate o
	movimento e o pressionar de botões do mouse em diferentes mouses de
	maneira independente.

		O valor predefinido é **Desligado** (**-nomultimouse**).

.. raw:: latex

	\clearpage

.. _mame-commandline-nosteadykey:

**-[no]steadykey** / **-[no]steady**

	Alguns sistemas exigem que dois ou mais botões sejam pressionados
	exatamente ao mesmo tempo para realizar movimentos ou comandos
	especiais. Devido a limitação do hardware do teclado, pode ser
	difícil ou até mesmo impossível de realizar usando um teclado comum.
	Essa opção seleciona diferentes modos de manuseio o que torna mais
	fácil registrar o pressionamento simultâneo das teclas, porém tem a
	desvantagem de deixar a sua capacidade de resposta mais lenta.

		O valor predefinido é **Desligado** (**-nosteadykey**).

.. _mame-commandline-uiactive:

**-[no]ui_active**

	Habilita a opção para que a interface do usuário se sobreponha a do
	teclado emulado caso esteja presente.

		O valor predefinido é **Desligado** (**-noui_active**).

.. _mame-commandline-nooffscreenreload:

**-[no]offscreen_reload** / **-[no]reload**

	Controla se o MAME trata o segundo botão da pistola de luz
	(lightgun) como um sinal para recarregar a arma. Neste caso, o MAME
	reportará a posição da arma como (**0,MAX**) com o gatilho
	pressionado, o que é o equivalente a uma recarga da arma com ela
	apontada para fora da tela. Isso só é necessário para jogos que
	precisam que o usuário atire para fora da tela para recarregar a
	arma e se também a sua arma não tiver essa funcionalidade.

		O valor predefinido é **Desligado** (**-nooffscreen_reload**).

.. _mame-commandline-joystickmap:

**-joystick_map** / **-joymap** <*mapa*>

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
		| | 444555666 | | numéricos, você pode especificar o caractere 's',                             |
		| | 444555666 | | que significa 'pegajoso' . Neste caso, o valor do                             |
		| | 111222333 | | mapa é o mesmo que foi da última vez que um valor não pegajoso                |
		| | 111222333 | | foi lido.                                                                     |
		| | 111222333 |                                                                                 |
		+-------------+---------------------------------------------------------------------------------+

	Para definir o mapa para este parâmetro, você pode usar uma cadeia
	destas linhas separadas por um '.' (que indica o fim de uma
	linha), dessa maneira:

	``-joymap 777888999.777888999.777888999.444555666.444555666.444555666.111222333.111222333.111222333``

	No entanto, isso pode ser reduzido usando vários atalhos compatíveis
	com o parâmetro <*map*>. Caso as informações sobre uma linha estejam
	ausentes, presume-se que os dados ausentes nas colunas 5-9 são
	simétricos da esquerda/direita com os dados da coluna 0-4; qualquer
	dados ausentes das colunas 0-4, assume-se então que estas serão
	cópias dos dados anteriores. A mesma lógica se aplica a linhas
	ausentes, exceto que a simetria cima/baixo seja assumida.

	Usando essas abreviações o mapa com 81 caracteres pode ser
	simplesmente definido por essas 11 cadeias de caracteres:
	``-joymap 7778...4445``

	Olhando para a primeira linha, 7778 são apenas 4 caracteres longos.
	A 5º entrada não pode usar valores simétricos então assume-se que
	seja igual ao valor anterior, '8'. O 6º caractere é esquerda/direita
	em simetria com o 4º caractere, resultando em '8'. O 7º caractere é
	esquerda/direita em simétrica com o 3º caractere, resultando em '9'
	(que é '7' invertido com esquerda/direita). Eventualmente isso
	resulta numa cadeia de 777888999 na linha.

	A segunda e a terceira linhas estão ausentes, portanto, elas são
	consideradas idênticas à primeira linha. A quarta linha decodifica
	de forma semelhante à primeira linha, produzindo 444555666.
	A quinta linha está faltando, então é assumido como sendo o mesmo
	que o quarto.

	As três linhas restantes também estão faltando, então elas são
	consideradas os espelhos cima/baixo das três primeiras linhas, dando
	três linhas finais de 111222333.

.. raw:: latex

	\clearpage

.. _mame-commandline-joystickdeadzone:

**-joystick_deadzone** / **-joy_deadzone** / **-jdz** <*valor*>

	Caso você jogue com um joystick analógico ele poderá estar um pouco
	fora de contro. O ``-joystick_deadzone`` informa uma folga ao longo
	de um eixo que você deve mover antes que o eixo comece a mudar.
	Essa opção espera um valor flutuante (float) no intervalo entre
	**0.0** e **1.0**. Onde **0** é o centro do joystick e **1** o
	limite externo.

		O valor predefinido é **0.3** (**-joystick_deadzone 0.3**).

.. _mame-commandline-joysticksaturation:

**-joystick_saturation** / **joy_saturation** / **-jsat** <*valor*>

	Caso você jogue com um joystick analógico as extremidades podem
	estar um pouco fora e podem não corresponder nas direções + /.
	O ``-joystick_saturation`` define se uma folga no movimento do eixo
	será aceita até que se atinja o alcance máximo. Essa opção espera um
	valor flutuante (float) no intervalo entre **0.0** até **1.0** onde
	**0** é o centro do joystick e **1** é o limite externo.

		O valor predefinido é **0.85** (**-joystick_saturation 0.85**).

.. _mame-commandline-natural:

**-natural**

	Permite que o usuário defina se deve ou não usar um teclado natural.
	Isso permite que você inicie seu sistema em um modo *nativo*
	dependendo da sua região, permitindo compatibilidade para teclados
	fora do padrão "QWERTY".

	O valor predefinido é **Desligado** (**-nonatural**).

	No modo de "teclado emulado" (predefinido) o MAME traduz o
	pressionamento/liberação de teclas/botões do host para
	pressionamentos emulados de tecla. Quando você pressiona/solta uma
	tecla/botão mapeado para uma tecla emulada, o MAME pressiona/libera
	a tecla emulada.

	No modo "teclado natural", o MAME tenta traduzir os caracteres para
	as teclas digitadas. O sistema operacional traduz pressionamentos
	de tecla a caracteres (da mesma forma quando você digita em um
	editor de texto) e o MAME tenta traduzir esses caracteres para
	pressionamentos de tecla emulados.

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

.. _mame-commandline-joystickcontradictory:

**-joystick_contradictory**

	Aceita a entrada de comandos contraditórios e simultâneos no
	controle digital como **Esquerda e Direita** ou **Cima e Baixo** ao
	mesmo tempo.

		O valor predefinido é **Desligado**
		(**-nojoystick_contradictory**)

.. _mame-commandline-coinimpulse:

**-coin_impulse** *[n]*

	Define o tempo de impulso da moeda com base em *n* (``n<0``
	desabilita, ``n==0`` obedeça o driver, ``0<n`` defina o tempo em
	*n*).

		O valor predefinido é **0** (**-coin_impulse 0**).

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
	para o mouse, controle (joystick) ou pistola de luz (lightgun)
	dependendo de uma classe em particular de controle analógico para um
	sistema em particular. Por exemplo, se você definir a opção
	``-paddle mouse``, então qualquer jogo que tenha um remo ou pá como
	controle será automaticamente configurado para ser usado com o mouse
	como se a opção ``-mouse`` tivesse sido definida.

	Observe que estes controles sobrescrevem as opções
	:ref:`-[no]mouse <mame-commandline-nomouse>`,
	:ref:`-[no]joystick <mame-commandline-nojoystick>`, etc.

.. raw:: latex

	\clearpage

Opções voltadas para a depuração
--------------------------------

.. _mame-commandline-verbose:

**-[no]verbose** / **-[no]v**

	Este é o **modo loquaz** [6]_, exibe todas as informações de
	diagnósticos disponíveis.
	Essas informações são úteis para apurar qualquer tipo de problemas
	com a sua configuração ou qualquer outra que possa aparecer.
	IMPORTANTE: favor rodar com ``mame -verbose`` e incluir a
	saída junto caso queira entrar em contato conosco para relatar um
	erro.

		O valor predefinido é **Desligado** (**-noverbose**).

.. _mame-commandline-oslog:

**-[no]oslog**

	Escreve um arquivo error.log com mensagens de diagnósticos do
	sistema caso um esteja presente.

	É predefinido que as mensagens de erro sejam enviadas para a saída
	padrão, geralmente é exibido no terminal, prompt de comando ou em um
	arquivo de log de sistema. No Windows, caso um depurador esteja
	sendo usado como o depurador do Visual Studio ou WinDbg, as
	mensagens de erros serão enviadas para estes ao invés de serem exibidas
	no terminal.

		O valor predefinido é **Desligado** (**-nooslog**).

.. _mame-commandline-log:

**-[no]log**

	Cria um arquivo chamado error.log que contém todos os registros de
	mensagens internas gerada pelo cerne do MAME e drivers de sistema.
	Isso pode ser usado ao mesmo tempo que ``-oslog`` para escrever os
	dados de saída de ambos ao mesmo tempo.

		O valor predefinido é **Desligado** (**-nolog**).

.. _mame-commandline-debug:

**-[no]debug** / **-[no]d**

	Habilita o depurador embutido no MAME. É predefinido que o depurador
	entre em ação ao pressionar a tela til (**~**) [7]_ durante a
	emulação.
	Ele também entra em ação imediatamente ao iniciar a emulação.

		O valor predefinido é **Desligado** (**-nodebug**).

.. _mame-commandline-debugscript:

**-debugscript** <*nome_do_arquivo*>

	Define um arquivo que vai conter a lista de comandos de depuração a
	serem executados no momento da inicialização.

		O valor predefinido é **NULO** (nenhum comando).

.. _mame-commandline-updateinpause:

**-[no]update_in_pause**

	Habilita a atualização do bitmap inicial da tela enquanto o sistema
	estiver pausado. Isso significa que a opção de retorno
	**VIDEO_UPDATE** sempre será chamada durante a pausa, o que pode ser
	útil durante a depuração.

	O valor predefinido é **Desligado** (**-noupdate_in_pause**).

.. raw:: latex

	\clearpage

.. _mame-commandline-watchdog:

**-watchdog** <*tempo*> / **-wdog** <*tempo*>

	Habilita o temporizador watchdog interno que vai automaticamente
	matar o processo do MAME caso o tempo de duração definido em
	<*tempo*> passe caso não haja nenhuma atualização de quadro.
	Tenha em mente que alguns sistemas ficam parados por algum tempo
	durante o carregamento da tela, então <*duration*> deve ser grande
	o suficiente para levar esse tempo extra em consideração.
	Geralmente, um valor entre **10** e **30** segundos devem ser
	suficientes.

		Nenhum watchdog vem habilitado.

.. _mame-commandline-debuggerfont:

**-debugger_font** <*nome_da_fonte*> / **-dfont** <*nome_da_fonte*>

	Define o nome da fonte a ser usada nas janelas do depurador.

	A fonte predefinida da janela é **Lucida Console**.
	A fonte predefinida do Mac (**Cocoa**) é o padrão de fonte de
	tamanho fixo do sistema (geralmente a fonte **Monaco**).
	A fonte padrão do Qt é **Courier New**.

.. _mame-commandline-debuggerfontsize:

**-debugger_font_size** <*pontos*> / **-dfontsize** <*pontos*>

	Define o tamanho da fonte a ser usada nas janelas do depurador
	em pontos.

	O tamanho padrão da janela é de **9** pontos.
	O tamanho padrão do Qt é de **11** pontos.
	O tamanho padrão do Mac (**Cocoa**) é o tamanho padrão usado pelo
	sistema.

.. raw:: latex

	\clearpage

Opções para a configuração da rede
----------------------------------

.. _mame-commandline-commlocalhost:

**-comm_localhost** <*endereço*>

	Definição para o endereço local. Este pode ser um endereço
	tradicional ``xxx.xxx.xxx.xxx`` ou um nome de host que possa ser
	resolvido

		O valor predefinido é **0.0.0.0**

.. _mame-commandline-commlocalport:

**-comm_localport** <*porta*>

	Definição da porta local. Esta pode ser qualquer porta de
	comunicação tradicional como um valor inteiro *non-signed* com
	16-bit (**0-65535**).

		O valor predefinido é **15122**.

.. _mame-commandline-commremotehost:

**-comm_remotehost** <*endereço*>

	Definição do endereço remoto. Este pode ser um endereço tradicional
	``xxx.xxx.xxx.xxx`` ou um nome de host que possa ser resolvido.

	O valor predefinido é **0.0.0.0**

.. _mame-commandline-commremoteport:

**-comm_remoteport** <*porta*>

	Definição da porta remota. Esta pode ser qualquer porta de
	comunicação tradicional como um valor inteiro *non-signed* com
	16-bit (**0-65535**).

		O valor predefinido é **15122**.

.. _mame-commandline-commframesync:

**-[no]comm_framesync**

	Sincroniza os frames entre os hosts na rede.

		O valor predefinido é **Desligado** (**-nocomm_framesync**).

.. raw:: latex

	\clearpage

Opções diversas
---------------

.. _mame-commandline-drc:

**-[no]drc**
	Ativa o núcleo o DRC (recompilador dinâmico) da CPU visando uma
	velocidade máxima de emulação, caso esteja disponível.

		O valor predefinido é **Ligado** (**-drc**).

.. _mame-commandline-drcusec:

**-drc_use_c**

	Force o uso de DRC usando infra-estrutura em código C.

	O valor predefinido é **Desligado** (**-nodrc_use_c**).

.. _mame-commandline-drcloguml:

**-drc_log_uml**

	Grave um registro descompilado DRC UML em um arquivo de registro
	(log).

		O valor predefinido é (**-nodrc_log_uml**).

.. _mame-commandline-drclognative:

**-drc_log_native**

	Grave o DRC nativo e descompilado num registro de log em formato
	assembler.

		O valor predefinido é **Desligado** (**-nodrc_log_native**).

.. _mame-commandline-bios:

**-bios** <*biosname*>

	Determina qual BIOS usar no sistema a ser emulado em sistemas
	que fazem uso de uma BIOS. A saída ``-listxml`` listará todos os
	nomes das BIOS disponíveis para o sistema.

		Não há valor predefinido (O MAME usará a primeira BIOS nativa
		do sistema que for encontrada, caso uma esteja disponível).

.. _mame-commandline-cheat:

**-[no]cheat** / **-[no]c**

	Ativa o cardápio de trapaças, exibindo uma lista de trapaças que
	ficam armazenadas em um arquivo externo chamado **cheat.7z**.
	Essa opção também habilita as opções de turbo dos botões.

		O valor predefinido é **Desligado** (**-nocheat**).

.. _mame-commandline-skipgameinfo:

**-[no]skip_gameinfo**

	Ao iniciar, faz com que o MAME não exiba a tela de informações do
	sistema ou jogo.

		O valor predefinido é **Desligado** (**-noskip_gameinfo**).

.. _mame-commandline-uifont:

**-uifont** <*nome_da_fonte*>

	Define o nome da fonte ou um nome do arquivo de fonte a ser usada na
	interface do usuário. Caso esta fonte não possa ser encontrada ou
	não puder ser carregada, o MAME usará a sua própria fonte embutida.
	Em algumas plataformas o <*nome_da_fonte*> (nome da fonte) pode ser
	um nome da fonte do sistema em vez de um arquivo fonte com extensão
	``.bdf``.

		O valor predefinido é **default** (O MAME usará a fonte nativa).

.. _mame-commandline-ui:

**-ui** <*type*>

	Define o tipo de interface do usuário a ser usada, as opções ficam
	entre **simple** ou **cabinet**.

		O valor predefinido é **Cabinet** (**-ui cabinet**).

.. _mame-commandline-ramsize:

**-ramsize** / **-ram** [*n*]

	Permite que você altere o tamanho padrão da RAM (caso exista suporte
	para tanto no driver).

.. raw:: latex

	\clearpage

.. _mame-commandline-confirmquit:

**-confirm_quit**

	Exibir um aviso na tela "*Confirmar Sair*" antes de sair, exigindo
	que o usuário confirme a ação antes de sair do MAME.

		O valor predefinido é **Desligado** (**-noconfirm_quit**).

.. _mame-commandline-uimouse:

**-ui_mouse**

	Exibe o ponteiro do mouse na interface do usuário do MAME.

		O valor predefinido é **sem mouse** (**-noui_mouse**).

.. _mame-commandline-language:

**-language** / **-lang** <*idioma*>

	Especifique um idioma para ser usado na interface do usuário, os
	arquivos de tradução para cada idioma estão no caminho definido em
	**languagepath**.

.. _mame-commandline-nvramsave:

**-[no]nvram_save** / **-[no]nvwrite**

	Salva o conteúdo da NVRAM ao sair da emulação. Caso essa opção seja
	desligada, o conteúdo que foi gravado anteriormente não será apagado
	e qualquer alteração atual não será gravada. Ao desabilitar essa
	função suprime incondicionalmente o salvamento de arquivos .nv
	associados com alguns tipos de programas usados em cartuchos.

		O valor predefinido é **Ligado** (**-nvram_save**)

.. raw:: latex

	\clearpage

Opções para uso com script
--------------------------

.. _mame-commandline-autobootcommand:

**-autoboot_command** / **-ab** "<*command*>"

	Cadeia de comandos que serão executados após a inicialização da
	máquina (entre aspas " "). Para emitir uma cotação para a
	emulação, use """ no comando. Usando **\\n** irá criar uma nova
	linha, emitindo o que foi digitado antes como comando.

	Exemplo: ``-autoboot_command "load """$""",8,1\\n``

.. _mame-commandline-autobootdelay:

**-autoboot_delay** [*n*]

	Tempo de atraso (em segundos) para o **-autoboot_command**.

.. _mame-commandline-autobootscript:

**-autoboot_script** / **-script** [*nome_do_arquivo.lua*]

	Carrega e executa um scrit após a inicialização da máquina.

.. _mame-commandline-console:

**-console**

	Habilita emulador do Console Lua.

		O valor predefinido é **Desligado** (**-noconsole**)

.. _mame-commandline-plugins:

**-plugins**
	Habilita o uso de plug-ins Lua

		O valor predefinido é **Ligado** (**-plugins**).

.. _mame-commandline-plugin:

**-plugin** [*plugin shortname*]

	Permite o uso de uma lista de plug-ins Lua separados por vírgula.

.. _mame-commandline-noplugin:

**-noplugin** [*plugin shortname*]

	Permite desabilitar uma lista de plug-ins Lua separados por vírgula.

.. raw:: latex

	\clearpage

Opções do servidor HTTP
-----------------------

.. _mame-commandline-http:

**-http**
	Habilita o servidor de HTTP.

		O valor predefinido é **Desligado** (**-nohttp**).

.. _mame-commandline-httpport:

**-http_port** [*port*]

	Define uma porta para o servidor HTTP.

		O valor predefinido é **8080**.

.. _mame-commandline-httproot:

**-http_root** [*rootfolder*]

	Define a pasta raíz para os documentos do servidor HTTP.

		O valor predefinido é **web**.

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
		sincronismo com a parte de baixo, surgindo um efeito ou
		um "*defeito*" onde cada metade se desloca para lados opostos
		horizontalmente. (Nota do tradutor)
.. [6]	Tagarela, que verbaliza muito, falador, barulhento.
		(Nota do tradutor)
.. [7]	Até que o teclado **ABNT-2** seja mapeado pela equipe do MAMEDev,
		essa tecla fica do lado esquerdo da tecla 1, logo abaixo da
		tecla ESQ. (Nota do tradutor)
