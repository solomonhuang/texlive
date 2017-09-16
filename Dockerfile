FROM debian:stable-slim
LABEL maintainer="kaichanh@gmail.com"

RUN apt-get -qq update && apt-get install -y wget perl make git \
    texlive texlive-xetex texlive-latex-recommended texlive-latex-extra texlive-bibtex-extra texlive-science texlive-humanities pdftk curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos texlive texlive

#VOLUME [ "/home/texlive/doc" ]

#WORKDIR /home/texlive/doc
USER texlive

#ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

