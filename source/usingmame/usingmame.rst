Primeiros passos
----------------

Atualmente já é possível sair usando o MAME sem precisar usar qualquer
parâmetros na linha de comando. Para iniciar a interface gráfica basta
iniciar o executável clicando duas vezes no **mame.exe** (32 bit) ou
**mame64.exe** (64 bit). Continue lendo caso tenha interesse em
desvendar todo o potencial que o MAME pode te oferecer.

Em plataformas baseadas em Macintosh OS X e plataformas com base Unix,
certifique-se de configurar a fonte do seu sistema para que corresponda
ao seu idioma antes de iniciar, caso contrário você pode não conseguir
ler o texto devido à falta de glifos e outros caracteres.

Para marinheiros de primeira viagem o MAME pode parecer um pouco
complexo, porém é bem mais simples do que parece. Você pode iniciar uma
máquina selecionando ela na lista que aparece do lado direito da tela ou
pode também iniciar usando a linha de comando:

	**mame.exe** <*system*> <*software*>

Em **system** você pode escolher uma das centenas de sistemas emulados,
já em **software** é o nome da máquina [#]_ que deseja rodar. O software
nada mais é do que um nome de uma ROM. É possível também a utilização de
**lista de programa** (**softlists**) que é um grade catálogo de
software ou máquinas de diferentes sistemas conhecidos no banco de dados
interno do MAME.

Para rodar o **Sonic the Headgehog** na versão do **Sega Genesis
Americano** execute o comando como mostrado abaixo:

	**mame.exe genesis sonic**

Alternativamente, você pode também começar MAME apenas com o sistema:

	**mame.exe genesis**

E escolher numa *lista de jogos* qual deseja iniciar selecionando
:menuselection:`cart --> lista de programa`, para que essa lista
funcione é necessário ter um conjunto de máquinas no diretório **roms**.
Observe que muitas cópias de ROMs antigas, de fitas e discos que
funcionavam em versões anteriores, podem não mais serem reconhecidas
pelas versões mais novas do MAME, exigindo que você as atualize ou as
renomeie caso o nome tenha mudado ao longo do tempo e seja compatível
com a última versão do MAME para que elas voltem a funcionar.

Caso seja carregado um sistema arcade ou outro conteúdo que
não esteja na lista, as coisas ficam um pouco mais complicadas.

A estrutura básica da linha de comando fica assim:

	**mame.exe** <*system*> <*media*> <*software*> <*options*>

Onde:

*	<*system*> é o apelido ou o nome encurtado do sistema que deseja
	emular (por exemplo, nes, c64, etc).
*	<*media*> é o seletor da mídia que você deseja carregar (se for um
	cartucho, tente **-cart** ou **-cart1**; caso seja um disquete,
	tente **-flop** or **-flop1**; caso seja um CD-ROM, tente
	**-cdrom**).
*	<*software*> é o programa ou jogo que deseja carregar (também pode
	ser usado o caminho completo para o arquivo a ser carregado ou como
	o nome abreviado do arquivo que esteja na sua lista de software).
*	<*options*> é qualquer opção de linha de comando adicional para
	controles, vídeo, áudio, etc.

Lembre-se que ao digitar um nome de sistema <*system*> e este ainda não
exista ou não seja emulado [#]_, o MAME irá sugerir algumas
opções próximas ao que foi digitado. No caso de desconhecimento de quais
mídias <*media*> estão disponíveis, inicie a emulação como mostra o
exemplo abaixo:

	**mame.exe** <*system*> :ref:`-listmedia <mame-commandline-listmedia>` <*options*>


Para saber quais são as opções <*options*> estão disponíveis, leia o
capítulo :ref:`universal-command-line` deste manual, veja também as
:ref:`frontends`.

Como alternativa, você também pode usar a opção de ajuda abaixo:

	**mame.exe -help**

O comando exibe algumas opções básicas de uso, a versão do MAME e outras
informações.

	**mame.exe -showusage**

Mostra uma lista (bastante longa) das opções disponíveis na linha de
comando. As opções principais são descritas na seção
:ref:`index-commandline` deste manual.

	**mame.exe -showconfig**

Mostra uma lista (bastante longa) das opções de configuração que estão
sendo usadas pelo MAME. Essas configurações sempre podem ser modificadas
na linha de comando ou editadas diretamente no arquivo de configuração
``mame.ini``, este é o arquivo primário de configuração do MAME. É
possível encontrar uma descrição de algumas opções de configuração na
seção :ref:`index-commandline` deste manual (na maioria dos casos, cada
opção de configuração listada ali, possui uma versão equivalente para a
linha de comando).

Para criar um novo arquivo ``mame.ini`` com as configurações primárias
já predefinidas:

	**mame.exe -createconfig** ou **mame.exe -cc**

Serão criados 3 arquivos, o ``mame.ini`` que é o arquivo primário de
configuração, o ``plugins.ini`` que é o arquivo que armazena uma lista
de plugins disponíveis e o ``ui.ini``, este arquivo armazena toda a
customização feita na interface interna como mudar o tamanho e o
nome da fonte, a cor da interface, etc.

Observe que o ``mame.ini`` é basicamente um arquivo de texto simples,
que pode ser editado com qualquer editor de texto (como o
Notepad, `Geany <https://www.geany.org/>`_,
`Emacs <https://www.gnu.org/software/emacs/>`_ ou
`TextEdit <https://support.apple.com/pt-br/guide/textedit/welcome/mac>`_
por exemplo) e alterar todas as opções conforme a sua necessidade. A
principio, não há a necessidade de nenhum ajuste específico para começar
a usar o MAME, então você pode basicamente deixar a maioria das opções
inalteradas.

Caso o MAME venha a ser atualizado, novas opções disponíveis serão
aplicadas ao ``mame.ini`` anterior [#]_ quando o comando for executado
novamente.

Neste capítulo revelamos apenas o topo do iceberg, há muito mais para
ser revelado, nos próximos capítulos começaremos a entrar mais a fundo
nos detalhes de todos os comandos compatíveis e todas as possibilidades
de customização do MAME.

.. [#]	Os desenvolvedores do MAME preferem usar o termo **máquinas** ao
		invés de **jogos**, talvez visando evitar problemas legais?
.. [#]	Existe uma diferença entre sistema e máquina, o comando em
		questão funciona apenas com sistemas. Arcades são considerados
		máquinas como o CPS1, CP2, ZN, etc. O comando ao ser usado com
		uma máquina irá retornar um erro "*Unknown system*".
		(Nota do tradutor)
.. [#]	Caso haja alguma opção customizada neste arquivo, é
		recomendável que um backup seja feito antes pois até o presente
		momento, **este comando não atualiza nada**, ele apaga as
		informações anteriores e reescreve novas. (Nota do tradutor)
