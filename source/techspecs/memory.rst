.. raw:: latex

	\clearpage

A memória emulada do sistema e o gerenciamento dos espaços de endereçamento
===========================================================================

.. contents:: :local:

Resumo
------

O subsistema da memória (``emumem`` e o ``addrmap``) combina várias
funções úteis para a emulação do sistema:

* a decodificação do barramento do endereço e o despacho com cache
* as descrições estáticas de um mapa de endereçamento
* a alocação da RAM e do registro para o registro do estado
* a interação com as regiões da memória para acessar a rom

Os dispositivos criam espaços de endereçamento, como por exemplo um
barramento decodificável, através do ``device_memory_interface``.  A
configuração da máquina define o endereço dos mapas para colocar nos
espaços de endereçamento, assim o dispositivo pode ler e escrever
através do barramento.

Conceitos Básicos
-----------------

O Endereçamento
~~~~~~~~~~~~~~~

Um espaço de endereçamento implementado na classe **address_space**,
representa um barramento endereçável com vários sub-dispositivos em
potenciais conectados que exigem uma decodificação. Possui várias linhas
de dados (8, 16, 32 ou 64) chamada largura de dados, várias linhas de
endereços (1 a 32) chamado largura de endereço e um **endianness**.
Além disso uma mudança de endereço permite que barramentos que tenham
uma granularidade atômica diferente de 1 byte.

Os objetos do espaço de endereço fornecem uma série de métodos para o
acesso a leitura e a gravação, assim como uma segunda série de métodos
para alterar dinamicamente a decodificação.


Os mapas de endereçamento
~~~~~~~~~~~~~~~~~~~~~~~~~

Um mapa de endereçamento é uma descrição estática da decodificação
prevista quando um barramento for utilizado. Ele se conecta à memória,
a outros dispositivos e a outros métodos, geralmente é instalado na
inicialização em um endereçamento. Esta descrição é armazenada em uma
estrutura **address_map** que é preenchida programaticamente.


As ações, os bancos e as regiões
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Os compartilhamentos da memória são zonas da memória que são alocadas e
podem ser colocadas em vários lugares no mesmo espaço de endereço ou em
um endereço diferente, eles também podem ser acessado de forma direta a
partir dos dispositivos.

Os bancos de memória são zonas que acessam a memória de forma indireta
dando a possibilidade de se alterar de forma dinâmica e eficiente a zona
de uma região específica.

As regiões da memória são zonas da memória de somente leitura onde as
ROMs são carregadas.

Todos eles têm nomes com permissão de acesso.

Visualizações
~~~~~~~~~~~~~

As visualizações são uma forma de misturar diferentes submapas em uma
faixa da memória com comutação rápida. É para ser usado quando diversos
dispositivos mapearem nos mesmos endereços e forem comutados
externamente. Elas devem ser criadas como um objeto do dispositivo e
depois configuradas estaticamente num mapa de memória ou dinamicamente
através das chamadas ``install_*``.

Os submapas intercambiáveis, também conhecidos como variantes, são
nomeados através de um número inteiro. Uma indexação interna através de
um mapa garante que qualquer valor inteiro possa ser usado.

Os objetos da memória
---------------------

Compartilhamentos - memory_share
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	class memory_share {
		const std::string &name() const;
		void \*ptr() const;
		size_t bytes() const;
		endianness_t endianness() const;
		u8 bitwidth() const;
		u8 bytewidth() const;
	};

Um compartilhamento da memória é uma zona nomeada da memória alocada que
é automaticamente gravada como estados e podem ser mapeados nos
endereçamentos. É o contêiner predefinido para a memória que é
compartilhada entre os espaços, mas também compartilhado entre uma CPU
emulada e um driver.  Como tal, é fácil ter acesso ao seu conteúdo a
partir da classe do driver.

.. code-block:: C++

	required_shared_ptr<uNN> m_share_ptr;
	optional_shared_ptr<uNN> m_share_ptr;
	required_shared_ptr_array<uNN, count> m_share_ptr_array;
	optional_shared_ptr_array<uNN, count> m_share_ptr_array;
	
	[device constructor] m_share_ptr(\*this, "name"),
	[device constructor] m_share_ptr_array(\*this, "name%u", 0U),

No nível do dispositivo, um ponteiro para a zona de memória pode ser
facilmente recuperada através da construção de um destes quatro
localizadores. Observe que como cada localizador chamando um
``target()`` no localizador dá a você o objeto ``memory_share``.

.. code-block:: C++

	memory_share_creator<uNN> m_share;
	
	[device constructor] m_share(\*this, "name", size, endianness),

Um compartilhamento da memória pode ser criado caso ele não exista em um
mapa da memória através dessa classe de criação. Caso já exista basta
recupera-la. Esta classe se comporta como um ponteiro mas também tem o
método ``target()`` para obter o objeto ``memory_share`` e os métodos de
compartilhamento de informação ``bytes()``, ``endianness()``,
``bitwidth()`` e o ``bytewidth()``.

.. code-block:: C++

	memory_share \*memshare(string tag) const;

O método do dispositivo ``memshare`` recupera um compartilhamento da
memória por nome.  Cuidado pois a pesquisa pode ser dispendiosa, em vez
disso prefira os localizadores.

.. raw:: latex

	\clearpage

Bancos - memory_bank
~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	class memory_bank {
	const std::string &tag() const;
	int entry() const;
	void set_entry(int entrynum);
	void configure_entry(int entrynum, void \*base);
	void configure_entries(int startentry, int numentry, void \*base, offs_t stride);
	void set_base(void \*base);
	void \*base() const;
	};

Um banco de memória é um desreferenciamento do nome da zona da memória
que pode ser mapeada nos espaços de endereçamento.  Ele aponta para
``nullptr`` quando é criado. O ``configure_entry`` permite definir uma
relação entre um número da entrada e um ponteiro base. O
``configure_entries`` faz o mesmo através das diversas entradas
consecutivas que abrangem uma zona da memória. Alternativamente o
``set_base`` define a base para a entrada 0 e a seleciona.

O ``set_entry`` permite selecionar de forma dinâmica e eficientemente
a entrada ativa atual, o ``entry()`` obtém esta seleção de volta e
``base()`` obtém o ponteiro associado a base.

.. code-block:: C++

	required_memory_bank m_bank;
	optional_memory_bank m_bank;
	required_memory_bank_array<count> m_bank_array;
	optional_memory_bank_array<count> m_bank_array;
	
	[device constructor] m_bank(\*this, "name"),
	[device constructor] m_bank_array(\*this, "name%u", 0U),

No nível do dispositivo, um ponteiro para o objeto do banco da memória
pode ser facilmente recuperado ao construir um destes quatro
localizadores.

.. code-block:: C++

	memory_bank_creator m_bank;
	
	[device constructor] m_bank(\*this, "name"),

Um compartilhamento da memória pode ser criado caso ele não exista em um
mapa da memória através dessa classe de criação. Caso já exista basta
recupera-la.

.. code-block:: C++

	memory_bank \*membank(string tag) const;

O método do dispositivo ``memshare`` recupera um compartilhamento da
memória por nome.  Cuidado pois a pesquisa pode ser dispendiosa, em vez
disso prefira os localizadores.

.. raw:: latex

	\clearpage

Regiões - memory_region
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	class memory_bank {
	u8 \*base();
	u8 \*end();
	u32 bytes() const;
	const std::string &name() const;
	endianness_t endianness() const;
	u8 bitwidth() const;
	u8 bytewidth() const;
	u8 &as_u8(offs_t offset = 0);
	u16 &as_u16(offs_t offset = 0);
	u32 &as_u32(offs_t offset = 0);
	u64 &as_u64(offs_t offset = 0);
	}

Uma região é usada para armazenar dados de somente leitura, como as ROMs
ou o resultado das descriptografias fixadas. O seu conteúdo não são
salvos, é por isso que eles não devem ser gravado a partir do sistema
emulado. Eles na realidade não possuem uma largura intrínseca
(``base()`` sempre retorna um u8 \*), que é histórico e praticamente
impossível de consertar neste ponto.  Os métodos ``as_*`` permitem
acessá-los a partir de uma determinada largura.

.. code-block:: C++

	required_memory_region m_region;
	optional_memory_region m_region;
	required_memory_region_array<count> m_region_array;
	optional_memory_region_array<count> m_region_array;
	
	[device constructor] m_region(\*this, "name"),
	[device constructor] m_region_array(\*this, "name%u", 0U),

No nível do dispositivo, um ponteiro para o objeto da região da memória
pode ser facilmente recuperado através da construção de um destes quatro
localizadores.

::

	memory_region \*memregion(string tag) const;

O método do dispositivo ``memshare`` recupera um compartilhamento da
memória por nome. Cuidado pois a pesquisa pode ser dispendiosa, em vez
disso prefira os localizadores.

.. raw:: latex

	\clearpage

Visualizações - memory_view
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

    class memory_view {
        memory_view(device_t &device, std::string name);
        memory_view_entry &operator[](int slot);

        void select(int entry);
        void disable();

        const std::string &name() const;
    }

Uma visualização permite alternar parte de um mapa de memória entre
diversas possibilidades ou mesmo desabilitá-lo completamente para ver o
que estava lá antes. Ele é criado como um objeto do dispositivo.

.. code-block:: C++

    memory_view m_view;

    [device constructor] m_view(*this, "name"),

Então será configurado através da API do mapa de endereços ou
dinamicamente. Durante a execução uma quantidade de variantes podem ser
selecionadas utilizando o método ``select`` ou a visualização pode ser
desativada utilizando o método ``disable``. Uma visualização desativada
pode ser reativada a qualquer momento.

O API dos mapas de endereçamentos
---------------------------------

A estrutura geral da API
~~~~~~~~~~~~~~~~~~~~~~~~

Um mapa de endereçamento é um método onde um dispositivo que preenche a
estrutura de um **address_map** geralmente chamada de **mapa**, passada
através de uma referência. O método então pode definir alguma
configuração global através de métodos específicos e em seguida,
oferecer as entradas orientadas para o intervalo de endereços que
indicam o que deve acontecer quando um intervalo específico for
acessado.

A sintaxe geral para as entradas utiliza um método de encadeamento:

.. code-block:: C++

	map(start, end).handler(...).handler_qualifier(...).range_qualifier();

Os valores ``start`` e ``end`` definem o intervalo, o bloco ``handler()`` define
como o acesso é tratado, o bloco ``handler_qualifier()`` determina
alguns aspectos do manipulador (como o compartilhamento da memória, por exemplo) e o
O bloco ``range_qualifier()`` refina o intervalo (o espelhamento, o mascaramento, o byte
a seleção...).

O mapa segue um princípio do "o último ganha", onde o último é
selecionado quando vários manipuladores correspondem a um determinado
endereço.


As configurações globais
~~~~~~~~~~~~~~~~~~~~~~~~

Mascaramento global
'''''''''''''''''''

.. code-block:: C++

	map.global_mask(offs_t mask);

Permite indicar uma máscara que será aplicada em todos os endereços
quando acessar o espaço onde o mapa estiver instalado.


O valor retornado na leitura não mapeada/nop-ed
'''''''''''''''''''''''''''''''''''''''''''''''

.. code-block:: C++

	map.unmap_value_low();
	map.unmap_value_high();
	map.unmap_value(u8 value);

Define o valor para retornar nas leituras para um endereço não mapeado
ou sem saída. Low significa ``0``, high ``~0``.

.. raw:: latex

	\clearpage

A configuração do manipulador
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O método no dispositivo atual
'''''''''''''''''''''''''''''

.. code-block:: C++

	(...).r(FUNC(my_device::read_method))
	(...).w(FUNC(my_device::write_method))
	(...).rw(FUNC(my_device::read_method), FUNC(my_device::write_method))
	
	uNN my_device::read_method(address_space &space, offs_t offset, uNN mem_mask)
	uNN my_device::read_method(address_space &space, offs_t offset)
	uNN my_device::read_method(address_space &space)
	uNN my_device::read_method(offs_t offset, uNN mem_mask)
	uNN my_device::read_method(offs_t offset)
	uNN my_device::read_method()
	
	void my_device::write_method(address_space &space, offs_t offset, uNN data, uNN mem_mask)
	void my_device::write_method(address_space &space, offs_t offset, uNN data)
	void my_device::write_method(address_space &space, uNN data)
	void my_device::write_method(offs_t offset, uNN data, uNN mem_mask)
	void my_device::write_method(offs_t offset, uNN data)
	void my_device::write_method(uNN data)

Define um método do dispositivo ou driver atual para ler, escrever ou
ambos na entrada atual.  O protótipo do método pode levar diversas
formas que tornam alguns elementos opcionais.  uNN representa ``u8``,
``u16``, ``u32`` ou ``u64`` dependendo da largura dos dados do
manipulador. O manipulador pode ser menos largo do que o próprio
barramento (por exemplo, um dispositivo de 8 bits em um barramento com
32 bits).

O offset informado é criado a partir do endereço de acesso.  Começa com
zero no início do intervalo com incrementos para cada unidade ``uNN``.
Um manipulador ``u8`` obterá um offset em bytes, um ``u32`` em ``words``
duplas. O ``mem_mask`` tem os seus bits definidos onde os acessadores de
fato fazem a condução do bit. Geralmente é construído em unidades de
byte, porém em alguns casos dos CIs das portas de E/S com os registros
de direção por bit, a resolução pode estar no nível de bits.


O método em um dispositivo diferente
''''''''''''''''''''''''''''''''''''

.. code-block:: C++

	(...).r(m_other_device, FUNC(other_device::read_method))
	(...).r("other-device-tag", FUNC(other_device::read_method))
	(...).w(m_other_device, FUNC(other_device::write_method))
	(...).w("other-device-tag", FUNC(other_device::write_method))
	(...).rw(m_other_device, FUNC(other_device::read_method), FUNC(other_device::write_method))
	(...).rw("other-device-tag", FUNC(other_device::read_method), FUNC(other_device::write_method))

Define um método de um outro dispositivo, designado através de um
localizador (``required_device`` ou ``optional_device``) ou sua tag,
para ler, escrever ou ambos na entrada atual.

.. raw:: latex

	\clearpage

A função lambda
'''''''''''''''

.. code-block:: C++

	(...).lr{8,16,32,64}(NAME([...](address_space &space, offs_t offset, uNN mem_mask) -> uNN { ... }))
	(...).lr{8,16,32,64}([...](address_space &space, offs_t offset, uNN mem_mask) -> uNN { ... }, "name")
	(...).lw{8,16,32,64}(NAME([...](address_space &space, offs_t offset, uNN data, uNN mem_mask) -> void { ... }))
	(...).lw{8,16,32,64}([...](address_space &space, offs_t offset, uNN data, uNN mem_mask) -> void { ... }, "name")
	(...).lrw{8,16,32,64}(NAME(read), NAME(write))
	(...).lrw{8,16,32,64}(read, "name_r", write, "name_w")

Define um lambda que é chamada durante a leitura, a gravação ou em
ambos. O protótipo lambda pode ser qualquer um dos 6 métodos
disponíveis.  Um pode ou utilizar ``FUNC()`` sobre toda a lambda ou
informar um nome após a definição da lambda. O número é a largura de
dados do acesso, como o ``NN`` por exemplo.


O acesso direto à memória
'''''''''''''''''''''''''

.. code-block:: C++

	(...).rom()
	(...).writeonly()
	(...).ram()

Seleciona uma faixa do intervalo para acessar uma zona da memória como
somente leitura (read-only), somente gravação (write-only) ou leitura e
gravação (read-write) respectivamente. Qualificadores específicos do
manipulador permite dizer onde esta zona da memória deveria estar.
Existem dois casos onde não qualificador é aceitável:

* ``ram()`` dá uma zona ram anônima não acessível fora do
  espaço de endereçamento.

* ``rom()`` quando o mapa da memória é utilizado em um ``AS_PROGRAM``
  espaço de um dispositivo (CPU) cujos nomes também sejam o nome de uma
  região.
  Em seguida, a zona da memória aponta para essa região no offset
  correspondente ao início da zona.

.. code-block:: C++

	(...).rom().region("name", offset)

O qualificador da região permite fazer um ponto somente leitura da zona
para o conteúdo de uma determinada região em um determinado offset.

.. code-block:: C++

	(...).rom().share("name")
	(...).writeonly.share("name")
	(...).ram().share("name")

O qualificador de compartilhamento permite fazer o ponto da zona para
uma região da memória compartilhada definida através do seu nome. Caso a
região esteja presente em diversos espaços o endianness deve
corresponder caso o tamanho, a largura do barramento e se o barramento
tiver mais do que um byte de largura.


O acesso ao banco
'''''''''''''''''

.. code-block:: C++

	(...).bankr("name")
	(...).bankw("name")
	(...).bankrw("name")

Define a faixa do intervalo para apontar para o conteúdo de um banco que
é lido, escrito ou em modo de leitura e escrita.


O acesso à porta
''''''''''''''''

.. code-block:: C++

	(...).portr("name")
	(...).portw("name")
	(...).portrw("name")

Define a faixa do intervalo para apontar para uma porta de E/S.


Os acessos descartados
''''''''''''''''''''''

.. code-block:: C++

	(...).nopr()
	(...).nopw()
	(...).noprw()

Define a faixa do intervalo para descartar o acesso sem registrar o log.
Durante a leitura, um valor não mapeado é retornado.


O acesso não mapeado
''''''''''''''''''''

.. code-block:: C++

	(...).unmapr()
	(...).unmapw()
	(...).unmaprw()

Define a faixa do intervalo para descartar o acesso com registro no log.
Durante a leitura, um valor não mapeado é retornado.


O mapeamento do sub-dispositivo
'''''''''''''''''''''''''''''''

.. code-block:: C++

	(...).m(m_other_device, FUNC(other_device::map_method))
	(...).m("other-device-tag", FUNC(other_device::map_method))

Inclui um submapa definido pelo dispositivo. O início da faixa do
intervalo indica onde termina o endereço zero do submapa, e o fim do
intervalo corta o submapa caso seja necessário. Observe que os
qualificadores do intervalo (definidos posteriormente) se aplicam.

Atualmente, apenas manipuladores são permitidos nos submapas e não nas
zonas da memória ou nos bancos.


Os qualificadores de alcance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O espelhamento
''''''''''''''

.. code-block:: C++

	(...).mirror(mask)

Duplica o intervalo nos endereços que estiverem acessíveis, definindo
qualquer um dos 1 bits presentes na máscara. Por exemplo, um intervalo
``0-0x1f`` com a máscara ``0x300`` estará presente em ``0-0x1f``,
``0x100-0x11f``, ``0x200-0x21f`` e ``0x300-0x31f``. Os endereços
informados para o manipulador permanecem no intervalo ``0-0x1f``, os
bits do espelho não são vistos.


O mascaramento
''''''''''''''

.. code-block:: C++

	(...).mask(mask)

Válido apenas com os manipuladores, o endereço será mascarado com a
máscara antes de ser passado para o manipulador.


A seleção
'''''''''

.. code-block:: C++

	(...).select(mask)

Válido apenas com manipuladores, a faixa do intervalo será espelhado com
espelho, mas os bits de endereçamento do espelho serão mantidos no
offset informado para o manipulador quando for chamado. Isso é útil para
os dispositivos como o CI de áudio onde os bits mais baixos do
endereçamento selecionam uma função e os bits mais altos um número da
voz.


A seleção da subunidade
'''''''''''''''''''''''

.. code-block:: C++

	(...).umask16(16-bits mask)
	(...).umask32(32-bits mask)
	(...).umask64(64-bits mask)

Válido apenas com manipuladores e submapas, seleciona quais as linhas
dos dados do barramento estão realmente conectados ao manipulador ou aos
dispositivos.  O dispositivo atual deve ser um múltiplo de um byte, por
exemplo, a máscara é uma série de ``00`` e ``ff``.  O offset será
ajustado de acordo, de modo que a diferença de 1 significa a próxima
unidade manuseada no acesso.

**CASO** a máscara seja mais estreita do que a largura do barramento, a
máscara será replicada nas linhas superiores.


O manuseio da seleção do CI na subunidade
'''''''''''''''''''''''''''''''''''''''''

.. code-block:: C++

	(...).cselect(16/32/64)

Quando um dispositivo está conectado na parte do barramento, como um
byte em um barramento de 16 bits, o manipulador do destino só é ativado
quando essa parte for de fato acessada.  Em alguns casos o acesso do
byte num barramento de 16-bits 68000 o hardware atual verifica apenas o
word do endereço e não se o byte correto é acessado.  O ``cswidth``
permite informar a memória do sistema para acionar o manipulador caso
uma parte mais ampla do barramento seja acessada.
O parâmetro é a largura do gatilho (seria 16 no caso do 68000).

Configuração da visualização
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

   map(start, end).view(m_view);
   m_view[0](start1, end1).[...];

Uma visualização é configurada em um mapa de endereços com o método de
visualização. O único qualificador aceito é o espelho. A versão
"desativada" da visualização incluirá o que estava na faixa antes da
configuração da visualização.

As diferentes variantes são configuradas através da indexação da
visualização com o número da variante e da criação de uma entrada da
maneira usual. As entradas dentro de uma variante devem permanecer
dentro do limite. Não há outras restrições adicionais. O conteúdo de uma
variante, por padrão é o que estava lá antes, por exemplo, o conteúdo da
vista desabilitada, e então a configuração permite anular parte ou a
totalidade dela.

As variantes só podem ser configuradas uma vez que a própria
visualização tenha sido configurada com o método ``view``.

Uma visualização só pode ser colocada em um mapa de endereços e em
apenas uma posição. Caso várias visualizações tenham o mesmo conteúdo ou
similar, lembre-se que a criação de um mapa não é mais do que uma
chamada do método e a criação de um segundo método para configurar uma
visualização é perfeitamente razoável. Uma visualização é do tipo
``memory_view`` e uma entrada indexada (por exemplo, uma variante para
configuração) é do tipo ``memory_view::memory_view_entry &``.

Uma visualização pode ser instalada em outra visualização mas não se
esqueça que uma visualização pode ser instalada apenas uma vez. Uma
visualização também pode fazer parte do "que estava lá antes".

.. raw:: latex

	\clearpage

O API do mapeamento dinâmico do espaço de endereçamento
-------------------------------------------------------

A estrutura geral da API
~~~~~~~~~~~~~~~~~~~~~~~~

Uma série de métodos permite alterar a decodificação do barramento de um
espaço de endereçamento em tempo real.  Eles são poderosos, porém têm
alguns problemas:

* Alterando os mapeamentos de forma repetida pode causar lentidão
* O estado do espaço do endereçamento não é registrado nos estados
  salvos, portanto, deve ser reconstruído após o carregamento do estado
* Podem ser ocultados em qualquer lugar, em vez de agrupados em um mapa
  do endereçamento, que pode ser menos legível

Os métodos em vez de decompor as informações no manipulador, o
qualificador do manipulador e a faixa do intervalo do qualificador os
coloca todos juntos como parâmetros do método. Para tornar as coisas um
pouco mais legíveis, muitos deles são opcionais, porém, os opcionais
sendo escritos em itálico.


O mapeamento do manipulador
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	uNN my_device::read_method(address_space &space, offs_t offset, uNN mem_mask)
	uNN my_device::read_method_m(address_space &space, offs_t offset)
	uNN my_device::read_method_mo(address_space &space)
	uNN my_device::read_method_s(offs_t offset, uNN mem_mask)
	uNN my_device::read_method_sm(offs_t offset)
	uNN my_device::read_method_smo()
	
	void my_device::write_method(address_space &space, offs_t offset, uNN data, uNN mem_mask)
	void my_device::write_method_m(address_space &space, offs_t offset, uNN data)
	void my_device::write_method_mo(address_space &space, uNN data)
	void my_device::write_method_s(offs_t offset, uNN data, uNN mem_mask)
	void my_device::write_method_sm(offs_t offset, uNN data)
	void my_device::write_method_smo(uNN data)
	
	readNN_delegate   (device, FUNC(read_method)) 
	readNNm_delegate  (device, FUNC(read_method_m)) 
	readNNmo_delegate (device, FUNC(read_method_mo)) 
	readNNs_delegate  (device, FUNC(read_method_s)) 
	readNNsm_delegate (device, FUNC(read_method_sm)) 
	readNNsmo_delegate(device, FUNC(read_method_smo)) 
	
	writeNN_delegate   (device, FUNC(write_method)) 
	writeNNm_delegate  (device, FUNC(write_method_m)) 
	writeNNmo_delegate (device, FUNC(write_method_mo)) 
	writeNNs_delegate  (device, FUNC(write_method_s)) 
	writeNNsm_delegate (device, FUNC(write_method_sm)) 
	writeNNsmo_delegate(device, FUNC(write_method_smo)) 


.. raw:: latex

	\clearpage

Para ser adicionado a um mapa, um método chama e o dispositivo é chamado
para serem agrupados no tipo delegado de forma apropriada. São 12
tipos, para a leitura, para a escrita e para todos os seis protótipos
possíveis.
Observe que como todos os delegados, eles também podem envolver lambdas.

.. code-block:: C++

	space.install_read_handler(addrstart, addrend, read_delegate, *unitmask*, *cswidth*)
	space.install_read_handler(addrstart, addrend, addrmask, addrmirror, addrselect, read_delegate, *unitmask*, *cswidth*)
	space.install_write_handler(addrstart, addrend, write_delegate, *unitmask*, *cswidth*)
	space.install_write_handler(addrstart, addrend, addrmask, addrmirror, addrselect, write_delegate, *unitmask*, *cswidth*)
	space.install_readwrite_handler(addrstart, addrend, read_delegate, write_delegate, *unitmask*, *cswidth*)
	space.install_readwrite_handler(addrstart, addrend, addrmask, addrmirror, addrselect, read_delegate, write_delegate, *unitmask*, *cswidth*)

Estes seis métodos permitem instalar manipuladores empacotados por
delegados em um espaço de endereçamento. seja plano ou com máscara,
espelho e select. No caso de leitura e escrita, ambos os delegados devem
ter o mesmo tipo (smo stuff) para evitar uma explosão combinatória de
tipos dos métodos.

O mapeamento direto da faixa do intervalo da memória
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	space.install_rom(addrstart, addrend, void \*pointer)
	space.install_rom(addrstart, addrend, addrmirror, void \*pointer)
	space.install_writeonly(addrstart, addrend, void \*pointer)
	space.install_writeonly(addrstart, addrend, addrmirror, void \*pointer)
	space.install_ram(addrstart, addrend, void \*pointer)
	space.install_ram(addrstart, addrend, addrmirror, void \*pointer)

Instala um bloco de memória em um espaço do endereço com ou sem espelho.
a ROM é somente leitura, a ram é leitura/gravação, ``writeonly`` é
somente gravação. O ponteiro não deve ser nulo, este método não alocará
a memória.

O mapeamento do banco
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	space.install_read_bank(addrstart, addrend, memory_bank \*bank)
	space.install_read_bank(addrstart, addrend, addrmirror, memory_bank \*bank)
	space.install_write_bank(addrstart, addrend, memory_bank \*bank)
	space.install_write_bank(addrstart, addrend, addrmirror, memory_bank \*bank)
	space.install_readwrite_bank(addrstart, addrend, memory_bank \*bank)
	space.install_readwrite_bank(addrstart, addrend, addrmirror, memory_bank \*bank)

Instala para a leitura, a gravação ou ambos em um banco existente da
memória em um espaço de endereçamento.

O mapeamento da porta
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	space.install_read_port(addrstart, addrend, const char \*rtag)
	space.install_read_port(addrstart, addrend, addrmirror, const char \*rtag)
	space.install_write_port(addrstart, addrend, const char \*wtag)
	space.install_write_port(addrstart, addrend, addrmirror, const char \*wtag)
	space.install_readwrite_port(addrstart, addrend, const char \*rtag, const char \*wtag)
	space.install_readwrite_port(addrstart, addrend, addrmirror, const char \*rtag, const char \*wtag)

Instala a leitura, a gravação ou ambas as portas através do nome.

Os acessos abandonados
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	space.nop_read(addrstart, addrend, *addrmirror*)
	space.nop_write(addrstart, addrend, *addrmirror*)
	space.nop_readwrite(addrstart, addrend, *addrmirror*)

Descarta os acessos para uma faixa do intervalo determinado com um
espelho opcional.

Os acessos não mapeados
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	space.unmap_read(addrstart, addrend, *addrmirror*)
	space.unmap_write(addrstart, addrend, *addrmirror*)
	space.unmap_readwrite(addrstart, addrend, *addrmirror*)

Desfaz o mapeamento dos acessos (por exemplo, faz o registro log do
acesso como não mapeado) para o alcance de uma determinada faixa do
intervalo com um espelho opcional.

A instalação do mapa do dispositivo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	space.install_device(addrstart, addrend, device, map, *unitmask*, *cswidth*)

Instala um endereço do dispositivo com um mapa de endereçamento em um
determinado espaço.

Instalação da visualização
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: C++

	space.install_view(addrstart, addrend, view)
	space.install_view(addrstart, addrend, addrmirror, view)

	view[0].install...

Instala uma visualização em um espaço. Isto só pode ser feito uma vez e
em apenas um espaço e a visualização não deve ter sido configurada antes
através da API do mapa de endereços. Uma vez instalada a visualização
pode ser selecionada através de indexação para chamar um método de
mapeamento dinâmico sobre ela.

Uma visualização pode ser instalada em uma variante de outra
visualização sem problemas com a única restrição usual de uma única
instalação.
