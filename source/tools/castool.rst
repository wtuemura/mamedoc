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
==========

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




Lista de formatos compatívels
=============================

Esses são os formatos compatíveis com o Castool para a conversão para
o format .WAV.

**A26**

	Imagem do Atari 2600 SuperCharger

	Nome da Extensão: a26

**APF**

	APF Imagination Machine

	Nome da Extensão: cas, cpf, apt

**ATOM**

	Acorn Atom

	Nome da Extensão: tap, csw, uef

**BBC**

	Acorn BBC & Electron

	Nome da Extensão: csw, uef

**CBM**

	Série Comodore 8-bits

	Nome da Extensão: tap

**CDT**

	Amstrad CPC

	Nome da Extensão: cdt

**CGENIE**

	EACA Colour Genie

	Nome da Extensão: cas

**COCO**

	Tandy Radio Shack Color Computer

	Nome da Extensão: cas

**CSW**

	Compressed Square Wave

	Nome da Extensão: csw

**DDP**

	Coleco ADAM

	Nome da Extensão: ddp

**FM7**

	Fujitsu FM-7

	Nome da Extensão: t77

**FMSX**

	MSX

	Nome da Extensão: tap, cas

**GTP**

	Elektronika inzenjering Galaksija

	Nome da Extensão: gtp

**HECTOR**

	Micronique Hector & Interact Family Computer

	Nome da Extensão: k7, cin, for

**JUPITER**

	Jupiter Cantab Jupiter Ace

	Nome da Extensão: tap

**KC85**

	VEB Mikroelektronik KC 85

	Nome da Extensão: kcc, kcb, tap, 853, 854, 855, tp2, kcm, sss

**KIM1**

	MOS KIM-1

	Nome da Extensão: kim, kim1

**LVIV**

	PK-01 Lviv

	Nome da Extensão: lvt, lvr, lv0, lv1, lv2, lv3

**MO5**

	Thomson MO-series

	Nome da Extensão: k5, k7

**MZ**

	Sharp MZ-700

	Nome da Extensão: m12, mzf, mzt

**ORAO**

	PEL Varazdin Orao

	Nome da Extensão: tap

**ORIC**

	Tangerine Oric

	Nome da Extensão: tap

**PC6001**

	NEC PC-6001

	Nome da Extensão: cas

**PHC25**

	Sanyo PHC-25

	Nome da Extensão: phc

**PMD85**

	Tesla PMD-85

	Nome da Extensão: pmd, tap, ptp

**PRIMO**

	Microkey Primo

	Nome da Extensão: ptp

**RKU**

	UT-88

	Nome da Extensão: rku

**RK8**

	Mikro-80

	Nome da Extensão: rk8

**RKS**

	Specialist

	Nome da Extensão: rks

**RKO**

	Orion

	Nome da Extensão: rko

**RKR**

	Radio-86RK

	Nome da Extensão: rk, rkr, gam, g16, pki

**RKA**

	Zavod BRA Apogee BK-01

	Nome da Extensão: rka

**RKM**

	Mikrosha

	Nome da Extensão: rkm

**RKP**

	SAM SKB VM Partner-01.01

	Nome da Extensão: rkp

**SC3000**

	Sega SC-3000

	Nome da Extensão: bit

**SOL20**

	PTC SOL-20

	Nome da Extensão: svt

**SORCERER**

	Exidy Sorcerer

	Nome da Extensão: tape

**SORDM5**

	Sord M5

	Nome da Extensão: cas

**SPC1000**

	Samsung SPC-1000

	Nome da Extensão: tap, cas

**SVI**

	Spectravideo SVI-318 & SVI-328

	Nome da Extensão: cas

**TO7**

	Thomson TO-series

	Nome da Extensão: k7

**TRS8012**

	TRS-80 Level 2

	Nome da Extensão: cas

**TVC64**

	Videoton TVC 64

	Nome da Extensão: cas

**TZX**

	Sinclair ZX Spectrum

	Nome da Extensão: tzx, tap, blk

**VG5K**

	Philips VG 5000

	Nome da Extensão: k7

**VTECH1**

	Video Technology Laser 110-310

	Nome da Extensão: cas

**VTECH2**

	Video Technology Laser 350-700

	Nome da Extensão: cas

**X07**

	Canon X-07

	Nome da Extensão: k7, lst, cas

**X1**

	Sharp X1

	Nome da Extensão: tap

**ZX80_O**

	Sinclair ZX80

	Nome da Extensão: o, 80

**ZX81_P**

	Sinclair ZX81

	Nome da Extensão: p, 81

