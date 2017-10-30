FROM debian:stretch

MAINTAINER Jochen Hiller <jo.hiller@gmail.com>


# packages required
#   texlive-base, minimal packages
#   texlive-xetec, needed for pandoc
#   lmodern, needed for modern fonts
#   texlive-fonts-recommended, needed for Metric font
#   texlive-generic-recommended, needed for ulem style

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
        texlive-xetex \
        lmodern \
        texlive-fonts-recommended \
        texlive-generic-recommended \
        && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /source

CMD ["sh"]
