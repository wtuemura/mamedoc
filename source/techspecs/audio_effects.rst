.. raw:: latex

	\clearpage


.. _techspecs-audio-effects:

Efeitos de áudio
================

.. contents:: :local:


Aspectos gerais
---------------

Os efeitos de áudio são aplicados ao som entre os dispositivos de
alto-falantes e a saída de som atual. Na implementação atual, a cadeia
de efeitos é fixa (mas não os parâmetros dos efeitos), e os parâmetros
são armazenados em arquivos **.cfg**. Honestamente, ainda não foram
concebidos para serem extensíveis, e não há indícios de que algum dia
serão.

Para adicionar um efeito, é necessário dividir o processo em quatro
etapas:

* **audio_effects/aeffects.***, para criar e publicar objetos de efeito;
* **audio_effects/youreffect.***, para implementar o efeito;
* **frontend/mame/ui/audioeffects.cpp***, para poder instanciar o menu
  de configuração de efeitos;
* **frontend/mame/ui/audioyoureffect.***, para poder implementar o menu
  de configuração do efeito;


audio_effects/aeffects.*
------------------------

A classe **audio_effect** nas fontes **aeffect** oferece três recursos:

* Um valor enum para designar o tipo de efeito, que deve corresponder à
  sua posição na cadeia (ou seja, a cadeia de efeitos segue a ordem
  enum), no arquivo **.h**;
* O nome do efeito no array **audio_effect::effect_names** do arquivo
  **.cpp**;
* A criação de um objeto de efeito correto é feita em
  **audio_effect::create** no **.cpp**;


audio_effects/youreffect.*
--------------------------

É aqui que o efeito é implementado. Ele toma a forma de uma classe
**audio_effect_youreffect**, que deriva de **audio_effect**.

Os métodos a serem implementados são:

.. code-block:: C++

    audio_effect_youreffect(u32 sample_rate, audio_effect *def);

    virtual int type() const override;
    virtual void config_load(util::xml::data_node const *ef_node) override;
    virtual void config_save(util::xml::data_node *ef_node) const override;
    virtual void default_changed() override;
    virtual u32 history_size() const; // optional

O construtor deve passar os parâmetros para o **audio_effect** e
inicializar os parâmetros do efeito. O **type** deve retornar um valor
enumerado para o efeito. O **config_load** e o **config_save** devem
carregar ou guardar os parâmetros do efeito na árvore XML do arquivo
**.cfg**.
O **default_changed** é invocado quando os parâmetros em **m_default**
são alterados e os parâmetros podem precisar ser atualizados. O
**history_size** permite dizer quantas amostras ainda devem estar
disponíveis no quadro de entrada anterior. Note-se que esse número não
deve depender dos parâmetros, mas apenas da taxa de amostragem.

Um efeito tem uma quantidade de parâmetros que podem vir de três fontes:

* Um valor padrão fixo;
* Um objeto de efeito equivalente da cadeia de efeitos predefinida;
* configuração do utilizador por meio da IU;

Os dois primeiros são reconhecidos pelo valor de **m_default**, que
obtém o valor de **def** no construtor. O valor a ser utilizado quando
não é definido pelo usuário é o fixo, a menos que seja definido o valor
**m_default**.

No mínimo, um efeito deve ter um parâmetro que permita contorná-lo.

A gestão de um parâmetro utiliza quatro métodos:

* **type param() const;**:  retorna o valor do parâmetro atual;
* **void set_param(type value);**: define o valor do parâmetro atual e o
  marca como definido pelo usuário;
* **bool isset_param() const;**: retorna **true** se o parâmetro foi
  definido pelo usuário;
* **void reset_param();**: redefine o parâmetro para o valor padrão
  (de **m_default** ou fixo) e o marca como não definido pelo usuário;

O parâmetro **config_save** deve salvar apenas os parâmetros definidos
pelo usuário. Já **config_load** deve recuperar os parâmetros presentes,
marcá-los como definidos pelo usuário e redefinir todos os outros.

Por fim, a implementação real vai para o método **apply**:

.. code-block:: C++

    virtual void apply(const emu::detail::output_buffer_flat<sample_t> &src, emu::detail::output_buffer_flat<sample_t> &dest) override;

Esse método usa dois *buffers* com o mesmo número de canais e precisa
aplicar o efeito a **src** para produzir **dest**. O
**output_buffer_flat** não é intercalado com *buffers* independentes por
canal.

Para facilitar o desvio, o método ``copy(src, dest)`` de
**audio_effect** permite copiar as amostras de **src** para **dest** sem
alterá-las.

A parte do aplicativo de efeito deve ser configurada da seguinte
maneira:

.. code-block:: C++

    u32 samples = src.available_samples();
    dest.prepare_space(samples);
    u32 channels = src.channels();

    // Produz canais * e os resultados de amostras para enviá-los para o dest.

    dest.commit(samples);

Para obter ponteiros para os buffers, use:

.. code-block:: C++

    const sample_t *source = src.ptrs(channel, source_index); // source_index deve estar em [-history_size()..samples-1]
    sample_t *destination = dest.ptrw(channel, destination_index); // destination_index deve estar em [0..samples-1]

As amostras indicadas pela origem e pelo destino são contíguas. A
quantidade de canais não mudará de uma chamada de aplicação para outra,
mas a quantidade de amostras variará. Além disso, a chamada ocorre em
uma *thread* diferente da *thread* principal e também em uma *thread*
diferente daquela onde são feitas as chamadas de configuração de
parâmetros.


frontend/mame/ui/audioeffects.cpp
---------------------------------

Aqui é suficiente adicionar uma criação do menu
**menu_audio_effect_youreffect** em **menu_audio_effects::handle**. O
efeito do menu escolherá os nomes dos efeitos de **audio_effect** (em
**aeffect.***).


frontend/mame/ui/audioyoureffect.*
----------------------------------

Isso é usado para implementar o menu de configuração do efeito. É um
pouco complicado porque é preciso gerar a lista de parâmetros e seus
valores, definir os sinalizadores de seta para a esquerda ou para a
direita, dependendo das possíveis modificações, escurecê-los
(**FLAG_INVERT**) quando não forem definidos pelo usuário e gerenciar as
setas e as teclas de limpar para alterá-los. Basta copiar um menu
existente e alterá-lo conforme necessário.
