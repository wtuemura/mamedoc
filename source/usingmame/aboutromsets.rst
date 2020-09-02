.. A nice and clean way to do a page break, this case for latex and PDF
   only.
.. raw:: latex

	\clearpage

Sobre as ROMs e os seus conjuntos
=================================

O manuseio e atualização de ROMs e seus conjuntos usados no MAME é
provavelmente a maior área de confusão e frustração que os usuários
do MAME enfrentam.
Esta seção tem como objetivo esclarecer muitas das perguntas mais
comuns e abordar detalhes simples que você precisa saber para usar
o MAME de forma mais eficaz.

Vamos começar explicando o que é ROM.

O que é uma imagem ROM?
-----------------------

É uma imagem dos dados que estão dentro de um determinado circuito
integrado [1]_ na placa-mãe do arcade (ou outro dispositivo eletrônico)
em formato binário.

Para a maioria dos consoles e portáteis, os CIs individuais são
frequentemente (mas nem sempre) mesclados em um único arquivo.
Já as máquinas arcade a coisa é um pouco mais complicada devido ao seu
design, você normalmente precisará de dados encontrados em diferentes
circuitos espalhados pela placa.
Ao agrupar todos os arquivos do Puckman juntos, você obterá um conjunto
de ROMs [2]_ do jogo Puckman.

Um exemplo de uma imagem ROM seria o arquivo **pm1_prg1.6e** que estaria
armazenada em um conjunto de ROM **Puckman**.


Por que ROM e não algum outro nome?
-----------------------------------

ROM é um acrônimo de "Read-Only Memory" que significa uma memória que
serve somente para leitura. Alguns dos CIs usados para armazenar dados
não são regraváveis como por exemplo uma PROM, uma vez gravados os dados
se tornam permanentes (contanto que o CI não seja danificado ou
envelheça até a pifar de vez!).
Há outros modelos de CIs como as EPROM que podem ser reprogramados.

Rom dump ou dump é o processo de se extrair o conteúdo existente de
dentro um circuito integrado onde esteja armazenado o programa do que
quer que seja, logo, o nome deste conteúdo tornou-se conhecido como uma
"imagem ROM" ou apenas "ROM" para simplificar.


Pais, Clones, Divisão e Mesclagem
---------------------------------

Enquanto os desenvolvedores do MAME recebiam a sua terceira ou quarta
revisão do Pac Man, com correções de bugs e outras alterações no código
original, eles rapidamente descobriram que quase todas as placas
e integrados quem continham os dados das ROMs eram idênticas as versões
anteriormente copiadas. Para economizar espaço, o MAME foi ajustado para
usar um conjunto de sistema hierárquico de família, onde o **pai** seria
a ROM principal e seus derivados viriam logo abaixo sendo chamado de
**filho**.

A última revisão corrigida de um determinado conjunto (World) será
definido como pai dessa família, mas nem sempre.
Todos os conjuntos que em geral usarem os mesmos CIs (por exemplo,
a versão japonesa do Puckman e a versão USA/World do Pac Man) serão
definidos como clones, pois conterá apenas os arquivos que forem
diferentes se comparadas ao conjunto pai.

Caso o usuário tente rodar um jogo clone ou seus conjuntos subsequentes,
sem antes ter o jogo pai disponível, o usuário será informado do
problema. Usando o exemplo anterior, ao tentar jogar a versão Americana
do Pac Man sem antes ter o conjunto pai **PUCKMAN.ZIP**, aparecerá uma
mensagem de erro informando quais os arquivos estão faltando.

Agora vamos adicionar as últimas peças desse quebra-cabeças:
**não-mesclados** (*non-merged*), **dividido** (*split*), e conjuntos
**mesclados** (*merged*).

O MAME é extremamente versátil sobre onde dados da ROM estão localizados
e é muito inteligente para identificar o que ele precisa. Isso nos
permite fazer algumas mágicas relacionada com a maneira com o qual nós
armazenamos estes conjuntos de ROMs, visando a economia de espaço.

Um **conjunto não-mesclado** (*non-merged set*) é aquele que contém tudo
o que for necessário para que um determinado jogo rode armazenado dentro
de um único arquivo ZIP. Normalmente isso é ineficiente, muito espaço é
perdido, mas é o melhor caminho a seguir se você tem poucos jogos e
deseja que tudo seja simples e fácil de trabalhar.
Para a maioria dos usuários, este é um modo na qual nós não
recomendamos.

Um **conjunto dividido** (*split set*) é aquele em que o conjunto pai
contém todos os arquivos de dados que ele precisa, e os conjuntos clones
contêm *apenas* o que foi alterado em comparação com o conjunto pai.
Isso economiza espaço, mas não é tão eficiente quanto um conjunto
mesclado.

Um **conjunto mesclado** (*merged set*) de ROMs, contêm os arquivos do
conjunto pai e um ou mais conjuntos de clones armazenados dentro de um
mesmo arquivo. Caso o conjunto do Puckman, Midway Pac-Man (USA) seja
combinado juntamente com várias versões piratas (bootleg) em um único
arquivo chamado **PUCKMAN.ZIP** por exemplo, o resultado final é o
chamado *merged set*. Um conjunto mesclado completo com o pai e todos
os clones usam menos espaço do que um conjunto dividido (*split set*).

Estes são princípios básicos de conjuntos, porém existem dois outros
tipos de conjunto que serão usados no MAME de tempos em tempos.

Primeiro, é o **conjunto de BIOS** (*BIOS set*).
Algumas máquinas arcade compartilhavam uma plataforma de hardware em
comum, como o hardware de arcade Neo-Geo. Como a placa principal tinham
todos os dados necessários para iniciar e realizar seu auto-teste do
hardware antes de seguir para o cartucho de jogos. Aliás, não é
apropriado colocar os dados do jogo para iniciar junto com a BIOS.
Em vez disso, ele é armazenado separadamente como uma imagem BIOS para o
próprio sistema (por exemplo, **NEOGEO.ZIP** para jogos Neo-Geo)

Segundo, o **conjunto de dispositivos** (*device set*).
Frequentemente, os fabricantes de arcade reutilizavam várias partes de
seus projetos várias vezes a fim de economizar tempo e dinheiro. Alguns
desses circuitos menores reapareceriam em novas placas desde que
tivessem um mínimo em comum com as placas anteriores lançadas e que
usavam o mesmo circuito, então você não poderia simplesmente tê-los
compartilhando os dados do circuito/ROM por meio de uma relação normal
de pai/clone. Em vez disso, esses desenhos reutilizados e os dados da
ROM são categorizados como um dispositivo *Device*, com os dados
armazenados como um conjunto de dispositivos *Device set*. Por exemplo,
a Namco utilizou um circuito integrado customizado de entrada e saída
(I/O) *Namco 51xx* para para lidar com os comandos do joystick e as
chaves DIP para o jogo Galaga, assim como para outros jogos, você também
precisará do conjunto de dispositivos armazenado no arquivo
**NAMCO51.ZIP** e assim também para outros jogos que precisem dele.


Solucionando problemas dos seus conjuntos de ROMs e um pouco de história
------------------------------------------------------------------------

A frustração de muitos usuários do MAME podem estar relacionadas com
mudanças e modificações, julgadas como desnecessárias por muitos, que os
arquivos ROM sofrem ao longo do tempo e que parece que nossa intenção é
fazer da vida de vocês mais difícil. Entender a origem dessas mudanças e
por quê elas são necessárias ajudará você a evitar ser pego de surpresa
quando essas mudanças acontecem e saber o que precisa ser feito para
manter os seus conjuntos atualizados.

Uma grande quantidade de ROMs e seus conjuntos existiam antes da
emulação. Esses conjuntos iniciais foram criados por proprietários das
casas de arcades e usados para reparar as placas quebradas que não
funcionavam mais, e para a substituição de componentes/peças/integrados
danificados. Infelizmente, alguns destes conjuntos não continham todas
as informações necessárias, especialmente as mais críticas. Muitas das
imagens extraídas inicialmente continham falhas, erros, como
por exemplo, a falta de informação responsável pela paleta de cores da
tela.

Os primeiros emuladores simulavam artificialmente
esses dados de cores que faltavam, de maneira mais próxima possível mas
nunca correta, até descobrirem os dados que faltavam em outros circuitos
integrados. Isso resultou na necessidade de voltar, extrair os dados
ausentes e atualizar os conjuntos antigos com novos arquivos conforme
fosse necessário.

Não demoraria muito para descobrir que muitos dos conjuntos existentes
tinham dados ruins para um ou mais circuitos integrados. Os dados desses
também precisariam ser extraídos novamente, talvez de uma máquina
diferente, e muitos outros conjuntos precisariam de revisões completas.

Ocasionalmente, alguns jogos seriam descobertos com sua documentação
feita de forma totalmente incorreta. Alguns jogos considerados originais
eram na verdade, cópias piratas de fabricantes desconhecidos. Alguns
jogos que foram considerados como "piratas", eram na verdade a versão
original do jogo. Os dados de alguns jogos estavam bagunçados, de forma
que não se sabia de qual região a placa era como por exemplo, jogos
World misturado com Japão) o que exigiu também ajustes internos e a
correção dos nomes.

Mesmo agora, acontecem achados milagrosos e ocasionais que mudam a nossa
compreensão desses jogos. Como é fundamental que uma documentação seja
precisa para registrar a história dos arcades, o MAME mudará o nome dos
conjuntos sempre que for necessário, visando a precisão e mantendo as
coisas da maneira mais correta possível sempre no limite do conhecimento
que a equipe tem a cada novo lançamento do MAME.

Isso resulta em uma compatibilidade muito irregular para os conjuntos de
ROMs que deixam de funcionar nas versões mais antigas do MAME.
Alguns jogos podem não ter mudado muito entre 20 ou 30 novas versões
do MAME, assim como outros podem ter mudado drasticamente entre as novas
versões lançadas.

Se você encontrar problemas com um determinado conjunto que não funciona
mais, há várias coisas a serem verificadas:

*	Você está tentando rodar um conjunto de ROMs destinado à uma versão
	mais antiga do MAME?
*	Você tem o conjunto de BIOS necessários ou a ROM dos dispositivos?
*	Seria este um clone que precisaria ter o pai também?

O MAME sempre informará quais os arquivos estão faltando, dentro de
quais conjuntos e onde eles foram procurados.


ROMs e CHDs
-----------

Os dados do CI que contém a ROM tendem a ser relativamente pequenos
e são carregados sem maiores problemas na memória do sistema.
Alguns jogos também usavam mídias adicionais de armazenamento, como
discos rígidos, CD-ROMs, DVDs e Laserdiscs. Esses meios de armazenamento
são, por questões técnicas diversas, inadequados para serem armazenados
da mesma forma que os dados da ROM e em alguns casos não caberão por
inteiro na memória.

Assim, um novo formato foi criado para eles, sendo armazenados num
arquivo CHD. **Compressed Hunks of Data** ou numa tradução literal seria
**Pedações de Dados Comprimidos** ou CHD para simplificar.
São projetados especificamente em torno das necessidades da mídia de
armazenamento em massa. Alguns jogos de arcade, consoles e PCs
precisarão de um arquivo CHD para rodar.

Como os CHDs já estão comprimidos, eles **NÃO** devem ser armazenados
dentro de um arquivo ZIP ou 7Z como você faria com os conjuntos de ROM.


.. [1]	Estes circuitos integrados também são conhecidos pela abreviação
		"CI" (se fala CÊ-Í), assim como é chamado de "chip" em Inglês.
		(Nota do tradutor)
.. [2]	Esse conjunto é chamado de *ROM set* em Inglês.
		(Nota do tradutor)
