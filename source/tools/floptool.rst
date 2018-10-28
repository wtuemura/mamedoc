Floptool - Uma ferramenta genérica de manipulação de imagens de disquete para o MAME
====================================================================================



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


Usando o Floptool
=================

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

|	floptool convert coco zaxxon.cas zaxxon.wav
|	floptool convert cbm arkanoid.tap arkanoid.wav
|	floptool convert ddp mybasicprogram.ddp mybasicprogram.wav

.. A nice and clean way to do a page break, this case for latex and PDF
   only.
.. raw:: latex

	\clearpage

Formatos compatíveis
====================

Esses são os formatos compatíveis com o Floptool para a conversão em
outros formatos.

**MFI**

	Imagem de disquete do mame

	Nome da Extensão: mfi

**DFI**

	Formato de extração DiscFerret flux

	Nome da Extensão: dfi

**IPF**

	Imagem de disquete do SPS

	Nome da Extensão: ipf

**MFM**

	Imagem de disquete do HxC Floppy Emulator

	Nome da Extensão: mfm

**ADF**

	Imagem de disquete do Amiga ADF

	Nome da Extensão: adf

**ST**

	Imagem de disquete do Atari ST

	Nome da Extensão: st

**MSA**

	Imagem de disquete do Atari MSA

	Nome da Extensão: msa

**PASTI**

	Imagem de disquete do Atari PASTI

	Nome da Extensão: stx

**DSK**

	Formato CPC DSK

	Nome da Extensão: dsk

**D88**

	Imagem de disco do D88

	Nome da Extensão: d77, d88, 1dd

**IMD**

	Imagem de disco do IMD

	Nome da Extensão: imd

**TD0**

	Imagem de disco do Teledisk

	Nome da Extensão: td0

**CQM**

	Imagem de disco do CopyQM

	Nome da Extensão: cqm, cqi, dsk

**PC**

	Imagem de disquete de PC

	Nome da Extensão: dsk, ima, img, ufi, 360

**NASLITE**

	Imagem de disco do NASLite

	Nome da Extensão: img

**DC42**

	Imagem DiskCopy 4.2

	Nome da Extensão: dc42

**A2_16SECT**

	Imagem de disco do Apple II com 16 setores

	Nome da Extensão: dsk, do, po

**A2_RWTS18**

	Imagem tipo RWTS18 do Apple II

	Nome da Extensão: rti

**A2_EDD**

	Imagem EDD do Apple II

	Nome da Extensão: edd

**ATOM**

	Imagem de disco do Acorn Atom

	Nome da Extensão: 40t, dsk

**SSD**

	Imagem de disco do Acorn SSD

	Nome da Extensão: ssd, bbc, img

**DSD**

	Imagem de disco do Acorn DSD

	Nome da Extensão: dsd

**DOS**

	Imagem de disco do Acorn DOS

	Nome da Extensão: img

**ADFS_O**

	Imagem de disco do Acorn ADFS (OldMap)

	Nome da Extensão: adf, ads, adm, adl

**ADFS_N**

	Imagem de disco do Acorn ADFS (NewMap)

	Nome da Extensão: adf

**ORIC_DSK**

	Imagem de disco do Oric

	Nome da Extensão: dsk

**APPLIX**

	Imagem de disco do Applix

	Nome da Extensão: raw

**HPI**

	Imagem de disquete do HP9845A

	Nome da Extensão: hpi
