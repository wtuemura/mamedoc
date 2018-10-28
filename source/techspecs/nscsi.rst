.. raw:: latex

	\clearpage

O novo subsistema SCSI
======================

Introdução
----------

O subsistema **nscsi** foi criado para permitir que uma implementação
fique o mais próximo possível do hardware físico real, (na esperança de)
facilitar a implementação de novos CIs controladores a partir de
documentações.


Estrutura global
----------------

O SCSI paralelo é construído em torno de um barramento simétrico ao qual
vários dispositivos estão conectados. O barramento é composto de 9
linhas de controle (no momento, as versões posteriores do SCSI podem ter
mais) e até 32 linhas de dados (mas os chips atualmente implementados
suportam apenas 8). Todas as linhas são coletores abertos, o que
significa que um ou vários chips conectam a linha ao terra e a linha,
óbvio, vai para o terra ou nenhum CI conduz nada e a linha continua no
Vcc. Além disso, o barramento usa um lógica invertida, significa que o
sinal ao ser aterrado equivale a 1.
Os controladores SCSI tradicionalmente funcionam em níveis lógicos e não
físicos, então o subsistema nscsi também funciona em níveis lógicos,
assim todas as suas saídas para os dispositivos são lógicos.

Estruturalmente, a implementação é feita em torno de duas classes
principais:

* **nscsi_bus_devices** representa o barramento
* **nscsi_device** representa um dispositivo individual

Um dispositivo só se comunica com o barramento e o barramento cuida da
manipulação transparente da descoberta e a comunicação do dispositivo.
Além disso a classe **nscsi_full_device** propõe um dispositivo SCSI com
o protocolo SCSI implementado, facilitando a criação de dispositivos
SCSI genéricos como se fossem discos rígidos ou leitores de CD-ROM.


Conectando um barramento SCSI em um driver
------------------------------------------

O subsistema nscsi aproveita as interfaces de slot e a nomenclatura do
dispositivo para permitir uma implementação e configuração de barramento
de forma simples.

Primeiro você precisa criar uma lista de dispositivos aceitáveis para
conectar ao barramento. Isso geralmente inclui **cdrom**, **hasrdisk** e
o CI do controlador.
Por exemplo:

|
| static SLOT_INTERFACE_START( next_scsi_devices )
|     SLOT_INTERFACE("cdrom", NSCSI_CDROM)
|     SLOT_INTERFACE("harddisk", NSCSI_HARDDISK)
|     SLOT_INTERFACE_INTERNAL("ncr5390", NCR5390)
| SLOT_INTERFACE_END

A interface **_INTERNAL** indica um dispositivo que não é selecionável
pelo usuário, o que é útil para o controlador.

Então na configuração da máquina (ou em uma configuração de fragmento)
você precisa primeiro adicionar o barramento e em seguida os
dispositivos (potenciais) como dispositivos de sub-dispositivos do
barramento com o SCSI ID como seu nome. Você pode usar como exemplo:

|
|     MCFG_NSCSI_BUS_ADD("scsibus")
|     MCFG_NSCSI_ADD("scsibus:0", next_scsi_devices, "cdrom", 0, 0, 0, false)
|     MCFG_NSCSI_ADD("scsibus:1", next_scsi_devices, "harddisk", 0, 0, 0, false)
|     MCFG_NSCSI_ADD("scsibus:2", next_scsi_devices, 0, 0, 0, 0, false)
|     MCFG_NSCSI_ADD("scsibus:3", next_scsi_devices, 0, 0, 0, 0, false)
|     MCFG_NSCSI_ADD("scsibus:4", next_scsi_devices, 0, 0, 0, 0, false)
|     MCFG_NSCSI_ADD("scsibus:5", next_scsi_devices, 0, 0, 0, 0, false)
|     MCFG_NSCSI_ADD("scsibus:6", next_scsi_devices, 0, 0, 0, 0, false)
|     MCFG_NSCSI_ADD("scsibus:7", next_scsi_devices, "ncr5390", 0, &next_ncr5390_interface, 10000000, true)

Essa configuração coloca como um leitor de CD-ROM padrão no SCSI ID 0 e
um disco rígido com SCSI ID 1forçando o controlador no ID 7.
Os parâmetros para adição são:

- device tag, composto por ``bus-tag:scsi-id``
- uma lista com os dispositivos aceitos
- um dispositivo conforme disposto na lista, se um já não estiver por padrão
- a configuração do dispositivo de entrada, caso haja (e geralmente não há)
- a estrutura de configuração do dispositivo, geralmente usado apenas para o controlador
- a frequência, geralmente usado apenas pelo controlador

O nome completo do dispositivo, para fins de mapeamento seria
``bus-tag:scsi-id:device-type``, ``scsibus:7:ncr5390`` para o nosso
controlador aqui.


Criando um novo dispositivo SCSI usando nscsi_device
----------------------------------------------------

A classe base "**nscsi_device**" deve ser usado para os CIs do
controlador SCSI. A classe fornece três variáveis e um método:

- A primeira variável, **scsi_bus**, é um ponteiro para o
  **nscsi_bus_device**.
- A segunda, **scsi_refid**, é uma referência opaca para passar algumas
  operação ao barramento.
- Finalmente, o **scsi_id** dá um SCSI ID individual por tag de
  dispositivo. É escrito uma vez na inicialização e nunca é lido ou
  gravado depois, o dispositivo pode fazer o que quiser com o valor ou a
  variável.

- O método virtual **scsi_ctrl_changed** é chamado quando for assistir
  as mudanças das linhas de controle. É através do barramento que são
  definidas quais as linhas serão monitoradas.

Para acessar as linhas existe uma proposta com cinco métodos:

* **ctrl_r()** e **data_r()** são os métodos de leitura.
  Os controles de bits são definidos dentro do enum [1]_ **s_\*** de
  **nscsi_device**.

* Os três bits abaixo (**INP**, **CTL** e **MSG**) são configurações
  para que o "masking" com 7(**S_PHASE_MASK**) retorne os números para
  as fases, que também estão disponíveis com o enum **S_PHASE_\***.

* A escrita nas linhas de dados é feito com ``data_w(scsi_refid,
  value)``.

* A escrita nas linhs de controle é feito com
  ``ctrl_w(scsi_refid, value, mask-of-lines-to-change)``.
  Para alterar todas as linhas de controle com uma chamada use a máscara
  **S_ALL**.

Claro que o que é lido é a lógica de tudo o que é conduzido por todos os
dispositivos.

* Finalmente, o método
  ``ctrl_wait_w(scsi_id, value, mask of wait lines to change)``, permite
  selecionar quais as linhas de controle que são monitoradas. A máscara
  de monitoramento é individual para cada dispositivo, o
  **scsi_ctrl_changed** é chamado sempre que uma linha de controle da
  máscara for alterado, devido a uma ação de um outro dispositivo (não
  em si, para evitar uma recursão irritante e um tanto inútil).

A implementação do controle é apenas uma questão de seguir o estado
descritivos das máquinas, pelo menos se eles estiverem disponíveis.
A única parte não descrita é a arbitragem/seleção que está documentada
na norma do SCSI. Para um iniciador (o que é que o controlador sempre é
essencialmente), funciona assim:

* espera o barramento ficar ocioso
* garante em qual número o seu **scsi_id** está na linha de dados
  (``1 << scsi_id``)
* espera o tempo de atribuição
* verifica se as linhas de dados ativas com o número maior é a sua

  * caso não seja, a atribuição é perdida, pare a condução de tudo e
    reinicie

* garante a linha selecionada (nesse ponto o barramento é seu)
* espera um pouco
* mantém a sua linha de dados garantida, garante que o número da linha
  de dados é o SCSI ID de destino
* espera um pouco
* garante que caso a linha **atn** seja necessária, retorne como sinal
  ocupado
* espera que o sinal ocupado seja garantido ou que acabe o tempo limite
  (timeout)

  * O tempo limite significa que ninguém está respondendo naquele ID,
    desocupe tudo e pare
* aguarda por um curto período até o **de-skewing**
* desocupa o barramento de dados e seleciona uma linha
* espera mais um pouco

E tudo pronto, você está conectado com o dispositivo de destino até que
o alvo desocupe a linha ocupada, seja porque você pediu ou apenas para
te aborrecer. O **de-assert** (desocupar) é chamado de desconexão.

O **ncr5390** é um exemplo de como usar um estado de máquina com dois
níveis de estado para lidar com todos os eventos.


Criando um novo dispositivo SCSI usando o **nscsi_full_device**
---------------------------------------------------------------

A classe base "**nscsi_full_device**" é usada para criar dispositivos
SCSI HLE-d destinados para uso genérico, como discos rígidos, CD-ROMs,
scanners talvez, etc. A classe fornece a manipulação de protocolo SCSI,
deixando somente a manipulação de comando e (opcionalmente) o tratamento
de mensagens para a implementação.

A classe atualmente suporta apenas dispositivos de destino.

O primeiro método para implementar é **scsi_command()**. Esse método é
chamado quando um comando chegar por completo. O comando está disponível
em **scsi_cmdbuf[]** e seu comprimento fica em **scsi_cmdsize** (porém o
comprimento em geral é inútil ao primeiro byte de comando dado).
A matriz de 4096-bytes **scsi_cmdbuf** pode então ser modificada
livremente.

Em **scsi_command()**, o dispositivo pode lidar com o comando ou
passá-lo com **nscsi_full_device::scsi_command()**.

Para lidar com o comando, vários métodos estão disponíveis:

- **get_lun(lua set in command)** lhe dará o LUN a ser trabalhado (o
  **in-command** um pode ser substituído por um nível de mensagem um).

- **bad_lun()** respostas para o host que o LUN específico não tiver
  suporte.

- **scsi_data_in(buffer id, size)** envia bytes com tamanho vindo da
  memória intermédia **buffer-id**

- **scsi_data_in(buffer id, size)** recebe bytes com o tamanho para a
  memória intermédia **buffer-id**

- **scsi_status_complete(status)** termina o comando com um determinado
  status.

- **sense(deferred, key)** prepara o senso da memória intermédia para um
  comando subsequente de solicitação, que é útil ao retornar um status
  de verificação da condição.

Os comandos **scsi_data_\*** e **scsi_status_complete** são
enfileirados, o manipulador de comandos deve chamá-los todos sem
tempo de espera.

O **buffer-id** identifica a memória intermediária. 0 também conhecido
como **SBUF_MAIN**, direciona a memória intermédia **scsi_cmdbuf**.
Os outros valores aceitáveis são 2 ou mais. 2+ ids são manipulados pelo
método **scsi_get_data** para leitura e **scsi_put_data** para gravação.

**UINT8 device::scsi_get_data(int id, int pos)** deve retornar o id da
posição do byte na memória intermediária, chamando em
**nscsi_full_device** por *id < 2*.

**void device::scsi_put_data(int id, int pos, UINT8 data)** deve
escrever o id da posição do byte na memória intermediária, chamando em
**nscsi_full_device** por *id < 2*.

O **scsi_get_data** e o **scsi_put_data** devem fazer as leituras e
gravações externas quando for necessário.

O dispositivo também pode sobrescrever o **scsi_message** para lidar com
mensagens SCSI diferentes daquelas tratadas de forma genérica e também
pode substituir alguns dos tempos (mas muitos deles não são usados,
cuidado).

Para facilitar as coisas uma certa quantidade de "*enums*" é definida:

- O enum **SS_\*** dá retornos de status (como **SS_GOOD** para todos
  que em condições boas).
- O enum **SC_\*** fornece os comandos SCSI.
- O enum **SM_\*** fornece as mensagens SCSI, com exceção do
  identificador (que é ``80-ff``, realmente não se encaixa em um enum).


O que falta no **scsi_full_device**
-----------------------------------


- **Suporte ao iniciador** Nesse momento, não temos nenhum dispositivo
  iniciador para o HLE.

- **Delays** Um comando *scsi_delay* ajudaria a dar tempos (*timings*)
  mais realistas, particularmente ao leitor de CD-ROM.

- **Operações desconectadas** Primeiro exigiria atrasos e além disso,
  um sistema operacional emulado que pudesse manipulá-lo.

- **Operação ampla em 16-bits** Precisa de um SO e de um iniciador que
  possam manipulá-lo.


O que falta no ncr5390 (e provavelmente em outros controladores futuros)
------------------------------------------------------------------------

- **A detecção de um barramento livre** No momento, o barramento é
  considerado livre caso o controlador não esteja ocupado, o que é
  verdade. Isso pode mudar uma vez que a operação de desconexão esteja
  em ação.

- **Comandos alvo** Ainda não são emulados ainda (vs. HLE).

.. [1]	Assumo que o termo abreviado "*enum*" seja um enumerador.
		(Nota do tradutor)
