.. _debugger-watchpoints-list:

Comandos watchpoint do depurador
================================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

|	:ref:`debugger-command-wpset` -- define o espaço de watchpoint para o programa, dados e I/O
|	:ref:`debugger-command-wpclear` -- limpa todos ou nenhum watchpoint caso nenhum <*wpnum*> seja definido
|	:ref:`debugger-command-wpdisable` -- desabilita todos ou um determinado watchpoint caso nenhum <*wpnum*> seja definido
|	:ref:`debugger-command-wpenable` -- habilita todos ou um determinado watchpoint caso nenhum <*wpnum*> seja definido
|	:ref:`debugger-command-wplist` -- lista todos os watchpoints
|

 .. _debugger-command-wpset:

wpset
-----

|  **wp[{d|i}][set]** <*address*>,<*length*>,<*type*>[,<*condition*>[,<*action*>]]
|
| define um novo "*watchpoint*" começando no endereço definido <*address*> e estendendo para <*length*>. O intervalo inclusivo do watchpoint é <*address*> através de <*address*> + <*length*> - 1.
| O comando "*wpset*" define um watchpoint na memória do programa; o comando "*wpdset*" define um watchpoint nos dados da memória; e o comando "*wpiset*" define um watchpoint no I/O da memória.
| O parâmetro <*type*> especifica que tipo de acesso apanhar. Pode ser um dos três valores: 'r' para um watchpoint de leitura 'w' para um watchpoint de gravação e 'rw' para um watchpoint de leitura/escrita.
|
| O parâmetro de condição opcional <*condition*> permite que você especifique uma expressão que será avaliada cada vez que o watchpoint for atingido. Se o resultado da expressão for verdadeiro (não-zero), o watchpoint irá interromper (halt) a execução; caso contrário, a execução continuará sem nenhuma notificação.
| O parâmetro opcional de ação <*action*> fornece um comando que é executado sempre que o watchpoint for atingido e a condição <*condition*> for verdadeira. Observe que você pode precisar incorporar a ação entre chaves **{ }** para evitar que as vírgulas e os pontos e vírgulas sejam interpretados como se aplicassem ao próprio comando wpset.
| Cada watchpoint que for definido é designado a um índice que pode ser usado em outros comandos watchpoint para usar este watchpoint como referência.
| A fim de ajudar a expressão de condição <*condition*>, duas variáveis estão disponíveis, a variável 'wpaddr' é definida para o endereço que realmente desencadeou o watchpoint, a variável 'wpdata' é definida para os dados que estão sendo lidos ou escritos, a variável 'wpsize' é definido para o tamanho dos dados em bytes.
|
| Exemplos:
|
|  ``wp 1234,6,rw``
|
| Define um watchpoint que interromperá a execução sempre que uma leitura ou escrita acontecer no intervalo de endereço **1234-1239**, inclusive.
|
|  ``wp 23456,a,w,wpdata == 1``
|
| Define um watchpoint que interromperá a execução sempre que uma escrita no intervalo do endereço **23456-2345f** e os dados escritos forem iguais a **1**.
|
|  ``wp 3456,20,r,1,{printf "Read @ %08X\\n",wpaddr; g}``
|
| Define um watchpoint que interromperá a execução sempre que uma leitura acontecer no intervalo de endereço **3456-3475**. Quando isso acontecer, imprime **Read @ <wpaddr>** e continua a execução.
|
|  ``temp0 = 0; wp 45678,1,w,wpdata==f0,{temp0++; g}``
|
| Define um watchpoint que interromperá a execução sempre que uma escrita acontecer no endereço **45678** e o valor que estiver sendo escrito for igual a **f0**. Quando isso acontecer, incrementa a variável **temp0** e resume a execução.
|
| Voltar para :ref:`debugger-watchpoints-list`
|

 .. _debugger-command-wpclear:

wpclear
-------

|  **wpclear** [<*wpnum*>]
|
| O comando "*wpclear*" limpa o watchpoint. Caso o <*wpnum*> seja definido, apenas o watchpoint solicitado é limpo, caso contrário, todos os watchpoints serão limpos.
|
| Exemplos:
|
|  ``wpclear 3``
|
| Limpa o **indexador 3** do watchpoint.
|
|  ``wpclear``
|
| Limpa todos os watchpoints.
|
| Voltar para :ref:`debugger-watchpoints-list`
|

 .. _debugger-command-wpdisable:

wpdisable
---------

|  **wpdisable** [<*wpnum*>]
|
| O comando "*wpdisable*" desabilita um watchpoint. Caso o <*wpnum*> seja definido, apenas o watchpoint solicitado é desativado, caso contrário, todos os watchpoints serão desativados. Note que desabilitar um watchpoint ele não é apagado, o watchpoint fica registrado temporariamente como inativo.
|
| Exemplos:
|
|  ``wpdisable 3``
|
| Desabilita o **indexador 3** do watchpoint.
|
|  ``wpdisable``
|
| Desabilita todos os watchpoints.
|
| Voltar para :ref:`debugger-watchpoints-list`
|

 .. _debugger-command-wpenable:

wpenable
--------

|  **wpenable** [<*wpnum*>]
|
| O comando "*wpenable*" habilita um watchpoint. Caso o <*wpnum*> seja definido, apenas o "*watchpoint*" solicitado é ativado, caso contrário, todos os watchpoints serão ativados.
|
| Exemplos:
|
|  ``wpenable 3``
|
| ativa todos os **index 3**.
|
|  wpenable
|
| ativa todos os watchpoints.
|
| Voltar para :ref:`debugger-watchpoints-list`
|

 .. _debugger-command-wplist:

wplist
------

|  **wplist**
|
|  O comando "*wplist*" lista todos os watchpoints atuais, junto com o seu indexador e quaisquer condições anexadas a eles.
|
| Voltar para :ref:`debugger-watchpoints-list`
|
