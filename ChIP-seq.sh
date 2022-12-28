###########################
#Reads from ChIP-seq libraries were aligned to the reference genome assembly (Minghui63RS1, ZhenShan97RS1 (Zhang et al., 2016) and Nipponbare(7.0) (Kawahara et al., 2013) using the bwa (v0.7.13) mem (Li and Durbin, 2009) algorithm. Mapped reads with a MAPQ quality score below 30 and PCR duplicates were filtered using SAMTools (v1.3.1) (Li et al., 2009) to ensure high-quality aligned data. For analysis of ChIP-seq libraries, narrow-peak calling settings were used in MACS2 (Zhang et al., 2008) (v2.1.0): macs2 callpeak -t input_file -c control_file -f BAM -n output peak_file -B -g 3.6e8. For broad-peak mode, MACS2 was used with FDR < 0.1.
##########################
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
#broad peak for ChIP-seq
macs2 callpeak -t ${sample%%_*}.unique.bam -c $input -f BAM -n ${sample%%_*} -B --broad -g genomesize --outdir ./${sample%%_*}_broad &
#narrow peak for ChIP-seq
macs2 callpeak -t ${sample%%_*}.unique.bam -c $input -f BAM -n ${sample%%_*} -B -g genomesize --outdir ./${sample%%_*}
done

