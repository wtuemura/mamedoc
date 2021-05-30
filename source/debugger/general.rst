.. raw:: latex

	\clearpage

.. _debugger-general-list:

Comandos gerais do depurador
============================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-do` -- avalia a expressão dada
| :ref:`debugger-command-symlist` -- lista os símbolos registrados
| :ref:`debugger-command-softreset` -- executa um soft reset
| :ref:`debugger-command-hardreset` -- executa um hard reset
| :ref:`debugger-command-print` -- imprime um ou mais <*item*>s para o console
| :ref:`debugger-command-printf` -- imprime um ou mais <*item*>s para o console usando <*format*>
| :ref:`debugger-command-logerror` -- exibe um ou mais <*item*>s para o arquivo error.log
| :ref:`debugger-command-tracelog` -- exibe um ou mais <*item*>s para o arquivo de rastreio usando <*format*>
| :ref:`debugger-command-tracesym` -- exibe um ou mais <*item*>s para o arquivo de rastreio
| history -- produz um breve histórico de *opcodes* visitados (**a ser concluído: ainda não há ajuda para este comando**)
| :ref:`debugger-command-trackpc` -- rastreia visualmente os opcodes visitados [booleano para ligar e desligar, para o dado CPU, limpa]
| :ref:`debugger-command-trackmem` -- grava qual PC grava em cada endereço de memória [booleano para ligar e desligar, limpar]
| :ref:`debugger-command-pcatmem` -- consulta qual PC escreveu para um determinado endereço de memória para o CPU atual
| :ref:`debugger-command-rewind` -- volta no tempo carregando o estado de retrocesso mais recente
| :ref:`debugger-command-statesave` -- salva um arquivo de estado para o driver atual
| :ref:`debugger-command-stateload` -- carrega um arquivo de estado para o driver atual
| :ref:`debugger-command-snap` -- salva um print da tela.
| :ref:`debugger-command-source` -- lê os comandos do <*filename*> e os executa um por um
| :ref:`debugger-command-quit` -- sai do MAME e do depurador
|

.. _debugger-command-do:

do
--

|  **do <expression>**
|
| O comando do avalia a expressão <*expression*> dada. Isso é normalmente usado para definir ou modificar variáveis.
|
| Exemplo:
|
|   do pc = 0
|
| Define o registro 'pc' para 0.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-symlist:

symlist
-------

|  **symlist** [<*cpu*>]
|
| Lista os símbolos registrados. Caso <*cpu*> não seja definido, os símbolos na tabela de símbolos globais serão exibidos; caso contrário, os símbolos para o CPU em específico serão exibidas. Os símbolos estão listados em ordem alfabética, os símbolos que forem de apenas leitura serão marcados com um asterisco.
|
| Exemplo:
|
|  ``symlist``
|
| Exibe a tabela de símbolos globais.
| Exibe os símbolos específicos para a CPU ``#2``.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-softreset:

softreset
---------

|  **softreset**
|
| Executa um soft reset.
| Exemplo:
|
| ``softreset``
|
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-hardreset:

hardreset
---------

|  **hardreset**
|
| Executa um hard reset.
| Exemplo:
|
| ``hardreset``
|
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-print:

print
-----

| O comando print imprime os resultados de uma ou mais expressões no console do depurador usando valores hexadecimais.
|
| Exemplo:
|
|  ``print pc``
|
| Imprime o valor de **pc** no console como um número hexadecimal.
| Imprime **a**, **b** e o valor de **a+b** no console como números hexadecimais.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-printf:

printf
------

|  **printf** <*format*>[,<*item*>[,...]]
|
| O comando "*printf*" executa um printf no estilo C para o console do depurador. Apenas um conjunto muito limitado de opções de formatação está disponível:
|
|  ``%[0][<n>]d`` -- imprime <*item*> como um valor decimal com contagem de dígitos opcional e preenchimento zero
|  ``%[0][<n>]x`` -- imprime <*item*> como um valor hexadecimal com contagem de dígitos opcional e preenchimento zero
|
| Todas as opções restantes de formatação são ignoradas. Use **%%** junto para gerar um caractere **%**. Várias linhas podem ser impressas incorporando um **\\n** no texto.
|
| Exemplos:
|
|  ``printf "PC=%04X",pc``
|
| Imprime **PC=<pcval>** onde <*pcval*> é exibido em hexadecimal com **4** dígitos e com zero preenchimento.
|
|  ``printf "A=%d, B=%d\\nC=%d",a,b,a+b``
|
| Imprime **A=<aval>**, **B=<bval>** em uma linha e **C=<a+bval>** na segunda linha.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-logerror:

logerror
--------

|  **logerror** <*format*>[,<*item*>[,...]]
|
| O comando "*logerror*" executa um printf no estilo C no registro de erro. Apenas um conjunto muito limitado de opções de formatação está disponível:
|
|  ``%[0][<n>]d`` -- registra <*item*> como um valor decimal com contagem de dígitos opcional e preenchimento zero
|  ``%[0][<n>]x`` -- registra <*item*> como um valor hexadecimal com contagem de dígitos opcional e preenchimento zero
|
| Todas as opções restantes de formatação são ignoradas. Use **%%** junto para gerar um caractere **%**. Várias linhas podem ser impressas incorporando um **\\n** no texto.
|
| Exemplos:
|
|  ``logerror "PC=%04X",pc``
|
| Registra **PC=<pcval>** onde <*pcval*> é exibido em hexadecimal com **4** dígitos e com preenchimento zero.
|
|  ``logerror "A=%d, B=%d\\nC=%d",a,b,a+b``
|
| Registra **A=<aval>**, **B=<bval>** em uma linha, e **C=<a+bval>** na segunda linha.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-tracelog:

tracelog
--------

|  **tracelog** <*format*>[,<*item*>[,...]]
|
| O comando "*tracelog*" executa um printf no estilo C e roteia a saída para o arquivo de rastreio atualmente aberto (consulte o comando 'trace' para mais detalhes). Caso nenhum arquivo esteja aberto no momento, o tracelog não fará nada. Apenas um conjunto muito limitado de opções de formatação está disponível. Veja :ref:`debugger-command-printf` para mais detalhes.
|
| Exemplos:
|
|  ``tracelog "PC=%04X",pc``
|
| Registra **PC=<pcval>** onde <*pcval*> é exibido em hexadecimal com **4** digitos com preenchimento zero.
|
|  ``printf "A=%d, B=%d\\nC=%d",a,b,a+b``
|
| Registra **A=<aval>**, **B=<bval>** em uma linha, e **C=<a+bval>** na segunda.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-tracesym:

tracesym
--------

|  **tracesym** <*item*>[,...]
|
| O comando "*tracesym*" imprime os símbolos especificados e roteia a saída para o arquivo de rastreio aberto no momento (consulte o comando 'trace' para obter detalhes). Caso nenhum arquivo esteja aberto no momento, o tracesym não faz nada.
|
| Exemplo:
|
|  ``tracelog pc``
|
| Registra **PC=<pcval>** onde <*pcval*> é exibido em seu formato predefinido.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-trackpc:

trackpc
-------

|  **trackpc** [<*bool*>,<*cpu*>,<*bool*>]
|
| O comando "*trackpc*" exibe quais contadores do programa já foram visitados em todas as janelas do desmontador. O primeiro argumento booleano ativa e desativa o processo. O segundo argumento é um seletor de CPU; caso nenhuma CPU seja especificada a CPU atual é selecionada automaticamente. O terceiro argumento é um booleano denotando se os dados existentes devem ser limpos ou não.
|
| Exemplos:
|
|  ``trackpc 1``
|
| Comece a rastrear o PC atual da CPU.
|
|  ``trackpc 1, 0, 1``
|
| Continue rastreando o PC na CPU 0, mas limpe as informações de faixa existentes.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-trackmem:

trackmem
--------

|  **trackmem** [<*bool*>,<*cpu*>,<*bool*>]
|
| O comando "*trackmem*" registra o PC a cada vez que um endereço de memória é gravado. O primeiro argumento booleano ativa e desativa o processo. O segundo argumento é um seletor de CPU; caso nenhuma CPU seja especificada, a CPU atual é selecionada automaticamente. O terceiro argumento é um booleano denotando se os dados existentes devem ser limpos ou não. Favor consultar o comando :ref:`debugger-command-pcatmem` para obter informações sobre como recuperar esses dados. Além disso, clicar com o botão direito em uma janela de memória exibirá o PC registrado para o endereço fornecido.
|
| Exemplos:
|
|  ``trackmem``
|
| Comece a rastrear o PC atual da CPU.
|
|  ``trackmem 1, 0, 1``
|
| Continue rastreando as gravações de memória na CPU 0, mas limpe as informações de faixa existentes.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-pcatmem:

pcatmem
-------

|  **pcatmem(p/d/i)** <*address*>[,<*cpu*>]
|
| **pcatmemp <address>[,<cpu>]** -- consulta qual PC escreveu para um dado endereço de memória do programa para o CPU atual
| **pcatmemd <address>[,<cpu>]** -- consulta qual PC escreveu para um endereço de dados na memória para a CPU atual
| **pcatmemi <address>[,<cpu>]** -- consulta qual PC escreveu para um endereço de I/O para a CPU atual (você também pode consultar esta informação clicando com o botão direito em uma janela de memória)
|
| O comando "*pcatmem*" retorna qual PC gravou em um determinado endereço de memória para a CPU atual. O primeiro argumento é o endereço solicitado. O segundo argumento é um seletor de CPU; caso nenhuma CPU seja especificada, a CPU atual é selecionada automaticamente. Clicar com o botão direito em uma janela de memória também exibirá o PC registrado para o endereço fornecido.
|
| Exemplo:
|
|  ``pcatmem 400000``
|
| Imprimir qual PC escreveu a localização de memória da CPU **0x400000**.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-rewind:

rewind
------

|  **rewind[rw]**
|
| O comando de retrocesso "*rewind*" carrega o estado mais recente baseado em RAM. Os estados de retrocesso, quando ativados, são salvos quando o comando "step", "over" ou "out" é executado, armazenando o estado da máquina a partir do momento antes de realmente avançar. Consecutivamente, o carregamento de estados de retrocesso pode funcionar como uma execução reversa. Dependendo de quais passos foram dados anteriormente, o comportamento pode ser similar ao "reverse stepi" do GDB ou "reverse next". Toda a saída para este comando está atualmente ecoada na janela da máquina em execução. A memória anterior e as estatísticas de rastreamento do PC serão limpas, a execução reversa atual não ocorre.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-statesave:

statesave
---------

|  **statesave[ss]** <*filename*>
|
| O comando "*statesave*" cria um estado de salvaguarda neste exato momento no tempo. O arquivo de estado fornecido é gravado no diretório de estado padrão (sta) e recebe .sta adicionado a ele, sem necessidade de extensão de arquivo. Toda a saída para este comando está atualmente ecoada na janela da máquina em execução.
|
| Exemplo:
|
|  ``statesave foo``
|
| Grava o arquivo 'foo.sta' no diretório de salvamento de estado padrão.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-stateload:

stateload
---------

|  **stateload[sl]** <*filename*>
|
| O comando "*stateload*" recupera um estado de salvamento do disco. O arquivo de estado fornecido é lido a partir do diretório de estado padrão (sta) e recebe .sta adicionado a ele, sem necessidade de extensão de arquivo. Toda a saída para este comando está atualmente ecoada na janela da máquina em execução. A memória anterior e as estatísticas de rastreamento do PC serão apagadas.
|
| Exemplo:
|
|  ``stateload foo``
|
| Carrega o arquivo 'foo.sta' do diretório padrão de salvamento de estado.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-snap:

snap
----

|  **snap** [[<*filename*>], <*scrnum*>]
|
| O comando snap tira um print da exibição de vídeo atual e a salva no diretório snapshot. Caso o <*filename*> seja definido explicitamente, uma única captura de tela *<scrnum>* é salva sob o nome do arquivo solicitado. Caso <*filename*> seja omitido, todas as telas são salvas usando as mesmas regras predefinidas que a tecla "salvar print da tela" no MAME.
|
| Exemplos:
|
|  ``snap``
|
| Obtém um print da tela de vídeo atual e salva no próximo nome de arquivo não conflitante no diretório **snapshot**.
|
|  ``snap shinobi``
|
| Obtém um print da tela de vídeo atual e a salva como 'shinobi.png' no diretório **snapshot**.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-source:

source
------

|  **source <filename>**
|
| O comando source lê um conjunto de comandos do depurador de um arquivo e os executa um por um, semelhante a um arquivo em lotes.
|
| Exemplo:
|
|  ``source break_and_trace.cmd``
|
| Lê nos comandos do depurador a partir do **break_and_trace.cmd** e os executa.
|
| Voltar para :ref:`debugger-general-list`
|

 .. _debugger-command-quit:

quit
----

|  **quit**
|
| O comando quit sai do MAME imediatamente.
|
| Voltar para :ref:`debugger-general-list`
|
