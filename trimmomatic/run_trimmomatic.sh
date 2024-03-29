#!/bin/bash

set -e

# this is where we mount the binary directories

TRIMMOMATIC_DIR=/opt/Trimmomatic-0.36/
FASTQC_DIR=/opt/FastQC/

echo this is the newest sortmerna

echo $0 $@

#out of paranoia make sure our parameters are set
if [ ${1}x = x ]; then
   echo READ1 is blank
   exit 1
fi
if [ ${2}x = x ]; then
   echo READ2 is blank
   exit 1
fi
if [ ${3}x = x ]; then
   echo ADAPTER is blank
   exit 1
fi
if [ ${4}x = x ]; then
   echo MINLEN is blank
   exit 1
fi


# get the parameters 1 to 4 ... someday do checking

R1=${1}
R2=${2}
ADAPTER=${3}
MINLEN=${4}


R1NAME=${R1%.f*}
R2NAME=${R2%.f*}

echo RNAME1 is $R1NAME
echo RNAME2 is $R2NAME


mkdir -p trimmomatic


echo java -jar ${TRIMMOMATIC_DIR}/trimmomatic-0.36.jar PE -phred33 \
          ${R1} ${R2} \
          trimmomatic/${R1NAME}.trimmed.fastq \
          trimmomatic/${R1NAME}.unpaired.fastq \
          trimmomatic/${R2NAME}.trimmed.fastq \
          trimmomatic/${R2NAME}.unpaired.fastq \
          ILLUMINACLIP:${TRIMMOMATIC_DIR}/adapters/${ADAPTER} \
          LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 \
          MINLEN:${MINLEN}

java -jar ${TRIMMOMATIC_DIR}/trimmomatic-0.36.jar PE -phred33 \
          ${R1} ${R2} \
          trimmomatic/${R1NAME}.trimmed.fastq \
          trimmomatic/${R1NAME}.unpaired.fastq \
          trimmomatic/${R2NAME}.trimmed.fastq \
          trimmomatic/${R2NAME}.unpaired.fastq \
          ILLUMINACLIP:${TRIMMOMATIC_DIR}/adapters/${ADAPTER} \
          LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 \
          MINLEN:${MINLEN}

cd trimmomatic


# gzip the trimmed inputs

${FASTQC_DIR}/fastqc ${R1NAME}.trimmed.fastq &
${FASTQC_DIR}/fastqc ${R2NAME}.trimmed.fastq &
wait
gzip ${R1NAME}.trimmed.fastq &
gzip ${R2NAME}.trimmed.fastq &
wait

# report out and clean up...

echo "R1 reads removed by Trimmomatic: "
echo $(cat ${R1NAME}.unpaired.fastq|wc -l)/4|bc
echo "R2 reads removed by Trimmomatic: "
echo $(cat ${R2NAME}.unpaired.fastq|wc -l)/4|bc

rm -rf *unpaired.fastq
