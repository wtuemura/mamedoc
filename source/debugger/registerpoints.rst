.. _debugger-registerpoints-list:

Comandos registerpoints do depurador
====================================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-rpset` -- define um registerpoint para disparar com uma condição <*condition*>
| :ref:`debugger-command-rpclear` -- limpa todos ou um determinado registerpoint se nenhum <*rpnum*> for especificado
| :ref:`debugger-command-rpdisable` -- desabilita todos ou um determinado registerpoint se nenhum <*rpnum*> for especificado
| :ref:`debugger-command-rpenable` -- habilita todo ou um determinado registerpoint se nenhum <*rpnum*> for especificado
| :ref:`debugger-command-rplist` -- lista todos os registerpoints
|

 .. _debugger-command-rpset:

rpset
-----

|  **rp[set]** {<*condition*>}[,<*action*>]]
|
| Define um novo registerpoint que será disparado quando a condição <*condition*> for atingida. A condição deve ser definida entre chaves para evitar que a condição seja avaliada como uma atribuição.
| O parâmetro opcional de ação <*action*> fornece um comando que é executado sempre que o registerpoint for atingido. Observe que você pode precisar incorporar a ação entre chaves **{ }** para evitar que as vírgulas e os pontos e vírgulas sejam interpretados como se aplicassem ao próprio comando "*rpset*".
| Cada registerpoint que for definido é designado a um índice que pode ser usado em outros comandos registerpoint para referenciar este registerpoint.
|
| Exemplos:
|
|  ``rp {PC==0150}``
|
| Define um registerpoint que interromperá a execução sempre que o registrador PC for igual a **0x150**.
|
|  ``temp0=0; rp {PC==0150},{temp0++; g}``
|
| Define um registerpoint que irá incrementar a variável **temp0** sempre que o registrador PC for igual a **0x150**.
| Define um registerpoint que interromperá a execução sempre que a variável **temp0** for igual a **5**.
|
| Voltar para :ref:`debugger-registerpoints-list`
|

 .. _debugger-command-rpclear:

rpclear
-------

|  **rpclear** [<*rpnum*>]
|
| O comando "*rpclear*" limpa um registerpoint. Caso o <*rpnum*> seja definido, apenas o registerpoint solicitado é limpo, caso contrário, todos os registerpoints serão limpos.
|
| Exemplos:
|
|  ``rpclear 3``
|
| Limpa o **indexador 3** do registerpoint.
|
|  ``rpclear``
|
| Limpa todos os registerpoints.
|
| Voltar para :ref:`debugger-registerpoints-list`
|

 .. _debugger-command-rpdisable:

rpdisable
---------

|  **rpdisable** [<*rpnum*>]
|
| O comando "*rpdisable*" desativa um registerpoint. Caso o <*rpnum*> seja especificado, somente o registerpoint solicitado é desabilitado, caso contrário, todos os registerpoint são desativados. Note que desabilitar um registerpoint ele não é apagado, o registerpoint fica registrado temporariamente como inativo.
|
| Exemplos:
|
|  ``rpdisable 3``
|
| Desabilita o **indexador 3** do registerpoint.
|
|  ``rpdisable``
|
| Desabilita todo os registerpoints.
|
| Voltar para :ref:`debugger-registerpoints-list`
|

 .. _debugger-command-rpenable:

rpenable
--------

|  **rpenable** [<*rpnum*>]
|
| O comando "*rpenable*" habilita um registerpoint. Caso o <*rpnum*> seja especificado, somente o registerpoint solicitado é ativado, caso contrário, todos os registerpoint serão habilitados.
|
| Exemplos:
|
|  ``rpenable 3``
|
| Habilita o **indexador 3** do registerpoint.
|
|  ``rpenable``
|
| Habilita todos os registerpoints.
|
| Voltar para :ref:`debugger-registerpoints-list`
|

 .. _debugger-command-rplist:

rplist
------

|  **rplist**
|
| O comando "*rplist*" lista todos os registerpoints atuais, juntamente com o seu índice e quaisquer ações anexadas à elas.
|
| Voltar para :ref:`debugger-registerpoints-list`
|
