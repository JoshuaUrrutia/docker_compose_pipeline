
FROM ubuntu:latest

# Basics
RUN apt-get -y update && \
    apt-get -y install apt-utils bash curl dialog git vim rsync && \
    apt-get clean

# jq for parsing JSON
RUN curl -L -sk -o /usr/local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" \
    && chmod a+x /usr/local/bin/jq

RUN apt-get -y update && \
    apt-get -y install build-essential \
    openjdk-8-jdk-headless \
    ant \
    gradle \
    maven \
    libssl-dev \
    libffi-dev  && \
    apt-get clean

RUN apt-get update && \
    apt-get install -y perl \
    gzip \
    libgomp1 \
    bc && \
    apt-get clean

RUN mkdir /opt/scripts

# All the source code we need is local to our repository,
# so we can just add the binaries to the container
ADD runsortmerna /opt/scripts/runsortmerna.sh
ADD /src/Trimmomatic-0.36 /opt/Trimmomatic-0.36
ADD /src/FastQC /opt/FastQC
WORKDIR /working/

# Alternative Installation Methods:
# # Trimmomatic
# WORKDIR /tmp
# RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.36.zip \
#     && unzip Trimmomatic-0.36.zip \
#     && rm Trimmomatic-0.36.zip \
#     && mv Trimmomatic-0.36 /opt/Trimmomatic-0.36
#
# # FastQC
# WORKDIR /tmp
# RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.7.zip \
#     && unzip fastqc_v0.11.7.zip \
#     && rm fastqc_v0.11.7.zip \
#     && mv FastQC /opt/FastQC
