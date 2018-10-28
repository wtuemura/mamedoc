.. raw:: latex

	\clearpage

O dispositivo da interface da ROM
=================================

1. Das capacidades
------------------

Esta interface foi concebida para dispositivos que esperam ter uma
ROM conectada a ela através de um barramento dedicado sendo
principalmente desenvolvido para CIs de áudio. Pode haver interesse de
outros tipos de dispositivos, no entanto há outros pontos a serem
levados em consideração, que podem torná-lo impraticável (como a cache
de decodificação de gráficos, por exemplo). A interface provê a
possibilidade de conexão entre um **ROM_REGION** com um **ADDRESS_MAP**
ou dinamicamente configurando um bloco de memória como se fosse uma ROM.
Nos casos da região e blocos, esse banco de memória é tratado de forma
automática.

2. Configuração
---------------

| **device_rom_interface**\ (*const machine_config &mconfig, device_t &device, u8 addrwidth, endianness_t endian = ENDIANNESS_LITTLE, u8 datawidth = 8*)

Além disso, a ordenação dos bits (*endianness* [1]_), podem ser
fornecidos casos eles não sejam "*little endian*" ou um barramento com
tamanho e largura de byte.

| **MCFG_DEVICE_ADDRESS_MAP**\ (*AS_0, map*)

Use esse método na configuração de tempo da máquina para que seja
providenciado um mapa de endereçamento para que seja possível a conexão
ao barramento.
Tem prioridade sobre uma região da rom, caso uma esteja presente.

| **MCFG_DEVICE_ROM**\ (*tag*)

Usado para selecionar uma região da rom a ser usada caso o mapa
de endereços de um dispositivo não seja informado. Predefinido para
**DEVICE_SELF**, por exemplo, uma tag do dispositivo.

| **ROM_REGION**\ (*length, tag, flags*)

Caso uma etiqueta (tag) esteja presente e seja idêntica a etiqueta do
dispositivo, assim como a descrição da ROM seja a mesma para o sistema,
a região da ROM definida com **MCFG_DEVICE_ROM**, será selecionada e
conectada. Um mapa de endereço tem prioridade sobre uma região da ROM
caso uma esteja presente na configuração da máquina.

| void **set_rom_endianness**\ (*endianness_t endian*)
| void **set_rom_data_width**\ (*u8 width*)
| void **set_rom_addr_width**\ (*u8 width*)

Esses métodos são voltados para dispositivos genéricos com
especificações de hardware indefinidas, sobrescreve a ordenação dos
bits, a largura do barramento e o endereçamento de dados atribuída por
meio de um construtor. Eles devem ser chamados de dentro do dispositivo
antes que o **config_complete** termine.

| void **set_rom**\ (*const void \*base, u32 size*);

A qualquer momento publique **interface_pre_start**, com este método,
um bloco de memória pode ser configurado como se uma rom estivesse
conectada. Sobrescreve qualquer configuração prévia que possa ter sido
fornecida. Pode ser feito mais de uma vez.

3. Acesso a ROM
---------------

| u8 **read_byte**\ (*offs_t byteaddress*)
| u16 **read_word**\ (*offs_t byteaddress*)
| u32 **read_dword**\ (*offs_t byteaddress*)
| u64 **read_qword**\ (*offs_t byteaddress*)

Esses métodos fornecem o acesso de leitura para uma rom que esteja
conectada. O acesso fora dos limites retorna mensagens não mapeadas de
erro (*logerror*).

4. Banco da Rom
---------------

Caso a região da rom ou o bloco da memória no **set_rom** seja maior
que o barramento de endereços, o banco da ROM [2]_ é configurado
automaticamente.

| void **set_rom_bank**\ (*int bank*)

Esse método seleciona o número atual do banco da rom.

5. Ressalvas
------------

Ao usar aquela interface, faz com que o dispositivo derive de
**device_memory_interface**. Caso o dispositivo queira realmente usar a
memória da interface para si mesmo, lembre-se que **AS_0/AS_PROGRAM** é
usado pela interface da ROM, por isso não se esqueça de chamar
**memory_space_config**.

Para dispositivos com saídas que possam ser usadas para endereçar
ROMs, porém restrito apenas ao encaminhamento de dados para outro
dispositivo com a única finalidade de processamento, pode ser que seja
de grande ajuda desativar a interface quando não a estiver usando.
Isso pode ser feito sobrescrevendo o **memory_space_config** para
retornar um vetor vazio.

.. [1]	Para maiores explicações sobre os diferentes tipos de endianness, acesse `este link <http://carlosdelfino.eti.br/programacao/cplusplus/Diferencas_entre_BigEndian_Little_Endian_e_Bit_Endianness/>`_. (Nota do tradutor)
.. [2]	Rom banking no texto original. (Nota do tradutor)
