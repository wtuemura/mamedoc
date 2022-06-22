.. raw:: latex

	\clearpage


.. _debugger-cheats-list:

Comandos para depuração de trapaça
==================================

.. note::

    **Pesquisa** é quando se deseja levantar mais informações sobre algo
    desconhecido. **Busca** é quando se deseja levantar informações
    sobre algo que já se sabe.

.. line-block::

    :ref:`debugger-command-cheatinit`
        Inicializa uma pesquisa da trapaça na região selecionada da memória.
    :ref:`debugger-command-cheatrange`
        Adiciona uma região selecionada da memória para a pesquisa da trapaça.
    :ref:`debugger-command-cheatnext`
        Filtra os candidatos da trapaça ao comparar com os valores anteriores.
    :ref:`debugger-command-cheatnextf`
        Filtra os candidatos da trapaça ao comparar com os valores iniciais.
    :ref:`debugger-command-cheatlist`
        Mosta a lista das trapaças que tiveram correspondências ou salve-os num arquivo.
    :ref:`debugger-command-cheatundo`
        Desfaz a última trapaça que foi buscada (estado apenas).

O depurador inclui uma funcionalidade simples de busca por trapaça que
funciona salvando o conteúdo da memória e depois filtrando os locais de
acordo com a maneira que os valores se alteram.

Demonstraremos o uso da funcionalidade da busca por uma trapaça de
vida infinita para o sistema **Raiden** (``raiden``):

* Inicie o jogo com o depurador ativo (``mame raiden -window -debug``).
  Na **janela do depurador** pressione :kbd:`F5` para que o jogo rode e
  clique na **janela do jogo**. Insira um crédito com :kbd:`5` e inicie
  a partida pressionando a tecla :kbd:`1`, entre no depurador clicando
  na tecla :kbd:`"` ou :kbd:`'` (fica do lado esquerdo da tecla :kbd:`1`
  ou consulte :ref:`o mapa do teclado <default-comparative-kbd>`).
* Clique na **janela do depurador**, tenha certeza que a *CPU* principal
  ``:maincpu`` esteja visível no topo da janela do depurador, inicie uma
  pesquisa por valores 8-bit sem assinatura usando o comando
  :ref:`cheatinit command <debugger-command-cheatinit>`, digite o
  comando na parte debaixo da janela do depurador seguido da tecla
  :kbd:`Enter`::

      >cheatinit ub
      36928 cheat locations initialized for NEC V30 ':maincpu' program space

* Pressione :kbd:`F5` para que o jogo continue, clique na **janela do
  jogo** e perca 1 vida, pressione novamente a tecla :kbd:`"` para
  interromper o jogo, clique na **janela do depurador**.
* Use o comando :ref:`cheatnext command <debugger-command-cheatnext>`
  para filtrar as localizações onde o valor tenha sido reduzido por 1::

      >cheatnext -,1
      19 cheats found

* Pressione :kbd:`F5` para que o jogo continue novamente, clique na
  **janela do jogo** e perca mais 1 vida, novamente pressione a tecla
  :kbd:`"`, clique na **tela do depurador** e repita o comando
  anterior::

      >cheatnext -,1
      Address=00B85 Start=03 Current=01
      1 cheats found

* Use o comando :ref:`cheatlist <debugger-command-cheatlist>` para
  salvar o endereço encontrado num arquivo na pasta principal do MAME::

      >cheatlist raiden-j1-vidas.xml

* O arquivo terá um fragmento em formato XML com o endereço e todos os
  valores encontrados para a trapaça:

  .. code-block:: XML

      <cheat desc="Possibility 1: 00B85 (01)">
        <script state="run">
          <action>:main*CPU*.pb@0x00B85=0x03</action>
        </script>
      </cheat>


 .. _debugger-command-cheatinit:

cheatinit
---------

**cheatinit** [[<*sinalização*>[<*largura*>[<*ordem*>]]],[<*endereço*>,<*comprimento*>[,<*espaço*>]]]

Inicia a busca pela trapaça nas áreas da *RAM* que possam ser escritas na
região do endereços indicado. Pode ser abreviado para ``ci``.

O primeiro argumento determina o formato do dado que será buscado. A
<*sinalização*> (*sign*) pode ser ``u`` para sem assinatura (*unsigned*)
ou ``s`` para assinado, <*largura*> (*width*) pode ser ``b`` para 8-bit
(byte), ``w`` para **16-bit** (*word*), ``d`` para **32-bit** (*double
word*) ou ``q`` para **64-bit** (*quadruple word*); <*ordem*> (*swap*)
pode ser ``s`` para um byte com a ordem invertida. Quando o primeiro
argumento for omitido ou estiver vazio, será usado o formato do dado da
busca anterior ou um formato com **8-bit** sem assinatura caso este seja
o formato usado na primeira busca.

O <*endereço*> (*address*) determina o endereço para o inicio da
pesquisa e o <*comprimento*> (*length*) determina a quantidade da
memória que será utilizada para esta pesquisa.

Caso seja definido, será pesquisada a *RAM* gravável no intervalo do
<*endereço*> até o <*endereço*>+<*comprimento*>-1; caso contrário, toda
a *RAM* gravável será pesquisada na faixa do endereço.

Consulte :ref:`debugger-devicespec` para mais detalhes em como
determinar a |fde|. Caso a região do endereço não seja
definido, ele retorna para a primeira |fde| que for exposto pela
primeira *CPU* que estiver visível.

Exemplos:

.. line-block::

    ``cheatinit ub,0x1000,0x10``
        Inicializa a busca pela trapaça com valores **8-bit** sem assinatura nos endereços ``0x1000``-``0x100f`` na região do programa visível da *CPU*.
    ``cheatinit sw,0x2000,0x1000,1``
        Inicializa a busca pela trapaça com valores **16-bit** com assinatura nos endereços ``0x2000``-``0x2fff`` na região do programa visível pela 2ª *CPU* do sistema (num índice com base zero).
    ``cheatinit uds,0x0000,0x1000``
        Inicializa a busca pela trapaça com valores **64-bit** sem assinatura com a ordem invertida dos bytes nos endereços ``0x0000``-``0x0fff`` |nrvd|.

|ret| :ref:`debugger-cheats-list`.


 .. _debugger-command-cheatrange:

cheatrange
----------

**cheatrange** <*endereço*>,<*comprimento*>

Acrescente as áreas da *RAM* que podem ser escritas na busca por trapaças.
Pode ser abreviado para ``cr``. Antes de utilizar este comando, o
comando :ref:`cheatinit <debugger-command-cheatinit>` deve ser utilizado
para inicializar a busca pela trapaça, para definir o espaço do
endereçamento e o formato dos dados.

O <*endereço*> determina o endereço a partir de onde a busca deve
começar, o <*comprimento*> determina a quantidade de memória que se
deseja pesquisar. A *RAM* gravável na faixa <*endereço*> até
<*endereço*>+<*comprimento*>-1, será adicionada às áreas que serão
pesquisadas.

Exemplos:

.. line-block::

    ``cheatrange 0x1000,0x10``
        Adiciona os endereços ``0x1000``-``0x100f`` nas regiões para a busca das trapaças.

|ret| :ref:`debugger-cheats-list`.


 .. _debugger-command-cheatnext:

cheatnext
---------

**cheatnext** <*condição*>[,<*valor_para_comparação*>]

Faz o filtro dos candidatos comparando com os valores das buscas
anteriores. Caso restem cinco ou menos candidatos, eles serão mostrados
no console de depuração. Este comando pode ser abreviado para ``cn``.

Argumentos possíveis para <*condição*>:

.. line-block::

    ``all``
        Use para atualizar o último valor sem alterar as correspondências atuais (o <*valor_para_comparação*> não é usado).
    ``equal`` (``eq``)
        Sem o <*valor_para_comparação*>, procure pelos valores que sejam iguais a pesquisa anterior; com o <*valor_para_comparação*>, busque pelos valores que sejam iguais ao <*valor_para_comparação*>.
    ``notequal`` (``ne``)
        Sem o <*valor_para_comparação*>, pesquise pelos valores que não sejam iguais a pesquisa anterior; com o <*valor_para_comparação*>, busque pelos valores que não sejam iguais ao <*valor_para_comparação*>.
    ``decrease`` (``de``, ``-``)
        Sem o <*valor_para_comparação*>, pesquise pelos valores que foram reduzidos desde a pesquisa anterior; com o <*valor_para_comparação*>, busque por valores que diminuíram com base no <*valor_para_comparação*> desde a última pesquisa.
    ``increase`` (``in``, ``+``)
        Sem o <*valor_para_comparação*>, pesquise pelos valores que aumentaram desde a pesquisa anterior; com o <*valor_para_comparação*>, busque por valores que aumentaram com base no <*valor_para_comparação*> desde a última pesquisa.
    ``decreaseorequal`` (``deeq``)
        Busca pelos valores que foram reduzidos ou que não tenham se alterado desde a pesquisa anterior (o <*valor_para_comparação*> não é usado).
    ``increaseorequal`` (``ineq``)
        Busca pelos valores que tenham aumentado ou que não tenham se alterado desde a pesquisa anterior (o <*valor_para_comparação*> não é usado).
    ``smallerof`` (``lt``, ``<``)
        Busca pelos valores que sejam menores que o <*valor_para_comparação*> (o <*valor_para_comparação*> é obrigatório).
    ``greaterof`` (``gt``, ``>``)
        Busca pelos valores que sejam maiores que o <*valor_para_comparação*> (o <*valor_para_comparação*> é obrigatório).
    ``changedby`` (``ch``, ``~``)
        Busca pelos valores que tenham se alterado com base no <*valor_para_comparação*> desde a pesquisa anterior (o <*valor_para_comparação*> é obrigatório).


Exemplos:

.. line-block::

    ``cheatnext increase``
        Busca todos os valores que tenham aumentado desde a pesquisa anterior.
    ``cheatnext decrease,1``
        Busca todos os valores que foram reduzidos por ``1`` desde a pesquisa anterior.

|ret| :ref:`debugger-cheats-list`.


 .. _debugger-command-cheatnextf:

cheatnextf
----------

**cheatnextf** <*condição*>[,<*valor_para_comparação*>]

Faz o filtro dos candidatos comparando com os valores iniciais das
buscas. Caso restem cinco ou menos candidatos, eles serão mostrados
no console de depuração. Pode ser abreviado para ``cnf``.

Argumentos possíveis para <*condição*>:

.. line-block::

    ``all``
        Use para atualizar o último valor sem alterar as correspondências atuais (o <*valor_para_comparação*> não é usado).
    ``equal`` (``eq``)
        Sem o <*valor_para_comparação*>, procure pelos valores que sejam iguais a pesquisa inicial; com o <*valor_para_comparação*>, busque pelos valores que sejam iguais ao <*valor_para_comparação*>.
    ``notequal`` (``ne``)
        Sem o <*valor_para_comparação*>, pesquise pelos valores que não sejam iguais a pesquisa inicial; com o <*valor_para_comparação*>, busque pelos valores que não sejam iguais ao <*valor_para_comparação*>.
    ``decrease`` (``de``, ``-``)
        Sem o <*valor_para_comparação*>, pesquise pelos valores que foram reduzidos desde a pesquisa inicial; com o <*valor_para_comparação*>, busque por valores que diminuíram com base no <*valor_para_comparação*> desde a última pesquisa.
    ``increase`` (``in``, ``+``)
        Sem o <*valor_para_comparação*>, pesquise pelos valores que aumentaram desde a pesquisa inicial; com o <*valor_para_comparação*>, busque por valores que aumentaram com base no <*valor_para_comparação*> desde a última pesquisa.
    ``decreaseorequal`` (``deeq``)
        Busca pelos valores que foram reduzidos ou que não tenham se alterado desde a pesquisa inicial (o <*valor_para_comparação*> não é usado).
    ``increaseorequal`` (``ineq``)
        Busca pelos valores que tenham aumentado ou que não tenham se alterado desde a pesquisa inicial (o <*valor_para_comparação*> não é usado).
    ``smallerof`` (``lt``, ``<``)
        Busca pelos valores que sejam menores que o <*valor_para_comparação*> (o <*valor_para_comparação*> é obrigatório).
    ``greaterof`` (``gt``, ``>``)
        Busca pelos valores que sejam maiores que o <*valor_para_comparação*> (o <*valor_para_comparação*> é obrigatório).
    ``changedby`` (``ch``, ``~``)
        Busca pelos valores que tenham se alterado com base no <*valor_para_comparação*> desde a pesquisa anterior (o <*valor_para_comparação*> é obrigatório).

Exemplos:

.. line-block::

    ``cheatnextf increase``
        Busca todos os valores que tenham aumentado desde a pesquisa inicial.
    ``cheatnextf decrease,1``
        Busca todos os valores que foram reduzidos por ``1`` desde a pesquisa inicial.

|ret| :ref:`debugger-cheats-list`.


 .. _debugger-command-cheatlist:

cheatlist
---------

**cheatlist** [<*nome_do_arquivo*>]

Sem o <*nome_do_arquivo*>, mostre as trapaças encontradas no momento no
console do depurador; com o <*nome_do_arquivo*>, salve as trapaças
encontradas num formato XML para o arquivo determinado. Pode ser
abreviado para ``cl``.

Exemplos:

.. line-block::

    ``cheatlist``
        Mostra o que foi encontrado no console.
    ``cheatlist cheat.xml``
        Grava o que foi encontrado no arquivo ``cheat.xml`` em formato XML.

|ret| :ref:`debugger-cheats-list`.


 .. _debugger-command-cheatundo:

cheatundo
---------

**cheatundo**

Desfaz o filtro da trapaça pelo mais recente comando
:ref:`cheatnext <debugger-command-cheatnext>` ou 
:ref:`cheatnextf <debugger-command-cheatnextf>`. Observe que os valores
anteriores **não** retrocedem. Pode ser abreviado com ``cu``.

Exemplos:

.. line-block::

    ``cheatundo``
        Restaura os candidatos filtrados pelo comando :ref:`cheatnext <debugger-command-cheatnext>` ou :ref:`cheatnextf <debugger-command-cheatnextf>` mais recente.

|ret| :ref:`debugger-cheats-list`.

.. |ret| replace:: Retorna para
.. |fde| replace:: faixa de endereços
.. |nrvd| replace:: na região visível do programa na CPU
