
.. raw:: latex

	\clearpage

Como o MAME lida com o caminho dos arquivos
===========================================

O MAME obedece uma sequência lógica quando verifica os arquivos dos
usuários como ROMs e os arquivos de trapaça.

A sequência de leitura dos caminhos
-----------------------------------

Usando o exemplo de um arquivo de trapaça do Sega Genesis/Megadrive
para o jogo **After Burner 2** (**aburner2** na lista de software para
Megadrive), o caminho predefinido para o :ref:`cheatpath
<mame-commandline-cheatpath>` é **cheat**. A sequência de pesquisa que o
MAME utiliza para encontrar o arquivo de trapaça é demonstrado abaixo:

1.	cheat/megadriv/aburner2.xml
		Primeiro caminho a ser pesquisado.

2.	:menuselection:`cheat/megadriv.zip --> aburner2.xml`
		Repare que primeiro é pesquisado um arquivo **.zip** e depois um
		arquivo **.7z**.

3.	:menuselection:`cheat/megadriv.zip --> <qualquer caminho>/aburner2.xml`
		Caso exista, será procurado pelo primeiro arquivo
		**aburner2.xml** que for encontrado dentro daquele arquivo zip,
		independente de onde esteja.

4.	:menuselection:`cheat.zip --> megadriv/aburner2.xml`
		A próxima pesquisa será feita por uma combinação de arquivo ou
		diretório, porém agora, dentro do arquivo de trapaça cheat.zip.

5.	:menuselection:`cheat.zip --> <qualquer caminho>/megadriv/aburner2.xml`
		Caso exista, irá procurar em qualquer lugar menos dentro do
		primeiro **aburner2.xml** que fica dentro do diretório
		**megadriv** e que esteja dentro de um arquivo zip.

6.	:menuselection:`cheat/megadriv.7z --> aburner2.xml`
		A próxima pesquisa é feita agora dentro de arquivos **.7z** [1]_.

7.	:menuselection:`cheat/megadriv.7z --> <qualquer caminho>/aburner2.xml`
		Em sequência a pesquisa é feita em qualquer outro caminho
		próximo.

8.	:menuselection:`cheat.7z --> megadriv/aburner2.xml`
		Similar aos arquivos **.zip**, porém agora com arquivos **.7z**.

9.	:menuselection:`cheat.7z --> <qualquer caminho>/megadriv/aburner2.xml`
		Similar aos itens **7** e **8**.

[a fazer: A leitura do conjunto de arquivos ROM é um pouco mais
complicado, adicionar CRC. Documentar isso no próximo dia ou dois.

..	[1]	7zip https://www.7-zip.org/ (Nota do tradutor).
