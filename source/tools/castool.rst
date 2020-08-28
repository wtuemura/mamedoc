.. raw:: latex

	\clearpage

Castool
=======

Castool é uma ferramenta para manutenção e manipulação de imagens de
fita k7 que os usuários precisarão aprender a usar. O MAME já é
compatível com formatos de áudio em .WAV, porém muitas das imagens
existentes, podem conter outros formatos como .TAP vinda de fitas
Comodore 64, .CAS para Tandy Color Computer e assim por diante.
A ferramenta Castool irá converter esses outros formatos para .WAV
caso seja usada no MAME.

A ferramenta faz parte do projeto MAME. Ele compartilha grande parte do
seu código com o MAME e a mesma não existiria se não fosse pelo MAME.
Logo os termos da sua distribuição seguem os mesmos termos existentes
para o MAME.
Favor ler a toda :ref:`MAME-license` com atenção.


Utilização
----------

Castool é um programa de linha comando que contém um conjunto simples de
instruções. Os comandos são invocados usando uma cadência de instruções,
exemplo:

	**castool convert** <*format*> <*inputfile*> <*outputfile*>

* **<format>** é o formato da imagem
* **<inputfile>** é o nome do arquivo que você estiver convertendo
* **<outputfile>** é o nome de saída do arquivo WAV

Exemplo de uso:

|	``castool convert coco zaxxon.cas zaxxon.wav``
|	``castool convert cbm arkanoid.tap arkanoid.wav``
|	``castool convert ddp mybasicprogram.ddp mybasicprogram.wav``
|


Lista dos formatos compatívels
------------------------------

Estes são os formatos compatíveis com o Castool para a conversão dos
arquivos para o formato WAV.

.. tabularcolumns:: |l|c|l|

.. list-table:: Listagem dos formatos
   :header-rows: 1

   * - Formato
     - Descrição
     - Nome da Extensão
   * - **A26**
     - Imagem do Atari 2600 SuperCharger
     - a26
   * - **APF**
     - APF Imagination Machine
     - cas, cpf, apt
   * - **ATOM**
     - Acorn Atom
     - tap, csw, uef
   * - **BBC**
     - Acorn BBC & Electron
     - csw, uef
   * - **CBM**
     - Série Comodore 8-bits
     - tap
   * - **CDT**
     - Amstrad CPC
     - cdt
   * - **CGENIE**
     - EACA Colour Genie
     - cas
   * - **COCO**
     - Tandy Radio Shack Color Computer
     - cas
   * - **CSW**
     - Compressed Square Wave
     - csw
   * - **DDP**
     - Coleco ADAM
     - ddp
   * - **FM7**
     - Fujitsu FM-7
     - t77
   * - **FMSX**
     - MSX
     - tap, cas
   * - **GTP**
     - Elektronika inzenjering Galaksija
     - gtp
   * - **HECTOR**
     - Micronique Hector & Interact Family Computer
     - k7, cin, for
   * - **JUPITER**
     - Jupiter Cantab Jupiter Ace
     - tap
   * - **KC85**
     - VEB Mikroelektronik KC 85
     - kcc, kcb, tap, 853, 854, 855, tp2, kcm, sss
   * - **KIM1**
     - MOS KIM-1
     - kim, kim1
   * - **LVIV**
     - PK-01 Lviv
     - lvt, lvr, lv0, lv1, lv2, lv3
   * - **MO5**
     - Thomson MO-series
     - k5, k7
   * - **MZ**
     - Sharp MZ-700
     - m12, mzf, mzt
   * - **ORAO**
     - PEL Varazdin Orao
     - tap
   * - **ORIC**
     - Tangerine Oric
     - tap
   * - **PC6001**
     - NEC PC-6001
     - cas
   * - **PHC25**
     - Sanyo PHC-25
     - phc
   * - **PMD85**
     - Tesla PMD-85
     - pmd, tap, ptp
   * - **PRIMO**
     - Microkey Primo
     - ptp
   * - **RKU**
     - UT-88
     - rku
   * - **RK8**
     - Mikro-80
     - rk8
   * - **RKS**
     - Specialist
     - rks
   * - **RKO**
     - Orion
     - rko
   * - **RKR**
     - Radio-86RK
     - rk, rkr, gam, g16, pki
   * - **RKA**
     - Zavod BRA Apogee BK-01
     - rka
   * - **RKM**
     - Mikrosha
     - rkm
   * - **RKP**
     - SAM SKB VM Partner-01.01
     - rkp
   * - **SC3000**
     - Sega SC-3000
     - bit
   * - **SOL20**
     - PTC SOL-20
     - svt
   * - **SORCERER**
     - Exidy Sorcerer
     - tape
   * - **SORDM5**
     - Sord M5
     - cas
   * - **SPC1000**
     - Samsung SPC-1000
     - tap, cas
   * - **SVI**
     - Spectravideo SVI-318 & SVI-328
     - cas
   * - **TO7**
     - Thomson TO-series
     - k7
   * - **TRS8012**
     - TRS-80 Level 2
     - cas
   * - **TVC64**
     - Videoton TVC 64
     - cas
   * - **TZX**
     - Sinclair ZX Spectrum
     - tzx, tap, blk
   * - **VG5K**
     - Philips VG 5000
     - k7
   * - **VTECH1**
     - Video Technology Laser 110-310
     - cas
   * - **VTECH2**
     - Video Technology Laser 350-700
     - cas
   * - **X07**
     - Canon X-07
     - k7, lst, cas
   * - **X1**
     - Sharp X1
     - tap
   * - **ZX80_O**
     - Sinclair ZX80
     - o, 80
   * - **ZX81_P**
     - Sinclair ZX81
     - p, 81
