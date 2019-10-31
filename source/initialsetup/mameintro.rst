Os sistemas emulados
====================

O ProjectMESS contém uma lista completa dos sistemas atualmente
emulados. Note que ter um sistema emulado, não significa que
a emulação dele está perfeita. Caso queira:

1. Verificar o status da emulação nas páginas wiki de cada sistema,
   acessível a partir da página de drivers (por exemplo, para o Apple
   Macintosh, olhe o arquivo de driver mac.cpp, é possível também acessar
   as páginas do **macplus** e **macse**),
2. Assim como ler também os registros correspondentes no arquivo
   **sysinfo.dat** para entender melhor quais problemas é possível
   encontrar durante a execução de um sistema no MAME. (para o Apple
   Macintosh Plus, também é necessário verificar esse arquivo).

Como alternativa, é possível ver essa condição por conta própria,
caso haja, prestando atenção na tela de aviso vermelha ou bege que
aparece antes do inicio da emulação. Observe que, caso tenha
informações que possam ajudar a melhorar a emulação de um sistema
emulado ou se você puder contribuir com correções e/ou novas adições ao 
código fonte atual, siga as instruções na página de contato ou poste uma
mensagem no Fórum do MAME em `https://forum.mamedev.org/
<https://forum.mamedev.org/>`_

A maior parte do MAME é programado em C++, alguns componentes principais
em C e outras linguagens auxiliares. Atualmente o MAME consegue emular
mais de 3200 sistemas independentes das últimas 5 décadas.

Os sistemas operacionais compatíveis
====================================

O código fonte atual pode ser compilada diretamente nos principais
sistemas operacionais: Microsoft Windows (ambos com suporte nativo para
DirectX/BGFX ou com suporte SDL), Linux, FreeBSD e Max OS X. Além disso
há suporte para ambas as versões de 32 e 64 bits, saiba que a versão
64 bits mostra um improviso significativo na performance se comparado
com a versão de 32 bits.

Requisitos do sistema
=====================

O desenvolvimento do MAME gira em torno das linguagens C/C++ e já foi
portado para diferentes plataformas. Com o passar do tempo, à medida que
o hardware do computador vai evoluindo, o código do MAME evolui junto
para aproveitar melhor o maior poder de processamento e os novos
recursos de hardware.

Os binários oficiais do MAME são compilados e projetados para rodar em
qualquer sistema Windows. Os requisitos mínimos são:

* Processador Intel Core ou equivalente com pelo menos 2.0 GHz
* Sistema Operacional de 32-bit (Windos Vista SP1 ou mais recente, Mac
  10.9 ou mais recente)
* 4 GB de RAM
* DirectX 9.0c para Windows
* Uma placa gráfica compatível com Direct3D ou OpenGL
* Qualquer placa de som compatível com DirectSound

Claro, os requisitos mínimos são apenas um pequeno exemplo. Nem sempre é
possível obter o melhor desempenho usando a configuração acima, mas
o MAME deverá rodar sem maiores problemas. As versões mais recentes do
MAME tendem a exigir mais recursos de hardware do que as suas versões
anteriores, assim, versões mais antigas do MAME poderão ter uma
performance melhor em um PC mais fraco ao custo de perder as melhorias
feitas nos sistemas existentes e dos novos sistemas que foram
adicionados e correções posteriores a versão do MAME que estiver usando.

O MAME tira vantagem dos recursos de hardware 3D para a exibição das
ilustrações assim como o redimensionamento do software ou jogo para tela
inteira. Para fazer uso destes benefícios, é obrigatório ter uma placa
de vídeo mais recente capaz de lidar com Direct3D 8 e com pelo menos
16 MB de memória RAM.

Os filtros especiais HLSL ou GLSL assim como o efeito de simulação de
tela de tubo CRT, causam uma sobrecarga extra na emulação, especialmente
em resoluções mais altas. Exigindo uma placa de vídeo moderna o bastante
para aguentar o tranco, pois a carga de processamento sobe
exponencialmente à medida que se aumenta também a resolução. Caso HLSL
ou GLSL fiquem muito pesado, tente reduzir o tamanho da resolução de
vídeo da emulação.

Tenha sempre em mente que, mesmo usando os computadores mais rápidos
disponíveis hoje, o MAME ainda é incapaz de rodar alguns sistemas em
sua velocidade nativa. O principal objetivo do projeto não é fazer com
que todos os sistemas emulados rodem na sua velocidade nativa, seja no
seu computador ou seja lá onde o MAME esteja sendo rodado; o principal
objetivo é documentar o hardware e reproduzir o seu comportamento
original tão fielmente quanto for possível.

Extrações de BIOS e programas
-----------------------------

Para que o MAME consiga emular a maioria destes sistemas, o conteúdo dos
circuitos integrados originais destes aparelhos precisam ser extraídos.
Isso pode ser feito extraindo estes dados do aparelho original você
mesmo, ou procurando por eles na internet por sua conta e risco.

O MAME não fornece, disponibiliza ou vem acompanhado de nenhum deles
justamente pelo fato desses conteúdos estarem protegidos por leis de
direitos autorais. Caso tenha interesse em encontrar algum software que
rode em uma das máquinas já emuladas, lembre-se, o Google e outros sites
de pesquisa são os seus melhores amigos nessas horas.

