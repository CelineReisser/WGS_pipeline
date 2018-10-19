DATADIRECTORY= #input directory
DATAOUTPUT= #output directory
SCRIPT= #path to store individual scripts
HEADER=#path to header.txt for your cluster specifics
TRIMMOMATICENV=" exectutables"
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
LOG_FOLDER= #path to log folder
NAME='cat /path/to/file/listing/sample_Names/base.txt'


# Global variables

#>Illumina_TruSeq_LT_R1 AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
#>Illumina_TruSeq_LT_R2 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
ADAPTERFILE="path to adapters.fasta"
NCPU=4

cd $DATADIRECTORY

mkdir -p $SCRIPT
mkdir -p $DATAOUTPUT
for file in $($NAME)
do
         cp $HEADER $SCRIPT/trimmomatic_pe_${file##*/}.qsub ;
         echo "cd $DATADIRECTORY" >> $SCRIPT/trimmomatic_pe_${file##*/}.qsub ;
         echo "$TRIMMOMATICENV"  >> $SCRIPT/trimmomatic_pe_${file##*/}.qsub ;
         echo "trimmomatic PE -Xmx23G \
        -threads 4 \
        -phred33 \
        $DATADIRECTORY/"$file"_R1.fastq.gz \
        $DATADIRECTORY/"$file"_R2.fastq.gz \
        $DATAOUTPUT/"$file"_R1.paired.fastq.gz \
        $DATAOUTPUT/"$file"_R1.single.fastq.gz \
        $DATAOUTPUT/"$file"_R2.paired.fastq.gz \
        $DATAOUTPUT/"$file"_R2.single.fastq.gz \
        ILLUMINACLIP:"$ADAPTERFILE":2:30:10 \
        LEADING:28 \
        TRAILING:28 \
        SLIDINGWINDOW:24:28 \
        MINLEN:40 2> $LOG_FOLDER/log.trimmomatic.pe."$TIMESTAMP"" >> $SCRIPT/trimmomatic_pe_${file##*/}.qsub ;
        qsub $SCRIPT/trimmomatic_pe_${file##*/}.qsub ;
 
done ;


