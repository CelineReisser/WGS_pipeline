SCRIPT=00_scripts/06_markDuplicates
HEADER=00_scripts/header-big-mem.txt
PICARDTOOLS= executables
NAME='cat 00_scripts/base.txt'
DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
DATAINPUT= 05_filtered_BAM
OUTDIR= 06_MD

cd $DATADIRECTORY
mkdir -p $SCRIPT
mkdir -p $OUTDIR

for FILE in $($NAME)
do
        cp $HEADER $DATADIRECTORY/$SCRIPT/picard_${FILE##*/}.qsub ;
	echo "#PBS -o /home1/datawork/creisser/sex_det/98_log_files/picardMD_"$FILE".txt " >> $DATADIRECTORY/$SCRIPT/picard_${FILE##*/}.qsub ;
	echo "#PBS -N picardMD_"$FILE" " >> $DATADIRECTORY/$SCRIPT/picard_${FILE##*/}.qsub ;
#	echo "module load java" >> $DATADIRECTORY/$SCRIPT/picard_${FILE##*/}.qsub ;
        echo "cd $DATAINPUT" >> $DATADIRECTORY/$SCRIPT/picard_${FILE##*/}.qsub ;
        echo "java -Xmx115G -jar ${PICARDTOOLS}/MarkDuplicates.jar I=./"$FILE".paired.sorted.bam O=$DATADIRECTORY/$OUTDIR/"$FILE".paired.sorted.MD.bam M=$DATADIRECTORY/$OUTDIR/"$FILE".MarkDup_metrics.txt ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=TRUE CREATE_INDEX=TRUE TMP_DIR=/home1/scratch/creisser/tmp/" >> $DATADIRECTORY/$SCRIPT/picard_${FILE##*/}.qsub ;
        qsub $DATADIRECTORY/$SCRIPT/picard_${FILE##*/}.qsub;
done;
