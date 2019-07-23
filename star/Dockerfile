FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get update && apt-get install -y wget

# Install our aligner

RUN wget https://github.com/alexdobin/STAR/archive/2.7.1a.tar.gz \
    && tar -xzf 2.7.1a.tar.gz && rm 2.7.1a.tar.gz \
    && cd STAR-2.7.1a
ENV PATH=/STAR-2.7.1a/bin/Linux_x86_64_static:$PATH
RUN chmod 777 /STAR-2.7.1a/bin/Linux_x86_64_static/*

# Setup working directory and scriptfiles
RUN mkdir /genome /working /test /opt/scripts
ADD chr4/Homo_sapiens* /chr4/
ADD star.sh /opt/scripts/star.sh
RUN chmod +x /opt/scripts/star.sh
WORKDIR /working/
