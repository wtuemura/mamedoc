Os sistemas emulados
~~~~~~~~~~~~~~~~~~~~

O ProjectMESS contém uma lista completa dos sistemas atualmente
emulados. Note que ter um sistema emulado, não significa que
a emulação dele é perfeita. Caso queira:

1. Verifique a condição geral da emulação nas páginas wiki de cada
   sistema. Para o **Apple Macintosh**, por exemplo, consulte o arquivo
   driver ``src/mame/apple/macii.cpp``. Consulte também os drivers do
   Mac Plus e Mac SE em ``src/mame/apple/mac128.cpp``.
2. Ao abrir esses arquivos, desça até o final da página e identifique as
   linhas "**COMP**". Abaixo de "**NAME**", estão os nomes dos sistemas
   que podem ser iniciados na linha de comando: ``mame NAME`` ou ao
   digitar "**NAME**" na interface gráfica do MAME para identificá-los e
   iniciá-los. Se o sistema que deseja iniciar estiver marcado como
   **MACHINE_NOT_WORKING**, à direita, significa que a emulação ainda
   não está completa e o sistema não funcionará direito.
3. Além disso, é necessário ler os registros correspondentes no arquivo
   **sysinfo.dat** para entender quais problemas podem ser encontrados
   durante a execução de um sistema no MAME (para o Apple Macintosh
   Plus, também é necessário verificar esse arquivo).

.. tip:: Em sistemas marcados como "**MACHINE_NOT_WORKING**", ao tentar
   iniciá-lo, o MAME exibe um alerta em vermelho bem grande na tela.
.. note:: Se quiser assumir o risco de iniciar uma máquina dessas, não
   relate qualquer tipo de problema aos desenvolvedores, pois é bem
   provável que eles já sejam conhecidos, mas não há informação ou
   conhecimento para resolvê-los.

Como alternativa, é possível verificar essa condição por conta própria,
caso haja, prestando atenção à tela de aviso vermelha ou bege que
aparece antes do início da emulação. Caso tenha informações que possam
ajudar a melhorar a emulação de um sistema emulado ou queira contribuir
com correções, ou novas adições ao código-fonte atual, siga as
instruções na página de contato ou poste uma
mensagem no Fórum do MAME em `https://forum.mamedev.org/
<https://forum.mamedev.org/>`_.

Grande parte do MAME é programado em C/C++  e outras linguagens
auxiliares. Atualmente o MAME consegue emular mais de 3200 sistemas
independentes das últimas cinco décadas.


A compatibilidade dos sistemas operacionais
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

O código-fonte atual pode ser compilado diretamente nos principais
sistemas operacionais: Microsoft Windows (ambos com suporte nativo para
DirectX/BGFX ou com suporte SDL), Linux, FreeBSD e macOS. Há ainda
compatibilidade com as versões de 32 e de 64 bits. A versão de 64 bits
apresenta um desempenho consideravelmente melhor que a de 32 bits.


Requisitos do sistema
~~~~~~~~~~~~~~~~~~~~~

O desenvolvimento do MAME gira em torno das linguagens C/C++ e já foi
adaptado para diferentes plataformas. Conforme o equipamento físico dos
computadores evolui, o código do MAME também evolui para aproveitar
melhor o maior poder de processamento e os novos recursos.

Os pacotes binários oficiais do MAME são compilados e projetados para
rodar no Windows. Os requisitos mínimos são:

* Uma CPU x86-64 que implemente o conjunto de recursos x86-64v2
  (comparação/troca de 16 bytes, instruções ``lahf``/``sahf`` no modo
  longo, instrução de contagem de população e SSE 4.2);
* Uma CPU Arm que implemente o conjunto de recursos ARMv8.2-A;
* Uma edição de 64 bits do Windows 7, Windows 10 ou posterior para
  x86-64, ou posterior para Arm;
* 4 GiB de RAM.
* DirectC 9.0c para Windows;
* Uma GPU compatível com Direct3D ou OpenGL com suporte para tamanhos de
  textura que não sejam potências de dois;

Em geral, qualquer CPU x86-64 a partir de 2015 ou a grande maioria das
CPUs ARM de 64 bits a partir de 2018 deve ser adequada. É possível
compilar o MAME com suporte para CPUs mais antigas, mas haverá perda de
desempenho.

Claro, os requisitos mínimos são apenas um exemplo. Nem sempre é
possível obter o melhor desempenho com a configuração acima, mas o MAME
deverá rodar sem maiores problemas. As versões mais recentes do MAME
tendem a exigir mais recursos do equipamento do que as versões
anteriores. Assim, as versões mais antigas do MAME podem ter um
desempenho melhor em um PC mais fraco, mas você pode perder as melhorias
implementadas na versão mais recente, os novos sistemas adicionados e
nas correções posteriores à versão do MAME que estiver usando.

O MAME aproveita os recursos 3D do equipamento físico para exibir
ilustrações (*artworks*) e redimensionar o software ou o jogo na tela
inteira. Para usufruir desses benefícios, é necessário ter uma placa de
vídeo mais recente, capaz de lidar com Direct3D 11, e no mínimo 2 GiB de
memória RAM.

Os filtros especiais HLSL ou GLSL, assim como o efeito de simulação de
uma tela de tubo CRT, causam uma sobrecarga extra na emulação,
especialmente em resoluções mais altas. É preciso ter uma placa de vídeo
moderna o bastante para aguentar o tranco, pois a carga do processamento
aumenta exponencialmente à medida que se aumenta também a resolução. Se
o HLSL ou o GLSL estiverem muito pesados, tente reduzir o tamanho da
resolução do vídeo do sistema emulado.

Tenha sempre em mente que, mesmo usando os computadores mais rápidos
disponíveis hoje, o MAME ainda é incapaz de rodar alguns sistemas em sua
velocidade nativa. O principal objetivo do projeto não é fazer com que
todos os sistemas emulados rodem em sua velocidade nativa, seja no seu
computador ou em qualquer outro lugar onde o MAME esteja sendo
executado; o interesse do projeto é documentar o hardware e reproduzir
seu comportamento original com a maior fidelidade possível.


As extrações da BIOS e dos programas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para que o MAME consiga emular a maioria desses sistemas, é necessário
extrair o conteúdo dos circuitos integrados originais desses aparelhos.
Isso pode ser feito por meio da extração desses dados do aparelho
original, ou da busca por eles na internet por sua conta e risco.

O MAME não fornece, disponibiliza ou vem acompanhado desses dados
justamente pelo fato de estarem protegidos por leis de direitos
autorais. Se tiver interesse em encontrar algum software que rode em um
dos sistemas já emulados, lembre-se de que o Google e outros sites de
pesquisa são os seus melhores amigos.
