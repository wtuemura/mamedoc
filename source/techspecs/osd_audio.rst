.. raw:: latex

	\clearpage


.. _techspecs-osd-audio:

Suporte de áudio com informações visuais na tela
================================================


Introdução
----------

O suporte de áudio no MAME permite que o usuário mapeie livremente entre
as saídas de áudio do sistema emulado (chamadas de "falantes") e o áudio
do sistema anfitrião. Uma parte disso é o suporte às informações visuais
exibidas na tela, onde um módulo específico do hospedeiro garante a
interface entre o MAME e o hospedeiro. Esta é a documentação para este
módulo.

.. note:: Atualmente, a documentação lida apenas com a saída, mas em
   breve a entrada também deve ser adicionada.
.. note:: **IVT** é um acrônimo de *informações visuais na tela*. No
   Inglês é **OSD** ou *On Screen Display*.
.. note:: **IU** é um acrônimo de *interface do usuário*.


Das capacidades
---------------

A interface *IVT* foi concebida para permitir três níveis de suporte,
dependendo do que a API permite e da quantidade de esforço necessária.
São eles:

* **Nível 1**: um ou mais alvos de áudio, com apenas um fluxo permitido
  por alvo (também conhecido como modo exclusivo);
* **Nível 2**: um ou mais alvos de áudio e vários fluxos por alvo;
* **Nível 3**: um ou mais alvos de áudio, vários fluxos por alvo e
  controle de volume visível pelo usuário por canal de fluxo;

De qualquer forma, apoiamos que o usuário use uma interface externa para
alterar o destino de um fluxo e, no nível 3, ajustar os volumes. Por
suporte, queremos dizer que as informações devem ser armazenadas na
configuração por jogo e que a IU interna deve permanecer em sincronia.


Terminologia
------------

Para este módulo, usamos os seguintes termos:

* **node**: um objeto para o qual podemos enviar áudio. Ele pode ser
  físico, como alto-falantes, ou virtual, como um sistema de efeitos e
  deve ter um nome único e apresentável para a IU;
* **port**: um canal de um nó, que tem um nome (não único, como "frente
  esquerda") e uma posição 3D;
* **stream**: uma conexão a um nó que permite enviar áudio para ele;


Documentação de referência
--------------------------

Adicionando um módulo
~~~~~~~~~~~~~~~~~~~~~

Para adicionar um módulo, basta adicionar um arquivo cpp à pasta
**src/osd/modules/sound**, que deve seguir esta estrutura:

.. code-block:: C++

    // Licença/Direitos Autorais
    
    #include "sound_module.h"
    #include "modules/osdmodules.h"

    #ifdef MODULE_SUPPORT_KEY

    #include "modules/lib/osdobj_common.h"

    // [...]
    namespace osd {
    namespace {

    class sound_module_class : public osd_module, public sound_module
    {
       sound_module_class() : osd_module(OSD_SOUND_PROVIDER, "module_name"),
                              sound_module()
       // ...
    };

    }
    }
    #else
    namespace osd { namespace {
      MODULE_NOT_SUPPORTED(sound_module_class, OSD_SOUND_PROVIDER, "module_name")
    }}
    #endif

    MODULE_DEFINITION(SOUND_MODULE_KEY, osd::sound_module_class)

Nesse código, quatro nomes devem ser escolhidos:

* **MODULE_SUPPORT_KEY**: alguma definição proveniente dos scripts do
  `GENie`_ para informar que esse módulo específico pode ser compilado
  (como **NO_USE_PIPEWIRE** ou **SDLMAME_MACOSX**);
* **sound_module_class**: é o nome da classe que compõe o módulo (como
  **sound_coreaudio**);
* **module_name**: é nome a ser usado em **-sound <xxx>** para
  selecionar esse módulo específico é chamado de **module_name** (como
  **coreaudio**);
* **SOUND_MODULE_KEY**: é um símbolo que representa o módulo
  internamente (como **SOUND_COREAUDIO**);

É necessário adicionar o caminho do arquivo para
**scripts/src/osd/modules.lua** em **osdmodulesbuild()** e a referência
do módulo para **src/osd/modules/lib/osdobj_common.cpp** em
**osd_common_t::register_options** com a linha:

.. code-block:: C++

    REGISTER_MODULE(m_mod_man, SOUND_MODULE_KEY);

Isso deve garantir que o módulo possa ser acessado por meio de
**-sound <xxx>** nos hospedeiros apropriados.


Interface
~~~~~~~~~

A interface completa é a seguinte:

.. code-block:: C++

    virtual bool split_streams_per_source() const override;
    virtual bool external_per_channel_volume() const override;

    virtual int init(osd_interface &osd, osd_options const &options) override;
    virtual void exit() override;

    virtual uint32_t get_generation() override;
    virtual osd::audio_info get_information() override;
    virtual uint32_t stream_sink_open(uint32_t node, std::string name, uint32_t rate) override;
    virtual uint32_t stream_source_open(uint32_t node, std::string name, uint32_t rate) override;
    virtual void stream_set_volumes(uint32_t id, const std::vector<float> &db) override;
    virtual void stream_close(uint32_t id) override;
    virtual void stream_sink_update(uint32_t id, const int16_t *buffer, int samples_this_frame) override;
    virtual void stream_source_update(uint32_t id, int16_t *buffer, int samples_this_frame) override;


A classe sound_module fornece padrões para os recursos mínimos: um alvo
estéreo e um fluxo na taxa de amostragem padrão. Para dar suporte a
isso, apenas **init**, **exit** e **stream_update** precisam ser
implementados. O **init** é invocado na inicialização e **exit**,
ao encerrar, pode fazer o que for necessário. O **stream_sink_update**
é invocado regularmente com um *buffer* do **sample_this_frame** * 2 *
**int16_t**, com o áudio a ser reproduzido. A partir deste ponto da
documentação, assumiremos que é necessário mais do que um único canal
estéreo.


Capacidades
~~~~~~~~~~~

Dois métodos são utilizados pelo módulo para indicar seu nível de
capacidade:

* A função **split_streams_per_source()** deve retornar **true** quando
  houver vários fluxos para um destino (os níveis 2 ou 3 por exemplo);

* A função **external_per_channel_volume()** deve retornar **true**
  quando os fluxos tiverem controle de volume por canal que possa ser
  controlado externamente (nível 3 por exemplo);


Informações sobre hardware e gerações
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O núcleo é executado com base no pressuposto de que os recursos de
hardware do hospedeiro podem se alterar a qualquer momento (dispositivos
Bluetooth ligando e desligando, USB plug-and-play, etc.) e que o módulo
tem alguma maneira de manter o controle sobre o que está acontecendo,
possivelmente usando *multithreading*. Para manter a leveza, usamos o
conceito de *geração*, que é um número de 32 bits incrementado pelo
módulo sempre que algo muda. O núcleo verifica o valor da geração atual
pelo menos uma vez a cada atualização (geralmente, um quadro por vez) e,
se houver alteração, solicita o novo estado, detecta e trata as
diferenças. A *geração* deve ser "eventualmente estável", ou seja, ela
para de alterar quando o usuário para de alterar as coisas o tempo todo.
Um incremento sistemático a cada quadro seria uma má ideia.

.. code-block:: C++

    virtual uint32_t get_generation() override;

Esse método retorna o número da geração atual. Ele é chamado no mínimo
uma vez por atualização, o que geralmente significa, por quadro. Quando
não há eventos especiais, ele deve ser relativamente leve.

.. raw:: latex

	\clearpage


.. code-block:: C++

    virtual osd::audio_info get_information() override;

    struct audio_rate_range {
        uint32_t m_default_rate;
        uint32_t m_min_rate;
        uint32_t m_max_rate;
    };

    struct audio_info {
        struct node_info {
                std::string m_name;
                uint32_t m_id;
                audio_rate_range m_rate;
		std::vector<std::string> m_port_names;
		std::vector<std::array<double, 3>> m_port_positions;
		uint32_t m_sinks;
		uint32_t m_sources;
        };

        struct stream_info {
                uint32_t m_id;
                uint32_t m_node;
                std::vector<float> m_volumes;
        };

        uint32_t m_generation;
        uint32_t m_default_sink;
        uint32_t m_default_source;
        std::vector<node_info> m_nodes;
        std::vector<stream_info> m_streams;
    };

Ele deve fornecer todas as informações sobre o estado atual do
hospedeiro e do módulo. Esse estado é:

* **m_generation**: o número da geração atual;
* **m_nodes**: o vetor de nós disponíveis (**node_info**);

  * **m_name**: o nome do nó;
  * **m_id**: a ID numérica do nó;
  * **m_rate**: a taxa de amostragem mínima, máxima e preferencial para
    o nó;
  * **m_port_names**: o vetor dos nomes das portas;
  * **m_port_positions**: o vetor da posição 3D das portas. Consulte
    **src/emu/speaker.h** para obter as posições predefinidas;
  * **m_sinks**: A quantidade de sinks (entradas);

* **m_sources**: a quantidade de fontes (saídas);
* **m_default_sink**: a ID do nó padrão atual do sistema para saída de
  áudio é **0** (zero) a menos que haja tal conceito;
* **m_default_source**: o mesmo para a entrada de áudio (não utilizado
  no momento);
* **m_streams**: a vetor de fluxos ativos (**stream_info**);

  * **m_id**: a ID numérico do fluxo;
  * **m_node**: o nó de destino do fluxo;
  * **m_volumes**: é vazio se **external_per_channel_volume** for
    **false**; caso contrário, o valor do volume atual de cada canal;

As IDs, tanto para nós quanto para fluxos, são valores (independentes)
de 32 bits sem sinal e não nulos associados, respectivamente, a nós e
fluxos. As IDs não devem ser reutilizadas. Um nó que some e depois
retorna deve receber uma nova ID. O encerramento de um fluxo não permite
a reutilização da sua ID.

Se um nó tiver fontes e sinks (saídas), as fontes são monitores das
saídas, por exemplo, são *loopbacks*. Nesse caso, elas devem ter a mesma
contagem.

O nó deve ser independente. Deve ser possível abrir fluxos para dois nós
diferentes simultaneamente. Tenha cuidado com as bibliotecas de várias
APIs que podem entrar em conflito entre si. Além disso, com fluxos de
monitoramento, deve ser possível abrir fluxos separados para entrada e
saída. Se isso não for possível, não publique as entradas de
monitoramento.

Quando houver controle externo, um módulo deve alterar o valor da função
**stream_info::m_node** e **stream_info::m_volumes** quando o usuário o
alterar. O número da geração deve ser incrementado quando isso
acontecer, para que o núcleo saiba que deve procurar por alterações.

Os volumes são flutuantes em dB, sendo que **0** significa **100%** e
**-96** significa **sem áudio**. O arquivo **audio.h** fornece os
métodos **db_to_linear** e **linear_to_db**, caso essa conversão seja
necessária.

Há dois valores especiais de posição:

* **unknown()**: a posição do alto-falante ou do microfone é
  desconhecida, mas a posição ainda deve ser usada. A posição será
  centralizada;
* **map_on_request_only()**: significa que a entrada ou saída não deve
  ser usada para mapeamentos completos, mas somente quando
  explicitamente solicitada com um mapeamento de canal;

Há uma condição de corrida inerente a esse sistema, pois as coisas podem
mudar a qualquer momento após o retorno do método. A ideia é que as
informações retornadas sejam internamente consistentes (um fluxo não
deve apontar para um ID de nó que não exista na estrutura, o mesmo vale
para o destino padrão) e que qualquer alteração externa desse estado
incremente o número de geração. Por meio do sistema de geração, o núcleo
acabará por estar em sincronia com a realidade.


Fluxos de entrada e saída
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    virtual uint32_t stream_sink_open(uint32_t node, std::string name, uint32_t rate) override;
    virtual uint32_t stream_source_open(uint32_t node, std::string name, uint32_t rate) override;
    virtual void stream_set_volumes(uint32_t id, const std::vector<float> &db) override;
    virtual void stream_close(uint32_t id) override;
    virtual void stream_sink_update(uint32_t id, const int16_t *buffer, int samples_this_frame) override;
    virtual void stream_source_update(uint32_t id, int16_t *buffer, int samples_this_frame) override;

Os fluxos são o conceito utilizado para enviar ou receber áudio de/para
o sistema de áudio anfitrião. Um fluxo é primeiro aberto através da
função **stream_sink_open** para alto-falantes e **stream_source_open**
para microfones, tendo como alvo um nó específico a uma taxa de
amostragem específica. É-lhe dado um nome para ser utilizado pelos
serviços de som do anfitrião para fins da IU (atualmente, o nome do
jogo, se **split_streams_per_source** for **false**, e a etiqueta
**speaker_device/microphone_device**, se for **true**). A ID devolvida
deve ser diferente de zero e nunca ter sido utilizado antes para
fluxos em caso de sucesso. As falhas, como quando o nó desaparece entre
as chamadas **get_information** e **open**, devem ser silenciosas e
retornar zero.

* **stream_set_volumes** é usado apenas quando
  **external_per_channel_volume** for **true** e é usado pelo núcleo
  para definir o volume por canal. A chamada deve ser ignorada se a ID
  do fluxo não existir (ou for zero). Não tente aplicar volumes no
  módulo se a API do hospedeiro não oferecer essa função; deixe o núcleo
  lidar com isso;
* **stream_close** fecha um fluxo; a chamada deve ser ignorada se a ID
  do fluxo não existir (ou for zero);

Abrir, fechar ou alterar o volume de um fluxo não exige que se toque no
número da geração.

* **stream_sink_update** é o método utilizado para enviar dados para o
  nó por meio de um fluxo específico. Ele fornece um buffer com valores
  **int16_t** de
  **samples_this_frame** * **node channel count channel-interleaved**. O
  tempo de vida dos dados na memória intermédia ou do próprio ponteiro
  da memória intermédia é indefinido após o retorno da chamada do
  método. A chamada deve ser ignorada se a ID do fluxo não existir
  (ou for zero);
* **stream_source_update** é o equivalente a recuperar dados de um nó,
  escrevendo no buffer em vez de lê-lo. As restrições são idênticas;

Quando um fluxo some porque o nó de destino é perdido, ele deve ser
simplesmente removido das informações, o núcleo assumirá o nó e
fechará o fluxo.

Dado o pressuposto de competição pela interface, todos os métodos devem
tolerar a utilização pelo núcleo das IDs obsoletas ou nulas, portanto a
reutilização das IDs deve ser evitada. Além disso, os métodos de
atualização e os de abertura/fechamento/volume podem ser chamados
simultaneamente em *threads* diferentes.


Classe de assistência *abuffer*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    class abuffer {
    public:
        abuffer(uint32_t channels);
        void get(int16_t *data, uint32_t samples);
        void push(const int16_t *data, uint32_t samples);
        uint32_t channels() const;
    };

A classe **abuffer** é um auxiliar fornecido pelo módulo
**sound_module** para armazenar a entrada ou saída de áudio em *buffer*.
Ela descarta automaticamente os dados quando há um estouro e duplica a
última amostra quando há um estouro. Deve ser inicializada primeiro com
a quantidade de canais, se necessário, pode ser recuperado com o método
**channels()**. O método **push** envia amostras 16 bit
**samples** * **channels** para o *buffer*. O método get recupera
amostras 16 bit **samples** * **channels** do *buffer* em ordem *FIFO*.

.. tip:: **FIFO** significa "*first in, first out*". Em português
   significa "*primeiro a entrar, primeiro a sair*" (PEPS).

Não está protegido contra *multithreading*, mas não utiliza variáveis de
classe. Portanto, não é possível ler e escrever uma instância específica
do **abuffer** ao mesmo tempo. O bloqueio obrigatório da interface de
áudio do sistema deve ser suficiente para garantir isso.

.. _GENie: https://github.com/bkaradzic/GENie
