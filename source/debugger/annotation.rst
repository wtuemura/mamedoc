.. _debugger-annotation-list:

Comandos de anotação de código do depurador
===========================================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-comadd` -- Inclui um comentário ao código desmontado em um determinado endereço
| :ref:`debugger-command-comdelete` -- remove o comentário de um determinado endereço
| :ref:`debugger-command-comsave` -- salva o comentário atual em um arquivo
| :ref:`debugger-command-comlist` -- imprime os comentários disponíveis de um arquivo
| :ref:`debugger-command-commit` -- aplica um comadd e depois comsave


 .. _debugger-command-comadd:

comadd
------

|  **comadd[//]** <*address*>,<*comment*>
|
| Inclui uma string <*comment*> ao código desmontado em <*address*>. O atalho para este comando é só '//'
|
| Exemplos:
|
|  ``comadd 0, hello world.``
|
| Inclui o comentário 'hello world.' ao código no endereço **0x0**
|
|  ``// 10, opcode não documentado!``
|
| Inclui o comentário 'opcode não documentado!' ao código no endereço **0x10**


 .. _debugger-command-comdelete:

comdelete
---------

|  **comdelete**
|
| Apaga o comentário em um offset determinado da memória. O comentário que é excluído está no banco de memória ativo no momento.
|
| Exemplos:
|
|  ``comdelete 10``
|
| Apaga o comentário do código no endereço **0x10** (usando as configurações do banco atual de memória)


 .. _debugger-command-comsave:

comsave
-------

|  **comsave**
|
| Salva as observações de trabalho no arquivo de comentário XML do driver.
|
| Exemplos:
|
|  ``comsave``
|
| Salva os comentários no arquivo de comentários do driver


 .. _debugger-command-comlist:

comlist
-------

|  **comlist**
|
| Imprime o comentário atual disponível em formato legível para humanos na janela de saída do depurador.
|
| Exemplos:
|
|  ``comlist``
|
| Mostra os comentários disponíveis atualmente.


 .. _debugger-command-commit:

commit
------

|  **commit[/*]** <*address*>,<*comment*>
|
| Inclui uma string <*comment*> ao código desmontado no <*address*> e salva num arquivo. Basicamente é o mesmo que comadd + comsave em uma única linha.
| O atalho para este comando é ``\'\/\*\'``
|
| Exemplos:
|
|  ``commit 0, hello world.``
|
| Inclui o comentário 'hello world.' ao código no endereço **0x0**
|
|  ``// 10, undocumented opcode!``
|
| Inclui o comentário 'opcode não documentado!' ao código no endereço **0x10**

