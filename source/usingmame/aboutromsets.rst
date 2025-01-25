.. raw:: latex

	\clearpage


.. _aboutromsets:

Sobre as ROMs e os seus conjuntos
=================================

O manuseio e a atualização das ROMs e de seus respectivos conjuntos
provavelmente causam a maior confusão e geram problemas entre os
usuários do MAME, especialmente os iniciantes.

Esta seção tem como objetivo esclarecer diversos tópicos sobre o
assunto, tirar dúvidas comuns e abordar detalhes importantes para usar o
MAME de forma mais eficaz.


.. _aboutromsets_rom:

O que é uma imagem ROM?
-----------------------

A programação do jogo em si é armazenada em circuitos integrados [#CI]_
na placa-mãe do arcade ou em outro tipo de dispositivo (CD-ROM, DVD-ROM,
HDD, etc.). Esses circuitos são chamados de ROMs, um acrônimo de
*"Read-Only Memory"* ou memória de somente leitura. A programação do
jogo vem num único CI na maioria dos consoles e portáteis, mas nem
sempre. Já nos sistemas arcade, a situação é mais complexa devido ao seu
design: o sistema precisa ler todos os dados do jogo encontrados em
diferentes CIs espalhados por toda a placa. Alguns dos CIs usados para
armazenar os dados não são regraváveis, como
um CI do tipo **PROM**, por exemplo. Uma vez gravados, os dados ficam
armazenados de maneira permanente, a menos que o CI não seja danificado
ou envelheça até que se desgastar por completo.

Abaixo, vemos um exemplo de um conjunto de CIs do tipo **EPROM** que
pode ser apagado por meio de luz ultravioleta. As etiquetas são
colocadas sobre esses CIs, que contêm uma abertura para realizar tal
apagamento, como proteção contra o apagamento acidental ou involuntária
dos dados. Dada a limitação tecnológica e de espaço da época, os dados
eram divididos em diferentes EPROMs.

.. figure:: images/eprom.svg
	:width: 90%
	:align: center
	:figclass: align-center
	:alt: EPROMs

.. raw:: html

	<p></p>

.. raw:: latex

	\clearpage

Em seguida, os dados contidos nessas EPROMs são lidos e armazenados
em forma de imagem binária por meio de um leitor apropriado. Esse
processo de extrair a imagem destes circuitos integrados é chamado de
*"dump"* ou *"ROM dump"*. As imagens extraídas são geralmente
organizadas e armazenadas em arquivos com o nome **xxyyzz.01**,
**xxyyzz.02**, **xxyyzz.03**, **xxyyzz.04**, **xxyyzz.05** e
**xxyyzz.06** respectivamente. Após concluir todo o processo e todo o
trabalho de aferição para saber se as imagens foram extraídas
corretamente, os desenvolvedores registram o nome de cada imagem e seus
respectivos valores de CRC [#CRC]_ e SHA1 [#SHA1]_ dentro do
código-fonte do respectivo driver para que o MAME saiba como
carregá-las.


.. _aboutromsets_rom_version:

As ROMs e as suas "versões"
---------------------------

É imprescindível entender que há uma grande confusão em relação ao MAME
e às "*versões*" das ROMs utilizadas por ele. Portanto, é importante
entender como o MAME aceita uma ROM como válida. Usando a ROM **pacman**
como exemplo, o banco de dados interno do MAME nos mostra o seguinte:

.. code-block:: shell

	mame -lr pacman 
	ROMs required for driver "pacman".
	Name                                   Size Checksum
	pacman.6e                              4096 CRC(c1e6ab10) SHA1(e87e059c5be45753f7e9f33dff851f16d6751181)
	pacman.6f                              4096 CRC(1a6fb2d4) SHA1(674d3a7f00d8be5e38b1fdc208ebef5a92d38329)
	pacman.6h                              4096 CRC(bcdd1beb) SHA1(8e47e8c2c4d6117d174cdac150392042d3e0a881)
	pacman.6j                              4096 CRC(817d94e3) SHA1(d4a70d56bb01d27d094d73db8667ffb00ca69cb9)
	pacman.5e                              4096 CRC(0c944964) SHA1(06ef227747a440831c9a3a613b76693d52a2f0a9)
	pacman.5f                              4096 CRC(958fedf9) SHA1(4a937ac02216ea8c96477d4a15522070507fb599)
	82s123.7f                                32 CRC(2fc650bd) SHA1(8d0268dee78e47c712202b0ec4f1f51109b1f2a5)
	82s126.4a                               256 CRC(3eb3a8e4) SHA1(19097b5f60d1030f8b82d9f1d3a241f93e5c75d6)
	82s126.1m                               256 CRC(a9cc86bf) SHA1(bbcec0570aeceb582ff8238a4bc8546a23430081)
	82s126.3m                               256 CRC(77245b66) SHA1(0c4d0bee858b97632411c440bea6948a74759746)

Ao dizer ROM **pacman**, estamos nos referindo ao arquivo compactado
chamado **pacman.zip**. Para que essa ROM funcione corretamente, todos
os arquivos ROM devem corresponder à lista acima em todas as
características específicas, como o nome de cada arquivo, o tamanho e o
*checksum* (CRC e SHA1) de cada um.

Essa é a única informação que o MAME considera, não existindo na lista
acima qualquer informação sobre uma  "*versão da ROM*", "*versão do
MAME*" e nem o MAME armazena tal informação em lugar algum. Essa questão
já foi abordada com mais detalhes em :ref:`outro capítulo <Old-Sets>`.

Além disso, há duas questões adicionais: uma parte vem de **front-ends**
e outros aplicativos que utilizam diferentes versões do MAME. A outra
questão está relacionada a pessoas que compilam uma versão completa das
ROMs conforme novas versões do MAME são lançadas, visando "facilitar" a
vida daqueles que colecionam tais arquivos.

É importante ressaltar que, infelizmente, um mito se espalhou pela
internet sugerindo que a ROM do pacman, por exemplo, só funcionaria se a
versão da ROM correspondesse à versão do MAME. Como demonstrado acima,
isso não corresponde à realidade. No site `Arcade Database`_, por
exemplo, é possível verificar que não houve alterações no jogo
**pacman** entre as versões **0.196** e **0.270** do MAME. Portanto,
desde que os arquivos correspondam à lista acima, o jogo **pacman**
funcionará normalmente nas versões mais recentes do MAME.

Portanto, para o usuário iniciante, não é preciso atualizar todas as
suas ROMs a cada nova versão do MAME. Provavelmente, as ROMs que você
mais usa e já tem continuarão a funcionar sem problemas. Caso os
desenvolvedores do MAME atualizem o driver ou o arquivo da ROM, ou
apareça um novo *ROM dump* (na possibilidade de haver algum problema na
versão anterior), basta atualizar **apenas o arquivo ROM que foi
atualizado** e **não todo o conjunto**, como muitos fazem. Além disso,
vale observar que a mesma informação é aplicável àqueles que fazem
coleção desses arquivos. Não é preciso baixar todo um *ROMSET* (conjunto
de arquivos ROMs) para uma determinada versão do MAME, basta adicionar
as novas ROMs e manter as outras já existentes (conforme o caso). Essa
operação pode ser gerenciada de forma prática e eficiente por meio de
:ref:`gerenciadores de ROMs <advanced-tricks-dat-sistema>`.


.. _aboutromsets_division:

A organização do conjunto das ROMs
----------------------------------

Ao longo do desenvolvimento dos jogos de arcade, por exemplo, alguns
deles passam por revisões, nas quais o código pode ser corrigido ou
atualizado. Em geral, a placa original do arcade era mantida e a
programação de um dos CIs relacionados à atualização da programação do
jogo era trocada. Além disso, é importante ressaltar que, em certos
casos, um mesmo arcade pode ser comercializado em diferentes partes do
mundo. Nesses casos, a programação principal é mantida, mas algumas
partes da programação são substituídas, como o licenciamento, o nome da
empresa licenciada, o idioma, o título, os personagens etc.

Visando otimizar o espaço, a estrutura interna do MAME foi organizada
utilizando um sistema hierárquico familiar de "*parent*" e "*clone*", ou
seja, **principal** e **clone** em tradução livre.

A última revisão corrigida de um determinado sistema será definida como
a ROM principal desta família (sendo definida como *World*), mas nem
sempre. Por exemplo, serão definidos como **clones** todos os conjuntos
de ROMs que, em geral, usarem exatamente os mesmos CIs. No entanto, caso
haja dados diferentes do conjunto principal em alguns deles, como a
versão japonesa do **Puckman** e a versão USA/World do **Pac Man**, isso
deve ser levado em consideração.


Ao rodar um jogo clone ou um dos seus conjuntos subsequentes sem antes
ter o jogo principal disponível, o usuário será informado do problema.
Usando o exemplo anterior, ao tentar jogar a versão americana do
**Pac Man** (**pacman**) sem antes ter a ROM principal **puckman**,
aparecerá uma mensagem de erro informando quais são os arquivos em
falta.

Para realizar esse teste, podemos usar a opção
:ref:`-verifyroms <mame-commandline-verifyroms>`, supondo que tenhamos
ambas as ROMs **puckman.zip** e **pacman.zip** na nossa pasta
**roms**. Para verificar se a ROM **puckman** está em conformidade,
podemos realizar o seguinte teste via prompt de comando ou terminal:

.. code-block:: shell

	mame -verifyroms puckman
	romset puckman is good
	1 romsets found, 1 were OK.

O mesmo teste pode ser feito com a ROM **pacman**:

.. code-block:: shell

	mame -verifyroms pacman
	romset pacman [puckman] is good
	1 romsets found, 1 were OK.

È importante notar que, como a ROM **pacman** é um clone de **puckman**,
o MAME destaca essa informação dentro de colchetes **[]**, no caso
**[puckman]**. Isso indica que temos ambas as ROMs.

Supondo que não tenhamos a ROM **puckman**, o que aconteceria? Nesse
caso, ao realizar o mesmo teste com a rom **pacman**, o MAME apresentará
o seguinte erro:

.. code-block:: shell

	mame -verifyroms pacman
	pacman      : 82s123.7f (32 bytes) - NOT FOUND (puckman)
	pacman      : 82s126.4a (256 bytes) - NOT FOUND (puckman)
	pacman      : 82s126.1m (256 bytes) - NOT FOUND (puckman)
	pacman      : 82s126.3m (256 bytes) - NOT FOUND (puckman)
	romset pacman [puckman] is bad
	1 romsets found, 0 were OK.

Aqui o MAME identifica quais são os arquivos que estão faltando
(**82s123.7f**, **82s126.4a**, **82s126.1m**, **82s126.3m**), o
respectivo tamanho de cada um dos arquivos e o mais importante, o MAME
informa qual o nome da ROM que está faltando (**puckman**). Como
**puckman** está entre colchetes, podemos concluir que **puckman** está
faltando e que ele é necessário para que a ROM **pacman** funcione.

Podemos usar a opção :ref:`-listclones / -lc <mame-commandline-listclones>`
para identificar a ROM principal e o clone, por exemplo:

.. code-block:: shell

	mame -lc pacman
	Name:            Clone of:
	pacman           puckman

O MAME também é capaz de identificar a falta de ROMs necessárias para o
funcionamento de um sistema, independentemente da questão das ROMs
principais e clones. Tomemos como exemplo o jogo *The King of
Fighters '94* (**kof94**): para que ele funcione, é preciso ter o
arquivo com as BIOS do sistema, por exemplo:

.. code-block:: shell

	mame -verifyroms kof94
	kof94       : sfix.sfix (131072 bytes) - NOT FOUND (neogeo)
	kof94       : 000-lo.lo (131072 bytes) - NOT FOUND (neogeo)
	kof94       : sp-s2.sp1 (131072 bytes) - NOT FOUND (neogeo)
	kof94       : sp-s.sp1 (131072 bytes) - NOT FOUND (neogeo)
	...
	romset kof94 [neogeo] is bad
	1 romsets found, 0 were OK.

Nesse caso, o MAME informa que a ROM **neogeo** (ou **neogeo.zip** na
pasta **roms**) não existe, não foi encontrada na pasta **roms** ou que
o caminho para onde ela exista não foi definido no
:ref:`rompath <mame-commandline-rompath>`. Para resolver o problema,
basta baixar o arquivo **neogeo.zip**, colocá-lo na pasta **roms** e
repetir o teste:

.. code-block:: shell

	mame -verifyroms kof94
	romset kof94 [neogeo] is good
	1 romsets found, 1 were OK.

Considerando a versatilidade do MAME em identificar o que é necessário
para que a ROM correta seja lida adequadamente e a emulação funcione
corretamente, os conjuntos de ROMs são separados em três categorias:

* **non-merged** (não mesclado)
* **split** (dividido)
* **merged** (mesclado)

.. raw:: latex

	\clearpage

A organização em questão é bastante simples e intuitiva, como
demonstrado na imagen [#IMAGENS]_ abaixo:

.. figure:: images/nao_mesclado.svg
	:width: 20%
	:align: center
	:figclass: align-center
	:alt: não mesclado

.. raw:: html

	<p></p>

Nesta categoria (não mesclado), infelizmente, há perda de muito espaço,
pois há duplicidade de arquivos. No nosso exemplo acima, por exemplo, há
a duplicidade das ROMs **XXYYZZ** de 1 a 4. A única diferença reside na
ROM 5, presente na ROM **principal**, e na ROM 6, localizada na ROM
**clone**. Como mencionado anteriormente, a diferença entre elas pode
estar relacionada a um idioma diferente ou a um licenciamento específico
para um país diferente do original, como do Japão para os EUA ou do
Japão para o Reino Unido, entre outros. Porém, é importante ressaltar
que, devido à ineficiência de armazenamento, esse é um modo não
recomendado para armazenar ROMs.

.. figure:: images/dividido.svg
	:width: 20%
	:align: center
	:figclass: align-center
	:alt: dividido

.. raw:: html

	<p></p>

Neste caso, todos os arquivos de ROMs principais estão contidos em um
único arquivo ZIP, e apenas o arquivo da ROM diferente é separado como
**clone** em relação à ROM **principal**. A vantagem desse modo é a
economia de espaço, já que não há duplicidade de ROMs. No entanto, é
importante ressaltar que algumas pessoas podem preferir o modo
mesclado. A desvantagem desse modo é a dependência externa de arquivos
BIOS (como **neogeo.zip** nos sistemas Neo Geo, por exemplo) e
dispositivos (como **namco51.zip**, por exemplo). Caso esses arquivos
sejam excluídos acidentalmente, o sistema pode deixar de funcionar.

.. figure:: images/mesclado.svg
	:width: 15%
	:align: center
	:figclass: align-center
	:alt: dividido

.. raw:: html

	<p></p>

Nesse caso, todas as ROMs necessárias do sistema (incluindo os clones)
estão em um único arquivo. A vantagem desse modo é que é possível
economizar ainda mais espaço que no modo dividido, pois todos os
arquivos clones que eventualmente se repetem em sistemas diferentes
agora ficam em um arquivo só, assim como as ROMs do tipo BIOS e
dispositivos.

Esses são os princípios básicos desses conjuntos de ROMs. Porém,
existem dois outros tipos de conjunto que serão usados no MAME de tempos
em tempos.


.. raw:: latex

	\clearpage

O primeiro, é o **conjunto de BIOS** (*BIOS set*). Alguns sistemas
arcade compartilhavam uma plataforma de hardware, como o hardware de
arcade Neo Geo. Isso porque havia todos os dados necessários para
iniciar e realizar o autoteste do hardware antes de inicializar um dos
cartuchos de jogos na placa principal. Porém, é importante ressaltar que
não é apropriado colocar os dados do jogo para iniciar junto com a BIOS.
Em vez disso, eles são armazenados separadamente como uma imagem BIOS
para o próprio sistema (**neogeo.zip**, no caso dos jogos Neo Geo, por
exemplo).

O segundo é o **conjunto de dispositivos** (*device set*). Visando
economizar tempo e dinheiro, os fabricantes de arcade frequentemente
reutilizavam várias partes de seus projetos mais de uma vez. Alguns
desses circuitos menores poderiam ser utilizados nas placas mais novas,
desde que tivessem um mínimo em comum com o circuito das placas lançadas
anteriormente. Portanto, não seria possível organizar os dados do
circuito ou da própria ROM usando o contexto de principal e clone. Por
esse motivo, algumas ROMs são categorizadas como "*Device*"
(dispositivo), onde os dados são armazenados como um conjunto de
dispositivos ou "*Device set*".

Um exemplo disso é o circuito integrado customizado de entrada e saída
(I/O) *Namco 51xx*, utilizado pela Namco para lidar com os comandos do
joystick e as chaves DIP no jogo Galaga. Esse circuito também é
utilizado por outros jogos. Assim, para que o jogo **Galaga** funcione
no MAME, é preciso ter as ROMs de dispositivos armazenadas nos arquivos
**namco51.zip** e **namco54.zip**.


.. _aboutromsets_problems:

Solucionando problemas dos seus conjuntos de ROMs e um pouco de história
------------------------------------------------------------------------

É possível que a frustração de muitos usuários do MAME esteja
relacionada com alterações julgadas como desnecessárias nos arquivos
ROM. No entanto, tais alterações são necessárias devido às mudanças
sofridas pelos arquivos ROM ao longo do tempo. É possível que o objetivo
seja tornar a experiência dos usuários mais desafiadora, mas isso não
parece ser a intenção.

A compreensão dessas mudanças e de seus motivos pode contribuir para
evitar possíveis mal-entendidos sobre as
:ref:`versões das ROMs <aboutromsets_rom_version>`.

Muitas ROMs e seus respectivos conjuntos já existiam antes da emulação.
Esses conjuntos iniciais foram criados pelos proprietários das casas de arcade
e utilizados como recurso de manutenção para as placas quebradas que já
não funcionavam mais, assim como para a substituição de componentes,
peças e CI danificados. Infelizmente, alguns desses conjuntos não
continham todos os dados essenciais (o programa em si) para que
pudessem funcionar. Muitas das imagens extraídas no início apresentavam
falhas e erros, seja por um procedimento incorreto no momento da
extração ou pela falta de tecnologia para fazê-lo de maneira eficiente,
como a falta de informação responsável pela paleta de cores da tela,
por exemplo.

Os primeiros emuladores buscavam simular artificialmente esses dados de
cores que faltavam da maneira mais próxima possível, porém, por mais que
se tentasse, nunca se chegava próximo do original, pois havia erros.
Felizmente, os dados faltantes foram descobertos em outros circuitos
integrados. Dessa forma, é essencial que se extraiam esses dados e se
atualizem os conjuntos antigos sempre que necessário.

Em seguida, percebeu-se que muitos dos conjuntos existentes continham
dados inadequados para um ou mais circuitos integrados. À medida que a
emulação daquele sistema específico melhorava, os dados ruins se
tornavam mais evidentes, como uma imagem extraída com partes faltantes,
no formato errado ou corrompida, entre outros. Em alguns casos, os
desenvolvedores precisavam criar uma maneira de contornar o
funcionamento original de certos circuitos para que a emulação pudesse
funcionar, pois não tinham acesso à imagem do CI específico ou não era
possível extrair seu conteúdo. Quando a imagem do CI era extraída e
usada no emulador, a emulação do sistema deixava de funcionar.

Por esse e outros motivos, uma vez compreendido como o circuito
funcionava, o driver e as ROMs daquele sistema específico precisavam ser
atualizados. À medida que mais ROMs surgiam, mais conjuntos precisavam
de revisões completas.

Em algumas ocasiões, foi descoberto que a documentação de alguns jogos
continha informações incorretas ou estava em ordem equivocada. Alguns
jogos considerados originais eram, na verdade, cópias piratas de
fabricantes desconhecidos. Em outros casos, jogos tidos como "*piratas*"
eram, na verdade, a versão original do jogo. Em alguns casos, os dados
estavam desorganizados, dificultando a identificação da região de
determinadas placas (como jogos "*World*" misturados com "*Japan*",
por exemplo). Isso exigiu ajustes internos e a correção dos seus
respectivos nomes.

Até hoje, surgem ocasionalmente novos achados que desafiam nossa
compreensão desses jogos. Considerando que uma documentação precisa é
fundamental para registrar a história dos arcades, o MAME mudará o nome
dos conjuntos sempre que necessário, visando à precisão e mantendo as
coisas da maneira mais correta possível, sempre no limite do
conhecimento da equipe a cada novo lançamento do MAME.

Isso pode resultar em uma compatibilidade que não é tão uniforme para os
conjuntos de ROMs que não funcionam nas versões mais antigas do MAME.
Alguns jogos podem não ter mudado muito entre 20 ou 30 novas versões do
MAME, enquanto outros podem ter sido drasticamente alterados entre as
novas versões já lançadas.

Caso encontre problemas com um determinado conjunto de ROMs que não
funcionam mais, há várias coisas a serem verificadas:

*	Você está tentando rodar um conjunto de ROMs destinado à uma versão
	mais antiga do MAME?
*	Você têm o conjunto de BIOS necessários ou a ROM dos dispositivos?
*	Seria este um clone que precisaria ter também a ROM principal?

O MAME
:ref:`sempre informará quais os arquivos estão faltando <aboutromsets_rom>`,
dentro de quais conjuntos e onde eles foram procurados.


.. _aboutromsets_rom_chd:

ROMs e CHDs
-----------

Os dados do CI que contêm a imagem da ROM tendem a ser relativamente
pequenos e são carregados sem problemas na memória do sistema. Além
disso, alguns jogos também utilizavam mídias adicionais de
armazenamento, como discos rígidos, CD-ROMs, DVDs e fitas de vídeo.
Porém, devido a limitações técnicas, esses meios de armazenamento não
são ideais para o armazenamento de dados de ROM. Em alguns casos, eles
não se encaixam por completo na memória.

Diante desse cenário, foi desenvolvido um novo formato para esses
dispositivos: o CHD. Em uma tradução literal, o termo seria
"Pedaços Comprimidos de Dados", ou CHD, para simplificar. Esses formatos
são projetados especificamente para atender às necessidades de
armazenamento dessa mídia. Para executar alguns jogos de arcade, de
consoles e de PCs, é necessário um arquivo CHD.

Uma vez que os CHDs já estão comprimidos, recomenda-se **não
comprimi-los novamente**, independentemente do formato.

Com o objetivo de economizar espaço na existência de diversas variantes
de um sistema ou programa, o MAME oferece suporte a arquivos
"*delta CHD*". Esses arquivos armazenam apenas as partes de dados
diferentes do arquivo CHD **principal**, o que possibilita uma economia
de espaço considerável quando houver um grande compartilhamento de dados
entre eles. Observe que os arquivos "*delta CHD*" só podem ser usados
nos clones dos sistemas principais e nos dispositivos com uma ROM
principal e seus clones. Para utilizar um delta CHD, é necessário que
exista um CHD principal, para que o MAME consiga ler os dados
compartilhados, seja para um sistema, para dispositivos ROM ou para
programas.


.. _Arcade Database: http://adb.arcadeitalia.net/dettaglio_mame.php?game_name=pacman&lang=en
.. [#CI]	Estes circuitos integrados também são conhecidos pela abreviação
		"CI" (se fala CÊ-Í), assim como é chamado de "chip" em Inglês.
.. [#CRC]	Significa *Cyclic Redundancy Check* ou verificação
		cíclica de redundância, serve para aferir a integridade dos
		dados dos arquivos.
.. [#SHA1]	Significa *Secure Hash Algorithm* ou algoritmo de dispersão
		seguro, é uma função criptográfica que retorna um resultado com
		valor hexadecimal (hash) usado também para aferir a
		autenticidade dos dados dos arquivos.
.. [#IMAGENS]	Foi usado a imagem
		`deste link <https://forums.launchbox-app.com/topic/33619-mame-tutorial-for-n00bs/>`_
		como referência.
