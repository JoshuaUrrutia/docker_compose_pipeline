FROM ubuntu:latest

RUN apt-get -y update && \
    apt-get -y install autoconf \
    bison \
    build-essential \
    flex \
    libtool \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    build-essential \
    libssl-dev \
    libffi-dev  && \
    apt-get clean

# Example of how to use a requirements.txt file for python installs
#ADD requirements.txt /requirements.txt
#RUN pip3 install --upgrade -r /requirements.txt

RUN pip3 install multiqc

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /working/
