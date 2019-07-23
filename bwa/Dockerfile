FROM ubuntu:latest

 RUN apt-get update \
     && apt-get upgrade -y \
     && apt-get install -y wget \
        unzip \
        make \
        gcc \
        zlib1g-dev \
        ncurses-dev \
        bzip2  \
        libbz2-dev \
        liblzma-dev
#     && apt-get install software-properties-common -y \
#     && apt-get install python-software-properties -y \
#     && apt-get install perl -y \
#     && apt-get install curl -y \
#     && apt-get install unzip -y \
#     && apt-get install less -y \
#     && apt-get install libgomp1 -y \
#     && apt-get install build-essential -y \
#     && apt-get install bzip2 -y \
#     && apt-get install bedtools -y \
#     && apt-get install libbz2-dev -y \
#     && apt-get install liblzma-dev -y \
#     && apt-get install ncurses-dev -y \
#     && apt-get install zlib1g-dev -y \
#     && apt-get install r-base -y \
#     && apt-get install ant -y \
#     && apt-get install git -y \
#     && apt-get install tabix -y \
#     && apt-get -y clean \
#     && apt-get -y autoclean \
#     && apt-get -y autoremove

# BWA
WORKDIR /tmp
RUN wget https://github.com/lh3/bwa/archive/v0.7.17.zip \
    && unzip v0.7.17.zip
WORKDIR bwa-0.7.17
RUN make \
    && mv /tmp/bwa-0.7.17 /opt/bwa


# SAMTOOLS
WORKDIR /tmp
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 \
    && tar --bzip2 -xf samtools-1.9.tar.bz2 \
    && rm samtools-1.9.tar.bz2
WORKDIR /tmp/samtools-1.9
ENV SAMTOOLS_INSTALL_DIR=/opt/samtools
RUN ./configure --enable-plugins --prefix=$SAMTOOLS_INSTALL_DIR \
    && make all all-htslib \
    && make install install-htslib



#ADD executables to bath
#ENV PATH "/opt/bin/:$PATH"
ENV PATH "/opt/bwa/:$PATH"
ENV PATH  "/opt/samtools/bin/:$PATH"


# Add analysis script
# RUN pwd
# ADD src /src
# RUN chmod +x /src/analysis_pipeline.sh
# ENV GATK /src/GenomeAnalysisTK.jar
# ADD tests /tests
# RUN chmod +x /tests/test.sh
#WORKDIR /tests/
WORKDIR /working/
