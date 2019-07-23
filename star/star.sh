#!/bin/bash
set -e

R1=${1}
R2=${2}


cd /chr4/
gunzip *.gz
echo STAR --runThreadN 21 --runMode genomeGenerate \
     --genomeDir /chr4/ \
     --genomeFastaFiles /chr4/Homo_sapiens.GRCh38.dna.chromosome.4.fa \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.gff3 \
     --genomeSAindexNbases 12

STAR --runThreadN 21 --runMode genomeGenerate \
     --genomeDir /chr4/ \
     --genomeFastaFiles /chr4/Homo_sapiens.GRCh38.dna.chromosome.4.fa \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.gff3 \
     --genomeSAindexNbases 12

mkdir /working/star
cd /working/star/
echo STAR --runThreadN 5 --genomeDir /chr4/ \
     --readFilesCommand zcat \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.gff3 \
     --readFilesIn ${R1} ${R2} \
     --quantMode GeneCounts \
     --outSAMtype BAM SortedByCoordinate

STAR --runThreadN 5 --genomeDir /chr4/ \
     --readFilesCommand zcat \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.gff3 \
     --readFilesIn ${R1} ${R2} \
     --quantMode GeneCounts \
     --outSAMtype BAM SortedByCoordinate


# gzip ${R1%.gz}
# gzip ${R2%.gz}

#echo rm -rf *.fastq *.fa *.gff chr*.txt Genome genomeParameters.txt SA SAindex settings.txt
#rm -rf *.fastq *.fa *.gff chr*.txt Genome genomeParameters.txt SA SAindex settings.txt
