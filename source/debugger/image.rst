.. _debugger-image-list:

Comandos para depuração de imagem
=================================

Na interface de depuração do MAME você pode digitar **help <command>**
para uma melhor descrição de cada comando.

| :ref:`debugger-command-images` -- lista todos os dispositivos de imagens arquivos montados
| :ref:`debugger-command-mount` -- monta um arquivo para um dispositivo
| :ref:`debugger-command-unmount` -- desmonta um aquivo de uma dispositivo específico
|

 .. _debugger-command-images:

images
------

|  **images**
|
| Usado para exibir na tela uma lista de dispositivos de imagens disponíveis.
|
| Exemplos:
|
|  ``images``
|
| Mosta uma lista de dispositivos e arquivos montados para o driver atual.
|

 .. _debugger-command-mount:

mount
-----

|  **mount** <*device*>,<*filename*>
|
| Monta o dispositivo <*device*> com o nome de arquivo <*filename*> da imagem.
|
| O nome do arquivo <*filename*> pode ser o item na lista de software ou o caminho completo do arquivo.
|
| Exemplos:
|
|  ``mount cart,aladdin``
|
| Monta a lista de software com o item aladdin no dispositivo de cartucho.
|

 .. _debugger-command-unmount:

unmount
-------

|  **unmount** <*device*>
|
| Desmonta o arquivo de imagem do dispositivo <*device*>.
|
| Exemplos:
|
|  ``unmount cart``
|
| Desmonta qualquer arquivo montado no dispositivo cart.
|
