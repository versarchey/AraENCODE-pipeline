##bwa:v0.7.17-r1188
##samtools:v1.11
##pairtools:v1.0.2 
##fastp:v0.23.2
##pairix:v0.3.7
##coreutils:v8.32
##cooler:v0.9.1

nthreads=12
genome_index=AraENCODE.TAIR10.dna.toplevel.fa
fastq1=SRR1761094_1.fastq.gz
fastq2=SRR1761094_2.fastq.gz
fastq1_qc=SRR1761094_1.qc.fastq.gz
fastq2_qc=SRR1761094_2.qc.fastq.gz
output_dir="your_output_path"
prefix="your_filename"
bin_size=10000000

#Fastp is a fast and comprehensive tool designed for QC and trimming of high-throughput sequencing data. It performs quality filtering, adapter trimming, and generates QC reports for further analysis. In the context of Hi-C data, fastp can be utilized to ensure the reliability and accuracy of downstream analysis.
fastp -w 6 -i $fastq1 -I $fastq2 -o $fastq1_qc -O $fastq2_qc -h $output_dir/fastp.html -j $output_dir/fastp.json
#Alignment,hi-C reads are mapped to the tair10(Arabidopsis thaliana) reference genome using bwa version 0.7.17. Specifically, we run:
bwa mem -SP5M -t $nthreads $genome_index $fastq1_qc $fastq2_qc |samtools view -hbS > $output_dir/$prefix.bam
#Filtering valid hi-C alignments
#A bam file is read in, and a pairsam file is written out.The pairsam file is a pairs file, listing one read pair per line, with additional columns to track the sam-file lines, and a pairtools read classification.These classifications include information on whether the read aligned to 0, 1, or multiple places in the genome and whether it aligned end-to-end or if it was clipped.
pairtools parse -c ${genome_index}.fai $output_dir/$prefix.bam -o $output_dir/$prefix.pairsam.gz --drop-sam
#A pairsam (or generically pairs) file is read in, and a pairsam file is written out.The rows are sorted in chr1-chr2-pos1-pos2 order.Note that the flipping order and sort order of chromosomes is not identical.
pairtools sort --memory 24G $output_dir/$prefix.pairsam.gz -o $output_dir/$prefix.sort.pairsam.gz
#Duplicate alignments that share the same pair of 5'end coordinates +/- 3 bps are marked as identified.An arbitrary one is retained with the original classification, while others get a duplicate classification.
pairtools dedup --mark-dups $output_dir/$prefix.sort.pairsam.gz -o $output_dir/$prefix.dedup.pairsam.gz --output-stats $output_dir/$prefix.dedup.stats --output-dups $output_dir/$prefix.dup.pairsam.gz
#Only the reads with pairtools classification UU and UC are retained and output to a pairs file.
pairtools select '(pair_type=="UU") or (pair_type=="UR") or (pair_type=="RU")' $output_dir/$prefix.dedup.pairsam.gz -o $output_dir/$prefix.select.pairsam.gz
#Use pairix to index the generated pairsam.gz file, so as to facilitate faster query and retrieval.
pairix -p pairs $output_dir/$prefix.select.pairsam.gz

#Hic interaction matrix is generated from the pair file, which is saved in. mcool file format and normalized. The. mcool file contains 1kb, 2kb, 5kb, 10kb, 25kb, 50kb, 100kb and 250kb.
cooler cload pairix ${genome_index}.fai:${bin_size} $output_dir/$prefix.select.pairsam.gz $output_dir/$prefix.${bin_size}.cool
cooler zoomify -p 5 -r 1000,2000,5000N --balance $output_dir/$prefix.${bin_size}.cool -o $output_dir/$prefix.mcool

