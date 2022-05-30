.. _debugger-execution-list:

Comandos de execução do depurador
=================================

.. line-block::

    :ref:`debugger-command-step`
        Passo único para instruções <*quantidade*> ( :kbd:`F11` ).
    :ref:`debugger-command-over`
        Passo único durante instruções <*quantidade*> ( :kbd:`F10` ).
    :ref:`debugger-command-out`
        Passo único até que o manipulador atual da sub-rotina/execução
        retorne ( :kbd:`Shift`-:kbd:`F11` ).
    :ref:`debugger-command-go`
        |1| ( :kbd:`F5` ).
    :ref:`debugger-command-gbt`
        |1| até que a próxima verdadeira ramificação seja executada.
    :ref:`debugger-command-gbf`
        |1| até que a próxima falsa ramificação seja executada.
    :ref:`debugger-command-gex`
        |1| até que a exceção seja criada.
    :ref:`debugger-command-gint`
        |1| até que a interrupção seja obtida ( :kbd:`F7` ).
    :ref:`debugger-command-gni`
        |1| até a próxima instrução mais adiante.
    :ref:`debugger-command-gtime`
        |1| até que o atraso determinado tenha decorrido.
    :ref:`debugger-command-gvblank`
        |1| até o próximo |vbi| [#VBI]_ ( :kbd:`F8` ).
    :ref:`debugger-command-next`
        |1| até a próxima alternância da *CPU* ( :kbd:`F6` ).
    :ref:`debugger-command-focus`
        Foca o depurador apenas na <*CPU*>.
    :ref:`debugger-command-ignore`
        Para a depuração na <*CPU*>.
    :ref:`debugger-command-observe`
        Retoma a depuração na <*CPU*>.
    :ref:`debugger-command-trace`
        Rastreia a determinada *CPU* para um arquivo.
    :ref:`debugger-command-traceover`
        Rastreia a determinada *CPU* para um arquivo, mas ignore as
        sub-rotinas.
    :ref:`debugger-command-traceflush`
        Elimina todos os arquivos de rastreamento que estiverem abertos.

.. [#VBI]	Vertical Blanking Interval, também conhecido como intervalo vertical ou VBLANK.


 .. _debugger-command-step:

step
----

**s[tep]** [<*quantidade*>]

Avança uma ou mais instruções sobre a *CPU* que estiver atualmente em
execução. Executa uma instrução caso <*quantidade*> seja omitido ou a
<*quantidade*> de passos para as instruções caso seja informada.

Exemplos:

.. line-block::

    ``s``
        Avança uma instrução na *CPU* atual.
    ``step 4``
        Avança 4 instruções na *CPU* atual.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-over:

over
----

**o[ver]** [<*quantidade*>]

O comando ``over`` avança um único passo sobre uma ou mais instruções
que estiverem sendo executadas na *CPU*, passando por cima das chamadas da
sub-rotina e das capturas do manipulador e contando-os como uma única
instrução. Observe que, ao passar por cima de uma chamada da sub-rotina
o código pode ser executado nas outras *CPUs* antes do retorno da chamada.

Passa por cima de uma instrução caso a <*quantidade*> seja omitida, ou
passe por cima das instruções caso a <*quantidade*> seja informada.

Observe que esta funcionalidade pode não estar implementada em todos os
tipos de *CPU*. Caso não esteja, então o comando ``over`` se comportará
exatamente como o comando :ref:`debugger-command-step`.

Exemplos:

.. line-block::

    ``o``
        Avança uma instrução na *CPU* atual.
    ``over 4``
        Avança 4 instruções na *CPU* atual.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-out:

out
---

**out**

O comando ``out`` avança um único passo até encontrar um retorno da
sub-rotina ou caso o retorno de uma instrução em exceção seja
encontrada. Observe que como ele detecta o retorno das condições da
exceção, caso tente sair de uma sub-rotina e uma interrupção/exceção
ocorra antes de atingir o final, será possível interromper o final das
exceções do manipulador prematuramente.

Observe que a funcionalidade para sair pode não estar implementada em
todos os tipos de *CPU*. Caso não esteja, então o comando ``out`` se
comportará exatamente como o comando :ref:`debugger-command-step`.

Exemplo:

.. line-block::

    ``out``
        Continua os passos até que uma sub-rotina ou um manipulador das exceções retorne.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-go:

go
--

**g[o]** [<*endereço*>]

|1|. O controle não será devolvido ao depurador até que
um ponto de interrupção ou que um ponto de controle [#WATCHPOINT]_ seja
atingido ou até que você faça uma interrupção manual. Caso o
<*endereço*> opcional seja fornecido, um ponto temporário de interrupção
incondicional será definido na *CPU* que estiver visível no endereço
determinado. Este ponto será eliminado automaticamente quando for
atingido.

	.. [#WATCHPOINT]	Watchpoint no Inglês

Exemplos:

.. line-block::

    ``g``
        |1| até que o ponto de interrupção/controle seja atingido ou até que uma interrupção (*break*) seja manualmente requisitada.
    ``g 1234``
        |1| parando no endereço 1234 até que outra condição faça com que a execução pare antes dela.

|ret| :ref:`debugger-execution-list`.


.. _debugger-command-gbf:

gbf
---

**gbf [<condição>]**

Retoma a execução. O controle não será devolvido ao depurador até que um
ponto de interrupção ou de controle seja acionado ou até que uma
ramificação condicional ou uma instrução ignorada não seja tomada, após
qualquer slot atrasado.

O parâmetro opcional **<condição>** permite que você especifique uma
expressão que será avaliada cada vez que uma ramificação condicional
seja encontrada. Caso o resultado da expressão seja verdadeiro
(não zero), a execução será interrompida se a ramificação não tiver sido
tomada; caso contrário, a execução continuará sem qualquer notificação.

Exemplos:

.. line-block::

    ``gbf``
        |1| até que o ponto de interrupção/controle seja atingido ou até
        a próxima ramificação falsa.
    ``gbf {pc != 1234}``
        |1| até que a próxima ramificação seja falsa, independente da
        instrução no endereço ``1234``.

|ret| :ref:`debugger-execution-list`


.. _debugger-command-gbt:

gbt
---

**gbt [<condição>]**

Retoma a execução. O controle não será devolvido ao depurador até que um
ponto de interrupção ou de controle seja acionado ou até que uma
ramificação condicional ou uma instrução ignorada seja tomada, seguido
de qualquer slot atrasado.

O parâmetro opcional **<condição>** permite que você especifique uma
expressão que será avaliada cada vez que uma ramificação condicional
seja encontrada. Caso o resultado da expressão seja verdadeiro
(não zero), a execução será interrompida após a ramificação ter sido
tomada; caso contrário, a execução continuará sem qualquer notificação.

Examplos:

.. line-block::

    ``gbt``
        |1| até que o ponto de interrupção/controle seja atingido ou até
        a próxima ramificação verdadeira.
    ``gbt {pc != 1234}``
        |1| até que a próxima ramificação seja verdadeira, independente
        da instrução no endereço ``1234``.

|ret| :ref:`debugger-execution-list`


.. _debugger-command-gex:

gex
---

**ge[x]** [<*exceção*>,[<*condição*>]]

|1|. O controle não será devolvido ao depurador até que
um ponto de interrupção ou de controle seja atingido, ou até que seja
levantada uma condição de exceção na *CPU* atual. Use o parâmetro opcional
<*exceção*> para parar a execução apenas numa condição de exceção
específica. Caso a <*exceção*> não seja usada, a execução irá parar em
qualquer condição de exceção.

O parâmetro opcional <*condição*> permite determinar uma expressão que
será avaliada cada vez que uma condição específica de exceção for
levantada. Caso o resultado da expressão seja verdadeiro (não zero), a
exceção interromperá a execução; caso contrário, a execução continuará
sem qualquer notificação.

Exemplos:

.. line-block::

    ``gex``
        |1| até que o ponto de interrupção/controle seja atingido ou até que uma condição de exceção seja levantada na *CPU* atual.
    ``ge 2``
        |1| até que o ponto de interrupção/controle seja atingido ou até que uma condição de exceção 2 seja levantada na *CPU* atual.

|ret| :ref:`debugger-execution-list`.


.. _debugger-command-gint:

gint
----

**gi[nt]** [<*irqline*>]

|1|. |2|, ou até que uma interrupção seja confirmada e reconhecida na
CPU atual. |3| <*irqline*> para parar a execução apenas na interrupção
determinada da linha que está sendo confirmada e reconhecida. Caso
<*irqline*> não seja usado, a execução será parada quando qualquer
interrupção for reconhecida.

Exemplos:

.. line-block::

    ``gi``
        |4| ou até que uma interrupção seja confirmada e reconhecida na *CPU* atual.
    ``gint 4``
        |4| ou até que uma interrupção requeira que a linha 4 seja confirmada e reconhecida na *CPU* atual.

|ret| :ref:`debugger-execution-list`.


.. _debugger-command-gni:

gni
---

**gni [<quantidade>]**

Retoma a execução. O controle não será devolvido ao depurador até que um
ponto de interrupção ou de controle seja acionado. Um ponto de
interrupção temporário e incondicional é definido no endereço do
programa **<quantidade>** atual, sendo passado de forma sequencial. Ele
é automaticamente removido quando este ponto de interrupção é acionado.

O parâmetro **<quantidade>** é opcional e retorna para o padrão ``1``
quando nada for definido. O comando não faz nada caso **<quantidade>**
seja definido como ``0``. O valor limite para **<quantidade>** é o
decimal ``512``.

Exemplos:

    ``gni``
        |1| até que o ponto de interrupção/controle seja atingido,
        incluindo o ponto de interrupção temporário definido no endereço
        da instrução seguinte.
    ``gni 2``
        |1| até que o ponto de interrupção/controle seja atingido. Um
        ponto de interrupção é definido após duas instruções passarem da
        atual.

|ret| :ref:`debugger-execution-list`


.. _debugger-command-gtime:

gtime
-----

**gt[ime]** <*milissegundos*>

|1|. O controle não será devolvido ao depurador até que o tempo interno
da emulação tenha decorrido. O intervalo é determinado em milissegundos.

Exemplo:

.. line-block::

    ``gtime #10000``
        Retoma a execução por 10 segundos do tempo de emulação.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-gvblank:

gvblank
-------

**gv[blank]**

|1|. |2|, ou até que se inicie o |vbi| para uma tela emulada.

Exemplos:

.. line-block::

    ``gv``
        |4| ou até que um |vbi| se inicie.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-next:

next
----

**n[ext]**

Retoma a execução até que uma *CPU* diferente seja agendada. Caso seja
ignorada pelo uso dos comandos :ref:`debugger-command-ignore` ou
:ref:`debugger-command-focus` a execução da CPU não vai parar.

Exemplo:

.. line-block::

    ``n``
        |1|, parando quando uma *CPU* diferente que não foi ignorada estiver agendada.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-focus:

focus
-----

**focus** <*CPU*>

Foca de forma exclusiva na <*CPU*> definida ignorando todas as outras. O
argumento <*CPU*> pode ser a etiqueta de um dispositivo ou um número de
depuração da *CPU* (|cpom|). É o mesmo que usar o comando
:ref:`debugger-command-ignore` para ignorar todas as *CPUs* que não seja
a *CPU* que foi definida.

Exemplos:

.. line-block::

    ``focus 1``
        Concentre-se exclusivamente na segunda CPU do sistema (|ibz|), ignorando todas as outras CPUs.
    ``focus audiopcb:melodycpu``
        Concentre-se exclusivamente na CPU |ccad| ``:audiopcb:melodycpu``.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-ignore:

ignore
------

**ignore** [<*CPU*>[,<*CPU*>[,…]]]

Ignora determinadas *CPUs* no depurador. As *CPUs* podem ser definidas
através de uma etiqueta ou pelo número da CPU no depurador (|cpom|). O
depurador nunca mostra a execução para as *CPUs* que forem ignoradas e
os pontos de interrupção ou de observação nas CPUs ignoradas não têm
qualquer efeito. Caso nenhuma *CPUs* seja indicada, as *CPUs* atualmente
ignoradas serão listadas. Utilize o comando
:ref:`debugger-command-observe` para parar de ignorar uma *CPU*.

Observe que você não pode ignorar todas as *CPUs*; pelo menos uma *CPU*
deve ser observada o tempo todo.

Exemplos:

.. line-block::

    ``ignore audiocpu``
        Ignora a CPU |ccad| ``:audiocpu`` |auod|.
    ``ignore 2,3,4``
        Ignora a terceira, quarta e quinta *CPU* no sistema (|ibz|) |auod|.
    ``ignore``
        Lista as CPUs que estiverem sendo ignoradas pelo depurador.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-observe:

observe
-------

**observe** [<*CPU*>[,<*CPU*>[,…]]]

Permite a interação com determinada *CPU* no depurador. As *CPUs* podem
ser definidas através de etiquetas ou pelo número da *CPU* (|cpom|).
Este comando reverte o comando :ref:`debugger-command-ignore`. Quando
nenhuma *CPUs* for definida, apenas as *CPUs* observadas no momento
serão listadas.

Exemplos:

.. line-block::

    ``observe audiocpu``
        Para de ignorar a CPU |ccad| ``:audiocpu`` |auod|.
    ``observe 2,3,4``
        Para de ignorar a 3ª, 4ª, 5ª *CPU* no sistema (|ibz|) |auod|.
    ``observe``
        Lista as CPUs que estão atualmente sendo observadas pelo depurador.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-trace:

trace
-----

**trace** {<*nome_do_arquivo*>|off}[,<*CPU*>[,[noloop|logerror][,<*ação*>]]]

Inicia ou interrompe o rastreamento da execução de determinada <*CPU*>
ou da <*CPU*> atualmente visível caso nenhuma tenha sido definida. Para
ativar o rastreamento defina o nome do arquivo para o registro do
rastreamento no parâmetro <*nome_do_arquivo*>. Para desativar o
rastreamento use o termo ``off`` no parâmetro <*nome_do_arquivo*>.
Quando o argumento <nome_do_arquivo> começar com dois chevrons (``>>``),
ele é tratado como uma diretiva para abrir o arquivo para anexar em vez
de gravar por cima.

O terceiro parâmetro opcional é um campo sinalizador. As sinalizações
compatíveis são ``noloop`` e ``logerror``. As diversas sinalizações
devem ser separadas por caracteres ``|`` (barra vertical). Por padrão,
os laços são detectados e condensados numa única linha. Quando a
sinalização ``noloop`` for definida, os *loops* não serão detectados e
todas as instruções serão registradas como já executadas. Quando a
sinalização ``logerror`` for definida, a saída do registro de erro será
incluída no registro de rastreamento.

O parâmetro opcional <*ação*> é um comando de depuração para ser
executado antes que cada mensagem de rastreamento seja registrada.
Geralmente, isto incluirá um comando
:ref:`debugger-command-tracelog` ou :ref:`debugger-command-tracesym`
incluindo informações adicionais no registro de rastreamento. |oqts|
``trace``.

Exemplos:

.. line-block::

    ``trace joust.tr``
        |irde| |dcav|, |rasa| ``joust.tr``.
    ``trace dribling.tr,maincpu``
        |irde| |ccad| ``:maincpu:``, |rasa| ``dribling.tr``.
    ``trace starswep.tr,,noloop``
        |irde| |dcav|, |rasa| ``starswep.tr``, com a detecção de loop desativada.
    ``trace starswep.tr,1,logerror``
        |irde| da segunda CPU do sistema (|ibz|), registrando a saída junto com a saída do registro de erro no arquivo ``starswep.tr``.
    ``trace starswep.tr,0,logerror|noloop``
        |irde| da primeira CPU do sistema (|ibz|), registrando a saída junto com a saída do registro de erro no arquivo ``starswep.tr``, com a detecção de loop desativada.
    ``trace >>pigskin.tr``
        |irde| |dcav|, agregando a saída do registro ao arquivo ``pigskin.tr``.
    ``trace off,0``
        Desativa o rastreamento para a primeira CPU no sistema (|ibz|).
    ``trace asteroid.tr,,,{tracelog "A=%02X ",a}``
        |irde| |dcav|, |rasa| ``asteroid.tr``. Antes de cada linha registra ``A=<aval>`` ao registro de rastreamento.

|ret| :ref:`debugger-execution-list`.


 .. _debugger-command-traceover:

traceover
---------

**traceover** {<*nome_do_arquivo*>|off}[,<*CPU*>[,[noloop|logerror][,<*ação*>]]]

Inicia ou interrompe o rastreamento da execução de determinada <*CPU*>
ou da <*CPU*> atualmente visível caso nenhuma tenha sido definida. No
momento que o retorno a sub-rotina é encontrada, o rastreamento será ignorado 

No momento que uma chamada de sub-rotina é encontrada, a sub-rotina será
ignorada pelo rastreamento. É usado o mesmo algoritmo que é usado no
comando :ref:`step over <debugger-command-over>`. Ele não funcionará
corretamente com funções recursivas ou caso o endereço retornado não
siga imediatamente a instrução da chamada.

Este comando aceita os mesmos parâmetros que o comando
:ref:`debugger-command-trace`. Favor consultar a seção correspondente
para uma descrição mais detalhada das opções e para obter mais exemplos.

Exemplos:

.. line-block::

    ``traceover joust.tr``
        |irde| |dcav|, |rasa| ``joust.tr``.
    ``traceover dribling.tr,maincpu``
        |irde| |ccad| ``:maincpu:``, |rasa| ``dribling.tr``.
    ``traceover starswep.tr,,noloop``
        |irde| |dcav|, |rasa| ``starswep.tr``, com a detecção de loop desativada.
    ``traceover off,0``
        Desativa o rastreamento para a primeira CPU no sistema (|ibz|).
    ``traceover asteroid.tr,,,{tracelog "A=%02X ",a}``
        |irde| |dcav|, |rasa| ``asteroid.tr``. Antes de cada linha registra ``A=<aval>`` ao registro de rastreamento.

|ret| :ref:`debugger-execution-list`


 .. _debugger-command-traceflush:

traceflush
----------

**traceflush**

Grava no disco todos os arquivos dos registros de rastreamento que
estiverem abertos.

Exemplo:

.. line-block::

    ``traceflush``
        Grava todos os arquivos dos registros de rastreamento.

|ret| :ref:`debugger-execution-list`

.. |1| replace:: Retoma a execução
.. |2| replace:: O controle não será devolvido ao depurador até que um
   ponto de interrupção ou de controle seja atingido
.. |3| replace:: Use o parâmetro opcional
.. |4| replace:: Retoma a execução até que o ponto de
   interrupção/controle seja atingido
.. |ret| replace:: Retorna para
.. |vbi| replace:: intervalo de apagamento vertical
.. |ibz| replace:: num índice com base zero
.. |auod| replace:: ao utilizar o depurador
.. |ccad| replace:: com o caminho absoluto da etiqueta
.. |irde| replace:: Inicia o rastreio da execução
.. |dcav| replace:: na CPU que estiver visível no momento
.. |cpom| replace:: consulte :ref:`debugger-devicespec` para obter mais
   detalhes
.. |rasa| replace:: registrando a saída no arquivo
.. |oqts| replace:: Observe que talvez seja necessário cercar a ação
   dentro de chaves ``{`` ``}`` garantindo que as vírgulas e os
   ponto-e-vírgulas dentro do comando não sejam interpretadas no
   contexto do próprio comando
