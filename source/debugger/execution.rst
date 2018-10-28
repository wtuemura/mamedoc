.. _debugger-execution-list:

Comandos de execução do depurador
=================================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-step` -- passo único para instruções <*count*> (F11)
| :ref:`debugger-command-over` -- passo único durante instruções <*count*> (F10)
| :ref:`debugger-command-out` -- passo único até o manipulador atual de subrotina/execução seja terminado (Shift-F11)
| :ref:`debugger-command-go` -- resume a execução, define breakpoint temporário no endereço <*address*> (F5)
| :ref:`debugger-command-gint` -- resume a execução, define breakpoint temporário se <*irqline*> for tomada (F7)
| :ref:`debugger-command-gtime` -- resume a execução até que o atraso determinado termine
| :ref:`debugger-command-gvblank` -- resume a execução, define breakpoint temporário até o próximo VBLANK (F8)
| :ref:`debugger-command-next` -- executa até que o próximo CPU alterne (F6)
| :ref:`debugger-command-focus` -- foca o depurados apenas na <*cpu*>
| :ref:`debugger-command-ignore` -- para a depuração na <*cpu*>
| :ref:`debugger-command-observe` -- continua a depuração na <*cpu*>
| :ref:`debugger-command-trace` -- rastreia o dado CPU para um arquivo (defaults to active CPU)
| :ref:`debugger-command-traceover` -- rastreia o dado CPU para um arquivo, mas pule as subrotinas (defaults to active CPU)
| :ref:`debugger-command-traceflush` -- elimine todos os arquivo open trace.


 .. _debugger-command-step:

step
----

|  **s[tep]** [<*count*>=1]
|
| O comando "*step*" avança uma ou mais instruções na CPU que estiverem sendo executadas. É predefinido que o comando execute apenas uma instrução a cada vez que for chamado. Também é possível dar um passo em diferentes instruções ao incluir o parâmetro opcional <*count*>.
|
| Exemplos:
|
|  ``s``
|
| Avança apenas uma instrução da CPU.
|
|  ``step 4``
|
| Avança quatro instruções da CPU.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-over:

over
----

|  **o[ver]** [<*count*>=1]
|
| O comando "*over*" avança um passo simples sobre uma ou mais instruções que estiverem sendo executadas na CPU, passando por cima de chamadas de sub-rotina e traps do manipulador de exceção, contando-os como uma única instrução. Observe que, ao passar por cima de uma chamada de sub-rotina o código pode ser executado em outras CPUs antes da conclusão da chamada. É predefinido que o comando execute apenas uma instrução a cada vez que for chamado. Também é possível dar um passo em diferentes instruções ao incluir o parâmetro opcional <*count*>.
|
| Observe que a funcionalidade step over pode não estar implementada em todos os tipos de CPU. Caso não esteja, então o comando 'over' se comportará exatamente como o comando 'step'.
|
| Exemplos:
|
|  ``o``
|
| Avança e passa por cima de apenas uma instrução da CPU.
|
|  ``over 4``
|
| Avança e passa por cima sobre quatro instruções da CPU atual.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-out:

out
---

|  **out**
|
| O comando "*out*" avança passos simples até encontrar um retorno da sub-rotina ou retorno da instrução em exceção. Observe que, como ele detecta o retorno das condições de exceção, caso você tente sair de uma sub-rotina e ocorrer uma interrupção/exceção antes de atingir o final, você poderá parar prematuramente no final do manipulador de exceções.
|
| Observe que a funcionalidade de saída não pode estar implementada em todos os tipos de CPU. Caso não esteja, então o comando 'out' se comportará exatamente como o comando 'step'.
|
| Exemplos:
|
|  ``out``
|
| Avance até que a sub-rotina atual ou o manipulador de exceções retorne.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-go:

go
--

|  **g[o]** [<*address*>]
|
| O comando "*go*" retoma a execução do código atual. O controle não será retornado ao depurador até que um breakpoint ou um watchpoint seja atingido, ou até que você interrompa manualmente usando a chave designada. O comando go usa um parâmetro opcional *<address>* que é um breakpoint incondicional que é definido antes de ser executado e removido automaticamente quando for pressionado.
|
| Exemplos:
|
|  ``g``
|
| Retomar a execução até o próximo **break/watchpoint** ou até uma parada manual.
|
|  ``g 1234``
|
| Retomar a execução parando no endereço **1234** a não ser que algo nos pare primeiro.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-gvblank:

gvblank
-------

|  **gv[blank]**
|
| O comando "*gvblank*" retoma a execução do código atual. O controle não será retornado ao depurador até que um breakpoint ou watchpoint seja atingido ou até que o próximo **VBLANK** ocorra no emulador.
|
| Exemplos:
|
|  ``gv``
|
| Retomar a execução até o próximo **break/watchpoint** ou até o próximo **VBLANK**.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-gint:

gint
----

|  **gi[nt]** [<*irqline*>]
|
| O comando "*gint*" retoma a execução do código atual. O controle não será retornado ao depurador até que um breakpoint ou watchpoint seja atingido ou até que um IRQ seja declarado e reconhecido na CPU atual. Você pode definir um <*irqline*> caso deseje interromper a execução apenas em uma determinada linha de IRQ que estiver sendo declarada e confirmada. Caso o <*irqline*> seja omitido, então qualquer linha IRQ irá parar a execução.
|
| Exemplos:
|
|  ``gi``
|
| Retomar a execução até o próximo **break/watchpoint** ou até que qualquer IRQ seja declarado e reconhecido na CPU atual.
|
|  ``gint 4``
|
| Retomar a execução até a próxima **break/watchpoint** ou até que a linha IRQ seja declarada e confirmada na CPU atual.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-gtime:

gtime
-----

|  **gt[ime]** <*milliseconds*>
|
| O comando "*gtime*" retoma a execução do código atual. O controle não será retornado ao depurador até que um atraso especificado tenha decorrido. O atraso é em milissegundos.
|
| Examplo:
|
|  ``gtime #10000``
|
| Retomar a execução por dez segundos
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-next:

next
----

|  **n[ext]**
|
| O comando "*next*" retoma a execução e continua a execução até a próxima vez que uma CPU diferente for planejada. Note que se você usou 'ignore' para ignorar certas CPUs, você não irá parar até que uma CPU não-'ignore' seja agendada.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-focus:

focus
-----

|  **focus** <*cpu*>
|
| O comando "*focus*" Define o foco do depurador exclusivamente para o dado <*cpu*>. Isso é equivalente a especificar 'ignore' em todas as outras CPUs.
|
| Example:
|
|  ``focus 1``
|
| Concentre-se exclusivamente CPU **#1** enquanto ignora todas as outras CPUs ao usar o depurador.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-ignore:

ignore
------

|  **ignore** [<*cpu*>[,<*cpu*>[,...]]]
|
| Ignora a <*cpu*> definida ao usar o depurador. Isso significa que você nunca verá a execução nessa CPU e tão pouco poderá definir breakpoints nela. Para desfazer essa mudança, use o comando 'observe'. Você pode definir diferentes *<cpu>s* em um único comando. Note também que você não tem permissão para ignorar todas as CPUs; pelo menos um deve estar ativo em todos os momentos.
|
| Exemplos:
|
|  ``ignore 1``
|
| Ignore o CPU **#1** ao usar o depurador.
|
|  ``ignore 2,3,4``
|
| Ignora a CPU **#2**, **#3** e **#4** ao usar o depurador.
|
|  ``ignore``
|
| Liste todas as CPUs atualmente ignoradas.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-observe:

observe
-------

|  **observe** [<*cpu*>[,<*cpu*>[,...]]]
|
| Reativa a interação com a <*cpu*> definida no depurador. Este comando desfaz os efeitos do comando 'ignore'. Você pode especificar diferentes <*cpu*>s em um único comando.
|
| Exemplos:
|
|  ``observe 1``
|
| Pare de ignorar a CPU **#1** ao usar o depurador.
|
|  ``observe 2,3,4``
|
| Pare de ignorar a CPU **#2**, **#3** e **#4** quando usar o depurador.
|
|  ``observe``
|
| Liste todas as CPUs sendo observadas atualmente.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-trace:

trace
-----

|  **trace** {<*filename*> | *OFF*}[,<*cpu*>[,[*noloop* | *logerror*][,<*action*>]]]
|
| Inicia ou para o rastreio da execução da <*cpu*> definida. Caso a <*cpu*> seja omitida a CPU que estiver ativa no momento será definida.
|
| Ao habilitar o rastreamento, defina um nome do arquivo <*filename*> no parâmetro. Para desabilitar o rastreamento, substitua a palavra-chave 'off' no <*filename*>.
|
| <*detectloops*> deve ser **true** ou **false**.
|
| Caso o 'noloop' seja omitido, o rastreamento terá loops detectados e será condensado em uma única linha. Caso o 'noloop' seja definido, o rastreio irá conter cada opcode conforme for sendo executado.
|
| Caso o 'logerror' seja definido, a saída do logerror irá aumentar o rastreamento. Se você deseja obter informações adicionais sobre cada vestígio de log, você pode acrescentar o parâmetro <*action*> que é um comando que é executado antes que cada traço que for registrado. Geralmente, isso é usado para incluir um comando 'tracelog'. Observe que você pode precisar incorporar a ação entre chaves **{ }** para evitar que as vírgulas e os pontos-e-vírgulas sejam interpretados como se aplicassem ao próprio comando trace.
|
|
| Exemplos:
|
|  ``trace joust.tr``
|
| Iniciar o rastreamento da CPU atualmente ativa, registrando a saída para 'joust.tr'.
|
|  ``trace dribling.tr,0``
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída para 'dribling.tr'.
|
|  ``trace starswep.tr,0,noloop``
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída em 'starswep.tr', com a detecção de loop desativada.
|
|  trace starswep.tr,0,logerror
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída (junto com a saída logerror) para 'starswep.tr'.
|
|  ``trace starswep.tr,0,logerror|noloop``
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída (junto com a saída logerror) para 'starswep.tr' com a detecção de loop desativada.
|
|  ``trace >>pigskin.tr``
|
| Comece a rastrear a CPU atualmente ativa, anexando a saída de log para 'pigskin.tr'.
|
|  ``trace off,0``
|
| Desativar o rastreio na CPU **#0**.
|
|  ``trace asteroid.tr,0,,{tracelog "A=%02X ",a}``
|
|
|  ``trace dribling.tr,0``
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída para 'dribling.tr'. Antes de cada linha, a saída **A=<aval>** para o tracelog.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-traceover:

traceover
---------

|  **traceover** {<*filename*> | *OFF*}[,<*cpu*>[,<*detectloops*>[,<*action*>]]]
|
| Inicia ou para o rastreio na execução da <*cpu*> especificada.
|
| Quando o rastreamento atinge uma sub-rotina ou chamada, a sub-rotina será ignorada pelo rastreamento. O mesmo algoritmo é usado como é usado no comando *step over*. Isso significa que o rastreio não funcionará corretamente quando as chamadas forem recursivas ou o endereço de retorno não estiver seguindo imediatamente a instrução de chamada.
|
| <*detectloops*> deve ser true ou false. Caso o <*detectloops*> seja *true* ou *omitido*, o rastreio terá loops detectados e condensados em uma única linha. Caso seja *false*, o rastreio conterá todos os opcode à medida que forem executados.
| Se o <*cpu*> for omitido, a CPU atualmente ativa será a especificada.
| Ao habilitar o rastreamento, especifique o nome do arquivo <*filename*> no parâmetro.
| Para desabilitar o rastreamento, substitui a palavra-chave 'off' para <*filename*>.
| Se você deseja obter informações adicionais sobre cada vestígio de log, você pode acrescentar o parâmetro <*action*> que é um comando que é executado antes de cada rastreio que for registrado. Geralmente, isso é usado para incluir um comando 'tracelog'. Observe que você pode precisar incorporar a ação entre chaves **{ }** para evitar que as vírgulas e os pontos-e-vírgulas sejam interpretados como se aplicassem ao próprio comando trace.
|
|
| Exemplos:
|
|  ``traceover joust.tr``
|
| Iniciar o rastreamento da CPU atualmente ativa, registrando a saída para 'joust.tr'.
|
|  ``traceover dribling.tr,0``
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída para 'dribling.tr'.
|
|  ``traceover starswep.tr,0,false``
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída para 'starswep.tr', com a detecção de loop desativada.
|
|  ``traceover off,0``
|
| Desativar o rastreio na CPU **#0**.
|
|  ``traceover asteroid.tr,0,true,{tracelog "A=%02X ",a}``
|
| Comece a rastrear a execução da CPU **#0**, registrando a saída para 'dribling.tr'. Antes de cada linha, a saída **A=<aval>** para o tracelog.
|
| Voltar para :ref:`debugger-execution-list`


 .. _debugger-command-traceflush:

traceflush
----------

|  **traceflush**
|
| Libera todos os arquivos de rastreamento abertos.
|
| Voltar para :ref:`debugger-execution-list`
