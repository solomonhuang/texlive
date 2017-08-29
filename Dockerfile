FROM debian:stable-slim
LABEL maintainer="kaichanh@gmail.com"

RUN apt-get -qq update && apt-get install -y wget perl make \
     `apt-cache depends texlive-binaries | awk '/Depends:/{print$2}'` \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN mkdir -p install-tl
COPY texlive-2017.profile /install-tl/
RUN tar xf install-tl-unx.tar.gz -C install-tl --strip-components=1 && cd install-tl && perl ./install-tl -profile texlive-2017.profile \
    && cd / && rm -rf install-tl install-tl-unx.tar.gz

RUN adduser --disabled-password --gecos texlive texlive
ADD texlive-path.sh /etc/profile.d/

VOLUME [ "/home/texlive/doc" ]

WORKDIR /home/texlive/doc
USER texlive

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

