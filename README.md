# Documentação MAME para o Português do Brasil

| Formatos        | Condição           |
| ------------- |:-------------:| 
HTML, PDF, EPUB| [![Documentation Status](https://readthedocs.org/projects/mamedoc/badge/?version=latest)](https://mamedoc.readthedocs.io/pt/latest/?badge=latest)

Para ler o documento online acesse a página oficial do projeto no link
abaixo, lá também se encontram os arquivos em HTML, PDF e e-PUB:

https://mamedoc.readthedocs.io

# Sobre

Tradução não oficial da documentação do MAME para o Português do Brasil.
Todo o texto fonte oficial foi obtido do site:
https://github.com/mamedev/mame/tree/master/docs

Este documento não tem qualquer relação com o documento oficial e tão
pouco com o projeto MAME, apesar de utilizá-lo como referência. Este
projeto teve inicio como uma tradução porém por diversas razões se
tornou um trabalho independente sem no entanto ignorar as atualizações
da documentação oficial e assim como abordando tópicos que não existem
na documentação oficial, tópicos estes que foram pedidos por alguns
membros da comunidade brasileira que gostam de emuladores e em especial
o MAME.

# Compilando este documento para outros formatos

## Fedora

Instale os seguintes pacotes:

```
sudo dnf install python3-sphinx python2-sphinx python3-sphinx-bootstrap-theme python3-sphinxcontrib-rsvgconverter inkscape librsvg2-tools latexmk texlive-cmap texlive-metafont texlive-collection-fontsrecommended texlive-babel-portuges texlive-fncychap texlive-lwarp texlive-fancyhdr texlive-framed texlive-wrapfig texlive-parskip texlive-upquote texlive-titlesec texlive-capt-of texlive-needspace texlive-lato texlive-fontaxes texlive-inconsolata python2-pygments texlive-texments texlive-pygmentex texlive-verbments texlive-collection-publishers texlive-texinfo texinfo python2-docutils texlive-polyglossia texlive-tabulary texlive-collection-langportuguese texlive-hyphen-portuguese pip
```

## Debian

```
sudo apt-get install python3-sphinx python3-pip latexmk texlive texlive-science texlive-formats-extra texlive-fonts-extra librsvg2-bin
```

## Windows

No Windows é preciso ter o MSYS2 e instalar os seguintes pacotes:

```
pacman -S mingw-w64-x86_64-librsvg mingw-w64-x86_64-python-sphinx mingw-w64-x86_64-python-sphinxcontrib-svg2pdfconverter
```

Na sua conta comum, use o `pip` ou `pip3` para instalar os pacotes
restantes:

```
pip install -U Sphinx sphinx_rtd_theme sphinxcontrib-svg2pdfconverter
```

Caso apareça o erro abaixo:

```
Package babel Warning: No hyphenation patterns were preloaded for
(babel)                the language `Portuguese' into the format.
(babel)                Please, configure your TeX system to add them and
(babel)                rebuild the format. Now I will use the patterns
(babel)                preloaded for english instead on input line 55.
```
Verifique se no arquivo `/usr/share/texlive/texmf-dist/tex/generic/config/language.dat`
as linhas abaixo existem:

```
dumylang        dumyhyph.tex    %for testing a new language.
nohyphenation   zerohyph.tex    %a language with no patterns at all.
portuguese loadhyph-pt.tex
=portuges
=brazil
=brazilian
```

Em seguida faça o comando abaixo para atualizar o cache de fontes do
tex:

```
sudo fmtutil-sys --all
```

Faça uma cópia do texto fonte com o comando:

```
  git clone https://github.com/wtuemura/mamedoc.git
```


Será criado um diretório chamado **mamedoc** com todo o código texto
desta documentação, entre no diretório **mamedoc** e use o comando `make
formato` onde `formato` pode ser substituído por qualquer um da lista
abaixo.

- **html** para gerar páginas HTML
- **dirhtml** para gerar arquivos index.html e arquivos doctree
- **singlehtml** para gerar um arquivo HTML de uma página só
- **pickle** para gerar arquivos pickle
- **json** para gerar arquivos json
- **htmlhelp** para gerar arquivos de ajuda em formato HTML, precisa ser finalizado com o [Microsoft HTML Help Workshop](https://www.microsoft.com/en-us/download/details.aspx?id=21138).
- **qthelp** para gerar arquivos de ajuda em formato HTML e de ajuda compatíveis com KDE ou Qt
- **devhelp** para gerar arquivos de ajuda em formato HTML e Devhelp (Gnome e compatíveis)
- **epub** para gerar arquivos em formato de livro digital
- **latex** para gerar arquivos em formato latex, é possível especificar as opções de tamanho de página PAPER=a4 ou PAPER=letter
- **latexpdf** para gerar arquivos latex e já convertê-los para PDF usando o latexpdf
- **xelatexpdf** para gerar arquivos latex e já convertê-los para PDF usando o xelatexpdf
- **text** para gerar arquivos texto
- **man** para gerar arquivos man
- **texinfo** para gerar arquivos texinfo
- **info** para gerar arquivos info
- **gettext** para gerar arquivos pot para tradução
- **changes** para gerar um relatório com um apanhado do que foi modificado
- **linkcheck** verifica se todos os links externos usando em cada uma das páginas do documento não estão quebrados
- **doctest** audita todas as páginas do projeto em busca de erros e gera um relatório no final

Então para gerar um arquivo PDF fazemos `make latexpdf` ou `make html`
para gerar páginas HTML e assim por diante.

# Licença

A [Atribuição 4.0 Internacional (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/legalcode.pt) em resumo lhe garantem os seguintes direitos:

- Compartilhar, copiar e redistribuir este material através de qualquer meio ou formato.
- Adaptar, misturar, transformar e criar a partir dele, para qualquer finalidade, inclusive comercial.

Desde que sejam respeitadas as seguintes condições:

- **Atribuição**, você deve dar o devido crédito, prover um link para a
  licença e indicar se mudanças foram feitas. Você deve fazê-lo em
  qualquer circunstância razoável, mas de nenhuma maneira que sugira que
  o licenciante apoia você ou o seu uso.
- **Sem restrições adicionais**, você não pode usar de meios jurídicos
  ou de qualquer outro meio de restrição, inclusive eletrônicos, digital
  ou qualquer outro meio restritivo que venha a aparecer, que impeçam
  outros de fazer legalmente o que o que esta licença já esteja
  permitindo.
Este trabalho de tradução está licenciado sob a Licença Atribuição 4.0
Internacional Creative Commons por Wellington T. Uemura.

Para visualizar uma cópia desta licença, visite http://creativecommons.org/licenses/by/4.0/ ou mande uma carta para:

Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

