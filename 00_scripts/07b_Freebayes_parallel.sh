#!/usr/bin/env bash
#PBS -q omp
#PBS -l walltime=120:00:00
#PBS -l mem=115g
#PBS -l ncpus=40
#PBS -N freebayes
#PBS -o /home1/datawork/creisser/sex_det/98_log_files/07b_freebayes_parallel_out.txt

DATADIRECTORY=/home1/scratch/creisser/sex_det/06_MD
OUTDIR=/home1/scratch/creisser/sex_det/07_freebayes
FREEBAYESENV=". /appli/bioinfo/freebayes/latest/env.sh"
REF=/home1/datawork/creisser/sex_det/01_info_files/sspace.final.scaffolds.fasta
INDEX=/home1/datawork/creisser/sex_det/01_info_files/sspace.final.scaffolds.fasta.fai

$FREEBAYESENV
mkdir -p $OUTDIR
cd $DATADIRECTORY

LS="ls $DATADIRECTORY/*.sorted.MD.bam"
$LS > /home1/datawork/creisser/sex_det/00_scripts/bam_list_freebayes.txt
BAM=/home1/datawork/creisser/sex_det/00_scripts/bam_list_freebayes.txt

NCPU=28
nAlleles=4

freebayes-parallel  <(fasta_generate_regions.py $INDEX 100000) "$NCPU" \
-f $REF --use-best-n-alleles $nAlleles -C 5 --genotype-qualities -L $BAM > $OUTDIR/sex_det_snp.vcf


