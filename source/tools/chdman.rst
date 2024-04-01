.. _chdman:

Chdman
======

O chdman é um gerenciador de arquivos CHD que pode ser usado para
criar, converter, verificar a integridade dos arquivos e extrair dados
das imagens de mídia no formato CHD. |pcd|.

A utilização típica é ``chdman <comando> <opção>...``

.. note::
	Parent CHD = CHD principal, para obter mais informações sobre termos
	como "parent", "clone" e outros, consulte :ref:`aboutromsets`.

.. raw:: latex

	\clearpage

.. contents:: :local:


.. _chdman-commonopts:

Opções comuns
-------------

A disponibilidade das opções abaixo variam de acordo com o comando:

**--input <arquivo>** / **-i <arquivo>**

	Define o arquivo de entrada. Esta opção é obrigatória para a
	maioria dos comandos. |ofce|.


**--inputparent <arquivo_chd>** / **-ip <arquivo_chd>**

	Define o arquivo CHD principal como o arquivo de entrada. Esta
	opção é compatível com a maioria dos comandos que operam com
	arquivos de entrada no formato CHD. Esta opção deve ser usada caso o
	arquivo de entrada seja um *delta CHD*. |dchd|.


**--inputstartbyte <offset>** / **-isb <offset>**

	Define o offset em bytes para os dados no arquivo de entrada.
	|iupc| que possuam um cabeçalho antes do início dos dados, ou,
	|peoc|. |npse| ``--inputstarthunk``/``-ish``.


.. raw:: latex

	\clearpage


**--inputstarthunk <offset>** / **-ish <offset>**

	Define o offset para os dados no arquivo de entrada em
	blocos. |npse| ``--inputstartbyte``/``-isb``.


**--inputbytes <comprimento>** / **-ib <comprimento>**

	Define a quantidade de dados de entrada em bytes, |cpod|. |iupc| que contêm conteúdo
	adicional após os dados ou |peoc|. |npse| ``--inputhunks``/``-ih``.


**--inputhunks <comprimento>** / **-ih <comprimento>**

	Define a quantidade de dados de entrada nos blocos, |cpod|.
	|npse| ``--inputbytes``/``-ib``.


**--output <arquivo>** / **-o <arquivo>**

	Define o nome do arquivo de saída. Esta opção é necessária para
	comandos que produzem arquivos de saída. |ofcs|.


**--outputparent <arquivo_chd>** / **-op <arquivo_chd>**

	Define o nome do arquivo de saída do CHD principal. |eocc|.
	O uso desta opção produz um *delta CHD*. |dchd|. A mídia do CHD
	principal deve ser do mesmo tipo, do mesmo tamanho e ter blocos com
	o mesmo tamanho.


**--compression none|<tipo>[,<tipo>]...** / **-c none|<tipo>[,<tipo>]...**

	Define quais algoritmos de compressão usar. |eocc|. Use ``none``
	para desativar a compressão ou especifique até quatro algoritmos de
	compressão separados por vírgula. Consulte
	:ref:`algoritmos de compressão <chdman-compression>` para conhecer
	os algoritmos de compressão compatíveis. A compressão deve ser
	desativada para criar arquivos de imagem de mídia graváveis.


**--hunksize <bytes>** / **-hs <bytes>**

	Define o tamanho do bloco em bytes. |eocc|. O tamanho do bloco
	não pode ser menor que ``16 bytes`` nem maior que ``1048576 bytes``
	(1 MiB). O tamanho do bloco deve ser um múltiplo do tamanho do
	setor ou do tamanho da unidade da mídia. Blocos com tamanhos maiores
	podem proporcionar melhores taxas de compressão, mas reduzem o
	desempenho nas pequenas leituras aleatórias, pois um bloco inteiro
	precisa ser lido e descomprimido de cada vez.


**--force** / **-f**

	Substitui os arquivos gerados caso já existam. Esta opção é
	compatível com os comandos que geram arquivos.


**--verbose** / **-v**

	Ativa o modo loquaz. Em alguns comendos esta opção gera informações
	mais detalhadas.


**--numprocessors <quantidade>** / **-np <quantidade>**

	Limita a quantidade máxima de threads utilizada para a compressão de
	dados. |eocc|.


.. _chdman-commands:

Comandos
--------

info
~~~~

Exibe informações de um arquivo no formato CHD. As informações incluem:

* Versão do formato CHD e os algoritmos de compressão utilizados.
* O valor de tamanhos compactados e não compactados e a taxa geral de
  compressão.
* O tamanho do bloco, o tamanho da unidade e a quantidade de blocos no
  arquivo.
* Informações do SHA1 e dos metadados.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--verbose`` / ``-v``

Consulte também o capítulo :ref:`Gerando um arquivo de registro de um
arquivo CHD <advanced-tricks-chd-info>`.


verify
~~~~~~

Verifica a integridade de um arquivo no formato CHD. O arquivo de
entrada deve ser um arquivo CHD somente leitura (a integridade dos
arquivos graváveis do CHD não poderá ser verificada). Observe que este
comando altera o arquivo de entrada caso a opção ``--fix``/``-f`` seja
utilizada.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputparent <arquivo_chd>`` / ``-ip <arquivo_chd>``

|oa|:

* ``--fix`` / ``-f``


createraw
~~~~~~~~~

Cria um arquivo no formato CHD a partir de uma imagem de mídia em
formato RAW.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputstartbyte <offset>`` / ``-isb <offset>``
* ``--inputstarthunk <offset>`` / ``-ish <offset>``
* ``--inputbytes <comprimento>`` / ``-ib <comprimento>``
* ``--inputhunks <comprimento>`` / ``-ih <comprimento>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--outputparent <arquivo_chd>`` / ``-op <arquivo_chd>``
* ``--compression none|<tipo>[,<tipo>]...`` / ``-c none|<tipo>[,<tipo>]...``
* ``--hunksize <bytes>`` / ``-hs <bytes>``
* ``--force`` / ``-f``
* ``--numprocessors <quantidade>`` / ``-np <quantidade>``

|oa|:

**--unitsize <bytes>** / **-us <bytes>** (obrigatório)

	A unidade de tamanho em bytes para gerar o arquivo CHD. Esta é a
	menor unidade de dados que pode ser endereçada dentro do arquivo
	CHD. Ela deve corresponder ao tamanho do setor ou da página original
	da mídia. O tamanho do bloco deve ser um múltiplo inteiro do tamanho
	da unidade. A unidade deve ser definida caso nenhum CHD principal
	tenha sido informado para gerar o arquivo final. Caso um CHD
	principal seja informado para gerar um arquivo CHD, o tamanho da
	unidade deverá corresponder ao tamanho da unidade do arquivo do CHD
	principal.

Na ausência das opções ``--hunksize`` ou ``-hs``, as predefinições
serão:

* O tamanho do bloco do arquivo do CHD principal, caso um arquivo CHD
  principal seja informado para gerar o arquivo final.
* O menor múltiplo inteiro do tamanho da unidade, não maior que
  ``4 KiB``, caso o tamanho da unidade não seja maior que ``4 KiB``
  (4096 bytes).
* O tamanho da unidade, caso seja maior que ``4 KiB`` (4096 bytes).

Na ausência das opções ``--compression`` ou ``-c``, a predefinição será
``lzma,zlib,huff,flac``.


createhd
~~~~~~~~

|cuad| disco rígido no formato CHD.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>``
* ``--inputstartbyte <offset>`` / ``-isb <offset>``
* ``--inputstarthunk <offset>`` / ``-ish <offset>``
* ``--inputbytes <comprimento>`` / ``-ib <comprimento>``
* ``--inputhunks <comprimento>`` / ``-ih <comprimento>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--outputparent <arquivo_chd>`` / ``-op <arquivo_chd>``
* ``--compression none|<tipo>[,<tipo>]...`` / ``-c none|<tipo>[,<tipo>]...``
* ``--hunksize <bytes>`` / ``-hs <bytes>`` (obrigatório)
* ``--force`` / ``-f``
* ``--numprocessors <quantidade>`` / ``-np <quantidade>``

|oa|:

* ``--sectorsize <bytes>`` / ``-ss <bytes>``
* ``--size <bytes>`` / ``-s <bytes>``
* ``--chs <cylinders>,<heads>,<sectors>`` / ``-chs <cylinders>,<heads>,<sectors>``
* ``--template <template>`` / ``-tp <template>``

Cria uma imagem de disco rígido vazia (preenchida com zeros). Caso
nenhuma entrada seja fornecida, as seguintes opções de entrada
início/comprimento não poderão ser utilizadas
(``--inputstartbyte``/``-isb``, ``--inputstarthunk``/``-ish``,
``--inputbytes``/``-ib`` e ``--inputhunks``/``-ih``).

Na ausência das opções ``--hunksize`` ou ``-hs``, as predefinições
serão:

* O tamanho do bloco do arquivo do CHD principal, caso um arquivo CHD
  principal seja informado para gerar o arquivo final.
* O menor múltiplo inteiro do tamanho do setor, não maior que ``4 KiB``,
  caso o tamanho do setor não seja maior que ``4 KiB`` (4096 bytes).
* O tamanho do setor, caso seja maior que ``4 KiB`` (4096 bytes).

Na ausência das opções ``--compression`` ou ``-c`` e se um arquivo de
entrada for informado, a predefinição  será ``lzma,zlib,huff,flac`` ou
``none`` na ausência de um arquivo de entrada.


createcd
~~~~~~~~

|cuad| CD-ROM no formato CHD.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--outputparent <arquivo_chd>`` / ``-op <arquivo_chd>``
* ``--compression none|<tipo>[,<tipo>]...`` / ``-c none|<tipo>[,<tipo>]...``
* ``--hunksize <bytes>`` / ``-hs <bytes>`` (obrigatório)
* ``--force`` / ``-f``
* ``--numprocessors <quantidade>`` / ``-np <quantidade>``

Caso as opções ``--hunksize`` ou ``-hs`` não sejam usadas, a
predefinição será o tamanho do bloco do CHD principal se o CHD
principal for informado para gerar o arquivo final, caso contrário,
serão oito setores por bloco (18.816 bytes).

Na ausência das opções ``--compression`` ou ``-c`` a predefinição será
``cdlz,cdzl,cdfl``.

Consulte também o capítulo :ref:`Convertendo um CD-ROM para CHD com o
chdman <advanced-tricks-cd-chd>`.


createdvd
~~~~~~~~~

|cuad| DVD-ROM no formato CHD.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputstartbyte <offset>`` / ``-isb <offset>``
* ``--inputstarthunk <offset>`` / ``-ish <offset>``
* ``--inputbytes <comprimento>`` / ``-ib <comprimento>``
* ``--inputhunks <comprimento>`` / ``-ih <comprimento>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--outputparent <arquivo_chd>`` / ``-op <arquivo_chd>``
* ``--compression none|<tipo>[,<tipo>]...`` / ``-c none|<tipo>[,<tipo>]...``
* ``--hunksize <bytes>`` / ``-hs <bytes>`` (obrigatório)
* ``--force`` / ``-f``
* ``--numprocessors <quantidade>`` / ``-np <quantidade>``

Caso as opções ``--hunksize`` ou ``-hs`` não sejam usadas, a
predefinição será o tamanho do bloco do CHD principal se o CHD
principal for informado para gerar o arquivo final, caso contrário,
serão dois setores por bloco (4096 bytes).

Na ausência das opções ``--compression`` ou ``-c`` a predefinição será
``lzma,zlib,huff,flac``.


createld
~~~~~~~~

|cuad| LaserDisc no formato CHD.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--outputparent <arquivo_chd>`` / ``-op <arquivo_chd>``
* ``--compression none|<tipo>[,<tipo>]...`` / ``-c none|<tipo>[,<tipo>]...``
* ``--hunksize <bytes>`` / ``-hs <bytes>`` (obrigatório)
* ``--force`` / ``-f``
* ``--numprocessors <quantidade>`` / ``-np <quantidade>``

|oa|:

* ``--inputstartframe <offset>`` / ``-isf <offset>``
* ``--inputframes <comprimento>`` / ``-if <comprimento>``

Na ausência das opções ``--compression`` ou ``-c`` a predefinição será
``avhu``.


extractraw
~~~~~~~~~~

Extrai dados de um CHD para uma imagem de mídia bruta (RAW).

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputparent <arquivo_chd>`` / ``-ip <arquivo_chd>``
* ``--inputstartbyte <offset>`` / ``-isb <offset>``
* ``--inputstarthunk <offset>`` / ``-ish <offset>``
* ``--inputbytes <comprimento>`` / ``-ib <comprimento>``
* ``--inputhunks <comprimento>`` / ``-ih <comprimento>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--force`` / ``-f``


extracthd
~~~~~~~~~
Extrai dados de um CHD para uma imagem de disco rígido.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputparent <arquivo_chd>`` / ``-ip <arquivo_chd>``
* ``--inputstartbyte <offset>`` / ``-isb <offset>``
* ``--inputstarthunk <offset>`` / ``-ish <offset>``
* ``--inputbytes <comprimento>`` / ``-ib <comprimento>``
* ``--inputhunks <comprimento>`` / ``-ih <comprimento>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--force`` / ``-f``


extractcd
~~~~~~~~~

Extrai dados de um CHD para uma imagem de CD-ROM.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputparent <arquivo_chd>`` / ``-ip <arquivo_chd>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--force`` / ``-f``

|oa|:

* ``--outputbin <arquivo>`` / ``-ob <arquivo>``
* ``--splitbin`` / ``-sb``


extractdvd
~~~~~~~~~~

Extrai dados de um CHD para uma imagem de DVD-ROM.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputparent <arquivo_chd>`` / ``-ip <arquivo_chd>``
* ``--inputstartbyte <offset>`` / ``-isb <offset>``
* ``--inputstarthunk <offset>`` / ``-ish <offset>``
* ``--inputbytes <comprimento>`` / ``-ib <comprimento>``
* ``--inputhunks <comprimento>`` / ``-ih <comprimento>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--force`` / ``-f``


extractld
~~~~~~~~~

Extrai dados de um CHD para uma imagem de LaserDisc.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--inputparent <arquivo_chd>`` / ``-ip <arquivo_chd>``
* ``--output <arquivo>`` / ``-o <arquivo>`` (obrigatório)
* ``--force`` / ``-f``

|oa|:

* ``--inputstartframe <offset>`` / ``-isf <offset>``
* ``--inputframes <comprimento>`` / ``-if <comprimento>``


addmeta
~~~~~~~

Adiciona metadados ao arquivo CHD. |ecao|.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)

|oa|:

* ``--tag <tag>`` / ``-t <tag>`` (obrigatório)
* ``--index <index>`` / ``-ix <index>``
* ``--valuetext <text>`` / ``-vt <text>``
* ``--valuefile <arquivo>`` / ``-vf <arquivo>``
* ``--nochecksum`` / ``-nocs``


delmeta
~~~~~~~

Excluí metadados do arquivo CHD. |ecao|.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)

|oa|:

* ``--tag <tag>`` / ``-t <tag>`` (obrigatório)
* ``--index <index>`` / ``-ix <index>``


dumpmeta
~~~~~~~~

Extrai os metadados de um arquivo CHD para uma saída padrão ou para um
arquivo.

|occ|:

* ``--input <arquivo>`` / ``-i <arquivo>`` (obrigatório)
* ``--output <arquivo>`` / ``-o <arquivo>``
* ``--force`` / ``-f``

|oa|:

* ``--tag <tag>`` / ``-t <tag>`` (obrigatório)
* ``--index <index>`` / ``-ix <index>``


listtemplates
~~~~~~~~~~~~~

Lista os modelos de disco rígido disponíveis. Esse comando não aceita
nenhuma opção.


.. _chdman-compression:

Algoritmos de compressão
------------------------


Há suporte para os seguintes algoritmos de compressão:

**zlib – zlib deflate**

	Comprime os dados usando o algoritmo *zlib deflate*.

**zstd – Zstandard**

	Comprime os dados usando o algoritmo *Zstandard*. Isso proporciona
	um desempenho muito bom de compressão e descompressão com taxas de
	compressão melhores do que o *zlib deflate*, porém, programas mais
	antigos podem não ser compatíveis com arquivos CHD que usam a
	compressão *Zstandard*.

**lzma – Lempel-Ziv-Markov chain algorithm**

	Comprime os dados usando o algoritmo *Lempel-Ziv-Markov-chain
	(LZMA)*. Isso proporciona altas taxas de compressão ao custo de um
	desempenho ruim de compressão e descompressão.

**huff – Huffman coding**

	Comprime os dados usando a codificação de entropia Huffman de 8
	bits.

**flac – Free Lossless Audio Codec**

	Comprime os dados como áudio PCM com dois canais (estéreo) de 16
	bits e 44,1 kHz usando o *Free Lossless Audio Codec* (FLAC). Isso
	proporciona boas taxas de compressão caso a mídia contenha dados de
	áudio PCM com 16 bits.

**cdzl – zlib deflate for CD-ROM data**

	Comprime os dados de áudio e comprime separadamente os dados dos
	subcanais dos setores do CD-ROM usando o algoritmo *zlib deflate*.


.. raw:: latex

	\clearpage


**cdzs – Zstandard for CD-ROM data**

	Comprime os dados de áudio e comprime separadamente os dados dos
	subcanais dos setores do CD-ROM usando o algoritmo *Zstandard*.
	Isso proporciona um desempenho muito bom de compressão e
	descompressão tendo melhores taxas de compressão se comparado com o
	*zlib deflate*, porém, programas mais antigos podem não ser
	compatíveis com arquivos CHD que usam a compressão *Zstandard*.

**cdlz - Lempel-Ziv-Markov chain algorithm/zlib deflate for CD-ROM data**

	Comprime os dados de áudio e comprime separadamente os dados dos
	subcanais dos setores do CD-ROM usando o algoritmo de cadência
	*Lempel-Ziv-Markov (LZMA)* para dados de áudio e o algoritmo
	*zlib deflate* para dados dos subcanais. Isso proporciona altas
	taxas de compressão ao custo de um desempenho ruim de compressão e
	descompressão.

**cdfl – Free Lossless Audio Codec/zlib deflate for CD-ROM data**

	Comprime os dados de áudio e comprime separadamente os dados dos
	subcanais dos setores do CD-ROM usando o algoritmo *Free Lossless
	Audio Codec* (FLAC) para dados de áudio e o algoritmo *zlib deflate*
	para os dados dos subcanais. Isso proporciona boas taxas de
	compressão para as trilhas de áudio CD.

**avhu – Huffman coding for audio-visual data**

	Esse é um algoritmo de compressão especializado para dados
	audiovisuais (A/V). Ele só deve ser usado para criar arquivos CHD
	vindos de um LaserDisc.


.. |pcd| replace:: CHD é um acrônimo para pedaços ou blocos de dados
.. |dchd| replace:: O *delta CHD* é um arquivo que armazena apenas a
   diferença dos blocos do CHD principal
.. |ofce| replace:: Dependendo do comando, os formatos compatíveis do
   arquivo de entrada poderão variar
.. |ofcs| replace:: Dependendo do comando, os formatos compatíveis do
   arquivo de saída poderão variar
.. |iupc| replace:: Isso é útil para criar arquivos no formato CHD a
   partir de arquivos de entrada
.. |peoc| replace:: para extrair conteúdo parcial de um arquivo no
   formato CHD
.. |npse| replace:: Não pode ser usado em conjunto com a opção
.. |cpod| replace:: começando pelo offset dos dados na entrada do arquivo
.. |eocc| replace:: Esta opção é compatível com os comandos que geram
   arquivos no formato CHD
.. |occ| replace:: Opções compatíveis
.. |oa| replace:: Opções adicionais
.. |cuad| replace:: Cria um arquivo de imagem de um
.. |ecao| replace:: Este comando altera o seu arquivo de entrada.
