WORKING_DIRECTORY=/Path/to/your/copy/of/WGS_pipeline
ASSEMBLY= 01_info_files/your_genome.fasta
BWA="bwa"
BWA_ENV=" executables"
INDIR= 03_trimmed
OUTDIR= 04_mapped
LOG_FOLDER= 98_log_files
NAMEM='cat 00_scripts/baseM.txt'
NAMEF='cat 00_scripts/baseF.txt'
SCRIPT= 00_scripts/04_bwa_mem
HEADER= 00_scripts/header-big-mem.txt

cd $WORKING_DIRECTORY
mkdir -p $SCRIPT
mkdir -p $OUTDIR
cd $INDIR

# Fir individual file (no pooling), SM needs to be different:
for FILE in $($NAMEM)
do
        cp $WORKING_DIRECTORY/$HEADER $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
	echo "#PBS -N 04_bwa_mem_"$FILE" " >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "#PBS -o $WORKING_DIRECTORY/$LOG_FOLDER/04_bwa_mem_"$FILE".txt" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "cd $WORKING_DIRECTORY/$INDIR" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
	echo "$BWA_ENV" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "bwa mem -t 28 -M -R '@RG\tID:$FILE\tSM:$FILE\tPL:illumina\tLB:lib1\tPU:unit1' $WORKING_DIRECTORY/${ASSEMBLY} $WORKING_DIRECTORY/$INDIR/"$FILE"_R1_paired.fastq.gz $WORKING_DIRECTORY/$INDIR/"$FILE"_R2_paired.fastq.gz > $WORKING_DIRECTORY/$OUTDIR/"$FILE".sam" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        qsub $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
done ;

# For pooled data, SM needs to be the same:
for FILE in $($NAMEF)
do
        cp $WORKING_DIRECTORY/$HEADER $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
	echo "#PBS -N 04_bwa_mem_"$FILE" " >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "#PBS -o $WORKING_DIRECTORY/$LOG_FOLDER/04_bwa_mem_"$FILE".txt" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "cd $WORKING_DIRECTORY/$INDIR" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "$BWA_ENV" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        echo "bwa mem -t 28 -M -R '@RG\tID:$FILE\tSM:poolFemales\tPL:illumina\tLB:lib1\tPU:unit1' $WORKING_DIRECTORY/${ASSEMBLY} $WORKING_DIRECTORY/$INDIR/"$FILE"_R1_paired.fastq.gz $WORKING_DIRECTORY/$INDIR/"$FILE"_R2_paired.fastq.gz > $WORKING_DIRECTORY/$OUTDIR/"$FILE".sam" >> $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
        qsub $WORKING_DIRECTORY/$SCRIPT/bwa_${FILE##*/}.qsub ;
done ;

