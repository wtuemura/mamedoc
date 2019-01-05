Como o MAME lida com o caminho dos arquivos
===========================================

O MAME obedece uma sequência lógica quando verifica os arquivos dos
usuários como ROMs e os arquivos de trapaça.


A sequência de leitura dos caminhos
-----------------------------------

Vamos usar o exemplo de um arquivo de trapaça do Sega Genesis/Megadrive
para o jogo **After Burner 2** (aburner2 na lista de jogos para
Megadrive), o caminho predefinido para o :ref:`cheatpath
<mame-commandline-cheatpath>` é cheat. A sequência de pesquisa que o
MAME utiliza para encontrar o arquivo de trapaça é demonstrado abaixo:

1.	``cheat/megadriv/aburner2.xml``
2.	``cheat/megadriv.zip`` -> ``aburner2.xml``
	Repare que ele pesquisa por um arquivo *.ZIP* primeiro, depois um
	arquivo *.7Z*.
3.	``cheat/megadriv.zip`` -> ``<qualquer caminho>/aburner2.xml``
	Caso exista, ele procurará pelo primeiro arquivo aburner2.xml que
	ele puder encontrar dentro daquele arquivo zip, independente de onde
	esteja.
4.	``cheat.zip`` -> ``megadriv/aburner2.xml``
	Agora está procurando especificamente por uma combinação de arquivo
	ou pasta, porém agora, dentro do arquivo cheat.zip.
5.	``cheat.zip`` -> ``<qualquer caminho>/megadriv/aburner2.xml``
	Como antes, caso exista, irá procurar em qualquer lugar menos dentro
	do primeiro aburner2.xml que fica dentro da pasta megadriv e que
	esteja dentro de um arquivo zip.
6.	``cheat/megadriv.7z`` -> ``aburner2.xml``
	Agora começa a procurar dentro de arquivos *.7z* [1]_.
7.	``cheat/megadriv.7z`` -> ``<qualquer caminho>/aburner2.xml``
8.	``cheat.7z`` -> ``megadriv/aburner2.xml``
9.	``cheat.7z`` -> ``<qualquer caminho>/megadriv/aburner2.xml``
	Similar aos arquivos *.zip*, porém que agora com arquivos *.7z*.


[a fazer: A leitura do conjunto de arquivos ROM é um pouco mais
complicado, adicionar CRC. Documentar isso no próximo dia ou dois.

..	[1]	7zip https://www.7-zip.org/ (Nota do tradutor).
