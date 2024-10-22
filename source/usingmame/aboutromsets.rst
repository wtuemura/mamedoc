.. raw:: latex

	\clearpage


.. _aboutromsets:

Sobre as ROMs e os seus conjuntos
=================================

O manuseio e a atualização das ROMs e de seus respectivos conjuntos
provavelmente causam a maior confusão e geram problemas entre os
usuários do MAME, especialmente os inicianes.

Esta seção tem como objetivo esclarecer diversos tópicos sobre o
assunto, tirar dúvidas comuns e abordar detalhes importantes para usar o
MAME de forma mais eficaz.


.. _aboutromsets_rom:

O que é uma imagem ROM?
-----------------------

A programação do jogo em si é armazenada em circuitos integrados [#CI]_
na placa-mãe do arcade ou em outro tipo de dispositivo (CD-ROM, DVD-ROM,
HDD, etc.). Nós os chamamos de ROMs, pois é um acrônimo de
*"Read-Only Memory"*, que significa memória de somente leitura.

Na maioria dos consoles e portáteis, a programação do jogo geralmente
vem num único CI (mas nem sempre). Já nos sistemas arcade, a coisa é um
pouco mais complicada devido ao seu design: o sistema em questão
normalmente precisa ler todos os dados do jogo encontrados em
diferentes CIs espalhados por toda a placa.

Alguns dos CIs usados para armazenar os dados não são regraváveis, como
um CI do tipo **PROM**, por exemplo. Uma vez gravados, os dados ficam
armazenados permanentemente (desde que o CI não seja danificado ou
envelheça até que se desgastar por completo!).

Abaixo, vemos um exemplo de um conjunto de CI do tipo **EPROM** que
pode ser apagado por meio de luz ultravioleta (as etiquetas são
colocadas sobre esses CIs, que contêm uma abertura
para realizar esse apagamento, como proteção contra a eliminação
acidental ou involuntária dos dados) e gravado novamente. Dada a
limitação tecnológica e de espaço da época, os dados eram divididos em
diferentes EPROMs.

.. figure:: images/eprom.svg
	:width: 90%
	:align: center
	:figclass: align-center
	:alt: EPROMs

.. raw:: html

	<p></p>

.. raw:: latex

	\clearpage

Posteriormente, os dados contidos nessas EPROMs são lidos e armazenados
em forma de imagem binária por meio de um leitor apropriado. Esse
processo de extrair a imagem destes circuitos integrados é chamado de
*"dump"* ou de *"ROM dump"*. As imagens, depois de extraídas, geralmente
podem ser organizadas e armazenadas como ``xxyyzz.01``, ``xxyyzz.02``,
``xxyyzz.03``, ``xxyyzz.04``, ``xxyyzz.05`` e ``xxyyzz.06``,
respectivamente. Após a conclusão de todo o processo e de todo o
trabalho de aferição para saber se as imagens foram extraídas
corretamente, os desenvolvedores registram o nome de cada imagem e seus
respectivos valores de CRC [#CRC]_ e SHA1 [#SHA1]_ dentro do
código-fonte do respectivo driver para que o MAME saiba como
carregá-las.


.. _aboutromsets_rom_version:

As ROMs e as suas "versões"
---------------------------

Há uma grande confusão em relação ao MAME e às *"versões"* das
ROMs utilizadas por ele. No entanto, vejamos o que o MAME leva em
consideração ao aceitar uma ROM como válida. Usando a ROM **pacman**
como exemplo, o banco de dados interno do MAME nos mostra o seguinte::

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

Para que a ROM **pacman** (do arquivo ``pacman.zip``) seja considerada
**válida**, várias características muito específicas devem corresponder
à lista acima como o nome de cada arquivo, o tamanho e o *checksum*
(CRC + SHA1) de cada um deles.

Essa é a única informação que o MAME considera, **não existindo** na
lista acima qualquer informação de *"versão da ROM"*, nem o MAME
armazena tal informação em lugar algum. Essa questão também já foi
abordada com mais detalhes em :ref:`outro capítulo <Old-Sets>`.

Para complicar ainda mais as coisas, temos mais duas questões: uma parte
vem de **front-ends** e outros aplicativos que utilizam diferentes
versões do MAME. A outra questão está relacionada a pessoas que compilam
uma versão completa das ROMs conforme novas versões do MAME são
lançadas, visando "facilitar" a vida daqueles que colecionam tais
arquivos.

Talvez por causa de desinformação, espalhou-se pela internet um mito
de que a ROM do **pacman**, por exemplo, *"só vai funcionar"* se a
versão da ROM corresponder à versão do MAME. Como demonstrado acima,
isso não tem qualquer fundamento. Podemos ver, por exemplo, no site
`Arcade Database`_ que nada foi alterado no jogo **pacman** entre as
versões **0.196** e **0.270** do MAME. Logo, desde que os arquivos
correspondam à lista acima, o jogo **pacman** funcionará normalmente nas
versões mais recentes do MAME.

Portanto, para o usuário mais leigo, não é preciso atualizar todas as
suas ROMs a cada nova versão do MAME; provavelmente,as ROMs que
você mais usa e já tem continuarão a funcionar sem problemas. Caso os
desenvolvedores do MAME atualizem o driver ou o arquivo da ROM, ou
apareça um novo *ROM dump* (na possibilidade de haver algum problema na
versão anterior), basta atualizar **apenas o arquivo ROM que foi
atualizado** e não **todo o conjunto** como muitos fazem. A mesma
informação vale para aqueles que fazem coleção desses arquivos: não é
preciso baixar todo um *ROMSET* (conjunto de ROMs) para uma determinada
versão do MAME, basta adicionar as novas ROMs e manter as outras já
existentes (se for o caso). Isso pode ser facilmente gerenciado por meio
de :ref:`gerenciadores de ROMs <advanced-tricks-dat-sistema>`.


.. _aboutromsets_division:

A organização do conjunto das ROMs
----------------------------------

Ao longo do desenvolvimento dos jogos de arcade, por exemplo, alguns
deles passam por revisões, nas quais o código pode ser corrigido ou
atualizado. Muitas vezes, mantinha-se a placa original do arcade e
trocava-se apenas a programação de um dos CIs relacionados à atualização
da programação do jogo. Há casos também em que um mesmo arcade é vendido
em diferentes partes do mundo. Nesses casos, a programação principal é
mantida, mas algumas partes da programação são substituídas, como o
licenciamento, o nome da empresa licenciada, o idioma, o título, os
personagens etc.

Visando economizar espaço, a estrutura interna do MAME foi organizada
de maneira a utilizar um sistema hierárquico familiar de *"parent"* e
*"clone"*, ou seja, **principal** e **clone** em tradução livre.

A última revisão corrigida de um determinado sistema será definida como
a ROM **principal** desta família (sendo definida como *World*), mas
nem sempre. Por exemplo, serão definidos como **clones** todos os
conjuntos de ROMs que em geral usarem exatamente os mesmos CIs. No
entanto, caso haja dados que forem diferentes do conjunto principal em
alguns deles (como a versão japonesa do **Puckman** e a versão
USA/World do **Pac Man**).

Ao rodar um jogo clone ou um dos seus conjuntos subsequentes sem antes
ter o jogo principal disponível, o usuário será informado do problema.
Usando o exemplo anterior, ao tentar jogar a versão americana do
**Pac Man** (``pacman``) sem antes ter a ROM principal ``puckman``,
aparecerá uma mensagem de erro informando quais são os arquivos em
falta.

Para fazer este teste, podemos usar a opção
:ref:`-verifyroms <mame-commandline-verifyroms>`, supondo que tenhamos
ambas as ROMs ``puckman.zip`` e ``pacman.zip`` na nossa pasta
**roms**. Podemos realizar o seguinte teste para verificar se a ROM
``puckman`` está com tudo em ordem::

	mame -verifyroms puckman
	romset puckman is good
	1 romsets found, 1 were OK.

O mesmo teste pode ser feito com a ROM ``pacman``::

	mame -verifyroms pacman
	romset pacman [puckman] is good
	1 romsets found, 1 were OK.

Note que como a ROM **pacman** é um clone de **puckman**, o MAME
destaca essa informação dentro de colchetes ``[]``, no caso
``[puckman]``, isso indica que temos ambas as ROMs.

Vamos supor que não tenhamos a ROM **puckman**. Neste caso, o MAME
apresentará o seguinte erro ao realizar o mesmo teste com a ROM
**pacman**::

	mame -verifyroms pacman
	pacman      : 82s123.7f (32 bytes) - NOT FOUND (puckman)
	pacman      : 82s126.4a (256 bytes) - NOT FOUND (puckman)
	pacman      : 82s126.1m (256 bytes) - NOT FOUND (puckman)
	pacman      : 82s126.3m (256 bytes) - NOT FOUND (puckman)
	romset pacman [puckman] is bad
	1 romsets found, 0 were OK.

Aqui o MAME identifica quais são os arquivos que estão faltando
(``82s123.7f``, ``82s126.4a``, ``82s126.1m``, ``82s126.3m``), o
respectivo tamanho de cada um dos arquivos e o mais importante, o MAME
informa qual o nome da ROM que está faltando (``puckman``). Como
**puckman** está entre colchetes, sabemos que **puckman** está
faltando e que é necessário para que a ROM **pacman** funcione.

Podemos usar a opção :ref:`-listclones / -lc <mame-commandline-listclones>`
para identificar a ROM principal e o clone, por exemplo::

	mame -lc pacman
	Name:            Clone of:
	pacman           puckman

O MAME também consegue apontar a falta de ROMs necessárias para o
funcionamento de um sistema, independentemente da questão das ROMs
principais e clones. Podemos usar o exemplo do jogo **The King of
Fighters '94** (``kof94``): para que ele funcione, é preciso ter o
arquivo com as BIOS do sistema, por exemplo::

	mame -verifyroms kof94
	kof94       : sfix.sfix (131072 bytes) - NOT FOUND (neogeo)
	kof94       : 000-lo.lo (131072 bytes) - NOT FOUND (neogeo)
	kof94       : sp-s2.sp1 (131072 bytes) - NOT FOUND (neogeo)
	kof94       : sp-s.sp1 (131072 bytes) - NOT FOUND (neogeo)
	...
	romset kof94 [neogeo] is bad
	1 romsets found, 0 were OK.

Neste caso, o MAME informa que a ROM ``neogeo`` (ou ``neogeo.zip`` na
pasta **roms**) não existe, não foi encontrada na pasta **roms** ou que
o caminho para onde ela exista não foi definido no
:ref:`rompath <mame-commandline-rompath>`. Para corrigir o problema,
basta baixar o arquivo ``neogeo.zip``, colocá-lo na pasta **roms** e
repetir o teste::

	mame -verifyroms kof94
	romset kof94 [neogeo] is good
	1 romsets found, 1 were OK.

Dada a versatilidade do MAME em identificar o que é necessário para que
a ROM correta seja lida adequadamente e a emulação funcione
corretamente, os conjuntos de ROMs são separados em três categorias:

* **non-merged** (não mesclado)
* **split** (dividido)
* **merged** (mesclado)

.. raw:: latex

	\clearpage

A sua organização é bem simples de se compreender conforme mostram as
imagens [#IMAGENS]_ abaixo:

.. figure:: images/nao_mesclado.svg
	:width: 20%
	:align: center
	:figclass: align-center
	:alt: não mesclado

.. raw:: html

	<p></p>

Nesta categoria, há perda de muito espaço, pois há duplicidade de
arquivos. No nosso exemplo acima, há a duplicidade das ROMs
``XXYYZZ`` de 1 a 4. A única diferença é a ROM 5 na ROM **principal**
e a ROM 6 na ROM **clone**. Como explicado anteriormente, a diferença
entre elas pode ser um idioma diferente ou um licenciamento
diferente para um país diferente do original, como do Japão para os EUA
ou do Japão para o Reino Unido, etc. Dada a ineficiência de
armazenamento, este é um modo não recomendado para armazenar ROMs.

.. figure:: images/dividido.svg
	:width: 20%
	:align: center
	:figclass: align-center
	:alt: dividido

.. raw:: html

	<p></p>

Aqui, temos todos os arquivos de ROMs principais em um arquivo ZIP, e
apenas o arquivo da ROM diferente é separado como **clone** em relação à
ROM **principal**. A característica desse modo é a economia de espaço,
já que não há duplicidade de ROMs. Porém, há quem prefira o modo
**mesclado**. A desvantagem desse modo é a dependência externa de
arquivos BIOS (como ``neogeo.zip``, por exemplo) e dispositivos (como
``namco51.zip``, por exemplo). Se esses arquivos forem perdidos caso
sejam excluídos por engano, o sistema para de funcionar.

.. figure:: images/mesclado.svg
	:width: 15%
	:align: center
	:figclass: align-center
	:alt: dividido

.. raw:: html

	<p></p>

Neste caso, todas as ROMs necessárias do sistema (incluindo os clones)
estão em um único arquivo. A vantagem desse modo é economizar ainda mais
espaço que no modo dividido, pois todos os arquivos clones que
eventualmente se repetem em sistemas diferentes agora ficam em um
arquivo só, assim como as ROMs do tipo BIOS e dispositivos.

Esses são princípios básicos desses conjuntos de ROMs, porém, existem
dois outros tipos de conjunto que serão usados no MAME de tempos em
tempos.

.. raw:: latex

	\clearpage

O primeiro, é o **conjunto de BIOS** (*BIOS set*). Alguns sistemas de
arcade compartilhavam uma plataforma de hardware em comum, como o
hardware de arcade Neo Geo. Isso porque havia todos os dados necessários
para iniciar e realizar o seu próprio autoteste do hardware antes de
inicializar um dos cartuchos de jogos na placa principal.
Aliás, não é apropriado colocar os dados do jogo para iniciar junto com
a BIOS. Em vez disso, eles são armazenados separadamente como uma imagem
BIOS para o próprio sistema (**neogeo.zip** no caso dos jogos Neo Geo
por exemplo).

O segundo é o **conjunto de dispositivos** (*device set*). Visando
economizar tempo e dinheiro, os fabricantes de arcade frequentemente
reutilizavam várias partes de seus projetos mais de uma vez. Alguns
desses circuitos menores reapareceriam nas placas mais novas, desde que
tivessem um mínimo em comum com o circuito das placas lançadas
anteriormente. Logo, não seria possível organizar os dados do circuito
ou da própria ROM usando o contexto de **principal** e **clone**. Por
esse motivo, algumas ROMs são categorizadas como *"Device"*
(dispositivo), onde os dados são armazenados como um conjunto de
dispositivos ou *"Device set"*.

Por exemplo, a Namco utilizou um circuito integrado customizado de
entrada e saída (I/O) *Namco 51xx* para lidar com os comandos do
joystick e as chaves DIP para o jogo **Galaga**, que também é utilizado
por outros jogos. Assim, para que o jogo **Galaga** funcione no MAME, é
preciso ter as ROMs de dispositivos armazenadas nos arquivos
``namco51.zip`` e ``namco54.zip``.


.. _aboutromsets_problems:

Solucionando problemas dos seus conjuntos de ROMs e um pouco de história
------------------------------------------------------------------------

A frustração de muitos usuários do MAME pode estar relacionada com
alterações julgadas como desnecessárias nos arquivos ROM, porém tais
alterações são necessárias devido às alterações sofridas pelos arquivos
ROM ao longo do tempo. Parece que isso é feito para tornar a vida dos
usuários mais difícil, mas não é o caso.

Compreender o motivo dessas alterações e o porquê de serem necessárias
ajudará a evitar ser iludido por essas contradições sobre as
:ref:`versões das ROMs <aboutromsets_rom_version>`.

Muitas ROMs e seus respectivos conjuntos já existiam antes da emulação.
Esses conjuntos iniciais foram criados pelos proprietários das casas de
arcade e utilizados como recurso de manutenção para as placas quebradas
que já não funcionavam mais, assim como para a substituição de
componentes, peças e CI danificados. Infelizmente, alguns desses
conjuntos já não continham todos os dados essenciais (o programa em si)
para que pudessem funcionar. Muitas das imagens extraídas no início
apresentavam falhas e erros, seja por um procedimento incorreto no
momento da extração ou pela falta de tecnologia para fazê-lo de maneira
eficiente, como a falta de informação responsável pela paleta de cores
da tela, por exemplo.

Os primeiros emuladores tentavam simular artificialmente esses dados de
cores que faltavam da maneira mais próxima possível, porém, por mais que
se tentasse, nunca se chegava próximo do original, pois havia erros. Até
que se descobriram os dados faltantes em outros circuitos integrados.
Por isso, é necessário extrair esses dados e atualizar os conjuntos
antigos conforme necessário.

Logo se descobriu que muitos dos conjuntos já existentes tinham dados
ruins para um ou mais circuitos integrados. À medida que a emulação
daquele sistema específico melhorava, os dados ruins se tornavam mais
evidentes, como uma imagem extraída com partes faltantes, no formato
errado ou corrompida, entre outros. Às vezes, os desenvolvedores
precisavam criar uma maneira de burlar o funcionamento original de
certos circuitos para que a emulação pudesse funcionar, pois não tinham
acesso à imagem do CI específico ou não era possível extrair seu
conteúdo. Quando a imagem do CI era extraída e usada no emulador, a
emulação do sistema deixava de funcionar.

Por esse e outros motivos, uma vez compreendido como o circuito
funcionava, o driver e as ROMs daquele sistema específico precisavam ser
atualizados. E, à medida que mais ROMs apareciam, mais conjuntos
precisavam de revisões completas.

Ocasionalmente, descobria-se que a documentação de alguns jogos estava
incorreta ou fora de ordem. Alguns jogos considerados originais eram,
na verdade, cópias piratas de fabricantes desconhecidos. Outros jogos
tidos como *"piratas"* eram, na verdade, a versão original do jogo. Os
dados de alguns jogos estavam desorganizados, de maneira que não se
sabia exatamente de qual região determinada placa era (como jogos
**World** misturados com **Japan**, por exemplo), o que exigiu ajustes
internos e a correção dos seus respectivos nomes.

Mesmo agora, acontecem achados ocasionais e *"milagrosos"* que alteram a
nossa compreensão desses jogos. Como uma documentação precisa é
fundamental para registrar a história dos arcades, o MAME mudará o nome
dos conjuntos sempre que necessário, visando à precisão e mantendo as
coisas da maneira mais correta possível, sempre no limite do
conhecimento da equipe a cada novo lançamento do MAME.

Isso resulta numa compatibilidade muito irregular para os conjuntos de
ROMs que deixaram de funcionar nas versões mais antigas do MAME. Alguns
jogos podem não ter mudado muito entre 20 ou 30 novas versões do MAME,
enquanto outros podem ter sido drasticamente alterados entre as novas
versões já lançadas.

Caso encontre problemas com um determinado conjunto de ROMs que não
funcionam mais, há várias coisas a serem verificadas:

*	Você está tentando rodar um conjunto de ROMs destinado à uma versão
	mais antiga do MAME?
*	Você têm o conjunto de BIOS necessários ou a ROM dos dispositivos?
*	Seria este um clone que precisaria ter também a ROM principal?

O MAME :ref:`sempre informará quais os arquivos estão faltando <aboutromsets_rom>`,
dentro de quais conjuntos e onde eles foram procurados.


.. _aboutromsets_rom_chd:

ROMs e CHDs
-----------

Os dados do CI que contêm a imagem da ROM tendem a ser relativamente
pequenos e são carregados sem problemas na memória do sistema. Alguns
jogos também utilizavam mídias adicionais de armazenamento, como discos
rígidos, CD-ROMs, DVDs e fitas de vídeo. Esses meios de armazenamento
não são adequados para o armazenamento de dados de ROM por questões
técnicas diversas. Em alguns casos, eles não cabem por inteiro na
memória.

Assim, foi criado um novo formato para eles: o CHD. Em uma tradução
literal, o termo seria *"Pedaços Comprimidos de Dados"*, ou CHD, para
simplificar. Esses formatos são projetados especificamente para atender
às necessidades de armazenamento dessa mídia. Para rodar, alguns jogos
de arcade, de consoles e de PCs necessitarão de um arquivo CHD.

Como os CHDs já estão comprimidos, eles **NÃO DEVEM** ser comprimidos
novamente, independentemente do formato.

Com o objetivo de economizar espaço na existência de diversas variantes
de um sistema ou programa, o MAME oferece suporte a arquivos *"delta
CHD"*. Esses arquivos armazenam apenas as partes de dados diferentes do
arquivo CHD **principal**, o que possibilita uma economia de espaço
considerável quando houver um grande compartilhamento de dados entre
eles. Os arquivos delta CHD só podem ser usados nos clones dos sistemas
principais e nos dispositivos com uma ROM principal e seus clones. Para
usar um delta CHD, é necessário que exista um CHD principal para que o
MAME consiga ler os dados compartilhados, seja para um sistema, para
dispositivos ROM ou para programas.


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
