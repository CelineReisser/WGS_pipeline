#!/usr/bin/env bash
#PBS -N trimmomatic.sh
#PBS -o /home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/98_log_files/trimmomatic.sh.out
#PBS -q omp
#PBS -l ncpus=4
#PBS -l mem=60gb
#PBS -l walltime=24:00:00
#PBS -r n

# Header
DATADIRECTORY=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/02_data/raw
DATAOUTPUT=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/03_trimmed
SCRIPT=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/01_trimmomatic_pe.sh
HEADER=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/header.txt
TRIMMOMATICENV=". /appli/bioinfo/trimmomatic/latest/env.sh"
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
LOG_FOLDER=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/98_log_files
#BASE=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/base.txt
NAME='cat /home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/base-4.txt'
cd $PBS_O_WORKDIR

# Global variables

#>Illumina_TruSeq_LT_R1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
#>Illumina_TruSeq_LT_R2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
ADAPTERFILE=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/adapters.fasta
NCPU=4

$TRIMMOMATICENV

cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"

for file in $($NAME)
do

trimmomatic PE -Xmx23G \
        -threads 8 \
        -phred33 \
        $DATADIRECTORY/"$file"_R1.fastq.gz \
        $DATADIRECTORY/"$file"_R2.fastq.gz \
        $DATAOUTPUT/"$file"_R1.paired.fastq.gz \
        $DATAOUTPUT/"$file"_R1.single.fastq.gz \
        $DATAOUTPUT/"$file"_R2.paired.fastq.gz \
        $DATAOUTPUT/"$file"_R2.single.fastq.gz \
        ILLUMINACLIP:"$ADAPTERFILE":2:30:10 \
        LEADING:28 \
        TRAILING:28 \
        SLIDINGWINDOW:24:28 \
        MINLEN:40 2> $LOG_FOLDER/log.trimmomatic.pe."$TIMESTAMP"
    
done
