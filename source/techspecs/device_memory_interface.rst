
.. raw:: latex

	\clearpage

O dispositivo da interface de memória
=====================================

1. Das capacidades
------------------

A interface do dispositivo de memória provê aos dispositivos a
capacidade de criar espaços de endereços mapeados aos quais estes possam
ser associados. É usado por qualquer dispositivo que forneça um
endereço/barramento de dados (lógico) para que os outros dispositivos
possam se conectar à ela. É em essência, mas não apenas, as CPUs.

A interface permite um conjunto ilimitado de espaços de endereços,
numerados com valores positivos pequenos. Os IDs devem permanecer
pequenos pois eles indexam os vetores visando manter a rápida pesquisa.
Os espaços com os números entre 0-3 tem uma constante com um nome
associado à ela:

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

Os espaços 0 e 3 como "*AS_PROGRAM*" e "*AS_OPCODE*" são especiais para
o depurador e algumas CPU's por exemplo. AS_PROGRAM é usado pelo
depurador e CPUs como um espaço de onde a CPU lê as suas instruções para
o desmontador. Quando presente, AS_OPCODE é usado pelo depurador e
algumas CPUs para ler parte do 'opcode' da instrução. O opcode significa
que ele é dependente do dispositivo. Por exemplo, para o z80 é o byte
inicial que é lido junto com o sinal M1 declarado.
Para o 68000 significa que cada instrução 'word' mais os acessos
relativos ao PC. O principal, mas não o único uso do AS_OPCODE, serve
para implementar a descriptografia de instruções através de um hardware
de forma separada dos dados.

2. Configuração
---------------

| std::vector<std::pair<int, const address_space_config \*>>\ **memory_space_config**\ *(int spacenum) const*

O dispositivo deve sobrescrever esse método fornecendo um vetor de pares
compreendendo um espaço numerado e seu descritor de configuração
associado **address_space_config**. Alguns exemplos para pesquisar
quando precisar:

* Vetor padrão two-space: v60_device
* Condicional AS_OPCODE: z80_device
* Configuração herdada e com um espaço adicionado: m6801_device
* Configuração herdada e com um patch no espaço: tmpz84c011_device


| bool **has_configured_map**\ *() const*
| bool **has_configured_map**\ *(int index) const*

O método **has_configured_map** permite um teste no método
**memory_space_config** caso um **address_map** seja associado com o
espaço dado. Isso permite a implementação opcional de espaços de memória
como as AS_OPCODES em determinados núcleos de CPUs, em versões de teste
sem o uso de parâmetros para o espaço zero (0).

3. Associando mapas aos espaços
-------------------------------

A associação de mapas aos espaços é feito a nível de configuração da
máquina, após a declaração de dispositivo:

| **MCFG_DEVICE_ADDRESS_MAP**\ *(_space, _map)*
| **MCFG_DEVICE_PROGRAM_MAP**\ *(_map)*
| **MCFG_DEVICE_DATA_MAP**\ *(_map)*
| **MCFG_DEVICE_IO_MAP**\ *(_map)*
| **MCFG_DEVICE_DECRYPTED_OPCODES_MAP**\ *(_map)*

A macro genérica e as quatro associações específicas associadas a um
mapa para um espaço dado. Endereços mapeados associados com espaços não
existentes são ignorados sem qualquer aviso. O *devcpu.h* definem os
apelidos **MCFG_CPU_*_MAP** para macros específicos.

| **MCFG_DEVICE_REMOVE_ADDRESS_MAP**\ *(_space)*

Essa macro remove a memória associada a um mapa em um determinado
espaço. Útil para remover um mapa de um espaço opcional, quando for
derivado de uma configuração de máquina.


4. Acessando os espaços
-----------------------

| address_space &\ **space**\ *() const*
| address_space &\ **space**\ *(int index) const*

Retorna um determinado espaço de endereços depois da inicialização.
É uma versão de testes sem parâmetros para AS_PROGRAM/AS_0.
Aborta na inexistência do espaço.

| bool **has_space**\ *() const*
| bool **has_space**\ *(int index) const*

Indica se um determinado espaço fornecido realmente existe. É uma versão
de testes sem parâmetros para AS_PROGRAM/AS_0.


5. Compatibilidade do MMU para o desmontador
--------------------------------------------

| bool **translate**\ *(int spacenum, int intention, offs_t &address)*

Faz uma tradução lógica para o endereço físico através do dispositivo
MMU [1]_. O "*spacenum*" dá o número do espaço, intenção do tipo do
acesso futuro *(TRANSLATE_(READ\|WRITE\|FETCH)(\|_USER\|_DEBUG))* e o
endereço é um parâmetro de entrada e saída (in/out) com o endereço para
traduzir e a sua versão traduzida. Deve retornar **true** caso a tradução
seja correta e **false** caso o endereço não tenha sido mapeado.

Observe que, por algum motivo histórico, o próprio dispositivo
deve substituir o método virtual **memory_translate** com a
mesma assinatura.

.. [1]	Memory management unit ou Unidade de gerenciamento de memória.
		(Nota do tradutor)
