#!/usr/bin/env bash
#PBS -q 
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o 98_log_files
#PBS -N vcftools

DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
INDIR=/home1/scratch/creisser/sex_det/07_freebayes
VCFTOOLSENV= executables

$VCFTOOLSENV
cd $DATADIRECTORY/$INDIR

vcftools --maf 0.1 --max-missing 0.9 --vcf sex_det_snp_DP10.vcf --recode --out sex_det_snp_DP10_maf0.1_miss0.9
