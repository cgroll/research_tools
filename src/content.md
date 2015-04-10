% Research tools
% Christian Groll

# [git](http://www.git-scm.com/)

##

- git was created to managed cooperative work on the Linux kernel

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
subversion 

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

## 

- including mathematical formulas:

````latex
	
$$
\gamma(n)=\sum_{i=1}^{n}x^{2}
$$
````

⇒ configure `MathJax` to correctly render formulas

## 

`pandoc` details:

- how is output file created?
- how are command line arguments included?

[pandoc-templates](https://github.com/jgm/pandoc-templates)

[default.revealjs](https://github.com/jgm/pandoc-templates/blob/master/default.revealjs)

##

- setting paths: **better solution**
- custom pandoc [template files](https://github.com/cgroll/pandoc_custom)

````sh

git clone https://github.com/cgroll/pandoc_custom.git
````

## [MathJax](http://www.mathjax.org/)


$$
\gamma(n)=\sum_{i=1}^{n}x^{2}
$$


##

````sh

pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs \
-f markdown -o output/content.slides.html src/content.md
````


##

Citations:

````sh

sudo apt-get install pandoc-citeproc
````

##

Alternatively, you could also circumvent raw LaTeX with:

- [LyX](www.lyx.org)
- [emacs org-mode](http://orgmode.org/)

# coding: best practices

# [Make](http://www.gnu.org/software/make/)

##
- automating tasks
- starting small, with sh command:

# [Julia](http://julialang.org/)

##
- IJulia
- notebook files

# Notebook environments

##
- [beaker notebook](http://beakernotebook.com/)
- [Jupyter](http://jupyter.org/)
