.. _debugger-general-list:

Comandos gerais do depurador
============================

.. line-block::

    :ref:`debugger-command-help`
        |eaai| no console.
    :ref:`debugger-command-do`
        Avalia a expressão fornecida.
    :ref:`debugger-command-symlist`
        Lista os símbolos registrados.
    :ref:`debugger-command-softreset`
        Executa uma redefinição simples [#sr]_.
    :ref:`debugger-command-hardreset`
        Executa uma redefinição completa [#hr]_.
    :ref:`debugger-command-print`
        Imprime um ou mais <*item*>s no console.
    :ref:`debugger-command-printf`
        Imprime um ou mais <*item*>s no console usando <*formato*>.
    :ref:`debugger-command-logerror`
        Grava um ou mais <*item*>s no ``error.log``.
    :ref:`debugger-command-tracelog`
        Grava um ou mais <*item*>s no arquivo de rastreamento usando <*formato*>.
    :ref:`debugger-command-tracesym`
        Grava um ou mais <*item*>s no arquivo de rastreamento.
    :ref:`debugger-command-history`
        Exibe os endereços PC e os *opcodes* visitados recentemente.
    :ref:`debugger-command-trackpc`
        Rastreia visualmente os *opcodes* já visitados.
    :ref:`debugger-command-trackmem`
        Grava qual PC escreveu em cada endereço da memória.
    :ref:`debugger-command-pcatmem`
        Consulta qual PC escreveu num determinado endereço da memória.
    :ref:`debugger-command-rewind`
        Volta no tempo carregando o estado mais recente da rebobinagem.
    :ref:`debugger-command-statesave`
        Grava o estado no arquivo para o sistema que está sendo emulado.
    :ref:`debugger-command-stateload`
        Lê o arquivo do estado do sistema que está sendo emulado.
    :ref:`debugger-command-snap`
        Grava uma captura da tela.
    :ref:`debugger-command-source`
        Faz a leitura dos comando a partir do arquivo e os executa individualmente.
    :ref:`debugger-command-time`
        Imprime o tempo atual do sistema no console.
    :ref:`debugger-command-quit`
        Encerra o depurador e a emulação.


.. _debugger-command-help:

help
----

**help** [<*tópico*>]

Exibe a ajuda integrada do depurador no console. Caso nenhum <*tópico*>
seja definido, os principais tópicos serão listados. A maioria
dos comandos do depurador possuem tópicos correspondentes de ajuda.

Exemplos:

.. line-block::

    ``help``
        Lista os principais tópicos de ajuda.
    ``help expressions``
        |eaai| para a sintaxe de expressão do depurador.
    ``help wpiset``
        |eaai| para o comando :ref:`wpiset <debugger-command-wpset>`.

|ret| :ref:`debugger-general-list`.


.. _debugger-command-do:

do
--

**do** <*expressão*>

O comando ``do`` simplesmente avalia a expressão fornecida. Geralmente é
utilizado para definir ou alterar a variável do estado do dispositivo
(os registros da *CPU* por exemplo) ou para escrever na memória.
Consulte :ref:`debugger-express` |pomd| sobre a sintaxe da
expressão.


Exemplo:

.. line-block::

    ``do pc = 0``
        Define o registro ``pc`` como ``0``.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-symlist:

symlist
-------

**symlist** [<*CPU*>]

Lista os símbolos registrados e seus respectivos valores. Quando a
<*CPU*> não for definida, os símbolos na tabela de símbolos globais são
exibidos, caso contrário, são exibidos os símbolos específicos do
dispositivo <*CPU*>. Os símbolos são listados em ordem alfabética. São
anotados apenas os símbolos que sejam somente de leitura. Consulte
:ref:`debugger-devicespec` |pomd| de como definir uma *CPU*.

Exemplos:

.. line-block::

    ``symlist``
        Exibe a tabela global dos símbolos.
    ``symlist 2``
        Exibe os símbolos para a 3ª CPU do sistema (|ibz|).
    ``symlist audiocpu``
        Exibe os símbolos para a CPU |ccad| ``:audiocpu``.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-softreset:

softreset
---------

**softreset**

Executa uma redefinição simples. Invoca as funções do membro *reset* de
todos os dispositivos do sistema (por padrão, o mesmo ocorre ao
pressionar :kbd:`F3` durante a emulação).

Exemplo:

.. line-block::

    ``softreset``
        Executa uma redefinição simples.

|ret| :ref:`debugger-general-list`.


	.. raw:: latex

		\clearpage


 .. _debugger-command-hardreset:

hardreset
---------

**hardreset**

Executa uma redefinição completa. Isso faz o reinicio completo da sessão
e inicia uma nova com o mesmo sistema e com as mesmas opções. (por
padrão, o mesmo ocorre ao pressionar :kbd:`Shift` + :kbd:`F3` durante a
emulação). Observe que isso ocasiona a perda do histórico no console do
emulador e do registro de erro.

Exemplo:

.. line-block::

    ``hardreset``
        Executa uma redefinição completa.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-print:

print
-----

**print** <*item*>[,…]

O comando ``print`` imprime o resultado de uma ou mais expressões no
console do depurador como números hexadecimais.

Exemplos:

.. line-block::

    ``print pc``
        Imprime o valor do registro ``pc`` no console como um número hexadecimal.
    ``print a,b,a+b``
        Imprime o valor de ``a``, ``b`` e de ``a`` + ``b`` no console como números hexadecimais.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-printf:

printf
------

**printf** <*formato*>[,<*argumento*>[,…]]

|imfe| no console de depuração. Apenas um subconjunto muito limitado dos
especificadores de formato e das sequências de escape estão disponíveis:

.. line-block::

    ``%c``
        |iacc| como um caractere 8-bit.
    ``%[0][<n>]d``
        |iacc| como um número decimal com largura opcional mínima do campo, com preenchimento zero.
    ``%[0][<n>]o``
        |iacc| como um número octal com largura opcional mínima do campo, com preenchimento zero usando letras minúsculas.
    ``%[0][<n>]x``
        |iacc| como um número hexadecimal com largura opcional mínima do campo, com preenchimento zero usando letras maiúsculas.
    ``\%%``
        Imprime a porcentagem literal do símbolo.
    ``\n``
        Imprime uma quebra de linha.
    ``\\``
        Imprime literalmente uma barra lateral.

Qualquer outro formato que for utilizado será ignorado.

Exemplos:

.. line-block::

    ``printf "PC=%04X",pc``
        Imprime ``PC=<pcval>`` onde <*pcval*> |evhr|.
    ``printf "A=%d, B=%d\\nC=%d",a,b,a+b``
        Imprime ``A=<aval>, B=<bval>`` numa linha e ``C=<a+bval>`` na segunda.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-logerror:

logerror
--------

**logerror** <*formato*>[,<*argumento*>[,…]]

|imfe| no registro de erro. Consulte :ref:`debugger-command-printf` para
mais detalhes sobre o limitado subconjunto dos especificadores de
formato e das sequências de escape.

Exemplos:

.. line-block::

    ``logerror "PC=%04X",pc``
        Registra ``PC=<pcval>`` onde <*pcval*> |evhr|.
    ``logerror "A=%d, B=%d\\nC=%d",a,b,a+b``
        Registra ``A=<aval>, B=<bval>`` numa linha, e ``C=<a+bval>`` na segunda.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-tracelog:

tracelog
--------

**tracelog** <*format*>[,<*argumento*>[,…]]

|imfe| para o arquivo de rastreamento |anm| (consulte
:ref:`debugger-command-trace` |pomd|). O comando não tem qualquer efeito
caso nenhum arquivo de rastreamento esteja aberto. Consulte
:ref:`debugger-command-printf` |pomd| sobre o limitado subconjunto dos
especificadores de formato e das sequências de escape.

Exemplos:

.. line-block::

    ``tracelog "PC=%04X",pc``
        Produz ``PC=<pcval>`` onde <*pcval*> |evhr| |carr|.
    ``tracelog "A=%d, B=%d\\nC=%d",a,b,a+b``
        Produz ``A=<aval>, B=<bval>`` numa linha e ``C=<a+bval>`` na segunda, |carr|.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-tracesym:

tracesym
--------

**tracesym** <*item*>[,…]

Imprime os símbolos indicados no arquivo de rastreamento |anm| (consulte
:ref:`debugger-command-trace` |pomd|). O comando não tem qualquer efeito
caso nenhum arquivo esteja aberto.

Exemplo:

.. line-block::

    ``tracesym pc``
        Produz ``PC=<pcval>`` onde <*pcval*> é o valor do registro ``pc`` em seu formato padrão |carr|.

|ret| :ref:`debugger-general-list`.


	.. raw:: latex

		\clearpage


.. _debugger-command-history:

history
-------

**history** [<*CPU*>[,<*comprimento*>]]

Exibe os endereços *PC* visitados recentemente e a desmontagem das
instruções nestes endereços. Se presente, o primeiro argumento seleciona
a CPU (consulte :ref:`debugger-devicespec` |pomd|), caso contrário,
assume a *CPU* que estiver visível. Caso o segundo argumento esteja
presente, faz a limitação da quantidade de endereços que será exibido.
Os endereços são apresentados na ordem do menor para os mais
recentemente visitados.

Exemplos:

.. line-block::

    ``history ,5``
        Exibe até cinco endereços e instruções *PC* mais recentemente visitados para a CPU que estiver visível.
    ``history 3``
        Exibe os endereços e as instruções *PC* mais recentemente visitados para a 4ª CPU do sistema (|ibz|).
    ``history audiocpu,1``
        Exibe os endereços e as instruções *PC* mais recentemente visitados |ccad| ``:audiocpu``.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-trackpc:

trackpc
-------

**trackpc** [<*ativa*>[,<*CPU*>[,<*apaga*>]]]

Liga ou desliga o rastreamento do endereço *PC* visitado para a
visualização da desmontagem. As instruções nos endereços visitados
são destacadas nas visualizações de desmontagem do depurador enquanto o
rastreamento estiver ligado. O 1º argumento é um booleano determinando
se o rastreamento deve ser ativado ou não (o padrão é ``enabled``). Já
o 2º argumento determina em qual *CPU* o rastreamento deve ser ativado
ou não (consulte :ref:`debugger-devicespec` |pomd|).
Quando nenhuma *CPU* for definida, assume a 1ª *CPU* que estiver
visível. O 3º argumento é um booleano que determina se os dados
existentes devem ser apagados ou não (o padrão é ``false``).

Exemplos:

.. line-block::

   ``trackpc 1``
      Inicia ou faz o rastreamento PC da *CPU* atual.
   ``trackpc 1,0,1``
      Inicia ou continua o rastreamento PC na 1ª *CPU* do sistema (|ibz|), porém apaga o histórico que foi rastreado até o momento.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-trackmem:

trackmem
--------

**trackmem** [<*ativa*>,[<*CPU*>,[<*apaga*>]]]

Liga ou desliga o registro do endereço *PC* cada vez que um endereço da
memória for escrito. O 1º argumento é um booleano determinando
se o rastreamento deve ser ativado ou não (o padrão é ``enabled``). Já o
2º argumento determina em qual *CPU* o rastreamento deve ser ativado ou
não (consulte :ref:`debugger-devicespec` |pomd|).
Quando nenhuma *CPU* for definida, assume a primeira *CPU* que estiver
visível. O 3º argumento é um booleano que determina se os dados
existentes devem ser apagados ou não (o padrão é ``false``).

Utilize :ref:`debugger-command-pcatmem` para reaver estes dados. Ao
clicar com o botão direito do mouse no visualizado de memória do
depurador, também será exibido o valor registrado no *PC* para dado
endereço em algumas configurações.

Exemplos:

.. line-block::

    ``trackmem``
        |icrd| |dcav|.
    ``trackmem 1,0,1``
        |icrd| na 1ª *CPU* do sistema (|ibz|), porém apaga os dados de rastreamentos já existentes.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-pcatmem:

pcatmem
-------

**pcatmem[{d|i|o}]** <*endereço*>[:<*espaço*>]

Retorna o valor PC no momento onde o endereço especificado tenha sido
recentemente escrito. O argumento é o endereço solicitado, opcionalmente
seguido por dois pontos e uma *CPU* e/ou uma |fde| (consulte
:ref:`debugger-devicespec` |pomd|).

Os sufixos ``d``, ``i`` ou ``o`` controlam a |fde| padrão para o comando.

O rastreamento deve estar ativado para que os dados utilizados por este
comando possam ser gravados (consulte :ref:`debugger-command-trackmem`).
Ao clicar com o botão direito do mouse no visualizado de memória do
depurador, também será exibido o valor registrado no *PC* para dado
endereço em algumas configurações.

Exemplos:

.. line-block::

   ``pcatmem 400000``
      Imprime o valor recentemente escrito no *PC* quando a localização ``400000`` estiver |nrvd|.
   ``pcatmem 3bc:io``
       Imprime o valor recentemente escrito no *PC* quando a localização ``3bc`` estiver na faixa ``io`` da *CPU* que estiver visível.
   ``pcatmem 1400:audiocpu``
       Imprime o valor recentemente escrito no *PC* quando a localização ``1400`` estiver na faixa do programa ``:audiocpu`` da *CPU*.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-rewind:

rewind
------

**rewind**

Carrega o estado salvo mais recente da *RAM*. Quando ativado os estados
``rewind`` são gravados quando os comando :ref:`debugger-command-step`,
:ref:`debugger-command-over` e :ref:`debugger-command-out` são
utilizados, armazenando o estado do sistema num momento antes do
avanço. Este comando pode ser abreviado para ``rw``.

A carga consecutiva dos estados ``rewind`` pode funcionar como uma
execução inversa. Dependendo das etapas que foram tomadas
anteriormente, o comportamento pode ser semelhante ao dos comandos
``reverse-stepi`` e ``reverse-next`` do *GDB*. |tsdc|.

As estatísticas anteriores da memória e do rastreamento do PC são
apagadas. A atual execução reversa não ocorre.

Exemplos:

.. line-block::

    ``rewind``
        Carrega o estado anterior da *RAM*.
    ``rw``
        Uma forma breviada do comando.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-statesave:

statesave
---------

**statesave** <*nome_do_arquivo*>

Grava um estado do sistema do momento atual no tempo do emulador. O
arquivo do estado é gravado no diretório de gravação do estado (consulte
a opção :ref:`state_directory <mame-commandline-statedirectory>`), a
extensão ``.sta`` é adicionada automaticamente ao nome do arquivo. Pode
ser abreviado para ``ss``.

|tsdc|.

Exemplos:

.. line-block::

   ``statesave foo``
      Grava o estado do sistema que está sendo emulado no arquivo ``foo.sta`` no diretório de gravação do estado.
   ``ss bar``
      A forma abreviada do comando, grava o estado do sistema que está sendo emulado no arquivo ``bar.sta``.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-stateload:

stateload
---------

**stateload** <*nome_do_arquivo*>

Carrega o arquivo de estado a partir do disco. O arquivo do estado é
carregado a partir do diretório de gravação do estado (consulte
a opção :ref:`state_directory <mame-commandline-statedirectory>`), a
extensão ``.sta`` é adicionada automaticamente ao nome do arquivo. Pode
ser abreviado para ``sl``.

|tsdc|. |amaa|.

Exemplos:

.. line-block::

    ``stateload foo``
        Carrega o arquivo do estado ``foo.sta`` a partir do diretório de gravação do estado.
    ``sl bar``
        A forma abreviada do comando, carrega o arquivo ``bar.sta``.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-snap:

snap
----

**snap** [<*nome_do_arquivo*>[,<*scrnum*>]]

Faz uma captura da tela emulada e grava no diretório *snapshot*
(consulte a opção
:ref:`snapshot_directory <mame-commandline-snapshotdirectory>`).

Quando um nome é definido, uma única captura é salva usando este nome
(o a primeira tela do sistema caso nenhuma tenha sido definida). Quando
um nome não é definido, as configurações predefinidas são utilizadas
(consulte as opções :ref:`snapview <mame-commandline-snapview>` e
:ref:`snapname <mame-commandline-snapname>` ).

A extensão ``.png`` é adicionada automaticamente ao nome do arquivo. O
número da tela é atrabuída |ibz|, conforme é visto nos nomes das
visualizações com uma única tela que são geradas automaticamente nos
menus das opções de vídeo do MAME.

Exemplos:

.. line-block::

    ``snap``
        Faz uma captura da tela usando as configurações já predefinidas.
    ``snap shinobi``
        Faz uma captura da primeira tela e salva como ``shinobi.png`` no diretório configurado para *snapshot*.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-source:

source
------

**source** <*nome_do_arquivo*>

Carrega o arquivo em modo texto e executa cada linha como se fossem
comandos de depuração. É equivamente a rodar um *script shell* ou um
arquivo *batch*.

Exemplo:

.. line-block::

    ``source break_and_trace.cmd``
        Carrega e executa os comandos do depurador a partir do arquivo ``break_and_trace.cmd``.

|ret| :ref:`debugger-general-list`.


.. _debugger-command-time:

time
----

Imprime o tempo total decorrido da emulação no console do depurador.

Exemplos:

.. line-block::

    ``time``
        Imprime o tempo decorrido da emulação.

|ret| :ref:`debugger-general-list`.


 .. _debugger-command-quit:

quit
----

**quit**

Fecha o depurador e encerra a emulação imediatamente. Ou encerra o MAME
ou retorna ao menu de seleção do sistema dependendo de como o sistema
foi usado na linha de comando, se o MAME foi iniciado sozinho e sem
comandos ele retorna para a interface gráfica, caso tenha sido iniciado
com algum sistema, o MAME encerra imediatamente.

Exemplo:

.. line-block::

    ``quit``
        Encerra a emulação imediatamente.

|ret| :ref:`debugger-general-list`.


.. |eaai| replace:: Exibe a ajuda integrada
.. |ret| replace:: Retorna para
.. |ibz| replace:: num índice com base zero
.. |anm| replace:: aberto no momento
.. |ccad| replace:: com o caminho absoluto da etiqueta
.. |iacc| replace:: Imprime o argumento correspondente
.. |evhr| replace:: é o valor hexadecimal do registro ``pc`` com um mínimo de quatro dígitos e preenchimento zero
.. |imfe| replace:: Imprime uma mensagem formatada em estilo C
.. |carr| replace:: caso o arquivo de registro de rastreamento esteja aberto
.. |dcav| replace:: na *CPU* que estiver visível no momento
.. |icrd| replace:: Inicia ou continua o rastreamento das escritas na memória
.. |pomd| replace:: para obter mais informações
.. |fde| replace:: faixa de endereços
.. |nrvd| replace:: na região visível do programa na *CPU*
.. |amaa| replace:: A memória anterior e as estatísticas de rastreamento do PC serão apagadas
.. |tsdc| replace:: Toda a saída deste comando é ecoada em tempo real na janela do sistema que estiver em execução
.. [#sr] *Soft reset* no Inglês.
.. [#hr] *Hard reset* no Inglês.
