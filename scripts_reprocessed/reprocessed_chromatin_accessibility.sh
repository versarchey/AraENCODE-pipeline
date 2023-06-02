#########################################
#For FAIRE-seq, ATAC-seq, MNase-seq data, the alignment processes were similar to that for ChIP-Seq. Peaks were identified by MACS2 with the following settings: macs2 callpeak -t input_file --nomodel --shift -100 --extsize 200 -f BAM -n output_peak file -B -q 0.05 -g 3.6e8.
##########################################
module load fastp/0.20.0
module load deepTools/2.5.3
module load MACS2/2.1.1
module load BWA/0.7.17
for sample in *_1.fastq;do
index="BWA_IDX_PATH"
genomesize="GENOME_SIZE"
input="INPUT_BAM"
######################################Trim raw fastq
fastp -i $sample -I ${sample%%_*}_2.fastq -o ${sample%%_*}_1.trim.fastq -O ${sample%%_*}_2.trim.fastq
########Mapping convert and filter
bwa mem -M $index -t 10 ${sample%%_*}_1.trim.fastq ${sample%%_*}_2.trim.fastq > ${sample%%_*}.sam
samtools view --threads 10 -bS ${sample%%_*}.sam -o ${sample%%_*}.bam
samtools sort ${sample%%_*}.bam --threads 10 -o ${sample%%_*}.sorted.bam
samtools rmdup ${sample%%_*}.sorted.bam ${sample%%_*}.rmdup.bam
samtools view -b ${sample%%_*}.rmdup.bam -q 30 -o ${sample%%_*}.unique.bam
rm ${sample%%_*}.bam ${sample%%_*}.sam ${sample%%_*}.sorted.bam ${sample%%_*}.rmdup.bam
######## BigWig file
samtools index -b ${sample%%_*}.unique.bam
bamCoverage -b ${sample%%_*}.unique.bam -o $sample.bw
####################################################MACS2 call peaks
#ATAC-seq MNase-seq FAIRE-seq
macs2 callpeak -t ${sample%%_*}.unique.bam --nomodel --shift -100 --extsize 200 -f BAM -n ${sample%%_*} -B -q 0.05 -g genomesize --outdir ./${sample%%_*}
done
