
.. raw:: latex

	\clearpage

ID para controles estáticos
===========================

Já é predefinido que as identificações (IDs) de mapeamento entre os
dispositivos e os controladores não são estáticos. Por exemplo, o
controlador de um controle "joystick" pode ser atribuído inicialmente
para ``Joy 1``, mas depois de uma reinicialização, ele pode aparecer
como ``Joy 3``.

O MAME enumera os dispositivos conectados e os atribui IDs com base na
ordem da enumeração do controlador. Os fatores que podem causar a
alteração destas IDs são, conectar ou desconectar os controles ou
dispositivos USB, alterar as portas ou "*hubs*", assim como até mesmo a
reinicialização do computador.

Como é um pouco complicado garantir que as IDs do controlador sejam
sempre as mesmas, é para isso que usamos a configuração ``mapdevice``.
Com essa configuração é possível definir uma identificação para o
controlador do dispositivo, garantindo ao MAME que o dispositivo
definido sempre seja mapeado com a mesma identificação.

O uso do mapdevice
------------------
O **mapdevice** é um elemento de configuração definido através de um
marcador salvo em um arquivo no formato xml. São necessários dois
atributos, o ``device`` e o ``controller``.
Nota: Essa configuração só entra em vigor quando for adicionada ao
arquivo de configuração **ctrl**. 

O atributo ``device`` define o ID do dispositivo que será mapeado.
Também pode ser uma subcategoria de caracteres desta ID. No MAME use o
modo loquaz através da opção ``-verbose`` para ver quais dispositivos
estão disponíveis durante a inicialização (mais detalhes logo
abaixo).

No MAME o atributo ``controller`` define a ID do controlador que é
composto pelo índice e por uma classe de controladores como **JOYCODE**,
**GUNCODE**, **MOUSECODE**, etc.


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

.. raw:: latex

	\clearpage

Acima definimos quatro mapeamentos, **GUNCODE 1/2** e **JOYCODE 1/2**:

*	As duas primeiras entradas ``mapdevice`` definem o controle
	da pistola de luz do jogador **1** e **2** (player 1 e 2) para
	**Gun 1** e **Gun 2** respectivamente.
*	Nós usamos uma cadeia de caracteres com os seus nomes brutos para
	que cada dispositivo combinem forma individual. Observe que, como
	este é um arquivo em formato XML, precisamos usar o caractere de
	escape ``&amp;`` para representar o caractere ``&``.
*	As duas últimas entradas ``mapdevices``, definem o jogador **1** e o
	jogador **2** para ``Joy 1`` e ``Joy 2`` respectivamente.
	Neste caso, estes são dispositivos ``XInput``.


Listando os dispositivos disponíveis
------------------------------------
Você deve estar se perguntando, como foi que nós obtivemos as IDs dos
dispositivos usados no exemplo acima?

Rode o MAME com o parâmetro ``-v`` para ativar o modo
:ref:`loquaz <mame-commandline-verbose>`. Assim será exibido no uma
lista de dispositivos disponíveis no terminal com a etiqueta
``device id``.

Aqui um exemplo: ::

		Input: Adding Gun #0:
		Input: Adding Gun #1:
		Input: Adding Gun #2: HID-compliant mouse (device id: \\?\HID#VID_045E&PID_0053#7&18297dcb&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd}) < aqui!
		Input: Adding Gun #3: HID-compliant mouse (device id: \\?\HID#IrDeviceV2&Col08#2&2818a073&0&0007#{378de44c-56ef-11d1-bc8c-00a0c91405dd}) < aqui!
		Input: Adding Gun #4: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1602&MI_02#8&389ab7f3&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd}) < aqui!
		Input: Adding Gun #5: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1601&MI_02#9&375eebb1&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd}) < aqui!
		Input: Adding Gun #6: HID-compliant mouse (device id: \\?\HID#VID_1241&PID_1111#8&198f3adc&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd}) < aqui!
		Skipping DirectInput for XInput compatible joystick Controller (XBOX 360 For Windows).
		Input: Adding Joy #0: ATRAK Device #1 (device id: ATRAK Device #1) < aqui!
		Skipping DirectInput for XInput compatible joystick Controller (XBOX 360 For Windows).
		Input: Adding Joy #1: ATRAK Device #2 (device id: ATRAK Device #2) < aqui!
		Input: Adding Joy #2: XInput Player 1 (device id: XInput Player 1) < aqui!
		Input: Adding Joy #3: XInput Player 2 (device id: XInput Player 2) < aqui!

Use o modo :ref:`loquaz <mame-commandline-verbose>`: para ver se a
configuração foi aceita e está com a ID correta, se der tudo certo deve
aparecer ``Remapped`` e as novas configurações::

		Input: Remapped Gun #0: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1601&MI_02#9&375eebb1&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Remapped Gun #1: HID-compliant mouse (device id: \\?\HID#VID_D209&PID_1602&MI_02#8&389ab7f3&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})
		Input: Remapped Joy #0: XInput Player 1 (device id: XInput Player 1)
		Input: Remapped Joy #1: XInput Player 2 (device id: XInput Player 2)

