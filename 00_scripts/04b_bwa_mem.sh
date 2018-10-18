ASSEMBLY="/home1/datawork/creisser/sex_det/01_info_files/sspace.final.scaffolds.fasta"
WORKING_DIRECTORY=/home1/datawork/creisser/sex_det/
BWA="bwa"
BWA_ENV=". /appli/bioinfo/bwa/latest/env.sh"
INDIR=/home1/datawork/creisser/sex_det/03_trimmed
OUTDIR=/home1/scratch/creisser/sex_det/04_mapped
LOG_FOLDER=/home1/datawork/creisser/sex_det/98_log_files
NAMEM='cat /home1/datawork/creisser/sex_det/00_scripts/baseM.txt'
NAMEF='cat /home1/datawork/creisser/sex_det/00_scripts/baseF.txt'
SCRIPT=/home1/datawork/creisser/sex_det/00_scripts/04_bwa
HEADER=/home1/datawork/creisser/sex_det/00_scripts/header-big-mem.txt

mkdir -p $SCRIPT
mkdir -p $OUTDIR
cd $INDIR

# Fir individual file (no pooling), SM needs to be different:
for FILE in $($NAMEM)
do
        cp $HEADER $SCRIPT/bwa_${FILE##*/}.qsub ;
	echo "#PBS -N 04_bwa_mem_"$FILE" " >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "#PBS -o /home1/datawork/creisser/sex_det/98_log_files/04_bwa_mem_"$FILE".txt" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "cd $INDIR" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
	echo "$BWA_ENV" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "bwa mem -t 28 -M -R '@RG\tID:$FILE\tSM:$FILE\tPL:illumina\tLB:lib1\tPU:unit1' ${ASSEMBLY} $INDIR/"$FILE"_R1_paired.fastq.gz $INDIR/"$FILE"_R2_paired.fastq.gz > $OUTDIR/"$FILE".sam" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        qsub $SCRIPT/bwa_${FILE##*/}.qsub ;
done ;

# For pooled data, SM needs to be the same:
for FILE in $($NAMEF)
do
        cp $HEADER $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "cd $INDIR" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "$BWA_ENV" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "bwa mem -t 28 -M -R '@RG\tID:$FILE\tSM:poolFemales\tPL:illumina\tLB:lib1\tPU:unit1' ${ASSEMBLY} $INDIR/"$FILE"_R1_paired.fastq.gz $INDIR/"$FILE"_R2_paired.fastq.gz > $OUTDIR/"$FILE".sam" >> $SCRIPT/bwa_${FILE##*/}.qsub ;
        qsub $SCRIPT/bwa_${FILE##*/}.qsub ;
done ;

