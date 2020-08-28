.. raw:: latex

	\clearpage

Floptool
========

Floptool é uma ferramenta para manutenção e manipulação de imagens de
disquete que os usuários precisam aprender a usar. O MAME já é
compatível com formatos de áudio em .WAV, porém muitas das imagens
existentes, podem conter outros formatos como .TAP vinda de fitas
Comodore 64, .CAS para Tandy Color Computer e assim por diante.
A ferramenta Castool irá converter esses outros formatos para .WAV caso
seja usada no MAME.

A ferramenta faz parte do projeto MAME compartilhando grande parte do
seu código e a mesma não existiria se não fosse pelo MAME.
Logo, os termos da sua distribuição seguem os mesmos termos existentes
para o MAME. Favor ler a toda :ref:`MAME-license` com atenção.


Utilização
----------

Floptool é um programa de linha comando que contém um conjunto simples
de instruções. Os comandos são invocados usando uma cadência de
instruções, exemplo:

|	**floptool identify** <*inputfile*> [<*inputfile*> ...]
|	**floptool convert** [*input_format* | *auto*] output_format <*inputfile*> <*outputile*>

* **<format>** é o formato da imagem
* **<input_format>** é o formato do arquivo de entrada, se for desconhecido, use auto
* **<output_format>** é o formato de destino do arquivo
* **<inputfile>** é o nome do arquivo que você deseja converter ou identificar
* **<outputfile>** é o nome do arquivo final que foi convertido

Exemplo de uso:

|	``floptool convert coco zaxxon.cas zaxxon.wav``
|	``floptool convert cbm arkanoid.tap arkanoid.wav``
|	``floptool convert ddp mybasicprogram.ddp mybasicprogram.wav``
|


.. raw:: latex

	\clearpage

Lista dos formatos compatívels
------------------------------

Estes são os formatos compatíveis com o Floptool usados para a conversão
em outros formatos.

.. tabularcolumns:: |l|c|l|

.. list-table:: Listagem dos formatos
   :header-rows: 1

   * - Formato
     - Descrição
     - Nome da Extensão
   * - **MFI**
     - Imagem de disquete do mame
     - mfi
   * - **DFI**
     - Formato de extração DiscFerret flux
     - dfi
   * - **IPF**
     - Imagem de disquete do SPS
     - ipf
   * - **MFM**
     - Imagem de disquete do HxC Floppy Emulator
     - mfm
   * - **ADF**
     - Imagem de disquete do Amiga ADF
     - adf
   * - **ST**
     - Imagem de disquete do Atari ST
     - st
   * - **MSA**
     - Imagem de disquete do Atari MSA
     - msa
   * - **PASTI**
     - Imagem de disquete do Atari PASTI
     - stx
   * - **DSK**
     - Formato CPC DSK
     - dsk
   * - **D88**
     - Imagem de disco do D88
     - d77, d88, 1dd
   * - **IMD**
     - Imagem de disco do IMD
     - imd
   * - **TD0**
     - Imagem de disco do Teledisk
     - td0
   * - **CQM**
     - Imagem de disco do CopyQM
     - cqm, cqi, dsk
   * - **PC**
     - Imagem de disquete do PC
     - dsk, ima, img, ufi, 360
   * - **NASLITE**
     - Imagem de disco do NASLite
     - img
   * - **DC42**
     - Imagem DiskCopy 4.2
     - dc42
   * - **A2_16SECT**
     - Imagem de disco do Apple II com 16 setores
     - dsk, do, po
   * - **A2_RWTS18**
     - Imagem tipo RWTS18 do Apple II
     - rti
   * - **A2_EDD**
     - Imagem EDD do Apple II
     - edd
   * - **ATOM**
     - Imagem de disco do Acorn Atom
     - 40t, dsk
   * - **SSD**
     - Imagem de disco do Acorn SSD
     - ssd, bbc, img
   * - **DSD**
     - Imagem de disco do Acorn DSD
     - dsd
   * - **DOS**
     - Imagem de disco do Acorn DOS
     - img
   * - **ADFS_O**
     - Imagem de disco do Acorn ADFS (OldMap)
     - adf, ads, adm, adl
   * - **ADFS_N**
     - Imagem de disco do Acorn ADFS (NewMap)
     - adf
   * - **ORIC_DSK**
     - Imagem de disco do Oric
     - dsk
   * - **APPLIX**
     - Imagem de disco do Applix
     - raw
   * - **HPI**
     - Imagem de disquete do HP9845A
     - hpi
