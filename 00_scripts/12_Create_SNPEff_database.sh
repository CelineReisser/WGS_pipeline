#!/usr/bin/env bash
#PBS -q 
#PBS -l walltime=
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o 98_log_files
#PBS -N snpeff

SNPEFF=/Path/to/snpEff/Folder
GFF=01_info_files/your_genome.gff3
FASTA=01_info_files/your_genome.fasta
DBNAME=your_genome

cd $SNPEFF

#create necessary directories for analysis in the SNPeff program folder: a directory "data" in wich two other directories is created:
mkdir -p data
mkdir -p data/$DBNAME
mkdir -p data/genomes


# Copy files where they need to be. GFF in the $DBNAME directory, fasta in the "genomes" directory
cp $GFF ./data/$DBNAME/genes.gff
cp 01_info_files/$DBNAME.fasta ./data/genomes/$DBNAME.fa


#Modify the config file in order to add the new genome
echo "# Genome of your species, your_genome.fasta" >> snpEff.config
echo "$DBNAME.genome : $DBNAME" >> snpEff.config

java -Xmx115G -jar $SNPEFF/snpEff.jar build -gff3 -v $DBNAME
