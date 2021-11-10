.. raw:: latex

	\clearpage

As convenções de nomenclaturas usadas pelo MAME
===============================================

.. contents:: :local:

.. raw:: latex

	\clearpage


.. _naming-intro:

Introdução
----------

Visando promover a consistência e a legibilidade no código-fonte do
MAME, utilizamos algumas convenções de nomenclatura em diversos
elementos.


.. _naming-definitions:

Definições
----------

.. tabularcolumns:: |\Y{0.15}|\Y{0.23}|\Y{0.35}|

.. list-table:: As convenções utilizadas no código-fonte do MAME
    :header-rows: 0
    :stub-columns: 0

    * - **Snake Case**
      - snake_case
      - Tudo é escrito em minúsculas e as palavras são separadas por
        sublinhados.
    * - **Screaming Snake Case**
      - ESTOU_GRITANDO
      - Tudo é escrito em maiúsculas e as palavras são separadas por
        sublinhados.
    * - **Camel Case**
      - exemploCamelCase
      - As palavras ou frases são escritas sem espaço onde o início de
        cada palavra começa com a letra em maiúsculas, menos a primeira.
    * - **Llama Case**
      - ExemploLlamaCase
      - As palavras ou frases são escritas sem espaço onde o início de
        cada palavra começa com a letra em maiúsculas.


.. _naming-transliteration:

Transliteração
--------------

O script amplamente mais conhecido no mundo é o Alfabeto Latino que
também é chamado de Alfabeto Romano. Convenientemente, também está
incluído na codificação de quase todos os caracteres.  Para tornar o
MAME mais acessível globalmente, nós requisitamos que as transliterações
dos títulos e dos outros metadados vindos a partir dos outros scripts
sejam feitas com o Alfabeto Latino. Não use traduções nos metadados, as
traduções são inerentemente sujeitas a erros e interpretações erradas.
As traduções podem ser incluídas nos comentários caso sejam úteis.

Em geral, caso um nome oficial da escrita latina for conhecido, este
deve ser utilizado em favor de uma simples transliteração. Para os
títulos contendo estrangeirismos e palavras emprestadas de outros
idiomas, a grafia latina convencional deve ser usada (um exemplo prático
disso é usar "Mahjong" nos títulos japoneses em vez de "Maajan").

.. raw:: latex

	\clearpage

**Chinês**

	Onde o público alvo fale Mandarim, o **Hanyu Pinyin** deve ser
	usado. Dentro dos contextos onde diacríticos não são permitidos
	(quando for limitado ao ASCII por exemplo), os números dos tons
	devem ser omitidos. Quando os tons estão sendo indicados por
	diacríticos, as regras do **Sandhi** de tom devem ser aplicados.
	Onde o público alvo fale Cantonês (principalmente Hong Kong e
	Guandong), o **Jyutping** deve ser usado com a omissão dos números
	de tom. Na dúvida, utilize o **Hanyu Pinyin**.

**Grego**

	Utilize as regras **ISO: type (TR)**.  Não utilize o inglês
	tradicional nas grafias para os nomes gregos (pessoas ou lugares).

**Japonês**

	Em geral as regras alteradas **Hepburn** devem ser utilizadas. Use
	um apóstrofo entre o **N** silábico e uma vogal seguinte (incluindo
	as vogais iotizadas). Não use hífens para transliterar vogais
	prolongadas.

**Coreano**

	Para os sobrenomes Coreanos utilize as regras revisadas da
	romanização Coreana (RR) com as tradicionais da ortografia Inglesa.
	Não use regras ALA LC para a divisão das palavras e uso de hífens.

**Vietnamita**

	Quando os diacríticos não podem ser utilizados, omita os tons e
	substitua as vogais com simples vogais em Inglês, não utilize as
	convenções **VIQR** ou **TELEX** (``"um chuot nuong"`` em vez de
	``"a(n chuo^.t nu*o*'ng"`` ou ``"awn chuootj nuowngs"`` por
	exemplo).


.. _naming-titles:

Os títulos e as descrições
--------------------------

Tente reproduzir o título original de forma mais fiel possível sempre
que houver a possibilidade. Tente preservar a convenção das maiúsculas e
das minúsculas utilizada pelo fabricante ou distribuidor. Caso nenhum
título oficial em Alfabeto Latino seja conhecido, use uma transliteração
padrão.
Para as entradas na lista de software onde uma transliteração é usada
para a descrição do elemento (atributo ``description``), coloque o
título num elemento de informação (atributo ``info``) com um atributo
``name="alt_title"``.

Para os itens de software que possuam diferentes títulos (diferentes
títulos separados por região com a mesma mídia de instalação por
exemplo), utilize um título em Alfabeto Latino para o elemento da
descrição (atributo ``description``) e coloque os outros títulos nos
elementos de informação (atributo ``info``) com atributos
``name = "alt_title"``.

Caso uma desambiguação seja necessária, tente ser o mais descritivo
possível. Use o número da versão do fabricante, o nome do licenciado
regional ou faça uma descrição concisa entre as diferenças do hardware
com preferência aos números dos conjuntos arbitrários por exemplo.
Cerque o texto de desambiguação entre parênteses, preserve a caixa
original para os nomes e o texto da versão, porém use minúsculas para
qualquer outra coisa exceto os nomes próprios e os acrônimos.

.. raw:: latex

	\clearpage


.. _naming-cplusplus:

Convenções de nomenclatura para C++
-----------------------------------

**Macros do pré-processador**

	Os nomes das macros devem usar o **screaming snake case**.
	As macros são sempre globais e os nomes conflitantes podem causar
	erros, pense com cuidado sobre o que as macros precisam ser nos
	cabeçalhos e as nomeie de acordo.

**Include guards**

	A inclusão das *guard macros* devem começar com ``MAME_`` e devem
	terminar com um uma versão em maiúsculas do nome do arquivo, com
	espaços sendo substituídos por sublinhados.

**Constantes**

	As constantes devem usar o **screaming snake case**, sejam elas
	constantes globais, membros de dados constantes, enumeradores ou
	pré-processadores constantes.

**Funções**

	Os nomes de funções livres devem usar o **snake case**. Existem
	alguns utilitários funções que foram implementadas anteriormente
	como macros dos pré-processadores que ainda usam o **screaming snake
	case**.

**Classes**

	Os nomes das classes devem usar um **snake case**. Os nomes de
	classes abstratas devem terminar com ``_base``. Os membro de funções
	públicas (incluindo funções de membro estático) devem usar o **snake
	case**.

**As Classes dos dispositivos**

	Os nomes específicos da implementação do ``driver_device``
	convencionalmente termina com ``_state``, enquanto a outra classe do
	nome do dispositivo específico terminar com ``_device``. Os nomes
	específico do ``device_interface`` convencionalmente começam com
	``device_`` e terminam com ``_interface``.

**Os tipos dos dispositivos**

	Os tipos dos dispositivos devem usar **screaming snake case**.
	Lembre-se que os tipos dos dispositivos são nomes dentro do
	namespace global, então escolha de forma explícita, nomes unívocos
	e diretos.

**As enumerações**

	O nome da enumeração deve usar maiúsculas e minúsculas. Os
	enumeradores devem usar **screaming snake case**.

**Os parâmetros usados como modelo**

	Os parâmetros usados como modelo devem usar maiúsculas e minúsculas
	(ambos os parâmetros de tipo e de valor).
