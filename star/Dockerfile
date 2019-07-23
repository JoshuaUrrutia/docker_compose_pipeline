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


RUN mkdir /genome
    # && cd /genome \
    # && wget ftp://ftp.ensembl.org/pub/release-97/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
    # && gunzip Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
    # && wget ftp://ftp.ensembl.org/pub/release-97/gff3/homo_sapiens/Homo_sapiens.GRCh38.97.gff3.gz \
    # && gunzip Homo_sapiens.GRCh38.97.gff3.gz

# Setup working directory and scriptfiles
RUN mkdir /working /test /opt/scripts
ADD chr4/Homo_sapiens* /chr4/
ADD star.sh /opt/scripts/star.sh
RUN chmod +x /opt/scripts/star.sh
WORKDIR /working/
