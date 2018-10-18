#!/usr/bin/env bash
#PBS -q mpi
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o /home1/datahome/creisser/scratch/platax/sex_det/rna-seq_mapping_workflow/98_log_files

DATADIRECTORY=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/
INDIR=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/07_freebayes
HEADER=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/header-big-mem.txt
VCFTOOLSENV=". /appli/bioinfo/vcftools/0.1.14/env.sh"

$VCFTOOLSENV
cd $INDIR

vcftools --weir-fst-pop $DATADIRECTORY/00_scripts/base-M.txt --weir-fst-pop $DATADIRECTORY/00_scripts/base-F.txt --vcf $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic

#vcftools --TsTv --vcf $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic

vcftools --relatedness --vcf $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic

vcftools --depth --vcf $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic

vcftools --geno-depth --vcf $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic.vcf --out $INDIR/sex_det_snp_DP10_maf0.1_miss0.final_biallelic
