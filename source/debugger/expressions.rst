.. _debugger-expressions-list:

Guia de expressões do depurador
===============================


As expressões podem ser usadas em qualquer lugar onde um parâmetro
numérico for esperado. A sintaxe das expressões está muito próxima da
sintaxe do estilo C padrão com ordenação completa do operador e
parênteses.
Existem alguns operadores faltando (principalmente o operador trinário
?:) e alguns novos "acessadores de memória". A tabela abaixo lista todos
os operadores em sua ordem, os operadores de primeira prioridade vem
primeiro.

|
|
|
| ``( ) :`` parênteses padrão
| ``++ -- :`` incremento/decremento do postfix
| ``++ -- ~ ! - + b@ w@ d@ q@ :`` prefixo inc/dec, binário NOT, lógico NOT, unário +/-, acesso à memória
| ``* / % :`` multiplicar, dividir, módulo
| ``+ - :`` adicionar, subtrair
| ``<< >> :`` deslocar para a esquerda/direita
| ``< <= > >= :`` menor que, menor que ou igual, maior que, maior que ou igual
| ``== != :`` igual, não igual
| ``& :`` binário AND
| ``^ :`` binário XOR
| ``| :`` bibinárionary OR
| ``&& :`` lógica AND
| ``|| :`` lógica OR
| ``= \*= /= %= += -= <<= >>= &= \|= ^= :`` atribuição
| ``, :`` termos separados, parâmetros de função
|

Números
-------

Os números são prefixados de acordo com suas bases:

- Números hexadecimais (base 16) são prefixados com :code:`$` ou :code:`0x`.

- Números decimais (base 10) são prefixados com :code:`#`

- Os números octais (base 8) são prefixados com :code:`0o`.

- Números binários (base 2) são prefixados com :code:`0b`.

- Números não pré-fixados são hexadecimais (base 16).

Exemplos:

- :code:`123` é um hexadecimal 123 (decimal 291).

- :code:`$123` é um hexadecimal 123 (decimal 291).

- :code:`0x123` é um hexadecimal 123 hexadecimal (decimal 291).

- :code:`#123` é um decimal 123.

- :code:`0o123` é um octal 123 (decimal 83).

- :code:`0b1001` é um decimal 9.

- :code:`0b123` é inválido.

Diferenças dos comportamentos C
-------------------------------


- Primeiro, toda matemática é executada em valores full 64-bit unsigned,
  então coisas como **a < 0** não funcionam como esperado.

- Segundo, os operadores lógicos **&&** e **||** não possuem
  propriedades short-circuit e as duas metades são sempre avaliadas.

- Finalmente, os novos operadores de memória funcionam assim:

- **b!<addr>** se refere ao byte <*addr*> e *NÃO* se suprime os efeitos
  colaterais, como ler uma mailbox, remover o sinalizador pendente ou ao ler um FIFO, remover um item.

- **b@** se refere ao byte <*addr*> no momento em que se suprime os
  efeitos colaterais.

- Da mesma forma, **w@** e **w!** referem-se a um *word* na memória,
  **d@** e **d!** referem-se a um *dword* na memória, e **q@** e **q!**
  referem-se a um *qword* na memória.

- Os operadores de memória podem ser usados como *lvalues* e *rvalues*,
  então você pode escrever **b\@100 = ff** para armazenar um byte na
  memória. É predefinido que esses operadores leiam a partir do espaço
  de memória do programa, mas você pode sobrescrevê-los prefixando-os
  com um 'd' ou um 'i'.

- Como tal, **dw\@300** refere-se à palavra de memória de dados no
  endereço 300 e **id\@400** referem-se a memória de I/O.
