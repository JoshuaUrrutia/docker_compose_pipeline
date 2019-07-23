#!/bin/bash
set -e

R1=${1}
R2=${2}
outdir=${R1%_R1*}
outdir=${outdir##*/}

cd /chr4/
gunzip *.gz
echo --runThreadN 21 --runMode genomeGenerate \
     --genomeDir /chr4/ \
     --genomeFastaFiles /chr4/Homo_sapiens.GRCh38.dna.chromosome.4.fa \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.chromosome.4.gff3 \
     --sjdbOverhang 98 \
     --genomeSAindexNbases 12

STAR --runThreadN 21 --runMode genomeGenerate \
     --genomeDir /chr4/ \
     --genomeFastaFiles /chr4/Homo_sapiens.GRCh38.dna.chromosome.4.fa \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.chromosome.4.gff3 \
     --sjdbOverhang 98 \
     --genomeSAindexNbases 12


mkdir -p /working/star/
cd /working/star
mkdir -p $outdir
cd $outdir
echo STAR --runThreadN 5 --genomeDir /chr4/ \
     --readFilesCommand zcat \
     --readFilesIn ${R1} ${R2} \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.chromosome.4.gff3 \
     --quantMode GeneCounts \
     --outSAMtype BAM SortedByCoordinate \
     --sjdbGTFtagExonParentGeneName Name

STAR --runThreadN 5 --genomeDir /chr4/ \
     --readFilesCommand zcat \
     --readFilesIn ${R1} ${R2} \
     --sjdbGTFfile /chr4/Homo_sapiens.GRCh38.97.chromosome.4.gff3 \
     --quantMode GeneCounts \
     --outSAMtype BAM SortedByCoordinate \
     --sjdbGTFtagExonParentGeneName Name


# gzip ${R1%.gz}
# gzip ${R2%.gz}

#echo rm -rf *.fastq *.fa *.gff chr*.txt Genome genomeParameters.txt SA SAindex settings.txt
#rm -rf *.fastq *.fa *.gff chr*.txt Genome genomeParameters.txt SA SAindex settings.txt
