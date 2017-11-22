# Open Issues

These are the current issues which should be added to this template.

* add Version AND generated at date to the main information of document

```
# use that to add current date as version
#  --metadata date="`date "+%B %e, %Y"`" \
```

* Code snippets with surrounding box
* footnotes with multi lines
* footline: add total pages right side
* Index/Term: e.g. glossar, index
* Tables with numbering and text
* --variable toc-title="XXX" does not work
* customized text for Table of Contents in customize.tex does not work

```
% Table of contents formatting
% \renewcommand{\contentsname}{My special Table of Contents}
```

* Footer text needs to be defined in customization.tex, bad, no content inside
* Footer: page 5 / 10 is missing

* Check if we need a special latex template. If so add this to build.sh
    * and generate with `pandoc --print-default-template=latex > template.latex`

```
  --template=template.latex \
```

* Including source code from external file does not yet work

You can also add source code from an external file, and even include some lines of code of that.
For that purpose we need a pandoc extension "include-source", see <https://github.com/owickstrom/pandoc-include-code>

Sample for given Dockerfile:

```{include=../../Dockerfile}
TODOO Some text should be overriden by Dockerfile
```

## Open issues for generating the docker image

* Eliminate warnings during generate of Docker image

```
debconf: delaying package configuration, since apt-utils is not installed
...
Cannot determine type of tlpdb from /root/texmf!
```

* install fonts via tlmgr
* `tlmgr install collection-fontsrecommended` does not work, will fail with error `tlmgr: updmap failed (status 1), output:`

* these fonts are not supported within docker container

```
--variable mainfont="Palatino" \
--variable sansfont="Helvetica" \
--variable monofont="Menlo" \
```

* add fonts package to container `fonts-freefont-ttf`
* consider to use Google Noto fonts (see <https://www.google.com/get/noto/>)


* install and use "pandoc-include-code" filter: add code from external file
  * `cabal install pandoc-include-code`
