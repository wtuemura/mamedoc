.. raw:: latex

	\clearpage

O dispositivo da interface da ROM
=================================

.. contents:: :local:

Das capacidades
---------------

Esta interface foi concebida para dispositivos que esperam ter uma
ROM conectada à ela através de um barramento dedicado sendo
principalmente desenvolvido para CIs de áudio. Pode haver um interesse
de outros tipos de dispositivos, no entanto há outros pontos a serem
levados em consideração, que pode torná-lo impraticável (como a cache
da decodificação dos gráficos, por exemplo). A interface informa a
possibilidade da conexão entre a região da ROM com um mapa de endereço
ou então configurar dinamicamente um bloco da memória como se fosse uma
ROM.Nos casos da região e blocos, este banco de memória é tratado de
forma automática.

Configuração
------------

::

	device_rom_interface<AddrWidth, DataWidth=0, AddrShift=0, Endian=ENDIANNESS_LITTLE>

A interface é um modelo que pega a largura do endereçamento do
barramento dedicado como um parâmetro. Além disso é possível informar a
largura do barramento de dados (caso não seja um byte), o deslocamento
do endereço (caso não seja 0) e o endianness [1]_ (caso não seja little
endian ou um barramento com tamanho em byte) pode ser fornecido.
A largura do barramento de dados é 0 para byte, 1 para word, etc.

::

	void set_map(map);

Use este método na configuração do tempo da máquina para que seja
providenciado a conexão de um mapa de endereçamento ao barramento.
Tem prioridade sobre uma região da ROM, caso uma esteja presente.

::

	void set_device_rom_tag(tag);

Usado para selecionar uma região da ROM que será usada caso o mapa
de endereços de um dispositivo não seja informado. A predefinição é
``DEVICE_SELF``, por exemplo, uma tag do dispositivo.

::

	ROM_REGION(length, tag, flags)

Caso a região da ROM definida com a tag ``set_device_rom_tag`` esteja
presente, seja informada nas definições da ROM para o sistema ou seja
idêntica a tag do dispositivo, esta será selecionada como a ROM correta.
Um mapeamento do endereço terá prioridade sobre uma região da ROM caso
uma esteja presente na configuração da máquina.

::

	void override_address_width(u8 width);

Este método permite sobrescrever a largura do endereço do barramento.
Deve ser invocado de dentro do dispositivo antes da conclusão
do ``config_complete``.

::

	void set_rom(const void *base, u32 size);

A qualquer momento publique ``interface_pre_start`` com este método,
um bloco da memória pode ser configurado como se uma ROM estivesse
conectada. Sobrescreve qualquer configuração prévia que possa ter sido
fornecida. Pode ser feito mais de uma vez.

Acesso a ROM
------------

::

	u8 read_byte(offs_t addr);
	u16 read_word(offs_t addr);
	u32 read_dword(offs_t addr);
	u64 read_qword(offs_t addr);

Estes métodos fornecem o acesso de leitura para uma ROM que esteja
conectada. O acesso fora dos limites retorna mensagens de erro
``logerror`` sobre o não mapeamento.

O Banco da ROM
--------------

Caso a região da ROM ou o bloco da memória no ``set_rom`` seja maior
que o barramento de endereços possa acessar, o banco da ROM [2]_ será
configurado de forma automática.

::

	void set_rom_bank(int bank);

Este método seleciona o número do banco atual.

Ressalvas
---------

Ao usar aquela interface, faz com que o dispositivo derive do
``device_memory_interface``. Caso o dispositivo queira realmente
utilizar a interface da memória para si mesmo, lembre-se que
o espaço zero (0 ou ``AS_PROGRAM``) é utilizado pela interface da ROM,
por isso não se esqueça de invocar a base do método
``memory_space_config``.

Para os dispositivos com saídas que possam ser utilizadas para endereçar
as ROMs restrito apenas ao encaminhamento dos dados para outro
dispositivo com a única finalidade de processamento, pode ser que seja
de grande ajuda desativar a interface quando ela não estiver sendo
utilizada. Isto pode ser feito sobrescrevendo o ``memory_space_config``
para que retorne um vetor vazio.

.. [1]	Para maiores explicações sobre os diferentes tipos de endianness, acesse `este link <http://carlosdelfino.eti.br/programacao/cplusplus/Diferencas_entre_BigEndian_Little_Endian_e_Bit_Endianness/>`_. (Nota do tradutor)
.. [2]	Rom banking no texto original. (Nota do tradutor)
