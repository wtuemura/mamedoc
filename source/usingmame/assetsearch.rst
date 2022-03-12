.. raw:: latex

	\clearpage


.. _assetsearch:

Como o MAME localiza os seus arquivos?
======================================

.. contents:: :local:

Introdução
----------

Ao contrário dos típicos programas de computador onde você navega pelo
seu disco e seleciona um arquivo para abrir ou um local para salvar, o
MAME possuí configurações que indicam onde procurar os arquivos que ele
usa. Você pode alterar estas configurações iniciando o MAME sem
qualquer parâmetro, depois selecionando :guilabel:`Configurações` e,
em seguida, selecionando :guilabel:`Configuração dos diretórios`
(lembre-se de clicar em :guilabel:`Salva a configuração` para aplicar
as suas alterações). Você também pode alterar as configurações editando
diretamente os arquivos ``mame.ini`` e ``ui.ini`` ou usando as
respectivas opções diretamente na linha de comando ou dos outros
arquivos de configuração. Para obter mais informações sobre todas as
opções disponíveis para controlar onde o MAME deve procurar pelos
arquivos e os diferentes tipos de configurações, consulte os capítulos
:ref:`mame-commandline-pathoptions` e o :ref:`advanced-multi-CFG`.

Terminologia
~~~~~~~~~~~~

Precisamos compreender algumas terminologias utilizadas nas explicações
mais adiante:

**Sistema**

    Um sistema é uma máquina completa que pode ser emulada pelo MAME.
    Alguns sistemas executam um programa (*software*) fixo, enquanto
    outros podem carregar programas a partir de um catálogo de programas
    e/ou os arquivos |deum|.

**Dispositivo**

    Um componente emulado que pode ser usado por vários sistemas ou por
    outros dispositivos. Alguns dispositivos precisam de uma cópia da
    imagem de uma ROM e alguns dispositivos permitem que um programa
    possa ser lido a partir de uma lista adicional de programas que
    serão usadas com um sistema específico.

.. raw:: latex

	\clearpage

**Sistema principal**

    O MAME usa uma relação de principal/clone para agrupar os sistemas
    relacionados. Um sistema no grupo é escolhido para ser o *principal*
    e os outros são chamados de *clones*. (A escolha do sistema
    principal é um tanto arbitrária. Não é necessariamente a original ou
    a variante definitiva).

**BIOS do sistema**

    Um sistema configurado sem programa. Isso é geralmente aplicável em
    sistemas do tipo arcade que usavam cartuchos com jogos
    intercambiáveis ou placas com as ROMs. Observe que isso *não* é o
    mesmo que as configurações da seleção da BIOS que permitem a escolha
    de uma ROMs para a inicialização do sistema (como as máquinas Neo
    Geo por exemplo) ou um *firmware* do dispositivo.

**O item de um programa**

    Um pacote de um programa descrito num catálogo de programas.
    Os itens dos programas podem consistir em diversas *partes* que
    podem ser montadas de forma individual. Devido a grande variedade de
    mídia compatível com o MAME, as partes do programa podem usar
    diferentes *carregadores*. Neles se incluí os *carregadores de ROM*,
    tipicamente utilizado por cartuchos e o *carregador de arquivo de
    uma imagem*, usado por partes do programa que consistem numa única
    imagem |deum| (como a imagem de um disquete, de um CD-ROM, de uma
    fita cassete, etc).

**O item de um programa principal**

    Os itens dos programas relacionados são agrupados usando
    relacionamentos do tipo principal/clone, numa forma semelhante aos
    sistemas relacionados.  Isso é geralmente utilizado para agrupar
    as diferentes versões ou os diferentes lançamentos de um mesmo tipo
    de programa. Caso o programa tenha um item principal, ele sempre
    estará no mesmo catálogo de programas.

**Nome abreviado**

    O MAME utiliza *nomes abreviados* para identificar de forma única,
    os sistemas e os dispositivos pelo item de um programa dentro de um
    catálogo e para também, identificar de forma única as partes do
    programa dentro de um programa.

    É possível ver o nome abreviado de um sistema destacando-o no menu
    de seleção do sistema, garantindo que o painel de informações esteja
    visível à direita e mostrando as :guilabel:`Informações gerais` na
    aba de :guilabel:`Informações`.  Por exemplo, o nome abreviado para
    o **Nintendo Virtual Boy** é ``vboy``. O nome abreviado do sistema e
    do dispositivo também podem ser vistos na saída das várias opções da
    linha de comando, incluindo as opções ``-listxml``, ``-listfull``,
    ``-listroms`` e ``-listcrc``.

    Você pode ver os nomes abreviados para um programa e em qual
    catálogo ele pertence, destacando-o no menu do catálogo de
    programas, garantindo que o painel de informações esteja visível
    à direita, fazendo com que seja mostrado as :guilabel:`Informações
    do catálogo de programas` na aba de :guilabel:`Informações`.
    Por exemplo, o nome abreviado para o sistema **Macintosh 6.0.3** é
    ``sys603`` e o nome abreviado para o catálogo de programas fica no
    arquivo ``mac_flop.xml``.  Os nomes abreviados do catálogo
    correspondem ao nome do arquivo (por exemplo, o catálogo de
    programas do cartucho do Sega Mega Drive/Genesis é um arquivo
    chamado de ``megadriv.xml`` e o seu nome abreviado é ``megadriv``).
    Você também pode ver as listas abreviadas do catálogo de programas,
    os programas e suas partes ao procurar pelo atributo ``name`` nos
    arquivos XML do catálogo de programas que ficam dentro da pasta
    **hash**.

.. raw:: latex

	\clearpage


Opções do caminho para fazer a busca
------------------------------------

A maioria das opções para definir os locais de busca, permitem que
vários diretórios sejam adicionados desde que eles sejam separados por
ponto e vírgula (``;``).  As variáveis de ambiente são expandidas usando
a sintaxe do prompt de comando no Windows ou no terminal nos sistemas
UNIX.

Os caminhos relativos são interpretados em relação ao diretório atual de
trabalho no momento do uso. No Windows, caso o executável do MAME seja
iniciado com um duplo clique, o diretório de trabalho será este
onde o executável do MAME estiver. Caso inicie o MAME clicando duas
vezes nele através do *Finder* do macOS ou na maioria das distribuições
Linux, o seu **home** será definido como o diretório de trabalho.


Arquivos compactados
--------------------

O MAME pode carregar arquivos compactados do tipo PKZIP (ZIP) e LZMA
(7-Zip) (estes devem ter as extensões ``.zip`` e ``.7z``
respectivamente). Uma série de extensões são compatíveis com o formato
PKZIP, incluindo o Zip64 para arquivos grandes, registros de data e hora
(*timestamps*) do NTFS e a compressão LZMA. Apenas o formato ASCII pode
ser usado nos nomes dos arquivos ou UTF-8 nos arquivos do tipo PKZIP
(os arquivos 7-Zip sempre usam nomes de arquivo com UTF-16).

Porém, o MAME **não carrega** arquivos que estejam agrupados e
compactados num único arquivo, por exemplo, quando todas as ROMs do
Master System estiverem dentro de um arquivo chamado ``sms.zip`` ou
quando todas as ROMs do Mega Drive estiverem compactadas dentro de um
arquivo chamado ``megadriv.zip`` e assim por diante. O MAME não possui
compatibilidade com arquivos dividido em vários segmentos (arquivos
divididos em partes como, ``.zip.001``, ``.zip.002``, ``*-part.001``,
``*-part.002``, etc), com arquivos criptografados e com o método legado
de compactação do tipo "implosão" nos arquivos PKZIP.

O desemprenho do MAME pode ser reduzido ao utilizar arquivos compactados
com uma grande quantidade de itens dentro deste arquivo. Os arquivos
compactados que usam o algoritmo de compactação LZMA (7-zip) utilizam a
CPU de forma mais intensa durante o processo de descompactação se
comparado aos arquivos compactados usando algoritmos mais simples como o
PKZIP. O layout do arquivo não é levado em consideração durante o
carregamento dos arquivos, então o uso de "compactação sólida"
geralmente resulta no MAME descompactando os mesmos dados repetidamente
durante o carregamento da mídia.


Como o MAME procura por uma mídia?
----------------------------------

Use a opção :ref:`rompath <mame-commandline-rompath>` para definir o
caminho das pastas onde as imagens das ROMs, as imagens de disco e
outras mídias devem ser procuradas. É predefinido que o MAME procure
pela mídia numa pasta chamada **roms** dentro do diretório de trabalho.
Para o propósito desta discussão, o disquete, a fita cassete, a fita de
papel e as outras imagens |deum| que não sejam armazenados no formato
CHD são tratados como cópias das ROMs.

Ao procurar por uma cópia (*dump*) do sistema, do dispositivo ou do
programa, o MAME trata as pastas e arquiva dentro das pastas
configuradas pela opção ``rompath`` como equivalente, mas lembre-se da
limitação onde o MAME não pode carregar os arquivos de um arquivo
contido em outro arquivo (um arquivo compactado que tenha outro arquivo
compactado dentro). O MAME procura primeiro uma pasta, depois procura
por um arquivo PKZIP e, finalmente, um arquivo 7-Zip. Ao procurar uma
cópia da ROM num arquivo, o MAME primeiro procura um arquivo com um
determinado nome e com um determinado CRC. Caso o arquivo correspondente
não seja encontrado, o MAME procura por um arquivo com um determinado
CRC ignorando o nome. Caso nenhum arquivo correspondente seja
encontrado, o MAME finalmente procura por um arquivo com um determinado
nome, ignorando o CRC.

Embora o MAME possa carregar imagens de disco no formato CHD de dentro
dos arquivos, isso não é recomendado. Os arquivos CHD já possuem dados
compactados, o formato em si já está compactado e os dados são
armazenados de uma maneira permite o acesso aleatório dos arquivos. Caso
uma imagem de disco no formato CHD esteja armazenada num arquivo PKZIP
ou num 7-Zip, o MAME precisa primeiro, carregar o arquivo inteiro na
memória para poder usá-lo. Para casos como um disco rígido ou para
imagens de um LaserDisc, isso provavelmente usará uma quantidade de
espaço grande no arquivo de troca (*swap*), prejudicando o desempenho e
possivelmente reduzindo a expectativa de vida útil dos seus discos ou
SSDs. É melhor manter as imagens CHD sem compressão dentro das suas
respectivas pastas.


As ROMs dos sistemas
~~~~~~~~~~~~~~~~~~~~

Para cada pasta configurada em ``rompath``, o MAME procura as ROMs do
sistema nos seguintes locais:

* |npon| do próprio sistema.
* |npon| do sistema principal do sistema, caso seja aplicável.
* |npon| da BIOS do sistema correspondente, caso seja aplicável.

Usando a máquina **Shiritsu Justice Gakuen** como exemplo, o MAME
buscará pelas ROMs do sistema nesta ordem:

* O nome abreviado do sistema é ``jgakuen``, então o MAME irá procurar
  por uma pasta chamada **jgakuen**, um arquivo PKZIP chamado
  ``jgakuen.zip`` ou um arquivo 7-Zip chamado ``jgakuen.7z``.
* O sistema principal é a versão européia do **Rival Schools**, que tem
  o nome abreviado ``rvschool``, então o MAME irá procurar por uma pasta
  chamada **rvschool**, um arquivo PKZIP chamado ``rvschool.zip`` ou um
  arquivo 7-Zip chamado ``rvschool.7z``.
* A BIOS do sistema correspondente é a placa Capcom ZN2, que tem o nome
  abreviado ``coh3002c``, então o MAME irá procurar uma pasta chamada
  **coh3002c**, um arquivo PKZIP chamado ``coh3002c.zip`` ou um arquivo
  7-Zip chamado ``coh3002c.7z``.


ROMs do dispositivo
~~~~~~~~~~~~~~~~~~~

Para cada caminho configurado em ``rompath``, o MAME procurará pelas
ROMs dos dispositivos nos seguintes locais:

* |npon| do dispositivo.
* |npon| da ROM do dispositivo principal do dispositivo, caso seja
  aplicável.
* |npon| do sistema.
* |npon| do sistema principal do sistema, caso seja aplicável.
* |npon| da BIOS do sistema correspondente, caso seja aplicável.

Usando o clone **Unitron 1024 Macintosh** com um teclado francês
**Macintosh Plus** com um teclado numérico como exemplo, o MAME
procurará a ROM do microcontrolador do teclado da seguinte maneira:

* O nome abreviado do teclado francês **Macintosh Plus** é
  ``mackbd_m0110a_f``, então o MAME procurará uma pasta chamada
  **mackbd_m0110a_f**, um arquivo PKZIP chamado ``mackbd_m0110a_f.zip``
  ou um arquivo 7-Zip chamado ``mackbd_m0110a_f.7z``.
* A ROM principal do dispositivo é o teclado U.S. **Macintosh Plus** com
  um teclado numérico, que tem o nome abreviado ``mackbd_m0110a``, então
  o MAME procurará por uma pasta chamada **mackbd_m0110a**, um arquivo
  PKZIP chamado ``mackbd_m0110a.zip`` ou um arquivo 7-Zip chamado
  ``mackbd_m0110a.7z``.
* O nome abreviado do sistema **Unitron 1024** é ``utrn1024``, então o
  MAME procurará por uma pasta chamada **utrn1024**, um arquivo PKZIP
  chamado ``utrn1024.zip`` ou um arquivo 7-Zip chamado ``utrn1024.7z``.
* O sistema principal do **Unitron 1024** é o **Macintosh Plus**, que
  tem o nome abreviado ``macplus``, então o MAME irá procurar por uma
  pasta chamada **macplus**, um arquivo PKZIP chamado ``macplus.zip`` ou
  um arquivo 7-Zip chamado ``macplus.7z``.
* Caso não haja uma BIOS que corresponda ao sistema, então o MAME não
  fará mais buscas.


As ROMs dos itens dos programas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para cada pasta configurada em ``rompath``, o MAME procura pelos itens
dos programas do sistema nos seguintes locais:

* |npon| do item dos programas correspondente dentro de uma pasta
  correspondente ao nome abreviado do catálogo de programas (ou uma
  pasta correspondente ao nome abreviado do item do programa dentro de
  um arquivo correspondente ao nome do catálogo de programas).
* |npon| do item do programa principal dentro de uma pasta que
  corresponda ao nome abreviado do catálogo de programas, caso seja
  aplicável (ou uma pasta correspondente ao nome abreviado do item do
  software principal num arquivo que corresponda ao nome do catálogo de
  programas).
* |npon| do item do programa (assim é feito por questão de conveniência
  dos itens do programa que também são executados como sistemas
  autônomos com o mesmo nome abreviado, como nos jogos de Neo Geo).
* |npon| do item do programa principal, caso seja aplicável.  (Isso é
  utilizado para conveniência dos itens do programa que também são
  executados como sistemas autônomos com o mesmo nome abreviado, como
  nos jogos de Neo Geo).
* Quaisquer pastas e ou arquivos que seriam pesquisados pelas ROMs do
  sistema ou do dispositivo para o sistema ou para o dispositivo onde a
  lista do programa pertença. Isso é utilizado por questões históricas
  devido à forma como a compatibilidade ao catálogo de programas foi
  originalmente adicionado no MESS e será removido numa versão futura do
  MAME.

Ao carregar a versão alemã do **Dune II** do cartucho do
Mega Drive/Genesis a partir do catálogo de programas na versão PAL do
Mega Drive, o MAME procurará a ROM do cartucho ROM da seguinte maneira:

* O nome abreviado do item do programa para a versão alemã do
  **Dune II** é ``dune2g`` e o nome abreviado da ROM do cartucho do
  Mega Drive/Genesis no catálogo de programas é ``megadriv``, então o
  MAME procurará por uma pasta chamada **dune2g**, um arquivo PKZIP
  chamado ``dune2g.zip`` ou um arquivo 7-Zip chamado ``dune2g.7z``
  dentro de uma pasta chamada **megadriv** (ou uma pasta chamada
  **dune2g** dentro de um arquivo PKZIP chamado ``megadriv.zip`` ou um
  arquivo 7-Zip chamado ``megadriv.7z``).
* O item do programa principal é a versão PAL europeia genérica do
  **Dune II** no mesmo catálogo de programas, que tem o nome abreviado
  ``dune2``, então o MAME procurará uma pasta chamada **dune2**, um
  arquivo PKZIP chamado ``dune2.zip`` ou um arquivo 7-Zip arquivo
  chamado ``dune2.7z`` dentro de uma pasta chamada **megadriv** (ou uma
  pasta chamado **dune2** dentro de um arquivo PKZIP chamado
  ``megadriv.zip`` ou um arquivo 7-Zip chamado ``megadriv.7z``).
* O próximo MAME irá ignorar o nome abreviado do catálogo de programas e
  usará apenas o nome abreviado do item do programa, procurando por uma
  pasta chamada **dune2g**, um arquivo PKZIP chamado ``dune2g.zip`` ou
  um arquivo 7-Zip chamado ``dune2g.7z``.
* Ainda ignorando o nome abreviado do catálogo de programas, o MAME
  usará apenas o nome abreviado do programa principal, procurando uma
  pasta chamada **dune2**, um arquivo PKZIP chamado ``dune2.zip`` ou um
  arquivo 7-Zip chamado ``dune2.7z``.
* O nome abreviado da versão do sistema PAL do Mega Drive é
  ``megadriv``, então o MAME procurará por uma pasta chamada
  **megadriv**, um arquivo PKZIP chamado ``megadriv.zip`` ou um arquivo
  7-Zip chamado ``megadriv.7z``.
* O sistema principal da versão PAL do Mega Drive é o sistema
  norte-americano Genesis, que tem o nome curto ``genesis``, então o
  MAME irá procurar uma pasta chamada **genesis**, um arquivo PKZIP
  chamado ``genesis.zip`` ou um arquivo 7-Zip chamado ``genesis.7z``.


As imagens de disco no formato CHD
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O MAME procura pelos sistemas, pelos dispositivos e os itens do programa
através das as imagens de disco no formato CHD, com algumas diferenças:

* Para os sistemas e para os itens de um programa, o MAME verificará o
  sistema ou programa principal se aplicável com os nomes alternativos
  para uma imagem de disco com o mesmo conteúdo. Isso permite que você
  mantenha uma única cópia de uma imagem de disco no formato CHD para um
  sistema principal, um item de um programa ou quaisquer clones que
  dependam de uma imagem de disco com o mesmo conteúdo,
  independentemente do nome esperado pelos clones.
* Para os itens de um programa, o MAME procurará imagens de disco no
  formato CHD numa pasta que corresponda ao nome abreviado no catálogo
  de programas. Isso é utilizado para conveniência quando todos os itens
  num catálogo de programas que tenham apenas uma única imagem de disco
  cada em formato CHD.
* Recomendamos que você **não comprima** as imagens de disco em formato
  CHD num arquivo PKZIP ou num arquivo 7-Zip. No entanto, caso isso seja
  feito, o MAME só conseguirá encontrar os discos em formato CHD dentro
  dos arquivos com um determinado nome. Isto ocorre porque o MAME
  utiliza o conteúdo do cabeçalho CHD e uma soma de verificação
  (*checksum*) do próprio arquivo CHD. A soma de verificação do próprio
  arquivo CHD pode variar dependendo das opções de compressão.


Programas avulsos
~~~~~~~~~~~~~~~~~

Muitos sistemas são compatíveis com o carregamento da mídia a partir de
um arquivo informando o caminho do arquivo na linha de comando usando
uma das opções |deum|. Os caminhos relativos são interpretados em
relação ao diretório de trabalho atual.

Você pode definir um caminho para um arquivo dentro de um arquivo PKZIP
ou 7-Zip da mesma maneira que definir um caminho para um arquivo numa
pasta (lembre-se de que você pode ter no máximo um único arquivo num
caminho, pois o MAME não suporta o carregamento de arquivos de arquivos
contidos em outros arquivos). Caso defina um caminho para um arquivo
PKZIP ou um arquivo 7-Zip, o MAME usará o primeiro arquivo encontrado no
arquivo (isso depende da ordem onde os arquivos são armazenados no
arquivo, é mais útil para arquivos contendo um único arquivo).

Inicie o Nintendo Entertainment System/Famicom com o arquivo
**amazon_diet_EN.nes** montado no slot do cartucho:

.. code-block:: bash

    mame nes -cart amazon_diet_EN.nes

.. raw:: latex

	\clearpage

Inicie o sistema Osborne-1 com o primeiro arquivo do arquivo
``os1xutls.zip`` montado na primeira unidade de disquete:

.. code-block:: bash

    mame osborne1 -flop1 os1xutils.zip

Inicie o sistema **Macintosh Plus** com o arquivo ``system tools.img``
no arquivo ``sys603.zip`` montado na primeira unidade de disquete:

.. code-block:: bash

    mame macplus -flop1 "sys603.zip/system tools.img"


Diagnosticando uma mídia ausente
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ao iniciar um sistema a partir do menu de seleção do MAME ou a partir da
seleção do menu do catálogo de programas, o MAME irá listar qualquer
sistema, cópia da ROM do dispositivo (*dump*) ou as imagens ausentes do
disco, desde que haja pelo menos uma cópia da imagem da ROM ou uma
imagem de disco presente para o sistema. Para os clones do sistemas,
pelo menos uma cópia da ROM deve estar presente ou uma imagem de disco
*exclusiva para o clone*, para que o MAME possa listar as ROMs e as
imagens de disco que estiverem ausentes.

Caso todas as imagens de disco, todas as ROMs do sistema e todas as ROMs
do dispositivo estejam presentes e o sistema estiver sendo iniciado com
um item de um programa, o MAME verificará se a ROM e a imagem do disco
para o item do programa estão presentes.  Se pelo menos uma ROM ou uma
imagem de disco para o item de um programa estiver presente, o MAME
listará todas as ROMs ou as imagens de disco que estiverem ausentes.

Por exemplo, se você tentar iniciar o sistema **Macintosh Plus** e a ROM
do microcontrolador do teclado estiver ausente, o MAME exibe a seguinte
mensagem de erro::

    As imagens ROM/disco necessárias para o sistema selecionado ou estão
    faltando ou estão incorretas.
    Adquira os arquivos corretos ou selecione um sistema diferente.

    O arquivo 341-0332-a.bin (mackbd_m0110a) não foi encontrado

    Pressione qualquer tecla para continuar.

O nome da ROM que falta é mostrado (``341-0332-a.bin``) bem como o
nome abreviado do dispositivo ao qual ele pertence (``mackbd_m0110a``).
Quando uma ROM está ausente ou a imagem do disco não for específico para
o sistema selecionado, o nome abreviado do sistema ou do dispositivo ao
qual ele pertence será mostrado.

Caso inicie um sistema no MAME a partir do prompt de comando ou do
terminal, o MAME mostrará onde ele procurou pelas ROMs ou pelas imagens
de disco que não foram encontradas.

Usando o exemplo de um clone do **Unitron 1024 Macintosh** com um
teclado francês conectado, o MAME mostrará as seguintes mensagens de
erro caso as ROMs não estejam presentes::

    mame utrn1024 -kbd frp
    342-0341-a.u6d NOT FOUND (tried in utrn1024 macplus)
    342-0342-a.u8d NOT FOUND (tried in utrn1024 macplus)
    341-0332-a.bin NOT FOUND (tried in mackbd_m0110a_f mackbd_m0110a utrn1024 macplus)

O MAME utilizou o nome abreviado do sistema ``utrn1024`` e o nome
abreviado do sistema principal ``macplus`` durante a procura pelas ROMs
do sistema. Ao pesquisar pela ROM do microcontrolador do teclado, o MAME
utilizou o nome abreviado do dispositivo ``mackbd_m0110a_f``, o nome
abreviado da ROM dispositivo principal ``mackbd_m0110a``, o nome
abreviado do sistema ``utrn1024`` e o nome abreviado do sistema
principal ``macplus``.

As partes do programa que utilizam um carregador de ROM (geralmente uma
mídia em cartucho) mostra uma mensagem similar quando as ROMs não são
encontradas. Usando o exemplo da versão alemã do **Dune II** num Mega
Drive PAL, o MAME mostrará as seguintes mensagens de erro caso nenhuma
ROM esteja presente::

    mame megadriv dune2g
    mpr-16838-f.u1 NOT FOUND (tried in megadriv\dune2g megadriv\dune2 dune2g dune2 megadriv genesis)
    Fatal error: Required files are missing, the machine cannot be run.

O MAME procurou a ROM do cartucho usando:

* O nome abreviado do catálogo de programas do ``megadriv`` e o nome
  abreviado do programa ``dune2g``.
* O nome abreviado do catálogo de programas ``megadriv`` e o nome
  abreviado do programa principal ``dune2``.
* Apenas o nome abreviado do programa ``dune2g``.
* Apenas o nome abreviado do programa principal ``dune2``.
* Os locais que seriam procurados pelo sistema PAL do Mega Drive
  (o sistema ``megadriv`` com o nome abreviado e o nome abreviado do
  sistema principal ``genesis``).

As partes do programa que usam o carregador de arquivos de imagem
(incluindo disquetes e uma mídia em fita cassete) só verificam a mídia
depois que as imagens da ROM forem carregadas e os arquivos da mídia
forem mostrados de forma diferente.  Usando o exemplo do
**Macintosh System 6.0.3**, o MAME mostrará estas mensagens de erro caso
o programa esteja faltando::

    mame macplus -flop1 sys603:flop1
    :fdc:0:35dd: error opening image file system tools.img: No such file or directory (generic:2) (tried in mac_flop\sys603 sys603 macplus)
    Fatal error: Device Apple/Sony 3.5 DD (400/800K GCR) load (-floppydisk1 sys603:flop1) failed: No such file or directory

As mensagens de erro mostram onde o MAME fez a procura pelo arquivo de
imagem. Neste caso, ele usou o nome abreviado do catálogo de programas
``mac_flop`` e o nome abreviado do programa ``sys603``, apenas o nome
abreviado do programa ``sys603`` e os locais onde as ROMs do sistema
seriam procuradas.

.. |npon| replace:: Numa pasta ou num arquivo correspondente ao nome
.. |deum| replace:: de uma mídia
