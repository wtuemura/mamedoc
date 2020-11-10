.. raw:: latex

	\clearpage

Os localizadores de objetos
===========================

.. contents:: :local:


Introdução
----------

Os localizadores de objetos são uma parte importante oferecida pelo MAME
como uma junção na união dos dispositivos que formam a emulação de um
sistema. São usados para definir as conexões entre os dispositivos
acessando os seus recursos de forma eficiente e também confirmando se
os mesmos estão disponíveis durante a validação.

Os localizadores procuram um objeto alvo através de uma tag através de
um dispositivo base. Para alguns tipos são necessários parâmetros
adicionais.

A maioria dos localizadores possuem versões obrigatórias e também
versões opcionais. As versões obrigatórias geram um erro caso o objeto
não seja encontrado no destino. Isso prevenirá que um dispositivo
seja iniciado inicie ou gere um erro de validação. As versões opcionais
irão registrar uma mensagem detalhada no caso do objeto não ter sido
encontrado no destino ou então, forneça membros de teste caso o objeto
no destino tenha ou não sido encontrado.

As classes do localizador são declaradas no cabeçalho
``src/emu/devfind.h`` e tem a sua API documentada em formato Doxygen.

.. raw:: latex

	\clearpage

Os tipos do localizador dos objetos
-----------------------------------

**required_device<DeviceClass>, optional_device<DeviceClass>**

	Encontra um dispositivo. O modelo do argumento ``DeviceClass`` deve
	ser uma classe derivada a partir do ``device_t`` ou do
	``device_interface``.

**required_memory_region, optional_memory_region**

	Encontra uma região da memória, geralmente a partir das definições
	das ROMs. O alvo é o objeto ``memory_region``.

**required_memory_bank, optional_memory_bank**

	Encontra um banco de memória instanciado em um mapa dos endereços.
	O alvo é o objeto ``memory_bank``.

**memory_bank_creator**

	Encontra um banco de memória instanciado em um mapa dos endereços ou
	o cria caso ele ainda não exista. O alvo é o objeto ``memory_bank``.
	Não há versão opcional, porque o objeto no destino sempre será
	encontrado ou será criado.

**required_ioport, optional_ioport**

	Encontra uma porta de E/S nas definições da porta de entrada em um
	dispositivo. O alvo é o objeto ``ioport_port``.

**required_address_space, optional_address_space**

	Encontra um espaço dos endereços de um dispositivo. O alvo é o
	objeto ``address_space``.

**required_region_ptr<PointerType>, optional_region_ptr<PointerType>**

	Encontra o ponteiro base de uma região da memória, geralmente a
	partir das definições das ROMs. O argumento do modelo
	``PointerType`` é o tipo do destino (geralmente um tipo inteiro e
	sem assinatura). O alvo é o primeiro elemento na região
	compartilhada da memória.

**required_shared_ptr<PointerType>, optional_shared_ptr<PointerType>**

	Encontra o ponteiro base de um compartilhamento da memória
	instanciado em um mapa dos endereços.
	O argumento do modelo ``PointerType`` é o tipo do destino
	(geralmente um tipo inteiro e sem assinatura). O alvo é o primeiro
	elemento na região compartilhada da memória.

**memory_share_creator<PointerType>**

	Encontra o ponteiro base de um compartilhamento da memória
	instanciado em um mapa dos endereços, ou o cria caso um ainda não
	exista.
	O argumento do modelo ``PointerType`` é o tipo do destino
	(geralmente um tipo inteiro sem assinatura). O alvo é o primeiro
	elemento no compartilhamento da memória. Não há versão opcional
	porque o objeto alvo sempre será encontrado ou será criado.

.. raw:: latex

	\clearpage

Localizando os recursos
-----------------------

Começaremos com um exemplo simples de um dispositivo que utiliza os
localizadores dos objetos para acessar a ramificação dos seus próprios
dispositivos, as entradas e a região da ROM. Os exemplos do código aqui
presente tem base na placa da interface da impressora paralela do
Apple II, porém visando a simplificação dos exemplos, muita coisa foi
removida.

Os localizadores são declarados como membros da classe do dispositivo::

	class a2bus_parprn_device : public device_t, public device_a2bus_card_interface
	{
	public:
		a2bus_parprn_device(machine_config const &mconfig, char const *tag, device_t *owner, u32 clock);
	
		virtual void write_c0nx(u8 offset, u8 data) override;
		virtual u8 read_cnxx(u8 offset) override;
	
	protected:
		virtual tiny_rom_entry const *device_rom_region() const override;
		virtual void device_add_mconfig(machine_config &config) override;
		virtual ioport_constructor device_input_ports() const override;
	
	private:
		required_device<centronics_device>      m_printer_conn;
		required_device<output_latch_device>    m_printer_out;
		required_ioport                         m_input_config;
		required_region_ptr<u8>                 m_prom;
	};

Queremos encontrar um ``centronics_device``, um ``output_latch_device``,
uma porta E/S e uma região da memória 8 bits.

No construtor, definimos o alvo inicial para os localizadores::

	a2bus_parprn_device::a2bus_parprn_device(machine_config const &mconfig, char const *tag, device_t *owner, u32 clock) :
		device_t(mconfig, A2BUS_PARPRN, tag, owner, clock),
		device_a2bus_card_interface(mconfig, *this),
		m_printer_conn(*this, "prn"),
		m_printer_out(*this, "prn_out"),
		m_input_config(*this, "CFG"),
		m_prom(*this, "prom")
	{
	}

Cada localizador recebe um dispositivo base e uma tag com argumentos do
construtor. O dispositivo base informado na construção atende a dois
propósitos. O mais óbvio, a tag, que é definida em relação a este
dispositivo e provavelmente o mais importante, o objeto se registra
com este dispositivo para que seja chamado para realizar a validação
e a resolução dos objetos.

.. raw:: latex

	\clearpage

Observe que os localizadores *não* copiam as strings das tags.
O solicitante deve garantir que a string da tag se mantenha válida até
o final da validação e/ou até que a resolução seja concluída e que a
região da memória e da porta de E/S venha a partir da definição e da
entrada da ROM respectivamente::

	namespace {

	ROM_START(parprn)
		ROM_REGION(0x100, "prom", 0)
		ROM_LOAD( "prom.b4", 0x0000, 0x0100, BAD_DUMP CRC(00b742ca) SHA1(c67888354aa013f9cb882eeeed924e292734e717) )
	ROM_END
	
	INPUT_PORTS_START(parprn)
		PORT_START("CFG")
		PORT_CONFNAME(0x01, 0x00, "Acknowledge latching edge")
		PORT_CONFSETTING(   0x00, "Falling (/Y-B)")
		PORT_CONFSETTING(   0x01, "Rising (Y-B)")
		PORT_CONFNAME(0x06, 0x02, "Printer ready")
		PORT_CONFSETTING(   0x00, "Always (S5-C-D)")
		PORT_CONFSETTING(   0x02, "Acknowledge latch (Z-C-D)")
		PORT_CONFSETTING(   0x04, "ACK (Y-C-D)")
		PORT_CONFSETTING(   0x06, "/ACK (/Y-C-D)")
		PORT_CONFNAME(0x08, 0x00, "Strobe polarity")
		PORT_CONFSETTING(   0x00, "Negative (S5-A-/X, GND-X)")
		PORT_CONFSETTING(   0x08, "Positive (S5-X, GND-A-/X)")
		PORT_CONFNAME(0x10, 0x10, "Character width")
		PORT_CONFSETTING(   0x00, "7-bit")
		PORT_CONFSETTING(   0x10, "8-bit")
	INPUT_PORTS_END
	
	} // anonymous namespace
	
	tiny_rom_entry const *a2bus_parprn_device::device_rom_region() const
	{
		return ROM_NAME(parprn);
	}
	
	ioport_constructor a2bus_parprn_device::device_input_ports() const
	{
		return INPUT_PORTS_NAME(parprn);
	}

Observe que as tags ``"prom"`` e o ``"CFG"`` correspondem às tags
passadas ao objeto em construção.

.. raw:: latex

	\clearpage

A ramificação dos dispositivos são instanciados na função do membro de
configuração da máquina do dispositivo:

.. code-block:: C++

	void a2bus_parprn_device::device_add_mconfig(machine_config &config)
	{
		CENTRONICS(config, m_printer_conn, centronics_devices, "printer");
		m_printer_conn->ack_handler().set(FUNC(a2bus_parprn_device::ack_w));
	
		OUTPUT_LATCH(config, m_printer_out);
		m_printer_conn->set_output_latch(*m_printer_out);
	}

Os localizadores são passados para os tipos dos dispositivos para
fornecer as tags ao instanciar os dispositivos herdados. Depois de
instanciar um dispositivo ramificado desta forma, o objeto pode ser
utilizado como um ponteiro para o dispositivo até o final da
configuração da função do membro de configuração da máquina. Observe que
para usar um localizador como este, o seu dispositivo base
deve ser o mesmo que o dispositivo que está sendo configurado (o
ponteiro ``this`` da função do membro de configuração da máquina).

Após a inicialização da máquina emulada os localizadores podem ser
usados da mesma maneira que os ponteiros:

.. code-block:: C++

	void a2bus_parprn_device::write_c0nx(u8 offset, u8 data)
	{
		ioport_value const cfg(m_input_config->read());
	
		m_printer_out->write(data & (BIT(cfg, 8) ? 0xffU : 0x7fU));
		m_printer_conn->write_strobe(BIT(~cfg, 3));
	}
	
	u8 a2bus_parprn_device::read_cnxx(u8 offset)
	{
		offset ^= 0x40U;
		return m_prom[offset];
	}

Por questão de conveniência, os localizadores que visam o ponteiro
base das regiões da memória e os compartilhamentos podem ser indexados
como arrays.

.. raw:: latex

	\clearpage

As conexões entre os dispositivos
---------------------------------

Os dispositivos precisam estar conectados em um sistema. No Sun SBus por
exemplo, o dispositivo precisa de acesso à CPU do host e ao espaço do
endereço. É assim que declaramos os localizadores na classe do
dispositivo (com todas as distrações removidas)::

	DECLARE_DEVICE_TYPE(SBUS, sbus_device)
	
	class sbus_device : public device_t, public device_memory_interface
	{
		template <typename T, typename U>
		sbus_device(
				machine_config const &mconfig, char const *tag, device_t *owner, u32 clock,
				T &&cpu_tag,
				U &&space_tag, int space_num) :
			sbus_device(mconfig, tag, owner, clock)
		{
			set_cpu(std::forward<T>(cpu_tag));
			set_type1space(std::forward<U>(space_tag), space_num);
		}
	
		sbus_device(machine_config const &mconfig, char const *tag, device_t *owner, u32 clock) :
			device_t(mconfig, type, tag, owner, clock),
			device_memory_interface(mconfig, *this),
			m_maincpu(*this, finder_base::DUMMY_TAG),
			m_type1space(*this, finder_base::DUMMY_TAG, -1)
		{
		}
	
		template <typename T> void set_cpu(T &&tag) { m_maincpu.set_tag(std::forward<T>(tag)); }
		template <typename T> void set_type1space(T &&tag, int num) { m_type1space.set_tag(std::forward<T>(tag), num); }
	
	protected:
		required_device<sparc_base_device> m_maincpu;
		required_address_space m_type1space;
	};

Há algumas coisas que podem ser observadas aqui:

* Os membros do localizador são declarados para tudo que o
  dispositivo precisar acessar.
* O dispositivo não sabe como se encaixará em um sistema maior, o
  localizadores são construídos com argumentos fictícios.
* As funções do membro da configuração são providas para definir a tag
  para o host da CPU e a tag e o índice para o espaço do endereço
  tipo 1.
* Além do construtor do dispositivo padrão é provido um construtor com
  parâmetros para definir a CPU e espaço do endereço tipo 1.

A constante ``finder_base::DUMMY_TAG`` é garantida como sendo inválida e
não será resolvida para um objeto. Isso torna mais fácil detectar as
configurações que forem incompletas ao relatar um erro. Os espaços dos
endereços são numerados a partir do zero, logo, haverá um erro caso o
mesmo seja negativo.

As funções do membro para configurar os localizadores dos objetos tomam
uma referência universal a um objeto semelhante a uma tag (um tipo
modelado com o qualificador ``&&``), bem como qualquer outros parâmetros
necessários para o tipo específico do localizador de objeto. Um
localizador do espaço de endereço precisa de um número além de um objeto
semelhante a uma tag.

Então o que é seria um objeto semelhante a uma tag?

Há suporte para três coisas:

* Um ponteiro de string C (``char const *``) representando uma tag
  relativa ao dispositivo que estiver sendo configurado. Observe que o
  localizador de objetos não copiará a string. O chamado deve garantir
  que continuará válido até a sua resolução e/ou que a validação seja
  concluída.
* Um outro localizador de objetos, o localizador de objetos assumirá o
  seu alvo atual.
* Para os localizadores de dispositivos, uma referência para uma
  instância do tipo de dispositivo do destino, definindo o alvo para
  este dispositivo. Observe que não irá funcionar caso o dispositivo
  seja posteriormente substituído na configuração da máquina. Em geral
  é mais utilizado com ``*this``.

O construtor adicional que define a configuração inicial delega para o
construtor padrão e em seguida chama as funções do membro da
configuração apenas por conveniência.

Quando queremos instanciar este dispositivo e conectá-lo, fazemos o
seguinte::

	SPARCV7(config, m_maincpu, 20'000'000);
	
	ADDRESS_MAP_BANK(config, m_type1space);
	
	SBUS(config, m_sbus, 20'000'000);
	m_sbus->set_cpu(m_maincpu);
	m_sbus->set_type1space(m_type1space, 0);

Nós fornecemos os mesmos localizadores de objetos para instanciar a CPU,
o espaço do endereço dos dispositivos e para configurar o
dispositivo SBus.

Observe que também podemos usar strings literais C para configurar o
dispositivo SBus ao custo de precisar atualizar as tags em diferentes
lugares caso elas se alterem::

	SBUS(config, m_sbus, 20'000'000);
	m_sbus->set_cpu("maincpu");
	m_sbus->set_type1space("type1", 0);

Caso queira utilizar o construtor por questão de conveniência,
fornecemos apenas os argumentos ao instanciar o dispositivo::

	SBUS(config, m_sbus, 20'000'000, m_maincpu, m_type1space, 0);

.. raw:: latex

	\clearpage

As arrays para a localização dos objetos
----------------------------------------

Diversos sistemas possuem dispositivos semelhantes, portas de E/S
ou outros recursos que podem ser organizados de forma lógica como uma
array. Para simplificar estes casos, são oferecidos tipos do
localizador de objetos da array. Os nomes dos tipos da array do
localizador de objetos ``_array`` são adicionado a eles:

+------------------------+------------------------------+
| required_device        | required_device_array        |
+------------------------+------------------------------+
| optional_device        | optional_device_array        |
+------------------------+------------------------------+
| required_memory_region | required_memory_region_array |
+------------------------+------------------------------+
| optional_memory_region | optional_memory_region_array |
+------------------------+------------------------------+
| required_memory_bank   | required_memory_bank_array   |
+------------------------+------------------------------+
| optional_memory_bank   | optional_memory_bank_array   |
+------------------------+------------------------------+
| memory_bank_creator    | memory_bank_array_creator    |
+------------------------+------------------------------+
| required_ioport        | required_ioport_array        |
+------------------------+------------------------------+
| optional_ioport        | optional_ioport_array        |
+------------------------+------------------------------+
| required_address_space | required_address_space_array |
+------------------------+------------------------------+
| optional_address_space | optional_address_space_array |
+------------------------+------------------------------+
| required_region_ptr    | required_region_ptr_array    |
+------------------------+------------------------------+
| optional_region_ptr    | optional_region_ptr_array    |
+------------------------+------------------------------+
| required_shared_ptr    | required_shared_ptr_array    |
+------------------------+------------------------------+
| optional_shared_ptr    | optional_shared_ptr_array    |
+------------------------+------------------------------+
| memory_share_creator   | memory_share_array_creator   |
+------------------------+------------------------------+

Um caso comum para um localizador da array do objeto é a chave da
matriz:

.. code-block:: C++

	class keyboard_base : public device_t, public device_mac_keyboard_interface
	{
	protected:
		keyboard_base(machine_config const &mconfig, device_type type, char const *tag, device_t *owner, u32 clock) :
			device_t(mconfig, type, tag, owner, clock),
			device_mac_keyboard_interface(mconfig, *this),
			m_rows(*this, "ROW%u", 0U)
		{
		}
	
		u8 bus_r()
		{
			u8 result(0xffU);
			for (unsigned i = 0U; m_rows.size() > i; ++i)
			{
				if (!BIT(m_row_drive, i))
					result &= m_rows[i]->read();
			}
			return result;
		}
	
		required_ioport_array<10> m_rows;
	};

Construir um objeto localizador da array é o mesmo que construir um
localizador de objetos exceto que em vez de apenas uma tag você fornece
uma string com o formato da tag e um offset do índice. Neste caso as
tags das portas de E/S no array serão ``ROW0``, ``ROW1``, ``ROW2``,
``…`` e ``ROW9``. Observe que a matriz do localizador de objetos aloca o
armazenamento de forma dinâmica para as tags para que as mesmas
permaneçam válidas até a sua destruição.

O localizador é utilizado da mesma forma que um ``std::array`` do tipo
do localizador de objeto subjacente. Ele suporta a indexação, os
iteradores e com base nos intervalos de loop ``for``.

Por ter um offset do índice definido as tags, não precisam utilizar os
índices com base zero. É comum utilizar a indexação com base 1 como
mostra o exemplo abaixo::

	class dooyong_state : public driver_device
	{
	protected:
		dooyong_state(machine_config const &mconfig, device_type type, char const *tag) :
			driver_device(mconfig, type, tag),
			m_bg(*this, "bg%u", 1U),
			m_fg(*this, "fg%u", 1U)
		{
		}
	
		optional_device_array<dooyong_rom_tilemap_device, 2> m_bg;
		optional_device_array<dooyong_rom_tilemap_device, 2> m_fg;
	};

Isso faz com que ``m_bg`` encontre os dispositivos com as tags ``bg1`` e
``bg2`` enquanto ``m_fg`` encontra os dispositivos com as tags ``fg1``
e ``fg2``. Observe que os índices nos localizadores ainda tem base zero
como qualquer outra array C.

Também é possível que haja outras conversões do formato como
hexadecimais (``%x`` e ``%X``) ou caractere (``%c``)::

	class eurit_state : public driver_device
	{
	public:
		eurit_state(machine_config const &mconfig, device_type type, char const *tag) :
			driver_device(mconfig, type, tag),
			m_keys(*this, "KEY%c", 'A')
		{
		}
	
	private:
		required_ioport_array<5> m_keys;
	};

Neste caso as portas da matriz chave usam as tags ``KEYA``, ``KEYB``,
``KEYC``, ``KEYD`` e ``KEYE``.

.. raw:: latex

	\clearpage

É possível usar uma lista das tags do inicializador fechado-as entre
colchetes quando as tags não seguirem uma sequência ascendente simples::

	class seabattl_state : public driver_device
	{
	public:
		seabattl_state(machine_config const &mconfig, device_type type, char const *tag) :
			driver_device(mconfig, type, tag),
			m_digits(*this, { "sc_thousand", "sc_hundred", "sc_half", "sc_unity", "tm_half", "tm_unity" })
		{
		}
	
	private:
		required_device_array<dm9368_device, 6> m_digits;
	};

Se os localizadores subjacentes dos objetos exigirem argumentos
adicionais do construtor, forneça-os após o formato da etiqueta e o
deslocamento do índice (os mesmos valores serão usados para todos os
elementos da array)::

	class dreamwld_state : public driver_device
	{
	public:
		dreamwld_state(machine_config const &mconfig, device_type type, char const *tag) :
			driver_device(mconfig, type, tag),
			m_vram(*this, "vram_%u", 0U, 0x2000U, ENDIANNESS_BIG)
		{
		}
	
	private:
		memory_share_array_creator<u16, 2> m_vram;
	};

Isso localiza ou cria uma memória compartilhada com as etiquetas
``vram_0`` e ``vram_1``, cada uma com 8 KiB organizadas com 4,096 words
big-Endian 16-bit.


Localizadores opcionais de objetos
----------------------------------

Os localizadores opcionais de objetos não exibem um erro caso o objeto
alvo não seja encontrado. Isto é útil em duas situações: implementações
``driver_device`` (classes do estado) que representam uma família dos
sistemas onde alguns componentes não estão presentes em todas as
configurações e os dispositivos que podem utilizar um recurso de maneira
opcional. Também são fornecidas funções adicionais dos membros para
testar se o objeto alvo foi encontrado ou não.

.. raw:: latex

	\clearpage

Componentes opcionais do sistema
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Muitas vezes uma classe é usada para representar uma família relacionada
de sistemas. Caso um componente não esteja presente em todas as
configurações, pode ser conveniente usar um localizador opcional para
obter acesso a ele. Como exemplo, usaremos o dispositivo Sega X-board::

	class segaxbd_state : public device_t
	{
	protected:
		segaxbd_state(machine_config const &mconfig, device_type type, char const *tag, device_t *owner, u32 clock) :
			device_t(mconfig, type, tag, owner, clock),
			m_soundcpu(*this, "soundcpu"),
			m_soundcpu2(*this, "soundcpu2"),
			m_segaic16vid(*this, "segaic16vid"),
			m_pc_0(0),
			m_lastsurv_mux(0),
			m_adc_ports(*this, "ADC%u", 0),
			m_mux_ports(*this, "MUX%u", 0)
		{
		}
	
	optional_device<z80_device> m_soundcpu;
	optional_device<z80_device> m_soundcpu2;
	required_device<mb3773_device> m_watchdog;
	required_device<segaic16_video_device> m_segaic16vid;
		bool m_adc_reverse[8];
		u8 m_pc_0;
		u8 m_lastsurv_mux;
		optional_ioport_array<8> m_adc_ports;
		optional_ioport_array<4> m_mux_ports;
	};

Os membros ``optional_device`` e ``optional_ioport_array`` são
construídos e declarados de maneira comum. Antes de acessar o objeto
alvo, chamamos o membro da função ``found()`` para verificar a sua
presença no sistema (o operador "cast-to-Boolean" pode ser utilizado de
maneira explícita com a mesma finalidade):

.. code-block:: C++

	void segaxbd_state::pc_0_w(u8 data)
	{
		m_pc_0 = data;
		m_watchdog->write_line_ck(BIT(data, 6));
		m_segaic16vid->set_display_enable(data & 0x20);
		if (m_soundcpu.found())
			m_soundcpu->set_input_line(INPUT_LINE_RESET, (data & 0x01) ? CLEAR_LINE : ASSERT_LINE);
		if (m_soundcpu2.found())
			m_soundcpu2->set_input_line(INPUT_LINE_RESET, (data & 0x01) ? CLEAR_LINE : ASSERT_LINE);
	}

.. raw:: latex

	\clearpage

As portas opcionais de E/S oferecem de maneira conveniente a função do
membro chamado ``read_safe`` que lê o valor da porta caso esta esteja
presente ou em vez disso retorna o valor padrão::

	u8 segaxbd_state::analog_r()
	{
		int const which = (m_pc_0 >> 2) & 7;
		u8 value = m_adc_ports[which].read_safe(0x10);
	
		if (m_adc_reverse[which])
			value = 255 - value;
	
		return value;
	}
	
	uint8_t segaxbd_state::lastsurv_port_r()
	{
		return m_mux_ports[m_lastsurv_mux].read_safe(0xff);
	}

Na ausência, as portas ADC retornam 0x10 (decimal 16) enquanto na
ausência das portas digitais multiplexadas retornam 0xff (decimal 255).
Observe que o ``read_safe`` é um membro do próprio ``optional_ioport``
e não um membro do objeto alvo ``ioport_port`` (o ``optional_ioport``
não perde a sua referência durante o uso).

Há algumas desvantagens durante o uso dos localizadores opcionais:

* Não há como distinguir entre o alvo não estar presente ou não ser
  encontrado por questões de erros nas etiquetas tornando-as mais
  propensos a erros.
* Verificando caso o alvo esteja presente para poder utilizar os
  recursos do prognóstico do núcleo da CPU prejudicando potencialmente
  seu desempenho caso isso aconteça com muita frequência.

Avalie se os localizadores opcionais são a melhor solução ou se seria
mais apropriado a criação de uma classe derivada para o sistema com
componentes adicionais.

.. raw:: latex

	\clearpage

Recursos Opcionais
~~~~~~~~~~~~~~~~~~

Alguns dispositivos podem utilizar certos recursos de maneira opcional.
O dispositivo ainda funcionará caso o sistema host não os forneça,
embora algumas funcionalidades possam não estar disponíveis.
Por exemplo, o slot do cartucho do **Virtual Boy** responde em três
espaços de endereço chamados ``EXP``, ``CHIP`` e ``ROM``. O sistema host
jamais utilizará um ou mais deles, não é necessário fornecer um lugar
para que o cartucho instale os manipuladores correspondentes.
(Por exemplo, uma copiadora só pode utilizar apenas o espaço da ROM).

Vejamos como isso é implementado. O dispositivo de slot do cartucho do
**Virtual Boy** declara os membros ``optional_address_space`` para os
três espaços dos endereços, os membros do ``offs_t`` para os espaços
nestes endereços e as funções dos membros em linha para configurá-los::

	class vboy_cart_slot_device :
			public device_t,
			public device_image_interface,
			public device_single_card_slot_interface<device_vboy_cart_interface>
	{
	public:
		vboy_cart_slot_device(machine_config const &mconfig, char const *tag, device_t *owner, u32 clock = 0U);
	
	template <typename T> void set_exp(T &&tag, int no, offs_t base)
		{
			m_exp_space.set_tag(std::forward<T>(tag), no);
			m_exp_base = base;
		}
	template <typename T> void set_chip(T &&tag, int no, offs_t base)
		{
			m_chip_space.set_tag(std::forward<T>(tag), no);
			m_chip_base = base;
		}
	template <typename T> void set_rom(T &&tag, int no, offs_t base)
		{
			m_rom_space.set_tag(std::forward<T>(tag), no);
			m_rom_base = base;
		}
	
	protected:
		virtual void device_start() override;
	
	private:
		optional_address_space m_exp_space;
		optional_address_space m_chip_space;
		optional_address_space m_rom_space;
		offs_t m_exp_base;
		offs_t m_chip_base;
		offs_t m_rom_base;

	device_vboy_cart_interface *m_cart;
	};
	
	DECLARE_DEVICE_TYPE(VBOY_CART_SLOT, vboy_cart_slot_device)

.. raw:: latex

	\clearpage

Os localizadores de objetos são construídos com valores fictícios
para as etiquetas e os números do espaço matemático
(``finder_base::DUMMY_TAG`` e ``-1``):

.. code-block:: C++

	vboy_cart_slot_device::vboy_cart_slot_device(machine_config const &mconfig, char const *tag, device_t *owner, u32 clock) :
		device_t(mconfig, VBOY_CART_SLOT, tag, owner, clock),
		device_image_interface(mconfig, *this),
		device_single_card_slot_interface<device_vboy_cart_interface>(mconfig, *this),
		m_exp_space(*this, finder_base::DUMMY_TAG, -1, 32),
		m_chip_space(*this, finder_base::DUMMY_TAG, -1, 32),
		m_rom_space(*this, finder_base::DUMMY_TAG, -1, 32),
		m_exp_base(0U),
		m_chip_base(0U),
		m_rom_base(0U),
		m_cart(nullptr)
	{
	}

Para ajudar na detecção dos erros de configuração, verificaremos os
casos onde os espaços dos endereços foram configurados mas não estão
presentes:

.. code-block:: C++

	void vboy_cart_slot_device::device_start()
	{
		if (!m_exp_space && ((m_exp_space.finder_tag() != finder_base::DUMMY_TAG) || (m_exp_space.spacenum() >= 0)))
			throw emu_fatalerror("%s: Address space %d of device %s not found (EXP)\n", tag(), m_exp_space.spacenum(), m_exp_space.finder_tag());
	
		if (!m_chip_space && ((m_chip_space.finder_tag() != finder_base::DUMMY_TAG) || (m_chip_space.spacenum() >= 0)))
			throw emu_fatalerror("%s: Address space %d of device %s not found (CHIP)\n", tag(), m_chip_space.spacenum(), m_chip_space.finder_tag());
	
		if (!m_rom_space && ((m_rom_space.finder_tag() != finder_base::DUMMY_TAG) || (m_rom_space.spacenum() >= 0)))
			throw emu_fatalerror("%s: Address space %d of device %s not found (ROM)\n", tag(), m_rom_space.spacenum(), m_rom_space.finder_tag());
	
		m_cart = get_card_device();
	}
