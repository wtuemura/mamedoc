Usando o MAME
-------------

Caso você queira sair usando sem precisar usar a linha de comando
saiba que você já pode usar o MAME sem precisar baixar e configurar
nenhuma interface gráfica. Inicie o MAME sem parâmetros, lhe será
apresentada a interface gráfica do MAME ao clicar duas vezes no arquivo
**mame.exe** ou executando-o diretamente da linha de comando.
Caso você esteja interessado em desvendar todo o poder que o MAME pode
te oferecer, continue lendo.

Em plataformas baseadas em Macintosh OS X e plataformas com base Unix,
certifique-se de configurar a fonte do seu sistema para que corresponda
ao seu idioma antes de iniciar, caso contrário você pode não conseguir
ler o texto devido à falta de glifos e outros caracteres.

Caso você seja um novo usuário do MAME, você pode a princípio, achá-lo
um pouco complexo. Vamos falar um pouco sobre as listas de programas
(*softlists*), pois elas podem simplificar bastante as coisas para você.
Caso o conteúdo que você esteja tentando reproduzir já esteja listado no
MAME, iniciar o conteúdo é tão fácil quanto;

	**mame.exe** <*system*> <*software*>

Por exemplo:

	**mame.exe nes metroidu**

Isso vai fazer com que o a versão americana do Metroid para o Nintendo
Entertainment System seja carregada.

Alternativamente, você poderia começar MAME com:

	**mame.exe nes**

E escolher numa *lista de jogos* qual deseja iniciar. A partir daí
você pode escolher qualquer jogo compatível com a lista que você tenha,
essa listagem nada mais é do que um conjunto de todas as ROMs que você
tem armazenado na pasta ROMs ou outro lugar que você tenha configurado.
Observe que muitas cópias de ROMs antigas, de fitas e discos que
funcionavam em versões anteriores, podem não mais serem reconhecidas
pelas versões mais novas do MAME, exigindo que você as atualize ou as
renomeie para um nome compatível com a última versão do MAME para que
elas possam voltar a funcionar.

Caso você esteja carregando uma placa de arcade ou outro conteúdo que
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

Lembre-se que se você digitar um nome de sistema <*system*> que não
corresponda a nenhum sistema emulado [1]_, o MAME irá sugerir algumas opções
próximas ao que você digitou. Caso você não saiba quais mídias <*media*>
estão disponíveis, você sempre poderá iniciar a emulação como mostra
o exemplo abaixo:

	**mame.exe** <*system*> **-listmedia**

Caso você não saiba qual opção <*options*> está disponível, há algumas
coisas que você pode fazer. Primeiro de tudo, você pode verificar a
seção deste manual sobre as opções de linha de comando. Você também pode
tentar alguns citados em :ref:`frontends`, dentre outros disponíveis
para o MAME.

Como alternativa, você também pode usar a opção abaixo para obter ajuda:


	**mame.exe -help**

O comando exibe algumas opções básicas de uso, a versão do MAME e outras
informações.


	**mame.exe -showusage**

Mostra uma lista (bastante longa) das opções de linha de comando
disponíveis para o MAME. As opções principais são descritas na seção
:ref:`index-commandline` deste manual.


	**mame.exe -showconfig**

Mostra uma lista (bastante longa) das opções de configuração que estão
sendo usadas pelo MAME. Essas configurações sempre podem ser modificadas
na linha de comando ou editadas diretamente no arquivo ``mame.ini`` que
é o arquivo de configuração primário do MAME. Você pode encontrar uma
descrição de algumas opções de configuração na seção
:ref:`index-commandline` do manual (na maioria dos casos, cada opção de
configuração listada ali, possui uma versão equivalente para a linha de
comando).

.. raw:: latex

	\clearpage

Cria um novo arquivo ``mame.ini`` com as configurações primárias já
predefinidas.

	**mame.exe -createconfig**

Observe que o ``mame.ini`` é basicamente um arquivo de texto simples,
portanto, você pode abri-lo com qualquer editor de texto (como o
Notepad, `Geany <https://www.geany.org/>`_,
`Emacs <https://www.gnu.org/software/emacs/>`_ ou
`TextEdit <https://support.apple.com/pt-br/guide/textedit/welcome/mac>`_
por exemplo) e alterar todas as opções conforme a sua necessidade. A
principio, não há a necessidade de nenhum ajuste específico para começar
a usar o MAME, então você pode basicamente deixar a maioria das opções
inalteradas.

Caso o MAME venha a ser atualizado, novas opções disponíveis serão
aplicadas ao ``mame.ini`` anterior [2]_ quando o comando for executado
novamente.

Agora que você tem mais confiança, você pode tentar melhorar e
customizar as opções do MAME. Só tenha em mente a ordem em que as opções
são lidas.

Veja :ref:`advanced-multi-CFG` para obter mais informações.

.. [1]	Existe uma diferença entre sistema e máquina, o comando em
		questão funciona apenas com sistemas. Arcades são considerados
		máquinas como o CPS1, CP2, ZN, etc. O comando ao ser usado com
		uma máquina irá retornar um erro "*Unknown system*".
		(Nota do tradutor)
.. [2]	Caso você tenha alguma opção customizada neste arquivo, é
		recomendável que um backup seja feito antes de executar o
		comando. (Nota do tradutor)
