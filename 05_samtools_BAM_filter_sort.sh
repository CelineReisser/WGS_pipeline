DATADIRECTORY=/home1/scratch/creisser/sex_det/04_mapped
DATAOUTPUT=/home1/datawork/creisser/sex_det/05_filtered_BAM
SCRIPT=/home1/datawork/creisser/sex_det/00_scripts/05_samtools_filter_sort
HEADER=/home1/datawork/creisser/sex_det/00_scripts/header-big-mem.txt
SAMTOOLSENV=". /appli/bioinfo/samtools/1.4.1/env.sh"
NAME="cat /home1/datawork/creisser/sex_det/00_scripts/base.txt"

mkdir -p $SCRIPT
mkdir -p $DATAOUTPUT

for FILE in $($NAME)
do
        cp $HEADER $SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "#PBS -o /home1/datawork/creisser/sex_det/98_log_files/05_samtools_filter_"$FILE".txt" >> $SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "#PBS -N 05_samtools_filter_"$FILE" " >> $SCRIPT/samtools_${FILE##*/}.qsub ;
        echo "cd $DATADIRECTORY" >> $SCRIPT/samtools_${FILE##*/}.qsub ;
        echo "$SAMTOOLSENV"  >> $SCRIPT/samtools_${FILE##*/}.qsub ;
        echo "samtools view -b -f0x2 -F 256 -q5 "$FILE".sam -o $DATAOUTPUT/"$FILE".paired.bam"  >> $SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "samtools sort -@ 8 $DATAOUTPUT/"$FILE".paired.bam -o $DATAOUTPUT/"$FILE".paired.sorted.bam"  >> $SCRIPT/samtools_${FILE##*/}.qsub ;
	echo "samtools index -b $DATAOUTPUT/"$FILE".paired.sorted.bam" >> $SCRIPT/samtools_${FILE##*/}.qsub ; 
	echo "rm $DATAOUTPUT/"$FILE".paired.bam" >> $SCRIPT/samtools_${FILE##*/}.qsub ;
        qsub $SCRIPT/samtools_${FILE##*/}.qsub ;
done ;
