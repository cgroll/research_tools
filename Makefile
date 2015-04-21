TMPL = pandoc_custom/templates/revealjs.template
CSL = pandoc_custom/csl/elsevier-harvard.csl

# output files, file stem
FILES = content.slides.html content.pdf
OUTDIR = output
OUT := $(addprefix $(OUTDIR)/,$(FILES))

html: output/content.slides.html

all: $(OUT)

$(OUTDIR)/content.slides.html: src/content.md Makefile refs.bib
	pandoc --template=$(TMPL) \
	-V slideNumber=true \
	--slide-level=2 --toc --toc-depth=1 \
	--filter pandoc_custom/filters/amsmath.hs \
	-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
	--include-in-header=pandoc_custom/css/reveal_left_strong.css \
	--filter pandoc-citeproc --csl=$(CSL) \
	--bibliography=refs.bib \
	-o output/content.slides.html src/content.md

$(OUTDIR)/content.pdf: src/content.md Makefile refs.bib
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


debug: src/content.md Makefile refs.bib
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
	-o output/content.tex $<


publish: $(OUT) Makefile refs.bib
	git checkout gh-pages
	git checkout master output/content.slides.html
	git commit -m "slides updated"
	git push origin gh-pages
	git checkout master

# TODO: push files to ftp server

clean:
	rm -f $(OUTDIR)/*.slides.html

again:
	make clean
	make
