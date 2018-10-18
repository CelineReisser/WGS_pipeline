SCRIPT=/home1/datawork/creisser/sex_det/00_scripts/06_markDuplicates
HEADER=/home1/datawork/creisser/sex_det/00_scripts/header-big-mem.txt
PICARDTOOLS="/home1/datahome/creisser/local-programs/picard-tools-1.119"
NAME='cat /home1/datawork/creisser/sex_det/00_scripts/base.txt'
DATADIRECTORY=/home1/datawork/creisser/sex_det/05_filtered_BAM
OUTDIR=/home1/scratch/creisser/sex_det/06_MD

mkdir -p $SCRIPT
mkdir -p $OUTDIR

for FILE in $($NAME)
do
        cp $HEADER $SCRIPT/picard_${FILE##*/}.qsub ;
	echo "#PBS -o /home1/datawork/creisser/sex_det/98_log_files/picardMD_"$FILE".txt " >> $SCRIPT/picard_${FILE##*/}.qsub ;
	echo "#PBS -N picardMD_"$FILE" " >> $SCRIPT/picard_${FILE##*/}.qsub ;
	echo "module load java" >> $SCRIPT/picard_${FILE##*/}.qsub ;
        echo "cd $DATADIRECTORY" >> $SCRIPT/picard_${FILE##*/}.qsub ;
        echo "java -Xmx115G -jar ${PICARDTOOLS}/MarkDuplicates.jar I=./"$FILE".paired.sorted.bam O=$OUTDIR/"$FILE".paired.sorted.MD.bam M=$OUTDIR/"$FILE".MarkDup_metrics.txt ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=TRUE CREATE_INDEX=TRUE TMP_DIR=/home1/scratch/creisser/tmp/" >> $SCRIPT/picard_${FILE##*/}.qsub ;
#        echo "rm "$FILE".paired.sorted.bam" >> $SCRIPT/picard_${FILE##*/}.qsub ;
        qsub $SCRIPT/picard_${FILE##*/}.qsub;
done;
