% Research tools
% Christian Groll

# [git](http://www.git-scm.com/)

## Resources

- 
- git lessons at [Software Carpentry](http://swcarpentry.github.io/git-novice/)

##

- git was created to managed cooperative work on the Linux kernel

- [myrepos](http://myrepos.branchable.com/)
  
## Installation

On Linux, git usually is installed upfront. If not, get it through
your package manager. For example, on Ubuntu:

````sh
sudo apt-get install git
````

## 

On Windows machine

## 

Project dependencies: subtree / submodule

##

git subtree

- incorporate external repositories without history
- allow easy updating for external repositories
  
Links:
- [atlassian blog](http://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree/)
  
##
git submodule

- sub-repository does not come with the parent repository
  automatically
- use for private data that may not be shared with public repository
  
  

##

Alternatives:
- subversion 
- [Mercurial](http://swcarpentry.github.io/hg-novice/)

# [Markdown](http://daringfireball.net/projects/markdown/)


## Headers

````

# New section

## New slides
````


## Lists

````

* Candy.
* Gum.
* Booze.
  
- Candy.
- Gum.
- Booze.
````

- Candy.
- Gum.
- Booze.
  
## 

````

1. Red
2. Green
3. Blue
````

1. Red
2. Green
3. Blue
   
   
## Links

````

This link points to [Google](http://www.google.de).
````

This link points to [Google](http://www.google.de).

## Emphasis

````

- normal text
- *single asterisks*
- **double asterisks**
````

- normal text
- *single asterisks*
- **double asterisks**
  
  
# [pandoc](http://johnmacfarlane.net/pandoc/)

##

> "If you need to convert files from one markup format into another,
> pandoc is your swiss-army knife."


[http://johnmacfarlane.net/pandoc/](http://johnmacfarlane.net/pandoc/)

## 

What for?

- enable markdown usage
- multiple output formats for single content file
  
  
##

Starting small

- input and output formats
- input and output files
  
````sh

pandoc -t revealjs -f markdown \
-o output/content.slides.html src/content.md
````
##

Add `-s` option for standalone html file:

````sh

pandoc -s -t revealjs -f markdown \
-o output/content.slides.html src/content.md
````

##

- inspect html source in browser: `Inspect element`
- adapt reveal.js path variable
  
````sh

pandoc -s -V revealjs-url=../reveal.js -t revealjs \
-f markdown -o output/content.slides.html src/content.md
````

##

- currently some files paths are out of sync between latest reveal.js
  version and pandoc version
- pandoc requires `reveal.min.js` and `reveal.min.css`
- first solution: create symbolic links
  
````sh

cd reveal.js/js
ln -s reveal.js reveal.min.js 
cd ../css
ln -s reveal.css reveal.min.css 
````

## [MathJax](http://www.mathjax.org/)

- including mathematical formulas:
  
````latex

$$
\gamma(n)=\sum_{i=1}^{n}x^{2}
$$
````

$\Rightarrow$ configure `MathJax` to correctly render formulas

## 

`pandoc` details:

- how is output file created?
- how are command line arguments included?
  
[pandoc-templates](https://github.com/jgm/pandoc-templates)

[default.revealjs](https://github.com/jgm/pandoc-templates/blob/master/default.revealjs)

##

- better solution for setting paths
- custom pandoc [template files](https://github.com/cgroll/pandoc_custom) 
  
	````sh
	
	git clone https://github.com/cgroll/pandoc_custom.git
	````
  
- or as **git subtree**:
  
	````sh
	
	git subtree add --prefix pandoc_custom \
	https://github.com/cgroll/pandoc_custom.git master --squash
	````
  
## 

- example MathJax code in template:
  
````
<!-- include local MathJax -->
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
extensions: ["tex2jax.js"],
TeX: { equationNumbers: { autoNumber: "AMS" } },
jax: ["input/TeX","output/HTML-CSS"],
tex2jax: {inlineMath: [["$$","$$"],["\\(","\\)"]]}});
</script>
<script type="text/javascript" src="../MathJax/MathJax.js"></script>

````

$\Rightarrow$ set MathJax path according to your needs!


## 

- link to template file in pandoc command
  
````sh

pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs \
-f markdown -o output/content.slides.html src/content.md
````

##

MathJax rendered

- equation without number

````latex
$$\alpha^{2} = \beta^{2}$$
````

$$\alpha^{2} = \beta^{2}$$

##

- using latex equation environment currently requires different syntax
  for `html` and `pdf` output

- labeled and numbered equation, `html`:
  
	````latex
	
	$$\begin{equation}
	\alpha = \beta
	\label{eq:sample}
	\end{equation}$$
	````

##

- same formula for `pdf` output:

	````latex
	
	\begin{equation}
	\alpha = \beta
	\label{eq:sample}
	\end{equation}
	````

## 

- both options are parsed differently 
- to get parsed contents, export to `native` format

````sh

pandoc -t native src/content.md -o output/content_native.txt
````

##

- the equations will appear as

````

,Para [Math DisplayMath "\\begin{equation}\n\\alpha = \\beta\n\\label{eq:sample}\n\\end{equation}"]
,RawBlock (Format "latex") "\\begin{equation}\n\\alpha = \\beta\n\\label{eq:sample}\n\\end{equation}"
````
$\Rightarrow$ using an appropriate `--filter` option might solve the problem

## 

- especially for latex, errors can be hard to find
- it might help to look at the raw produced `tex` file

````sh

pandoc -t latex -f markdown -s -o output/content.tex
````

##

- labeled and numbered equation:

$$\begin{equation}
\alpha = \beta
\label{eq:sample}
\end{equation}$$

##

- labeled aligned equations, single number:
  
````latex

$$\begin{equation}
\begin{split} 
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\end{split}
\label{eq:splitSample}
\end{equation}$$

````

$$\begin{equation}
\begin{split} 
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\end{split}
\label{eq:splitSample}
\end{equation}$$

## 

- aligned equations, one number per line, single label
  
````latex

$$\begin{align}
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\label{eq:alignedSample}
\end{align}$$
````


$$\begin{align}
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\label{eq:alignedSample}
\end{align}$$



##

- referring to equations in text
  
````

Referring to equations $\eqref{eq:sample}$, $\eqref{eq:splitSample}$
and $\eqref{eq:alignedSample}$.
````

Referring to equations $\eqref{eq:sample}$, $\eqref{eq:splitSample}$
and $\eqref{eq:alignedSample}$.


## Citations

-
 [pandoc-citeproc](http://hackage.haskell.org/package/pandoc-citeproc):
 
> "a library for rendering bibliographic reference citations into a
> variety of styles using a macro language called Citation Style
> Language (CSL)"

##

- Linux installation:
  
````sh

sudo apt-get install pandoc-citeproc
````

##

- keep list of references in bibtex format
  
````
@article{citeulike:1232469,
author = {Rubinstein, Mark},
citeulike-article-id = {1232469},
citeulike-linkout-0 = {http://www.jstor.org/stable/2697771},
journal = {The Journal of Finance},
number = {3},
pages = {1041--1045},
posted-at = {2007-04-17 17:49:48},
priority = {0},
title = {{Markowitz's \"Portfolio Selection\";: A Fifty-Year Retrospective}},
url = {http://www.jstor.org/stable/2697771},
volume = {57},
year = {2002}
}
````

##

- meanwhile bibtex entries for most references are readily available
- simply google for reference + bibtex
- export bibtex from
  [page](http://www.citeulike.org/user/felixroudier/author/Rubinstein) 
  
  
## [Citation Style Language](http://citationstyles.org/)

- define style of references and bibliography in *.csl* file
- [search citation styles](http://editor.citationstyles.org/about/)
  
## 

- pre-process citations in pandoc
  
````

pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
--bibliography=refs.bib \
-o output/content.slides.html src/content.md
````

## 

- cite reference
  
  ````
  ... according to [@citeulike:1232469].
  ````
  
  ... according to [@citeulike:1232469].
  
- references will appear automatically in bibliography at the end
  
## 

Internal links

- link to section
  
````

Still remember [the git introduction](#git)?
````

Still remember [the git introduction](#git)?

## Resources

- [John MacFarlane, slides](http://johnmacfarlane.net/BayHac2014/#/)
- [John MacFarlane, video](https://youtu.be/6TBpB-BEiIg)


## Pandoc alternatives

you could also circumvent raw LaTeX with:

- [LyX](www.lyx.org)
- [emacs org-mode](http://orgmode.org/)
  
# [Make](http://www.gnu.org/software/make/)

## Automation

- using command line allows for easy automation of repetitive tasks
- GUIs and mouse clicks are a lot less easy to automate
  
##

Starting small

- bash script: create file `export.sh` with content

	````sh
	  
	pandoc --template=pandoc_custom/templates/revealjs.template \
	-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
	--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \   
	--bibliography=refs.bib \
	-o output/content.slides.html src/content.md
	````

- call script with

	````sh
	sh export.sh   
	````
   
##

Improvements:

- only execute command, if source file was modified
- subsume multiple commands with pattern rules

$\Rightarrow$ use a `Makefile`

## 

- set target files with dependencies
- conditional execution: command is executed, if:
  - target file does not exist
  - last modification of dependency is more recent than last
    modification of target file

##

- create `Makefile`
- `Make` syntax:

	````make
	target: dependency1 dependency2
		target rule
	````

- important: line with target rule MUST start with TAB

## Usecase: pandoc slide creation

````make
output/content.slides.html: src/content.md Makefile refs.bib
	pandoc --template=pandoc_custom/templates/revealjs.template \
	-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
	--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
	--bibliography=refs.bib \
	-o output/content.slides.html src/content.md
````

## 

- you can build individual targets by calling `Make` on them:

	````sh
	
	make output/content.slides.html
	````

- if no argument is specified, `Make` automatically builds the first
  target appearing in a `Makefile`


##

- adding an additional output target

````make


````


##

dummy targets:

- use dummy targets to subsume multiple targets

## Additional resources

- Make lessons at [Software Carpentry](http://software-carpentry.org/v4/make/index.html)

# coding: best practices

# [Julia](http://julialang.org/)

##
- IJulia
- notebook files
  
# Notebook environments

##
- [beaker notebook](http://beakernotebook.com/)
- [Jupyter](http://jupyter.org/)
  
  
## References


