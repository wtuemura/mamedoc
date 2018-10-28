.. raw:: latex

	\clearpage

O novo subsistema de disquete
=============================

Introdução
----------

O novo subsistema de disquete visa emular o comportamento de disquetes e
controladores de disquetes em nível baixo o suficiente a ponto de fazer
com que as proteções também funcionem de forma transparente. O objetivo
é alcançado ao seguir a configuração de um hardware real:

- uma classe de imagem de disquete que mantém na memória o estado
  magnético da superfície flexível e as suas características físicas.

- uma classe manipuladora de imagem fala com a classe de imagem de
  disquete visando simular o drive de disquete, fornecendo todos os
  sinais existentes em um conector de disquete.

- dispositivos controladores que conversam com o manipulador de imagem e
  fornecem as interfaces de registo para o host que todos nós conhecemos
  e amamos.

- nas classes de manipulação de formato, lhes são dadas a tarefa de
  converter a origem e destino de forma neutra de uma imagem de disco
  físico para um estado de formato magnético do disco na memória,
  de forma que a classe gerenciadora do disquete possa geri-la.


O armazenamento de disquete para leigos
---------------------------------------

O disquete
~~~~~~~~~~

O disquete é um disco que armazena as orientações magnéticas em sua
superfície, dispostas em uma série de círculos concêntricos chamado de
faixas ou cilindros [1]_. As suas principais características são o seu
tamanho que vai de um diâmetro em torno de 2.8 polegadas
(63.5 milímetros) até 8 polegadas (200 milímetros), seu número de lados
graváveis (1 ou 2) e sua resistividade magnética. A resistividade
magnética indica o quão perto uma mudança na orientação magnética pode
ocorrer e a informação mantida.
Isso é um terço do que define o termo "densidade" que é usado com tanta
frequência para disquetes (os outros dois são o tamanho da cabeça do
drive de disquetes e a codificação a nível de bit (*bit-level encoding*
no Inglês).

As orientações magnéticas são sempre binárias, elas sempre apontam para
um lado ou para o outro, não há nenhum estado intermediário. A sua
direção pode estar na tangente da pista, na mesma direção, oposta a
rotação ou no caso de uma gravação no sentido perpendicular, a direção é
perpendicular (por isso o nome). A gravação no sentido perpendicular
permite que os dados de gravação ocupem menos espaço permitindo uma
maior densidade de gravação, porém chegou no final do tempo de vida da
tecnologia. Os discos com 2.88 Mb e derivados dos disquetes como Zip
Drives (etc), usavam gravação perpendicular. Para fins de emulação, a
direção não importa, o que importa é o fato que duas orientações são
possíveis. Além dessas orientações mais duas são possíveis: uma parte da
trilha pode ser desmagnetizada (sem orientação) ou danificada (sem
orientação ou não pode ser gravada).

Uma posição específica na rotação disco dispara um pulso de índice.
Essa posição pode ser detectada através de um buraco na superfície
(muito visível em disquetes 5.25 e 3 polegadas por exemplo) ou através
de uma posição específica do centro de rotação (disquetes com 3.5
polegadas, talvez outros). Esse pulso de índice é usado para determinar
o início da faixa, porém não é usado por todos os sistemas. Os disquetes
mais antigos de 8 polegadas têm múltiplos buracos marcando o índice
determinando o início dos setores (chamados de setor duro), no entanto
um deles está numa posição diferente para ser reconhecido como um início
de trilha, e os outros estão em posições fixas relativas à origem.


Unidade de Disquete
~~~~~~~~~~~~~~~~~~~

Uma unidade de disquete é o aparelho que lê e grava um disquete. Inclui
um conjunto capaz de girar o disco a uma velocidade fixa e uma ou duas
cabeças magnéticas ligadas a um motor de posicionamento para acessar as
trilhas.

A largura da cabeça e o tamanho do passo do motor de posicionamento
determinam quantas trilhas estão escritas no disquete. O número total de
trilhas varia entre 32 até 84 de acordo com o disquete e o drive, a
trilha 0 ficando mais ao externo (mais longo) dos círculos concêntricos,
e o maior com o menor círculo interno. Como resultado, as faixas com os
números mais baixos têm a menor densidade física de orientação
magnética, portanto, uma melhor confiabilidade. É por isso que
estruturas importantes e/ou frequentemente alteradas, como o bloco de
inicialização ou a tabela de alocação FAT, estão na trilha 0. É também
aí que vem a terminologia "stepping in" para aumentar o número da faixa
e "stepping out" para diminuí-lo. O número de faixas disponíveis é a
segunda parte do que geralmente está por trás do termo "densidade".

Um sensor detecta quando a cabeça está na faixa 0 e o controlador não
deve passar por ela. Além disso, bloqueios físicos impedem que a cabeça
saia do alcance correto da pista. Alguns sistemas (Apple II, alguns C64)
não levam em conta o sensor da trilha 0 fazendo com que a cabeça vá
contra o limite físico do bloco, fazendo um ruído de impacto bem
conhecido e eventualmente danificando o alinhamento da cabeça.

Além disso, alguns sistemas (Apple II e C64) têm acesso direto às fases
do motor de posicionamento da cabeça, permitindo que a cabeça se
posicione entre as pistas, no meio ou mesmo em posições intermediárias.
Isso não era útil para escrever mais faixas, uma vez que a largura da
cabeça não mudava, mas como a leitura confiável só era possível com a
posição correta, ela era usada como proteção contra cópia por alguns
sistemas.

O disco gira a uma velocidade fixa para uma determinada faixa.
A velocidade mais comum é de 300 RPM para cada faixa, com 360 rpm
encontrado para os disquetes de alta densidade com 5.25 polegadas e a
maioria dos disquetes com 8 polegadas. A velocidade dos primeiros
disquetes giravam em torno de 90 RPM ou até mesmo 150 RPM para um
disquete de alta densidade em um Amiga. Ter uma velocidade rotacional
fixa para todo o disco é chamada de Velocidade Angular Constante
(CAV em inglês) usada por quase todos ou Velocidade Angular Constante
Zoneada (ZCAV em inglês, usado no C64), dependendo se a taxa de bits de
leitura/gravação é constante ou depende da faixa. Alguns sistemas como
Apple II e Mac variam a velocidade de rotação dependendo da faixa (algo
como até 394 RPM) para terminar como uma Velocidade Linear Constante
(*Constant Linear Velocity* ou CLV em Inglês). A ideia por trás do
ZCAV/CLV é extrair mais bits da mídia mantendo o espaçamento mínimo
entre transições de orientação magnética, oferecendo a melhor
performance possível entre o espaço ocupado e a velocidade de transição
da cabeça. Parece que a complexidade não foi considerada válida já que
quase nenhum sistema faz.

Finalmente, após o disco girar e a cabeça estiver sob a posição
adequada, a leitura correta da faixa acontece. A leitura é feita através
de uma cabeça indutiva, que lhe dá a característica interessante de não
ler a orientação magnética de forma direta, ao invés disso, ser sensível
o suficiente às inversões de orientação, chamadas de transições de
fluxo. Esta detecção é fraca e pouco precisa, de modo que um
amplificador com Ajuste de Ganho Automático (*Automatic Gain Control*
ou AGC em Inglês) e um detector de pico são colocados de forma a
trabalhar em conjunto com da cabeça para fornecer pulsos limpos.
O AGC aumenta lentamente o nível de amplificação até que um sinal
ultrapasse um limite pré determinado, em seguida ajusta seu ganho para
que o dito sinal esteja estável em um nível fixo dentro deste limite.
Conforme a oscilação vai acontecendo o AGC entra em ação novamente.
Isso faz com que o amplificador se calibre para os sinais lidos no
disquete, desde que as transições de fluxo aconteçam com uma certa
frequência. Em uma zona muito longa, ocorre a captação de ruídos
aleatórios do ambiente, fazendo com que a amplificação deste sinal
ultrapasse o limite pré estabelecido, criando pulsos falsos onde não
existem nenhum. Muito longa neste caso são aquelas que acontecem entre
16-20us sem nenhuma transição.

Isso significa que uma zona suficientemente longa com uma orientação
magnética fixa ou nenhuma orientação (desmagnetizada ou danificada) será
lida como uma série de pulsos aleatórios após um breve atraso. Isso é
usado por proteções e é conhecido como "weak bits", que ao serem lidos
os dados são diferente cada vez que são acessados.

Um segundo nível de filtragem ocorre após o detector de pico. Quando
duas transições estão um pouco próximas (mas ainda acima do limiar da
mídia), um efeito saltante acontece entre elas, dando dois pulsos muito
próximos no meio, além dos dois pulsos normais. O drive de disquete
consegue detectar quando os pulsos estão muito próximos e os elimina,
deixando os pulsos normais novamente. Como resultado, se alguém escrever
uma cadeia de pulsos de alta frequência para o disquete, eles serão
lidos como um trem de pulsos muito próximos (fracos porque estão acima
da tolerância da mídia, mas capturados pelo AGC de qualquer forma,
apenas de forma pouco confiável) eles serão todos filtrados, dando uma
grande quantidade de tempo sem qualquer pulso no sinal de saída. Isso é
usado por algumas proteções uma vez que não é gravável usando o relógio
normal do controlador.

A escrita é simétrica, com uma série de pulsos enviados que fazem a
cabeça de gravação inverter a orientação do campo magnético cada vez que
um pulso é recebido.

Então, para concluir, a unidade de disquete fornece insumos para disco
de controle de rotação e a posição da cabeça (assim como a escolha
quando é de dupla-face), os dados são enviados de duas maneiras como um
trem de pulsos que representam inversões de orientação magnética.
O valor absoluto da orientação em si nunca é conhecido.


Controlador de Disquete
~~~~~~~~~~~~~~~~~~~~~~~

A tarefa do controlador de disquete é transformar a comunicação da
unidade de disquete em algo a CPU principal possa compreender.
O nível de compatibilidade entre um controlador e outro varia aos
extremos, vai de praticamente nada nos Apple II e C64, com alguma coisa
no Amiga e para completar Circuitos Integrados da *Western Digital*,
família **uPD765**).
Funções comuns incluem a seleção da unidade, controle do motor, busca
das trilhas e claro a leitura e gravação de dados. Destes somente os
dois últimos precisam ser descritos pois o resto é óbvio.

Os dados são estruturados em dois níveis: como bits individuais (meio
byte ou bytes) que são codificados na superfície e como estes são
agrupados em setores endereçados individualmente. Existem dois padrões
para eles chamados *Frequency Modulation* (sigla FM no inglês) e
*Modified Frequency Modulation* (sigla MFM no inglês), além de uma
série de outros sistemas e suas variantes. Além disso, alguns sistemas
tais como o Amiga usa um padrão de codificação *bit-level encoding*
(MFM) com uma organização de nível setorial local.


Codificação a nível de bit
--------------------------

Organização Celular
~~~~~~~~~~~~~~~~~~~

Todos os controladores de disquetes, até os mais esquisitos como o
Apple II, começa dividindo a pista em células de igual tamanho. Eles são
seções angulares no meio de onde uma inversão de orientação magnética
pode estar presente. Do ponto de vista do hardware, as células são
vistas como durações que combinada com a rotação do disquete determina
a seção. Por exemplo o tamanho padrão de uma célula MFM para um disquete
de dupla densidade com 3 polegadas é de 2us, também combinada com uma
velocidade de rotação com 300 RPM, dá um tamanho angular de 1/100.000
por volta. Outra maneira de dizer a mesma coisa é que há 100K (cem mil)
células em uma pista de dupla densidade de um disquete de 3 polegadas.

Em cada célula pode ou não haver uma transição de orientação magnética,
por exemplo, uma pulsação vindo de uma leitura ou ir para a escrita da
unidade de disquete. Uma célula com um pulso é tradicionalmente
conhecida como '1', e um sem '0'. Embora, duas restrições aplicam-se
para o conteúdo da célula. Primeiro, os pulsos não devem ser muito
juntos ou eles irão causar um borrão um ao outro, e/ou serão filtrados.

O limite é ligeiramente melhor do que 1/50.000 de uma volta para
disquete com densidade simples e dupla, metade disso para disquetes
de alta densidade e metade disso novamente para disquetes com densidade
estendida (ED) com gravação perpendicular. Segundo, eles não devem ser
muito longe um do outro, ou seja o AGC vai ficar instável e introduzir
pulsos fantasmas ou o controlador vai perder sincronização e obter um
sincronismo errado sobre as células durante a leitura.
Para via de regra geral, é melhor não ter mais de 3 células '0'
consecutivas.

Certas proteções usam isso para tornar os formatos não reconhecíveis
pelo controlador do sistema, quebrando a regra de três zeros ou brincar
com as durações e tamanhos das células.

Bit endocing é a arte de transformar dados brutos em uma célula de
configuração 0/1 que respeite as os dois limites.

Codificação FM
~~~~~~~~~~~~~~

O primeiro método de codificação desenvolvido para disquetes é chamado
de Frequência Modulada (*Frequency Modulation* ou FM), o tamanho da
célula é definida um pouco além do limite físico, como 4us por exemplo.
Isso significa que é possível ter '1' célula consecutiva de confiança.
Cada bit é codificado em duas células:

- a primeira célula, chamada o clock bit é '1'

- a segunda célula, chamada de data bit, é o bit em si

Uma vez que todas as outras células seja pelo menos '1' não há nenhum
risco de ir além de três zeros.

O nome Frequência Modulada simplesmente deriva do fato de que um 0 é
codificado com um período de trem de pulsos em 125 Khz enquanto um 1
são dois períodos do trem de pulso em 250 Khz.

Codificação MFM
~~~~~~~~~~~~~~~
A codificação de FM foi substituída pela codificação *Modified Frequency
Modulation (MFM)*, que pode empilhar exatamente o dobro de dados na
mesma superfície, daí seu outro nome de "dupla densidade".
O tamanho da célula é definido com um pouco mais de metade do limite
físico, 2us normalmente. A restrição significa que duas células '1'
devem ser separadas por pelo menos uma célula '0'. Cada bit é novamente
codificado em duas células:

- a primeira célula, chamada de clock bit, é '1' se ambos os bits de
  dados anteriores e atuais forem 0, então será '0'

- a segunda célula, chamada de data bit, é o bit em si

A regra de espaço mínimo é respeitada uma vez que um '1' de clock bit é,
por definição, rodeado por dois '0' de data bits e um '1' data bit é
rodeado por dois '0' clock bits. A maior cadeia de célula 0 possível é
quando ao codificar 101 que retorna x10001, respeitando o limite máximo
de três zeros.

Codificação GCR
~~~~~~~~~~~~~~~

As codificações *Group Coded Recording*, ou GCR, são uma classe de
codificações onde cadeias de bits com pelo menos tamanho de meio byte ou
4 bit são codificadas em um determinado fluxo de células dado por uma
tabela. Ele foi usado particularmente pelo Apple II, o Mac e o C64, e
cada sistema tem sua própria tabela ou tabelas.

Outras codificações
~~~~~~~~~~~~~~~~~~~

Existem outras codificações como o M2FM, mas elas são muito raras e
específicas para um determinado sistema.

Lendo os dados codificados
~~~~~~~~~~~~~~~~~~~~~~~~~~

Escrever dados codificados é fácil, você só precisa de um relógio na
frequência apropriada e enviar ou não uma cadeia de pulsos ao redor do
relógio. A diversão está em ler esses dados.
As células são uma construção lógica e não uma entidade física
mensurável.

As velocidades rotacionais variam ao redor dos valores definidos (+/- 2%
não é raro) e perturbações locais (turbulência do ar, distância da
superfície...) no geral, tornam a velocidade instantânea muito variável.
Portanto, para extrair o fluxo de valores da célula, o controlador deve
sincronizar dinamicamente com o trem de pulso que a cabeça do disquete
seleciona. O princípio é simples: uma janela de duração do tamanho da
célula é construída dentro da qual a presença de pelo menos um pulso
indica que a célula é um '1' e a ausência de qualquer um '0'.
Depois de chegar ao final da janela, a hora de início é movida
apropriadamente para tentar manter o pulso observado no meio exato dessa
janela. Isso permite corrigir a fase em cada célula '1', fazendo a
sincronização funcionar se a velocidade de rotação não estiver muito
fora.

Gerações subsequentes de controladores usaram um *Phase Locked Loop*
(PLL) que varia a duração da fase e da janela para se adaptar melhor as
velocidades erradas de rotação, geralmente com uma tolerância de +/-
15%.

Depois que o fluxo de dados da célula é extraído, a decodificação
depende da codificação. No caso de FM e MFM, a única questão é
reconhecer os bits de dados dos bits de clock, enquanto no GCR a posição
inicial do primeiro grupo deve ser encontrada. O segundo nível de
sincronização é tratado em um nível mais alto usando padrões não
encontrados em um fluxo normal.


Organização de nível no setor
-----------------------------

Os disquetes foram concebidos para a leitura e gravação com acesso
aleatório para blocos de dados de tamanhos razoáveis. Permite a seleção
de faixas para um primeiro nível de acesso aleatório e dimensionamento,
mas os 6 K de uma faixa de densidade dupla seria muito grande para ser
lidado por um bloco. 256/512 bytes são considerados um valor mais
apropriado. Para o efeito, dados em uma faixa são organizados como uma
série de (cabeçalho do setor, dados do setor) pares onde o cabeçalho do
setor indicam informações importantes, como o número do setor, tamanho,
e os dados do setor que contém os dados. Os setores tem que ser
quebrados em duas partes, porque enquanto a leitura é fácil, é lido o
cabeçalho, depois os dados sem assim for necessário, para escrever
requer a leitura do cabeçalho para encontrar o lugar correto, para só
então ligar a cabeça de escrita para os dados. A escrita inicial não é
instantânea e a fase não está perfeitamente alinhada com a cabeça de
leitura, portanto, um espaço para a sincronização é necessária entre o
cabeçalho e dados.

Somando a isso, em algum lugar no setor do cabeçalho e no sector dos
dados, geralmente são adicionados algum tipo de checksum para permitir
a verificação da integridade destes dados.

O FM e o MFM (nem sempre utilizaram) métodos de layout padrão do setor.

Layout do setor de FM
~~~~~~~~~~~~~~~~~~~~~

O layout padrão em FM de trilha/setor para um "PC" é assim:

- Uma quantidade de 0xff codificados em FM (40 geralmente)

- 6 0x00 codificados em FM (dando uma cadeia de pulso estável em 125 Khz)

- Um fluxo 1111011101111010 com 16 células (f77a, clock 0xd7, data 0xfc)

- Uma quantidade de 0xff codificados em FM (geralmente 26, muito volátil)

Então para cada setor:
- 6 0x00 codificados em FM (dando uma cadeia de pulso estável em 125 Khz)

- Um fluxo 1111010101111110 com 16 células (f57a, clock 0xc7, data 0xfe)

Cabeçalho do sector, faixa codificada em FM, cabeça, setor, código de
tamanho e dois bytes de crc por exemplo

- 11 0xff codificados em FM

- 6 0x00 codificados em FM (dando uma cadeia de pulso estável em 125 Khz)

- Um fluxo 1111010101101111 com 16 células (f56f, clock 0xc7, data 0xfb)

- Dados do setor codificado em FM seguido por dois bytes CRC

- Uma quantidade de 0xff codificados em FM (geralmente 48, muito volátil)

A trilha é terminada com um fluxo de células '1'.

Os trens de pulsos com 125 KHz são utilizados para travar o PLL ao
sinal corretamente. Os fluxos específicos com 16 células permitem
distinguir entre o clock e os data bits fornecendo um arranjo que não é
comum ocorrer em dados codificados em FM. No cabeçalho do sector da
trilha, os números começam em 0, cabeças são 0/1 dependendo do tamanho,
os números do setor geralmente começam em 1 e o tamanho do código é 0
para 128 bytes, 1 para 256, 2 para 512, etc.

O CRC é uma verificação de redundância cíclica dos bits de dados,
começando com uma marca logo após o trem de pulso usando o polinômio
0x11021.

Os controladores com base na Western Digital geralmente livram-se de
tudo deixando alguns 0xff no primeiro setor e permitem um melhor uso do
espaço como resultado.

Layout do setor de FM
~~~~~~~~~~~~~~~~~~~~~

O layout padrão de trilha/sector para MFM num "PC" é assim:

- Uma quantidade de 0x4e codificados em MFM (80 geralmente)

- 12 0x00 codificados em FM (dando uma cadeia de pulso estável em
  125 Khz)

- Um fluxo 0101001000100100 com 16 células (5224, clock 0x14, data 0xc2)

- O valor 0xfc codificado em MFM

- Uma quantidade de 0x4e codificados em MFM (geralmente 50, muito
  volátil)

Então para cada setor:

- 12 0x00 codificados em FM (dando uma cadeia de pulso estável em
  125 Khz)

- Três vezes um fluxo 0100010010001001 com 16 células (5224, clock 0x14,
  data 0xc2)

- Cabeçalho do sector, 0xfe codificado em MFM, trilha, cabeça, setor,
  código de tamanho e dois bytes de CRC por exemplo

- 22 0x4e codificado em MFM

- 12 0x00 codificados em MFM (dando uma cadeia de pulso estável em
  125 Khz)

- Três vezes um fluxo 0100010010001001 com 16 células (5224, clock 0x14,
  data 0xc2)

- 0xfb codificado em MFM, dados do setor seguido por dois bytes CRC

- Uma quantidade de 0x4e codificados em MFM (geralmente 84, muito
  volátil)

A trilha é finalizada com um fluxo 0x4e codificado em MFM.

Os trens de pulsos com 125 KHz são utilizados para travar o PLL ao
sinal de forma correta. A célula com o arranjo 4489 não aparece numa
codificação de dados MFM normal e é usada para a separação de
clock/dados.

Já para FM, os controladores com base Western Digital geralmente
livrarm-se de tudo menos alguns 0x4e antes do primeiro setor e permite
um melhor uso do espaço como resultado.

Formatação e escrita
~~~~~~~~~~~~~~~~~~~~

Para ser utilizável, um disquete deve ter os cabeçalhos do setor e os
dados padrão escritos em cada trilha. O controlador começa a escrita em
um determinado lugar, muitas vezes pelo pulso de índice, mas em alguns
sistemas sempre que o comando é enviado ele grava até que seja feita uma
volta completa. Isso é conhecido como formatação de disquete. No ponto
onde a escrita termina, há uma perda de sincronização uma vez que não
há nenhuma chance do relógio de fluxo da célula terminar a escrita de
forma correta. Esta mudança de fase brutal é chamada uma gravação da
tala, especificamente a faixa escrever da tala. É o ponto onde a
escrita deve começar se você quiser uma cópia raw da faixa para um novo
disquete.

Igualmente duas junções de gravação são criadas quando um setor é
escrito no início e no final da parte do bloco de dados. Não deveria
acontecer num disco masterizado, mesmo que haja algumas raras exceções.


A nova implementação
--------------------

Representação do disquete
~~~~~~~~~~~~~~~~~~~~~~~~~


O conteúdo do disquete é representado pela classe *floppy_image*.
Contém informações do tipo de mídia e uma representação do estado
magnético da superfície.

O tipo de mídia é dividido em duas partes. A primeira metade indica o
fator de forma física, ou seja, todas as mídias com esse fator podem ser
fisicamente inseridas em um leitor que puder manuseá-lo.
A segunda metade indicam as variantes que são geralmente detectáveis
pelo leitor, tais como a densidade e o número de lados.

Trilha de dados consiste em uma série valores lsb primários em 32-bits
representando as células magnéticas. Os bits 0-27 indicam a posição
absoluta do início da célula (não o tamanho) e os bits 28-31 indicam os
tipos. Os tipos podem ser:

- 0, MG_A -> Orientação Magnética A

- 1, MG_B -> Orientação Magnética B

- 2, MG_N -> Zona não magnetizada (neutra)

- 3, MG_D -> Zona danificada, lê como neutra mas não pode ser alterada
  por escrita

A posição está em unidades angulares de 1/200,000,000 de uma volta.
Corresponde a um nanossegundo quando a unidade gira a 300 RPM.

A última posição implícita da célula é 200,000,000.

As trilhas não formatadas são codificadas com um tamanho zero.

A informação de "junção de trilha" indica onde começar a escrever caso
você tente reescrever um disco físico com dados. Alguns formatos de
preservação codificam essa informação, ela é adivinhada para os outros.
A função de gravação da trilha do fdcs deve configurá-la.
A representação é a posição angular relativa ao índice.

Convertendo de e para uma representação interna
-----------------------------------------------

Classe e interface
~~~~~~~~~~~~~~~~~~

Precisamos ser capazes de converter para a representação interna os
formatos de dados contidos no disquete. Isso é feito através de classes
derivadas de *floppy_image_format_t*. A interface a ser implementada
deve conter:

- **name()** fornece um nome abreviado ao formato no disco

- **description()** fornece uma breve descrição do formato

- **extensions()** fornece uma lista separada por vírgula das extensões
  dos nomes de arquivos encontrados para esse formato

- **supports_save()** retorna verdadeiro se houver compatibilidade com o
  formato externo

- **identify(file, form factor)** retorna uma pontuação entre 0-100 para
  o arquivo que for daquele formato:

  - **0**	= esse formato não
  - **100**	= provavelmente esse formato
  - **50**	= formato identificado apenas pelo tamanho do arquivo

- **load(file, form factor, floppy_image)** carrega uma imagem e a
  converte para a representação interna

- **save(file, floppy_image)** (se implementado) convertido da
  representação interna e salva em uma imagem

Todos estes métodos são previstos para serem sem estado.

Métodos auxiliares de conversão
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Vários métodos são fornecidos para simplificar a gravação das classes do
conversor.


Métodos de conversão orientados à leitura
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


| **generate_track_from_bitstream(track number,**
|                               **head number,**
|                               **UINT8 \*cell stream,**
|                               **int cell count,**
|                               **floppy image)**
|

  Obtém um fluxo de tipos de células (0/1), primeiro o MSB, converte-o
  para o formato interno e armazena-o na devida trilha e cabeça de uma
  determinada imagem.

| **generate_track_from_levels(track number,**
|                            **head number,**
|                            **UINT32 \*cell levels,**
|                            **int cell count,**
|                            **splice position,**
|                            **floppy image)**

  Pega uma variante do formato interno onde cada valor representa uma
  célula, a parte da posição dos valores é o tamanho da célula e a parte
  do nível é MG_0, MG_1 para os tipos de células normais, MG_N, MG_D
  para as células não formatadas ou danificadas e MG_W para os bits mais
  fracos no estilo *Dungeon-Master*.
  Converte para o formato interno. Os tamanhos são normalizados para que
  eles tenham uma volta completa no total.

| **normalize_times(UINT32 \*levels,**
|                 **int level_count)**

  Pega um buffer de formato interno onde a parte da posição representa o
  ângulo até a próxima mudança e o transforma em um fluxo normal de
  posição, primeiro garantindo que o tamanho total seja normalizado para
  uma volta completa.


Métodos de conversão orientados a gravação
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

| **generate_bitstream_from_track(track number,**
|                               **head number,**
|                               **base cell size**,
|                               **UINT8 \*cell stream,**
|                               **int &cell_stream_size,**
|                               **floppy image)**

  Extrai um fluxo da célula 0/1 do formato interno usando uma
  configuração PPL com um tamanho de célula inicial definida para
  '*base cell size*' e uma tolerância de +/- 25%.


| **struct desc_xs { int track, head, size; const UINT8 \*data }**
| **extract_sectors_from_bitstream_mfm_pc(...)**
| **extract_sectors_from_bitstream_fm_pc(const UINT8 \*cell stream,**
|                                      **int cell_stream_size,**
|                                      **desc_xs \*sectors,**
|                                      **UINT8 \*sectdata,**
|                                      **int sectdata_size)**

  Extrai os setores padrão MFM ou FM de um fluxo de células regeneradas.
  Os setores devem apontar para uma matriz com 256 ofdesc_xs.

  Um setor existente é reconhecível por ter -> dados não nulos.
  Os dados do setor são escritos em sectdata até os bytes sectdata_size.


| **get_geometry_mfm_pc(...)**
| **get_geometry_fm_pc(floppy image,**
|                     **base cell size,**
|                     **int &track_count,**
|                     **int &head_count,**
|                     **int &sector_count)**

  Extrai a geometria (cabeças, trilhas, setores) de uma imagem de
  disquete tipo pc, verificando a trilha 20.


| **get_track_data_mfm_pc(...)**
| **get_track_data_fm_pc(track number,**
|                      **head number,**
|                      **floppy image,**
|                      **base cell size,**
|                      **sector size,**
|                      **sector count,**
|                      **UINT8 \*sector data)**


  Extrai o que você obteria ao ler na ordem dos setores '*sector size*'
  do número 1 para o contador do setor e registra o resultado no setor
  de dados.

.. raw:: latex

	\clearpage

Unidade de Disquete
-------------------

A classe *floppy_image_interface* simula a unidade de disquete.
Isso inclui uma série de sinais de controle, leitura e escrita.
Os sinais de controle de alterações devem ser sincronizadas, disparo
do temporizador para assegurar que a hora atual seja a mesma para
todos os dispositivos, por exemplo.

Sinais de controle
~~~~~~~~~~~~~~~~~~

Devido à maneira de como estão ligados na CPUs (diretamente numa porta
I/O por exemplo), o controlador de sinais trabalha com valores físicos
ao invés de lógicos. Em geral, o 0 significa ativo e 1 inativo.
Alguns sinais têm também um retorno de chamada associado a eles quando
mudam.

**mon_w(state) / mon_r()**

  Sinal para ligar o motor, gira no 0


**idx_r() / setup_index_pulse_cb(cb)**

  Sinal de indexação, vai a 0 no início da pista por aproximadamente
  2ms. O retorno de chamada é sincronizado. Só acontece quando um disco
  está em funcionamento e o motor está funcionando.


**ready_r() / setup_ready_cb(cb)**

  Sinal de pronto (*Ready*), vai a 1 quando o disco é removido ou o motor
  é parado. Vai a 0 depois de dois pulsos indexados.


**wpt_r() / setup_wpt_cb(cb)**

  Sinal de proteção contra gravação (1 = somente leitura).
  O retorno de chamada não é sincronizado.


**dskchg_r()**

  Sinal de mudança de disco, vai a 1 quando um disco é alterado, vai a 0
  para a mudança de trilha.


**dir_w(dir)**

  Seleciona a direção do passo da trilha (1 = fora = diminui o número da
  trilha).


**stp_w(state)**

  Sinal de passo, move-se por uma trilha na transição 1->0.


**trk00_r()**

  Sensor de trilha 0, retorna 0 quando estiver na trilha 0


**ss_w(ss) / ss_r()**

  Seleciona um lado


Interface de leitura e gravação
-------------------------------

A interface de leitura e gravação é projetada para trabalhar de forma
assíncrona, de maneira independentemente da hora atual, por exemplo.



.. [1]	 O cilindro é um termo de disco rígido usado de forma inadequada
		para disquetes. Ele vem do fato que os discos rígidos são
		semelhantes aos disquetes, mas incluem uma série de discos
		empilhados com uma cabeça de leitura/gravação em cada um deles.
		As cabeças estão fisicamente ligadas e todas apontam para o
		mesmo círculo em cada disco em um determinado momento, fazendo
		com que a área acessada pareça com um cilindro.
		Daí o nome. (Nota do tradutor)
