.. raw:: latex

	\clearpage

.. _plugins-inputmacro:

Input Macro Plugin
==================

.. contents:: :local:


.. _plugins-inputmacro-intro:

Introdução
----------

Este plug-in permite que uma série de comandos sejam executados ao
pressionar um botão ou uma combinação deles. Isso pode ser útil para
pessoas com algum tipo de deficiência ou lesões que não conseguem
realizar algumas sequências. Também pode ser usado como uma forma
trapacear nos jogos que exigem sequências rápidas como os eventos de
corrida no *Track & Field* ou em minijogos como o *Daisu-Kiss*.

Para configurar o plug-in pressione :kbd:`Tab` durante a emulação,
selecione :guilabel:`Opções dos plug-ins` --> :guilabel:`Input Macros`.
Caso existam macros para o sistema atual elas estarão listadas na tela,

Selecione uma macro para editá-la ou escolha :guilabel:`Add macro` para
configurar uma nova entrada. Consulte :ref:`plugins-inputmacro-settings`
para obter detalhes de como criar a sua. Para excluir uma macro da lista
destaque-a no menu e pressionando a tecla :kbd:`Del`.

As macros são armazenadas na pasta **inputmacro** na mesma pasta do
executável do MAME ou o que estiver definido na opção
:ref:`homepath option <mame-commandline-homepath>`. Um mesmo arquivo
armazena diferentes macros para o mesmo sistema e mantém a mesma
nomenclatura do nome da ROM seguido da extensão ``.cfg``. Por exemplo,
as macros de entrada para Daisu-Kiss serão salvas no arquivo
``daiskiss.cfg`` dentro da pasta **inputmacro**. O conteúdo do arquivo
tem o formato JSON.

clique em :guilabel:`Add macro` para criar a sua macro.

.. _plugins-inputmacro-settings:

Editando as macros
------------------

Ambas as opções para adicionar um novo macro como para alterar as suas
configurações são as mesmas.

As macros são criadas numa sequência de *etapas*, opcionalmente cada
*etapa* aguarda por um determinado tempo (quadros), depois ativa a
próxima etapa e assim sucessivamente, dependendo do sistema, algumas
etapas precisam ter um intervalo entre eles (atraso), caso contrário o
sistema não consegue acompanhar o comando que foi passado. A macro
depois concluída tem a opção de não fazer nada (libera os controles),
pode ser continuada ou repetir a sequência novamente.

*	:guilabel:`Name` / :guilabel:`Nome`

		Define o nome da macro. Pressione :kbd:`Enter` no teclado ou o
		**botão 1** do controle para editar o nome que estiver ali ou
		:kbd:`Espaço` para limpar antes de inserir um novo nome. Use as
		teclas direcionais para mover o cursor e a tecla :kbd:`Esc` para
		cancelar a edição.

*	:guilabel:`Activation sequence` / :guilabel:`Ativação`

		Define uma tecla, um botão ou a combinação deles para ativar a
		macro. Tenha ciência que as entradas tradicionais continuam valendo,
		assim sendo, procure escolher os botões/teclas de atalho que não
		tenham nenhuma função dentro da emulação.

*	:guilabel:`On release` / :guilabel:`Ao soltar`

		Define o que deve acontecer quando a ativação da sequência for
		iniciada antes da conclusão da macro.
		:guilabel:`Stop immediately` interrompe a macro assim que ela
		for concluída. :guilabel:`Complete macro` a macro será
		processada até o último passo.

*	:guilabel:`When held` / :guilabel:`Enquanto estiver pressionado`

		Use para definir o que deve acontecer caso o botão ou a tecla
		de ativação seja mantida pressionada depois que a macro for
		concluída.

		* :guilabel:`Release`

			Executa a macro e não ativa novamente até que a ativação
			aconteça novamente.

		* :guilabel:`Prolong step <n>`

			O **n** é o número do último passo da macro, neste caso, o 
			passo final da macro permanece ativa até que a ativação
			seja liberada, por exemplo, caso o último passo seja um
			botão de tiro, ele vai funcionar como um turbo até que o
			botão seja liberado.

		* :guilabel:`Loop to <n>`

			o **n** é o número do passo que deseja que seja repetido,
			incluindo o atraso, caso a ativação se mantenha mantida após
			a conclusão do passo final.

Casa passo possui um atraso, duração e configuração da entrada:

	* :guilabel:`Delay` / :guilabel:`Atraso`

		Define a quantidade de quadros que se deve aguardar antes que a
		entrada seja ativada, durante o atraso nenhuma entrada é ativada
		pela macro. É possível redefinir o valor da configuração para
		zero ao pressionar a tecla :kbd:`Del`.

	* :guilabel:`Duration` / :guilabel:`Duração`

		Define a quantidade da duração dos quadros que devem ser
		mantidos pressionados antes de prosseguir para o próximo passo
		(ou completá-lo caso ele seja o último). É possível redefinir o
		valor da configuração para zero ao pressionar a tecla
		:kbd:`Del`.

	* :guilabel:`Input` / :guilabel:`Entrada`

		Define a entrada que será ativada no passo, no momento apenas as
		entradas digitais são compatíveis. Clique em
		:guilabel:`Add input` para escolher uma entrada de uma lista
		(esta opção aparece apenas depois de definir a primeira
		entrada). Caso o passo tenha diversas entradas, selecione uma
		delas use a tecla :kbd:`Del` para excluir (todas as etapas
		devem ter pelo menos mais de uma entrada, caso contrário não é
		possível excluir a única entrada existente na etapa).

	* :guilabel:`Delete step` / :guilabel:`Excluí etapa`

		Em macros com mais de uma etapa, use esta opção para excluí-la
		(esta opção não aparece se a macro possuir apenas uma etapa).
		Verifique antes se as configurações das opções
		:guilabel:`On release` e :guilabel:`When held` estão corretas
		**depois** de excluir uma etapa.

Para adicionar uma etapa, selecione
:guilabel:`Add step at position` /
:guilabel:`Adicione uma etapa na posição` (depois dos passos já
existentes), use as teclas direcionais :kbd:`Esquerda` / :kbd:`Direita`
ou clique com o mouse nas setas para definir a posição desejada para a
inserção do novo passo, pressione então :kbd:`Enter` (ou clique duas
vezes no item) para adicionar a nova etapa. Será solicitado que você
defina a primeira entrada para a nova etapa. Lembre-se de verificar as
configurações :guilabel:`On release` e :guilabel:`When held` depois de
adicionar as etapas. O item :guilabel:`Add step at position` só
aparecerá depois que for definido a primeira entrada para a etapa
inicialmente criada durante a criação de uma nova macro.

Ao criar uma nova macro há uma opção :guilabel:`Cancel` /
:guilabel:`Cancela` que muda para :guilabel:`Create` / :guilabel:`Cria`
depois de definir a ativação e a primeira entrada para a etapa
inicial. Selecione :guilabel:`Create` para finalizar a criação da macro
e retornar à lista de entradas para a macro. A nova macro será
adicionada no final da lista. Pressione a tecla :kbd:`Esc` ou selecione
:guilabel:`Cancel` antes de definir a ativação/entrada para retornar ao
menu anterior sem criar a nova macro.

Ao editar uma macro já existente, selecione :guilabel:`Done` ou
pressione a tecla :kbd:`Esc` para retornar à lista de macros de entrada,
as alterações já entram em vigor imediatamente.

.. _plugins-inputmacro-examples:

Macros de exemplo
-----------------

Turbo para Raiden
~~~~~~~~~~~~~~~~~

Permite a funcionalidade de turbo ao jogador 1 usando a barra de espaço.
O mesmo efeito pode ser obtido usando o :ref:`plugins-autofire`, porém,
o exemplo abaixo demonstra o uso de uma macro:

* **Name**: Turbo P1
* **Activation sequence**: Kbd Space
* **On release**: Stop immediately
* **When held**: Loop to step 2
* **Step 1**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 2
  * **Input 1**: P1 Button 1
* **Step 2**:

  * **Delay (frames)**: 4
  * **Duration (frames)**: 2
  * **Input 1**: P1 Button 1

A primeira etapa não possui nenhum atraso para que o disparo comece
assim que a barra de espaço seja pressionada. O segundo passo tem um
atraso suficiente para garantir que o jogo reconheça o botão que está
sendo pressionado e novamente liberado. O segundo passo também é
repetido desde que a barra de espaço se mantenha pressionada.

Trapaceando na corrida em Track & Field
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Isso permite que você corra segurando apenas um botão no *Track & Field*
da Konami. Isso tira a maior parte da destreza (e da diversão) do jogo:

* **Name**: Corrida J1
* **Activation sequence**: Kbd Shift
* **On release**: Stop immediately
* **When held**: Loop to step 2
* **Step 1**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 1
  * **Input 1**: P1 Button 1
* **Step 2**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: P1 Button 3
* **Step 3**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: P1 Button 1

Esta macro alterna rapidamente entre os botões 1 e 3 do jogo fazendo com
que você consiga correr no jogo.

Street Fighter II
~~~~~~~~~~~~~~~~~

Esta macro permite que você faça o *Shoryuken* (*Dragon punch*) ao
pressionar a tecla :kbd:`M` com o jogador 1 estando do lado esquerdo da
tela, não se esqueça de clicar em :guilabel:`Done` ao concluir:

* **Name**: J1 Shoryuken SF
* **Activation sequence**: Kbd M
* **On release**: Complete macro
* **When held**: Release
* **Step 1**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 1
  * **Input 1**: J1 Direita
* **Step 2**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: J1 Baixo
* **Step 3**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 1
  * **Input 1**: J1 Baixo
  * **Input 2**: J1 Direita
  * **Input 3**: P1 Jab Punch

A macro realiza o golpe e caso mantenha a tecla pressionada, nada
acontece.

Esta é a macro para o *Hadouken* com *soco fraco* ao pressionar a tecla
:kbd:`N` com o jogador 1 estando do lado esquerdo da tela, não se
esqueça de clicar em :guilabel:`Done` ao concluir:

* **Name**: J1 Hadouken SF
* **Activation sequence**: Kbd N
* **On release**: Complete macro
* **When held**: Release
* **Step 1**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 1
  * **Input 1**: J1 Baixo
* **Step 2**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: J1 Direita
  * **Input 2**: J1 Baixo
* **Step 3**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 1
  * **Input 1**: J1 Direita
  * **Input 2**: P1 Strong Punch

Esta macro é utilizada pelo personagem **Guile** para soltar o *Sonic
Boom* com *soco médio* ao pressionar a tecla :kbd:`B` com o jogador 1
estando do lado esquerdo da tela, não se esqueça de clicar em
:guilabel:`Done` ao concluir:

* **Name**: J1 Sonic Boom
* **Activation sequence**: Kbd B
* **On release**: Complete macro
* **When held**: Release
* **Step 1**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 60
  * **Input 1**: J1 Esquerda
* **Step 2**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: J1 Direita
* **Step 3**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 1
  * **Input 1**: J1 Direita
  * **Input 2**: P1 Strong Punch

Esta macro faz o tal "*facão do Guile*" (Flash Kick) com *chute fraco*
ao pressionar a tecla :kbd:`V` com o jogador 1 estando do lado esquerdo
da tela, não se esqueça de clicar em :guilabel:`Done` ao concluir:

* **Name**: J1 Flash Kick
* **Activation sequence**: Kbd V
* **On release**: Complete macro
* **When held**: Release
* **Step 1**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 60
  * **Input 1**: J1 Baixo
* **Step 2**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: J1 Cima
  * **Input 2**: P1 Short Kick

Esta macro é utilizada pelo personagem **Zanguief** para fazer o nosso
conhecido "*Pilão Giratório*", também conhecido como *Spinning
Piledriver* e *Screw Pile Driver* com *soco fraco* ao pressionar a tecla
:kbd:`C` com o jogador 1 estando do lado esquerdo da tela, não se
esqueça de clicar em :guilabel:`Done` ao concluir:

* **Name**: J1 Screw Pile Driver
* **Activation sequence**: Kbd C
* **On release**: Complete macro
* **When held**: Release
* **Step 1**:

  * **Delay (frames)**: 0
  * **Duration (frames)**: 1
  * **Input 1**: J1 Direita
* **Step 2**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: J1 Baixo
* **Step 3**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: J1 Esquerda
* **Step 4**:

  * **Delay (frames)**: 1
  * **Duration (frames)**: 1
  * **Input 1**: J1 Cima
  * **Input 2**: P1 Strong Punch
