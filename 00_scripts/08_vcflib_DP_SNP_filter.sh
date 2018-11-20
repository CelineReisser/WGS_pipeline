#!/usr/bin/env bash
#PBS -q 
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o 98_log_files
#PBS -N vcffilter

DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
INDIR=07_freebayes
VCFLIBENV= executables

$VCFLIBENV
cd $DATADIRECTORY/$INDIR

vcffilter -g "DP > 10" -f "TYPE = snp" sex_det_snp.vcf > sex_det_snp_DP10.vcf



