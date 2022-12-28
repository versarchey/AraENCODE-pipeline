###########################
#Sequence quality of RNA-Seq libraries was evaluated by FastQC (Andrews, 2013), and the adapter sequences and low-quality reads were filtered using Trimmomatic (v0.36) (Bolger et al., 2014). Then cleaned reads were mapped to the reference genome using TopHat2 (v2.1.0) (Kim et al., 2013), and gene expression was quantified using Cufflinks (v2.1.1) (Trapnell et al., 2012).
##############################
module load fastp/0.20.0
for i in *_1.fastq
do
###########
fastp -i $sample -I ${sample%%_*}_2.fastq -o ${sample%%_*}_1.trim.fastq -O ${sample%%_*}_2.trim.fastq
###################mapped reads
tophat2 -p 4 -o ~/${i%%.*}/ $index ${sample%%_*}_1.trim.fastq  ${sample%%_*}_2.trim.fastq
#####quantified and normalized the FPKM
cuffquant -o ./${i%%.*} -library-type fr-firststrand $gff ./${i%%.*}/accept_hits.bam
cuffnorm --library-type fr-firststrand $gff -o cuffnorm ./${i%%.*}/abundances.cxb
##############
done
