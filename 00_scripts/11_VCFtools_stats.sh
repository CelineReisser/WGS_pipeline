#!/usr/bin/env bash
#PBS -q 
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o 98_log_files

DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
INDIR=07_freebayes
HEADER=00_scripts/header-big-mem.txt
VCFTOOLSENV= executables

$VCFTOOLSENV
cd $DATADIRECTORY/$INDIR

vcftools --weir-fst-pop $DATADIRECTORY/00_scripts/base-M.txt --weir-fst-pop $DATADIRECTORY/00_scripts/base-F.txt --vcf sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic

vcftools --relatedness --vcf sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out sex_det_snp_DP10_maf0.1_miss0.final_biallelic

vcftools --depth --vcf sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out sex_det_snp_DP10_maf0.1_miss0.final_biallelic

vcftools --geno-depth --vcf sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out sex_det_snp_DP10_maf0.1_miss0.final_biallelic
