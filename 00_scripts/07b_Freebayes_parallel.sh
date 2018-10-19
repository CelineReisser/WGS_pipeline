#!/usr/bin/env bash
#PBS -q 
#PBS -l walltime=120:00:00
#PBS -l mem= g
#PBS -l ncpus=
#PBS -N freebayes
#PBS -o 98_log_files/07b_freebayes_parallel_out.txt

DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
INDIR= 06_MD
OUTDIR= 07_freebayes
FREEBAYESENV= executables
REF= 01_info_files/your_genome.fasta
INDEX= 01_info_files/your_genome.fasta.fai

$FREEBAYESENV

cd $DATADIRECTORY
mkdir -p $OUTDIR

LS="ls $DATADIRECTORY/$INDIR/*.sorted.MD.bam"
$LS > 00_scripts/bam_list_freebayes.txt
BAM=00_scripts/bam_list_freebayes.txt

NCPU=28
nAlleles=4

freebayes-parallel  <(fasta_generate_regions.py $INDEX 100000) "$NCPU" \
-f $DATADIRECTORY/$REF --use-best-n-alleles $nAlleles -C 5 --genotype-qualities -L $DATADIRECTORY/$BAM > $DATADIRECTORY/$OUTDIR/sex_det_snp.vcf


