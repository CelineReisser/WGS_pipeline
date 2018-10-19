#!/usr/bin/env bash
#PBS -q mpi
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o /home1/datawork/creisser/sex_det/98_log_files
#PBS -N vcftools

DATADIRECTORY=/home1/scratch/creisser/sex_det/07_freebayes
INDIR=/home1/scratch/creisser/sex_det/07_freebayes
VCFTOOLSENV=". /appli/bioinfo/vcftools/0.1.14/env.sh"

$VCFTOOLSENV
cd $INDIR

vcftools --maf 0.1 --max-missing 0.9 --vcf $INDIR/sex_det_snp_DP10.vcf --recode --out $INDIR/sex_det_snp_DP10_maf0.1_miss0.9
