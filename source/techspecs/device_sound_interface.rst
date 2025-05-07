
.. raw:: latex

	\clearpage


O device_sound_interface
========================

.. contents:: :local:

.. raw:: latex

	\clearpage


O sistema de áudio
------------------

A interface de áudio do dispositivo é o ponto de entrada para
dispositivos que lidam com entrada e/ou saída de áudio. O sistema de
áudio é construído com base no conceito de fluxos que conectam
dispositivos com reamostragem e mixagem aplicadas de forma
transparente conforme a necessidade. Microfones (entrada de áudio) e
alto-falantes (saída de áudio) são dispositivos específicos e que usam a
mesma interface.


Usando o device_sound_interface
-------------------------------

Inicialização
~~~~~~~~~~~~~

Os fluxos de áudio devem ser criados no método **device_start** (ou
**interface_pre_start**).

.. code-block:: C++

    sound_stream *stream_alloc(int inputs, int outputs, int sample_rate, sound_stream_flags flags = STREAM_DEFAULT_FLAGS);

Um fluxo é criado usando **stream_alloc**. Ele recebe a quantidade de
canais de entrada e de saída, a taxa de amostragem e, opcionalmente, os
sinalizadores.

A taxa de amostragem pode ser **SAMPLE_RATE_INPUT_ADAPTIVE**,
**SAMPLE_RATE_OUTPUT_ADAPTIVE** ou **SAMPLE_RATE_ADAPTIVE**. Nesse caso,
a taxa de amostragem escolhida é a mais alta entre as entradas, saídas
ou ambas, respectivamente. No caso de um *loop*, a taxa de amostragem
escolhida é a taxa global configurada.

O único sinalizador não padrão disponível é **STREAM_SYNCHRONOUS**.
Quando definido, o método de geração de áudio é invocado para cada
amostra individualmente. Isso é necessário para *DSPs* que executam um
programa em cada amostra, mas é dispendioso, portanto, só deve ser usado
quando necessário.

Os dispositivos podem criar vários fluxos. No entanto, isso é raro.
Alguns chips da Yamaha deveriam fazê-lo, mas não o fazem. As entradas e
saídas são numeradas a partir de **0** e organizam todos os fluxos na
ordem em que são criados.


Entrada e saída de áudio
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    virtual void sound_stream_update(sound_stream &stream);

É necessário implementar esse método para consumir as amostras de
entrada e/ou computar as de saída. O fluxo a ser atualizado é passado
como parâmetro. Consulte a seção de fluxos, especificamente o acesso à
amostra, para saber como escrever o método.


Informação do fluxo
~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    int inputs() const;
    int outputs() const;
    std::pair<sound_stream *, int> input_to_stream_input(int inputnum) const;
    std::pair<sound_stream *, int> output_to_stream_output(int outputnum) const;

O método **inputs** retorna a quantidade total de entradas nos fluxos
criados pelo dispositivo. O método **outputs** conta as saídas de
maneira semelhante. Os outros dois métodos permitem obter a quantidade
de entrada ou saída do fluxo e do canal correspondente à quantidade
global de entrada ou saída do dispositivo.


Gerenciamento de ganho
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    float input_gain(int inputnum) const;
    float output_gain(int outputnum) const;
    void set_input_gain(int inputnum, float gain);
    void set_output_gain(int outputnum, float gain);
    void set_route_gain(int source_channel, device_sound_interface *target, int target_channel, float gain);

    float user_output_gain() const;
    float user_output_gain(int outputnum) const;
    void set_user_output_gain(float gain);
    void set_user_output_gain(int outputnum, float gain);

Esses métodos permitem definir o ganho em cada etapa das rotas entre
fluxos. Todos os ganhos são multiplicadores, com valor padrão ``1,0``.
As etapas vão desde a saída de amostras em **sound_stream_update** até
as amostras lidas em **sound_stream_update** do próximo dispositivo:

* Ganho de saída por canal;
* Ganho de saída do usuário por canal;
* Ganho de saída do usuário por dispositivo;
* Ganho por rota;
* Ganho de entrada por canal;

Os ganhos do usuário não devem ser definidos a partir do *driver*, pois
são utilizados pela interface do usuário (os controles deslizantes) e
são salvos na configuração do jogo. Os outros ganhos são para uso do
driver/dispositivo e são salvos ao salvar o estado.


Configuração de roteamento
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    device_sound_interface &add_route(u32 output, const device_finder<T, R> &target, double gain, u32 channel = 0)
    device_sound_interface &add_route(u32 output, const char *target, double gain, u32 channel = 0);
    device_sound_interface &add_route(u32 output, device_sound_interface &target, double gain, u32 channel = 0);

    device_sound_interface &reset_routes();

As rotas entre dispositivos, por exemplo, entre fluxos, são definidas no
momento da configuração. O método **add_route** deve ser chamado no
dispositivo de origem e fornece o canal, o dispositivo de destino, o
ganho e, opcionalmente, o canal no dispositivo de destino. A
constante **ALL_OUTPUTS** pode ser usada para adicionar uma rota de cada
canal da origem a um canal específico do destino.

O método **reset_routes** é usado para remover todas as rotas
configuradas em um dispositivo de origem específico.

.. code-block:: C++

    u32 get_sound_requested_inputs() const;
    u32 get_sound_requested_outputs() const;
    u64 get_sound_requested_inputs_mask() const;
    u64 get_sound_requested_outputs_mask() const;

Esses métodos são úteis para dispositivos que desejam se comportar de
maneira diferente, dependendo das rotas configuradas. Você obtém o
número máximo de canais solicitados mais um (que é o número de canais
quando todos os canais são roteados, mas é mais útil quando há lacunas)
ou uma máscara de uso para os canais de **0** a **63**. Observe que
**ALL_OUTPUTS** não registra saída ou contagem de saída específica
alguma.


Fluxos
------

Aspectos gerais
~~~~~~~~~~~~~~~

Os fluxos são pontos de extremidade associados a dispositivos e, quando
conectados entre si, garantem a transmissão de dados de áudio entre
eles. Um fluxo tem um número de entradas (que pode ser zero) e saídas
(igual) e uma taxa de amostragem comum a todas as entradas e saídas. As
conexões são definidas no nível de configuração da máquina, e o sistema
de áudio garante que a mixagem e a reamostragem sejam feitas de maneira
transparente.

As amostras nos fluxos são codificadas como **sample_t**. Na
implementação atual, trata-se de um *float*. Os valores nominais estão
entre **-1** e **1**, mas a fixação no nível do dispositivo não é
recomendada (a menos que isso aconteça no hardware, é claro), pois os
valores de ganho, volume e efeitos podem facilmente causar saturação.

Eles são implementados na classe **sound_stream**.


Características
~~~~~~~~~~~~~~~

.. code-block:: C++

    device_t &device() const;
    bool input_adaptive() const;
    bool output_adaptive() const;
    bool synchronous() const;
    u32 input_count() const;
    u32 output_count() const;
    u32 sample_rate() const;
    attotime sample_period() const;


Acesso por amostragem
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    s32 samples() const;

    void put(s32 output, s32 index, sample_t sample);
    void put_clamp(s32 output, s32 index, sample_t sample, sample_t clamp = 1.0);
    void put_int(s32 output, s32 index, s32 sample, s32 max);
    void put_int_clamp(s32 output, s32 index, s32 sample, s32 maxclamp);
    void add(s32 output, s32 index, sample_t sample);
    void add_int(s32 output, s32 index, s32 sample, s32 max);
    void fill(s32 output, sample_t value, s32 start, s32 count);
    void fill(s32 output, sample_t value, s32 start);
    void fill(s32 output, sample_t value);
    void copy(s32 output, s32 input, s32 start, s32 count);
    void copy(s32 output, s32 input, s32 start);
    void copy(s32 output, s32 input);
    sample_t get(s32 input, s32 index) const;
    sample_t get_output(s32 output, s32 index) const;

Esses são os métodos utilizados para implementar o
**sound_stream_update**. O primeiro **samples** informa quantas amostras
devem ser consumidas e/ou geradas. Se houver amostras a serem geradas,
elas são previamente liberadas (definidas como zero por exemplo).

As amostras de entrada são recuperadas com **get**, em que **input** é o
valor do canal no fluxo e **indexa** o valor da amostragem.

As amostras geradas são gravadas com as variantes **put**, que define
um **sample_t** na saída do canal no índice de posição. Já
**put_clamp**, faz o mesmo, mas primeiro fixa o valor em +/-**clamp**,
**put_int**, que faz o mesmo com uma amostra inteira, mas também faze
um clamp prévio com -**maxclamp** e **maxclamp**-1, que é o intervalo
normal para um valor de dois complementos.

O **add** e **add_int** são semelhantes, mas adicionam o valor da
amostra ao que já existe, em vez de substituí-lo. O **get_output** obtém
o valor de saída atualmente armazenado.

O **fill** define um intervalo de um canal de saída para um determinado
valor. Já **start** informa onde começar (índice padrão **0**) e
**count** conta quantos (por padrão, até o final do *buffer*).

O **copy** faz o mesmo que **fill**, mas obtém seu valor da posição
idêntica em um canal de entrada.

Observe que o *clamping* não deve ser usado a menos que ocorra de fato
no hardware. Entre ganhos e efeitos, há uma boa chance de que a
saturação possa ser evitada posteriormente na cadeia.


Tempo
~~~~~

.. code-block:: C++

    u32 sample_rate() const;
    attotime sample_period() const;

    u64 start_index() const;
    u64 end_index() const;
    attotime start_time() const;
    attotime end_time() const;

    attotime sample_to_time(u64 index) const;

O **sample_rate** fornece a taxa de amostragem atual do fluxo e
**sample_period** a correspondente duração.

Dentro uma chamada para a atualização de um *callback*, o
**start_index** fornece o número (começando em zero quando o sistema é
ligado) e **start_time** indica a hora da primeira amostragem que será
computada na atualização. O **end_index** e o **end_time** indicam, de
forma correspondente, uma vez passada a última amostragem que será
atualizada ou, em outras palavras, a primeira amostra da próxima chamada
de atualização. Fora de uma atualização de um *callback*, todos eles
apontam para a primeira amostra da próxima atualização.

Por fim, **sample_to_time** permite a conversão de um número de
amostragem para um tempo.

Observe que, em caso de alteração da taxa de amostragem, os números de
amostragem são recalculados para que terminem como se o fluxo tivesse a
nova taxa desde o início. E os tempos ainda serão tais que a amostragem
**0** esteja no tempo **0**.


Gerenciamento de ganho
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    float user_output_gain() const;
    void set_user_output_gain(float gain);
    float user_output_gain(s32 output) const;
    void set_user_output_gain(s32 output, float gain);

    float input_gain(s32 input) const;
    void set_input_gain(s32 input, float gain);
    void apply_input_gain(s32 input, float gain);
    float output_gain(s32 output) const;
    void set_output_gain(s32 output, float gain);
    void apply_output_gain(s32 output, float gain);

Isso é similar ao controle de ganho do dispositivo, exceto por um
detalhe: aplicar multiplica o ganho atual pelo valor fornecido.


Ações diversas
~~~~~~~~~~~~~~

.. code-block:: C++

    void set_sample_rate(u32 sample_rate);
    void update();

O método **set_sample_rate** permite alterar a taxa de amostragem do
fluxo. O método **update** aciona uma chamada para
**sound_stream_update** no fluxo e naqueles dos quais ele depende para
alcançar o tempo atual das amostras.


Dispositivos que usam device_mixer_interface
--------------------------------------------

A interface de mixagem do dispositivo é usada para dispositivos que
desejam transmitir áudio pela árvore de dispositivos sem afetá-la.
É muito útil, por exemplo, para dispositivos slot, que podem ter uma
conexão de áudio com o sistema principal. Eles são roteados como
qualquer outro dispositivo de áudio, criando fluxos automaticamente e
copiando a entrada para a saída. Não é necessário fazer nada no
dispositivo.
