.. raw:: latex

	\clearpage

A arma de luz
=============

.. contents:: :local:

.. _arma-luz-funcionamento:

Funcionamento
-------------

Em geral a arma possuí um fotorreceptor, repare que elas têm uma
lente no final do cano, quando o jogador aperta o gatilho o
fotorreceptor é acionado, a tela escurece e o alvo acende, tudo isso
em milésimos de segundo. Caso o alvo consiga excitar o fotorreceptor no
tempo adequado o programa do jogo entende se o jogador acertou ou não o
alvo.

Este é o conceito básico, no entanto, cada empresa desenvolve a sua
própria tecnologia. Neste `vídeo <https://youtu.be/2Dw7NFm1ZfY?t=981>`_
é possível ver como funciona em detalhes a bazuca do SNES chamada de
**Super Scope**, apesar de estar em Inglês, acredito que a ilustração do
autor seja de fácil compreensão.

Hoje vivemos em um mundo onde as telas de CRT deixaram de ser
fabricadas já faz algum tempo, atualmente no entanto, existem armas
desenvolvidas para funcionar com telas mais modernas como LCD, Plasma,
OLED, etc. Temos por exemplo a arma **Aimtrak** da empresa `Ultimarc
<https://www.ultimarc.com/aimtrak.html>`_ que utiliza um sensor no topo
da tela para detectar o movimento da arma.

Outro projeto muito interessante lançado recentemente no
`kickstarter <https://www.kickstarter.com/projects/sindenlightgun/the-sinden-lightgun>`_
é da arma `Sinden Lightgun <http://www.sindenlightgun.com/>`_ da
empresa **Sinden Technology** que desenvolveu uma nova tecnologia onde
não é mais necessário o uso de um sensor em cima da TV para que o jogo
possa identificar o movimento da arma. Esse projeto promete fazer com
que a arma de luz deles funcionem em qualquer TV de tela plana e
usando desde os consoles de videogames originais, máquinas de fliperama
e até mesmo emuladores como o MAME.

.. raw:: latex

	\clearpage

.. _arma-config-windows:

Configuração da arma no Windows
-------------------------------

A configuração no Windows é um processo mais simples, a princípio basta
conectar o acessório na porta USB e instalar o driver. Depois use o
aplicativo de configuração que acompanha o produto e faça os devidos
ajustes, testes e calibragem de mira.

Para identificar a sua arma no Windows, conecte-a no computador e
baixe o utilitário gratuito chamado `USBDeview
<http://www.nirsoft.net/utils/usb_devices_view.html>`_, rode ele e vá
em ``Exibir > escolher colunas > Deselect all`` e selecione as opções
``Nome do dispositivo, descrição, ID do Vendedor, ID do produto, ID da
Instância``, caso ele esteja em inglês, vá então em ``View > Choose
colums > Deselect all`` e selecione ``Device name, description, Vendor
ID, Product ID, Instance ID``.

O nome da sua arma deve aparecer no campo
``Nome do dispositivo/Device name``, tome nota do **ID do Vendedor
(Vendor ID)** e do **ID do Produto (Product ID)**, para o nosso exemplo
o dispositivo que usaremos é um mouse gamer com a identificação
**VID_1D57&PID_AD04**. Ainda com o dispositivo conectado rode o MAME com
o comando ``mame -v`` e observe a listagem de **Input** (Entradas) que
ele gera e tome nota!

Para não deixar a saída muito grande separei apenas o que nos
interessa:

.. code-block:: kconfig

	Input: Adding mouse #2: HID-compliant mouse (device id: \\?\HID#VID_1D57&PID_AD04&MI_01&Col01#7&ecdb012&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})

Para que fique fácil a compreensão, vamos quebrar essa linha em pedaços
listando apenas as partes que nos interessa para a configuração:

	* **Input** - O MAME exibe a descrição do que ele identificou como
	  entrada.
	* **Adding mouse #2** - Informa o que é este dispositivo e em que
	  ordem ele foi adicionado.
	* **HID-compliant mouse** - Informa o nome do dispositivo, muita
	  atenção quanto ao nome que aparece aqui pois o MAME costuma gerar
	  um crash com ``ACCESS VIOLATION`` ou ignorar o dispositivo caso
	  ele tenha o nome errado, ainda que o PID e VID estejam certos. As
	  armas Aimtrak podem exibir algo como ``ATRAK Device #1
	  product_1601d209-....`` neste caso, o que importa para nós é o
	  ``ATRAK Device #1``.

Para remapear este dispositivo como ``lightgun #0``, nós usamos o
exemplo da configuração abaixo:

.. code-block:: xml

	<mameconfig version="10">
	<system name="default">
		<input>
			<!--Atenção ao nome correto do dispositivo, esta parte configura a parte de controle da arma-->
			<mapdevice device="HID-compliant mouse" controller="JOYCODE_1" />
			<!--Aqui definimos o VID e PID da arma-->
			<mapdevice device="VID_1D57&amp;PID_AD04" controller="GUNCODE_1" />
			<!--Para 2 armas ou mais, basta usar JOYCODE_2/GUNCODE2 para o jogador 2 e assim por diante-->
		</input>
	</system>
	</mameconfig>

Salve a configuração como `arma.cfg <https://pastebin.com/3chyfNzr>`_
dentro do diretório **ctrl**, caso o MAME esteja aberto, feche. Inicie-o
novamente com o comando ``mame -v -ctrlr arma``, você deverá ter na
saída algo deste tipo:

.. code-block:: bash

	Attempting to parse: arma.cfg
	Input: Remapped lightgun #0: HID-compliant mouse (device id: \\?\HID#VID_1D57&PID_AD04&MI_01&Col01#7&ecdb012&0&0000#{378de44c-56ef-11d1-bc8c-00a0c91405dd})

.. _arma-config-linux:

Configuração da arma no Linux
-----------------------------

No Linux o processo é mais complicado e exige um pouco mais de trabalho
na parte de configuração porém não desanime, é mais fácil fazer do que
descrever todo o processo. Existem diferentes meios de se alcançar este
objetivo, dentre os mais conhecidos fazem com que o MAME veja essa
arma de luz como um mouse, o que faz com que a experiência final do
usuário não seja das melhores. Não há qualquer alinhamento prévio entre
a interface do mouse com a mira externa, isso exige que uma configuração
individual seja feita para cada jogo e ainda assim não é a mais precisa.

Existe no entanto um outro método fazendo a configuração através do
``udev`` e ``Xorg.conf`` que permite um acesso direto ao acessório e com
isso obter uma melhora significativa na questão da precisão da mira.

A base de referência usada aqui é o Debian e Ubuntu, talvez alguns
ajustes na configuração sejam necessárias para outros sistemas Linux, no
entanto este apanhado geral serve como um guia do que precisa ser feito.

.. _arma-config-udev:

Configuração das regras para udev
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A arma AimTrak assim como as de outras marcas, quando conectadas na
porta USB, exibem geralmente 2 mouses e 1 joystick. O que faremos será
fazer uma configuração estática usando o udev em conjunto com o
**libinput**, fazendo com que todo o resto seja ignorado, menos os
dispositivos que precisamos. Isso evita conflitos do sistema que
identifica mais de um mouse para cada arma USB que for conectada.

Crie um novo arquivo chamado **99-aimtrak.rules** em
``/etc/udev/rules.d`` com o comando
``sudo touch /etc/udev/rules.d/99-aimtrak.rules``, usamos um valor
numérico alto pois este arquivo não tem prioridade alguma, assim
deixamos ele para ser carregado por último pelo sistema evitando
possíveis conflitos. Usando o seu editor preferido, cole a configuração
abaixo:

.. code-block:: bash

		# Veja uma cópia deste arquivo no link abaixo:
		# https://pastebin.com/HQvML0Dg
		#
		# Define o modo "0666" e desabilita a assistência do libinput evitando
		# que o X11 use as interfaces ou dispositivos errados.
		SUBSYSTEMS=="usb", ATTRS{idVendor}=="d209", ATTRS{idProduct}=="160*", MODE="0666", ENV{ID_INPUT}="", ENV{LIBINPUT_IGNORE_DEVICE}="1"
	
		# Caso ID_USB_INTERFACE_NUM==2, habilite a assistência do libinput.
		SUBSYSTEMS=="usb", ATTRS{idVendor}=="d209", ATTRS{idProduct}=="160*", ENV{ID_USB_INTERFACE_NUM}=="02", ENV{ID_INPUT}="1", ENV{LIBINPUT_IGNORE_DEVICE}="0"

**NÃO PULE ESTA ETAPA!**

Salve, saia e recarregue a configuração com o comando ``udevadm control
--reload-rules``. Antes de prosseguir faça o comando ``sudo journalctl
-b -p err`` e verifique se não há o retorno de qualquer erro em vermelho
relacionado com essa regra que você acabou de adicionar, caso contrário
você vai perder o acesso ao computador e só será possível recuperá-lo
reiniciando e entrando no modo de recuperação do sistema para apagar ou
arrumar a regra.

A configuração acima é voltada especificamente para as armas
**AimTrak**, porém cada modelo de arma precisará de uma configuração
específica. Atenção a formatação deste aquivo, há distribuições que
ignoram a quebra de linha, porém distribuições como o Debian interpretam
a quebra de linha como um erro fazendo com que você perca o controle do
teclado e do mouse quando o computador é reiniciado, use o link acima
para obter uma cópia deste arquivo.

.. raw:: latex

	\clearpage

.. _arma-outro-fabricante:

E caso eu tenha uma arma de outro modelo ou fabricante?
-------------------------------------------------------

Toda a vez que um dispositivo USB é conectado no Linux ele faz um
registro dessa conexão, para acessar esse registro faça o comando
``sudo dmesg`` no terminal logo depois de conectar a sua arma USB.
Aqui um exemplo do que aparece no terminal logo depois que um mouse
gamer USB é conectado:

.. code-block:: bash

	[12119.580375] usb 2-1.3: new full-speed USB device number 3 using xhci_hcd
	[12119.688300] usb 2-1.3: New USB device found, idVendor=1d57, idProduct=ad04
	[12119.688303] usb 2-1.3: New USB device strings: Mfr=2, Product=1, SerialNumber=0
	[12119.688305] usb 2-1.3: Product: Gaming Mouse
	[12119.688306] usb 2-1.3: Manufacturer: LXD
	[12119.694168] input: LXD Gaming Mouse as /devices/pci0000:00/0000:00:09.0/0000:02:00.0/usb2/2-1/2-1.3/2-1.3:1.0/0003:1D57:AD04.0006/input/input17
	[12119.753002] hid-generic 0003:1D57:AD04.0006: input,hidraw5: USB HID v1.10 Keyboard [LXD Gaming Mouse] on usb-0000:02:00.0-1.3/input0
	[12119.759341] input: LXD Gaming Mouse as /devices/pci0000:00/0000:00:09.0/0000:02:00.0/usb2/2-1/2-1.3/2-1.3:1.1/0003:1D57:AD04.0007/input/input18
	[12119.816761] hid-generic 0003:1D57:AD04.0007: input,hidraw6: USB HID v1.10 Mouse [LXD Gaming Mouse] on usb-0000:02:00.0-1.3/input1

O exemplo mostra duas interfaces **input** assim como é com a arma
**AimTrak**, basta agora substituir os valores de **idVendor** e
**idProduct** para bater com o nosso dispositivo, assim a configuração
ficaria assim:

.. code-block:: bash

		# Veja uma cópia deste arquivo no link abaixo:
		# https://pastebin.com/gw0VszkK
		#
		# Define o modo "0666" e desabilita a assistência do libinput evitando
		# que o X11 use as interfaces ou dispositivos errados.
		SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d57", ATTRS{idProduct}=="ad04", MODE="0666", ENV{ID_INPUT}="", ENV{LIBINPUT_IGNORE_DEVICE}="1"
	
		# Caso ID_USB_INTERFACE_NUM==2, habilite a assistência do libinput.
		SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d57", ATTRS{idProduct}=="ad04", ENV{ID_USB_INTERFACE_NUM}=="02", ENV{ID_INPUT}="1", ENV{LIBINPUT_IGNORE_DEVICE}="0"

**NÃO PULE ESTA ETAPA!**

Salve, saia e recarregue a configuração com o comando ``udevadm control
--reload-rules``. Antes de prosseguir faça o comando ``sudo journalctl
-b -p err`` e verifique se não há o retorno de qualquer erro em vermelho
relacionado com essa regra que você acabou de adicionar, caso contrário
você vai perder o acesso ao computador e só será possível recuperá-lo
reiniciando e entrando no modo de recuperação do sistema para apagar ou
arrumar a regra.

.. raw:: latex

	\clearpage

.. _arma-configuracao-xorg:

Configurando as entradas no Xorg
--------------------------------

Vale lembrar que algumas distribuições Linux migraram para o Wayland,
apesar da migração o Wayland ainda compartilha configurações muito
semelhantes ao Xorg/X11, no entanto são poucas as distribuições que
ainda usam o arquivo de configuração **xorg.conf** assim como, o
diretório de configuração pode estar localizado em um outro lugar
qualquer, assim a sua sorte pode variar bastante.

Para que mais de uma arma funcione de forma correta, é necessário
configurar o Xorg para tratá-la(s) como dispositivos "`flutuantes`",
fazendo com que a mira de cada arma não seja confundida com o
ponteiro do mouse usado pelo sistema.

No **Ubuntu** e **Fedora** crie o arquivo **99-arma.conf** no
diretório ``/etc/X11/xorg.conf.d``, no **Debian** e no **Arch Linux** o
diretório fica em ``/usr/share/X11/xorg.conf.d``. Devido a grande
variedade de distribuições Linux é inviável tentar descrever o caminho
completo do diretório **xorg.conf.d** para cada uma delas, isso sem
contar macOS e as várias variantes de BSD's, no entanto, é possível usar
o comando abaixo para tentar localizá-lo caso a sua distribuição utilize
um diretório de mesmo nome para armazenar essas configurações porém em
um local diferente do predefinido: ::

	sudo find /usr -name xorg.conf.d

Caso o comando acima não retorne nada, verifique o diretório correto
para a distribuição que você estiver usando.

Dependendo da quantidade de dispositivos USB que você tenha conectado no
seu computador eles ocuparão diferentes ``input/event``, ainda usando o
nosso `mouse gamer` como exemplo, você pode fazer o comando
``libinput list-devices`` no **Ubuntu** e **Fedora** ou
``libinput-list-devices`` no **Debian**. Caso o comando não funcione
tenha certeza de ter instalado o pacote **libinput-tools**.
Para mais informações acesse este `link
<https://wayland.freedesktop.org/libinput/doc/latest/what-is-libinput.html>`_.

O comando deve listar todos os dispositivos, aqui limitado apenas para o
nosso caso:

.. code-block:: kconfig

	Device:           LXD Gaming Mouse
	Kernel:           /dev/input/event14
	Group:            3
	...
	
	Device:           LXD Gaming Mouse
	Kernel:           /dev/input/event15
	Group:            3

A saída completa foi eliminada para exibir apenas o que nos interessa,
caso a sua distribuição não tenha o **libinput-tools** por algum motivo, 
podemos usar o bom e velho comando ``cat /proc/bus/input/devices``:

.. code-block:: kconfig

	I: Bus=0003 Vendor=1d57 Product=ad04 Version=0110
	N: Name="LXD Gaming Mouse"
	P: Phys=usb-0000:02:00.0-1.3/input0
	U: Uniq=
	H: Handlers=sysrq kbd leds event14
	
	I: Bus=0003 Vendor=1d57 Product=ad04 Version=0110
	N: Name="LXD Gaming Mouse"
	P: Phys=usb-0000:02:00.0-1.3/input1
	U: Uniq=
	H: Handlers=kbd mouse2 event15

.. raw:: latex

	\clearpage

Veja que o comando também mostra o Vendor e Product ID's, com essa
informação em mãos criamos o seguinte conteúdo para o nosso arquivo
`99-arma.conf <https://pastebin.com/HQpY06Ca>`_, novamente, usamos
**99** para que este seja o último arquivo a ser lido pelo sistema:

.. code-block:: kconfig

	Section "InputClass"
		Identifier "LXD Gaming Mouse"
		MatchDevicePath "/dev/input/event*"
		MatchUSBID "1d57:ad04"
		Driver "libinput"
		Option "Floating" "yes"
		Option "AccelerationProfile" "-1"
		Option "AutoServerLayout" "no"
	EndSection

Um cuidado especial com a opção **Floating**, pode ser que dependendo do
seu dispositivo, deixar em **yes** pode fazer com que a sua arma ou
mouse fique limitado a um pequeno espaço na tela, caso seja o seu caso,
mude essa opção para **no**, salve o arquivo e encerre a cessão
(retorne para a tela de login). Isso precisa ser feito pois o arquivo só
é lido novamente quando a sessão é encerrada ou o computador é
reiniciado.

O **AccelerationProfile** serve para lidar com a aceleração ou não do
dispositivo, pode ser que no seu ambiente a mira esteja lenta demais,
arrastada ou rápida demais, etc. Ajuste conforme a sua necessidade, a
ideia é fazer com que a mira responda de forma rápida e precisa conforme
os seus movimento.
Os valores válidos segundo a `documentação oficial
<https://www.x.org/wiki/Development/Documentation/PointerAcceleration/>`_
são:

*	**-1** Nenhuma aceleração.
*	**1** Com aceleração caso o dispositivo suporte.
*	**2** Escala Polinomial, a velocidade serve como um coeficiente e
	a aceleração um expoente. Em resumo, tente este primeiro.
*	**3** Linear suave, escala linear na maioria do tempo com um
	início suave.
*	**4** Simples, transição suave entre aceleração e sem, este é o
	valor predefinido caso nada seja definido.
*	**5** Power, aceleração acentuada, difícil de controlar.
*	**6** Linear, velocidade e aceleração linear.
*	**7** Limitado, ascende a aceleração de forma suave até um limite.

.. raw:: latex

	\clearpage

.. _arma-configuracao-mame:

Configuração genérica
---------------------

Existem diferentes maneiras de fazer este tipo de configuração no MAME,
a primeira seria editando o seu ``~/.mame/mame.ini`` com as
configurações abaixo para **Windows**:

.. code-block:: kconfig

	lightgun                  1
	lightgun_device           lightgun
	offscreen_reload          1

Adicione as opções acima no seu ``mame.ini`` e pronto.

Aqui a configuração para **Linux** e variantes **SDL**:

.. code-block:: kconfig

	lightgun                  1
	lightgun_device           mouse
	lightgunprovider          x11
	lightgun_index1           "Continue lendo para saber o que usar aqui"
	offscreen_reload          1

Lembrando que estamos usando um mouse como teste, assim estamos usando
**lightgun_device** como **mouse**, caso você esteja usando uma arma
de luz mude para **lightgun**.

Na versão SDL precisamos definir **lightgun_index[1-8]**, geralmente o
valor que precisamos usar é o **nome do dispositivo** ou o seu **ID**.
É usando o **lightgun_index** entre 1 e 8 que você vai adicionando todas
as armas que você tiver no sistema, cada uma com o seu ID único.
Com a arma ou o mouse conectado, inicie o MAME com o comando
``mame64 -v``, o MAME deve exibir uma mensagem como essa (ela vai variar
muito de caso para caso):

.. code-block:: bash

	Evaluating device with name: Virtual core pointer
	Evaluating device with name: Virtual core keyboard
	Evaluating device with name: Virtual core XTEST pointer
	Evaluating device with name: Virtual core XTEST keyboard
	Evaluating device with name: Power Button
	Evaluating device with name: Power Button
	Evaluating device with name: Logitech USB Optical Mouse
	Evaluating device with name: Microsoft Microsoft® 2.4GHz Transceiver v8.0
	Evaluating device with name: Microsoft Microsoft® 2.4GHz Transceiver v8.0
	Evaluating device with name: Microsoft Microsoft® 2.4GHz Transceiver v8.0
	Evaluating device with name: Microsoft Microsoft® 2.4GHz Transceiver v8.0
	Evaluating device with name: Microsoft Microsoft® 2.4GHz Transceiver v8.0
	Evaluating device with name: LXD Gaming Mouse
	Evaluating device with name: LXD Gaming Mouse
	Evaluating device with name: LXD Gaming Mouse

No nosso exemplo o **LXD Gaming Mouse** repete 3x e ao usá-lo com o
**lightgun_index1**: ::

	lightgun_index1           LXD Gaming Mouse

O MAME reclama dizendo: ::

	Warning: There are multiple devices named "LXDGamingMouse".
	To ensure the correct one is selected, please use the device ID
	instead.

Traduzindo a mensagem fica assim: ::

	Atenção: Existe mais de um dispositivo com o nome "LXDGamingMouse".
	Favor usar o ID do dispositivo para ter certeza que apenas um seja
	escolhido.

Para encontrar o ID do dispositivo precisamos do programa **xinput**,
verifique no gerenciador de pacotes da sua distribuição como fazer para
instalá-lo, no **Debian** e **Ubuntu** seria ``sudo
apt-get install xinput``.

Execute o comando ``xinput list``:

.. code-block:: bash

	  Virtual core pointer					id=2	[master pointer  (3)]
	     Virtual core XTEST pointer				id=4	[slave  pointer  (2)]
	     Logitech USB Optical Mouse				id=8	[slave  pointer  (2)]
	     Microsoft Microsoft® 2.4GHz Transceiver v8.0	id=10	[slave  pointer  (2)]
	     Microsoft Microsoft® 2.4GHz Transceiver v8.0	id=11	[slave  pointer  (2)]
	  Virtual core keyboard					id=3	[master keyboard (2)]
	 Virtual core XTEST keyboard				id=5	[slave  keyboard (3)]
	  Power Button						id=6	[slave  keyboard (3)]
	  Power Button						id=7	[slave  keyboard (3)]
	  Microsoft Microsoft® 2.4GHz Transceiver v8.0		id=9	[slave  keyboard (3)]
	  Microsoft Microsoft® 2.4GHz Transceiver v8.0		id=12	[slave  keyboard (3)]
	  Microsoft Microsoft® 2.4GHz Transceiver v8.0		id=13	[slave  keyboard (3)]
	  LXD Gaming Mouse					id=14	[floating slave]
	  LXD Gaming Mouse					id=15	[floating slave]
	  LXD Gaming Mouse					id=16	[floating slave]

O comando exibe a **id=14**, **id=15** e **id=16** para o
**LXD Gaming Mouse**, nos testes o id que funciona com o nosso
dispositivo é o **id=15**, logo a configuração final fica assim:

.. code-block:: kconfig

	lightgun                  1
	lightgun_device           mouse
	lightgunprovider          x11
	lightgun_index1           15
	offscreen_reload          1

Salve o seu ``mame.ini`` com as opções acima e inicie o MAME com o
comando ``mame64 -v``, na saída agora temos:

.. code-block:: bash

	Lightgun: Begin initialization
	Lightgun mapping: Logical id 1: 15
	Input: Adding lightgun #0: 15 (device id: 15)
	0: 15
	...
	...
	Motion = 71
	Device 15: Registered 3 events.
	Events types to register: motion:71, press:69, release:70
	Lightgun: End initialization

Escolha um jogo de tiro qualquer e verá que a sua arma ou mouse deve
funcionar sem qualquer problema.

.. raw:: latex

	\clearpage

.. _arma-usando:

Configurando uma Pistola de luz
-------------------------------

Agora que tudo está funcionando a parte mais chata seria fazer
configuração da sua arma para cada uma das trezentas e poucas
máquinas, porém isso é mais simples do que parece. O MAME oferece a
opção :ref:`-ctrlr <mame-commandline-ctrlrpath>` para que você possa
carregar a configuração que você já fez para uma máquina mas que podem
ser usada em outras.

Inicie uma máquina qualquer como **bang** por exemplo, ``mame64 bang``,
quando ela iniciar pressione **TAB** para acessar a interface e vá em
**Entrada (esta máquina)**. Para o **Jogador 1** selecione **Lightgun X
Analog** e pressione **Enter**, mova a arma da esquerda para direita,
deve aparecer **Gun 1 X**, faça o mesmo com **Lightgun X Analog** mas
mova a arma de cima para baixo, agora a opção deve aparecer como
**Gun 1 X**. Caso tenha mais uma arma para o jogador 2 faça o mesmo
em **Lightgun X 2 Analog** e **Lightgun Y 2 Analog**.

Pressione **ESQ** para sair do MAME, vá até o diretório **cfg** e
localize o arquivo `bang.cfg <https://pastebin.com/n1YbX53G>`_, nele
está toda a configuração que você fez, exemplo:

.. code-block:: xml

	<?xml version="1.0"?>
	<!-- This file is autogenerated; comments and unknown tags will be stripped -->
	<mameconfig version="10">
		<system name="bang">
		<counters>
			<coins index="0" number="10" />
		</counters>
		<input>
		<port tag=":LIGHT0_X" type="P1_LIGHTGUN_X" mask="255" defvalue="128">
			<newseq type="standard">
				GUNCODE_1_XAXIS
			</newseq>
		</port>
		<port tag=":LIGHT0_Y" type="P1_LIGHTGUN_Y" mask="255" defvalue="128">
			<newseq type="standard">
				GUNCODE_1_YAXIS
			</newseq>
		</port>
	</input>
	</system>
	</mameconfig>

.. raw:: latex

	\clearpage

O exemplo acima foi gerado no Linux, no Windows e outros sistemas será
gerado o mesmo arquivo mas com uma `configuração diferente
<https://pastebin.com/FZJd3UBW>`_, aqui o exemplo para o Aimtrak no
Windows:

.. code-block:: xml

	
    <?xml version="1.0"?>
    <!-- This file is autogenerated; comments and unknown tags will be stripped -->
    <mameconfig version="10">
        <system name="bang">
            <counters>
                <coins index="0" number="10" />
            </counters>
            <input>
                <mapdevice device="ATRAK Device #1 product_XXXXXXXX-0000-0000-0000-XXXXXXXXXXXX instance_XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX" controller="GUNCODE_1" />
                <mapdevice device="ATRAK Device #2 product_YYYYYYYY-0000-0000-0000-YYYYYYYYYYYY instance_YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY" controller="GUNCODE_2" />
                <port type="P1_LIGHTGUN_X">
                    <newseq type="standard">
                        GUNCODE_1_XAXIS
                    </newseq>
                </port>
                <port type="P1_LIGHTGUN_Y">
                    <newseq type="standard">
                        GUNCODE_1_YAXIS
                    </newseq>
                </port>
                <port type="P2_LIGHTGUN_X">
                    <newseq type="standard">
                        GUNCODE_2_XAXIS
                    </newseq>
                </port>
                <port type="P2_LIGHTGUN_Y">
                    <newseq type="standard">
                        GUNCODE_2_YAXIS
                    </newseq>
                </port>
            </input>
        </system>
    </mameconfig>

Independente do arquivo que você tenha gerado edite a linha
**<system name="bang">** para **<system name="default">** e salve o
arquivo como **arma.cfg** dentro do diretório **ctrl**. Agora sempre
que você for iniciar o MAME com essa configuração, basta fazer o comando
``mame64 -ctrlr arma bang``. Assim o MAME inicia a máquina com as
suas configurações predefinidas.

Caso não queira fazer isso para cada jogo, adicione a configuração no
seu **mame.ini**: ::

	ctrlr                     arma

Lembrando que é possível também fazer como foi ensinado em
:ref:`Habilitando a arma apenas em jogos que precisam
<arma-em-jogos-que-precisam>` adicionando esta opção em **cfg.txt**.

.. raw:: latex

	\clearpage

.. _arma-em-jogos-que-precisam:

Habilitando a arma apenas em jogos que precisam
--------------------------------------------------

O problema de usar o ``mame.ini`` é que o MAME **sempre** vai carregar e
habilitar a arma em maquinas que não precisam, em um PC com bastante
recursos pode não ser problema, no entanto, caso o MAME esteja rodando
em um ambiente com recursos limitados isso pode ser um problema. Ou
simplesmente, é como o autor deste texto que gosta das coisas bem
organizadas.

O que faremos é replicar a configuração que temos e sabemos que funciona
apenas para as máquinas que usam arma, deixando o **mame.ini** livre
de modificações. Para realizar essa façanha *é bem simples*, basta
criarmos um arquivo ***.ini** **para cada uma das 362 máquinas
conhecidas** e salvar a configuração acima **EM CADA UM DESTES
ARQUIVOS**. Ainda bem que temos as ferramentas certas no **Linux**
para nos ajudar, certo?

Todos os procedimentos abaixo são feitos em um ambiente **Linux** mas
podem funcionar em um ambiente `MINGW <http://www.mingw.org/>`_
ou similares.

.. _arma-luz-maquinas:

*	Abra o seu arquivo ``~/.mame/mame.ini``, em **inipath** substitua o
 	``$HOME/.mame;.;ini`` por ``$HOME/.mame;.;ini;arma``
*	Salve e saia.
*	O site do projeto **Project-Snaps** mantém um arquivo chamado
 	**category.ini** com uma lista de jogos separados por diversas
 	categorias diferentes, dentre elas há a categoria de jogos de tiro
 	que usam armas definido na lista como **[Shooting / Guns]**,
 	usaremos os nomes desta lista para preparar a nossa.
*	Acesse `este link <http://www.progettosnaps.net/renameset/>`_ do
	site Project-Snaps e baixe o arquivo **category.ini** mais recente.
*	Abra o arquivo compactado e extraia o diretório **folders** no
	diretório raiz do MAME.
*	**No terminal**, vá até o diretório raiz do MAME e faça o comando
	``mkdir arma`` para criar o diretório seguido de ``cd arma``
	para entrar nele.
*	Execute o comando abaixo para filtrar apenas os nomes das máquinas
	que queremos e em seguida salvamos eles em um arquivo chamado
	`maquinas <https://pastebin.com/zZxvkza2>`_ em formato de fim de
	linha para Unix: ::

		awk '/Gun/{flag=1; next} / /{flag=0} flag' ../folders/category.ini| head -n -6 > maquinas && sed -i 's/\r//g' maquinas

*	Caso o seu ``cfg.txt`` esteja em formato Unix, ele precisa ser
	convertido antes de ser usado no Windows com o comando ``sed -i
	's/$/\r/' cfg.txt``.

*	Copie e cole a configuração abaixo em um arquivo texto e salve
	**dentro do diretório arma** localizado no diretório raiz do MAME
	como `cfg.txt <https://pastebin.com/UYu6P3gM>`_, no exemplo estou
	usando **mouse** como **lightgun_device**, caso esteja usando uma
	arma substitua por **lightgun**: ::

		lightgun                  1
		lightgun_device           mouse
		lightgunprovider          x11
		lightgun_index1           15
		offscreen_reload          1

*	No terminal, ainda dentro do diretório arma, execute o comando
	abaixo para criar uma configuração com o nome de cada máquina: ::

		while read lista; do cp cfg.txt "$lista".ini; done < maquinas

.. raw:: latex

	\clearpage

Agora dentro do diretório arma estará cheia de arquivos ***.ini**
como o nome de cada máquina que usa uma arma e com a configuração
correta dentro de cada um deles.

Estou disponibilizando esses arquivos ***.ini** já prontos visando
facilitar a vida de todos, a versão para Windows é bem genérica e deve
funcionar de imediato sem muitos ajustes, porém o mesmo não ocorre com a
versão Linux, a configuração precisa ser customizada individualmente
para cada caso, principalmente o **lightgun_index**, caso o nome ou o ID
esteja errado a sua arma não vai funcionar, de qualquer maneira aqui
estão os arquivos.

*	Arquivos ini com **lightgun_device** como mouse.
	https://www.mediafire.com/file/2vh06q6lbvcur8a/ini-mouse.7z
*	Arquivos ini com **lightgun_device** como lightgun.
	https://www.mediafire.com/file/ytmnp3ik9avyfjm/ini-lightgun.7z
*	Arquivos ini com **lightgun_device** como mouse para Windows.
	http://www.mediafire.com/file/1zz6vfkd7jh7tj8/ini-mouse-windows.7z
*	Arquivos ini com **lightgun_device** como lightgun para Windows.
	http://www.mediafire.com/file/hi7864yk8s09o78/ini-lightgun-windows.7z

Use o `7-zip <https://www.7-zip.org/>`_ para descompactar os arquivos
dentro do diretório arma.

.. raw:: latex

	\clearpage

.. _arma-separando-roms:

Separando apenas as ROMs das máquinas de tiro
---------------------------------------------

Da mesma maneira que podemos criar uma lista de configuração individual
para cada máquina, podemos também usar a mesma lista para copiar apenas
as suas ROMs atendendo a necessidade das pessoas que configuram as suas
máquinas dessa forma.

Ainda usando o arquivo :ref:`maquinas <arma-luz-maquinas>`
executaremos as seguintes ações:

*	Crie um diretório **roms** em qualquer outro lugar fora do diretório
	onde se encontra o MAME.
*	Copie o arquivo **maquinas** (ou gere um novo caso tenha apagado)
	para dentro deste diretório.
*	Você precisa encontrar o caminho completo onde todas as suas ROMs se
	encontram, vamos supor que seja ``/home/mame/mame/roms``, abra um
	terminal neste diretório e execute o comando abaixo: ::

		while read maquinas; do echo /home/mame/mame/roms/"$maquinas".zip ; done < maquinas > lista-roms

*	O comando acima vai ser alimentado pelo arquivo **maquinas** e
	substituir **"$maquinas"** pelos nomes que forem aparecendo linha a
	linha, depois ``> lista-roms`` faz o redirecionamento completo para
	o arquivo **lista-roms**. Ao final o arquivo ficará com o seguinte
	conteúdo: ::

	/home/mame/mame/roms/2spicy.zip
	/home/mame/mame/roms/alien3.zip
	/home/mame/mame/roms/alien3j.zip
	/home/mame/mame/roms/alien3u.zip
	/home/mame/mame/roms/aplatoon.zip
	/home/mame/mame/roms/area51.zip

*	Agora com a lista das ROMs e seu caminho completo basta copiá-los
	com o comando abaixo: ::

		while read copy ; do cp "$copy" . ; done < lista-roms

	O ponto depois de ``"$copy"`` faz com que o comando ``cp`` copie
	todos os arquivos para o diretório onde você está, caso queira
	copiá-los para outro lugar basta usar o caminho, assim: ::

		while read copy; do cp "$copy" /caminho/completo ; done < lista-roms

Apesar do comando **cp** funcionar bem para a maioria dos casos, é
impossível saber se o arquivo foi copiado de forma correta ou não para o
destino, nestes casos a melhor opção é usar o programa **rsync** que
durante o processo de cópia verifica a integridade do arquivo no
destivo, além de ser a melhor opção para a cópia de arquivos nós podemos
também registrar em um arquivo toda a operação que ele fez, seja bem
sucedida ou não, assim basta usar o comando anterior com algumas
alterações: ::

		while read copy; do rsync --info=name,progress2 --log-file=registro "$copy" . ; done < lista-roms

Neste novo comando a opção ``--info=name,progress2`` vai exibir
estatísticas da operação que ele estiver fazendo de um determinado
arquivo, o ``log-file=registro`` armazena todo o processo, seja ele bem
sucedido ou não assim como erros informando as ROMs que não foram
encontradas. É possível filtrar essas ROMs que não foram encontradas com
o comando: ::

		cat registro | grep "No such file or directory" | awk '{print $6}' > roms-ausentes

O exemplo que foi demonstrado aqui serve para qualquer outro tipo de
lista, você pode por exemplo gerar uma lista para máquinas CPS1/CPS2/ZN
e depois copiar essas ROMs em diretórios separados, o céu é o limite.

.. raw:: latex

	\clearpage

.. _arma-compilando:

Compilando uma versão do MAME só com maquinas de tiros
------------------------------------------------------

O MAME disponibiliza a opção de filtrar a lista de máquinas por
categoria, para mais informações veja :ref:`Categoria
<mamemenu-categoria>`, os jogos de tiro estão listados como
**[Shooting / Guns]**. No entanto está se tornando muito comum o uso de
miniPC's como Raspberry Pi, é muito comum também ver pessoas perguntando
como compilar uma versão customizada do MAME só com jogos de tiro em
fóruns e comunidades espalhadas pela internet. Os motivos são diversos,
o mais comum sendo a limitação de espaço que impossibilita ter um
binário completo do MAME.

Aqui iremos demonstrar como isso pode ser feito, recomendamos que antes
de prosseguir leia o capítulo :ref:`Compilando o MAME <compiling-MAME>`
para obter maiores informações e detalhes que não serão abordados aqui.
O autor assume que o você já tenha lido e compreendido o capítulo sobre
a compilação do MAME e que você já esteja familiarizado com o processo.

No :ref:`capítulo anterior <arma-em-jogos-que-precisam>` nós
demonstramos como criar o arquivo **maquinas** usando o arquivo
**category.ini** que fica dentro do diretório **folders**, naquele
aquivo ficam todas as máquinas dentro da categoria de tiro, porém para
compilar o MAME com elas nós necessitamos encontrar **TODOS** os drivers
responsável por eles e repassar essa informação aos scripts de
compilação usando a opção **SOURCES**.

*	Precisamos do arquivo ``maquinas`` com a listagem de todas elas,
	lembramos que o MAME está sempre em evolução, logo a lista
	disponível `aqui <https://pastebin.com/zZxvkza2>`_ pode mudar com o
	tempo, assim recomendamos manter o seu arquivo **categories.ini**
	atualizado e se for o caso, gere um novo arquivo seguindo as
	instruções do capítulo anterior.
*	Para encontrar os drivers responsáveis pelas máquinas da lista nós
	usamos a função
	:ref:`-listsource / -ls <mame-commandline-listsource>` do MAME,
	por exemplo: ::

		./mame64 -ls area51| awk '{print $2}'
		jaguar.cpp

*	Copie o arquivo **maquinas**
	(gerado ou `baixado <https://pastebin.com/zZxvkza2>`_) dento do
	diretório do MAME e execute o comando abaixo: ::

		while read lista; do ~/mame/mame64 -ls "$lista"; done < maquinas | awk '{print $2}' | awk '!seen[$0]++' | sort -d > drivers

	O comando vai alimentar o MAME com o nome das máquinas,
	``~/mame/mame64`` mostra o caminho completo onde se encontra o
	binário do MAME, o comando ``awk '{print $2}'`` vai selecionar
	apenas a segunda coluna onde estão os **drivers.cpp**, o comando
	``awk '!seen[$0]++'`` elimina todos os nomes duplicados, já o último
	comando dessa cadeia, ``sort -d > drivers`` organiza a lista em
	ordem alfabética e redireciona a sua saída para um arquivo chamado
	**drivers**.

*	Copie o arquivo **drivers** para dentro do diretório raiz onde se
	encontra o código fonte do MAME (onde está o arquivo **makefile**)
	e execute o comando abaixo: ::

		while read drivers; do find . -name "$drivers"; done <drivers | grep drivers | sed 's/..//' > list-drivers

	A primeira parte do comando vai ser alimentado pelo arquivo
	**drivers** enquanto pesquisa pelos nome da lista pois
	``"$drivers"`` será substituído por cada um dos nomes do arquivo
	**drivers**, dentro da pesquisa será encontrado outros itens além
	dos drivers como **video** por exemplo, então ``grep drivers`` vai
	ignorar todo o resto e listar apenas **drivers**. O comando
	``sed 's/..//' > list-drivers`` vai eliminar os dois primeiros
	caracteres **./** da lista e redirecionar tudo o que foi encontrado
	para o arquivo `list-drivers <https://pastebin.com/j1bkR9ge>`_,
	exemplo: ::

		src/mame/drivers/3do.cpp
		src/mame/drivers/8080bw.cpp
		src/mame/drivers/alg.cpp
		src/mame/drivers/atarittl.cpp
		...

*	Apesar da lista ter sido gerada, ela ainda não é útil para nós pois
	precisamos que ela esteja disposta em uma só linha e separada por
	vírgula, para isso executamos o comando abaixo: ::

		cat list-drivers | sed ':a;N;$!ba;s/\n/,/g' > compile-drivers

	Aqui o comando ``cat list-drivers`` lista todo o conteúdo de
	**list-drivers**, já ``sed ':a;N;$!ba;s/\n/,/g' > compile-drivers``
	vai quebrar o final de linha depois do último caractere, o 
	substituirá por vírgula e redirecionará a sua saída para o arquivo
	`compile-drivers <https://pastebin.com/3rGt6yvj>`_, exemplo:

.. code-block:: bash

		src/mame/drivers/3do.cpp,src/mame/drivers/8080bw.cpp,src/mame/drivers/alg.cpp,src/mame/drivers/atarittl.cpp,...

*	Com a nossa `lista completa <https://pastebin.com/4pEvJhm2>`_,
	basta agora executar o comando de compilação do MAME:

.. code-block:: bash

		make SYMBOLS=1 SYMLEVEL=1 PTR64=1 SSE2=1 OPTIMIZE=3 SOURCES=src/mame/drivers/3do.cpp,src/mame/drivers/8080bw.cpp,src/mame/drivers/alg.cpp,src/mame/drivers/atarittl.cpp,src/mame/drivers/bbusters.cpp,src/mame/drivers/calchase.cpp,src/mame/drivers/chihiro.cpp,src/mame/drivers/cischeat.cpp,src/mame/drivers/cops.cpp,src/mame/drivers/crystal.cpp,src/mame/drivers/cswat.cpp,src/mame/drivers/deco32.cpp,src/mame/drivers/dkong.cpp,src/mame/drivers/exidy440.cpp,src/mame/drivers/fantland.cpp,src/mame/drivers/gaelco2.cpp,src/mame/drivers/gticlub.cpp,src/mame/drivers/gunbustr.cpp,src/mame/drivers/hikaru.cpp,src/mame/drivers/hng64.cpp,src/mame/drivers/hornet.cpp,src/mame/drivers/iteagle.cpp,src/mame/drivers/jaguar.cpp,src/mame/drivers/konamigq.cpp,src/mame/drivers/konamigv.cpp,src/mame/drivers/konamigx.cpp,src/mame/drivers/konamim2.cpp,src/mame/drivers/ksys573.cpp,src/mame/drivers/lethal.cpp,src/mame/drivers/lethalj.cpp,src/mame/drivers/lindbergh.cpp,src/mame/drivers/lordgun.cpp,src/mame/drivers/mazerbla.cpp,src/mame/drivers/mediagx.cpp,src/mame/drivers/midxunit.cpp,src/mame/drivers/midyunit.cpp,src/mame/drivers/midzeus.cpp,src/mame/drivers/model2.cpp,src/mame/drivers/model3.cpp,src/mame/drivers/mw8080bw.cpp,src/mame/drivers/namconb1.cpp,src/mame/drivers/namcops2.cpp,src/mame/drivers/namcos10.cpp,src/mame/drivers/namcos11.cpp,src/mame/drivers/namcos12.cpp,src/mame/drivers/namcos22.cpp,src/mame/drivers/namcos23.cpp,src/mame/drivers/namcos2.cpp,src/mame/drivers/naomi.cpp,src/mame/drivers/nycaptor.cpp,src/mame/drivers/oneshot.cpp,src/mame/drivers/opwolf.cpp,src/mame/drivers/othunder.cpp,src/mame/drivers/playch10.cpp,src/mame/drivers/policetr.cpp,src/mame/drivers/pse.cpp,src/mame/drivers/seattle.cpp,src/mame/drivers/segas18.cpp,src/mame/drivers/segas32.cpp,src/mame/drivers/segaxbd.cpp,src/mame/drivers/segaybd.cpp,src/mame/drivers/seta2.cpp,src/mame/drivers/seta.cpp,src/mame/drivers/shootaway2.cpp,src/mame/drivers/skeetsht.cpp,src/mame/drivers/slapshot.cpp,src/mame/drivers/sshot.cpp,src/mame/drivers/ssv.cpp,src/mame/drivers/system1.cpp,src/mame/drivers/taitopjc.cpp,src/mame/drivers/taito_z.cpp,src/mame/drivers/targeth.cpp,src/mame/drivers/tickee.cpp,src/mame/drivers/triplhnt.cpp,src/mame/drivers/undrfire.cpp,src/mame/drivers/unianapc.cpp,src/mame/drivers/unico.cpp,src/mame/drivers/vcombat.cpp,src/mame/drivers/viper.cpp,src/mame/drivers/voyager.cpp,src/mame/drivers/vp101.cpp,src/mame/drivers/vsnes.cpp,src/mame/drivers/williams.cpp,src/mame/drivers/zn.cpp -j5


No final da compilação você terá um executável do MAME customizado, com
um tamanho reduzido e que vai incluir as máquinas de tiro assim como
todas as outras máquinas que esses drivers suportam. Para exibir apenas
as máquinas de tiro, use o filtro de Categoria.

