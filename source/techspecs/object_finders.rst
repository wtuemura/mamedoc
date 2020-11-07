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
configuração da máquina do dispositivo::

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
usados da mesma maneira que os ponteiros::

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

Por questão de conveniência, os localizadores que visam o ponteiro de
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

Um caso comum para um localizador da array do objeto é uma matriz da
chave::

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

Construir um objeto localizador de array é o mesmo que construir um
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
