.. raw:: latex

	\clearpage

.. _contributing-softlist:

Diretrizes para os catálogos de programas
=========================================

.. contents:: :local:


.. _contributing-softlist-intro:

Introdução
----------

Os |cdps| do MAME descrevem o programa em mídia
conhecido para os sistemas emulados de uma maneira que pode ser usada
para identificar arquivos conhecidos da imagem de um programa em mídia,
para verificar a integridade da imagem do arquivo e para carregar os
arquivos da imagem para serem emulados. Os |cdps| são
implementadas como arquivos XML na pasta ``hash``. A estrutura XML é
descrita no arquivo ``hash/softwarelist.dtd``.

Filosoficamente, os itens do |cdp| devem representar a
mídia original, em vez de uma cópia específica da mídia. Idealmente,
deve ser possível para qualquer pessoa com a mídia fazer um *dump*
(cópia) dela e produzir uma imagem idêntica encontrada no catálogo.
Claro, isso nem sempre é possível na prática, principalmente, é
problemático em mídias inerentemente analógicas, como um programa de
computador doméstico armazenado em fitas cassete.

O MAME se esforça para documentar as melhores imagens disponíveis das
mídias. Não é nossa intenção propagar imagens corrompidas, truncadas,
desfiguradas, com marcas d'água ou de outra forma, ruins. Sempre que
possível, são preferidas as estruturas correspondentes do arquivo à
estrutura da mídia original. Por exemplo, preferimos arquivos
individuais para os chips ROM separados na mídia do cartucho e usamos
as imagens do disco original em vez de arquivos extraídos dos mesmo
discos.


.. _contributing-softlist-itempart:

Itens e partes
--------------

Um |cdp| é uma coleção de itens e cada item pode ter várias partes. Um
item representa um pedaço do programa, distribuído como um pacote
completo. Outra parte representa uma única peça de mídia dentro do
pacote. As peças podem ser montadas individualmente nos dispositivos
emulados da mídia. Por exemplo, um programa distribuído em três
disquetes por exemplo, será listado como um único item, enquanto cada
disquete será uma parte deste item.

Às vezes, partes logicamente separadas de uma única mídia física são
representadas como partes separadas num item do programa. Por exemplo,
cada lado de uma fita cassete é representado como uma parte separada.
No entanto, os chips ROM individuais dentro de um cartucho, podem ser
arquivos separados, mas não são partes separadas, pois o cartucho é
montado como um todo.

.. raw:: latex

	\clearpage

Cada item é um elemento ``software``. O elemento ``software`` pode ter
os seguintes atributos:

**name** (obrigatório)

    Um nome curto que identifica o item. É usado para os nomes dos
    arquivos, argumentos da linha de comando, chaves do banco de dados,
    fragmentos de URL dentre outros. Deve ser conciso, porém
    reconhecível. Deve ser o único dentro da lista de programa. Os
    caracteres válidos são letras minúsculas do inglês, dígitos decimais
    e sublinhados. O comprimento máximo permitido é de dezesseis
    caracteres.

**cloneof** (opcional)

    O nome abreviado do item principal caso o item seja um clone. O
    principal deve estar no mesmo |cdp|, programas associados ao
    clone/principal espalhados em vários |cdps| não são suportados.

**supported** (opcional)

    Um dos valores ``yes`` (totalmente utilizável na emulação), ``no``
    (não utilizável na emulação) ou ``partial`` (utilizável na emulação
    com certas limitações). Caso o atributo não esteja presente, é o
    equivalente ao ``yes``. Exemplos de programas com suporte parcial
    incluem jogos que podem ser reproduzidos com falhas gráficas e
    programas de escritório onde algumas, mas nem todas as
    suas funcionalidades, funcionam.

Cada ``part`` é um elemento interna do elemento ``software``. O
elemento ``part`` deve ter os seguintes atributos:

**name** (obrigatório)

    Um nome abreviado que identifica a parte. Isso é usado para
    argumentos da linha de comando, chaves do banco de dados,
    fragmentos de URL dentre outros. Deve ser único dentro do item. Ele
    também é usado como o nome de exibição caso um nome de exibição
    separado não seja definido. Os caracteres válidos são letras
    minúsculas do inglês, dígitos decimais e sublinhados. O comprimento
    máximo permitido é de dezesseis caracteres.

**interface** (obrigatório)

    Este atributo é usado para identificar a mídia dos dispositivos
    emulados que são adequados para montar uma parte do programa. Os
    valores aplicáveis dependem do sistema que está sendo emulado.


.. _contributing-softlist-metadata:

Metadados
---------

Os |cdps| suportam vários tipos de metadados. Todos os itens do |cdp|
requerem a presença dos seguintes elementos de metadados:

**description**

    Este é o nome principal do item para exibição do programa. Deve ser
    o nome original do programa, transliterado para o alfabeto latino
    inglês, caso seja necessário. Deve ser único dentro do |cdp|. Caso
    o texto extra, além do próprio título, seja necessário para
    desambiguação, use letras minúsculas fora dos nomes próprios,
    inicialismos e citações literais.

**year**

    O ano do lançamento ou o ano dos direitos autorais do programa. Caso
    seja desconhecido, use uma estimativa com um ponto de interrogação.
    Os itens podem ser filtrados por ano no menu da seleção do programa.

.. raw:: latex

	\clearpage

**publisher**

    A produtora do programa. Isso pode ser o mesmo que o desenvolvedor
    caso o programa seja auto-publicado. Os itens podem ser filtrados
    pela publicação no menu da seleção do programa.

A maioria dos metadados dos itens visíveis do programa ao usuário é
fornecida usando elementos ``info``. Cada elemento ``info`` deve ter um
atributo ``name`` e um atributo ``value``. O atributo ``name``
identifica o tipo dos metadados e o atributo ``value`` é o próprio valor
dos metadados. Observe que os atributos ``name`` não precisam ser
exclusivos num item. Vários elementos ``info`` com o mesmo nome podem
estar presentes, caso seja apropriado. Isso é visto com frequência em
programas vendidos com títulos diferentes e em regiões diferentes.

Prefira vários elementos ``info`` com o mesmo atributo ``name`` em vez
de combinar vários valores em um único elemento. Por exemplo, se um
programa suporta vários idiomas de interface do usuário, use vários
elementos ``info`` com atributos ``name="language"``. Isso torna a
filtragem e as consultas ao banco de dados muito mais práticas.

O MAME exibe os metadados dos elementos ``info`` no menu de seleção do
programa. Os seguintes atributos ``name`` são especificamente
identificados e podem mostrar nomes localizados:

**alt_title**

    Usado para títulos alternativos. Exemplos são diferentes blocos
    usados em diferentes idiomas, scripts, regiões ou diferentes títulos
    usados na tela de título e na embalagem. O MAME pesquisa os títulos
    alternativos, bem como a descrição.

**author**

    O autor do programa. Os itens podem ser filtrados pelo autor no
    menu da seleção do programa.

**barcode**

    O número do código de barras que identifica o pacote do programas
    (normalmente um EAN).

**developer**

    o desenvolvedor responsável pela implementação do programa. Os itens
    podem ser filtrados pelo desenvolvedor no menu da seleção do
    programa.

**distributor**

    Parte responsável pela distribuição do programa aos varejistas (ou
    os clientes no caso de vendas diretas). Os itens podem ser filtrados
    pelo distribuidor no menu da seleção do programa.

**install**

    Instruções de instalação.

**isbn**

    O código ISBN incluso num livro disponível comercialmente.

**language**

    O idioma da interface compatível com o programa.

**oem**

    O fabricante original do equipamento, normalmente usado com versões
    personalizadas do programa e  distribuídas por um fornecedor de
    hardware.


.. raw:: latex

	\clearpage


**original_publisher**

    A produtora original, para os itens que representam o programa que foi
    relançado por uma produtora diferente.

**partno**

    O número da peça do distribuidor do programa.

**pcb**

    O identificador da placa de circuito impresso, tipicamente usado para as mídias em cartucho.

**programmer**

    O nome do programador que fez a programação do programa.

**release**

    A data de lançamento detalhada do programa, caso seja conhecida. Use
    o formato ``AAAAMMDD`` sem pontuação. Se apenas o mês for conhecido,
    use ``xx`` para os dígitos do dia, como ``199103xx`` ou
    ``19940729``.

**serial**

    O número que identifica o programa dentro de uma série de versões.

**usage**

    Instruções de uso.

**version**

    O número da versão do programa.

.. |cdp| replace:: catálogo de programa
.. |cdps| replace:: catálogos de programas
