O device_disasm_interface e os desmontadores
============================================

1. Das capacidades
------------------

Os desmontadores são classes que fornecem desmontagem e opcode
meta informações para os núcleos da CPU e **unidasm**. O
**device_disasm_interface** conecta um núcleo de CPU com seu
desmontador.

2. Os desmontadores
-------------------

2.1. Definição
~~~~~~~~~~~~~~

Um desmontador é uma classe que deriva de **util::disasm_interface**.
Em seguida, ele tem dois métodos necessários de implementação,
**opcode_alignment** e **disassemble** assim como 6 opcionais,
**interface_flags**, **page_address_bits**, **pc_linear_to_real**,
**pc_real_to_linear** e uma com quatro variantes possíveis,
**decrypt8/16/32/64**.


2.2. opcode_alignment
~~~~~~~~~~~~~~~~~~~~~

| u32 \ **opcode_alignment**\ () const

Retorna o alinhamento de opcode requisitado pela CPU nas unidades PC.
Em outras palavras o alinhamento necessário para os registros PC
da CPU.
Tende a ser 1 (quase todos), 2 (68000...), 4 (mips, ppc...),
com um excepcional 8 (processador paralelo tms 32082) e 16
(tms32010, instruções são 16-bits aligned e o PC targets bits).
Deve ser a potência de dois para evitar que as coias se quebrem.

Note que processadores como o tms32031 que têm instruções em 32-bits
mas onde os valores PC targets em 32-bits têm um alinhamento de 1.

2.3. disassemble
~~~~~~~~~~~~~~~~

| offs_t \ **disassemble**\ (std::ostream &stream, offs_t pc, const data_buffer &opcodes, const data_buffer &params)

Este é o método onde o trabalho de fato é acontece. Esse comando
desmonta uma instrução no endereço *PC* e escreve o resultado para
*stream*. Os valores a serem decodificados são recuperados
da memória intermediária *opcode*. Um objeto **data_buffer** oferecem
quatro métodos de acesso:

| u8  util::disasm_interface::data_buffer::\ **r8**\  (offs_t pc) const
| u16 util::disasm_interface::data_buffer::\ **r16**\ (offs_t pc) const
| u32 util::disasm_interface::data_buffer::\ **r32**\ (offs_t pc) const
| u64 util::disasm_interface::data_buffer::\ **r64**\ (offs_t pc) const

Eles leem os dados em um determinado endereço e pegam o endianness e os
PCs não lineares por acessos maiores que a largura do barramento.
A variante do depurador também armazena em cache os dados lidos em um
bloco, então por essa razão um não deve ler os dados muito longe da base
pc (ficar entre de 16K ou então, ter cuidado ao tentar seguir acessos
indiretos, por exemplo).

Uma quantidade de CPUs tem um sinal externo que divide as buscas em
parte um opcode e parte um parâmetro. Este é, por exemplo o sinal M1
do z80 ou o sinal SYNC do 6502. Alguns sistemas apresentam
diferentes valores para a CPU dependendo se esse sinal for
ativo, em geral usado para fins de proteção. Nestes CPUs a parte do opcode
deve ser lida a partir da memória intermediária do *opcode* e o
parâmetro part vindo da memória intermediária *params*. Eles serão ou
não a mesma memória intermediária, tudo vai depender do próprio sistema.

O método retorna o tamanho da instrução em unidades de PC, com um valor
máximo de 65535. Além disso, caso seja possível o desmontador deve
dar algumas informações meta sobre o opcode por "OR-ing" no resultado:

* **STEP_OVER** para chamadas de sub-rotina ou auto-decrementos de
    loops. Caso haja alguns slots com atraso, faça também OR com
    **step_over_extra**\ (n) onde n é o número da instrução.
* **STEP_OUT** para o retorno das instruções da sub-rotina

Além disso, para indicar que esses sinalizadores são compatíveis, OU o
resultado com **SUPPORTED**\ . Uma quantidade chata de desmontadores mentem
sobre essa compatibilidade (eles fazem um OR com **SUPPORTED** mesmo sem
gerar o **STEP_OVER** ou **STEP_OUT**, por exemplo). Não faça
isso, pois quebra a funcionalidade do *step over/step out* do depurador.

2.4. interface_flags
~~~~~~~~~~~~~~~~~~~~

| u32 **interface_flags**\ () const

Esse método opcional mostra detalhes do desmontador. O valor zero
predefinido é o correto na maioria das vezes. As bandeiras possíveis e
que precisam ser "OR-ed" juntas, são:

* **NONLINEAR_PC**\ : passar para o próximo opcode ou o próximo byte do opcode se não adicionar um ao pc. Usado para antigos PCs com base em LFSR.
* **PAGED**\ : o PC é envolvido com um limite de página
* **PAGED2LEVEL**\ : não apenas o PC envolve em algum tipo de limite de página, mas há dois níveis de paginação
* **INTERNAL_DECRYPTION**\ : há alguma descriptografia escondida entre a leitura de AS_PROGRAM e o desmontador atual
* **SPLIT_DECRYPTION**\ : há alguma descriptografia escondida entre a leitura do AS_PROGRAM e o desmontador atual, assim como essa descriptografia é diferente para os opcodes e os parâmetros

Note que, na prática, os sistemas de PC não lineares também são paginados,
o **PAGED2LEVEL** implica em **PAGED** e que **SPLIT_DECRYPTION**
implica em **DECRYPTION**.


2.5. pc_linear_to_real and pc_real_to_linear
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| offs_t **pc_linear_to_real**\ (offs_t pc) const
| offs_t **pc_real_to_linear**\ (offs_t pc) const

Esses métodos devem estar presentes apenas quando **NONLINEAR_PC**
estiver definido nos sinalizadores da interface. Eles devem converter o
PC de e para um valor com destino a um domínio linear onde os parâmetros
de instrução e a próxima instrução sejam alcançadas ao incrementar o
valor. O **pc_real_to_linear** converte para aquele domínio, já o
**pc_linear_to_real** é convertido de volta daquele domínio.


2.6. page_address_bits
~~~~~~~~~~~~~~~~~~~~~~

| u32 **page_address_bits**\ () const

Presente quando **PAGED** ou **PAGED2LEVEL** for definido, retorna a
quantidade de endereços de bits na pagina inferior.


2.7. page2_address_bits
~~~~~~~~~~~~~~~~~~~~~~~

| u32 **page2_address_bits**\ () const

Presente quando **PAGED2LEVEL** for definido, retorna a quantidade
de endereços de bits na página superior.

2.8. decryptnn
~~~~~~~~~~~~~~

| u8  **decrypt8**\  (u8  value, offs_t pc, bool opcode) const
| u16 **decrypt16**\ (u16 value, offs_t pc, bool opcode) const
| u32 **decrypt32**\ (u32 value, offs_t pc, bool opcode) const
| u64 **decrypt64**\ (u64 value, offs_t pc, bool opcode) const

Um destes deve ser definido quando **INTERNAL_DECRYPTION** ou
**SPLIT_DECRYPTION** for configurado. O escolhido será aquele que leva
o que **opcode_alignment** representa em bytes.

Esse método descriptografa um determinado valor do endereço PC (a partir
de AS_PROGRAM) e retorna o que será passado para o desmontador. 
No caso da descriptografia dividida, o opcode indica se estamos no
opcode (true) ou no parâmetro (false) parte da instrução.


3. Interface do desmontador, device_disasm_interface
----------------------------------------------------

3.1. Definição
~~~~~~~~~~~~~~~

Um núcleo de CPU deriva de **device_disasm_interface** através do
**cpu_device**\ . Um método deve ser implementado,
**create_disassembler**\ .

3.2. create_disassembler
~~~~~~~~~~~~~~~~~~~~~~~~

| util::disasm_interface \*\ **create_disassembler**\ ()

Esse método deve retornar um ponteiro para um novo objeto desmontado que
foi recém-alocado. O solicitante apropria-se do objeto e lida com o seu
tempo de vida.

Esse método será chamado no máximo uma vez durante a vida útil
do objeto da CPU.

4. A comunicação e a configuração do Desmontador
------------------------------------------------

Alguns desmontadores precisam ser configurados. A configuração pode ser
imutável (estático) duração da execução (como o modelo da CPU por
exemplo) ou dinâmico (o estado de um sinalizador ou uma preferência de
usuário). A configuração estática que pode ser feita seja por parâmetro(s)
para o construtor do desmontador ou através da derivação da classe do
desmontador principal. Caso a informação seja curta e sua semântica seja
óbvia (como o nome do modelo), fique à vontade para usar um parâmetro.
Caso contrário, deriva a classe.

A configuração dinâmica deve ser feita definindo primeiro uma
estrutura de grupo público chamado "config" no desmontador, 
com o destruidor virtual e métodos virtuais puros para extrair
as informações necessárias. Um ponteiro para essa estrutura deve ser
passada para o construtor do desmontador. O núcleo da CPU deve então
adicionar uma derivação dessa estrutura de configuração e implementar os
métodos. O Unidasm terá que separar pequena classe da configuração de
classes para que possa passar a informação.

5. Coisas que faltam
--------------------

Atualmente, não há como a GUI do depurador adicionar
uma configuração para cada núcleo. Ela se faz necessária para o s2650 e
os núcleos do saturn. É necessário também passar pela própria classe do
núcleo da CPU uma vez que é retirado da estrutura de configuração.

Falta compatibilidade do unidasm para uma configuração individual dos
núcleos da CPU. Isso se faz útil para muitas coisas, veja o código-fonte
do unidasm para a um lista atual (comentários "Configuration missing").
