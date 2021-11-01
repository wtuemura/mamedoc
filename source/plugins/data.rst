.. _plugins-data:

Data Plugin
===========

Este plug-in de dados carrega informações a partir de diferentes
arquivos de suporte externo para que possam ser exibidos pelo MAME.
Quando ativado, as informações são mostradas na aba
:guilabel:`Informações` à direita nos menus de seleção do sistema e
software.  As informações pode ser mostradas clicando no botão da barra
de ferramentas do sistema, software ou escolhendo
:guilabel:`Visualização da DAT externa` no menu principal durante a
emulação (este item não aparecerá caso o plugin de dados não esteja
ativado ou caso não haja informações disponíveis para o sistema emulado
no momento).

Para definir a pasta onde os plug-ins procuram por estes dados de
suporte, escolha :guilabel:`Configurações` -->
:guilabel:`Configurações dos diretórios` -- > :guilabel:`Dats`. Também é
possível definir o seu ``historypath`` no seu arquivo ``ui.ini``.

Ao carregar grandes arquivos de dados tais como o **history.xml**, isso
pode acarretar num tempo maior de carregamento, atrasando a abertura da
tela do MAME. Assim sendo, seja paciente ao iniciar o MAME após
atualizar ou adicionar novos arquivos de dados.

.. raw:: latex

	\clearpage

Os seguintes arquivos são compatíveis com o MAME:

history.xml
    Do `Gaming-History <https://www.arcade-history.com/>`_ (antigamente
    conhecido como Arcade-History)
mameinfo.dat
    Do `MASH’s MAMEINFO <https://mameinfo.mameworld.info/>`_
messinfo.dat
    Do `progetto-SNAPS MESSINFO.dat
    <https://www.progettosnaps.net/messinfo/>`_
gameinit.dat
    Do `progetto-SNAPS GameInit.dat
    <https://www.progettosnaps.net/gameinit/>`_
command.dat
    Do `progetto-SNAPS Command.dat
    <https://www.progettosnaps.net/command/>`_
score3.htm
    `Top Scores <http://replay.marpirc.net/txt/scores3.htm>`_ da página
    `MAME Action Replay Page <http://replay.marpirc.net/>`_
mameinfo.dat / command.dat Japonês
    Do `MAME E2J <https://e2j.net/downloads/>`_
sysinfo.dat
    Do agora defunto site Progetto EMMA
story.dat
    Do agora defunto site MAMESCORE

Caso instale o `hi2txt <https://greatstoneex.github.io/hi2txt-doc/>`_
também é possível exibir os maiores placares com o *data plugin* e
salvar o placar da memória não volátil ou através do
:ref:`hiscore support plugin <plugins-hiscore>` para jogos compatíveis.

Observe que não é possível, por exemplo, usar diferentes
arquivos ``mameinfo.dat`` feitos para diferentes idiomas ao mesmo tempo.

O *data plugin* cria um arquivo chamado ``history.db`` na primeira pasta
configurada para DATs. Este arquivo armazena as informações do arquivos
de suporte em formato SQLite3 visando uma rápida leitura.

