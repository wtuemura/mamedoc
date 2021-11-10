.. raw:: latex

	\clearpage

.. _ctrlrcfg:

Os arquivos de configuração para o controle
===========================================

.. contents:: :local:

.. _ctrlrcfg-intro:

Introdução
----------

Os arquivos de configuração para o controle podem ser usados para
alterar as configurações da entrada predefinida do MAME. Tais arquivos
de configuração podem ser usados com um dispositivo de entrada
fornecendo padrões mais adequados, ou usados como perfis que possam ser
selecionados para diferentes situações. O MAME inclui alguns exemplos de
arquivos de configuração na pasta **ctrlr** desenvolvidos para fornecer
padrões úteis para certos controles do tipo arcade.

Apesar da extensão ``.cfg``, estes arquivos estão no formato XML. O MAME
procura por tais arquivos nos diretórios definidos com a opção
``ctrlrpath``. Um arquivo de configuração será selecionado quando a
opção ``ctrlr`` seguido pelo nome nome do arquivo sem a extensão
``.cfg``, exemplo::

	ctrlr scorpionxg

Isso faz com que o MAME use o arquivo **ctlrl\\scorpionxg.cfg**.

Haverá um erro caso o MAME identifique que o arquivo de configuração
informado não exista ou caso o seu conteúdo não tenha nenhuma seção
aplicável ao sistema que está sendo emulado.

A utilização dos símbolos ou dos *tokens* de entrada variam conforme a
aplicação. A precisão dos valores disponíveis e os seus significados
dependem da versão exata do MAME que está sendo usado, dos dispositivos
conectados na entrada, dos módulos do provedor da entrada selecionada
(as opções ``keyboardprovider``, ``mouseprovider``, ``lightgunprovider``
e ``joystickprovider``) e possivelmente das outras configurações.


.. raw:: latex

	\clearpage

.. _ctrlrcfg-structure:

Estrutura básica
----------------

A sua estrutura segue um formato similar ao formato usado pela
configuração do sistema que o MAME usa para salvar coisas como as
configurações da entrada e dados da contabilidade da máquina.
Neste exemplo temos a estrutura geral de um arquivo de configuração de
um controle:

.. code-block:: XML

    <?xml version="1.0"?>
    <mameconfig version="10">
        <system name="default">
            <input>
                <!-- as configurações que afetam todos os sistemas emulados vão aqui -->
            </input>
        </system>
        <system name="neogeo">
            <input>
                <!-- as configurações que afetam o neogeo e os seus clones vão aqui -->
            </input>
        </system>
        <system name="intellec4.cpp">
            <input>
                <!-- as configurações que afetam todo os sistemas definidos no driver intellec4.cpp vão aqui -->
            </input>
        </system>
    </mameconfig>

A base de um arquivo de configuração do controle deve ser um elemento
``mameconfig``, com um atributo da ``version`` que especifica a versão do
formato desta configuração (atualmente ``10`` - O MAME não carregará um
arquivo usando qualquer outra versão). O elemento ``mameconfig`` contém
um ou mais elementos do sistema, cada qual com um nome do atributo
especificando os sistemas aos quais eles se aplicam. Cada elemento
``system`` contém um elemento ``input`` que contém o ``remap`` atual e os
elementos de configuração da porta ``port`` que serão descritos mais
adiante.

Ao iniciar a emulação de um sistema o MAME aplicará a configuração dos
elementos ``system`` onde o valor do atributo ``name`` atende a um dos
seguintes critérios:

* Caso o atributo ``name`` tenha o valor ``default``, ele sempre será
  aplicado (isso incluí os menus de seleção do sistema/software).
* Caso o atributo ``name`` tenha o mesmo nome do sistema, das suas
  variantes relacionadas ao sistema ou o nome encurtado da BIOS do
  sistema (caso seja aplicável).
* Caso o atributo ``name`` tenha o mesmo nome do arquivo fonte do
  driver.

Para a máquina "*DaeJeon! SanJeon SuJeon (AJTUE 990412 V1.000)*" por
exemplo, os elementos ``system`` serão aplicados caso o seu atributo
``name`` tenha o valor ``default`` (se aplica a todos os sistemas),
``sajeon`` (um nome encurtado do próprio sistema), ``sasissu`` (um nome
encurtado de uma outra versão da mesma máquina), ``stvbios`` (um nome
encurtado do nome da BIOS do sistema) ou ``stv.cpp`` (nome do arquivo
fonte/driver onde o sistema foi definido).

Num outro exemplo, será aplicado aos sistemas "*The Invaders*",
"*Super Invader Attack*" (um bootleg do The Invaders) e "*Dodgem*" caso
um elemento ``system`` onde o atributo ``name`` tenha o valor
``zac2650.cpp``.

Os elementos ``system`` são aplicados na ordem em que aparecem no
arquivo de configuração. As configurações dos elementos que aparecem ao
final do arquivo podem modificar ou alterar as configurações dos
elementos anteriores. Dentro de um elemento ``system``, os elementos
``remap`` são aplicados antes dos elementos ``port``.


.. raw:: latex

	\clearpage

.. _ctrlrcfg-substitute:

Remapeando os controles já predefinidos
---------------------------------------

É possível usar o emelento ``remap`` para substituir uma entrada do host
para um outro qualquer na configuração padrão do MAME. O exemplo abaixo
substitui as teclas no teclado numérico para a teclas direcionais do
cursor:

.. code-block:: XML

    <input>
        <remap origcode="KEYCODE_UP" newcode="KEYCODE_8PAD" />
        <remap origcode="KEYCODE_DOWN" newcode="KEYCODE_2PAD" />
        <remap origcode="KEYCODE_LEFT" newcode="KEYCODE_4PAD" />
        <remap origcode="KEYCODE_RIGHT" newcode="KEYCODE_6PAD" />
    </input>

O atributo ``origcode`` define o *token* para a entrada do host que será
substituído, o atributo ``newcode`` define o *token* para a entrada do
host que será substituído. Neste caso, são as atribuições que usa o
cursor para cima, para baixo e as setas para a esquerda e para a
direita, elas serão substituídas pelas teclas numéricas **8**, **2**,
**4** e **6** do teclado numérico.

Observe que as substituições indicadas usando os elementos ``remap``
se aplicam apenas às entradas que usam a atribuição padrão do MAME para
o tipo do controle. Ou seja, elas só se aplicam às atribuições padrão
para os tipos de controle definidos no menu "**Entradas (gerais)**".
Eles não se aplicam às atribuições padrão das entradas definidas nas
definições das portas de E/S do driver/dispositivo (usando a macro
``PORT_CODE``).

O MAME aplica os elementos ``remap`` encontrados dentro de qualquer
elemento ``system`` que seja aplicável.


.. _ctrlrcfg-typeoverride:

Substituindo os controles predefinidos
--------------------------------------

Utilize os elementos ``port`` com os atributos ``type`` sem os atributos
``tag`` para substituir as definições de entrada padrão do host para os
controles.

.. code-block:: XML

    <input>
        <port type="UI_CONFIGURE">
            <newseq type="standard">KEYCODE_TAB OR KEYCODE_1 KEYCODE_5</newseq>
        </port>
        <port type="UI_CANCEL">
            <newseq type="standard">KEYCODE_ESC OR KEYCODE_2 KEYCODE_6</newseq>
        </port>
        <port type="P1_BUTTON1">
            <newseq type="standard">KEYCODE_C OR JOYCODE_1_BUTTON1</newseq>
        </port>
        <port type="P1_BUTTON2">
            <newseq type="standard">KEYCODE_LSHIFT OR JOYCODE_1_BUTTON2</newseq>
        </port>
        <port type="P1_BUTTON3">
            <newseq type="standard">KEYCODE_Z OR JOYCODE_1_BUTTON3</newseq>
        </port>
        <port type="P1_BUTTON4">
            <newseq type="standard">KEYCODE_X OR JOYCODE_1_BUTTON4</newseq>
        </port>
    </input>

.. raw:: latex

	\clearpage

A configuração acima define as seguintes atribuições para as entradas:

* **Config Menu** (Interface do usuário)

	Tecla **Tab**, ou pressionando as teclas 1 e 2 simultaneamente

* **UI Cancel** (Interface do usuário)

	Tecla **ESC**, ou pressionando as teclas 2 e 6 simultaneamente

* **P1 Button 1** (Controles do jogador 1)

	Tecla **C**, ou o botão 1 do joystick 1

* **P1 Button 2** (Controles do jogador 1)

	Tecla **Shift** esquerda, ou o botão 2 do joystick 1

* **P1 Button 3** (Controles do jogador 1)

	Tecla **Z**, ou o botão 3 do joystick 1

* **P1 Button 4** (Controles do jogador 1)

	Tecla **X**, ou o botão 4 do joystick 1

Repare que isto será aplicado somente às entradas do controle do MAME.
Ou seja, os elementos ``port`` sem os atributos ``tag`` substituem
apenas as atribuições predefinidas no menu "**Entradas (gerais)**". Eles
não substituem as atribuições das entradas definidas nas definições
das portas de E/S do driver/dispositivo (usando a macro ``PORT_CODE``).

O MAME aplica os elementos ``port`` sem os atributos ``tag`` encontrados
dentro de qualquer elemento ``system``.


.. _ctrlrcfg-ctrloverride:

Substituindo a configuração predefinida para uma tecla específica
-----------------------------------------------------------------

Utilize os elementos ``port`` com os atributos ``tag``, ``type``,
``mask`` e ``defvalue`` para substituir os valores predefinidos para
controles específicos. Estes elementos ``port`` devem ser definidos
dentro dos elementos ``system`` para que sejam apenas aplicados em
determinados sistemas ou o código-fonte do driver (eles não devem
existir dentro dos elementos ``system`` onde o atributo ``name`` tenha
o valor ``default``). A atribuição da entrada predefinida do host pode
ser substituída assim como também é possível alternar as configurações
dos controles digitais.

Os atributos ``tag``, ``type``, ``mask`` and ``defvalue`` são usados
para identificar a entrada em questão. É possível encontrar os valores
usados para uma determinada entrada do host alternando a sua atribuição,
encerrando o MAME e verificando os valores no arquivo de configuração do
sistema. Observe que não há garantias que estes valores sejam os mesmos
e podem variar entre as versões do MAME.

Abaixo um exemplo que substitui as entradas predefinidas para o
**280-ZZZAP**:

.. code-block:: XML

    <system name="280zzzap">
        <input>
            <port tag=":IN0" type="P1_BUTTON2" mask="16" defvalue="0" toggle="no" />
            <port tag=":IN1" type="P1_PADDLE" mask="255" defvalue="127">
                <newseq type="increment">KEYCODE_K</newseq>
                <newseq type="decrement">KEYCODE_J</newseq>
            </port>
        </input>
    </system>

Esta configuração define as entradas para o esterçamento esquerdo e
direito para as teclas **K** e **J** respectivamente, desativando também
as configurações do câmbio para a entrada da troca de marchas.
