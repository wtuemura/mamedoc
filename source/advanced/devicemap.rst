
.. raw:: latex

	\clearpage


.. _devicemap:

ID fixo para os controles
=========================

É predefinido que o MAME não atribua números fixos (IDs) para os
dispositivos da entrada. Por exemplo, o driver de um controle
"*joystick 1*" pode ser atribuído inicialmente para ``Joy 1``, porém,
depois de uma reinicialização o mesmo controle pode aparecer como
``Joy 3``.

O MAME enumera os dispositivos conectados e os atribui IDs com base na
ordem da enumeração do controlador. Os fatores que podem causar a
alteração destas IDs são, conectar ou desconectar os controles ou
dispositivos USB, alterar as portas ou "*hubs*", assim como até mesmo a
reinicialização do computador. Tais números são impossíveis de se
prever.

É aqui onde a configuração do ``mapdevice`` entra em ação. Ao adicionar
esta configuração ao
:ref:`arquivo de configuração do controle <ctrlrcfg>`, é possível
atribuir uma identificação fixa para o controlador do dispositivo,
garantindo ao MAME que o dispositivo definido sempre seja mapeado com a
mesma identificação.


.. _devicemap-mapdevice:

Usando o mapdevice
------------------

O elemento XML ``mapdevice`` é adicionado na entrada do elemento XML do
arquivo de configuração do controle. Dois atributos são necessários,
``device`` e ``controller``. Observe que os elementos ``mapdevice``
apenas surtem efeito no arquivo de configuração do controle (definido
através da opção :ref:`-ctrlr <mame-commandline-ctrlr>`). Eles são
ignorados nos arquivos de configuração do sistema e no arquivo da
configuração padrão.

O atributo ``device`` determina a ID do dispositivo correspondente da
entrada. Também pode ser uma *substring* da ID do dispositivo. Para
obter a ID do dispositivo da entrada, selecione-o no menu
:ref:`menus-inputdevices`:

*	Inicie a emulação de um sistema qualquer (``mame sf2`` por exemplo).
*	Pressione :kbd:`Tab` e selecione :guilabel:`Configurações da entrada`.
*	Faça um clique duplo em :guilabel:`Dispositivos de entrada`.
*	Clique em qualquer um dos itens apresentados.
*	Faça um clique duplo em :guilabel:`Copia a ID do dispositivo` para
	que a ID seja copiada para a área de transferência.

Também será possível ver as IDs dos dispositivos da entrada através do
prompt de comando ou do terminal ao ativar o modo loquaz através da
opção ``-verbose`` (mais detalhes
:ref:`logo abaixo <devicemap-listdevice>`). O formato das IDs dos
dispositivos depende do tipo do dispositivo, do controlador do
dispositivo (*driver*), do módulo do provedor da entrada selecionada e
do sistema operacional. A ID dos seus dispositivo de entrada podem ser
muito diferentes dos exemplos mostrados aqui.

O atributo ``controller`` atribui o token para o tipo do dispositivo da
entrada (``JOYCODE``, ``GUNCODE``, ``MOUSECODE`` por exemplo) e o número
para atribuir ao dispositivo separados por um sublinhado. A numeração
começa a partir do ``1``, por exemplo, o *token* para o primeiro
controle será ``JOYCODE_1``, ``JOYCODE_2`` e assim sucessivamente.


.. raw:: latex

	\clearpage


Exemplo de configuração 
-----------------------

.. code-block:: xml

	<!-- Veja uma versão deste arquivo aqui https://pastebin.com/fTbEsANJ -->
	<mameconfig version="10">
	<system name="default">
		<input>
			<mapdevice device="VID_D209&amp;PID_1601" controller="GUNCODE_1" />
			<mapdevice device="VID_D209&amp;PID_1602" controller="GUNCODE_2" />
			<mapdevice device="XInput Player 1" controller="JOYCODE_1" />
			<mapdevice device="XInput Player 2" controller="JOYCODE_2" />
		<port type="P1_JOYSTICK_UP">
			<newseq type="standard">
				JOYCODE_1_YAXIS_UP_SWITCH OR KEYCODE_8PAD
			</newseq>
		</port>
		</input>
	</system>
	</mameconfig>


Acima definimos quatro mapeamentos, **GUNCODE 1/2** e **JOYCODE 1/2**:

*	Os dois primeiros ``mapdevice`` definem o controle
	da pistola de luz do jogador **1** e **2** (player 1 e 2) para
	**Gun 1** e **Gun 2** respectivamente.
*	Nós usamos uma cadeia de caracteres com os seus nomes brutos para
	que cada dispositivo combinem forma individual. Observe que, como
	este é um arquivo em formato XML, precisamos usar o caractere de
	escape ``&amp;`` para representar o caractere ``&``.
*	Os duas últimos elementos ``mapdevices``, definem o o controle do
	jogador **1** e do jogador **2** para **Joy 1** e **Joy 2**
	respectivamente.
	Neste caso, estes são controles do tipo ``XInput``.


.. _devicemap-listdevice:

Listando os dispositivos disponíveis
------------------------------------
Você deve estar se perguntando, como foi que nós obtivemos as IDs dos
dispositivos usados no exemplo acima?

Rode o MAME com o parâmetro ``-v`` para ativar o modo
:ref:`loquaz <mame-commandline-verbose>`. Assim será exibido no uma
lista de dispositivos disponíveis no terminal com a etiqueta
``device id``.

Aqui um exemplo::

		Input: Adding lightgun #1:
		Input: Adding lightgun #2:
		Input: Adding lightgun #3: HID-compliant mouse (device id: \\?\HID#VID_045E&PID_0053#7&18297dcb&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Adding lightgun #4: HID-compliant mouse (device id: \\?\HID#IrDeviceV2&Col08#2&2818a073&0&0007#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Adding lightgun #5: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1602&MI_02#8&389ab7f3&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Adding lightgun #6: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1601&MI_02#9&375eebb1&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Adding lightgun #7: HID-compliant mouse (device id: \\?\HID#VID_1241&PID_1111#8&198f3adc&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Skipping DirectInput for XInput compatible joystick Controller (XBOX 360 For Windows).
		Input: Adding joystick #1: ATRAK Device #1 (device id: ATRAK Device #1)
		Skipping DirectInput for XInput compatible joystick Controller (XBOX 360 For Windows).
		Input: Adding joystick #2: ATRAK Device #2 (device id: ATRAK Device #2)
		Input: Adding joystick #3: XInput Player 1 (device id: XInput Player 1)
		Input: Adding joystick #4: XInput Player 2 (device id: XInput Player 2)

Além disso, quando os dispositivos são reatribuídos usando elementos os
``mapdevice`` no arquivo de configuração do controle, para ver se as
configurações foram aplicadas ou não use o
:ref:`modo loquaz <mame-commandline-verbose>` e veja as linhas com
``Remapped`` indicam que as configurações foram aplicadas com sucesso,
exemplo::

		Input: Remapped lightgun #1: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1601&MI_02#9&375eebb1&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Remapped lightgun #2: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1602&MI_02#8&389ab7f3&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Remapped joystick #1: XInput Player 1 (device id: XInput Player 1)
		Input: Remapped joystick #2: XInput Player 2 (device id: XInput Player 2)

Observe que a numeração dos dispositivos listados no modo loquaz tem
base zero, enquanto a numeração dos dispositivos mostrados na interface
de usuário do MAME e nos arquivos de configuração não são.


Limitações
----------

Apenas será possível atribuir números fixos aos dispositivos da entrada
caso o MAME receba as IDs fixas e únicas dos dispositivos do provedor do
dispositivo e do sistema operacional. Isso nem sempre é o caso. Por
exemplo, o provedor de um controle SDL não é capaz de fornecer IDs
exclusivas para muitos controles USB.

No cado de nenhum dos dispositivos já configurados estiverem conectados
quando o MAME for iniciado, os dispositivos que forem conectados podem
não estar com a numeração esperada.
