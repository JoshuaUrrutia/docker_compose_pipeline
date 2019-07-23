#!/bin/bash

set -e

R1=${1}
R2=${2}
MOUNT="type=bind,source=$PWD,target=/working"

docker run --rm --mount ${MOUNT} docker_compose_pipeline_trimmomatic:latest \
       /opt/scripts/runsortmerna.sh \
       /working/$R1 /working/$R2 \
       TruSeq3-PE-2.fa:2:30:10 \
       36

docker run --rm --mount ${MOUNT} docker_compose_pipeline_star:latest \
       /opt/scripts/star.sh \
       /working/trimmomatic/${R1%.f*}.trimmed.fastq.gz \
       /working/trimmomatic/${R2%.f*}.trimmed.fastq.gz


docker run --rm -mount ${MOUNT} docker_compose_pipeline_multiqc:latest \
       multiqc \
       -o /working/multiqc/ \
       /working
