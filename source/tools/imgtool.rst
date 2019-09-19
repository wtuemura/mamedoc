Imgtool
=======


Imgtool é uma ferramenta usada para a manutenção e manipulação de
imagens de discos de diferentes tipos que os usuários precisam aprender
a usar. As funções incluem recuperar e armazenar os arquivos com
verificação/validação por CRC.

A ferramenta faz parte do projeto MAME compartilhando grande parte do
seu código e a mesma não existiria se não fosse pelo MAME.
Logo, os termos da sua distribuição seguem os mesmos termos existentes
para o MAME. Favor ler a toda :ref:`MAME-license` com atenção.

**Algumas porções do Imgtool contém direitos autorais dos Regentes da
Universidade da Califórnia (c) 1989, 1993.
Todos os direitos reservados.**

Utilização
==========

Imgtool é um programa de linha comando que contém alguns "subcomandos"
que fazem todo o trabalho. A maioria dos comandos são invocados usando
uma cadência de instruções, exemplo:

	**imgtool** <*subcommand*> <*format*> <*image*> ...

* **<subcommand>** é o nome do subcomando
* **<format>** é o formato da imagem
* **<image>** é o nome da imagem

Exemplo de uso:

|	``imgtool dir coco_jvc_rsdos myimageinazip.zip``
|	``imgtool get coco_jvc_rsdos myimage.dsk myfile.bin mynewfile.txt``
|	``imgtool getall coco_jvc_rsdos myimage.dsk``


As variações dos subcomandos serão dadas mais adiante. Observe que nem
todos os subcomandos são compatíveis ou aplicáveis em todos os
variados tipos diferentes de imagem.


Subcomandos
===========

**create**

	**imgtool create** <*format*> <*imagename*> [--(*createoption*)=value]

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem, é possível especificar um arquivo ZIP como nome da imagem


	Cria uma imagem

**dir**

	**imgtool dir** <*format*> <*imagename*> [*path*]

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Lista o conteúdo de uma imagem

**get**

	**imgtool get** <*format*> <*imagename*> <*filename*> [*newname*] [--filter=filter] [--fork=fork]

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Extrai um arquivo da imagem

**put**

	**imgtool put** <*format*> <*imagename*> <*filename*>... <*destname*> [--(*fileoption*)==value] [--filter=filter] [--fork=fork]

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Adiciona um arquivo na imagem (é compatível com coringas)

**getall**

	**imgtool getall** <*format*> <*imagename*> [*path*] [--filter=filter]

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Extrai todos os arquivos de uma imagem

**del**

	**imgtool del** <*format*> <*imagename*> <*filename*>...

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Apaga todos os arquivos de uma imagem

**mkdir**

	**imgtool mkdir** <*format*> <*imagename*> <*dirname*>

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Cria um subdiretório em uma imagem

**rmdir**

	**imgtool rmdir** <*format*> <*imagename*> <*dirname*>...

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Apaga um subdiretório em uma imagem

**readsector**

	**imgtool readsector** <*format*> <*imagename*> <*track*> <*head*> <*sector*> <*filename*>

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Lê o setor de uma imagem e grava em um nome de arquivo <*filename*> específico.

**writesector**

	**imgtool writesector** <*format*> <*imagename*> <*track*> <*head*> <*sector*> <*filename*>

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	Escreve no setor de uma imagem vinda de um arquivo <*filename*> especificado

**identify**

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo
	* <*imagename*> é o nome de destino da imagem; é possível especificar um arquivo ZIP como nome da imagem

	**imgtool identify** <*imagename*>

**listformats**

	Exibe uma lista com todos os formatos de imagem compatíveis com o imgtool

**listfilters**

	Exibe uma lista de todos os filtros compatíveis com o imgtool

**listdriveroptions**

	**imgtool listdriveroptions** <*format*>

	* <*format*> é o nome do formato da imagem, coco_jvc_rsdos por exemplo

	Exibe uma lista completa de todas as opções relacionadas a um formato em específico para os comandos 'put' e 'create'.


Filtros
=======

Os filtros são uma maneira de processar a maneira que os dados estão
sendo escritos ou lidos em uma imagem. Os filtros podem ser usados nos
comandos **get**, **put** e **getall** ao usar a opção ``--filter=xxxx``
na linha de comando. Atualmente, os seguintes filtros são compatíveis:

**ascii**

	Converte o final de linha dos arquivos para o formato apropriado

**cocobas**

	Processa programas BASIC tokenizados para Computadores TRS-80 Color (CoCo)

**dragonbas**

	Processa programas BASIC tokenizados para o Tano/Dragon Data Dragon 32/64

**macbinary**

	Processa arquivos de imagem (merged forks) Apple em formato MacBinary 

**vzsnapshot**

	[a fazer: VZ Snapshot? Descobrir o que que é isso...]

**vzbas**

	Processa programas BASIC tokenizados para o Laser/VZ

**thombas5**

	Processa programas BASIC tokenizados para o Thomson MO5 com BASIC 1.0 (apenas leitura, descriptografia automática)

**thombas7**

	Processa programas BASIC tokenizados para o Thomson TO7 com BASIC 1.0 (apenas leitura, descriptografia automática)

**thombas128**

	Processa programas BASIC tokenizados para o Thomson com BASIC 128/512 (apenas leitura, descriptografia automática)

**thomcrypt**

	Processa programas BASIC tokenizados para o Thomson BASIC, protegidos por criptografia (sem tokenização)

**bm13bas**

	Processa arquivos BASIC, Basic Master Level 3 tokenizados

Lista de formatos compatíveis
=============================


Imagem de disquete do Amiga (formato OFS/FFS) - (*amiga_floppy*)
----------------------------------------------------------------


Opções específicas de driver para o módulo 'amiga_floppy':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. O comando 'tabularcolumns' ajuda a manter a largura das tabelas nos
   formatos Latex e PDF, não muda em nada o formato HTML. O alinhamento
   destas tabelas estão configuradas como:
   'Esquerda' | 'Centro' | 'Esquerda'

.. tabularcolumns:: |L|C|L|

.. list-table:: amiga_floppy
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --density
     - dd/hd
     - Densidade
   * - --filesystem
     - ofs/ffs
     - Sistema de Arquivos
   * - --mode
     - none/intl/dirc
     - Opções do sistema de arquivos


Apple ][ imagem de disco DOS order (formato ProDOS) - (*apple2_do_prodos_525*)
------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple2_do_prodos_525':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple2_do_prodos_525
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1
     - Cabeças
   * - --tracks
     - 35
     - Pistas
   * - --sectors
     - 16
     - Setores
   * - --sectorlength
     - 256
     - Bytes por setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Apple ][ imagem de disco Nibble order (formato ProDOS) - (*apple2_nib_prodos_525*)
----------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple2_nib_prodos_525':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple2_nib_prodos_525
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1
     - Cabeças
   * - --tracks
     - 35
     - Pistas
   * - --sectors
     - 16
     - Setores
   * - --sectorlength
     - 256
     - Bytes por setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Apple ][ imagem de disco ProDOS order (formato ProDOS) - (*apple2_po_prodos_525*)
---------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple2_po_prodos_525':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple2_po_prodos_525
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1
     - Cabeças
   * - --tracks
     - 35
     - Pistas
   * - --sectors
     - 16
     - Setores
   * - --sectorlength
     - 256
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Apple ][imagem de disco gs 2IMG (formato ProDOS) - (*apple35_2img_prodos_35*)
-----------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple35_2img_prodos_35':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple35_2img_prodos_35
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 80
     - Pistas
   * - --sectorlength
     - 512
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o Apple DiskCopy (Disquete Mac HFS) - (*apple35_dc_mac_hfs*)
---------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple35_dc_mac_hfs':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple35_dc_mac_hfs
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 80
     - Pistas
   * - --sectorlength
     - 512
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o Apple DiskCopy (Disquete Mac MFS) - (*apple35_dc_mac_hfs*)
---------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple35_dc_mac_mfs':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple35_dc_mac_mfs
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 80
     - Pistas
   * - --sectorlength
     - 512
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o Apple DiskCopy (formato ProDOS) - (*apple35_dc_prodos_35*)
----------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple35_dc_prodos_35':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple35_dc_prodos_35
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 80
     - Pistas
   * - --sectorlength
     - 512
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o Apple raw 3.5" (Disquete Mac HFS) - (*apple35_raw_mac_hfs*)
----------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple35_raw_mac_hfs':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple35_raw_mac_hfs
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 80
     - Pistas
   * - --sectorlength
     - 512
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o Apple raw 3.5" (Disquete Mac MFS) - (*apple35_raw_mac_mfs*)
----------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple35_raw_mac_mfs':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple35_raw_mac_mfs
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 80
     - Pistas
   * - --sectorlength
     - 512
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o Apple raw 3.5" (formato ProDOS) - (*apple35_raw_prodos_35*)
----------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'apple35_raw_prodos_35':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: apple35_raw_prodos_35
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 80
     - Pistas
   * - --sectorlength
     - 512
     - Bytes por Setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o CoCo DMK (formato OS-9) - (*coco_dmk_os9*)
-----------------------------------------------------------------


Opções específicas de driver para o módulo 'coco_dmk_os9':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_dmk_os9
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 35-255
     - Pistas
   * - --sectors
     - 1-18
     - Setores
   * - --sectorlength
     - 128/256/512/1024/2048/4096/8192
     - Bytes por Setor
   * - --interleave
     - 0-17
     - Intercalação
   * - --firstsectorid
     - 0-1
     - Primeiro setor

.. raw:: latex

	\clearpage

Imagem de disco para o CoCo DMK (formato RS-DOS) - (*coco_dmk_rsdos*)
---------------------------------------------------------------------


Opções específicas de driver para o módulo 'coco_dmk_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_dmk_rsdos (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário [#]_


Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_dmk_rsdos (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 35-255
     - Pistas
   * - --sectors
     - 1-18
     - Setores
   * - --sectorlength
     - 128/256/512/1024/2048/4096/8192
     - Bytes por Setor
   * - --interleave
     - 0-17
     - Intercalação
   * - --firstsectorid
     - 0-1
     - Primeiro setor


Imagem de disco para o CoCo JVC (formato OS-9) - (*coco_jvc_os9*)
-----------------------------------------------------------------


Opções específicas de driver para o módulo 'coco_jvc_os9':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_jvc_os9
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 35-255
     - Pistas
   * - --sectors
     - 1-255
     - Setores
   * - --sectorlength
     - 128/256/512/1024
     - Tamanho do setor
   * - --firstsectorid
     - 0-1
     - Primeiro setor


Imagem de disco para o CoCo JVC (formato RS-DOS) - (*coco_jvc_rsdos*)
---------------------------------------------------------------------


Opções específicas de driver para o módulo 'coco_jvc_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_jvc_rsdos (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário


Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_jvc_rsdos (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 35-255
     - Pistas
   * - --sectors
     - 1-255
     - Setores
   * - --sectorlength
     - 128/256/512/1024
     - Tamanho do setor
   * - --firstsectorid
     - 0
     - Primeiro setor


Imagem de disco para o CoCo OS-9 (formato OS-9) - (*coco_os9_os9*)
------------------------------------------------------------------


Opções específicas de driver para o módulo 'coco_os9_os9':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_os9_os9
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 35-255
     - Pistas
   * - --sectors
     - 1-255
     - Setores
   * - --sectorlength
     - 128/256/512/1024
     - Tamanho do setor
   * - --firstsectorid
     - 1
     - Primeiro setor


Imagem de disco para o CoCo VDK (formato OS-9) - (*coco_vdk_os9*)
-----------------------------------------------------------------


Opções específicas de driver para o módulo 'coco_vdk_os9':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_vdk_os9
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 35-255
     - Pistas
   * - --sectors
     - 18
     - Setores
   * - --sectorlength
     - 256
     - Tamanho do setor
   * - --firstsectorid
     - 1
     - Primeiro setor


Imagem de disco para o CoCo VDK (formato RS-DOS) - (*coco_vdk_rsdos*)
---------------------------------------------------------------------


Opções específicas de driver para o módulo 'coco_vdk_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_vdk_rsdos (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário


Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: coco_vdk_rsdos (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 35-255
     - Pistas
   * - --sectors
     - 18
     - Setores
   * - --sectorlength
     - 256
     - Tamanho do setor
   * - --firstsectorid
     - 1
     - Primeiro setor


Imagem de disquete para o Concept - (*concept*)
-----------------------------------------------


Opções específicas de driver para o módulo 'concept':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (formato Basic Master Level 3) - (*cqm_bml3*)
-------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_bml3':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: cqm_bml3
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (formato FAT) - (*cqm_fat*)
------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_fat':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (Mac HFS Floppy) - (*cqm_mac_hfs*)
-------------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_mac_hfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (Disquete Mac MFS) - (*cqm_mac_mfs*)
---------------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_mac_mfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (formato OS-9) - (*cqm_os9*)
-------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_os9':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (formato ProDOS) - (*cqm_prodos_35*)
---------------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_prodos_35':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (formato ProDOS) - (*cqm_prodos_525*)
----------------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_prodos_525':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (formato RS-DOS) - (*cqm_rsdos*)
-----------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: cqm_rsdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o CopyQM (formato VZ-DOS) - (*cqm_vzdos*)
-----------------------------------------------------------------


Opções específicas de driver para o módulo 'cqm_vzdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: cqm_vzdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/binary/data
     - Tipo do arquivo
   * - --ascii
     - intern/extern
     - Nome do arquivo

Nenhuma opção específica para a criação da imagem


Sistema de arquivos para o Cybiko Classic - (*cybiko*)
------------------------------------------------------


Opções específicas de driver para o módulo 'cybiko':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. Ajustado para não quebrar o layout.

.. tabularcolumns:: |C|C|C|

.. list-table:: cybiko
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --flash
     - AT45DB041/AT45DB081/AT45DB161
     - Modelo da memória flash


Sistema de arquivos para o Cybiko Xtreme - (*cybikoxt*)
-------------------------------------------------------


Opções específicas de driver para o módulo 'cybikoxt':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (formato Basic Master Level 3) - (*d88_bml3*)
---------------------------------------------------------------------------

Opções específicas de driver para o módulo 'd88_bml3':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: d88_bml3
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (formato FAT) - (*d88_fat*)
---------------------------------------------------------


Opções específicas de driver para o módulo 'd88_fat':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (Disquete Mac HFS) - (*d88_mac_hfs*)
------------------------------------------------------------------


Opções específicas de driver para o módulo 'd88_mac_hfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (Disquete Mac MFS) - (*d88_mac_mfs*)
------------------------------------------------------------------


Opções específicas de driver para o módulo 'd88_mac_mfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (formato OS-9) - (*d88_os9*)
----------------------------------------------------------


Opções específicas de driver para o módulo 'd88_os9':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (formato OS-9) - (*d88_os9*)
----------------------------------------------------------


Opções específicas de driver para o módulo 'd88_prodos_35':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (formato ProDOS) - (*d88_prodos_525*)
-------------------------------------------------------------------


Opções específicas de driver para o módulo 'd88_prodos_525':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (formato RS-DOS) - (*d88_rsdos*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'd88_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: d88_rsdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o D88 (formato VZ-DOS) - (*d88_vzdos*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'd88_vzdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: d88_vzdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/binary/data
     - Tipo do arquivo
   * - --ascii
     - intern/extern
     - Nome do arquivo

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (formato Basic Master Level 3) - (*dsk_bml3*)
---------------------------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_bml3':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: dsk_bml3
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (formato FAT) - (*dsk_fat*)
---------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_fat':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (disquete Mac HFS) - (*dsk_mac_hfs*)
------------------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_mac_hfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete DSK (Disquete Mac MFS) - (*dsk_mac_mfs*)
-----------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_mac_mfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (formato OS-9) - (*dsk_os9*)
----------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_os9':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (formato ProDOS) - (*dsk_prodos_35*)
------------------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_prodos_35':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (formato ProDOS) - (*dsk_prodos_525*)
-------------------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_prodos_525':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (formato RS-DOS) - (*dsk_rsdos*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: dsk_rsdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o DSK (formato VZ-DOS) - (*dsk_vzdos*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'dsk_vzdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: cqm_vzdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/binary/data
     - Tipo do arquivo
   * - --ascii
     - intern/extern
     - Nome do arquivo

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (formato Basic Master Level 3) - (*fdi_bml3*)
-----------------------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_bml3':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: fdi_bml3
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (formato FAT) - (*fdi_fat*)
-----------------------------------------------------


Opções específicas de driver para o módulo 'fdi_fat':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (Disquete Mac HFS) - (*fdi_mac_hfs*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_mac_hfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (Disquete Mac MFS) - (*fdi_mac_mfs*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_mac_mfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (formato OS-9) - (*fdi_os9*)
------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_os9':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (formato ProDOS) - (*fdi_prodos_35*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_prodos_35':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (formato ProDOS) - (*fdi_prodos_525*)
---------------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_prodos_525':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (formato RS-DOS) - (*fdi_rsdos*)
----------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: fdi_rsdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de Disco Formatado (formato VZ-DOS) - (*fdi_vzdos*)
----------------------------------------------------------


Opções específicas de driver para o módulo 'fdi_vzdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: fdi_vzdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/binary/data
     - Tipo do arquivo
   * - --ascii
     - intern/extern
     - Nome do arquivo

Nenhuma opção específica para a criação da imagem


Cartão de memória para o HP48 SX/GX - (*hp48*)
----------------------------------------------


Opções específicas de driver para o módulo 'hp48':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. Ajustado para não quebrar o layout.

.. tabularcolumns:: |C|C|C|

.. list-table:: hp48
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --flash
     - AT45DB041/AT45DB081/AT45DB161
     - Modelo da memória flash

Imagem de disquete IMD (formato Basic Master Level 3) - (*imd_bml3*)
--------------------------------------------------------------------


Opções específicas de driver para o módulo 'imd_bml3':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: imd_bml3
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (formato FAT) - (*imd_fat*)
--------------------------------------------------


Opções específicas de driver para o módulo 'imd_fat':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (disquete Mac HFS) - (*imd_mac_hfs*)
-----------------------------------------------------------


Opções específicas de driver para o módulo 'imd_mac_hfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (Disquete Mac MFS) - (*imd_mac_mfs*)
------------------------------------------------------------


Opções específicas de driver para o módulo 'imd_mac_mfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (formato OS-9) - (*imd_os9*)
---------------------------------------------------


Opções específicas de driver para o módulo 'imd_os9':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (formato ProDOS) - (*imd_prodos_35*)
-----------------------------------------------------------


Opções específicas de driver para o módulo 'imd_prodos_35':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (formato ProDOS) - (*imd_prodos_525*)
------------------------------------------------------------


Opções específicas de driver para o módulo 'imd_prodos_525':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (formato RS-DOS) - (*imd_rsdos*)
-------------------------------------------------------


Opções específicas de driver para o módulo 'imd_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: imd_rsdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete IMD (formato VZ-DOS) - (*imd_vzdos*)
-------------------------------------------------------


Opções específicas de driver para o módulo 'imd_vzdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: imd_vzdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/binary/data
     - Tipo do arquivo
   * - --ascii
     - intern/extern
     - Nome do arquivo

Nenhuma opção específica para a criação da imagem


Imagem de disco rígido para o  MESS - (*mess_hd*)
-------------------------------------------------


Opções específicas de driver para o módulo 'mess_hd':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. list-table:: mess_hd
   :widths: 20 28 20
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --blocksize
     - 1-2048
     - Tamanho do Bloco
   * - --cylinders
     - 1-65536
     - Cilindros
   * - --heads
     - 1-64
     - Cabeças
   * - --sectors
     - 1-4096
     - Setores
   * - --seclen
     - | 128/256/512/1024/2048/4096
       | 8192/16384/32768/65536
     - Tamanho do setor


Disquete para o TI99 (formato PC99) - (*pc99fm*)
------------------------------------------------


Opções específicas de driver para o módulo 'pc99fm':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Disquete para o TI99 (formato PC99 MFM) - (*pc99mfm*)
-----------------------------------------------------


Opções específicas de driver para o módulo 'pc99mfm':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disco para o PC CHD - (*pc_chd*)
------------------------------------------


Opções específicas de driver para o módulo 'pc_chd':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. list-table:: pc_chd
   :widths: 20 40 20
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --cylinders
     - | 10/20/30/40/50/60/70/80/90/100/110/120
       | 130/140/150/160/170/180/190/200
     - Cilindros
   * - --heads
     - 1-16
     - Cabeças
   * - --sectors
     - 1-63
     - Setores

Imagem de disquete para o PC (formato FAT) - (*pc_dsk_fat*)
-----------------------------------------------------------


Opções específicas de driver para o módulo 'pc_dsk_fat':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: pc_dsk_fat
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Quantidade de cabeças
   * - --tracks
     - 40/80
     - Quantidade de pistas
   * - --sectors
     - 8/9/10/15/18/36
     - Quantidade de setores

Psion Organiser II Datapack - (*psionpack*)
-------------------------------------------


Opções específicas de driver para o módulo 'psionpack':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: psionpack (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --type
     - OB3/OPL/ODB
     - Tipo do arquivo
   * - --id
     - 0/145-255
     - ID do arquivo

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: psionpack (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --size
     - 8k/16k/32k/64k/128k
     - Tamanho do datapack
   * - --ram
     - 0/1
     - EPROM/RAM datapack
   * - --paged
     - 0/1
     - linear/paged datapack
   * - --protect
     - 0/1
     - datapack com escrita protegida
   * - --boot
     - 0/1
     - datapack inicializável
   * - --copy
     - 0/1
     - datapack com permissão de cópia

Imagem de disquete para o Teledisk (formato Basic Master Level 3) - (*td0_bml3*)
---------------------------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_bml3':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: td0_bml3
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (formato FAT) - (*td0_fat*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_fat':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (Disquete Mac HFS) - (*td0_mac_hfs*)
-----------------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_mac_hfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (Disquete Mac MFS) - (*td0_mac_mfs*)
-----------------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_mac_mfs':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (OS-9 format) - (*td0_os9*)
--------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_os9':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (formato ProDOS) - (*td0_prodos_35*)
-----------------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_prodos_35':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (formato ProDOS) - (*td0_prodos_525*)
------------------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_prodos_525':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (RS-DOS format) - (*td0_rsdos*)
------------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_rsdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: td0_rsdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/data/binary/assembler
     - Tipo do arquivo
   * - --ascii
     - ascii/binary
     - Sinaliza como ASCII ou binário

Nenhuma opção específica para a criação da imagem


Imagem de disquete para o Teledisk (VZ-DOS format) - (*td0_vzdos*)
------------------------------------------------------------------


Opções específicas de driver para o módulo 'td0_vzdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: td0_vzdos
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/binary/data
     - Tipo do arquivo
   * - --ascii
     - intern/extern
     - Nome do arquivo

Nenhuma opção específica para a criação da imagem


Imagem de disquete Thomson .fd, formato BASIC - (*thom_fd*)
-----------------------------------------------------------


Opções específicas de driver para o módulo 'thom_fd':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: thom_fd (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - auto/B/D/M/A
     - Tipo do arquivo
   * - --format
     - auto/B/A
     - Indicador do formato
   * - --comment
     - (string)
     - Comentário

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: thom_fd (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 40/80
     - Pistas
   * - --density
     - SD/DD
     - Densidade Simples ou Dupla
   * - --name
     - (string)
     - Nome do disquete

Imagem de disquete Thomson .fd, formato BASIC - (*thom_qd*)
-----------------------------------------------------------


Opções específicas de driver para o módulo 'thom_qd':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: thom_qd (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - auto/B/D/M/A
     - Tipo do arquivo
   * - --format
     - auto/B/A
     - Indicador do formato
   * - --comment
     - (string)
     - Comentário

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: thom_qd (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1-2
     - Cabeças
   * - --tracks
     - 25
     - Pistas
   * - --density
     - SD/DD
     - Densidade Simples ou Dupla
   * - --name
     - (string)
     - Nome do disquete

Imagem de disquete Thomson .fd, formato BASIC - (*thom_sap*)
------------------------------------------------------------


Opções específicas de driver para o módulo 'thom_sap':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: thom_sap (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - auto/B/D/M/A
     - Tipo do arquivo
   * - --format
     - auto/B/A
     - Indicador do formato
   * - --comment
     - (string)
     - Comentário

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: thom_sap (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1
     - Cabeças
   * - --tracks
     - 40/80
     - Pistas
   * - --density
     - SD/DD
     - Densidade Simples ou Dupla
   * - --name
     - (string)
     - Nome do disquete

Imagem de Disco Rígido para o TI990 - (*ti990hd*)
-------------------------------------------------


Opções específicas de driver para o módulo 'ti990hd':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: ti990hd
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --cylinders
     - 1-2047
     - Quantidade de cabeças
   * - --heads
     - 1-31
     - Quantidade de pistas
   * - --sectors
     - 1-256
     - Quantidade de Setores
   * - --bytes per sector
     - Geralmente 25256-512 256-512
     - Bytes Por Setor [A fazer: O imgtool está com falhas nesta seção]

Disquete para o TI99 (formato antigo do MESS) - (*ti99_old*)
------------------------------------------------------------


Opções específicas de driver para o módulo 'ti99_old':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: ti99_old
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --sides
     - 1-2
     - Lados
   * - --tracks
     - 1-80
     - Pistas
   * - --sectors
     - 1-36
     - Setores :menuselection:`1 --> 9 para DS, 1 --> 18 para DD, 1 --> 36 para AD`
   * - --protection
     - 0-1
     - Proteção (0 para normal, 1 para protegido)
   * - --density
     - Auto/DS/DD/AD
     - Tipos de densidade


Disco Rígido para o TI99 - (*ti99hd*)
-------------------------------------


Opções específicas de driver para o módulo 'ti99hd':

Nenhuma opção específica da imagem

Nenhuma opção específica para a criação da imagem


Disquete para o TI99 (formato V9T9) - (*v9t9*)
----------------------------------------------


Opções específicas de driver para o módulo 'v9t9':

Nenhuma opção específica da imagem

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: v9t9
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --sides
     - 1-2
     - Lados
   * - --tracks
     - 1-80
     - Pistas
   * - --sectors
     - 1-36
     - Setores :menuselection:`1 --> 9 para DS, 1 --> 18 para DD, 1 --> 36 para AD`
   * - --protection
     - 0-1
     - Proteção (0 para normal, 1 para protegido)
   * - --density
     - Auto/DS/DD/AD
     - Tipos de densidade


Imagem de disco para o Laser/VZ (formato VZ-DOS) - (*vtech1_vzdos*)
-------------------------------------------------------------------


Opções específicas de driver para o módulo 'vtech1_vzdos':

Opções específicas para o arquivo (utilizável com o comando 'put')

.. tabularcolumns:: |L|C|L|

.. list-table:: vtech1_vzdos (put)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --ftype
     - basic/binary/data
     - Tipo do arquivo
   * - --ascii
     - intern/extern
     - Nome do arquivo

Opções específicas para a criação da imagem (utilizável com o comando 'create'):

.. tabularcolumns:: |L|C|L|

.. list-table:: vtech1_vzdos (create)
   :header-rows: 1

   * - Opções
     - Valores permitidos
     - Descrição
   * - --heads
     - 1
     - Cabeças
   * - --tracks
     - 40
     - Pistas
   * - --sectors
     - 16
     - Setores
   * - --sectorlength
     - 154
     - Tamanho do setor
   * - --firstsectorid
     - 0
     - Primeiro setor


[A fazer: preencher as estruturas e descrever melhor os comandos.
Essas descrições vieram do arquivo imgtool.txt e estão muito
simplificadas]

.. [#]	ASCII flag. (Nota do tradutor)
