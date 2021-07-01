.. A nice and clean way to do a page break, this case for latex and PDF
   only.
.. raw:: latex

	\clearpage

Problemas comuns e algumas perguntas frequentes
===============================================

**Aviso: As informações a seguir não possuem qualquer fundamento
jurídico e tão pouco se destinam para tanto.**

1. :ref:`Old-Sets`
2. :ref:`rapid-coins`
3. :ref:`broken-package`
4. :ref:`faster-if-X`
5. :ref:`NeoGeo-broken`
6. :ref:`Sega-SGMDC`
7. :ref:`Missing-ROMs`
8. :ref:`ROM-Verify`
9. :ref:`Parent-Sets`
10. :ref:`Legal-ROMs`
11. :ref:`ROMs-Grey`
12. :ref:`Abandonware`
13. :ref:`eBay-cabs`
14. :ref:`ROM-DVDs`
15. :ref:`DMCA-exemption`
16. :ref:`24-hours`
17. :ref:`commercial-use`
18. :ref:`Ultracade`
19. :ref:`Blackscreen-DirectX`
20. :ref:`ControllerIssues`
21. :ref:`ExternalOPL`
22. :ref:`Autofire`
23. :ref:`gsync-freesync`

.. _Old-Sets:

Por que as minhas ROMs antigas não funcionam mais com as versões mais novas do MAME?
------------------------------------------------------------------------------------

Não há um único motivo porém podemos citar dois, por questões de
melhoramentos da emulação feita pelo MAME.

A emulação em si não é algo simples e trivial, horas e mais horas de
desenvolvimento são necessárias para descobrir como certos sistemas
funcionam, para descobrir como quebrar certas proteções, para descobrir
informações não disponíveis, para lidar com componentes eletrônicos que
foram customizados pelas empresas e não há informações disponíveis ao
público, etc. Logo certos parâmetros para fazer determinada máquina
funcionar mudam. Quando tais parâmetros mudam, certos arquivos das ROMs
deixam de ser necessárias, algumas precisam passar por uma validação e
outras precisam ser extraídas novamente o que acontece na grande maioria
das vezes.

As ROMs antigas foram extraídas de forma precária no passado sem passar
por validações, hoje com mais conhecimento e tecnologia estas mesmas
ROMs agora podem ser extraídas de forma mais confiável, por isso que as
ROMs são atualizadas e as antigas deixam de ser válidas, mesmo que elas
funcionassem nas versões mais antigas do MAME.

Há outros tipos de ROMs onde só é possível a sua extração através de um
processo chamado de `decapagem <https://recoveryic.com.br/decapagem-e-empacotamento-do-mcu/>`_
onde o miolo do circuito integrado é exposto para que só então o seu
conteúdo possa ser extraído à força, por isso que algumas ROMs que
funcionavam antes agora precisam de mais um ou mais arquivos.

Em conjunto com o processo de decapagem, depois que o miolo é exposto há
também casos onde alguns colaboradores e desenvolvedores do MAME
precisam recriar a ROM `manualmente
<https://www.youtube.com/watch?v=7YHkBRR-okY>`_ se utilizando de fotos
de alta resolução e este é um processo lento e muito demorado. Para
conhecer mais sobre este processo consulte a página do
`CAPS0ff <http://caps0ff.blogspot.com>`_ ou do
`Guru <http://members.iinet.net.au/~lantra9jp1_nbn/gurudumps/index.html>`_.


.. _rapid-coins:

Por que o meu jogo mostra uma tela de erro quando eu insiro moedas rapidamente?
-------------------------------------------------------------------------------

Isso não é um bug do MAME.
No hardware de arcade original, não era possível inserir moedas tão
rápido como se faz apertando um botão. A única maneira que você pode
obter crédito nesse ritmo é se o hardware do mecanismo de moedas estiver
com defeito ou se você estivesse fisicamente tentando enganar o
mecanismo de moeda.

Em ambos os casos, o jogo apresentaria um erro para que o responsável
investigasse a situação, evitando que algum espertinho tirasse vantagem
em cima daquele que trabalha duro para conquistar seu dinheiro.
Mantenha um ritmo lento de inserção de moedas e para que este erro não
ocorra.


.. _broken-package:

Por que o meu pacote MAME não oficial (vindo do EmuCR por exemplo ou de qualquer outro lugar) não funciona direito? Por que a minha atualização oficial está quebrada?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

Em muitos casos, as alterações de vários subsistemas tais como plug-ins
Lua, HLSL ou BGFX vem como atualizações para diversos arquivos
diferentes assim como o código fonte principal do MAME.
Infelizmente as versões que vem de terceiros podem vir como apenas um
executável principal do MAME ou com arquivos externos desatualizados,
que podem quebrar a relação entre estes arquivos externos e o código
fonte principal do MAME. Apesar das repetidas tentativas de entrar em
contato com alguns destes terceiros para alertá-los, estes insistem em
distribuir um MAME quebrado e sem as atualizações.

Como não temos qualquer controle sobre como estes terceiros distribuem
essas versões, tudo o que podemos fazer para sites como EmuCR é informar
que não fornecemos suporte para programas que nós não compilamos.
Compile o seu próprio MAME ou use um dos pacotes oficialmente
distribuídos por nós.

Este problema também ocorre caso não tenha atualizado o conteúdo das
pastas HLSL e BGFX com as últimas versões oficiais do MAME.

.. _faster-if-X:

Por que o MAME suporta jogos de console e terminais burros? Não seria mais rápido se o MAME suportasse apenas jogos de arcade? Não usaria menos memória RAM? Não faria com que o MAME ficasse mais rápido por causa de A, B ou C?
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Este é um equívoco comum.
A velocidade da emulação não é regida pelo tamanho final MAME, apenas as
partes mais ativamente usadas são carregadas na memória quando for
necessário.

Para o MAME os dispositivos adicionais são uma coisa boa pois nos
permite realizar testes de estresse em seções dos vários núcleos de CPU
e outras partes da emulação que normalmente não veem uma utilização mais
pesada. Enquanto um computador e uma máquina de arcade podem usar
exatamente o mesmo CPU, a maneira como eles usam este CPU pode diferir
drasticamente.

Nenhuma parte do MAME é descartável, independente de qual seja.
O princípio que o MAME defende que é a preservação e a documentação,
sejam as máquinas de vídeo poker quanto os arcades, não importa.
O MAME é um software de código aberto, muitas coisas já foram abordadas
da melhor maneira possível, há sempre espaço para melhorias, todas elas
são sempre bem vindas caso seja um programador habilidoso


.. _NeoGeo-broken:

Por que a minha ROM de Neo-Geo não funcionam mais? Como eu faço para que o jogo Humble Bundle volte a funcionar?
----------------------------------------------------------------------------------------------------------------

Recentemente a BIOS do Neo-Geo foi atualizada para adicionar uma nova
versão da Universe BIOS. Isso começou entre as versões 0.171 e 0.172 do
MAME que resultou em um erro ao tentar carregar qualquer jogo de
Neo-Geo com um conjunto **neogeo.zip** desatualizado, isso também afeta
o conjunto de pacote do jogo **Humble Bundle**.

Os jogos em si estão corretos e atualizados a partir da versão 0.173 do
MAME (e provavelmente continuará assim) no entanto uma atualização
manual destes arquivos que estão dentro dos pacotes .ZIP terá que ser
feita.
O conjunto de BIOS do Neo-Geo (**neogeo.zip**) incluído no pacote do
jogo **Humble Bundle** estava incompleto até a versão 0.172 do MAME.

Sugerimos que entre em contato com o fornecedor dos seus jogos
(**Humble Bundle** e **DotEmu**) e peça para eles atualizarem o jogo
para a versão mais recente. Se muita gente pedir de forma gentil, pode
ser que eles atualizem para você.


.. _Sega-SGMDC:

Como posso usar a coleção para a Steam do Mega Drive Classics collection do Sega Genesis com o MAME?
----------------------------------------------------------------------------------------------------

A partir da atualização de Abril de 2016, todas as imagens ROM incluídas
no conjunto são agora 100% compatíveis com o MAME e outros emuladores
*Genesis/Mega Drive*. As ROMs estão guardadas na pasta
``steamapps\\Sega Classics\\uncompressed ROMs`` como uma série de
extensões em formatos de imagem do tipo *.68K* e *.SGD*, que podem ser
carregadas diretamente no MAME. Os manuais em PDF para os jogos podem
também serem encontrados na pasta ``steamapps\\Sega Classics\\manuals``.


.. _Missing-ROMs:

Por que o MAME alega que "faltam arquivos" sendo que eu tenho estas ROMs?
-------------------------------------------------------------------------

Pode ser causado por várias razões:

*	Não é incomum as ROMs de um jogo mudarem entre as novas versões do
	MAME. Por que isso aconteceria?

	Muitas vezes é feita uma extração melhor do CI que contém a ROM ou
	então foi feita uma extração mais completa hoje e que não foi
	possível na época, ou até mesmo foi feito uma nova extração para
	corrigir os erros detectados nas ROMs anteriores. As primeiras
	versões do MAME não eram tão chatas sobre esta questão, porém as
	versões mais recentes são.

	Além disso, podem haver mais características de um jogo emulado em uma
	versão posterior que não havia na versão anterior, o que exige a
	execução de mais códigos dentro do MAME para rodar essa nova ROM.

*	Alguns jogos precisam de arquivos CHD.

	Um arquivo CHD é uma representação comprimida de uma imagem de um
	jogo em disco rígido, CD-ROM ou laserdisc, geralmente não é incluído
	como parte das ROMs de um jogo.

	No entanto, assim como na maioria dos casos, esses arquivos são
	necessários para rodar o jogo, e o MAME vai reclamar se eles não
	puderem ser encontrados.

*	Alguns jogos como **Neo-Geo**, **Playchoice-10**, **Convertible
	Video System**, **Deco Cassette**, **MegaTech**, **MegaPlay**,
	**ST-V Titan** e outros, precisam das suas ROMs e do conjunto de
	BIOS.

	As ROMs da BIOS geralmente contêm um código da ROM que é usado para
	inicializar a máquina, o código faz lista dos jogos em sistema
	multijogos e o código comum a todos os jogos no referido sistema.

	As ROMs da BIOS devem estar nomeadas corretamente e comprimida em
	formato ``.zip`` dentro da pasta ROMs.

*	Versões mais antigas do MAME precisavam de tabelas para
	descriptografar os arquivos criptografados, criado na época pela
	equipe **CPS2Shock** para que fosse possível emular jogos da
	**Capcom Play System 2**, também conhecido como jogos **CPS2**.

*	Alguns jogos no MAME são considerados *Clones* de outros jogos.
	Isto é, o jogo em questão é simplesmente uma versão alternativa do
	mesmo jogo.

	As versões alternativas de alguns jogos incluem as versões com
	texto em outros idiomas, com diferentes datas de direito autoral,
	versões posteriores ou atualizações, versões piratas, etc.

	Os jogos "clonados" muitas vezes se sobrepõem algum código da ROM do
	jogo, como se fosse a versão original. Para verificar se possuí ou
	não algum tipo de jogo "clonado" digite o comando: ::

		mame.exe -listclones

	Para rodar um "*jogo clonado*" basta colocar a ROM pai dentro da
	pasta ROMs (sempre zipada).

.. raw:: latex

	\clearpage

.. _ROM-Verify:

Como posso ter certeza que tenho as ROMs certas?
------------------------------------------------

O MAME verifica a existência das ROMs corretas antes de iniciar a
emulação. Caso veja alguma mensagem de erro, as suas ROMs não são
aquelas testadas e que funcionam corretamente com o MAME. É necessário
obter as ROMs corretas através de meios legais.

Caso tenha vários jogos e quiser verificar se eles são compatíveis
com a versão atual do MAME, será possível usar a opção ``-verifyroms``.

Por Exemplo: ::

		mame.exe -verifyroms robby

Verifica as suas ROMs para o jogo **Robby Roto** e exibe os resultados
na tela. ::

		mame.exe -verifyroms \* >verify.txt

Verifica a autenticidade de TODAS as ROMs dentro do seu diretório ROMs
e grava os resultados dentro de um arquivo de texto chamado
*verify.txt*.

.. _Parent-Sets:

Por que alguns jogos têm a versão Americana como a principal, outras têm a Japonesa e outros a versão  Mundo (World)?
---------------------------------------------------------------------------------------------------------------------

Embora essa regra nem sempre seja verdadeira, normalmente é a maneira na
qual estes conjuntos são organizados. A prioridade normal é usar o
conjunto **Mundo**, caso esteja disponível, **Americana**, se não
existir nenhum outro conjunto mundial em Inglês e **japonês** ou uma
outra região qualquer.

As exceções são aplicadas quando os conjuntos Americanos e Mundo têm
censuras ou alterações significativas da sua versão original.
Por exemplo, o jogo Gals Panic (do conjunto **galsnew**) usa a versão
Americana como pai porque têm recursos adicionais se comparado com a
versão de exportação mundial (do conjunto **galsnewa**). Esses são
recursos opcionais censurados, como uma opção de layout de controle
adicional (que não usa nenhum botão) e clipes de voz no idioma Inglês.

Uma outra exceção seria para os jogos que foram licenciados por
terceiros para que fossem exportados e lançados lá fora.
O Pac Man, por exemplo, foi publicado pela Midway nos EUA, embora tenha
sido criado pela Namco do Japão. Como resultado, o conjunto pai é o
conjunto japonês **puckman**, que mantém os direitos autorais da Namco.

Por último, um desenvolvedor que adiciona um novo conjunto, este pode
optar por usar qualquer esquema de hierarquia e de nomenclatura que
deseje e não fica restrito às regras acima.
No entanto, a maioria seguem essas diretrizes.

.. raw:: latex

	\clearpage

.. _Legal-ROMs:

Como faço para obter legalmente as ROMs ou as imagens de disco para poder rodar no MAME?
----------------------------------------------------------------------------------------

As principais opções são:

* É possível obter uma licença para eles, comprando uma através de um
  distribuidor ou fornecedor que tenha a devida autoridade para fazê-lo.
* É possível baixar um dos conjuntos de ROMs que foram disponibilizados
  gratuitamente para o público em geral e para o uso não comercial do
  mesmo.
* É possível comprar uma PCB de arcade e extrair as ROMs ou discos você
  mesmo e usá-las com o MAME.

No mais, você está por sua própria conta e risco.


.. _ROMs-Grey:

A cópia legal das ROMs não esbarram num possível limiar jurídico?
-----------------------------------------------------------------

Não, de forma alguma.
Você não tem permissão para fazer cópias de software sem a permissão do
proprietário que detém estes direitos. A questão é preto no branco,
mais claro que isso, impossível.


.. _Abandonware:

As ROMs dos jogos não podem ser consideradas abandonadas com o tempo (abandonware)?
-----------------------------------------------------------------------------------

Não.

Até mesmo as empresas que faliram tiveram seus ativos comprados por
alguém e esse alguém hoje é o detentor legal desses direitos autorais.


.. _eBay-cabs:

E aqueles gabinetes de arcade vendidos no Mercado Livre, OLX e outros lugares que vêm com todas as ROMs?
--------------------------------------------------------------------------------------------------------

Ele poderá estar cometendo um crime caso o vendedor não tenha uma
licença adequada ou permissão para fazer a venda, sem falar nas
devidas permissões legais e licenças para vender um gabinete junto com
essas ROMs. Ele só poderá vendê-las junto com o gabinete quando ele
tiver uma licença ou permissão para vender as ROMs em seu nome, vindas
de um distribuidor ou fornecedor licenciado para tanto.
Caso contrário, estamos falando de pirataria de software.

E para incluir uma versão do MAME nestes gabinetes que eles estão
vendendo junto com as ROMs, seria necessário também assinar um contrato
conosco para obter uma versão licenciada do MAME para rodar apenas as
ROMs que ele adquiriu de forma legal e mais nada.

.. raw:: latex

	\clearpage

.. _ROM-DVDs:

E aqueles caras que gravam DVDs com ROMs e cobram apenas o preço da mídia?
--------------------------------------------------------------------------

O que eles fazem é tão ilegal quanto vender as ROMs de forma direta ou
junto com os gabinetes. Enquanto alguém possuir os direitos autorais
destes jogos, fazer cópias ilegais da maneira que for e
disponibilizá-las para venda é crime e ponto final. Caso alguém vá para
a internet vender cópias piratas do último álbum de um artista qualquer
a preço de banana cobrando apenas o custo da mídia, você acha que eles
conseguiriam sair impunes dessa?

Pior ainda, muitas dessas pessoas gostam de afirmar que elas estão
ajudando o projeto. Para a equipe do MAME, essas pessoas só criam mais
problemas. Nós não estamos associados a essas pessoas de forma
alguma, independentemente de quão "oficiais" elas se achem.
Ao comprar pirataria você está incentivando os criminosos a continuar
lucrando com a venda de software pirata na qual eles não possuem direito
algum.

**Qualquer pessoa que use o nome do MAME e/ou seu logotipo para vender
esses produtos, também está violando direitos autorais e a marca
registrada do MAME.**


.. _DMCA-exemption:

Mas não há uma isenção especial do DMCA que torne a cópia de uma ROM legal?
---------------------------------------------------------------------------

Não.

Você entendeu essas isenções de forma errada. A isenção permite que as
pessoas façam a engenharia reversa para quebrar a criptografia que
protege a cópia de programas de computador obsoletos.

Ela permite que se faça isso para descobrir como esses programas
obsoletos funcionavam, não sendo ilegal de acordo com a DMCA.
Isso nada tem haver com legalidade de violar os direitos autorais dos
programas de computador alheios, que é o que você faz caso faça cópias
ilegais de ROMs.

O DMCA é uma lei Americana, é um acrônimo para **Digital Millennium
Copyright Act** ou numa tradução literal ficaria "*Lei dos Direitos
Autorais do Milênio Digital*".

No Brasil essa lei não tem validade alguma e tão pouco existe qualquer
lei equivalente no Brasil.

.. _24-hours:

Há algum problema se eu baixar a ROM e "experimentar" por 24 horas?
-------------------------------------------------------------------

Esta é uma lenda urbana criada por pessoas que distribuem ROMs para
download em seus sites, tentando justificar o fato deles estarem
infringindo a lei. Não existe nada disso em qualquer lei de direitos
autorais nos EUA e muito menos no Brasil ou em qualquer outro lugar.


.. _commercial-use:

E se eu comprar um gabinete com ROMs legalizadas, posso disponibilizá-lo em um local público para que eu possa ganhar dinheiro?
-------------------------------------------------------------------------------------------------------------------------------

Geralmente não.

Tais ROMs são licenciadas apenas para fins pessoais e de uso não
comercial a não ser que você tenha adquirido uma licença que diga o
contrário e permita tal uso.


.. _Ultracade:

Mas eu já vi gabinetes do Ultracade e Global VR Classics montados em lugares públicos? Por que eles podem?
----------------------------------------------------------------------------------------------------------

O Ultracade tinha dois produtos distintos, a máquina **Ultracade**
possuía **licenças comerciais** para o uso dos jogos com finalidade
comercial, já o **Arcade Legends** possuía uma licença **exclusiva**
voltada **apenas** para uso em ambiente particular e residencial.

Apenas as máquinas com licença comercial foram concebidas para serem
colocadas em local público e gerar renda, assim como foram e ainda são
as máquinas de arcade tradicionais.

Desde sua aquisição pela empresa Global VR eles só oferecem o gabinete
**Global VR Classics**, que equivale ao produto Ultracade anterior.


.. _Blackscreen-DirectX:

AJUDA! Eu estou tendo tela preta ou uma mensagem de erro relacionada com o DirectX no Windows!
----------------------------------------------------------------------------------------------

Possivelmente os arquivos Runtimes do DirectX, estejam faltando ou estão
danificados. Você pode baixar a ferramenta do DirectX mais recente
direto do site da Microsoft no endereço abaixo:
https://www.microsoft.com/pt-br/download/details.aspx?displaylang=en&id=35

Informações adicionais para a solução de problemas podem ser encontradas
na página da Microsoft em:
https://support.microsoft.com/pt-br/help/179113/how-to-install-the-latest-version-of-directx


.. _ControllerIssues:

Eu tenho um controlador que não quer funcionar com a versão nativa do MAME no Windows, o que posso fazer?
---------------------------------------------------------------------------------------------------------

O MAME predefine que lerá de forma direta os dados do(s) joystick(s), do
mouse e do(s) teclado(s) no Windows. Isso funciona com a maioria dos
dispositivos fornecendo resultados mais estáveis. No entanto, alguns
dispositivos precisam da instalação de drivers especiais que podem não
funcionar ou não ser compatível com o MAME.

Tente configurar as opções
:ref:`keyboardprovider<mame-commandline-keyboardprovider>`,
:ref:`mouseprovider<mame-commandline-mouseprovider>` ou
:ref:`joystickprovider<mame-commandline-joystickprovider>`
(dependendo de qual tipo de dispositivo de entrada ele seja) vindo da
entrada direta para uma das outras opções como o dinput ou win32.

Consulte também o capítulo :ref:`osd-commandline-options` para saber
mais detalhes de outros provedores compatíveis.


.. _ExternalOPL:

O que aconteceu com o suporte do MAME para placas de som externas com o OPL2 integrado?
---------------------------------------------------------------------------------------

O MAME em vez de emular o **OPL2** [#OPL2]_, inicialmente adicionou o
suporte para placas de som com o CI **YM3212** da Yamaha em sua versão
0.23.

Na versão nativa do MAME nunca houve um suporte adequado para essa
funcionalidade e foi completamente eliminada na versão 0.60, assim a
emulação do OPL2 tornou-se avançada o suficiente para ser a melhor
solução para a maioria dos casos naquela época.

Atualmente as placas de som mais recentes e modernas, não vem mais com
o **YM3212** embutido, tornando-se então a única solução.

As versões não oficiais do MAME podem também ter mantido esse suporte
por um período de tempo maior.

.. _Autofire:

O que aconteceu com a opção de Auto Disparo?
--------------------------------------------

Um plug-in Lua mais aprimorado e com mais funcionalidades foi adicionado
ao MAME 0.210, a opção que antes estava embutida no código fonte foi
removida no MAME 0.216. Este novo plug-in tem mais funcionalidades do
que o recurso de auto disparo incorporado na versão anterior, por
exemplo, você pode configurar um botão alternativo para o auto disparo
com diferentes taxas de disparo.

Para ativar e configurar o novo sistema de auto disparo, siga as
instruções abaixo:

 * Inicie o MAME sem nenhum sistema.
 * Selecione a opção **Plug-ins**.
 * Ative a opção **Autofire**.

A configuração é salva no arquivo ``plugin.ini`` dentro do diretório
raiz do MAME no Windows ou ~/.mame em sistemas \*nix \ e compatíveis.
Inicie um sistema de sua preferência, pressione **TAB** para que seja
exibida a interface do MAME e vá para **Opções dos Plug-ins -->
Autofire**. Caso já exista uma configuração de auto disparo definida,
ela será exibida, caso contrário a interface pedirá para que um botão de
auto disparo seja definido.

Na ausência de uma configuração selecione **add autofire button** e a
seguinte interface será exibida:

 * **Input**

	Escolha qual o botão que deseja usar a função de auto disparo.

 * **Hotkey**

	Escolha qual o botão de atalho deseja utilizar.

 * **On frames**

	Quantidade de quadros em que o botão será pressionado.

 * **Off frames**

	Quantidade de quadros em que o botão será liberado.

Clique duas vezes em **Input** para escolher o botão a ser usado, para
a máquina *Galaga* por exemplo, o jogador 1 usará **P1 Button 1**.
**Hotkey** é o botão que será usado para o auto disparo no momento que
for pressionado, ele pode ser qualquer botão do controle ou do teclado.
Note porém que desde a versão 0.216 ainda não há suporte para botões do
mouse.

Na opção **On frames** e **Off frames** você define a velocidade do
acionamento ou não acionamento do botão em quantidade de quadros. Alguns
sistemas não tem a capacidade de identificar velocidades muito rápidas
do acionamento dos botões como a máquina **Alcon** por exemplo assim
como várias outras. Caso se depare com essas máquinas reduza a
velocidade do acionamento aumentando o valor de **On frames** e **Off
frames**, escolha valores como 2 e 2 ou 3 e 3, etc.

Todas as configurações de auto disparo ficam armazenadas dento do
diretório **Autofire** com o nome da máquina utilizada seguida da
extensão *.cfg* (**galaga.cfg** por exemplo). Note haverá problemas caso
o botão de auto disparo seja definido no mesmo botão já predefinido pelo
MAME, veja o exemplo da máquina **Gradius**:

Caso o botão de disparo para o jogador 1 seja o mesmo escolhido para o
auto disparo, ao segurar o botão de disparo o auto disparo não vai
funcionar pois o botão nunca é liberado pelo jogador que o mantém
pressionado. O mesmo ocorre caso outro botão de auto disparo seja
escolhido e ambos os botões de disparo e auto disparo forem pressionados
ao mesmo tempo. Caso escolha o botão 3 do seu controle para usar o auto
disparo e o mesmo botão for usado para ativar um "power up", toda a vez
que o personagem recolher o item de "power up" este será ativado pelo
auto disparo pois este estará sempre pressionado junto com o botão de
auto disparo.

É obrigatório que o botão de auto disparo escolhido seja qualquer outro
botão que já não esteja sendo utilizado ou que não tenha nenhuma função
no sistema.

.. _gsync-freesync:

O MAME é compatível com o G-Sync ou FreeSync? Como configurar o MAME para utilizá-los?
--------------------------------------------------------------------------------------

O MAME já é compatível com ambos G-Sync e FreeSync nos sistemas Windows
e Linux, contudo não há a compatibilidade com o macOS ainda.

* Tenha certeza que seu monitor suporta pelo menos 120 Hz
  G-Sync/FreeSync. Caso o seu monitor seja compatível apenas com o modo
  G-Sync/FreeSync em 60 hz, haverá problemas com drivers como o
  *Pac-Man* que roda a **60.60606 Hz**, assim como outros que rodam com
  uma velocidade semelhante porém não os 60 Hz exatos.
* Caso esteja jogando o MAME em modo janela ou utilizando o sistema
  de vídeo BGFX, será necessário ter certeza que tenha o G-Sync/FreeSync
  ativado para o driver de vídeo que estiver utilizando nas aplicações
  em modo janela, assim como no modo de tela inteira.
* Tenha certeza que a opção :ref:`triple buffering
  <mame-wcommandline-triplebuffer>` esteja desligado.
* No geral, é aconselhável ligar a opção Vsync quando usar o G-Sync e 
  FreeSync.
* A opção :ref:`-lowlatency <mame-commandline-lowlatency>` não afeta o
  desempenho do MAME com o G-Sync ou FreeSync.

Os efeitos do G-Sync e FreeSync é mais notável nos drivers que rodam com
taxas de atualização que sejam bem diferentes do que o seu PC esteja
executando. Como por exemplo, os primeiras três versões do
**Mortal Kombat** roda a **54.706841 Hz**.

.. [#OPL2]	OPL é um acrônimo de "*FM Operator Type-L*" ou em uma tradução
		livre, *Operador de Modulação em Frequência Tipo L*, o 2 é o
		número do modelo. (Nota do tradutor)
