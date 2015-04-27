TMPL = pandoc_custom/templates/revealjs.template
CSL = pandoc_custom/csl/elsevier-harvard.csl

# output files, file stem
FILES = git.slides.html git.pdf
OUTDIR = output
OUT := $(addprefix $(OUTDIR)/,$(FILES))

CURRENT_TARGET = output/git
CURRENT_TARGET = output/markdown

current: $(CURRENT_TARGET).slides.html

reveal: $(CURRENT_TARGET).slides.html
pdf: $(CURRENT_TARGET).pdf

all: reveal pdf
everything: $(OUT)

## markdown, pandoc, make
#######

$(OUTDIR)/markdown.slides.html: src/markdown.md Makefile refs.bib
	pandoc --template=$(TMPL) \
	-V slideNumber=true \
	--filter pandoc_custom/filters/amsmath.hs \
	-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
	--include-in-header=pandoc_custom/css/reveal_left_strong.css \
	--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
	--bibliography=refs.bib \
	-o output/markdown.slides.html src/markdown.md


## git 
#######

$(OUTDIR)/git.slides.html: src/git.md Makefile refs.bib
	pandoc --template=$(TMPL) \
	-V slideNumber=true \
	--filter pandoc_custom/filters/amsmath.hs \
	-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
	--include-in-header=pandoc_custom/css/reveal_left_strong.css \
	-o output/git.slides.html src/git.md

$(OUTDIR)/git.pdf: src/git.md Makefile refs.bib
	pandoc -s -t beamer -f markdown \
	--slide-level=2 \
	-V theme=CambridgeUS -V colortheme=dolphin \
	-V header-includes=\\hypersetup{colorlinks\=true} \
	-V header-includes=\\hypersetup{urlcolor\=blue} \
	-V header-includes=\\hypersetup{linkcolor\=blue} \
	-V header-includes=\\usepackage{hyperref} \
	-V urlcolor=blue \
	-V linkcolor=blue \
	--mathjax \
	--filter pandoc_custom/filters/skip_pause.hs \
	--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
	--bibliography=refs.bib \
	-o $@ $<

debug: src/git.md Makefile refs.bib
	pandoc -s -t beamer -f markdown \
	--slide-level=2 \
	-V theme=Warsaw \
	-V header-includes=\\hypersetup{colorlinks\=true} \
	-V header-includes=\\usepackage{hyperref} \
	-V urlcolor=blue \
	-V linkcolor=blue \
	--mathjax \
	--filter pandoc_custom/filters/skip_pause.hs \
	--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
	--bibliography=refs.bib \
	-o output/git.tex $<

publish: $(OUT) Makefile refs.bib
	git checkout gh-pages
	git checkout master output/git.slides.html
	git commit -m "slides updated"
	git push origin gh-pages
	git checkout master

# TODO: push files to ftp server

clean:
	rm -f $(OUTDIR)/*.slides.html
	rm -f $(OUTDIR)/*.pdf

again:
	make clean
	make
