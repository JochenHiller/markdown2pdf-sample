FROM debian:stretch

MAINTAINER Jochen Hiller <jo.hiller@gmail.com>

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget \
        && \
    wget https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-1-amd64.deb && \
    dpkg -i pandoc* && \
    rm pandoc* && \
    apt-get install -y --no-install-recommends \
        texlive-base \
        texlive-latex-extra \
        texlive-latex-recommended \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        lmodern \
        texlive-base \
        texlive-xetex \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /source

CMD ["sh"]
