#!/bin/bash

# build the Markdown document to a PDF using pandoc
# Usage:
#   ./build.sh - builds locally
#   ./build.sh docker - builds within a container
#   ./build.sh clean - cleanup all generated artifacts
#

if [ "$1" == "" ] ; then
# default is to build locally
echo "Build locally..."

# pandoc useful commandline calls to check its configuration
#
#   pandoc --list-input-formats
#   pandoc --list-output-formats
#   pandoc --list-extensions
#   pandoc --print-default-template=markdown > template.markdown
#   pandoc --print-default-template=latex > template.latex
#

(
# generate into target folder, cleanup old generated file
if [ ! -d target/pdf ] ; then mkdir -p target/pdf ; fi
if [ -f target/pdf/MarkdownToPDF.pdf ] ; then
  rm target/pdf/MarkdownToPDF.pdf
fi

# generate relative to source folder
cd src/markdown

# lots of extensions needed
set -x
pandoc \
  --from=markdown_mmd\
+mmd_title_block\
+mmd_header_identifiers\
+mmd_link_attributes\
+backtick_code_blocks\
+table_captions\
+grid_tables\
+pipe_tables\
+raw_tex\
+latex_macros\
+yaml_metadata_block\
+shortcut_reference_links\
+link_attributes\
+strikeout\
+shortcut_reference_links\
+auto_identifiers\
+header_attributes\
  \
  --pdf-engine=xelatex \
  --include-in-header=customize.tex \
  --toc --toc-depth=3 --number-sections \
  --filter pandoc-include-code \
  --variable lof \
  --variable lot \
  --standalone \
  --variable documentclass:article \
  --variable papersize:a4paper \
  --variable classoption:openright \
  --variable geometry:"left=2cm, right=2cm, top=3cm, bottom=2cm" \
  --variable fontsize=12pt \
  --variable colorlinks \
  --variable urlcolor=blue \
  --metadata date="v02 - (Generated at `date "+%Y-%m-%d %H:%M:%S"`)" \
  --output=../../target/pdf/MarkdownToPDF.pdf \
   metadata.yaml 01_Main.md 02_OpenIssues.md
set +x

cd ../..
)

# open generated PDF on macOS to check build results when NOT running in docker
which open >/dev/null
if [ $? == 0 ] ; then
  if [ -f target/pdf/MarkdownToPDF.pdf ] ; then
    open target/pdf/MarkdownToPDF.pdf
  fi
fi


elif [ "$1" == "docker" ] ; then
# build using a docker container
echo "Build in docker container..."

docker build -t toolchain-pandoc .
# run build again now within docker, map current folder to /source dir
docker run -v `pwd`:/source toolchain-pandoc ./build.sh

# open generated PDF on macOS to check build results when NOT running in docker
if [ -f target/pdf/MarkdownToPDF.pdf ] ; then
  open target/pdf/MarkdownToPDF.pdf
fi

elif [ "$1" == "clean" ] ; then
# cleanup all generated files
echo "Cleanup generated files..."


# generate into target folder, cleanup old generated file
if [ -f target/pdf/MarkdownToPDF.pdf ] ; then
  rm target/pdf/MarkdownToPDF.pdf
fi
if [ -d target/pdf ] ; then rmdir target/pdf ; fi
if [ -d target ] ; then rmdir target ; fi


else
  # unknown option
  echo "Usage: build.sh [docker] [clean]"
  exit 1
fi
