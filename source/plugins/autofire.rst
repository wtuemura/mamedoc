.. _plugins-autofire:

Autofire Plugin
===============

.. contents:: :local:


.. _plugins-autofire-intro:

Introdução
----------

O *autofire plugin* permite simular um botão turbo (disparo automático),
o que pode ser útil para pessoas com alguma deficiência ou lesões em
jogos de tiro ou em que seja preciso pressionar o botão repetidas vezes.
Ele também pode auxiliar na prevenção de lesões por esforço repetitivo,
por exemplo.

Para configurá-lo, pressione :kbd:`Tab` durante a emulação e selecione
:guilabel:`Opções dos plug-ins` --> :guilabel:`Turbo`. O MAME
não vem com nenhum botão turbo configurado. Ao clicar duas vezes em
:guilabel:`Adiciona um botão turbo`, para configurar o botão. Consulte
:ref:`plugins-autofire-settings` para mais detalhes sobre essa
configuração. Quando não quiser mais a configuração, destaque o botão
que deseja excluir e clique em :kbd:`Del`.

Todas as configurações do turbo são salvas na pasta **autofire** dentro
da pasta designada para os dados do plug-in
(consulte a opção :ref:`homepath <mame-commandline-homepath>`). Ali
ficam armazenados arquivos de configuração para cada sistema, e a
nomenclatura usada é o nome da ROM com a extensão ``.cfg``. Por exemplo,
a configuração de um botão turbo para **Super-X** é salva como
``superx.cfg``, e o conteúdo do arquivo tem o formato JSON.


.. _plugins-autofire-settings:

Configurando os botões turbo
----------------------------

As as opções para adicionar um novo botão turbo ou para alterar as
suas configurações são as mesmas.

Selecione :guilabel:`Adicionar um botão turbo` e depois
:guilabel:`Entrada`, escolha o botão emulado que usar o turbo. Apenas
as entradas digitais são compatíveis com essa função. Em jogos de tiro,
você normalmente definirá isso como o botão de disparo principal.
Geralmente é o botão :guilabel:`P1 botão 1`, mas pode ter um nome
diferente para outro jogador. Nos jogos *Gradius* da Konami, por
exemplo, o botão :guilabel:`P1 botão 2` é o principal botão de disparo.

Selecione :guilabel:`Tecla de atalho` para definir o controle (ou
combinação de controles) que será usado para ativar o botão de turbo.
Pode ser qualquer combinação que o MAME suporte para ativar uma entrada
digital.

.. note:: Você não pode usar o mesmo botão já predefinido pelo MAME.

As opções :guilabel:`Quadros ligados` e :guilabel:`Quadros desligados`
definem por quanto tempo (em quantidade de quadros da emulação) o botão
deve permanecer pressionado e quando deve ser liberado. O ajuste pode
ser feito com as teclas :kbd:`esquerda` e :kbd:`direita` do teclado ou
usando as setas ao lado da opção. Para retornar aos valores originais,
use a tecla :kbd:`Del`. Ao concluir a configuração, clique em
:guilabel:`Cria` para criar o botão turbo.

Quanto menor o valor, mais rápido o botão turbo funciona; quanto maior o
valor, mais lento ele fica. Observe que nem todos os sistemas podem
aceitar valores muito baixos (rápidos) pois depende da rapidez com que o
sistema emulado lê as entradas, para que o turbo surta efeito no
sistema Alcon, por exemplo, é preciso configurar os valores como
**2 quadros ligados** e **2 quadros desligados**.
Experimente diferentes valores para obter os melhores resultados.

O novo botão será adicionado ao final da lista. Pressione a tecla
:guilabel:`retornar ao menu anterior`, ou pressione a tecla :kbd:`Esc`
ou selecione :guilabel:`Cancelar` antes de definir a entrada ou a tecla
de atalho para retornar ao menu anterior sem criar o novo botão de
turbo.

Ao modificar um botão de disparo automático existente, selecione
:kbd:`Feito` para aplicar as configurações e pressione :kbd:`Tab` para
fechar a interface e retornar à emulação. As alterações entram em
vigor imediatamente.

Para excluir um botão turbo já existente, selecione-o e pressione
:kbd:`Del` no teclado. O botão de turbo será excluído imediatamente,
sem necessidade de confirmação adicional.


.. _plugins-autofire-notes:

Observações e possíveis imprevistos
-----------------------------------

Os botões turbo agem como se estivessem conectados em paralelo às
entradas convencionais do MAME. Isso significa que, se você definir um
atalho para o botão turbo no mesmo botão ou chave que também é atribuído
diretamente a uma das entradas emuladas, você pode obter resultados
inesperados. Usando o Gradius como exemplo:

* Suponhamos que você tenha atribuído o **botão 1** do seu controle como
  disparo e também o tenha definido como turbo. Ao manter o botão de
  tiro pressionado, ele nunca será liberado e o turbo para de funcionar.
  O mesmo acontece se você definir outro botão qualquer como turbo (o
  **botão 3**, por exemplo) e mantiver os botões 1 e 3 pressionados ao
  mesmo tempo.
* Se o **botão 3** estiver definido como turbo e também estiver definido
  como *powerup*, a ação sempre ativará o *powerup*, pois internamente é
  como se este botão estivesse sempre pressionado.

Por isso, é recomendável escolher um botão qualquer e não aqueles que já
estão sendo usados pela emulação.

Usar um botão diferente como turbo é útil em jogos nos quais é preciso
manter o botão de tiro pressionado para liberar um tiro com maior poder
de fogo (como em *Raiden Fighters*, por exemplo), de modo que usar um
botão diferente com a função turbo acaba sendo uma
necessidade. [#TURBO]_.

..  [#TURBO] Nas versões mais antigas do MAME, o processo era muito
   mais simples, bastava ativar o turbo no botão desejado. Porém,
   a função foi removida no
   `MAME 0.216 <https://github.com/mamedev/mame/commit/90fe1e649a7bc9ea667de249736062d5dea21f7a>`_ .
   Com a função removida, não é mais possível usar o botão que já
   funcionava como disparo; agora é preciso escolher um botão diferente.
   ``(o_O)!``
