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

vcftools --weir-fst-pop $DATADIRECTORY/00_scripts/base-M.txt --weir-fst-pop $DATADIRECTORY/00_scripts/base-F.txt --vcf $INDIR/platax_sex_DP15_snp_maf0.1_miss0.recode.vcf --out $INDIR/platax_sex_DP15_snp_maf0.1_miss0

#vcftools --TsTv --vcf $INDIR/platax_sex_DP15_snp_maf0.1.vcf.recode.vcf --out $INDIR/platax_sex_DP15_snp_maf0.1

vcftools --relatedness --vcf $INDIR/platax_sex_DP15_snp_maf0.1_miss0.recode.vcf --out $INDIR/platax_sex_DP15_snp_maf0.1_miss0

vcftools --depth --vcf $INDIR/platax_sex_DP15_snp_maf0.1_miss0.recode.vcf --out $INDIR/platax_sex_DP15_snp_maf0.1_miss0

vcftools --geno-depth --vcf $INDIR/platax_sex_DP15_snp_maf0.1_miss0.recode.vcf --out $INDIR/platax_sex_DP15_snp_maf0.1_miss0
