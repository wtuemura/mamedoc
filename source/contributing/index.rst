.. _contributing:

CONTRIBUINDO COM O MAME
=======================

Deseja contribuir com o MAME mas não sabe por onde começar? A boa
notícia é que sempre há muito o que ser feito, especialmente para
pessoas com com uma grande variedade de habilidades.

Testando e relatando bugs
-------------------------

Algo que o MAME sempre pode fazer é mais testes e mais relatórios de
bugs. Caso esteja familiarizado com um sistema que o MAME emula e nota
algo de errado ou caso encontre um bug na interface do MAME, crie uma
conta em `MAME Testers <https://mametesters.org/view_all_bug_page.php>`_
e assumindo que já não tenha sido relatado, crie uma conta e relate o
problema encontrado. Tenha certeza que você leia primeiro as regras para
ter certeza de que vai começar da maneira correta. Observe que o
"MAME Testers" só aceita bugs voltados ao usuário em versões
específicas.

Para outros tipos de bugs, temos o
`github issues <https://github.com/mamedev/mame/issues>`_ onde há um
pouco mais de liberdade. Por exemplo, aqui aceitamos problemas voltados
ao desenvolvimento (problemas com a API interna ou problemas com o
sistema de compilação), solicitações e a correção de grandes regressões
que evita antes cheguem a versão de um lançamento.  Respeite o fato que
o "issue tracker" **não é** um fórum de discussão ou de suporte, é
apenas para relatar problemas que possam ser reproduzidos. Não abra um
chamado para fazer perguntas ou para pedir ajuda. Assim como, tenha
ciência que o versão que ali está é instável. Caso a revisão atual não
compile ou esteja totalmente quebrada, é bem provável que a gente já
saiba e não é necessário abrir um novo chamado para relatar o problema.
Dê um tempo e veja se aparece uma atualização. Talvez queira comentar
algo no respectivo commit sobre a mensagem de erro do compilador,
especialmente se estiver fazendo uma compilação não ortodoxa, mas,
suportada.

Ao abrir um *"ticket"*, lembre-se de fornecer o máximo de informações
possíveis para auxiliar outras pessoas a compreender, reproduzir e
diagnosticar o problema.

.. raw:: latex

	\clearpage

Informações que são importantes descrever:
 
* O comportamento incorreto e o comportamento esperado ou correto. Seja
  específico: apenas dizer que "não funciona" geralmente não informa
  muita coisa.
* Os detalhes do ambiente, incluindo o seu sistema operacional,
  arquitetura da CPU, localidade do sistema e o idioma de exibição, se
  aplicável.
* Para problemas relacionados com a saída de vídeo, informe o seu
  hardware de vídeo (GPU), a versão do driver e a opção de vídeo usada
  no MAME que você usou (ou não).
* Para problemas relacionados com a entrada, inclua os periféricos de
  entrada e as opções de entrada MAME que você está usando.
* A versão exata do MAME que você está usando, incluindo um
  *"git commit digest"* caso não seja uma versão final de lançamento,
  incluindo qualquer opção de compilação fora do padrão.
* A descrição exata do sistema e o software que está sendo emulado (pode
  não ser aplicável para problemas com partes da interface do usuário
  (IU) do MAME, como o menu de seleção do sistema). Inclua itens como a
  versão do BIOS selecionada e a configuração dos periféricos emulados
  (dispositivo de slot).
* Os passos para reproduzir o problema.  Assuma que a pessoa que está
  lendo é familiar com o próprio MAME, mas não necessariamente
  familiarizado com o sistema emulado e o programa em questão. Para
  problemas de emulação, a gravação dos comandos e/ou arquivos de estado
  salvos para reproduzir o problema podem ser muito importante.
* Se possível, uma referência do original que indique o comportamento
  correto. Caso tenha acesso ao hardware original do sistema emulado,
  isso ajuda a fazer uma gravação para comparar o comportamento correto.

.. _contributing-code:

Contribuindo para o código-fonte do MAME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O MAME é desenvolvido em C++, porém, ele não é todo desenvolvido com
essa linguagem. O código-fonte também inclui:

* A documentação hospedada neste site (e também disponibilizada nas
  versões finais do MAME como um PDF), escrito em formato
  `reStructuredText <https://docutils.sourceforge.io/rst.html>`_.
* Os :ref:`plug-ins <plugins>`, oferecidos desenvolvidos em
  `Lua 5.3 <https://www.lua.org/manual/5.3/>`_.
*  Layouts internos para máquinas emuladas que precisam exibir mais que
   uma simples tela emulada como interfaces, botões, etc. Estes são
   aplicações em XML :ref:`descritos aqui <layfile>`.
*  As listagens dos programas que descrevem os programas em mídia
   emulados pelo MAME. Essas listagens também estão em formato XML.
*  A tradução da interface do usuário está em formato
   `GNU gettext PO <https://www.gnu.org/software/gettext/manual/html_node/PO-Files.html>`_.
   Eles podem ser editados com um bom editor de texto ou uma ferramenta
   dedicada como o `Poedit <https://poedit.net/>`_.

O nosso repositório principal está
`hospedado no GitHub <https://github.com/mamedev/mame/>`_. Nós
preferimos receber contribuições para o código-fonte em forma de
`pull requests <https://github.com/mamedev/mame/pulls>`_. Você precisará
aprender o básico do git e se familiarizar com as ferramentas do git.

.. raw:: latex

	\clearpage

O processo básico para criar um *"pull request"* é o seguinte:

* Crie uma conta no GitHub.
* Faça um *fork* do repositório mamedev/mame.
* Crie uma nova ramificação do nosso ``master`` no repositório na sua
  conta.
* Faça a clonagem do *fork* do seu repositório bifurcado e verifique a
  sua nova ramificação.
* Faça as suas alterações, compile e faça os seus testes localmente.
* Aplique as suas alterações e faça um *"push"* na sua ramificação do
  GitHub.
* Opcionalmente, ative o *"GitHub Actions"* no seu repositório,
  permitindo que as suas alterações possam ser compiladas no Windows, no
  macOS e no Linux.
* Abra uma solicitação para mesclar as suas alterações no repositório
  ``master`` do mamedev/mame.

Lembre-se do seguinte (observe que nem todos os pontos são relevantes
a todos os tipos de alterações):

* Detalhe bem o assunto e a mensagem do seu *commit*. Inclua o que a sua
  alteração faz e qual a sua finalidade. Uma pessoa que leia o registro
  log do *commit* não precisa ter que examinar todo o *diff* para ter
  uma ideia básica do que um *commit* deve fazer. As mensagens padrão do
  *commit* fornecidas pelo GitHub são totalmente inúteis, pois não
  oferecem quaisquer indicação do que uma alteração deveria fazer.
* Teste as suas alterações. Garanta que toda a compilação do MAME possa
  ser concluída sem erros e que o código que você alterou funciona. É
  uma boa ideia compilar com ``DEBUG=1`` para verificar se todas as
  asserções são compiladas e não disparadas.
* Utilize um título e uma descrição elucidativa. O título deve fornecer
  um resumo de uma linha do que a alteração geral afeta e o que ela faz.
  Já na descrição, ela deve ser bem mais detalhada. Não deixe a
  descrição em branco e descreva a alteração nos comentários, pois isso
  torna a busca e a filtragem muito mais difíceis.
* Esteja ciente que o *"GitHub Actions"* possui recursos limitados. Não
  fica claro quando você está perto ou atinge tais limites, nós tivemos
  colaboradores banidos do *"GitHub Actions"* por violar tais limites.
  Mesmo que você apele, eles ainda não vão te dizer quais são os limites
  reais, justificando que caso você saiba os limites reais, será
  possível criar meios para evitá-los. Caso ative o *"GitHub Actions"*,
  considere não enviar *commits* individuais se não precisar que eles
  sejam automaticamente compilados ou executar o cancelamento do fluxo
  de trabalho quando não mais precisar dos resultados.

.. raw:: latex

	\clearpage

Temos diretrizes para partes específicas do código-fonte:

.. toctree::
    :titlesonly:

    cxx
    softlist
