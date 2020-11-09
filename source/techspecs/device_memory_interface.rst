
.. raw:: latex

	\clearpage

O dispositivo da interface de memória
=====================================

.. contents:: :local:

Das capacidades
---------------

A interface do dispositivo da memória fornece aos dispositivos a
capacidade de criar o mapeamento nos espaços dos endereços onde estes
possam ser associados. É usado por qualquer dispositivo que forneça um
endereço/barramento de dados (lógico) para que os outros dispositivos
possam se conectar nele. É em essência, mas não apenas, às CPUs.

A interface permite um conjunto ilimitado nos espaços de endereços,
numerados apenas com pequenos valores positivos. Os índices dos vetores
das IDs devem permanecer pequenos visando manter uma pesquisa rápida.
Os espaços numerados entre 0-3 possui o nome de uma constante associado
e ele:

+----+---------------+
| ID | Nome          |
+====+===============+
| 0  | AS_PROGRAM    |
+----+---------------+
| 1  | AS_DATA       |
+----+---------------+
| 2  | AS_IO         |
+----+---------------+
| 3  | AS_OPCODES    |
+----+---------------+

Os espaços 0 e 3 como o ``AS_PROGRAM`` e o ``AS_OPCODE`` são especiais
para o depurador e algumas CPU's por exemplo. o ``AS_PROGRAM`` é usado
pelo depurador e CPUs como um espaço de onde a CPU lê as suas instruções
para o desmontador. O ``AS_OPCODE`` quando está presente é utilizado
pelo depurador e algumas CPUs para ler parte da instrução do 'opcode', 
isso significa que o 'opcode' é dependente do dispositivo. Para o Z80
por exemplo, o byte inicial é lido junto com o sinal declarado do M1 enquanto
que para o 68000 significa cada instrução 'word' mais os acessos
relativos ao PC. O principal, mas não o único uso do ``AS_OPCODE``,
serve para implementar a descriptografia de instruções através de um
hardware de forma separada dos dados.

Configuração
------------

::

	std::vector<std::pair<int, const address_space_config \*>>\ **memory_space_config**\ *(int spacenum) const*

O dispositivo deve sobrescrever esse método fornecendo um vetor de pares
compreendendo um espaço numerado e seu descritor de configuração
associado ``address_space_config``. Alguns exemplos para pesquisar
quando precisar:

* Vetor padrão two-space: `v60_device <https://git.redump.net/mame/tree/src/devices/cpu/v60/v60.cpp?h=mame0226>`_
* Condicional AS_OPCODE: `z80_device <https://git.redump.net/mame/tree/src/devices/cpu/z80/z80.cpp?h=mame0226>`_
* Configuração herdada e com um espaço adicionado: `hd647180x_device <https://git.redump.net/mame/tree/src/devices/cpu/z180/hd647180x.cpp?h=mame0226>`_
* Configuração herdada e com um patch no espaço: `tmpz84c011_device <https://git.redump.net/mame/tree/src/devices/cpu/z80/tmpz84c011.cpp?h=mame0226>`_

::

	bool has_configured_map(int index = 0) const;


Associando os mapas aos espaços
-------------------------------

A associação dos mapas aos espaços é feito no nível da configuração da
máquina após a instanciação do dispositivo::

	void set_addrmap(int spacenum, T &obj, Ret (U::*func)(Params...));
	void set_addrmap(int spacenum, Ret (T::*func)(Params...));
	void set_addrmap(int spacenum, address_map_constructor map);

Estas funções associam um mapa a um determinado espaço. A associação dos
mapas dos endereços com espaços que não existem são ignorados sem
qualquer aviso. A primeira forma toma uma referência em um objeto e um
método para chamar este objeto. A segunda forma assume um método para
invocar o dispositivo atual que está sendo configurado. A terceira forma
toma um ``address_map_constructor`` para ser copiado. Em cada caso a
função deve poder ser invocada como argumento através da referência de
um objeto ``address_map``.

Como exemplo aqui está o mapa de configuração do endereço do mapa para a
CPU principal nas máquinas Hana Yayoi e na Hana Fubiki com todas as
distrações removidas::

	class hnayayoi_state : public driver_device
	{
	public:
		void hnayayoi(machine_config &config);
		void hnfubuki(machine_config &config);
	
	private:
	required_device<cpu_device> m_maincpu;

	void hnayayoi_map(address_map &map);
	void hnayayoi_io_map(address_map &map);
	void hnfubuki_map(address_map &map);
	};
	
	void hnayayoi_state::hnayayoi(machine_config &config)
	{
		Z80(config, m_maincpu, 20000000/4);
		m_maincpu->set_addrmap(AS_PROGRAM, &hnayayoi_state::hnayayoi_map);
		m_maincpu->set_addrmap(AS_IO, &hnayayoi_state::hnayayoi_io_map);
	}

	void hnayayoi_state::hnfubuki(machine_config &config)
	{
		hnayayoi(config);
	
		m_maincpu->set_addrmap(AS_PROGRAM, &hnayayoi_state::hnfubuki_map);
		m_maincpu->set_addrmap(AS_IO, address_map_constructor());
	}


Acessando os espaços
--------------------

::

	address_space &space(int index = 0) const;

Retorna um espaço de endereço específico depois da inicialização e o
endereço informado deve existir.

::

	bool has_space(int index = 0) const;

Indica se um determinado espaço fornecido realmente existe.


O suporte MMU para o desmontador
--------------------------------

::

	bool translate(int spacenum, int intention, offs_t &address);

Faz uma tradução lógica para o endereço físico através do dispositivo
MMU [1]_. O "*spacenum*" dá o número do espaço, a intenção para o tipo
do acesso futuro (``TRANSLATE_(READ\|WRITE\|FETCH)(\|_USER\|_DEBUG)``)
e o endereço é um parâmetro de entrada e saída (in/out) armazenando o
endereço para tradução na entrada e a versão traduzida no retorno.
Deve retornar ``true`` caso a tradução seja correta ou ``false`` caso o
endereço não tenha sido mapeado.

Observe que por alguma razão histórica, o próprio dispositivo
deve substituir o método virtual ``memory_translate`` com a
mesma assinatura.

.. [1]	Memory management unit ou Unidade de gerenciamento da memória.
		(Nota do tradutor)
