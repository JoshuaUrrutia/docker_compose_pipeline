#!/bin/bash

set -e

R1=${1}
R2=${2}
MOUNT="type=bind,source=$PWD,target=/working"

docker run --rm --mount ${MOUNT} dockercomposepipeline_trimmomatic:latest \
       /opt/scripts/runsortmerna.sh \
       $R1 $R2 \
       TruSeq3-PE-2.fa:2:30:10 \
       36

docker run --rm --mount ${MOUNT} dockercomposepipeline_star:latest \
       /opt/scripts/star.sh \
       trimmomatic/${R1%.f*}.trimmed.fastq.gz \
       trimmomatic/${R2%.f*}.trimmed.fastq.gz


docker run --rm -mount ${MOUNT} dockercomposepipeline_multiqc:latest \
       multiqc \
       -o multiqc/ \
       .
