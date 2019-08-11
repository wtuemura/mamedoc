.. _debugger-cheats-list:

Comandos para o depurador de trapaça
====================================


Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-cheatinit` -- inicializa uma pesquisa de trapaça na região da memória selecionada
| :ref:`debugger-command-cheatrange` -- adiciona uma região da memória a pesquisa de trapaça selecionada
| :ref:`debugger-command-cheatnext` -- continua a pesquisa de uma trapaça comparando-a com o último valor
| :ref:`debugger-command-cheatnextf` -- continua a pesquisa de uma trapaça comparando-a com o primeiro valor
| :ref:`debugger-command-cheatlist` -- mostra uma lista de pesquisa de trapaças que tiveram correspondências ou salve-as em um nome de arquivo <filename>
| :ref:`debugger-command-cheatundo` -- desfaz a última pesquisa de trapaça (estado apenas)
|
 .. _debugger-command-cheatinit:

cheatinit
---------

|  **cheatinit** [<*sign*><*width*><*swap*>,[<*address*>,<*length*>[,<*cpu*>]]]
|
| O comando **cheatinit** inicializa uma pesquisa da trapaça na região da memória selecionada.
|
| Se nenhum parâmetro for definido para a trapaça a pesquisa é inicializada em toda a memória intercambiável do CPU principal.
|
| **<sign>** pode ser **s(signed)** ou **u(unsigned)**
| **<width>** pode ser **b(8 bit)**, **w(16 bit)**, **d(32 bit)** ou **q(64 bit)**
| **<swap>** acrescenta **s** para a pesquisa de troca
|
| Exemplos:
|
|  ``cheatinit ub,0x1000,0x10``
|
| Inicializa a pesquisa de trapaça de **0x1000** para **0x1010** do primeiro CPU.
|
|  ``cheatinit sw,0x2000,0x1000,1``
|
| Inicializa a pesquisa de trapaça com uma largura de **2 bytes** em modo **signed** de **0x2000** para **0x3000** do segundo CPU.
|
|  ``cheatinit uds,0x0000,0x1000``
|
| Inicializa a pesquisa de trapaça com uma largura de **4 bytes** trocados de **0x0000** para **0x1000**.
|
| Back to :ref:`debugger-cheats-list`
|

 .. _debugger-command-cheatrange:

cheatrange
----------

|  **cheatrange** <*address*>,<*length*>
|
| O comando "*cheatrange*" reserva uma regiçao da memóra para que seja feita a pesquisa da trapaça.
|
| Antes de usar o "*cheatrange*" é necessário inicializar a pesquisa da trapaça com "*cheatinit*".
|
| Exemplos:
|
|  ``cheatrange 0x1000,0x10``
|
| Adiciona os bytes de **0x1000** para **0x1010** na pesquisa da trapaça.
|
| Back to :ref:`debugger-cheats-list`
|

 .. _debugger-command-cheatnext:

cheatnext
---------

|  **cheatnext** <*condition*>[,<*comparisonvalue*>]
|
| O comando "*cheatnext*" faz comparações com as últimas pesquisas coincidentes.
|
| Condição possível <*condition*>:
|
|  **all** (**todas**)
|
| Nenhum valor de comparação <*comparisonvalue*> é necessário.
|
| Use para atualizar o último valor sem mudar o os valores já encontrados.
|
|  **equal [eq]**
|
| Sem o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que são iguais aos da última pesquisa.
| Com o valor de comparação <*comparisonvalue*> onde todos os bytes sejam iguais com o valor de comparação <*comparisonvalue*>.
|
|  **notequal [ne]**
|
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que não sejam iguais a última pesquisa.
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que não são iguais ao valor de comparação <*comparisonvalue*>.
|
|  **decrease [de, +]**
|
| Sem o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que tiveram seu valor diminuído desde a última pesquisa.
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que tenham diminuído em comparação com o valor de comparação <*comparisonvalue*> desde a última pesquisa.
|
|  **increase [in, -]**
|
| Sem o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que tenham aumentando desde a última pesquisa.
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que tenham aumentado em comparação com o valor de comparação <*comparisonvalue*> desde a última pesquisa.
|
|  **decreaseorequal [deeq]**
|
| Nenhum valor de comparação <*comparisonvalue*> é necessário.
|
| Pesquise que todos os bytes que tenham diminuído ou tenham o mesmo valor desde a última pesquisa.
|
|  **increaseorequal [ineq]**
|
| Nenhum valor de comparação <*comparisonvalue*> é necessário.
|
| Pesquise que todos os bytes que tenham diminuído ou tenham o mesmo valor desde a última pesquisa.
|
|  **smallerof [lt]**
|
| Sem o valor de comparação <*comparisonvalue*> essa condição é inválida
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que são menores que o valor de comparação <*comparisonvalue*>.
|
|  **greaterof [gt]**
|
| Sem o valor de comparação <*comparisonvalue*> essa condição é inválida
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que são maiores que o valor de comparação <*comparisonvalue*>.
|
|  **changedby [ch, ~]**
|
| Sem o valor de comparação <*comparisonvalue*> essa condição é inválida
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que tenham mudado através do valor de comparação <*comparisonvalue*> desde a última pesquisa
|
|
| Exemplos:
|
|  ``cheatnext increase``
|
| Pesquise por todos os bytes que tenham aumentado desde a última pesquisa
|
|  ``cheatnext decrease, 1``
|
| Pesquise por todos os bytes que tenham diminuído por 1 desde a última pesquisa
|
| Back to :ref:`debugger-cheats-list`
|

 .. _debugger-command-cheatnextf:

cheatnextf
----------

|  **cheatnextf** <*condition*>[,<*comparisonvalue*>]
|
| O comando "*cheatnextf*" fará comparações com a pesquisa inicial.
|
| Condição possível <*condition*>:
|
|  **all** (**todas**)
|
| Nenhum valor de comparação <*comparisonvalue*> é necessário.
|
| Use para atualizar o último valor sem mudar o os valores já encontrados.
|
|  **equal [eq]**
|
| Sem o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que são iguais ao valor pesquisa inicial
| Com o valor de comparação <*comparisonvalue*> onde todos os bytes sejam iguais com o valor de comparação <*comparisonvalue*>.
|
|  **notequal [ne]**
|
| Sem o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que não são iguais ao valor pesquisa inicial
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que não são iguais ao valor de comparação <*comparisonvalue*>.
|
|  **decrease [de, +]**
|
| Sem o valor de comparação <*comparisonvalue*> Pesquise por todos os bytes que tenham diminuído desde o último valor pesquisa inicial
| Com o valor de comparação <*comparisonvalue*> Pesquise por todos os bytes que tenham diminuído pelo valor de comparação <*comparisonvalue*> desde o último valor pesquisa inicial.
|
|  **increase [in, -]**
|
| Sem o valor de comparação <*comparisonvalue*> Pesquise por todos os bytes que tenham diminuído desde a pesquisa inicial.
|
| Com o valor de comparação <*comparisonvalue*> Pesquise por todos os bytes que tenham aumentado pelo valor de comparação <*comparisonvalue*> desde a pesquisa inicial.
|
|  **decreaseorequal [deeq]**
|
| Nenhum valor de comparação <*comparisonvalue*> é necessário.
|
| Pesquise por todos os bytes que tenham diminuído ou tenha o mesmo valor da pesquisa inicial.
|
|  **increaseorequal [ineq]**
|
| Nenhum valor de comparação <*comparisonvalue*> é necessário.
|
| Pesquise por todos os bytes que tenham diminuído ou tenha o mesmo valor da pesquisa inicial.
|
|  **smallerof [lt]**
|
| Sem o valor de comparação <*comparisonvalue*> essa condição é inválida.
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que são menores que o valor de comparação <*comparisonvalue*>.
|
|  **greaterof [gt]**
|
| Sem o valor de comparação <*comparisonvalue*> essa condição é inválida.
| Com o valor de comparação <*comparisonvalue*> pesquise por todos os bytes que são maiores que o valor de comparação <*comparisonvalue*>.
|
|  **changedby [ch, ~]**
|
| Sem o valor de comparação <*comparisonvalue*> essa condição é inválida
| Com o valor de comparação <*comparisonvalue*> Pesquise por todos os bytes que tenham mudado pelo valor de comparação <*comparisonvalue*> desde a pesquisa inicial.
|
|
| Exemplos:
|
|  ``cheatnextf increase``
|
| Pesquise por todos os bytes que tenham aumentado desde a pesquisa inicial.
|
|  ``cheatnextf decrease, 1``
|
| Pesquise por todos os bytes que tenham diminuído 1 byte desde a pesquisa inicial.
|
| Back to :ref:`debugger-cheats-list`
|

 .. _debugger-command-cheatlist:

cheatlist
---------

|  **cheatlist** [<*filename*>]
|
| Sem o nome de arquivo <*filename*> mostre a lista de coincidentes no console de depuração.
| Com o nome de arquivo <*filename*> salve a lista de coincidentes em formato XML básico para o nome do arquivo <*filename*>.
|
| Exemplos:
|
|  ``cheatlist``
|
| Mostra as coincidências atuais no console de depuração.
|
|  ``cheatlist cheat.txt``
|
| Salve todas as coincidências atuais em formato XML no arquivo **cheat.txt**.
|
| Back to :ref:`debugger-cheats-list`
|

 .. _debugger-command-cheatundo:

cheatundo
---------

|  **cheatundo**
|
| Desfaz os resultados da última pesquisa.
|
| O comando desfazer não afeta o último valor.
|
|
| Exemplos:
|
|  ``cheatundo``
|
| desfaz a última pesquisa (apenas do estado).
|
| Back to :ref:`debugger-cheats-list`
|
