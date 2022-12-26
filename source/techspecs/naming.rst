.. raw:: latex

	\clearpage

.. _naming:

As convenções das nomenclaturas usadas pelo MAME
================================================

.. contents:: :local:

.. raw:: latex

	\clearpage


.. _naming-intro:

Introdução
----------

Visando promover a consistência e a legibilidade no código-fonte do
MAME, utilizamos algumas convenções de nomenclatura em diversos
elementos.


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

Para as convenções das nomenclaturas C++, consulte a seção da diretriz
de programação em C++ :ref:`contributing-cxx-naming`.
