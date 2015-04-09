% Research tools
% Christian Groll

# git / github

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

# pandoc

##

> "If you need to convert files from one markup format into another,
> pandoc is your swiss-army knife."


[http://johnmacfarlane.net/pandoc/](http://johnmacfarlane.net/pandoc/)

## 

What for?

- enable markdown usage
- multiple output formats for single content file

##

[Markdown](http://daringfireball.net/projects/markdown/)

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
- create symbolic links
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

##

- output is rendered according to the following default templates:

[pandoc-templates](https://github.com/jgm/pandoc-templates)

- for example, `reveal.js` is rendered through
  [this](https://github.com/jgm/pandoc-templates/blob/master/default.revealjs) file

##

Own templates:

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

# Make

##
- automating tasks
- starting small, with sh command:

# Julia

##
- IJulia
- notebook files

# Notebook environments

##
- [beaker notebook](http://beakernotebook.com/)
- [Jupyter](http://jupyter.org/)
