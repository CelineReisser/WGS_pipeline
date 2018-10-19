DATADIRECTORY= Path/to/your/copy/of/WGS_pipeline
DATAINPUT=03_trimmed
DATAOUTPUT= 03_trimmed/qc
SCRIPT= 00_scripts/03_fastqc_trimmed
HEADER= 00_scripts/header.txt
FASTQCENV= "executables"

cd $DATADIRECTORY
mkdir -p $SCRIPT
mkdir -p $DATAOUTPUT

for FILE in $(ls $DATAINPUT/*.fastq.gz)
do
        cp $HEADER $SCRIPT/fastqc_${FILE##*/}.qsub ;
        echo "cd $DATADIRECTORY" >> $SCRIPT/fastqc_${FILE##*/}.qsub ;
        echo "$FASTQCENV"  >> $SCRIPT/fastqc_${FILE##*/}.qsub ;
        echo "fastqc $FILE -o $DATAOUTPUT" >> $SCRIPT/fastqc_${FILE##*/}.qsub ;
        qsub $SCRIPT/fastqc_${FILE##*/}.qsub ;
done ;
