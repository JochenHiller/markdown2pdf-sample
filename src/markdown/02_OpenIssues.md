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
* Cross-References: with refs instead of text matching
* Cross-References, e.g. glossar, index
* Tables with numbering and text
* Control better page breaks
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

* Shrink Dockerfile to include only really needed packages (needs tryout)
