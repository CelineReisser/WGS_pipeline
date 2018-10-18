ASSEMBLY="/home/datawork-rmpf/platax/sex_det/rna-seq_mapping_workflow/01_info_files/transcriptome_platax_40278.fa"
WORKING_DIRECTORY=/home1/datahome/creisser/scratch/platax/sex_det/rna-seq_mapping_workflow
BWA="bwa"
BWA_ENV=". /appli/bioinfo/bwa/latest/env.sh"
INDIR=/home1/datahome/creisser/scratch/platax/sex_det/rna-seq_mapping_workflow/03_trimmed
OUTDIR=/home1/datahome/creisser/scratch/platax/sex_det/rna-seq_mapping_workflow/04_mapped
LOG_FOLDER=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/98_log_files
NAME='cat /home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/base.txt'
SCRIPT=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/04_bwa
HEADER=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/header.txt

mkdir -p $SCRIPT

cd $INDIR
for FILE in $($NAME)
do
        cp $HEADER $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "cd $INDIR" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "$BWA_ENV" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "bwa mem -t 16 -M -R '@RG\tID:$FILE\tSM:$FILE\tPL:illumina\tLB:lib1\tPU:unit1' ${ASSEMBLY} $INDIR/"$FILE"_R1.paired.fastq.gz $INDIR/"$FILE"_R2.paired.fastq.gz > $OUTDIR/"$FILE".sam" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        qsub $SCRIPT/bwa_${FILE##*/}.qsub ;
done ;

