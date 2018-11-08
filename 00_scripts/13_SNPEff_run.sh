#!/usr/bin/env bash
#PBS -q 
#PBS -l walltime=
#PBS -l select=1:ncpus=28:mem=115g
#PBS -o 98_log_files
#PBS -N snpeff

SNPEFF=/Path/to/your/snpEff/folder
DBNAME=your_genome
VCF=07_freebayes/your_VCF.vcf
OUTDIR=08_SNPEFF
WORKDIR=path/to/WGS_pipeline

mkdir -p $OUTDIR

cd $SNPEFF

#Do the test for the dataset with no missing data:
java -Xmx115G -jar $SNPEFF/snpEff.jar $DBNAME $VCF > $WORKDIR/$OUTDIR/your_VCF.ann.vcf &&
mv snpEff_summary.html $WORKDIR/$OUTDIR/your_VCF_report.html
mv snpEff_genes.txt $WORKDIR/$OUTDIR/your_VCF_genes_summary.txt
