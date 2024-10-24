.. _contributing:

CONTRIBUINDO COM O MAME
=======================

Deseja contribuir com o MAME, mas não sabe por onde começar? A boa
notícia é que há sempre muito o que ser feito, especialmente para
pessoas com habilidades diversas.

Testando e relatando bugs
-------------------------

Algo que o MAME sempre pode fazer é realizar mais testes e relatar mais
bugs. Se estiver familiarizado com um sistema que o MAME emula e notar
algo errado ou encontrar um bug na interface do MAME, crie uma
conta no
`MAME Testers <https://mametesters.org/view_all_bug_page.php>`_. Caso o
problema já não tenha sido relatado, crie uma conta e relate o que
aconteceu. Leia primeiro as regras para ter certeza de que vai começar
da maneira correta. Observe que o "MAME Testers" só aceita bugs
encontrados pelos usuários e em versões específicas.

Para outros tipos de bugs, há um pouco maism de liberdade no
`github issues <https://github.com/mamedev/mame/issues>`_. Por exemplo,
aqui aceitamos problemas voltados ao desenvolvimento (problemas com a
API interna ou problemas com a compilação), solicitações e a correção de
grandes regressões que evitam que cheguem à uma nova versão. Lembre-se
de que o "issue tracker" **não é** um fórum de discussão ou de suporte,
mas apenas um local para relatar problemas que possam ser reproduzidos.
Não abra um chamado para fazer perguntas ou pedir ajuda. Tenha ciência
também de que a versão disponível é instável. Se a revisão atual não
compilar ou estiver totalmente quebrada, provávelmente já saibemos e não
é necessário abrir um novo chamado para relatar o problema. Espere um
pouco e veja se aparece uma atualização. Talvez queira comentar
algo no respectivo commit sobre a mensagem de erro do compilador,
especialmente se estiver fazendo uma compilação não ortodoxa, mas
suportada.

Ao abrir um *"ticket"*, lembre-se de fornecer o máximo de informações
possíveis para auxiliar outras pessoas a compreender, reproduzir e
diagnosticar o problema.

.. raw:: latex

	\clearpage

Descreva as seguintes informações:
 
* É preciso especificar o comportamento incorreto e o comportamento
  esperado ou correto. Seja específico: dizer apenas que
  *"não funciona"* geralmente não ajuda.
* Inclua também detalhes do ambiente, incluindo o sistema operacional,
  a arquitetura da CPU, o idioma do sistema e de exibição, se for
  aplicável. Para erros de saída de vídeo, informe o hardware de vídeo
  (GPU), a versão do driver e o módulo de saída de vídeo utilizado no
  MAME. Para erros de entrada, inclua os periféricos e os módulos de
  entrada usados no MAME.
* A versão exata do MAME que você está usando, incluindo um resumo do
  commit do git, se não for uma versão final, e quaisquer opções de
  compilação fora do padrão.
* A descrição exata do sistema e o software emulado (o que pode não ser
  aplicável a problemas com partes da interface do usuário (IU) do
  MAME, como o menu de seleção do sistema). Inclua itens como a versão
  da BIOS selecionada e a configuração dos periféricos emulados
  (dispositivo de slot).
* A seguir, os passos para reproduzir o problema. Suponha que a pessoa
  que está lendo é familiarizada com o MAME, mas não necessariamente com
  o sistema emulado e o programa em questão. Para problemas de
  emulação, gravar os comandos e/ou arquivos de estado salvos pode ser
  muito importante para reproduzir o erro.
* Se possível, uma referência do comportamento correto no hardware
  original. Se tiver acesso ao hardware original do sistema emulado,
  isso ajuda a fazer uma gravação para comparar o comportamento correto.

.. _contributing-code:

Contribuindo para o código-fonte do MAME
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O MAME é desenvolvido em C++, porém não é todo escrito nessa linguagem.
O código-fonte também inclui:

* A documentação hospedada neste site (e também disponibilizada nas
  versões finais do MAME como um PDF) é escrita em formato
  `reStructuredText <https://docutils.sourceforge.io/rst.html>`_.
* Os :ref:`plug-ins <plugins>` foram desenvolvidos em
  `Lua 5.3 <https://www.lua.org/manual/5.3/>`_.
*  Layouts internos para máquinas emuladas que precisam exibir mais que
   uma simples tela emulada simples, como interfaces e botões, entre
   outros. Essas aplicações em XML são :ref:`descritas aqui <layfile>`.
*  As listagens dos programas que descrevem os programas em mídia
   emulados pelo MAME. Essas listagens também estão no formato XML.
*  A tradução da interface do usuário está no formato
   `GNU gettext PO <https://www.gnu.org/software/gettext/manual/html_node/PO-Files.html>`_.
   É possível editá-la com um bom editor de texto ou uma ferramenta
   dedicada, como o `Poedit <https://poedit.net/>`_.

O nosso repositório principal está
`hospedado no GitHub <https://github.com/mamedev/mame/>`_. Preferimos
receber contribuições para o código-fonte na forma de
`pull requests <https://github.com/mamedev/mame/pulls>`_. Você precisará
aprender o básico do Git e suas ferramentas.

.. raw:: latex

	\clearpage

O processo básico para criar um *"pull request"* é o seguinte:

* Crie uma conta no GitHub.
* Faça um *fork* do repositório mamedev/mame.
* Crie uma nova ramificação do nosso repositório ``master`` na sua
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
para todos os tipos de alterações):

* Detalhe bem o assunto e a mensagem do seu *commit*. Inclua o que a
  alteração afeta e o que ela deve alcançar. Uma pessoa que lê o
  registro do commit não deve precisar recorrer ao exame do diff para
  ter uma ideia básica do que foi feito. As mensagens padronizadas do
  commit fornecidas pelo GitHub são completamente inúteis, pois não
  fornecem nenhuma indicação do que uma alteração deve fazer.
* Teste as suas alterações. Garanta que toda a compilação do MAME possa
  ser concluída sem erros e que o código que foi alterado funciona. É
  uma boa ideia compilar com ``DEBUG=1`` para verificar se todas as
  asserções foram compiladas e não disparadas.
* Utilize um título e uma descrição elucidativa. O título deve fornecer
  um resumo de uma linha sobre o que a alteração geral afeta e como ela
  deve funcionar. A descrição deve conter mais detalhes. Não deixe a
  descrição em branco e descreva a alteração nos comentários, pois isso
  torna a busca e a filtragem muito mais difíceis.
* Esteja ciente de que o *"GitHub Actions"* tem limites de recursos. Não
  está claro quando você está próximo dos limites, e já vimos
  colaboradores serem banidos do *GitHub Actions* por violá-los. Mesmo
  que você recorra da proibição, eles ainda não lhe dirão quais são os
  limites reais, justificando que, se você os conhece, pode tomar
  medidas para evitá-los. Ao ativar o *GitHub Actions*, considere não
  fazer o push de commits individuais se não precisar que eles sejam
  criados automaticamente ou cancele execuções de fluxo de trabalho
  quando não precisar dos resultados.
* Se o seu envio for um computador ou outro dispositivo que requer um
  disco, fita, cartucho ou outra mídia para ser iniciado e executado,
  considere a possibilidade de criar uma lista de software que contenha
  pelo menos um exemplo dessa mídia. Isso ajuda todos que fazem
  alterações nos componentes compartilhados do MAME a verificarem
  facilmente se as alterações afetam negativamente o código.
* Ao enviar qualquer máquina nova que não seja de arcade, mas
  especialmente uma que não inicializa automaticamente e requer
  interação para ser utilizada, considere adicionar instruções de uso à
  página "Configuração" e `informações específicas do sistema`_ na
  página `Wiki do MAME`_. Qualquer pessoa pode editar o wiki após criar
  uma conta, e também são bem-vindas as subpáginas do seu sistema que
  descrevam detalhes técnicos.


.. _informações específicas do sistema: https://wiki.mamedev.org/index.php/System-Specific_Setup_and_Information
.. _Wiki do MAME: https://wiki.mamedev.org/

.. raw:: latex

	\clearpage

Temos diretrizes para partes específicas do código-fonte:

.. toctree::
    :titlesonly:

    cxx
    softlist
