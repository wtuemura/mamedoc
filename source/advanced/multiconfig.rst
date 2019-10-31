.. _advanced-multi-CFG:

Múltiplos arquivos de configuração
==================================

.. contents:: :local:

O MAME tem um poderoso sistema de configuração que permite ajustar as
opções de cada jogo, sistema ou até mesmo um tipo de monitor em
específico de maneira individual, porém requer um cuidado especial na
organização das configurações.

.. raw:: latex

	\clearpage

.. _advanced-multi-cfg-ordem-leitura:

A ordem da leitura dos arquivos
-------------------------------

1. A linha de comando é interpretada primeiro e tem prioridade sobre
   qualquer outro arquivo *.ini*.

2. O ``mame.ini`` (ou qualquer outra plataforma que use um *.ini* como o
   ``mess.ini`` por exemplo) são interpretadas duas vezes. Na primeira
   passada pode alterar várias configurações de caminho, a segunda
   passagem é feita para ver se há um arquivo de configuração válido
   nesse novo local (caso haja, altera as configurações com as
   informações desse arquivo).


3. O ``debug.ini`` se estiver no modo de depuração. Este é um arquivo de
   configuração avançado que a maioria das pessoas não precisam sequer
   se preocupar com ele.

4. Arquivos INI de orientação de tela (seja ``horizont.ini`` ou
   ``vertical.ini``).
   O jogo Pac-Man por exemplo usa uma tela vertical, assim o arquivo
   ``vertical.ini`` é lido. Enquanto jogo **Street Fighter Alpha** é um
   jogo com tela horizontal, assim o arquivo ``horizont.ini`` é lido.

   Geralmente o arquivo ``horizont.ini`` será lodo em sistemas sem
   monitores, com monitores diversos com orientações diferentes ou
   monitores conectados em dispositivos de slot.


5. Arquivos INI voltado para diferentes sistemas (``arcade.ini``,
   ``console.ini``, ``computer.ini``, ou ``othersys.ini``).
   Tanto o jogo **Pac-Man** quanto o jogo **Street Fighter Alpha**
   são jogos de arcade, então o arquivo a ser lido seria o
   ``arcade.ini``, enquanto um console como o **Atari 2600** o
   ``console.ini`` será lido.

6. Os arquivos INI voltados para diferentes tipos de tela
   (``vector.ini`` para jogos vetoriais, ``raster.ini`` para jogos
   rasterizados, ``lcd.ini`` para jogos em telas de cristal
   líquido (LCD), EL, Plasma).
   Ambos os jogos **Pac-Man** e **Street Fighter Alpha** são jogos
   rasterizados, então o arquivo a ser lido seria o ``raster.ini``,
   enquanto Tempest é um jogo com tela vetorial, então o arquivo
   a ser lido é o ``vector.ini``.
   
   Para sistemas que tenham mais de um monitor como *House Mannequin*,
   que usa um monitor CRT raster e um um par de telas em cristal
   líquido, são lidos os arquivos ``raster.ini`` e ``lcd.ini`` relevantes
   ao primeiro monitor e as outras respectivas telas.

7. Os arquivos INI voltados para arquivos fonte do driver. O MAME
   tentará ler ``source/``\ *<sourcefile>*\ ``.ini`` onde <*sourcefile*>
   é o nome do arquivo de código fonte onde o driver do sistema for
   definido. O código fonte de um sistema pode ser encontrado usando o
   comando **mame -listsource <pattern>**, exemplo. ::

	mame.exe -listsource sfa
	sfa             cps2.cpp

   O Banpresto **Sailor Moon**, Atlus **Dodonpachi** e Nihon System
   **Dangun Feveron** por exemplo, todos rodam em hardware semelhante e
   estão listados no arquivo de código fonte ``cave.cpp``, assim todos
   eles usarão o arquivo ``source/cave.ini`` neste caso.

8. Arquivos INI para BIOS (caso seja aplicável). O **The Last Soldier**
   por exemplo usa a BIOS do **Neo-Geo MVS**, assim o arquivo
   ``neogeo.ini`` será lido. Nenhum arquivo INI será lido em sistemas
   que não usem uma BIOS.

9. Arquivo INI da mesma família. O **The Last Soldier** é um clone do
   **The Last Blade / Bakumatsu Roman - Gekka no Kenshi**, assim o arquivo
   ``lastblad.ini`` será lido. Nenhum arquivo INI da mesma família será
   lido.

10. Arquivo INI do sistema. Usando o exemplo anterior, o arquivo
    ``lastsold.ini`` será lido para o **The Last Soldier**.

.. raw:: latex

	\clearpage

.. _advanced-multi-cfg-exemplo-seq:

Exemplos da sequência de leitura dos arquivos
---------------------------------------------

* O Brix que é um clone de Zzyzzyxx. (**mame brix**)

  1. Linha de comando
  2. ``mame.ini`` (global)
  3. (caso o depurador não esteja habilitado, nenhum arquivo INI extra será lido)
  4. ``vertical.ini`` (orientação de tela)
  5. ``arcade.ini`` (tipo do sistema)
  6. ``raster.ini`` (tipo do monitor)
  7. ``source/jack.ini`` (configuração específica para o driver)
  8. (nenhuma BIOS definida)
  9. ``zzyzzyxx.ini`` (sistema da mesma família)
  10. ``brix.ini`` (sistema)

* Super Street Fighter 2 Turbo (**mame ssf2t**)

  1. Linha de comando
  2. ``mame.ini`` (global)
  3. (caso o depurador não esteja habilitado, nenhum arquivo INI extra será lido)
  4. ``horizont.ini`` (orientação de tela)
  5. ``arcade.ini`` (tipo do sistema)
  6. ``raster.ini`` (tipo do monitor)
  7. ``source/cps2.ini`` (configuração específica para o driver)
  8. (nenhuma BIOS definida)
  9. (nenhum sistema da mesma família)
  10. ``ssf2t.ini`` (sistema)

* Final Arch (**mame finlarch**)

  1. Command line
  2. ``mame.ini`` (global)
  3. (caso o depurador não esteja habilitado, nenhum arquivo INI extra será lido)
  4. ``horizont.ini`` (orientação de tela)
  5. ``arcade.ini`` (tipo do sistema)
  6. ``raster.ini`` (tipo do monitor)
  7. ``source/stv.ini`` (configuração específica para o driver)
  8. ``stvbios.ini`` (BIOS definida)
  9. ``smleague.ini`` (sistema da mesma família)
  10. ``finlarch.ini`` (sistema)

*Lembre-se que os parâmetros na linha de comando tem preferência sobre
todos os outros arquivos!*

.. _advanced-multi-cfg-usando:

Usando diferentes arquivos de configuração
------------------------------------------

O MAME oferece a possibilidade de criar diferentes tipos de configuração
separada por algumas categorias ou pelo nome dos drivers em vez de
concentrar todas as configurações em um único arquivo como o
``mame.ini``. E para quê isso?

O MAME possuí dezenas de opções disponíveis para configurar outra
dezena de coisas como áudio, vídeo, controladores diversos, etc. A linha
de comando pode ficar bem grande e complexa dependendo do sistema a ser
emulado e variar de sistema para sistema. Criando diferentes tipos de
arquivos de configuração, é possível armazenar as diferentes opções
individuais para cada sistema encurtando também o tamanho da linha de
comando uma vez que as opções agora podem ficar armazenadas em seus
respectivos arquivos de configuração.

Podemos citar como exemplo a opção de vídeo, no Windows o MAME por
predefinição escolhe ``d3d`` como a melhor opção, porém caso seja
necessário o uso de outras opções como ``opengl`` ou até mesmo ``gdi``
se for o caso, em vez de usar esta opção toda a vez que for iniciar
alguma emulação, é possível definir como um padrão para todos os
sistemas dentro do arquivo ``mame.ini``.

O arquivo ``mame.ini`` afeta a configuração de forma global porém
algumas vezes há a necessidade de customizar apenas alguns sistemas em
específico sem que haja qualquer tipo de configuração cruzada onde a
configuração de um sistema afete o outro e vice versa. Como definir uma
configuração apenas para sistemas que usem vetores sem que essa
configuração afete sistemas que usem pixel (raster) por exemplo.

.. raw:: latex

	\clearpage
