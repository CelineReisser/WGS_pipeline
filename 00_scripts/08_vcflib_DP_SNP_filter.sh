#!/usr/bin/env bash
#PBS -q mpi
#PBS -l walltime=24:00:00
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o /home1/datawork/creisser/sex_det/98_log_files
#PBS -N vcffilter

DATADIRECTORY=/home1/scratch/creisser/sex_det/07_freebayes
INDIR=/home1/scratch/creisser/sex_det/07_freebayes
VCFLIBENV=". /appli/bioinfo/vcflib/1.0.0_rc1/env.sh"

$VCFLIBENV
cd $INDIR

vcffilter -g "DP > 10" -f" TYPE = snp" $INDIR/sex_det_snp.vcf > $INDIR/sex_det_snp_DP10.vcf



