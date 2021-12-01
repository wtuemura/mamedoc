.. raw:: latex

	\clearpage

.. _debugger-memory-list:

Comandos para a depuração da memória
====================================

.. note::

    **Pesquisa** é quando se deseja levantar mais informações sobre algo
    desconhecido. **Busca** é quando se deseja levantar informações
    sobre algo que já se sabe.

.. line-block::

    :ref:`debugger-command-dasm`
        Desmonta o código num determinado arquivo.
    :ref:`debugger-command-find`
        Faz uma pesquisa por dados na |mda|.
    :ref:`debugger-command-fill`
        Preenche a |mda| num determinado padrão.
    :ref:`debugger-command-dump`
        Despeja a |mda| num arquivo texto.
    :ref:`debugger-command-strdump`
        Despeja strings [#string]_ delimitadas a partir da |mda| num arquivo.
    :ref:`debugger-command-save`
        Grava os dados binários da |mda| num arquivo.
    :ref:`debugger-command-saver`
        Grava os dados binários de uma determinada faixa da memória num arquivo.
    :ref:`debugger-command-load`
        Carrega os dados binários a partir de um arquivo na |mda|.
    :ref:`debugger-command-loadr`
        Carrega os dados da memória a partir de um arquivo na |mda|. 
    :ref:`debugger-command-map`
        Faz o mapeamento do endereço lógico ao endereço físico e ao manipulador correspondente.
    :ref:`debugger-command-memdump`
        Despeja o mapa da memória atual num arquivo.

.. [#string]	Pode ser traduzido como cadeia de caracteres,
				cadência de caracteres, sequência de caracteres,
				caracteres, texto, dentre outras variantes dependendo do
				contexto, `mais informações <https://homepages.dcc.ufmg.br/~rodolfo/aedsi-2-06/cadeiadecaractere/cadeiadecaractere.html>`_.


.. _debugger-command-dasm:

dasm
----

**dasm** <*nome_do_arquivo*>,<*endereço*>,<*comprimento*>[,<*opcodes*>[,<*CPU*>]]

Desmonta a memória do programa num arquivo definido pelo parâmetro
<*nome_do_arquivo*>. O parâmetro <*endereço*> determina o endereço para
o início da desmontagem, o parâmetro <*comprimento*> determina o quanto
da memória será desmontada. A faixa do <*endereço*> através de
<*endereço*>+<*comprimento*> inclusive, será desmontada num arquivo.
É predefinido que os dados brutos do *opcode* sejam gerados em cada
linha. O parâmetro opcional <*opcodes*> é um booleano que ativa ou
desativa essa funcionalidade. Também é predefinido que a memória do
programa seja desmontada na *CPU* que estiver visível. Defina o 5º
parâmetro para desmontar a memória do programa numa *CPU* diferente
(consulte :ref:`debugger-devicespec` para obter mais detalhes).

.. raw:: latex

	\clearpage

Exemplos:

.. line-block::

    ``dasm venture.asm,0,10000``
        Desmonta o endereço ``0-ffff`` na *CPU* que estiver visível, incluindo os dados *opcode* bruto no arquivo ``venture.asm``.
    ``dasm harddriv.asm,3000,1000,0,2``
        Desmonta o endereço ``3000-3fff`` na 3ª *CPU* do sistema (|ibz|), sem os dados *opcode* bruto no arquivo ``harddriv.asm``.

|ret| :ref:`debugger-memory-list`.


 .. _debugger-command-find:

find
----

**f[ind][{d|i|o}]** <*endereço*>[:<*faixa*>],<*comprimento*>[,<*dados*>[,…]]

Faz uma busca na memória por uma determinada sequência de dados. O
<*endereço*> determina o início da busca, opcionalmente por ser seguido
por um dispositivo ou uma |fde| (consulte :ref:`debugger-devicespec`
para obter mais detalhes). A <*faixa*> determina o quanto da memória
será buscada. |qnfe|. É predefinido que o comando ``find`` exiba a
primeira |fde| que for exposta pelo dispositivo, ``findd`` |rfi| 1
(dados), ``findi`` |rfi| 2 (E/S), já ``findo`` |rfi| 3 (*opcodes*).

No parâmetro <*dados*> pode ser usado uma *string*, um valor numérico,
uma expressão ou um caractere curinga ``?``. É predefinido que os dados
não *string* sejam escritos usando o tamanho nativo da palavra na faixa
do endereço. Para substituir o tamanho dos dados para dados não
*string*, você pode prefixar os valores com ``b.`` para impor a busca
com um tamanho de byte, com ``w.`` para fazer a busca com o tamanho da
palavra (*word*), com ``d.`` para palavra dupla (*double word*) e ``q.``
para palavra quádrupla (*quadruple word*). As sobreposições se propagam
para os valores subsequentes, assim sendo, caso queira fazer uma busca
por uma sequência de palavras, é preciso prefixar o primeiro valor com
``w.``. Observe também que é possível misturar os tamanhos para realizar
buscas mais complexas. 

Toda a faixa do <*endereço*> através do <*endereço*>+<*comprimento*>-1
inclusive, será buscado pela sequência e todas as ocorrências serão
exibidas.

Exemplos:

.. line-block::

    ``find 0,10000,"HIGH SCORE",0``
        Faz uma busca pelos caracteres "HIGH SCORE" na faixa do endereço ``0-ffff`` do programa da *CPU* que estiver visível seguido pelo byte ``0``.
    ``find 300:tms9918a,100,w.abcd,4567``
        Faz uma busca com o tamanho palavra ``abcd`` e seguido pelo o valor ``4567`` na faixa do endereço ``300-3fff`` no primeiro espaço do endereço que estiver exposto pelo dispositivo |ccad| ``:tms9918a``.
    ``find 0,8000,"AAR",d.0,"BEN",w.0``
        Faz uma busca pelos caracteres "AAR" na faixa do endereço ``0000-7fff`` seguido por uma palavra dupla (*double word*) ``0`` e pelos caracteres "BEM" com tamanho ``0``.

|ret| :ref:`debugger-memory-list`.


 .. _debugger-command-fill:

fill
----

**fill[{d|i|o}]** <*endereço*>[:<*faixa*>],<*comprimento*>[,<*dados*>[,…]]

Sobrescreve um bloco da memória com uma cópia da sequência de dados que
foi fornecida.

O <*endereço*> determina o início de onde a escrita deve começar,
opcionalmente por ser seguido por um dispositivo ou uma |fde|
(consulte :ref:`debugger-devicespec` para obter mais detalhes). A
<*faixa*> determina o quanto da memória deve ser preenchida. Quando
nenhuma |fde| for definida, o sufixo do comando define a faixa do
endereço. É predefinido que o comando ``fill`` exiba a primeira |fde|
que for exposta pelo dispositivo, ``filld`` |rfi| 1 (dados), ``filli``
|rfi| 2 (E/S), já ``fillo`` |rfi| 3 (*opcodes*).

No parâmetro <*dados*> pode ser usado uma *string*, um valor numérico,
uma expressão ou um caractere curinga ``?``. É predefinido que os dados
não *string* sejam escritos usando o tamanho nativo da palavra na faixa
do endereço. Para substituir o tamanho dos dados para dados não
*string*, você pode prefixar os valores com ``b.`` para impor o
preenchimento com um tamanho de byte, com ``w.`` para fazer o
preenchimento com o tamanho da palavra (*word*), com ``d.`` para
palavra dupla (*double word*) e ``q.`` para palavra quádrupla
(*quadruple word*). As sobreposições se propagam para os valores
subsequentes, assim sendo, caso queira fazer um preenchimento por uma
sequência de palavras, é preciso prefixar o primeiro valor com ``w.``.
Observe também que é possível misturar os tamanhos para realizar
preenchimentos mais complexos. A operação de preenchimento poderá ser
truncada caso ocorra um erro falha da página (*page fault*) ou caso uma
parte da sequência ou da *string* falhe além do
<*endereço*>+<*comprimento*>-1.

|ret| :ref:`debugger-memory-list`.


 .. _debugger-command-dump:

dump
----

**dump[{d|i|o}]** <*nome_do_arquivo*>,<*endereço*>[:<*faixa*>],<*comprimento*>[,<*grupo*>[,<*ascii*>[,<*tamanho_da_linha*>]]]**

Faz o despejo do conteúdo da memória num arquivo texto definido pelo
parâmetro <*nome_do_arquivo*>.

O <*endereço*> determina o início de onde o despejo deve começar,
opcionalmente por ser seguido por um dispositivo ou uma |fde|
(consulte :ref:`debugger-devicespec` para obter mais detalhes). A
<*faixa*> determina o quanto da memória deve ser despejada. Quando
nenhuma |fde| for definida, o sufixo do comando define a faixa do
endereço. É predefinido que o comando ``dump`` exiba a primeira |fde|
que for exposta pelo dispositivo, ``dumpd`` |rfi| 1 (dados), ``dumpi``
|rfi| 2 (E/S), já ``dumpo`` |rfi| 3 (*opcodes*).

Toda a faixa do <*endereço*> através do <*endereço*>+<*comprimento*>-1
inclusive, será despejado no arquivo. É predefinido que os dados sejam
produzidos usando o tamanho nativo da palavra na faixa do endereço. É
possível alterar esta funcionalidade ao definir o parâmetro <*group*>
que pode ser utilizado para agrupar os dados em pedaços de ``1-``,
``2-``, ``4-``, ``8`` bytes. O parâmetro opcional <*ASCII*> é um
booleano que ativa ou desativa a geração dos caracteres *ASCII* do lado
direito de cada linha (a predefinição é ``enabled``). Já o parâmetro
opcional <*tamanho_da_linha*> determina a quantidade de dados nas
unidades de endereço de cada linha (é predefinido que seja 16 *bytes*).

.. raw:: latex

	\clearpage

Exemplos:

.. line-block::

    ``dump venture.dmp,0,10000``
        Faz o despejo do endereço ``0-ffff`` em pedaços de *1-byte* |nrvd| incluindo dados *ASCII* no arquivo ``venture.dmp``.
    ``dumpd harddriv.dmp,3000:3,1000,4,0``
        Faz o despejo dos dados do endereço da memória ``3000-3fff`` em pedaços de *4-bytes* a partir da 4ª *CPU* do sistema (|ibz|) no arquivo ``harddriv.dmp``.
    ``dump vram.dmp,0:sms_vdp:videoram,4000,1,false,8``
        Faz o despejo da faixa do endereço ``0000-3fff`` da ``videoram`` em pedaços de *1-byte* a partir do dispositivo |ccad| ``:sms_vdp``, sem dados *ASCII*, com 8 *bytes* por linha no arquivo ``vram.dmp``. 

|ret| :ref:`debugger-memory-list`.


.. _debugger-command-strdump:

strdump
-------

**strdump[{d|i|o}]** <*nome_do_arquivo*>,<*endereço*>[:<*faixa*>],<*comprimento*>[,<*term*>]

Faz o despejo do conteúdo da memória num arquivo texto definido pelo
parâmetro <*nome_do_arquivo*>.

O <*endereço*> determina o início de onde o despejo deve começar,
opcionalmente por ser seguido por um dispositivo ou uma |fde|
(consulte :ref:`debugger-devicespec` para obter mais detalhes). A
<*faixa*> determina o quanto da memória deve ser despejada. Quando
nenhuma |fde| for definida, o sufixo do comando define a faixa do
endereço. É predefinido que o comando ``strdump`` retorne para a
primeira |fde| que for exposta pelo dispositivo, ``strdumpd`` |rfi| 1
(dados), ``strdumpi`` |rfi| 2 (E/S), já ``strdumpo`` |rfi| 3
(*opcodes*).

É predefinido que os dados sejam interpretados como uma série de
caracteres com uma terminação NULA (ASCIIZ), o despejo terá um caractere
por linha, com sequências de escape em estilo C que serão utilizadas
nos bytes que não representem caracteres ASCII imprimíveis. O parâmetro
opcional <*term*> pode ser usado para determinar um caractere
de terminação diferente da cadeia de caracteres.

|ret| :ref:`debugger-memory-list`.


.. _debugger-command-save:

save
----

**save[{d|i|o}]** <*nome_do_arquivo*>,<*endereço*>[:<*faixa*>],<*comprimento*>

Grava os dados brutos da memória num arquivo binário determinado pelo
parâmetro <*nome_do_arquivo*>.

O <*endereço*> determina o início de onde a gravação deve começar,
opcionalmente por ser seguido por um dispositivo ou uma |fde|
(consulte :ref:`debugger-devicespec` para obter mais detalhes). A
<*faixa*> determina o quanto da memória deve ser gravada. Quando
nenhuma |fde| for definida, o sufixo do comando define a faixa do
endereço. É predefinido que o comando ``save`` retorne para a primeira
|fde| que for exposta pelo dispositivo, ``saved`` |rfi| 1 (dados),
``savei`` |rfi| 2 (E/S), já ``saveo`` |rfi| 3 (*opcodes*).

Toda a faixa do <*endereço*> através do <*endereço*>+<*comprimento*>-1
inclusive, será gravado num arquivo.

.. raw:: latex

	\clearpage

Exemplos:

.. line-block::

    ``save venture.bin,0,10000``
        Grava o endereço ``0-ffff`` |nrvd| atual em formato binário no arquivo ``venture.bin``.
    ``saved harddriv.bin,3000:3,1000``
        Grava os dados do endereço da memória ``3000-3fff`` a partir da 4ª *CPU* do sistema (|ibz|) no arquivo ``harddriv.bin``.
    ``save vram.bin,0:sms_vdp:videoram,4000``
        Grava a faixa do endereço ``0000-3fff`` da ``videoram`` a partir do dispositivo |ccad| ``:sms_vdp`` em formato binário no arquivo ``vram.bin``.

|ret| :ref:`debugger-memory-list`.


.. _debugger-command-saver:

saver
-----

**saver** <*nome_do_arquivo*>,<*endereço*>,<*comprimento*>,<*região*>

Grava o conteúdo bruto de uma região da memória determinado pelo
parâmetro <*região*> num arquivo binário determinado pelo parâmetro
<*nome_do_arquivo*>. As etiquetas da região seguem as mesmas regras que
as etiquetas dos dispositivos (consulte :ref:`debugger-devicespec` para
obter mais informações). O <*endereço*> determina o início de onde a
gravação deve começar. O <*comprimento*> determina o quanto da memória
deve ser gravada. 

Toda a faixa do <*endereço*> através do <*endereço*>+<*comprimento*>-1
inclusive, será gravado num arquivo.

Exemplos:

.. line-block::

    ``saver data.bin,200,100,:monitor``
        Grava a região do endereço ``200-2ff`` do ``:monitor`` em formato binário no arquivo ``data.bin``.
    ``saver cpurom.bin,1000,400,.``
        Grava o endereço ``1000-13ff`` |nrvd| em formato binário no arquivo ``cpurom.bin``.

|ret| :ref:`debugger-memory-list`.


 .. _debugger-command-load:

load
----

**load[{d|i|o}]** <*nome_do_arquivo*>,<*endereço*>[:<*faixa*>][,<*comprimento*>]

Carrega uma memória em formato bruto a partir de um arquivo binário
determinado pelo parâmetro <*nome_do_arquivo*>. O <*endereço*> determina
a partir de onde o arquivo deve ser lido, opcionalmente por ser seguido
por um dispositivo ou uma |fde| (consulte :ref:`debugger-devicespec`
para obter mais detalhes). O <*comprimento*> determina o quanto da
memória deve ser lida. |qnfe|. É predefinido que o comando ``load``
retorne para a primeira |fde| que for exposta pelo dispositivo,
``loadd`` |rfi| 1 (dados), ``loadi`` |rfi| 2 (E/S), já ``loado`` |rfi| 3
(*opcodes*).

Toda a faixa do <*endereço*> através do <*endereço*>+<*comprimento*>-1
inclusive, será gravado num arquivo. Quando o parâmetro <*comprimento*>
for omitido, caso seja zero ou caso seja maior que o comprimento total
do arquivo, todo o conteúdo do arquivo será lido e nada mais.

Observe que isso tem o mesmo efeito que fazer a escrita na faixa do
endereço a partir do visualizador da memória do depurador ou utilizando
os acessórios da memória ``b@``, ``w@``, ``d@`` ou ``q@`` nas expressões
do depurador. O conteúdo da memória que seja de leitura apenas não será
substituído e a escrita nos endereços de E/S terão efeitos que vão além
das configurações dos valores dos registros.

Exemplos:

.. line-block::

    ``load venture.bin,0,10000``
        Carrega o endereço ``0-ffff`` |nrvd| a partir do arquivo binário ``venture.bin``.
    ``loadd harddriv.bin,3000,1000,3``
        Carrega os dados da região da memória ``3000-3fff`` a partir da 4ª *CPU* do sistema (|ibz|) a partir do arquivo binário ``harddriv.bin``.
    ``load vram.bin,0:sms_vdp:videoram``
        Carrega a faixa da ``videoram`` para o dispositivo |ccad| ``:sms_vdp`` iniciando no endereço ``0000`` com todo o conteúdo binário do arquivo ``vram.bin``.

|ret| :ref:`debugger-memory-list`.


.. _debugger-command-loadr:

loadr
-----

**loadr** <*nome_do_arquivo*>,<*endereço*>,<*comprimento*>,<*região*>

Carrega uma memória na região da memória determinado pelo parâmetro
<*região*> a partir de arquivo binário determinado pelo parâmetro
<*nome_do_arquivo*>. As etiquetas da região seguem as mesmas regras que
as etiquetas dos dispositivos (consulte :ref:`debugger-devicespec` para
obter mais informações). O <*endereço*> determina o início de onde a
leitura deve começar. O <*comprimento*> determina o quanto da memória
deve ser carregada.

Toda a faixa do <*endereço*> através do <*endereço*>+<*comprimento*>-1
inclusive, será lido a partir do arquivo. Quando o <*comprimento*> for
zero ou caso seja maior que o comprimento total do arquivo, todo o
conteúdo do arquivo será lido e nada mais.

Exemplos:

.. line-block::

    ``loadr data.bin,200,100,:monitor``
        Carrega a região do endereço ``200-2ff`` do ``:monitor`` a partir do arquivo binário ``data.bin``.
    ``loadr cpurom.bin,1000,400,.``
        Carrega o endereço ``1000-13ff`` |nrvd| a partir do arquivo binário ``cpurom.bin``.

|ret| :ref:`debugger-memory-list`.


 .. _debugger-command-map:

map
---

**map[{d|i|o}]** <*endereço*>[:<*faixa*>]

Faz o mapeamento lógico do endereço da memória no endereço físico
correspondente, assim como informa o nome do manipulador. O endereço
opcionalmente pode ser seguido por dois pontos e um dispositivo ou uma
faixa de endereço (consulte :ref:`debugger-devicespec` para obter mais
detalhes). |qnfe|. É predefinido que o comando ``map`` retorne para a
primeira |fde| que for exposta pelo dispositivo, ``mapd`` |rfi| 1
(dados), ``mapi`` |rfi| 2 (E/S), já ``mapo`` |rfi| 3 (*opcodes*).

Exemplos:

.. line-block::

    ``map 152d0``
        Fornece o endereço físico e o nome do manipulador para o endereço lógico ``152d0`` |nrvd|.
    ``map 107:sms_vdp``
        Fornece o endereço físico e o nome do manipulador para o endereço lógico ``107`` na primeira faixa do endereço para o dispositivo |ccad| ``:sms_vdp``.

|ret| :ref:`debugger-memory-list`.


.. _debugger-command-memdump:

memdump
-------

**memdump** [<*nome_do_arquivo*>,[<*dispositivo*>]]

Faz o despejo dos mapas da memória atual num arquivo determinado pelo
parâmetro <*nome_do_arquivo*> ou ``memdump.log`` casa nenhum parâmetro
seja usado. Quando um <*dispositivo*> foi definido (consulte
:ref:`debugger-devicespec` para obter mais detalhes) apenas os mapas da
memória para a parte da árvore enraizada neste dispositivo serão
despejados.

Exemplos:

.. line-block::

    ``memdump mylog.log``
        Faz o despejo do mapa da memória para todos os dispositivos do sistema no arquivo ``mylog.log``.
    ``memdump``
        Faz o despejo do mapa da memória para todos os dispositivos do sistema no arquivo ``memdump.log``.
    ``memdump audiomaps.log,audiopcb``
        Faz o despejo do mapa da memória para todos os dispositivos |ccad| ``:audiopcb`` e todos os dispositivos relacionados no arquivo ``audiomaps.log``.
    ``memdump mylog.log,1``
        Faz o despejo do mapa da memória para o 2º dispositivo da *CPU* (|ibz|) e todos os dispositivos relacionados no arquivo ``mylog.log``.

|ret| :ref:`debugger-memory-list`.


.. |mda| replace:: memória da emulação
.. |ret| replace:: Retorna para
.. |ibz| replace:: num índice com base zero
.. |fde| replace:: faixa de endereços
.. |rfi| replace:: retorna para a faixa do índice
.. |ccad| replace:: com o caminho absoluto da etiqueta
.. |nrvd| replace:: na região visível do programa na *CPU*
.. |qnfe| replace:: Quando nenhuma faixa de endereços for definida, o sufixo do comando define a faixa do endereço
