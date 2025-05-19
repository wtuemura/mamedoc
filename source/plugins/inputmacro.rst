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
selecione :guilabel:`Opções dos plug-ins` --> :guilabel:`Macros`.
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

clique em :guilabel:`Nova macro` para criar a sua macro.

.. _plugins-inputmacro-settings:

Editando as macros
------------------

Ambas as opções para adicionar uma nova macro como para alterar as suas
configurações são as mesmas.

As macros são criadas numa sequência de *etapas*, opcionalmente cada
*etapa* aguarda por um determinado tempo (quadros), depois ativa a
próxima etapa e assim sucessivamente, dependendo do sistema, algumas
etapas precisam ter um intervalo entre eles (atraso), caso contrário o
sistema não consegue acompanhar o comando que foi passado. A macro
depois concluída tem a opção de não fazer nada (libera os controles),
pode ser continuada ou repetir a sequência novamente.

*	:guilabel:`Nome`

		Define o nome da macro. Pressione :kbd:`Enter` no teclado ou o
		**botão 1** do controle para editar o nome que estiver ali ou
		:kbd:`Espaço` para limpar antes de inserir um novo nome. Use as
		teclas direcionais para mover o cursor e a tecla :kbd:`Esc`
		(*UI_Back*)para cancelar a edição.

*	:guilabel:`Ativação`

		Define uma tecla, um botão ou a combinação deles para ativar a
		macro. Tenha ciência que as entradas tradicionais continuam valendo,
		assim sendo, procure escolher os botões/teclas de atalho que não
		tenham nenhuma função dentro da emulação.

*	:guilabel:`Ao soltar`

		Define o que deve acontecer quando a ativação da sequência for
		iniciada antes da conclusão da macro.
		:guilabel:`Pare` interrompe a macro assim que ela
		terminar. :guilabel:`Conclua a macro` a macro será
		processada até o última etapa.

*	:guilabel:`Enquanto estiver pressionado`

		Use para definir o que deve acontecer caso o botão ou a tecla
		de ativação seja mantida pressionada depois que a macro for
		concluída.

		* :guilabel:`Libera`

			Executa a macro e não ativa novamente até que a ativação
			aconteça novamente.

		* :guilabel:`Mantenha a etapa <n> ativa`

			O **n** é o número do último passo da macro, neste caso, o 
			passo final da macro permanece ativa até que a ativação
			seja liberada, por exemplo, caso o último passo seja um
			botão de tiro, ele vai funcionar como um turbo até que o
			botão seja liberado.

		* :guilabel:`Repita até a etapa <n>`

			o **n** é o número do passo que deseja que seja repetido,
			incluindo o atraso, caso a ativação se mantenha mantida após
			a conclusão do passo final.

Casa passo possui um atraso, duração e configuração da entrada:

	* :guilabel:`Atraso (quadros)`

		Define a quantidade de quadros que se deve aguardar antes que a
		ação seja feita, ou seja, durante o atraso nenhuma entrada é
		ativada. É possível redefinir o valor da configuração para
		zero ao pressionar a tecla :kbd:`Del`.

	* :guilabel:`Duração (quadros)`

		Define a quantidade de tempo (quadros) que o botão ou direcional
		deve ser mantido pressionado antes de prosseguir para o próximo
		passo (ou completá-lo caso ele seja o último). Alguns jogos
		registram o comando logo nos primeiros quadros, já outros
		precisam de 3 ou mais quadros para registrar a ação. É possível
		redefinir o valor da configuração para zero ao pressionar a
		tecla :kbd:`Del`.

	* :guilabel:`Entrada`

		Define a entrada que será ativada no passo, no momento apenas as
		entradas digitais são compatíveis. Clique em
		:guilabel:`Nova entrada` para escolher uma entrada de uma
		lista (esta opção aparece apenas depois de definir a primeira
		entrada). Caso o passo tenha diversas entradas, selecione uma
		delas use a tecla :kbd:`Del` para excluir (todas as etapas
		devem ter pelo menos mais de uma entrada, caso contrário não é
		possível excluir a única entrada existente na etapa).

	* :guilabel:`Excluí etapa`

		Em macros com mais de uma etapa, use esta opção para excluí-la
		(esta opção não aparece se a macro possuir apenas uma etapa).
		Verifique antes se as configurações das opções
		:guilabel:`Ao soltar` e :guilabel:`Enquanto estiver pressionado`
		estão corretas **depois** de excluir uma etapa.

Para adicionar uma etapa, selecione
:guilabel:`Adiciona uma etapa na posição` (depois dos passos já
existentes), use as teclas direcionais :kbd:`Esquerda` / :kbd:`Direita`
ou clique com o mouse nas setas para definir a posição desejada para a
inserção do novo passo, pressione então :kbd:`Enter` (ou clique duas
vezes no item) para adicionar a nova etapa. Será solicitado que você
defina a primeira entrada para a nova etapa. Lembre-se de verificar as
configurações :guilabel:`Ao soltar` e :guilabel:`Enquanto estiver
pressionado` depois de adicionar as etapas. O item :guilabel:`Adiciona
uma etapa na posição` só aparecerá depois que for definido a primeira
entrada para a etapa inicialmente criada durante a criação de uma nova
macro.

Ao criar uma nova macro há uma opção :guilabel:`Cancela` que muda para
:guilabel:`Cria` depois de definir a ativação e a primeira entrada para
a etapa inicial. Selecione :guilabel:`Cria` para finalizar a criação da
macro e retornar à lista de entradas para a macro. A nova macro será
adicionada no final da lista. Pressione a tecla :kbd:`Esc` ou selecione
:guilabel:`Cancela` antes de definir a ativação/entrada para retornar ao
menu anterior sem criar a nova macro.

Ao editar uma macro já existente, selecione :guilabel:`Feito` ou
pressione a tecla :kbd:`Esc` para retornar à lista de macros de entrada,
as alterações já entram em vigor imediatamente.

.. _plugins-inputmacro-examples:

Exemplos de macros
------------------

.. _plugins-inputmacro-baddudes:

Bad Dudes vs. Dragonninja
~~~~~~~~~~~~~~~~~~~~~~~~~

Esta macro faz o personagem dar um chute giratório, escolha o botão de
atalho que achar mais apropriado para o seu controle.

* **Nome**: :guilabel:`Giratória`
* **Combinação de ativação**: Tecla :kbd:`X`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`4`
  * **Entrada 1**: :guilabel:`P1 Jump`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 Jump`
  * **Entrada 2**: :guilabel:`P1 Atack`


.. _plugins-inputmacro-raiden:

Raiden
~~~~~~

Permite a funcionalidade de turbo ao jogador 1 usando a barra de espaço.
O mesmo efeito pode ser obtido usando o :ref:`plugins-autofire`, porém,
o exemplo abaixo demonstra o uso de uma macro:

* **Nome**: :guilabel:`Turbo P1`
* **Combinação de ativação**: Tecla :kbd:`Espaço`
* **Ao soltar**: :guilabel:`Pare`
* **Enquanto estiver pressionado**: :guilabel:`Repita até a etapa 2`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`Jogador 1 botão 1`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`4`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`Jogador 1 botão 1`

A primeira etapa não possui nenhum atraso para que o disparo comece
assim que a barra de espaço seja pressionada. O segundo passo tem um
atraso suficiente para garantir que o jogo reconheça o botão que está
sendo pressionado e novamente liberado. O segundo passo também é
repetido desde que a barra de espaço se mantenha pressionada.


.. _plugins-inputmacro-sf2:

Street Fighter II
~~~~~~~~~~~~~~~~~

Esta macro permite que você faça o *Shoryuken* (*Dragon punch*) ao
pressionar a tecla :kbd:`M` com o jogador 1 estando do lado esquerdo da
tela, não se esqueça de clicar em :guilabel:`Feito` ao concluir:

.. note::

	A partir da versão **0.237** os direcionais e muitas outras opções
	já estão traduzidas para o nosso idioma, caso as opções dos
	direcionais estejam diferentes, atualize a sua tradução com a versão
	compatível com esta documentação baixando o arquivo
	`strings.mo <https://github.com/wtuemura/mamedoc/tree/master/language/Portuguese_Brazil>`_
	e substituindo o arquivo que está na pasta
	**language\\Portuguese_Brazil**.


Shoryuken
^^^^^^^^^

|emfc| **esquerda** da tela:

* **Nome**: :guilabel:`Jogador 1 Shoryuken Esq`
* **Combinação de ativação**: Tecla :kbd:`M`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
  * **Entrada 2**: :guilabel:`P1 direita`
  * **Entrada 3**: :guilabel:`P1 Jab Punch`

|emfc| **direita** da tela:

* **Nome**: :guilabel:`Jogador 1 Shoryuken Dir`
* **Combinação de ativação**: Tecla :kbd:`M`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
  * **Entrada 2**: :guilabel:`P1 esquerda`
  * **Entrada 3**: :guilabel:`P1 Jab Punch`


Hadouken
^^^^^^^^

Esta é a macro para o *Hadouken* com *soco fraco* ao pressionar a tecla
:kbd:`N` com o jogador 1 estando do lado esquerdo da tela, não se
esqueça de clicar em :guilabel:`Feito` ao concluir.

|emfc| **esquerda** da tela:

* **Nome**: :guilabel:`Jogador 1 Hadouken Esq`
* **Combinação de ativação**: Tecla :kbd:`N`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
  * **Entrada 2**: :guilabel:`P1 direita`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`Jogador 1 direita`
  * **Entrada 2**: :guilabel:`P1 Strong Punch`

|emfc| **direita** da tela:

* **Nome**: :guilabel:`Jogador 1 Hadouken Dir`
* **Combinação de ativação**: Tecla :kbd:`N`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
  * **Entrada 2**: :guilabel:`P1 esquerda`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 esquerda`
  * **Entrada 2**: :guilabel:`P1 Strong Punch`


Sonic Boom
^^^^^^^^^^

Esta macro é utilizada pelo personagem **Guile** para soltar o *Sonic
Boom* com *soco médio* ao pressionar a tecla :kbd:`B` com o jogador 1
estando do lado esquerdo da tela, não se esqueça de clicar em
:guilabel:`Feito` ao concluir.

|emfc| **esquerda**:

* **Nome**: :guilabel:`Jogador 1 Sonic Boom Esq`
* **Combinação de ativação**: Tecla :kbd:`B`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`Jogador 1 direita`
  * **Entrada 2**: :guilabel:`P1 Strong Punch`

|emfc| **direita** da tela:

* **Nome**: :guilabel:`Jogador 1 Sonic Boom Dir`
* **Combinação de ativação**: Tecla :kbd:`B`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
  * **Entrada 2**: :guilabel:`P1 Strong Punch`


Flash Kick (facão)
^^^^^^^^^^^^^^^^^^

Esta macro faz o tal "*facão do Guile*" (*Flash Kick*) com *chute fraco*
ao pressionar a tecla :kbd:`V` com o jogador 1 estando do lado esquerdo
da tela, não se esqueça de clicar em :guilabel:`Feito` ao concluir.

* **Nome**: :guilabel:`Jogador 1 Flash Kick`
* **Combinação de ativação**: Tecla :kbd:`V`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 cima`
  * **Entrada 2**: :guilabel:`P1 Short Kick`


Spinning Piledriver (pilão giratório)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Esta macro é utilizada pelo personagem **Zanguief** para fazer o nosso
conhecido "*Pilão Giratório*", também conhecido como *Spinning
Piledriver* e *Screw Pile Driver* com *soco médio* ao pressionar a tecla
:kbd:`C` com o jogador 1 estando do lado esquerdo da tela, não se
esqueça de clicar em :guilabel:`Feito` ao concluir.

Essa macro funciona com o personagem em qualquer lado da tela:

* **Nome**: :guilabel:`Jogador 1 Screw Pile Driver`
* **Combinação de ativação**: Tecla :kbd:`C`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`P1 cima`
  * **Entrada 2**: :guilabel:`P1 Strong Punch`


.. _plugins-inputmacro-ssf2tu:

Super Street Fighter II Turbo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. tip:: Essa macro funciona com a versão americana ou a versão japonesa
   (**Super Street Fighter II X**).

Akuma
^^^^^

Execute essa macro na tela de seleção de personagens para jogar com o
Akuma, pressione a tecla :kbd:`N` para ativar.

* **Nome**: :guilabel:`Akuma`
* **Combinação de ativação**: Tecla :kbd:`N`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 10**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 11**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 12**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 13**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 14**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 15**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 16**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 17**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 18**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`Inicia jogador 1`
* **Etapa 19**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`30`
  * **Entrada 1**: :guilabel:`P1 botão 1`
  * **Entrada 2**: :guilabel:`P1 botão 2`
  * **Entrada 3**: :guilabel:`P1 botão 3`


.. raw:: latex

	\clearpage


.. _plugins-inputmacro-hsf2:

Hyper Street Fighter II: The Aniversary Edition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Akuma
^^^^^

Selecione a velocidade e o modo desejado, use macro para jogar com o
Akuma quando estiver na tela de seleção de personagens, pressione a
tecla :kbd:`N` para ativar.

* **Nome**: :guilabel:`Akuma`
* **Combinação de ativação**: Tecla :kbd:`N`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 10**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 11**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 12**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 13**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 14**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 15**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 16**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 17**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`60`
  * **Entrada 1**: :guilabel:`Aumenta o volume`
* **Etapa 18**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`2`
  * **Entrada 1**: :guilabel:`Inicia jogador 1`
* **Etapa 19**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`30`
  * **Entrada 1**: :guilabel:`P1 botão 1`
  * **Entrada 2**: :guilabel:`P1 botão 2`
  * **Entrada 3**: :guilabel:`P1 botão 3`


.. _plugins-inputmacro-svc:

SNK vs. Capcom - SVC Chaos
~~~~~~~~~~~~~~~~~~~~~~~~~~

Execute esta macro na tela de seleção de personagens, ao pressionar uma
das teclas selecionadas um comando especial será executado para
selecionar personagens especiais. Inicie o jogo normalmente, quando
estiver na tela de seleção de personagens, mantenha a tecla :kbd:`1`
pressionada (ou a tecla configurada para iniciar o jogador 1) e escolha
uma das teclas do **teclado numérico** abaixo para executar o comando
(à direita do teclado) mas, você pode configurar as teclas que quiser
desde que não entre em conflito com as :ref:`teclas já predefinidas
<default-keys>`.

.. note:: Os personagens **Shin Akuma** e **Serious Mr. Karate** apenas
   podem ser selecionados na versão AES do Neo Geo, consulte o capítulo
   :ref:`advanced-tricks-nvram`.

.. note:: Caso não queira fazer a configuração abaixo manualmente, ela
   pode ser baixada `aqui`_. Copie o conteúdo e cole num editor de
   texto, salve ele como **svc.cfg** na pasta **inputmacro**.

**Fonte**: `Strategywiki`_.

.. tabularcolumns:: |L|C|C|C|C|C|C|C|

.. list-table:: Lista dos personagens
    :header-rows: 0
    :stub-columns: 0
    :widths: auto

    * - **0**
      - Dan Hibiki
    * - **1**
      - Leopold Goenitz
    * - **2**
      - Demitri Maximoff
    * - **3**
      - Geese Howard
    * - **4**
      - Violent Ken
    * - **5**
      - Orochi Iori
    * - **6**
      - Zero
    * - **7**
      - Mars People
    * - **8**
      - Shin Akuma *
    * - **9**
      - Serious Mr. Karate *


Dan Hibiki
^^^^^^^^^^

* **Nome**: :guilabel:`Dan Hibiki`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_0`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Leopold Goenitz
^^^^^^^^^^^^^^^

* **Nome**: :guilabel:`Goenitz`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_1`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Demitri Maximoff
^^^^^^^^^^^^^^^^

* **Nome**: :guilabel:`Demitri Maximoff`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_2`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Geese Howard
^^^^^^^^^^^^

* **Nome**: :guilabel:`Geese Howard`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_3`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Violent Ken
^^^^^^^^^^^

* **Nome**: :guilabel:`Violent Ken`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_4`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Orochi Iori
^^^^^^^^^^^

* **Nome**: :guilabel:`Orochi Iori`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_5`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Zero
^^^^

* **Nome**: :guilabel:`Zero`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_6`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 10**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 11**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Mars People
^^^^^^^^^^^

* **Nome**: :guilabel:`Mars People`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_7`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 10**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 11**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Shin Akuma
^^^^^^^^^^

* **Nome**: :guilabel:`Shin Akuma`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_8`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 10**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 11**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 12**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 13**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


Serious Mr. Karate
^^^^^^^^^^^^^^^^^^

* **Nome**: :guilabel:`Serious Mr. Karate`
* **Combinação de ativação**: Tecla :kbd:`KEYPAD_9`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 5**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 6**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 7**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 baixo`
* **Etapa 8**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 9**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 cima`
* **Etapa 10**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 esquerda`
* **Etapa 11**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 12**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 direita`
* **Etapa 13**:

  * **Atraso (quadros)**: :guilabel:`3`
  * **Duração (quadros)**: :guilabel:`3`
  * **Entrada 1**: :guilabel:`P1 A`


.. _plugins-inputmacro-trackfld:

Track & Field
~~~~~~~~~~~~~

Isso permite que você corra segurando apenas um botão no *Track & Field*
da Konami. Isso tira a maior parte da destreza (e da diversão) do jogo:

* **Nome**: :guilabel:`Corrida J1`
* **Combinação de ativação**: Tecla :kbd:`Shift`
* **Ao soltar**: :guilabel:`Pare`
* **Enquanto estiver pressionado**: :guilabel:`Repita até a etapa 2`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`Jogador 1 botão 1`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`Jogador 1 botão 3`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`Jogador 1 botão 1`

Esta macro alterna rapidamente entre os botões 1 e 3 do jogo fazendo com
que você consiga correr no jogo.


.. _plugins-inputmacro-trstar:

Top Ranking Stars
~~~~~~~~~~~~~~~~~

Esta macro é um exemplo de como ativar golpes especiais em jogos que
precisam que os comandos sejam mantidos pressionados por mais tempo para
que o comando seja corretamente identificado e executado. O comando é
para o especial "*Stardust*" do personagem *Shouichi Kanou*. Escolha o
botão de atalho que achar mais apropriado para o seu controle.

* **Nome**: :guilabel:`Stardust`
* **Combinação de ativação**: Tecla :kbd:`S`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`4`
  * **Entrada 1**: :guilabel:`Jogador 1 baixo`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`4`
  * **Entrada 1**: :guilabel:`Jogador 1 baixo`
  * **Entrada 2**: :guilabel:`Jogador 1 direita`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`4`
  * **Entrada 1**: :guilabel:`Jogador 1 direita`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`Jogador 1 botão 2`

A macro abaixo serve para o segundo especial do mesmo personagem.

* **Nome**: :guilabel:`Stardust 2`
* **Combinação de ativação**: Tecla :kbd:`A`
* **Ao soltar**: :guilabel:`Conclua a macro`
* **Enquanto estiver pressionado**: :guilabel:`Libera`
* **Etapa 1**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`4`
  * **Entrada 1**: :guilabel:`Jogador 1 cima`
* **Etapa 2**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`4`
  * **Entrada 1**: :guilabel:`Jogador 1 cima`
  * **Entrada 2**: :guilabel:`Jogador 1 direita`
* **Etapa 3**:

  * **Atraso (quadros)**: :guilabel:`1`
  * **Duração (quadros)**: :guilabel:`4`
  * **Entrada 1**: :guilabel:`Jogador 1 direita`
* **Etapa 4**:

  * **Atraso (quadros)**: :guilabel:`0`
  * **Duração (quadros)**: :guilabel:`1`
  * **Entrada 1**: :guilabel:`Jogador 1 botão 3`

.. |emfc| replace:: Essa macro funciona com o personagem à
.. _aqui: https://pastebin.com/b0UbTwBH
.. _Strategywiki: https://strategywiki.org/wiki/SVC_Chaos:_SNK_vs._Capcom/Secrets
