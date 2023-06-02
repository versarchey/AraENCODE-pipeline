##########################################
#The sequence quality of the whole-genome bisulfite sequencing (WGBS) libraries were mapped to the reference genome using BatMeth2 with default parameters (Zhou et al., 2019). The uniquely mapped reads were used for calculating the DNA methylation levels. Individual cytosines with coverage of at least 3 were considered for methylation-level calling.
#########################################
for sample in *_1.fastq;do
index="BOWTIE_IDX_PATH"
gff="GFF_PATH"
############## TRIM fastq
fastp -i ${sample} -I ${sample%%_*}_2.fastq -o ${sample%%_*}_1.trim.fastq -O ${sample%%_*}_2.trim.fastq
#####################used BatMeth2 pipe 
BatMeth2 pipel -1 ${sample%%_*}_1.trim.fastq -2 ${sample%%_*}_2.trim.fastq -o ${sample%%_*} -p 6 --gff $gff -g $index
done
