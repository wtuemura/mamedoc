.. _debugger-memory-list:

Comandos para a depuração da Memória
====================================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-dasm` -- desmonta para um determinado arquivo
| :ref:`debugger-command-find` -- pesquisa a memória do programa, dados de memória, ou a memória I/O por dados
| :ref:`debugger-command-fill` -- completa a memória do programa, dados de memória, ou a memória I/O com dados
| :ref:`debugger-command-dump` -- extrai a memória do programa, dados da memória, ou os dados I/O como texto
| :ref:`debugger-command-save` -- salva o binário do programa, dados, ou a memória I/O para um determinado aquivo
| :ref:`debugger-command-load` -- carrega um programa binário na memória, memória de dados, ou a memória I/O de um determinado arquivo
| :ref:`debugger-command-map` -- mapeia um programa lógico, dados, ou um endereço de I/O para um endereço físico e um banco
|

 .. _debugger-command-dasm:

dasm
----

|  **dasm** <*filename*>,<*address*>,<*length*>[,<*opcodes*>[,<*cpu*>]]
|
| O comando "*dasm*" desmonta a memória de um programa para um arquivo definido no parâmetro <*filename*>. O <*address*> indica o endereço do início do desmonte e <*length*> indica quanta memória deve ser desmontada. O intervalo *<address>* através de *<address>+<length>-1* será inclusive salvo para um arquivo. É predefinido que os dados **raw opcode** sejam enviados para a saída com cada linha. O parâmetro <*opcodes*> opcional pode ser usado para ativar (**1**) ou desativar (**0**) essa função. Finalmente, você pode desmontar o código de outra CPU, ao definir o parâmetro <*cpu*>.
|
| Exemplos:
|
|  ``dasm venture.asm,0,10000``
|
| Desmonta os intervalos de endereços **0-ffff** no CPU atual, incluindo dados de **raw opcode** para o arquivo 'venture.asm'.
|
|  ``dasm harddriv.asm,3000,1000,0,2``
|
| Desmonta os intervalos de endereços **3000-3fff** da CPU **#2** sem nenhum dado de **raw opcode** para o arquivo 'harddriv.asm'.
|
| Voltar para :ref:`debugger-memory-list`
|

 .. _debugger-command-find:

find
----

|  **f[ind][{d|i}]** <*address*>,<*length*>[,<*data*>[,...]]
|
| Os comandos **find**/**findd**/**findi** pesquisam na memória por uma sequência específica de dados. O 'find' procurará o espaço do programa na memória, enquanto 'findd' procurará o espaço dos dados na memória e 'findi' procurará pelo espaço I/O na memória. O *<address>* indica o endereço que será iniciado a pesquisa, e <*length*> indica quanta memória será pesquisada. *<data>* pode ser tanto uma string citada, um valor numérico, uma expressão ou um caractere curinga '?'. As strings por padrão implicam em uma pesquisa de tamanho de byte. Os dados não string são pesquisados por padrão no tamanho da palavra nativa da CPU. Para substituir o tamanho da pesquisa por sequências sem string, você pode prefixar o valor com **b**. para forçar pesquisa de tamanho de byte, **w** para pesquisa por tamanho da palavra, **d** para o tamanho dword e **q** para o tamanho qword. As substituições são memorizadas, então se você quiser procurar por uma série de palavras, basta prefixar o primeiro valor com um *w*. Observe também que você pode misturar os tamanhos para executar as pesquisas mais complexas. Todo o intervalo *<address>* através de *<address>+<length>-1* será inclusive pesquisada na sequência e todas as ocorrências serão exibidas.
|
| Exemplos:
|
|  ``find 0,10000,"HIGH SCORE",0``
|
| Procura no intervalo de endereços **0-ffff** na CPU atual pela string "**HIGH SCORE**" seguido por um **0** byte.
|
|  ``findd 3000,1000,w.abcd,4567``
|
| Pesquisa o intervalo de endereços da memória de dados **3000-3fff** por um valor com o tamanho word **abcd** seguido pelo valor word com tamanho **4567**.
|
|  ``find 0,8000,"AAR",d.0,"BEN",w.0``
|
| Procura no intervalo de endereços **0000-7fff** pela string "**AAR**" seguindo por um dwrod com tamanho **0** seguido pela string "**BEN**" e seguido por uma word com tamanho **0**.
|
| Voltar para :ref:`debugger-memory-list`
|

 .. _debugger-command-fill:

fill
----

|  **fill[{d|i}]** <*address*>,<*length*>[,<*data*>[,...]]
|
| Os comanndos **fill**/**filld**/**filli** sobrescrevem um bloco da memória por uma sequência específica de dados. O 'fill' preenche o espaço do programa na memória, enquanto 'filld' preencherá o espaço de dados na memória e o 'filli' preencherá o espaço de memória I/O. O *<address>* indica o endereço que será iniciado a escrita, e <*length*> indica quanta memória será preenchida. *<data>* pode ser tanto uma string citada, um valor numérico ou uma expressão. Por predefinição os dados não strings são escritos nativamente com tamanho word da CPU. Para sobrescrever o tamanho dos dados para não strings, é possível prefixar o valor com b. para impor o preenchimento do tamanho do byte, w. para preenchimento com tamanho word, d. para preenchimento com tamanho dword e q. para preenchimento com tamanho qword. As sobrescritas são memorizadas, assim caso queira preencher com uma série de words é necessário prefixar o primeiro valor com um w. Observe que é possível também misturar os tamanhos para que seja possível realizar preenchimentos mais co,plexos. A operação de preenchimento poderá ser truncado caso uma falha da página ocorra ou caso uma parte da sequência ou da string falhe além do <address>+<length>-1.
|
| Voltar para :ref:`debugger-memory-list`

 .. raw:: latex

	\clearpage

 .. _debugger-command-dump:

dump
----

|  **dump[{d|i}]** <*filename*>,<*address*>,<*length*>[,<*size*>[,<*ascii*>[,<*cpu*>]]]
|
| Os comandos **dump**/**dumpd**/**dumpi** extraem a memória para um arquivo texto especificado com o parâmetro <*filename*>.
| 'dump' despejará o espaço de memória do programa, enquanto 'dumpd' despejará o espaço de memória dos dados e 'dumpi' despejará o espeço de memória do I/O.
| <*address*> Indica o endereço inicial do despejo, e <*length*> indica o quanto será despejado. O intervalo <*address*> através de <*address*>+<*length*>-1 será inclusive salvo em um arquivo.
| É predefinido que os dados serão emitidos em formato de byte, a menos que o espaço de endereço subjacente seja apenas *word/dword/qword-only*. Você pode sobrescrever isso definindo o parâmetro <*size*>, que pode ser usado para agrupar os dados em pedaços de 1, 2, 4 e 8 bytes.
| O parâmetro <*ascii*> opcional pode ser usado para ativar (1) ou desativar (0) a saída de caracteres ASCII à direita de cada linha; por padrão, isso está ativado.
| Finalmente, você pode despejar a memória de outro CPU ao definir o parâmetro <*cpu*>.
|
|
| Exemplos:
|
|  ``dump venture.dmp,0,10000``
|
| Despeja o intervalo de endereços **0-ffff** em pedaços de **1 byte** na CPU atual, incluindo dados ASCII no arquivo 'venture.dmp'.
|
|  ``dumpd harddriv.dmp,3000,1000,4,0,3``
|
| Despeja o intervalo de endereços **3000-3fff** da CPU **#3** em pedaços de **4 bytes**, sem nenhum dado ASCII no arquivo 'harddriv.dmp'.
|
| Voltar para :ref:`debugger-memory-list`
|

 .. _debugger-command-save:

save
----

|  **save[{d|i}]** <*filename*>,<*address*>,<*length*>[,<*cpu*>]
|
| O comando **save**/**saved**/**savei** gravam memória pura (raw) no arquivo de binário especificado com o parâmetro <*filename*>.
| 'save' salvará o espaço de memória do programa, enquanto 'saved' salvará o espaço de dados da memória e 'savei' salvará o espaço de memória I/O.
| <*address*> Indica o endereço inicial que será salvo, e <*length*> indica o quanto dessa memória será salva. O intervalo <*address*> através de <*address*>+<*length*>-1 será inclusive salvo para um arquivo.
| Você também pode salvar a memória de outro CPU ao definir o parâmetro <*cpu*>.
|
|
| Exemplos:
|
|  ``save venture.bin,0,10000``
|
| Salva o intervalo de endereços **0-ffff** na CPU atual para o arquivo 'venture.bin'.
|
|  ``saved harddriv.bin,3000,1000,3``
|
| Salva o intervalo de dados da memória **3000-3fff** da CPU **#3** para o arquivo binário 'harddriv.bin'.
|
| Voltar para :ref:`debugger-memory-list`
|

 .. _debugger-command-load:

load
----

|  **load[{d|i}]** <*filename*>,<*address*>[,<*length*>,<*cpu*>]
|
| Os comandos **load**/**loadd**/**loadi** carregam dados puros vindos de um arquivo binário ao ser especificado com o parâmetro <*filename*>.
| 'load' carregará o programa no espaço de memória enquanto 'loadd' carregará os dados no espaço de memória e 'loadi' carregará o I/O no espaço de memória.
| <*address*> indica o endereço do início do salvamento, e <*length*> indica o quanto dessa memória será lida. O intervalo <*address*> através de <*address*>+<*length*>-1 será inclusive lido de um arquivo.
| Se você definir <*length*> = *0* ou um comprimento maior que o comprimento total do arquivo, ele carregará todo o conteúdo do arquivo e nada mais.
| Você também pode carregar memória de outra CPU definindo o parâmetro <*cpu*>.
|
| NOTA: A escrita só será possível caso seja possível sobrescrever na janela da memória.
|
|
| Exemplos:
|
|  ``load venture.bin,0,10000``
|
| Carrega o intervalo de endereços **0-ffff** na CPU atual vindo do arquivo binário 'venture.bin'.
|
|  ``loadd harddriv.bin,3000,1000,3``
|
| Carrega dados de memória do intervalo de endereços **3000-3fff** da CPU **#3** vindo do arquivo binário 'harddriv.bin'.
|
| Voltar para :ref:`debugger-memory-list`
|

 .. _debugger-command-map:

map
---

|  **map[{d|i}]** <*address*>
|
| O comando **map**/**mapd**/**mapi** faz o mapeamento lógico de endereço na memória para o endereço físico correto, além de definir o banco.
| 'map' mapeará o espaço do programa na memória enquanto 'mapd' mapeará o espaço dos dados na memória e 'mapi' mapeará o espaço I/O na memória.
|
| Exemplo:
|
|  ``map 152d0``
|
| Fornece o endereço físico e o banco para o endereço lógico **152d0** na memória do programa
|
| Voltar para :ref:`debugger-memory-list`
|
