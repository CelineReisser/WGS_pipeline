#!/usr/bin/env bash
#PBS -q 
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o 98_log_files
#PBS -N BCFtools


DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
INDIR= 08_freebayes
BCFLIBENV=". /appli/bioinfo/bcftools/1.4.1/env.sh"

$BCFLIBENV
cd $DATADIRECTORY/$INDIR

# Remove the multi allelic list
# Use -m2 -M2 -v snps to only keep biallelic SNPs.

bcftools view -m2 -M2 -v snps sex_det_snp_DP10_maf0.1_miss0.final.vcf -o sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf

bcftools view -m2 -M2 -v snps sex_det_snp_DP10_maf0.1_miss0.9.final.vcf -o sex_det_snp_DP10_maf0.1_miss0.9.final_biallelic.vcf

