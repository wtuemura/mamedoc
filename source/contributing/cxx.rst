.. _contributing-cxx:

Diretriz de programação em C++
==============================

.. contents:: :local:


.. _contributing-cxx-intro:

Introdução
------------

**Em termos de convenções de programação, o estilo presente no arquivo
de código-fonte deve ser favorecido em relação aos padrões encontrados
abaixo.**

Ao criar um novo arquivo dentro do núcleo do MAME (**src/emu** e
**src/lib**), as seguintes convenções de programação devem ser
observadas quando um novo código-fonte está sendo criado. Caso o
código-fonte esteja fora do núcleo, deve-se dar deferência ao estilo
preferido do contribuidor, embora seja fortemente encorajado a programar
entendendo que o arquivo pode precisar ser compreensível por outras
pessoas com o tempo.


.. raw:: latex

	\clearpage


.. _contributing-cxx-definitions:

Definições
----------

**Snake case**

    Tudo é escrito em minúsculas e os espaços são substituídos por
    sublinhados: ``como_neste_exemplo``

**Screaming snake case**

    Tudo é escrito em minúsculas e os espaços são substituídos por
    sublinhados: ``COMO_NESTE_EXEMPLO``

**Camel case**

    As palavras ou AS frases são escritas sem espaço onde o início de
    cada palavra começa com a letra em maiúsculas, menos a primeira:
    ``comoNesteExemplo``

**Llama case**

    As palavras as ou frases são escritas sem espaço entre as palavras e
    onde o início de cada palavra começa com a primeira letra em
    maiúsculas: ``ComoNesteExemplo``


.. _contributing-cxx-fileformat:

Formato do arquivo de código-fonte
----------------------------------

Os arquivos C++ de código-fonte do MAME estão no formato de texto
**UTF-8**, com caracteres de largura fixa e paradas de tabulação em
intervalos de quatro espaços. Os arquivos de código-fonte devem terminar
com um sinal de fim de linha. Nos comentários, é permitido qualquer
texto *"unicode"* válido e imprimível. Somente o subconjunto
*"Unicode ASCII"* imprimível é permitido em comentários e textos
externos.

A ferramenta **srcclean** é usada para impor regras de formatação ao
arquivo de código-fonte antes de cada lançamento. É possível compilar
essa ferramenta e aplicá-la aos arquivos alterados antes de abrir uma
solicitação *"pull"*, evitando assim conflitos ou alterações inesperadas.


.. _contributing-cxx-naming:

Convenção de nomenclatura
-------------------------

**Macros do pré-processador**

    Os nomes das macros devem usar o **screaming snake case**.
    As macros são sempre globais e os nomes conflitantes podem causar
    erros, portanto pense com cuidado sobre o que as macros devem conter
    nos cabeçalhos e as nomeie de acordo.

**Include guards**

    A inclusão das *guard macros* deve começar com ``MAME_`` e terminar
    com o nome do arquivo em maiúsculas, com espaços substituídos por
    sublinhados.

**Constantes**

    As constantes devem usar o **screaming snake case**, sejam elas
    globais, membros de dados, enumeradores ou pré-processadores.

**Funções**

    Os nomes de funções livres devem usar o **snake case**. Embora
    existam algumas funções utilitárias que foram implementadas
    anteriormente como macros dos pré-processadores, elas ainda usam o
    **screaming snake case**.

.. raw:: latex

	\clearpage

**Classes**

    Os nomes das classes devem usar um **snake case**. Os nomes de
    classes abstratas devem terminar com ``_base``. Os membros de
    funções públicas (incluindo funções de membro estático) devem
    utilizar o **snake case**.

**As Classes dos dispositivos**

    Os nomes específicos da implementação do ``driver_device``
    convencionalmente terminam com ``_state``, enquanto os nomes das
    outras classes terminam com ``_device``. Os nomes específico da
    ``device_interface`` convencionalmente começam com ``device_`` e
    terminam com ``_interface``.

**Os tipos dos dispositivos**

    Os tipos dos dispositivos devem usar **screaming snake case**.
    Lembre-se de que os tipos de dispositivos são nomes dentro do
    namespace global, portanto escolha nomes explícitos, nomes unívocos
    e diretos.

**As enumerações**

    O nome da enumeração deve usar maiúsculas e minúsculas. Os
    enumeradores devem usar **screaming snake case**.

**Os parâmetros usados como modelo**

    Os parâmetros usados como modelo devem usar letras maiúsculas e
    minúsculas (tanto o tipo quanto o valor).

Os identificadores que tenham dois sublinhados consecutivos ou que
comecem com um sublinhado seguido de uma letra maiúscula, estão sempre
reservados e não podem ser usados.

Os nomes do tipo e os outros identificadores com um sublinhado à
esquerda, devem ser evitados no espaço de nomes globais (*namespace*),
pois são reservados de forma explícita de acordo com o padrão C++. Além
disso, os identificadores sufixados com ``_t`` devem ser evitados dentro
do espaço de nomes globais, pois eles também são reservados segundo os
padrões POSIX. Embora o MAME viole esta política ocasionalmente,
principalmente com ``device_t``, trata-se de uma decisão infeliz que foi
herdada e que deve ser evitada em todo e qualquer novo código.


.. _contributing-cxx-literals:

Variáveis e literais
--------------------

O uso de literais octais é desencorajado fora de casos bem específicos.
Eles não possuem os prefixos óbvios com base em letras encontrados nas
literais hexadecimais e nos binárias, portanto, podem ser difíceis de
distinguir rapidamente de um literal decimal para codificadores que não
estão familiarizados com a notação octal.

É preferido utilizar os literais hexadecimais em minúsculas, por
exemplo, ``0xbadc0de`` em vez de ``0xBADC0DE``. Para maior clareza,
tente não exceder a largura de bits da variável que será utilizada para
armazená-lo.

Os literais binários raramente são usados no código-fonte do MAME, pois
o prefixo ``0b`` não é padronizado até o C++14, mas não há nenhuma
política para evitar a sua utilização.

A notação de sufixo inteiro deve ser usada ao especificar literais de
64 bits, mas não é estritamente necessária em outros casos. No entanto,
é possível deixar claro rapidamente o uso pretendido de um determinado
literal. Os longos sufixos literais inteiros em maiúsculas devem ser
utilizados para evitar confusão com o dígito ``1``, por exemplo, ``7LL``
em vez de ``7ll``.

O agrupamento de dígitos deve ser usado para literais numéricos mais
longos, pois ajuda a reconhecer a ordem de magnitude ou as posições do
campo de bits mais rapidamente. Os literais decimais devem usar grupos
com três dígitos e os literais hexadecimais devem usar grupos com quatro
dígitos, exceto em situações específicas onde diferentes agrupamentos
seriam mais fáceis de entender, como em ``4'433'619`` ou
``0xfff8'1fff``.

Os tipos que não possuam um tamanho especificamente definido, devem ser
evitados caso sejam registrados no sistema *"save-state*" do MAME, pois
isso prejudica a portabilidade. Em geral, isso significa evitar o uso de
``int`` para esses membros.

É recomendável, porém não obrigatório, que os membros dos dados da
classe sejam prefixados com ``m_`` para membros com instância não
estáticas e ``s_`` para membros estáticos. Isso não se aplica a classes
ou estruturas aninhadas.


.. _contributing-cxx-braceindent:

Contraventamento e indentação
-----------------------------

As tabulações são usadas para o recuo inicial das linhas, com uma
tabulação usada por nível de escopo agrupado. As declarações que forem
divididas em várias linhas devem ser recuadas por duas tabulações. Os
espaços são usados para alinhamento em outros locais dentro de uma
linha.

É preferível que a órtese seja no estilo **K&R** ou no estilo
**Allman**. Não há uma preferência específica para os colchetes nas
instruções com linha única, embora o colchete deva ser consistente num
determinado bloco ``if/else``, conforme é mostrado abaixo:

.. code-block:: C++

    if (x == 0)
    {
        return;
    }
    else
    {
        call_some_function();
        x--;
    }

Ao utilizar uma série de blocos
``if``/``else`` ou ``if``/``else if``/``else`` com comentários no recuo
superior, evite adicionar novas linhas. O uso de novas linhas
pode fazer com que os blocos ``else if`` ou ``else`` sejam perdidos,
pois as novas linhas podem empurrá-los para fora da altura visível do
editor:

.. code-block:: C++

    // O início do seu contador hipotético acabou.
    if (x == 0)
    {
        return;
    }
    // Devemos fazer algo se o contador estiver em execução.
    else
    {
        call_some_function();
        x--;
    }

A indentação para as instruções ``case`` dentro de um corpo ``switch``
pode estar no mesmo nível que a instrução ``switch`` ou um nível acima.
Não há um estilo específico utilizado em todos os principais arquivos,
embora o recuo de um nível pareça ser mais frequente.


.. _contributing-cxx-spacing:

Espaçamento
-----------

É veementemente recomendado o espaçamento simples e consistente entre os
operadores binários, as variáveis e os literais. Os exemplos a seguir
exibem um espaçamento relativamente consistente:

.. code-block:: C++

    uint8_t foo = (((bar + baz) + 3) & 7) << 1;
    uint8_t foo = ((bar << 1) + baz) & 0x0e;
    uint8_t foo = bar ? baz : 5;

Os exemplos a seguir exibem extremos em qualquer direção, embora seja
menos difícil ter espaços adicionais do que ter poucos:

.. code-block:: C++

    uint8_t foo = ( ( ( bar + baz ) + 3 ) & 7 ) << 1;
    uint8_t foo = ((bar<<1)+baz)&0x0e;
    uint8_t foo = (bar?baz:5);

Por exemplo, um espaço deve ser usado entre uma instrução C++
fundamental e o seu parêntese de abertura:

.. code-block:: C++

    switch (value) ...
    if (a != b) ...
    for (int i = 0; i < foo; i++) ...


.. _contributing-cxx-scoping:

Escopo
------

O escopo das variáveis deve ser o mais restrito possível. Embora existam
muitas declarações das instâncias da variável local no estilo C89 na
base do código do MAME, isso é em grande parte um resquício dos
primeiros dias do MAME, que antecedem a especificação C99.

Os dois trechos a seguir mostram o estilo legado da declaração da
variável local, seguido pelo estilo mais moderno e recomendado:

.. code-block:: C++

    void dispositivo_exemplo::alguma_funcao()
    {
        int i;
        uint8_t data;

        for (i = 0; i < std::size(m_buffer); i++)
        {
            data = m_buffer[i];
            if (data)
            {
                alguma_outra_funcao(data);
            }
        }
    }

.. code-block:: C++

    void dispositivo_exemplo::alguma_funcao()
    {
        for (int i = 0; i < std::size(m_buffer); i++)
        {
            const uint8_t data = m_buffer[i];
            if (data)
            {
                alguma_outra_funcao(data);
            }
        }
    }

Os valores enumerados, ``structs`` e as classes usadas apenas por um
dispositivo específico, devem ser declarados dentro da própria classe do
dispositivo. Isso evita a poluição do *"namespace"* global e torna o
uso específico do dispositivo mais evidente à primeira vista.


.. _contributing-cxx-const:

Const Correctness
-----------------

Historicamente, a correção *const* não foi um requisito estrito do
código que entra no MAME, mas há um valor crescente nisso à medida que a
quantidade de refatoração do código aumenta e a dívida técnica diminui.

Ao escrever um novo código, vale a pena dedicar um tempo para determinar
se uma variável local pode ser declarada como ``const``. Assim como para
considerar quais as funções de um novo membro de uma nova classe
podem ser qualificadas como ``const``.

Da mesma forma, as matrizes de constantes devem ser declaradas como
``constexpr`` e devem usar o *Screaming Snake Case*, conforme descrito
no início deste documento. Por fim, ambas as *arrays* de strings no
estilo C devem ser declaradas como *array const* das *strings const*,
assim:

.. code-block:: C++

    static const char *const NOMES_EXEMPLO[4] =
    {
        "1-bit",
        "2-bit",
        "4-bit",
        "Invalid"
    };


.. _contributing-cxx-comments:

Comentários
-----------

Embora ``/* os comentários em ANSI C */`` sejam frequentemente
encontrados na base do código, houve uma transição gradual para
o estilo de ``// comentários C++`` nos casos de comentários em uma única
linha. Isso é basicamente uma diretriz, e os programadores são
encorajados a usar o estilo que for mais confortável.

A menos que citem especificamente o conteúdo de uma máquina ou materiais
auxiliares, os comentários devem ser em inglês para corresponder ao
idioma predominante entre a equipe do MAME e ser compreensível para
todos ao redor do mundo.

O código comentado normalmente deve ser removido antes de criar um
*pull request*, pois há uma tendência de ficar obsoleto devido à
natureza de rápida movimentação da API principal do MAME. Se houver a
intenção conhecida de que o código eventualmente será incluído,
ele deve ser marcado como ``if (0)`` ou ``if (false)``, pois o código
removido por meio de uma macro do pré-processador ficará obsoleto com a
mesma velocidade.


.. _contributing-cxx-helpers:

Auxiliares específicos do MAME
------------------------------

Sempre que possível, use funções auxiliares e macros para operações de
manipulação dos bits.

A função auxiliar ``BIT(valor, bit)`` pode ser usada para extrair o
estado de um bit em uma determinada posição específica de um valor
inteiro. O valor resultante será alinhado à posição do bit de menor
importância, ou seja, assumirá o valor ``0`` ou ``1``.

Uma sobrecarga da mesma função, ``BIT(valor, bit, largura)`` pode ser
usada para extrair um bit do campo de uma determinada largura de um
valor inteiro, começando na posição do bit determinado. O resultado
também será justificado à direita e terá o mesmo tipo de dado que o
valor da entrada.

Há, adicionalmente, uma série de auxiliares para funcionalidades como
a contagem de zeros/uns à esquerda, para a contagem populada e para a 
multiplicação e a divisão de números inteiros assinados/não assinados
nos resultados de 32 bits ou 64 bits. Nem todos esses auxiliares têm
amplo uso no código-base do MAME, mas usá-los num novo código é
altamente recomendável quando o código for crítico para questões de
desempenho, pois eles utilizam a montagem *"inline"* ou recursos
intrínsecos do compilador por plataforma, quando estiverem disponíveis.

``count_leading_zeros_32/64(T value)``

    Aceita um valor não assinado de 32 ou 64 bits e retorna um valor não
    assinado de 8 bits contendo a quantidade de zeros consecutivos a
    partir do bit mais importante.

``count_leading_ones_32/64(T value)``

    A funcionalidade é idêntica à da anterior, porém, examinando um bit
    consecutivo.

``population_count_32/64(T value)``

    Aceita um valor de 32 ou 64 bits não assinado e retorna a quantidade
    de bits encontrada, ou seja, o peso *Hamming* do valor.

``rotl_32/64(T value, int shift)``

    Ele executa um deslocamento circular/barril à esquerda de um valor
    não assinado de 32 ou 64 bits usando um valor de deslocamento
    determinado. O valor do deslocamento será mascarado para se integrar
    no intervalo válido de bits para um valor de 32 ou 64 bits.

``rotr_32/64(T value, int shift)``

    A funcionalidade é idêntica à da anterior, porém, com o deslocamento
    à direita.

Para documentação sobre os auxiliares relacionados à multiplicação e à
divisão, consulte o ``src/osd/eminline.h``.

.. raw:: latex

	\clearpage


.. _contributing-cxx-logging:

Registrando
-----------

O MAME possui diversas funções de registro para diferentes propósitos.
Duas das funções de registro de log mais utilizadas são o ``logerror``
e o ``osd_printf_verbose``:

* Os dispositivos herdam a função de membro ``logerror``. Isso inclui
  automaticamente a *tag* totalmente qualificada do dispositivo que
  invoca as mensagens de registro. A saída é enviada para o registro log
  rotativo do *buffer* do depurador do MAME, caso o depurador esteja
  ativado. Se a :ref:`opção -log <mame-commandline-log>` estiver
  ativada, o registro também será feito no arquivo ``error.log`` dentro do
  diretório de trabalho. Se a
  :ref:`opção -oslog <mame-commandline-oslog>` estiver ativada, ela
  também será enviada para a saída de diagnóstico do sistema operacional
  (o registro de diagnóstico do host do depurador do Windows, caso um
  host de depuração esteja conectado ou, caso contrário, usa o modo de
  erro padrão).
* A saída da função ``osd_printf_verbose`` é enviada para o modo de erro
  padrão caso a :ref:`opção -verbose <mame-commandline-verbose>` esteja
  ativada.

A função ``osd_printf_verbose`` deve ser usada para fazer o registro que
é muito útil no diagnóstico de problemas do usuário, enquanto o
``logerror`` deve ser usado para mensagens mais relevantes aos
desenvolvedores (durante o desenvolvimento do próprio MAME ou
ao desenvolver programas para sistemas emulados usando o depurador do
próprio MAME).

Para o registro da depuração, existe um sistema baseado em um canal
por meio do cabeçalho ``logmacro.h``. Ele pode ser usado como um
sistema de registro genérico, sem a necessidade de usar a sua capacidade
de mascarar canais específicos da seguinte maneira:

.. code-block:: C++

    // Todos os outros cabeçalhos no arquivo .cpp devem estar acima desta linha.
    #define VERBOSE (1)
    #include "logmacro.h"
    ...
    void some_device::some_reg_write(u8 data)
    {
        LOG("%s: some_reg_write: %02x\n", machine().describe_context(), data);
    }

O exemplo acima também faz uso de uma função auxiliar que está
disponível em todas as que sejam derivadas de
``device_t``: ``machine().describe_context()``. Essa função retornará
uma *string* que descreve o contexto da emulação em que a função está
sendo executada. Isso inclui a *tag* totalmente qualificada do
dispositivo que está atualmente em execução (se houver). Se o
dispositivo relevante implementar um ``device_state_interface``, ele
também incluirá o valor do contador do programa atual relatado pelo
dispositivo.

Para um controle mais refinado, as máscaras dos bits específicos podem
ser definidas e usadas por meio da macro ``LOGMASKED``:

.. code-block:: C++

    // Todos os outros cabeçalhos no arquivo .cpp devem estar acima desta linha.
    #define LOG_FOO (1 << 1U)
    #define LOG_BAR (1 << 2U)

    #define VERBOSE (LOG_FOO | LOG_BAR)
    #include "logmacro.h"
    ...
    void some_device::some_reg_write(u8 data)
    {
        LOGMASKED(LOG_FOO, "some_reg_write: %02x\n", data);
    }

    void some_device::another_reg_write(u8 data)
    {
        LOGMASKED(LOG_BAR, "another_reg_write: %02x\n", data);
    }

Observe que a posição do bit menos importante para as máscaras
informadas pelo usuário é ``1``, pois a posição do bit ``0`` é reservada
para o ``LOG_GENERAL``.

É predefinido que ``LOG`` e o ``LOGMASKED`` usarão a função ``logerror``
fornecida pelo dispositivo. No entanto, isso pode ser alterado
conforme seja necessário. O caso de uso mais comum seria direcionar a
saída para a saída padrão, o que pode ser feito definindo explicitamente
o ``LOG_OUTPUT_FUNC`` da seguinte maneira:

.. code-block:: C++

    #define LOG_OUTPUT_FUNC osd_printf_info

Um desenvolvedor deve sempre garantir que a opção ``VERBOSE`` esteja
definida como ``0`` e que qualquer definição de ``LOG_OUTPUT_FUNC`` seja
comentada antes de abrir um *"pull request"*.


.. _contributing-cxx-structure:

Organização estrutural
----------------------

Todos os arquivos de código-fonte C++ devem começar com dois comentários
listando a licença de distribuição e os detentores dos direitos autorais
num formato padronizado. As licenças são especificadas por meio de seu
identificador *SPDX* curto, caso esteja disponível. Abaixo, um exemplo
do formato padrão:

.. code-block:: C++

    // license:BSD-3-Clause
    // copyright-holders:David Haywood, Tomasz Slanina

Os cabeçalhos incluídos geralmente devem ser agrupados do mais
dependente ao menos dependente e classificados alfabeticamente dentro
dos seus respectivos grupos:

* O cabeçalho do prefixo do projeto, ``emu.h``, deve ser a primeira
  coisa numa unidade de tradução.
* Cabeçalhos locais do projeto (cabeçalhos que estão junto com os
  arquivos de código-fonte por exemplo).
* Para os cabeçalhos em ``src/devices``.
* Para os cabeçalhos em ``src/emu``.
* Para os cabeçalhos em ``src/lib/util``.
* Para os cabeçalhos da camada *OSD*.
* Para os cabeçalhos predefinidos da biblioteca C++.
* Para os cabeçalhos específicos do sistema operacional.
* Para os cabeçalhos *layout*.

Por fim, os cabeçalhos específicos da tarefa, como o ``logmacro.h``
descrito na seção anterior, devem ser incluídos por último. Abaixo
segue um exemplo prático:

.. code-block:: C++

    #include "emu.h"

    #include "cpu/m68000/m68000.h"
    #include "machine/mc68328.h"
    #include "machine/ram.h"
    #include "sound/dac.h"
    #include "video/mc68328lcd.h"
    #include "video/sed1375.h"

    #include "emupal.h"
    #include "screen.h"
    #include "speaker.h"

    #include "pilot1k.lh"

    #define VERBOSE (0)
    #include "logmacro.h"

Na maioria dos casos, a declaração da classe para um controlador do
sistema, deve estar junto no arquivo de código-fonte correspondente à
implementação. Nesses casos, a declaração da classe e todo o conteúdo do
arquivo de código-fonte, exceto as macros ``GAME``, ``COMP`` ou
``CONS``, devem ser colocados num *namespace* anônimo (o que produz
melhores diagnósticos do compilador, permite uma otimização mais
agressiva, reduz a chance de símbolos duplicados e também reduz o tempo
de lincagem).

Dentro de uma declaração da classe, deve haver uma seção para cada nível
de acesso do membro (``public``, ``protected`` e ``private``) quando for
possível. Isso pode não ser possível em casos onde as constantes e/ou os
tipos privados precisam ser declarados antes dos membros públicos. Os
membros devem usar o menor nível de acesso público necessário. As
funções do membro virtual substituído, geralmente devem usar o mesmo
nível de acesso que a função do membro correspondente da classe base.

As declarações da classe dos membros devem ser agrupadas para auxiliar
na sua compreensão:

* Dentro de uma seção de nível de acesso dos membros, devem ser
  agrupados constantes, tipos, membros de dados, funções do membro da
  instância e funções estáticas do membro.
* Nas classes dos dispositivos, as funções de configuração do membro
  devem ser agrupadas separadamente das funções de sinal ativo do
  membro.
* As funções virtuais do membro que forem substituídas, devem ser
  agrupadas de acordo com as classes base das quais elas forem herdadas.

Para as classes sobrecarregadas com diversos construtores, a delegação
do construtor deve ser usada sempre que possível, visando evitar listas
repetidas dos inicializadores dos membros.

As constantes que são usadas por um controlador (*driver*) de
dispositivo ou de máquina, devem estar na forma de valores
enumerados com tamanho explícito dentro da declaração da classe ou ser
relegadas a macros ``#define`` dentro do arquivo fonte. Isso ajuda a
evitar a poluição do pré-processador.
