.. _contributing:

CONTRIBUINDO COM O MAME
=======================

Você deseja contribuir com o MAME, mas não sabe por onde começar? A boa
notícia é que há sempre muito a ser feito, especialmente para pessoas
com habilidades diversas.


Testando e relatando problemas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O MAME sempre pode realizar mais testes e relatar mais bugs. Se estiver
familiarizado com um sistema emulado pelo MAME e notar algo errado ou
encontrar um problema (*bug*) em sua interface, crie uma conta no
`MAME Testers <https://mametesters.org/view_all_bug_page.php>`_. Se o
problema ainda não tiver sido relatado, crie uma conta e relate o que
aconteceu. Leia primeiro as regras para ter certeza de que começará da
maneira correta. Observe que o "MAME Testers" só aceita relatos de
problemas encontrados pelos próprios usuários e em versões específicas.

Para outros tipos de bugs, há um pouco mais de liberdade no `github
issues <https://github.com/mamedev/mame/issues>`_. Aqui, por exemplo,
aceitamos problemas relacionados ao desenvolvimento (como problemas com
a API interna ou com a compilação), solicitações e correções de grandes
regressões que impeçam a chegada de uma nova versão. Lembre-se de que o
"*issue tracker*" **não é** um fórum de discussão ou de suporte, mas
apenas um local para relatar problemas passíveis de reprodução. Não abra
um chamado (*ticket*) para fazer perguntas ou pedir ajuda. Tenha ciência
também de que a versão disponível é instável. Se a revisão atual não
compilar ou estiver totalmente quebrada, provavelmente já sabemos e não
é necessário abrir um novo chamado para relatar o problema. Espere um
pouco e veja se uma atualização é disponibilizada. Talvez você queira
comentar algo no respectivo commit sobre a mensagem de erro do
compilador, especialmente se estiver fazendo uma compilação não
ortodoxa, mas suportada.

Ao abrir um chamado, lembre-se de fornecer o máximo de informações
possível para ajudar outras pessoas a entender, reproduzir e
diagnosticar o problema.


.. raw:: latex

	\clearpage


Descreva as seguintes informações:
 
* É preciso especificar o comportamento incorreto e o comportamento
  esperado. Seja específico: dizer apenas que *"não funciona"* não ajuda
  em nada para a depuração e para a solução do problema;
* Inclua também detalhes do ambiente, como o sistema operacional, a
  arquitetura da CPU, o idioma do sistema operacional e o idioma de
  exibição, se aplicável. No caso de erros de saída de vídeo, informe o
  hardware (GPU), a versão do driver e o módulo de saída utilizado no
  MAME. Para erros de entrada, inclua os periféricos e os módulos de
  entrada utilizados no MAME;
* Informe também a versão exata do MAME que você está usando, incluindo
  um resumo do commit do Git se não for uma versão final, e quaisquer
  outras opções de compilação que você tenha utilizado;
* Descreva também o sistema e o software emulado com exatidão (o que
  pode não ser aplicável a problemas com partes da interface do usuário
  (IU) do MAME, como o menu de seleção do sistema). Inclua também itens
  como a versão da BIOS selecionada e a configuração dos periféricos
  emulados (dispositivo de slot);
* Em seguida, descreva os passos para reproduzir o problema. Suponha que
  a pessoa que lerá o relatório é familiarizada com o MAME, mas não
  necessariamente com o sistema emulado e o programa em questão. Para
  problemas de emulação, gravar os comandos e/ou os arquivos de estado
  salvos pode ser muito importante para reproduzir o erro;
* Se possível, forneça uma referência do comportamento correto no
  hardware original. Se você tiver acesso ao hardware original do
  sistema emulado, será possível fazer uma gravação para comparar o
  comportamento correto.


.. _contributing-code:

Contribuindo para o código-fonte do MAME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Embora o MAME seja desenvolvido em C++, nem todo o código-fonte é
escrito nessa linguagem. Seu código-fonte também inclui:

* A documentação oficial em Inglês hospedada `neste
  site <https://docs.mamedev.org/>`_ (e também disponibilizada nas
  versões finais do MAME, em formato PDF) é escrita em
  `reStructuredText <https://docutils.sourceforge.io/rst.html>`_;
* Os :ref:`plug-ins <plugins>` foram desenvolvidos em
  `Lua 5.4 <https://www.lua.org/manual/5.4/>`_.
* Há layouts internos para máquinas emuladas que precisam exibir mais
  que uma tela simples, como interfaces e botões, entre outros. Essas
  aplicações em XML são :ref:`descritas aqui <layfile>`;
* Há também as listagens dos programas que descrevem os programas em
  mídia emulados pelo MAME. Essas listagens também estão no formato
  XML;
* A tradução da interface do usuário está no formato `GNU gettext PO
  <https://www.gnu.org/software/gettext/manual/html_node/PO-Files.html>`_.
  É possível editá-la com um bom editor de texto comum ou uma ferramenta
  dedicada, como o `Poedit <https://poedit.net/>`_.

Nosso repositório principal está `hospedado no GitHub
<https://github.com/mamedev/mame/>`_. Preferimos receber contribuições
para o código-fonte por meio de "*pull requests*". Para isso, é
necessário aprender o básico do Git e das suas ferramentas. Para mais
detalhes, consulte a `documentação oficial
<https://git-scm.com/docs/git/pt_BR>`_ do projeto Git.


.. raw:: latex

	\clearpage


O processo básico para criar um "*pull request*" é o seguinte:

* Crie uma conta no GitHub;
* Faça um *fork* do repositório mamedev/mame;
* Crie uma nova ramificação do repositório  principal (**master**) na
  sua conta;
* Então clone (faça um *fork*) do seu repositório e verifique a sua
  nova ramificação;
* Faça as suas alterações, compile e faça os seus testes localmente;
* Aplique as suas alterações e faça um "*push*" na sua ramificação do
  GitHub;
* Opcionalmente, ative o *"GitHub Actions"* em seu repositório,
  para que as suas alterações possam ser compiladas para sistemas
  Windows, macOS e Linux usando os servidores do GitHub;
* Por fim, abra uma solicitação para mesclar as suas alterações no repositório
  principal (**master**) do mamedev/mame.

Lembre-se do seguinte (observe que nem todos os itens são relevantes
para todos os tipos de alterações):

* Detalhe bem o assunto e a mensagem do seu *commit*. Inclua o que a
  alteração afeta e o que ela deve alcançar. Quem ler o registro do
  commit não deve precisar consultar o diff para entender o que foi
  feito. As mensagens de commit padrão fornecidas pelo GitHub são
  completamente inúteis, pois não fornecem nenhuma indicação do
  propósito de uma alteração;
* Teste suas alterações. Garanta que toda a compilação do MAME seja
  concluída sem erros e que o código alterado funcione. É uma boa ideia
  compilar com **DEBUG=1** para verificar se todas as asserções foram
  compiladas, mas não disparadas.
* Use um título e uma descrição elucidativos. O título deve fornecer um
  resumo de uma linha sobre o que a alteração geral afeta e como ela
  deve funcionar. A descrição deve conter mais detalhes. Não deixe a
  descrição em branco, pois isso torna a busca e a filtragem muito mais
  difíceis.
* Esteja ciente de que o "*GitHub Actions*" tem limites de recursos. Não
  está claro quando se está próximo dos limites e já vimos colaboradores
  serem banidos do GitHub Actions por violá-los. Mesmo que você recorra
  da proibição, não lhe dirão quais são os limites reais, justificando
  que, se você os conhece, pode tomar medidas para evitá-los. Ao ativar
  o GitHub Actions, considere não fazer o push de commits individuais, a
  menos que você precise que eles sejam criados automaticamente, ou
  cancele execuções de fluxo de trabalho quando não precisar dos
  resultados;
* Caso o envio seja um computador ou outro dispositivo que necessite de
  um disco, fita, cartucho ou outro tipo de mídia para ser iniciado e
  executado, considere a possibilidade de criar uma lista de softwares
  contendo pelo menos um exemplo dessa mídia. Isso ajuda todos que fazem
  alterações nos componentes compartilhados do MAME a verificarem
  facilmente se as alterações afetam negativamente o código;
* Ao enviar qualquer máquina nova que não seja de arcade — especialmente
  uma que não inicializa automaticamente e requer interação para ser
  utilizada —, considere adicionar instruções de uso à página
  "Configuração" e `informações específicas do sistema`_ à página `wiki
  do MAME`_. Qualquer pessoa pode editar o wiki após criar uma conta. Também
  são bem-vindas subpáginas que descrevam detalhes técnicos do seu
  sistema.

.. _informações específicas do sistema: https://wiki.mamedev.org/index.php/System-Specific_Setup_and_Information
.. _Wiki do MAME: https://wiki.mamedev.org/

.. raw:: latex

	\clearpage

Temos diretrizes para partes específicas do código-fonte:

.. toctree::
    :titlesonly:

    cxx
    softlist
