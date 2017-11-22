FROM debian:unstable
# use debian:unstable to get latest TeXLive 2017-10-04

MAINTAINER Jochen Hiller <jo.hiller@gmail.com>

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        gnupg \
        sudo \
        && \
    wget https://github.com/jgm/pandoc/releases/download/2.0.3/pandoc-2.0.3-1-amd64.deb && \
    dpkg -i pandoc* && \
    rm pandoc* && \
    apt-get install -y --no-install-recommends \
        cabal-install \
        texlive-base \
        texlive-xetex \
        lmodern \
        texlive-fonts-recommended \
        texlive-generic-recommended \
        xzdec \
        && \
    cd ~ && mkdir texmf && tlmgr init-usertree && \
    tlmgr update --self && \
    tlmgr install ucharcat && \
    cabal update && \
    cabal install pandoc-include-code && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

    # packages required
    #   ca-certificates, wget, to support HTTPS download
    #   gnupg, to verify signed TeX packages
    #   Pandoc 2.0.3, from https://github.com/jgm/pandoc/releases/download/2.0.3/pandoc-2.0.3-1-amd64.deb
    #     install from Pandoc deb package
    #   cabal, pandoc package manager
    #   texlive-base, minimal packaging
    #   texlive-xetec, needed for pandoc
    #   lmodern, needed for modern fonts
    #   texlive-fonts-recommended, for many fonts
    #   texlive-generic-recommended, needed for ulem.sty
    #   xzdec, to uncompress tex packages with tlmgr
    #   tlmgr, to install missing packages, see https://tex.stackexchange.com/questions/137428/tlmgr-cannot-setup-tlpdb
    #      tlmgr install ucharcat
    #   pandoc extensions
    #     include-code, include source code from external files
    #

ENV PATH="/root/.cabal/bin:${PATH}"
# add this folder to PATH to allow to find pandoc filters

WORKDIR /source

CMD ["sh"]
