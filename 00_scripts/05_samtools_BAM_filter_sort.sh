DATADIRECTORY=/Path/to/your/copy/of/WGS_pipeline
DATAINPUT=04_mapped
DATAOUTPUT=05_filtered_BAM
SCRIPT= 00_scripts/05_samtools_filter_sort
HEADER= 00_scripts/header-big-mem.txt
SAMTOOLSENV= executables
NAME="cat 00_scripts/base.txt"

cd $DATADIRECTORY
mkdir -p $SCRIPT
mkdir -p $DATAOUTPUT

for FILE in $($NAME)
do
        cp $DATADIRECTORY/$HEADER $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "#PBS -o cd "$DATADIRECTORY"/98_log_files/05_samtools_filter_"$FILE".txt" >> $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "#PBS -N 05_samtools_filter_"$FILE" " >> $DATADIRECTORY$SCRIPT/samtools_${FILE##*/}.qsub ;
        echo "cd $DATAINPUT" >> $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
        echo "$SAMTOOLSENV"  >> $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
        echo "samtools view -b -f0x2 -F 256 -q5 "$FILE".sam -o $DATAOUTPUT/"$FILE".paired.bam"  >> $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "samtools sort -@ 8 $DATADIRECTORY/$DATAOUTPUT/"$FILE".paired.bam -o $DATADIRECTORY/$DATAOUTPUT/"$FILE".paired.sorted.bam"  >> $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "samtools index -b $DATADIRECTORY/$DATAOUTPUT/"$FILE".paired.sorted.bam" >> $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ; 
	echo "rm $DATADIRECTORY/$DATAOUTPUT/"$FILE".paired.bam" >> $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
        qsub $DATADIRECTORY/$SCRIPT/samtools_${FILE##*/}.qsub ;
done ;
