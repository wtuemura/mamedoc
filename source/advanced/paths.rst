Como o MAME lida com o caminho dos arquivos
===========================================

O MAME obedece uma sequência lógica quando verifica os arquivos dos
usuários como ROMs e os arquivos de trapaça.


A sequência de leitura dos caminhos
-----------------------------------

Vamos usar o exemplo de um arquivo de trapaça do Sega Genesis/Megadrive
para o jogo After Burner 2 (aburner2 na lista de jogos para Megadrive),
o caminho predefinido para o "cheatpath" é cheat. É assim que o MAME vai
fazer a pesquisa por um arquivo de trapaça:

1.	cheat/megadriv/aburner2.xml
2.	cheat/megadriv.zip -> aburner2.xml
	Repare que ele pesquisa por um arquivo *.ZIP* primeiro, depois um
	arquivo *.7Z*.
3.	cheat/megadriv.zip -> <arbitrary path>/aburner2.xml
	Ele procurará (caso haja) pelo primeiro arquivo aburner2.xml que
	ele puder encontrar dentro daquele arquivo zip, independente de onde
	esteja.
4.	cheat.zip -> megadriv/aburner2.xml
	Agora está procurando especificamente por uma combinação de arquivo
	ou pasta, porém agora, dentro do arquivo cheat.zip.
5.	cheat.zip -> <qualquer caminho>/megadriv/aburner2.xml
	Como antes, menos dentro do primeiro (se houver) o arquivo
	aburner2.xml dentro da pasta megadriv que esteja dentro de um
	arquivo zip.
6.	cheat/megadriv.7z -> aburner2.xml
	Agora começa a procurar dentro de arquivos *7ZIP*.
7.	cheat/megadriv.7z -> <qualquer caminho>/aburner2.xml
8.	cheat.7z -> megadriv/aburner2.xml
9.	cheat.7z -> <qualquer caminho>/megadriv/aburner2.xml
	Similar ao zip, soque agora com arquivos *7ZIP*.


[a fazer: A leitura do conjunto de arquivos ROM é um pouco mais
complicado, adicionar CRC. Documentar isso no próximo dia ou dois.
