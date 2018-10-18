DATADIRECTORY=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/03_trimmed
DATAOUTPUT=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/02_data/qc
SCRIPT=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/03_fastqc_trimmed_scripts
HEADER=/home1/scratch/creisser/platax/sex_det/rna-seq_mapping_workflow/00_scripts/header.txt
FASTQCENV=". /appli/bioinfo/fastqc/latest/env.sh"

mkdir -p $SCRIPT

for FILE in $(ls $DATADIRECTORY/*.fastq.gz)
do
        cp $HEADER $SCRIPT/fastqc_${FILE##*/}.qsub ;
        echo "cd $DATADIRECTORY" >> $SCRIPT/fastqc_${FILE##*/}.qsub ;
        echo "$FASTQCENV"  >> $SCRIPT/fastqc_${FILE##*/}.qsub ;
        echo "fastqc $FILE -o $DATAOUTPUT" >> $SCRIPT/fastqc_${FILE##*/}.qsub ;
        qsub $SCRIPT/fastqc_${FILE##*/}.qsub ;
done ;
