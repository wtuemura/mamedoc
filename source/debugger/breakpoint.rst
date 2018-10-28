.. _debugger-breakpoint-list:

Comandos de breakpoints do depurador
====================================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-bpset` -- define o breakpoint no <*address*>
| :ref:`debugger-command-bpclear` -- limpa um determinado breakpoint ou todos se nenhum <*bpnum*> for especificado
| :ref:`debugger-command-bpdisable` -- desabilita um determinado breakpoint se nenhum <*bpnum*> for especificado
| :ref:`debugger-command-bpenable` -- habilita um determinado breakpoint ou todos se nenhum <*bpnum*> for especificado
| :ref:`debugger-command-bplist` -- lista todos os breakpoints


 .. _debugger-command-bpset:

bpset
-----

|  **bp[set]** <*address*>[,<*condition*>[,<*action*>]]
|
| Define uma nova execução de breakpoint no <*address*> especificado.
| O parâmetro de condição opcional *<condition>* permite que você especifique uma expressão que será avaliada cada vez que um breakpoint for atingido. Caso o resultado da expressão seja verdadeiro (não-zero), o breakpoint irá interromper (halt) a execução; caso contrário, a execução continuará sem nenhuma notificação.
| O parâmetro opcional de ação *<action>* fornece um comando que é executado sempre que o breakpoint for atingido e a condição *<condition>* for verdadeira. Observe que você pode precisar incorporar a ação dentro de chaves **{ }** para evitar que vírgulas e ponto e vírgula seja interpretado e aplicado ao comando de bpset em si. Cada breakpoint que for definido é designado a um índice que pode ser usado em outros comandos breakpoint para usar este breakpoint como referência.
|
| Exemplos:
|
|  ``bp 1234``
|
| Define um breakpoint que irá interromper uma execução sempre que o PC for igual a **1234**.
|
|  ``bp 23456,a0 == 0 && a1 == 0``
|
| Define um breakpoint que irá interromper uma execução sempre que o PC for igual a **23456** e a expressão **(a0 == 0 && a1 == 0)** for verdadeira.
|
|  ``bp 3456,1,{printf "A0=%08X\\n",a0; g}``
|
| Define um breakpoint que irá interromper uma execução sempre que o PC for igual a **3456**. Quando isso acontecer, imprime **A0=<a0val>** e continua a execução.
|
|  ``bp 45678,a0==100,{a0 = ff; g}``
|
| Define um breakpoints que irá interromper uma execução sempre que o PC for igual a **45678** e a expressão **(a0 == 100)** for verdadeira. Quando isso acontecer, define **a0** para **ff** e resume a execução.
|
|  ``temp0 = 0; bp 567890,++temp0 >= 10``
|
| Define um breakpoints que irá interromper uma execução sempre que o PC for igual a **567890** e a expressão **(++temp0 >= 10)** for verdadeira. Isso somente para de fato após o breakpoint ter sido atingido 16 vezes.
|
| Back to :ref:`debugger-breakpoint-list`


 .. _debugger-command-bpclear:

bpclear
-------

|  **bpclear** [<*bpnum*>]
|
| O comando "*bpclear*" limpa um breakpoint. Caso um <*bpnum*> seja definido, apenas o breakpoint requisitado será limpo, caso contrário todos os breakpoints serão limpos.
|
| Exemplos:
|
|  ``bpclear 3``
|
| Limpa o indexador **3** do breakpoints.
|
|  ``bpclear``
|
| Limpa todos os breakpoints.
|
| Back to :ref:`debugger-breakpoint-list`


 .. _debugger-command-bpdisable:

bpdisable
---------

|  **bpdisable** [<*bpnum*>]
|
| O comando "*bpdisable*" desabilita um breakpoint. Caso um <*bpnum*> seja definido, apenas o breakpoint solicitado será desabilitado, caso contrário todos os breakpoints serão desativados. Observe que ao desabilitar um breakpoint ele não será apagado, apenas o marca temporariamente como inativo.
|
| Exemplos:
|
|  ``bpdisable 3``
|
| Desabilita o indexador **3** do breakpoint.
|
|  ``bpdisable``
|
| Desabilita todos os breakpoints.
|
| Back to :ref:`debugger-breakpoint-list`


 .. _debugger-command-bpenable:

bpenable
--------

|  **bpenable** [<*bpnum*>]
|
| O comando "*bpenable*" habilita um breakpoint. Caso um <*bpnum*> seja definido, apenas o breakpoint solicitado será ativado, caso contrário todos os breakpoints serão desativados.
|
| Exemplos:
|
|  ``bpenable 3``
|
| Ativa o indexador 3 do breakpoint.
|
|  ``bpenable``
|
| Ativa todos os breakpoints.
|
| Back to :ref:`debugger-breakpoint-list`


 .. _debugger-command-bplist:

bplist
------

|  **bplist**
|
| O comando bplist lista todos os breakpoints atuais, junto com seu indexador ou qualquer condições ou ações anexados a eles.
|
| Back to :ref:`debugger-breakpoint-list`

