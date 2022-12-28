#############################################
#ChIA-PET data were processed with updated ChIA-PET Tool(V3)software, a JAVA-based package for automatic processing of ChIA-PET sequence data, including linker filtering, read mapping, redundancy removal, protein-binding sites, and chromatin interaction identification.
#############################################
for sample in *_1.fastq;do
index="BWA_IDX_PATH"
genomesize="GENOME_SIZE"
java -jar ChIA-PET.jar --mode 1 --fastq1 test_long_1.fastq --fastq2 test_long_2.fastq --linker ChIA-PET_Tool_V3/linker/linker_long.txt --minimum_linker_alignment_score 14 --GENOME_INDEX $index --GENOME_LENGTH 3.6E8 --CHROM_SIZE_INFO $genomesize --CYTOBAND_DATA oryza_cytoBandIdeo.txt --output test_long --SPECIES 3 --prefix OUT --thread 4
done
