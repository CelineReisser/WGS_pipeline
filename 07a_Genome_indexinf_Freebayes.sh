#!/bin/bash
#PBS -N db1_BWA_indexing
#PBS -o /home1/datawork/creisser/sex_det/98_log_files/07a_Genome_indexing_Freebayes.out
#PBS -l walltime=20:00:00
#PBS -l mem=60g
#PBS -r n

# Global variables
SAMTOOLSENV=". /appli/bioinfo/samtools/1.4.1/env.sh"
BWA=/home1/datahome/creisser/local-programs/bwa-0.7.15
FASTA=/home1/datawork/creisser/sex_det/01_info_files/sspace.final.scaffolds.fasta

$SAMTOOLSENV

# index the transcriptome
samtools faidx $FASTA

