Software de renderização 3D no MAME
===================================

.. contents:: :local:


.. _poly_manager-history:

Introdução
----------

No final dos anos 80 muitos jogos arcade começaram a incorporar vídeo
com gráficos 3D renderizados através de um hardware dedicado. Estes
gráficos 3D são tipicamente renderizados a partir de elementos de baixo
nível numa memória intermediária (buffer) (geralmente um buffer duplo ou
triplo), depois talvez combinados com *tilemaps* ou sprites comuns antes
de serem apresentados ao jogador.

Se tratando da emulação de jogos 3D no geral há duas abordagens. A
primeira seria aproveitar o hardware 3D atual e traduzir os elementos de
baixo nível para formatos equivalentes ao hardware mais modernos. No
caso de um emulador de plataforma compartilhada como o MAME, é preciso
ter uma API flexível o suficiente para descrever com precisão todos os
elementos e todas e as suas respectivas ações. É preciso também que o
emulador seja capaz de obter os dados do quadro do buffer que foi
renderizado (uma vez que diversos jogos já fazem isso) para então fazer
a combinação com outros elementos de uma maneira que a sincronização
seja devidamente efetuada em conjunto com a renderização de fundo.

Alternativamente, seria possível renderizar os elementos de baixo nível
diretamente através de software. A grande vantagem é poder simular
praticamente qualquer comportamento, assim como é feito pelo hardware
original ao custo da perda de desempenho. No MAME assim como em toda
emulação, isso acontece numa única tarefa o que acaba penalizando o
desempenho final. Entretanto, assim como é feita na abordagem com o
hardware 3D físico, teoricamente, uma abordagem com base em software
poderia ser distribuída para outras tarefas para aliviar o esforço extra
desde que houvessem mecanismos para sincronizar tudo quando fosse
preciso, por exemplo, ao ler e ao escrever os quadros diretamente a
partir de e para o buffer.

O MAME por enquanto usa a segunda abordagem, aproveitando a assistência
do modelo de uma classe chamada **poly_manager** para lidar com
situações triviais.


.. raw:: latex

	\clearpage

.. _poly_manager-concept:

O conceito
----------

O princípio do **poly_manager** é ser um mecanismo para dar suporte à
renderização multi-tarefa dos elementos 3D de baixo nível. As chamadas
fornecem ao **poly_manager** um conjunto de *vértices* para um elemento
e mais um retorno do renderizador. O **poly_manager** quebra o elemento
em extensões ao longo da linha de varredura e distribui o trabalho entre
um conjunto das *tarefas*. O renderizador então é designado na tarefa de
cada extensão que está sendo trabalhada onde a lógica específica do jogo
pode fazer o que for preciso para que os dados sejam renderizados.

A principal responsabilidade do **poly_manager** é garantir a ordem.
Dado um conjunto das tarefas e da quantidade de trabalho dos objetos
que serão concluídos, por isso a importância que ao menos dentro de uma
determinada linha de varredura, todo o trabalho seja realizado em
sequência e na ordem certa. A abordagem seria então atribuir cada
extensão a um *contêiner* (*bucket*) com referência na coordenada Y.
Assim o **poly_manager** garante que apenas uma tarefa seja realizada
por vez e também seja responsável pelo processamento do trabalho num
determinado contêiner.

Os vértices no **poly_manager** consistem em simples coordenadas 2D X e
Y, incluindo zero ou mais parâmetros adicionais de iteração. Estes
parâmetros podem ser qualquer coisa: os valores da intensidade de
iluminação; as cores RGB(A) para o shader Gouraud; coordenadas U, V
padronizadas para o mapeamento da textura; valores 1/Z para o buffer Z;
etc. A iteração dos parâmetros independentemente do que eles
representam, são interpolados de forma linear através do elemento no
espaço da tela e disponibilizados como parte da extensão da chamada de
retorno da tela.


.. _poly_manager-objecttype:

ObjectType
~~~~~~~~~~

Ao criar uma classe **poly_manager**, você deve definir um tipo especial
denominado **ObjectType**.

Como a renderização acontece de forma assíncrona nas tarefas, a ideia é
que a classe **ObjectType** tenha uma imagem com todos as informações
relevantes para a renderização.
Isto permite que a tarefa principal continue, alterando potencialmente
alguns dos estados mais relevantes enquanto a renderização acontece em
outro lugar.

Em teoria, poderíamos alocar uma nova classe **ObjectType** para cada
primitivo da renderização 3D, contudo, seria bastante ineficiente. É bem
comum definir o estado da renderização e depois renderizar vários
primitivos 3D usando o mesmo estado.

Por esta razão, o **poly_manager** mantém uma matriz interna dos objetos
**ObjectType** e mantém uma cópia do último **ObjectType** que foi
utilizado. Antes de enviar um novo elemento, os responsáveis pela
chamada podem ver se o estado da renderização se alterou. Em caso
positivo, é possível pedir ao **poly_manager** para alocar uma nova
classe **ObjectType** e preenchê-la. Quando o primitivo 3D é encaminhado
para a renderização, a instância mais recente do **ObjectType** é
capturada de forma implícita e disponibilizada para as chamadas de
retorno da renderização.

Nos cenários mais complexos onde os dados podem se alterar de maneira
menos constante, há um modelo semelhante ao **poly_array** que pode ser
usado no gerenciamento dos dados. O **poly_manager** interno utiliza a
classe **poly_array** no gerenciamento das suas alocações
**ObjectType**. Mais informações sobre a classe **poly_array** serão
fornecidas mais tarde.


.. raw:: latex

	\clearpage

.. _poly_manager-primitives:

Primitivos 3D
~~~~~~~~~~~~~

O **poly_manager** é compatível com diferentes tipos de primitivos 3D:

* O elemento mais utilizado pelo **poly_manager** é o *triângulo*, pois
  tem a propriedade onde os parâmetros iterativos têm deltas constantes
  através de toda a sua superfície.
  Ambos também são compatíveis, os *os leques do triângulo* com
  comprimento arbitrário e as *faixas do triângulo*.

* Em adição aos triângulos o **poly_manager** também é compatível com
  *polígonos* com uma quantidade arbitrária de vértices. É esperado que
  a lista dos vértices esteja em ordem horária e anti-horária.
  O **poly_manager** analisará os limites para computar os deltas
  através de cada extensão.

* Um caso especial da compatibilidade do **poly_manager** é o primitivo
  *tile* que é um único *quad* definido por dois vértices, um vértice na
  diagonal superior esquerda e outro na diagonal inferior direita. Assim
  como os triângulos, os *tiles* possuem parâmetros iterativos
  constantes ao longo de toda a sua superfície.

* E concluindo, o **poly_manager** é compatível com um mecanismo
  totalmente personalizado onde o requerente fornece uma lista das
  extensões que são aproximadamente alimentadas diretamente nas tarefas.
  Isso é útil ao emular um sistema com primitivos 3D incomuns onde seja
  necessário um tipo de comportamento bem específico nas suas bordas.


.. _poly_manager-synchronization:

O sincronismo
~~~~~~~~~~~~~

A sincronização é um dos principais requisitos para proporcionar um
mecanismo assíncrono de renderização. A sincronização no
**poly_manager** é muito simples: basta chamar a função ``wait()``.

Há diversos motivos para usar um *wait*:

* No momento da exibição, os dados dos pixels devem ser copiados para a
  tela. Caso algum primitivo 3D seja enfileirado e este toque a parte da
  tela onde será exibida, será preciso esperar a conclusão da
  renderização antes de continuar com a copia. Observe que esta espera
  pode não ser totalmente necessária em alguns casos (num sistema com
  *buffer* triplo por exemplo).

* Caso o sistema que esteja sendo emulado tenha um mecanismo para ler o
  retorno do *framebuffer* depois da renderização, assim um *wait* deve
  ser usado antes da leitura a fim de garantir que a assincronicidade da
  renderização seja concluída.

* Caso o sistema que esteja sendo emulado altere qualquer estado que não
  esteja no cache do **ObjectType** ou num outro lugar (na memória da
  textura por exemplo), assim um *wait* deve ser usado para garantir
  que o estado dos primitivos 3D sejam consumidos e que o seu trabalho
  seja finalizado.

* Caso o sistema que esteja sendo emulado possa usar a renderização de
  um objeto anterior como a origem da textura para um novo primitivo 3D,
  então a apresentação do segundo elemento primitivo deve aguardar até
  que o primeiro primitivo seja concluído. O **poly_manager** não
  dispõem de nenhum mecanismo interno para auxiliar nessa detecção,
  assim sendo, cabe àquele que faz a chamada determinar quando ou caso
  seja necessário.

Como a operação *wait* tem ciência quando acontece a conclusão de toda a
renderização, o **poly_manager** também aproveita esta oportunidade para
recuperar toda a memória que foi alocada para as suas estruturas
internas, bem como a memória que foi alocada nas estruturas
**ObjectType**. Por isso é importante que não seja mantido nenhum
**ObjectType** após a invocação de um *wait*.


.. raw:: latex

	\clearpage

.. _poly_manager-class:

A classe poly_manager
---------------------

Na maioria das aplicações o **poly_manager** não é usado de forma
direta, em vez disso, serve como uma classe de referência para uma
classe de renderização mais completa. A própria classe do
**poly_manager** é um modelo::

    template<typename BaseType, class ObjectType, int MaxParams, u8 Flags = 0>
    class poly_manager;

E os parâmetros deste modelo são:

* **BaseType**

	É o tipo utilizado internamente para coordenadas e para a iteração
	dos parâmetros, em geral, deve ser ou ``float`` ou ``double``.
	Teoricamente, um ponto fixo inteiro também poderia ser utilizado,
	contudo, você pode se deparar com problemas pois a lógica matemática
	não foi projetada para isso.

* **ObjectType**

	É a estrutura de dados definida por objeto pelo usuário, descrita
	acima. Internamente, o **poly_manager** vai gerenciar um destes
	**poly_array** e um ponteiro para a alocação mais recente no momento
	em que um primitivo 3D for submetido, este será implicitamente
	encaminhado para o retorno da chamada de cada extensão
	correspondente.

* **MaxParams**

	É a quantidade máxima dos parâmetros iterados que podem ser
	definidos num vértice. Os parâmetros iterados são genéricos e
	tratados igualmente, de maneira que o mapeamento dos índices dos
	parâmetros está completamente alinhado com o vínculo entre a chamada
	e o seu retorno. É permitido que o **MaxParams** seja 0.

* **Flags**

	Pode ser zero ou ser qualquer um dos sinalizadores abaixo:

- **POLY_FLAG_NO_WORK_QUEUE**

	Defina este sinalizador para desativar a renderização assíncrona;
	pode ser útil para fazer depuração. Quando esta opção está ativa,
	todos os primitivos são enfileirados e depois processados em
	sequência nas tarefas quando um ``wait()`` for invocado a partir da
	classe **poly_manager**.

- **POLY_FLAG_NO_CLIPPING**

	Especifique caso queira que o **poly_manager** ignore o corte
	(*clipping*) interno. Use isso caso o retorno do renderizador faça o
	seu próprio corte ou caso o solicitante sempre trate o corte antes
	de submeter os primitivos 3D.


.. raw:: latex

	\clearpage

.. _poly_manager-types_constants:

Tipos e Constantes
~~~~~~~~~~~~~~~~~~

.. _poly_manager-vertex_t:

vertex_t
++++++++

Dentro da classe do **poly_manager** você encontrará o tipo **vertex_t**
faz a descrição de um único vórtice. Todos os métodos de traçado
primitivo aceitam 2 ou mais destes objetos **vertex_t**. O **vertex_t**
inclui as coordenadas X e Y em conjunto com os valores dos parâmetros de
uma matriz iteradas nele::

    struct vertex_t
    {
        vertex_t() { }
        vertex_t(BaseType _x, BaseType _y) { x = _x; y = _y; }

        BaseType x, y;                          // coordenadas X, Y
        std::array<BaseType, MaxParams> p;      // parâmetros iterados
    };

Observe que o próprio **vertex_t** está definido dentro dos valores do
modelo do **BaseType** e do **MaxParams** que tem posse da classe
**poly_manager**.

Todos os primitivos do **poly_manager** operam no região da tela, onde
(0,0) representa o canto superior esquerdo da diagonal superior esquerda
do pixel, já (0,5,0,5) representa o centro deste pixel.
Os valores dos pixels esquerdo e cima são inclusivos, enquanto os
valores dos pixels direito e baixo são exclusivos.

Assim, um *tile* renderizado a partir de (2,2)-(4,3) ocupará 2 pixels:
(2,2) e (3,2).

Ao invocar um método primitivo de desenho, a matriz dos parâmetros
iterativos **p** não precisa ser completamente preenchida. A quantidade
dos valores válidos dos parâmetros iterados é definido como base nos
parâmetro dos métodos de desenho primitivo, de maneira que apenas aquela
quantidade de parâmetros precisem ser realmente preenchidos e repassados
para as estruturas **vertex_t**.


.. _poly_manager-extent_t:

extent_t
++++++++

O **poly_manager** divide os primitivos em extensões, são intervalos
horizontais contíguos mantidos dentro de uma única linha de varredura.
Estas extensões então são distribuídas às tarefas que invocarão a
chamada de retorno com as informações sobre como fazer a renderização de
cada extensão. O tipo **extent_t** descreve uma dessas extensões,
fornecendo as coordenadas X delimitadoras juntamente com uma matriz de
valores iniciais dos parâmetros iterados e dos deltas em todo o
intervalo::

    struct extent_t
    {
        struct param_t
        {
            BaseType start;                     // o inicio do valor do parâmetro
            BaseType dpdx;                      // dp/dx relativo ao inicio
        };
        int16_t startx, stopx;                  // iniciando (inclusivo)/encerrando (exclusivo) extremidades (endpoints)
        std::array<param_t, MaxParams> param;   // matriz de parâmetros inicio/deltas
        void *userdata;                         // dados personalizados por intervalo
    };

Para cada parâmetro iterado, o valor **start** contém o valor no lado
esquerdo do intervalo. Já o valor **dpdx** contém a alteração do valor
do parâmetro de cada coordenada X.

Também há um campo **userdata** na estrutura **extent_t**, que
normalmente não é utilizada a não ser durante a execução de uma
renderização personalizada.


.. _poly_manager-render_delegate:

render_delegate
+++++++++++++++

Ao renderizar um primitivo, além dos vértices, você também deve informar
uma chamada de retorno do formulário **render_delegate**::

  void render(int32_t y, extent_t const &extent, ObjectType const &object, int threadid)

Este retorno de chamada é responsável pela renderização propriamente
dita. Ela provavelmente será chamada mais tarde para cada extensão numa
tarefa de trabalho diferente. Os parâmetros repassados são:

* **y**

	É a coordenada Y da scanline da extensão atual.

* **extent**

	É a referência à estrutura **extent_t** descrita acima, nesta
	extensão ela define o início/encerramento do valor X junto com os
	valores dos parâmetros de cada iteração dos valores do início/delta.

* **object**

	É a referência da alocação mais recente do **ObjectType** no momento
	onde o primitivo foi enviado para ser renderizado; teoricamente
	deveria ter a maioria, se não todos os dados necessário para
	realizar a renderização.

* **threadid**

	É a identificação única que indica o índice da tarefa de trabalho
	sendo executada no momento; este valor é útil caso esteja mantendo
	qualquer tipo de estatística e não queira acrescentar argumentos
	sobre os valores que são compartilhados. Nesta situação, é possível
	alocar as instâncias dos dados do **WORK_MAX_THREADS** e atualizar a
	instância que for passada para o **threadid**. Quando quiser exibir
	as estatísticas, a principal tarefa de trabalho pode acumular e
	redefinir os dados de todas as tarefas quando for seguro fazê-lo
	(após um *wait* por exemplo).


.. raw:: latex

	\clearpage

.. _poly_manager-methods:

Metodologia
~~~~~~~~~~~


.. _poly_manager-poly_manager:

poly_manager
++++++++++++
::

    poly_manager(running_machine &machine);

O construtor do **poly_manager** aceita apenas um parâmetro, uma
referência ao **running_machine**. Isso concede ao **poly_manager** o
acesso às filas de trabalho necessárias para executar os trabalhos em
multi-tarefa.


.. _poly_manager-wait:

wait
++++
::

    void wait(char const *debug_reason = "general");

Invocando o ``wait()`` suspende as tarefas até que toda a renderização
pendente seja concluída:

* **debug_reason**

	É um parâmetro opcional que determina o motivo da espera. É útil
	caso a constante de tempo da compilação **TRACK_POLY_WAITS** esteja
	ativada, pois ela emitirá um resumo dos tempos de espera e as razões
	no final da execução.

		**Retorna:** Nada.


.. _poly_manager-object_data:

object_data
+++++++++++
::

    objectdata_array &object_data();

Este método apenas devolve uma referência ao **poly_array** interno do
**ObjectType** que foi definido ao criar o **poly_manager**. Para a
maioria das aplicações a única coisa mais interessante a ser feita com
ele é invocar o método ``next()`` para alocar um novo objeto à ser
preenchido.

	**Retorna:** Uma referência ao **poly_array** do **ObjectType**.


.. _poly_manager-register_poly_array:

register_poly_array
+++++++++++++++++++
::

    void register_poly_array(poly_array_base &array);

Em aplicações avançadas, é possível optar pela criação dos seus próprios
objetos **poly_array** para administrar grandes pedaços de dados
alterados com pouca frequência, assim como as paletas. Após cada
``wait()``, o **poly_manager** redefine todos os objetos **poly_array**
conhecidos a fim de recuperar a pendência de toda a memória que foi
alocada. Ao registrar aqui os seus objetos **poly_array** é possível
garantir que as suas matrizes também sejam reinicializadas após uma
invocação do ``wait()`` .

	**Retorna:** Nada.


.. raw:: latex

	\clearpage

.. _poly_manager-render_tile:

render_tile
+++++++++++
::

    template<int ParamCount>
    uint32_t render_tile(rectangle const &cliprect, render_delegate callback,
                         vertex_t const &v1, vertex_t const &v2);

Este método enfileira um único *tile* primitivo para a renderização:

* **ParamCount**

	É a quantidade dos valores ativos na matriz de parâmetros iterados
	dentro de cada **vertex_t** apresentado; não deve ser maior que o
	valor de **MaxParams** definido no instanciação do modelo do
	**poly_manager**.

* **cliprect**

	É uma referência ao recorte de um retângulo. Todos os pixels e todos
	os valores dos parâmetros são recortados para ficar dentro destes
	limites antes de serem adicionados nas filas de trabalho para a sua
	renderização, a menos que **POLY_FLAG_NO_CLIPPING** tenha sido
	definido como um parâmetro de sinalização para o **poly_manager**.

* **callback**

	É o responsável pelo retorno da chamada que será feita para
	renderizar cada extensão.

* **v1**

	Contém as coordenadas e os parâmetros de iteração para o canto
	superior esquerdo do tile.

* **v2**

	Contém as coordenadas e os parâmetros de iteração para o canto
	superior direito do tile.

**Retorna:** A quantidade total dos pixels que foram recortados representado pelas extensões consultadas.


.. _poly_manager-render_triangle:

render_triangle
+++++++++++++++
::

    template<int ParamCount>
    uint32_t render_triangle(rectangle const &cliprect, render_delegate callback,
                             vertex_t const &v1, vertex_t const &v2, vertex_t const &v3);

Este método enfileira um único *triângulo* primitivo para a renderização:

* **ParamCount**

	É a quantidade dos valores ativos na matriz de parâmetros iterados
	dentro de cada **vertex_t** apresentado; não deve ser maior que o
	valor de **MaxParams** definido no instanciação do modelo do
	**poly_manager**.

* **cliprect**

	É uma referência ao recorte de um retângulo. Todos os pixels e todos
	os valores dos parâmetros são recortados para ficar dentro destes
	limites antes de serem adicionados nas filas de trabalho para a sua
	renderização, a menos que **POLY_FLAG_NO_CLIPPING** tenha sido
	definido como um parâmetro de sinalização para o **poly_manager**.

* **callback**

	É o responsável pelo retorno da chamada que será feita para
	renderizar cada extensão.

.. raw:: latex

	\clearpage

* **v1**, **v2**, **v3**

	Contém as coordenadas e os parâmetros de iteração para cada vértice
	do triângulo.

		**Retorna:** A quantidade total dos pixels que foram recortados representado pelas extensões consultadas.


.. _poly_manager-render_triangle_fan:

render_triangle_fan
+++++++++++++++++++
::

    template<int ParamCount>
    uint32_t render_triangle_fan(rectangle const &cliprect, render_delegate callback,
                                 int numverts, vertex_t const *v);

Este método enfileira um ou mais *triângulos* primitivos para a
renderização, definido pela sua sequência:

* **ParamCount**

	É a quantidade dos valores ativos na matriz de parâmetros iterados
	dentro de cada **vertex_t** apresentado; não deve ser maior que o
	valor de **MaxParams** definido no instanciação do modelo do
	**poly_manager**.

* **cliprect**

	É uma referência ao recorte de um retângulo. Todos os pixels e todos
	os valores dos parâmetros são recortados para ficar dentro destes
	limites antes de serem adicionados nas filas de trabalho para a sua
	renderização, a menos que **POLY_FLAG_NO_CLIPPING** tenha sido
	definido como um parâmetro de sinalização para o **poly_manager**.

* **callback**

	É o responsável pelo retorno da chamada que será feita para
	renderizar cada extensão.

* **numverts**

	A quantidade total dos vértices fornecidos; deve ser pelo menos 3.

* **v**

	É um ponteiro para uma matriz de objetos **vertex_t** contendo as
	coordenadas e os parâmetros iterados para todos os triângulos em
	leque. Significa que o primeiro vértice é fixo. Portanto, caso
	sejam apresentados 5 vértices, indicando 3 triângulos, os vértices
	utilizados serão: (0,1,2) (0,2,3) (0,3,4)

		**Retorna:** A quantidade total dos pixels que foram recortados representado pelas extensões consultadas.


.. raw:: latex

	\clearpage

.. _poly_manager-render_triangle_strip:

render_triangle_strip
+++++++++++++++++++++
::

    template<int ParamCount>
    uint32_t render_triangle_strip(rectangle const &cliprect, render_delegate callback,
                                   int numverts, vertex_t const *v);

Este método enfileira um ou mais *triângulos* primitivos para a
renderização, definido em ordem de tiras:

* **ParamCount**

	É a quantidade dos valores ativos na matriz de parâmetros iterados
	dentro de cada **vertex_t** apresentado; não deve ser maior que o
	valor de **MaxParams** definido no instanciação do modelo do
	**poly_manager**.

* **cliprect**

	É uma referência ao recorte de um retângulo. Todos os pixels e todos
	os valores dos parâmetros são recortados para ficar dentro destes
	limites antes de serem adicionados nas filas de trabalho para a sua
	renderização, a menos que **POLY_FLAG_NO_CLIPPING** tenha sido
	definido como um parâmetro de sinalização para o **poly_manager**.

* **callback**

	É o responsável pelo retorno da chamada que será feita para
	renderizar cada extensão.

* **numverts**

	A quantidade total dos vértices fornecidos; deve ser pelo menos 3.

* **v**

	É um ponteiro para uma matriz de objetos **vertex_t** contendo as
	coordenadas e os parâmetros iterados para todos os triângulos,
	definido em ordem de tiras:
	Portanto, caso sejam apresentados 5 vértices, indicando 3
	triângulos, os vértices utilizados serão: (0,1,2) (1,2,3) (2,3,4)

		**Retorna:** A quantidade total dos pixels que foram recortados representado pelas extensões consultadas.


.. raw:: latex

	\clearpage

.. _poly_manager-render_polygon:

render_polygon
++++++++++++++
::

    template<int NumVerts, int ParamCount>
    uint32_t render_polygon(rectangle const &cliprect, render_delegate callback, vertex_t const *v);

Este método enfileira um único *polígono* primitivo para a renderização:

* **NumVerts**

	É a quantidade de vértices num polígono.

* **ParamCount**

	É a quantidade dos valores ativos na matriz de parâmetros iterados
	dentro de cada **vertex_t** apresentado; não deve ser maior que o
	valor de **MaxParams** definido no instanciação do modelo do
	**poly_manager**.

* **cliprect**

	É uma referência ao recorte de um retângulo. Todos os pixels e todos
	os valores dos parâmetros são recortados para ficar dentro destes
	limites antes de serem adicionados nas filas de trabalho para a sua
	renderização, a menos que **POLY_FLAG_NO_CLIPPING** tenha sido
	definido como um parâmetro de sinalização para o **poly_manager**.

* **callback**

	É o responsável pelo retorno da chamada que será feita para
	renderizar cada extensão.

* **v**

	É um ponteiro para uma matriz de objetos **vertex_t** contendo as
	coordenadas e os parâmetros iterados para o polígono. É esperado
	que os vértices sejam ou em ordem horária ou em ordem anti-horária.

		**Retorna:** A quantidade total dos pixels que foram recortados representado pelas extensões consultadas.


.. _poly_manager-render_extents:

render_extents
++++++++++++++
::

    template<int ParamCount>
    uint32_t render_extents(rectangle const &cliprect, render_delegate callback,
                            int startscanline, int numscanlines, extent_t const *extents);

Este método enfileira as extensões personalizadas diretamente:

* **ParamCount**

	É a quantidade dos valores ativos na matriz de parâmetros iterados
	dentro de cada **vertex_t** apresentado; não deve ser maior que o
	valor de **MaxParams** definido no instanciação do modelo do
	**poly_manager**.

* **cliprect**

	É uma referência ao recorte de um retângulo. Todos os pixels e todos
	os valores dos parâmetros são recortados para ficar dentro destes
	limites antes de serem adicionados nas filas de trabalho para a sua
	renderização, a menos que **POLY_FLAG_NO_CLIPPING** tenha sido
	definido como um parâmetro de sinalização para o **poly_manager**.

.. raw:: latex

	\clearpage

* **callback**

	É o responsável pelo retorno da chamada que será feita para
	renderizar cada extensão.

* **startscanline**

	É a coordenada Y da primeira extensão fornecida.

* **numscanlines**

	É a quantidade das extensões fornecidas.

* **extents**

	É um ponteiro para um conjunto de objetos **extent_t** contendo o
	início/parada (start/stop) das coordenadas X e os parâmetros
	iterados. O campo **userdata** da origem da extensão também é
	copiado para o destino (este campo não é usado para todos os outros
	tipos de renderização).

		**Retorna:** A quantidade total dos pixels que foram recortados representado pelas extensões consultadas.


.. _poly_manager-zclip_if_less:

zclip_if_less
+++++++++++++
::

    template<int ParamCount>
    int zclip_if_less(int numverts, vertex_t const *v, vertex_t *outv, BaseType clipval);

Este método é um método de auxílio para cortar um polígono contra um
valor Z informado. Ele assume que o primeiro parâmetro iterado em
**vertex_t** representa a coordenada Z. Caso alguma borda cruze o plano
Z representado por **clipval**, esta borda é aparada.

* **ParamCount**

	É a quantidade dos valores ativos na matriz de parâmetros iterados
	dentro de cada **vertex_t** apresentado; não deve ser maior que o
	valor de **MaxParams** definido no instanciação do modelo do
	**poly_manager**.

* **numverts**

	É a quantidade de vértices na entrada da matriz.

* **v**

	É um ponteiro para a matriz de entrada dos objetos **vertex_t**.

* **outv**

	É um ponteiro para a saída da matriz dos objetos **vertex_t**. O
	**v** e o **outv** não podem se sobrepor ou apontar para a mesma
	memória.

* **clipval**

	É o valor de recorte que deve ser comparado com o parâmetro 0.

	**Retorna:** A quantidade dos vértices gerados escritos em **outv**.

Observe que desde a concepção, é possível que este método produza mais
vértices do que a matriz de entrada, portanto, aqueles que forem
invocá-lo devem garantir que haja espaço suficiente na saída do buffer
para acomodar isso.


.. raw:: latex

	\clearpage

.. _poly_manager-render-examples:

Exemplos do renderizador
------------------------

Aqui está um exemplo completo de como criar um software renderizador 3D
através do **poly_manager**. O nosso renderizador de exemplo só
manuseará triângulos planos e com shaders Gouraud com buffer de
profundidade (Z).


.. _poly_manager-types:

Tipos
~~~~~

A primeira coisa que precisamos definir é o formato da nossa vértice
*visível externamente * que é diferente do **vertex_t** interno que vai
definir o **poly_manager**. Em teoria é possível usar **vertex_t**
diretamente, porém a natureza genérica dos parâmetros iterados do
**poly_manager** torna as coisas estranhas::

    struct example_vertex
    {
        float x, y, z;      // Coordenadas X,Y,Z
        rgb_t color;        // a cor neste vértice
    };

Em seguida, definimos o **ObjectType** necessário para **poly_manager**.
Para o nosso simples exemplo, nós definimos uma estrutura
**example_object_data** que consiste em ponteiros para os nossos
buffers de renderização, mais um par de valores fixos que em alguns
casos são consumidos. Renderizadores mais complexos normalmente têm
muitos mais parâmetros de objeto definidos aqui::

    struct example_object_data
    {
        bitmap_rgb32 *dest;    // ponteiro para o renderizador do bitmap
        bitmap_ind16 *depth;   // ponteiro de profundidade do bitmap
        rgb_t color;           // coloração geral (para a limpeza e o caso de sombreamento plano)
        uint16_t depthval;     // valor da profundidade fixa (para limpeza)
    };

.. raw:: latex

	\clearpage

Agora definimos a nossa classe do renderizador que derivamos do
**poly_manager**. Como parâmetros do modelo ``float`` que definimos
como o tipo base para os nossos dados, uma vez que isso será preciso o
suficientemente para este exemplo e também fornecemos os nossos
**example_object_data** como a classe **ObjectType**, mais a quantidade
máxima dos parâmetros iterados que o nosso renderizador precisará
(4 neste caso)::

    class example_renderer : public poly_manager<float, example_object_data, 4>
    {
    public:
        example_renderer(running_machine &machine, uint32_t width, uint32_t height);

        bitmap_rgb32 *swap_buffers();

        void clear_buffers(rgb_t color, uint16_t depthval);
        void draw_triangle(example_vertex const *verts);

    private:
        static uint16_t ooz_to_depthval(float ooz);

        void draw_triangle_flat(example_vertex const *verts);
        void draw_triangle_gouraud(example_vertex const *verts);

        void render_clear(int32_t y, extent_t const &extent, example_object_data const &object, int threadid);
        void render_flat(int32_t y, extent_t const &extent, example_object_data const &object, int threadid);
        R

        int m_draw_buffer;
        bitmap_rgb32 m_display[2];
        bitmap_ind16 m_depth;
    };


.. _poly_manager-constructor:

O construtor
~~~~~~~~~~~~

O construtor do nosso renderizador de exemplo inicializa apenas o
**poly_manager** e aloca os buffers da renderização e da profundidade::

    example_renderer::example_renderer(running_machine &machine, uint32_t width, uint32_t height) :
        poly_manager(machine),
        m_draw_buffer(0)
    {
        // aloca dois buffers para a exibição e um buffer de profundidade
        m_display[0].allocate(width, height);
        m_display[1].allocate(width, height);
        m_depth.allocate(width, height);
    }


.. raw:: latex

	\clearpage

.. _poly_manager-swap_buffers:

swap_buffers
~~~~~~~~~~~~

O primeiro método interessante em nosso renderizador é o
``swap_buffers()`` que retorna um ponteiro ao buffer para onde estamos
desenhando e configura o outro buffer como um novo alvo para ser
desenhada. A ideia é que o manipulador da atualização da tela chamará
este método para obter o bitmap que será mostrado ao usuário::

    bitmap_rgb32 *example_renderer::swap_buffers()
    {
        // aguarde pela conclusão de qualquer renderização antes de devolver o buffer
        wait("swap_buffers");

        // devolva o buffer do desenho atual e em seguida, alterne para o outro
        // para desenho futuro
        bitmap_rgb32 *result = &m_display[m_draw_buffer];
        m_draw_buffer ^= 1;
        return result;
    }

O mais importante a ser observado aqui é a chamada para o
**poly_manager** ``wait()`` que bloqueará a linha atual até que toda a
renderização esteja concluída. Isto é importante pois, caso contrário,
o requerente pode receber um bitmap que ainda está sendo desenhado
levando a visuais quebrados ou corrompidos.


.. _poly_manager-clear_buffers:

clear_buffers
~~~~~~~~~~~~~

Uma das operações mais comuns a serem realizadas ao fazer a renderização
3D é inicializar ou limpar a tela e os buffers de profundidade para um
valor conhecido. O método abaixo alavanca a *tela* primitiva para
renderizar um retângulo na tela passando em (0,0) e (largura,altura)
para os dois vértices.

Como os valores de cor e de profundidade para limpar o buffer são
constantes, eles são armazenados num objeto recentemente alocado
**example_object_data**, juntamente com um ponteiro para os buffers em
questão. A chamada ``render_tile()`` é feita com um sufixo ``<0>``
indicando que não há parâmetros iterados para se preocupar::

    void example_renderer::clear_buffers(rgb_t color, uint16_t depthval)
    {
        // aloque os dados do objeto e preencha-os com as informações necessárias
        example_object_data &object = object_data().next();
        object.dest = &m_display[m_draw_buffer];
        object.depth = &m_depth;
        object.color = color;
        object.depthval = depthval;

        // topo, a coordenada esquerda sempre é (0,0)
        vertex_t topleft;
        topleft.x = 0;
        topleft.y = 0;

        // inferior, a coordenada direita é (largura,altura)
        vertex_t botright;
        botright.x = m_display[0].width();
        botright.y = m_display[0].height();

        // renderize como um bloco com 0 parâmetros iterados
        render_tile<0>(m_display[0].cliprect(),
                       render_delegate(&example_renderer::render_clear, this),
                       topleft, botright);
    }

O retorno de chamada de renderização fornecido para ``render_tile()``
também é definido (privadamente) na nossa classe e lida com uma única
extensão. Observe como os parâmetros da renderização são extraídos da
estrutura fornecida **example_object_data**::

    void example_renderer::render_clear(int32_t y, extent_t const &extent, example_object_data const &object, int threadid)
    {
        // obtém os ponteiros para o início do buffer de profundidade e linhas de varredura do destino
        uint16_t *depth = &object.depth->pix(y);
        uint32_t *dest = &object.dest->pix(y);

        // faz um loop em toda a extensão e apenas armazena os valores constantes do objeto
        for (int x = extent.startx; x < extent.stopx; x++)
        {
            dest[x] = object.color;
            depth[x] = object.depthval;
        }
    }

Outro ponto importante a ser ressaltado é que as coordenadas X
fornecidas pela extensão da estrutura são inclusiva da *startx*, porém,
exclusivas do *stopx*. O recorte é feito antes do tempo para que o
retorno da chamada possa se concentrar na disposição dos pixels o mais
rápido possível com o mínimo de sobrecarga.


.. _poly_manager-draw_triangle:

draw_triangle
~~~~~~~~~~~~~

A seguir, temos a nossa função real de renderização triangular, que
desenhará um único triângulo dado um conjunto de três vértices
disponibilizados no formato externo **example_vertex**::

    void example_renderer::draw_triangle(example_vertex const *verts)
    {
        // caixa plana sombreada
        if (verts[0].color == verts[1].color && verts[0].color == verts[2].color)
            draw_triangle_flat(verts);
        else
            draw_triangle_gouraud(verts);
    }

Como é mais simples e mais rápido renderizar um triângulo plano
sombreado, o código verifica se as cores são as mesmas em todos os três
vértices. Caso sejam, invocamos para um caso com shader plano, caso
contrário o processamos como um triângulo shader Gouraud completo.

Esta é uma técnica comum para otimizar o desempenho da
renderização: identificar casos especiais que reduzem o trabalho por
pixel, e encaminhá-los para separar o retorno da renderização que são
otimizados para aquele caso especial.


.. raw:: latex

	\clearpage

.. _poly_manager-draw_triangle_flat:

draw_triangle_flat
~~~~~~~~~~~~~~~~~~

Aqui está o código de configuração para renderizar um triângulo com um
shader plano::

    void example_renderer::draw_triangle_flat(example_vertex const *verts)
    {
        // aloque os dados do objeto e preencha-os com as informações necessárias
        example_object_data &object = object_data().next();
        object.dest = &m_display[m_draw_buffer];
        object.depth = &m_depth;

        // neste caso, a cor é constante e definida nos dados do objeto
        object.color = verts[0].color;

        // copie X, Y e 1/Z para os vértices poly_manager
        vertex_t v[3];
        for (int vertnum = 0; vertnum < 3; vertnum++)
        {
            v[vertnum].x = verts[vertnum].x;
            v[vertnum].y = verts[vertnum].y;
            v[vertnum].p[0] = 1.0f / verts[vertnum].z;
        }

        // renderiza o triângulo com 1 parâmetro iterado (1/Z)
        render_triangle<1>(m_display[0].cliprect(),
                            render_delegate(&example_renderer::render_flat, this),
                            v[0], v[1], v[2]);
    }

Primeiro, colocamos diretamente a cor fixa no **example_object_data**,
depois preenchemos três objetos **vertex_t** objetos com as coordenadas
X e Y no local habitual, e 1/Z como o nosso único e único parâmetro
iterado. (Usamos aqui 1/Z porque os parâmetros de iteração são
interpolados linearmente no espaço da tela. Z não é linear no espaço da
tela, já 1/Z é por causa da correção de perspectiva).

.. raw:: latex

	\clearpage

No caso do nosso shader plano então invoca o ``render_trangle`` definido
o parâmetro iterado ``<1>`` para interpolar e apontando para um caso
especial do retorno de chamada do renderizador plano::

    void example_renderer::render_flat(int32_t y, extent_t const &extent, example_object_data const &object, int threadid)
    {
        // obtém os ponteiros para o início do buffer de profundidade e linhas de varredura do destino
        uint16_t *depth = &object.depth->pix(y);
        uint32_t *dest = &object.dest->pix(y);

        // obtenha o valor inicial 1/Z e o delta por X
        float ooz = extent.param[0].start;
        float doozdx = extent.param[0].dpdx;

        // itera sobre a extensão
        for (int x = extent.startx; x < extent.stopx; x++)
        {
            // converta o valor 1/Z num valor de profundidade integral
            uint16_t depthval = ooz_to_depthval(ooz);

            // se mais próximo do que o pixel atual, copie o valor da cor e da profundidade
            if (depthval < depth[x])
            {
                dest[x] = object.color;
                depth[x] = depthval;
            }

            // independentemente, atualize o valor de 1/Z para o próximo pixel
            ooz += doozdx;
        }
    }

Isto torna a chamada de retorno é um pouco mais envolvente do que o
caso da liberação.

Primeiro, temos que lidar com um parâmetro iterado (1/Z) cujos valores
iniciais e do X-delta nós extraímos da extensão antes do início do loop
interno.

Em segundo lugar, realizamos testes no buffer de profundidade utilizando
o ``ooz_to_depthval()`` como um auxiliar para transformar o valor de
ponto flutuante 1/Z num inteiro com 16 bits. Comparamos este valor com o
valor atual do buffer de profundidade, e só armazenamos o valor do
pixel/profundidade caso seja inferior.

Ao final de cada iteração, avançamos o valor 1/Z pelo delta X, em
preparação para o próximo pixel.


.. raw:: latex

	\clearpage

.. _poly_manager-draw_triangle_gouraud:

draw_triangle_gouraud
~~~~~~~~~~~~~~~~~~~~~

Concluímos agora com o código para completar o caso Gouraud-shaded::

    void example_renderer::draw_triangle_gouraud(example_vertex const *verts)
    {
        // aloque os dados do objeto e preencha-os com as informações necessárias
        example_object_data &object = object_data().next();
        object.dest = &m_display[m_draw_buffer];
        object.depth = &m_depth;

        // copie X, Y, 1/Z e R,G,B para os vértices do poly_manager
        vertex_t v[3];
        for (int vertnum = 0; vertnum < 3; vertnum++)
        {
            v[vertnum].x = verts[vertnum].x;
            v[vertnum].y = verts[vertnum].y;
            v[vertnum].p[0] = 1.0f / verts[vertnum].z;
            v[vertnum].p[1] = verts[vertnum].color.r();
            v[vertnum].p[2] = verts[vertnum].color.g();
            v[vertnum].p[3] = verts[vertnum].color.b();
        }

        // renderize o triângulo com 4 parâmetros iterados (1/Z, R, G, B)
        render_triangle<4>(m_display[0].cliprect(),
                            render_delegate(&example_renderer::render_gouraud, this),
                            v[0], v[1], v[2]);
    }

.. raw:: latex

	\clearpage

Aqui temos 4 parâmetros iterados: o valor da profundidade 1/Z, mais o
vermelho, verde e azul, armazenados como valores de ponto flutuante.
Invocamos o ``render_trangle()`` com ``<4>`` já que é a quantidade de
parâmetros iterados para serem processados e apontamos para o retorno
completo da chamada do renderizador do Gouraud::

    void example_renderer::render_gouraud(int32_t y, extent_t const &extent, example_object_data const &object, int threadid)
    {
        // obtém os ponteiros para o início do buffer de profundidade e linhas de varredura do destino
        uint16_t *depth = &object.depth->pix(y);
        uint32_t *dest = &object.dest->pix(y);

        // obtenha o valor inicial 1/Z e o delta por X
        float ooz = extent.param[0].start;
        float doozdx = extent.param[0].dpdx;

        // obtenha os valores iniciais de R,G,B e o delta por X como 8,24 com valores de ponto fixo
        uint32_t r = uint32_t(extent.param[1].start * float(1 << 24));
        uint32_t drdx = uint32_t(extent.param[1].dpdx * float(1 << 24));
        uint32_t g = uint32_t(extent.param[2].start * float(1 << 24));
        uint32_t dgdx = uint32_t(extent.param[2].dpdx * float(1 << 24));
        uint32_t b = uint32_t(extent.param[3].start * float(1 << 24));
        uint32_t dbdx = uint32_t(extent.param[3].dpdx * float(1 << 24));

        // itera sobre a extensão
        for (int x = extent.startx; x < extent.stopx; x++)
        {
            // converta o valor 1/Z num valor de profundidade integral
            uint16_t depthval = ooz_to_depthval(ooz);

            // caso esteja mais próximo do que o pixel atual, monte a cor
            if (depthval < depth[x])
            {
                dest[x] = rgb_t(r >> 24, g >> 24, b >> 24);
                depth[x] = depthval;
            }

            // independentemente, atualize os valores 1/Z e R,G,B para o próximo pixel
            ooz += doozdx;
            r += drdx;
            g += dgdx;
            b += dbdx;
        }
    }

Isto segue o mesmo padrão de retorno da chamada com o sombreado plano,
exceto que temos 4 parâmetros de iteração para prosseguir.

Observe que ainda que os parâmetros iterados sejam do tipo "flutuante",
convertemos os valores das cores em inteiros de ponto fixo quando
iteramos sobre eles. Isto nos poupa de fazer 3 conversões *float-to-int*
em cada pixel. Os valores RGB originais eram entre 0-255, portanto a
interpolação só pode produzir valores na faixa entre 0-255. Assim,
podemos usar 24 bits de um inteiro com 32 bits como fração, que é
bastante preciso neste caso.


.. raw:: latex

	\clearpage

.. _poly_manager-poly_array_class:

Tópico avançado: A classe poly_array
------------------------------------

A **poly_array** tem como modelo uma classe que é utilizada para
gerenciar um vetor dinamicamente dimensionado de objetos cuja vida útil
começa na alocação e termina quando o ``reset()`` for invocado. A classe
**poly_manager** utiliza internamente vários objetos **poly_array**,
incluindo um para os dados **ObjectType** que foram alocados, um para
cada renderização primitiva e um para manter todas as extensões
alocadas.

O **poly_array** tem uma propriedade adicional onde após um *reset*
retém uma cópia do objeto alocado mais recentemente.  Isto assegura que
quem invoca sempre pode invocar o ``last()`` e obter imediatamente um
objeto válido mesmo após um reset.

A classe **poly_array** exige dois modelos de parâmetros::

    template<class ArrayType, int TrackingCount>
    class poly_array;

Estes parâmetros são:

* **ArrayType**

	É o tipo do objeto que se deseja alocar e administrar.

* **TrackingCount**

	É a quantidade de objetos que se deseja manter após um *reset*.
	Normalmente este valor ou é 0 (não importa rastrear nenhum objeto)
	ou 1 (só é necessário um objeto); entretanto, caso esteja usando
	**poly_array** para gerenciar uma coleção compartilhada de objetos
	entre vários consumidores independentes, ele pode ser maior. Veja
	abaixo um exemplo onde isto pode ser útil.

Note que os objetos alocados por **poly_array** são propriedade do
**poly_array** e serão automaticamente liberados mediante o seu
encerramento.

O **poly_array** é otimizado para uso em sistemas multi-tarefa de alta
frequência. Portanto, uma característica adicional da classe em questão
é o arredondamento do tamanho da alocação do **ArrayType** para o limite
da linha de cache mais próxima, na suposição onde as entradas vizinhas
poderiam ser acessadas por núcleos diferentes simultaneamente. Manter
cada objeto do **ArrayType** na sua própria linha de cache assegura que
não haja falsos impactos no desempenho do compartilhamento.

Atualmente, o **poly_array** não possui nenhum mecanismo para determinar
o tamanho da linha de cache em tempo real, portanto, presume-se que
64 bytes seja um tamanho típico para a linha de cache, que é verdadeiro
para a maioria dos chips x64 e ARM desde 2021. Este valor pode ser
modificado alterando-se a constante **CACHE_LINE_SHIFT** definido no
topo da classe.

Os objetos alocados pelo **poly_array** são criados em blocos de 64k.
No momento da construção, um pedaço dos objetos é antecipadamente
alocado. O tamanho do pedaço é controlado pela constante
**CHUNK_GRANULARITY** definido no topo da classe.

Como mais objetos são alocados, caso o **poly_array** fique sem espaço,
mais será alocado de forma dinâmica. Este processo produzirá pedaços
separados dos objetos até a próxima chamada ``reset()``, quando a
**poly_array** realocará todos os objetos num vetor contíguo novamente.

No caso onde **poly_array** seja utilizado para gerenciar um pool
compartilhado dos objetos, ele pode ser configurado para reter vários
itens alocados mais recentemente utilizando uma **TrackingCount** maior
que 1. Caso o **poly_array** esteja gerenciando objetos para duas
unidades de textura por exemplo, será possível definir o
**TrackingCount** igual a 2, e passar o índice da unidade da textura em
chamadas para ``next()`` e ``last()``. Após um *reset*, o **poly_array**
lembrará do objeto alocado mais recentemente para cada uma das unidades
de forma independente.


.. raw:: latex

	\clearpage

.. _poly_manager-poly_array_methods:

Metodologia
~~~~~~~~~~~


.. _poly_manager-poly_array:

poly_array
++++++++++
::

    poly_array();

O construtor **poly_array** não precisa de parâmetros e basicamente
pré-aloca um pedaço dos objetos preparando-os para futuras alocações.


.. _poly_manager-count:

count
+++++
::

	u32 count() const;

**Retorna:** A quantidade dos objetos atualmente alocados.


.. _poly_manager-max:

max
+++
::

	u32 max() const;

**Retorna:** A quantidade máxima dos objetos já alocados em algum momento.


.. _poly_manager-itemsize:

itemsize
++++++++
::

	size_t itemsize() const;

**Retorna:** O tamanho de um objeto, arredondado para o limite da linha do cache mais próxima.


.. _poly_manager-allocated:

allocated
+++++++++
::

	u32 allocated() const;

**Retorna:** A quantidade dos objetos que cabem no que foi alocado atualmente.


.. _poly_manager-byindex:

byindex
+++++++
::

	ArrayType &byindex(u32 index);

Retorna uma referência de um objeto na matriz por índice.
Equivale ao [**index**] numa matriz normal:

* **index**

	É o índice do item que você deseja consultar.

		**Retorna:** Uma referência ao objeto em questão. Como uma
		referência é devolvida, a sua responsabilidade é garantir que o
		**index** seja inferior a ``count()``, pois não há qualquer
		mecanismo para devolver um resultado inválido.


.. raw:: latex

	\clearpage

.. _poly_manager-contiguous:

contiguous
++++++++++
::

	ArrayType *contiguous(u32 index, u32 count, u32 &chunk);

Retorna um ponteiro para a base de uma seção contígua dos itens
**count** iniciando no **index**. Como o **poly_array** se redimensiona
dinamicamente, pode não ser possível acessar todos os objetos **count**
de forma contígua, então a quantidade dos objetos realmente contíguos é
devolvido no **chunk**:

* **index**

	É o índice do primeiro item que se deseja acessar de forma contígua.

* **count**

	É a quantidade dos itens que se deseja acessar de forma contígua.

* **chunk**

	É uma referência a uma variável que será definida para a quantidade
	real dos itens contíguos disponíveis a partir do **index**. Caso o
	**chunk** seja inferior ao **count**, então o solicitante deverá
	processar os itens **chunk** devolvidos, então invoque novamente
	``countiguous()`` no (**index** + **chunk**) para ter acesso ao
	restante.

		**Retorna:** Um ponteiro ao primeiro item no pedaço contíguo. Nenhuma verificação do intervalo é feito, portanto a sua responsabilidade é garantir que **index** + **count** seja menor ou igual a ``count()``.


.. _poly_manager-indexof:

indexof
+++++++
::

	int indexof(ArrayType &item) const;

Retorna o índice dentro da matriz do item em questão:

* **item**

É uma referência a um item na matriz.

**Retorna:** O índice do item. Deve sempre ser o caso onde::

	array.indexof(array.byindex(index)) == index


.. _poly_manager-reset:

reset
+++++
::

	void reset();

Redefine o **poly_array**, desalocando semanticamente todos os objetos.
Caso as alocações anteriores tenham criado uma matriz não contígua, um
novo vetor é alocado neste momento para que as alocações futuras até o
mesmo nível permaneçam contíguas.

Observe que o **ArrayType** destruidor *não* é invocado nos objetos
pois eles são desalocados.

	**Retorna:** Nada.


.. raw:: latex

	\clearpage

.. _poly_manager-next:

next
++++
::

	ArrayType &next(int tracking_index = 0);

Atribui um novo objeto e devolve uma referência a ele. Caso não haja
espaço suficiente para um novo objeto na matriz atual, uma nova matriz
não contígua é criada para mantê-lo:

* **tracking_index**

	É o índice de rastreamento que se deseja atribuir um novo item.
	Neste caso comum, isto é 0, mas poderia ser diferente de zero caso
	se utilize um **TrackingCount** maior que 1.

		**Retorna:** Uma referência ao objeto. Observe que o
		posicionamento do novo operador é invocado sobre este objeto,
		portanto o construtor predefinido **ArrayType** será invocado
		aqui.


.. _poly_manager-last:

last
++++
::

	ArrayType &last(int tracking_index = 0) const;

Retorna uma referência ao último objeto que foi alocado:

* **tracking_index**

	É o índice de rastreamento do objeto desejado. Neste caso comum,
	isto é 0, mas poderia ser diferente de zero caso se utilize um
	**TrackingCount** maior que 1. O **poly_array** recorda o
	objeto recentemente alocado de forma independente para cada
	**tracking_index**.

		**Retorna:** Uma referência ao último objeto alocado.
