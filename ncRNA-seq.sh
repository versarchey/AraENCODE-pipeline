####################
#in the process of miRNA analysis, firstly filter the adapter with cutadapt, then mapped reads to the genome with mirdeep2, and normalized  the expression of miRNA annotated in miRBase. siRNA analysis first filters out tRNA, rRNA and miRNA in rice genome, and then found 21nt and 24nt siRNA reads by script.
#####################
module load cutadapt/1.9.1
module load deepTools/2.5.3
#######miRNA
genomeindex="GENOMDE_INDEX"
for i in *.fastq
do
#####################Trim fastq
cutadapt -g GATCGTCGGACT -a TGGAATTCTCGG --quality-base 33 -m 10 -O 4 --discard-untrimmed $i > ${i}.trim.fastq
################################ mapped reads to rice by mirdeep2
perl ~/tools/mirdeep2-master/bin/mapper.pl ./${i}.trim.fastq -e -h -j -m -p $genomeindex -s ${i%%.*}.fa -t ${i%%.*}.arf -v
############################# quntified counts for miRNA
~/tools/mirdeep2-master/bin/quantifier.pl -p osa_hairpin.fa -m osa_mature.fa -r ./${i%%.*}.fa -y ${i%%.*}
done
###################siRNA
index="OtherRNA_index"
#otherRNA include tRNA rRNA miRNA
for i in *.fastq
do
###### Mapped the reads to other RNA and get the unmapped reads
bowtie $index -q -a -v 0 --al ${i%%.*} --un ${i%%.*}_un ./$i -S ${i%%.*}.sam
###### Mapped unmapped reads to Rice genome and filter 21nt 24nt siRNA
bowtie $genomeindex -q -a -v 0 --al ${i%%_*}_map --un ${i%%_*}_nomap ./${i%%.*}_un -S ${i%%_*}.rice.sam
python 21_24_filter.py $i ${i%%.*}_24.sam ${i%%.*}_21.sam
samtools view -bS ${i%%.*}_24.sam -O ${i%%.*}_24.bam
samtools view -bS ${i%%.*}_21.sam -O ${i%%.*}_21.bam
done
rm *.sam
############################# convert bam to bw file
for i in *.bam
do
samtools sort ${i%%.*}.bam -o ${i%%.*}.sorted.bam
samtools index ${i%%.*}.sorted.bam
bamCoverage -b ${i%%.*}.sorted.bam -o ./${i%%.*}.bw
done
