#!/bin/bash
#PBS -N db1_BWA_indexing
#PBS -o 98_log_files/07a_Genome_indexing_Freebayes.log
#PBS -l walltime=20:00:00
#PBS -l mem=60g
#PBS -r n

# Global variables
SAMTOOLSENV= executables
BWA= exectuable/folder
DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
FASTA=01_info_files/your_genome.fasta

$SAMTOOLSENV

# index the transcriptome
samtools faidx $DATADIRECTORY/$FASTA

