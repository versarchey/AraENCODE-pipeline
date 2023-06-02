#############################################
#ChIA-PET data were processed with updated ChIA-PET Tool(V3)software, a JAVA-based package for automatic processing of ChIA-PET sequence data, including linker filtering, read mapping, redundancy removal, protein-binding sites, and chromatin interaction identification.
#############################################
for sample in *_1.fastq;do
prefix=$sample
genomefile="GENOME_FILE_PATH"
genomefaifile="FAI_FILE_PATH"
index="BWA_IDX_PATH"
genomesize="GENOME_SIZE"
java -jar /public/home/zjwang/software/ChIA-PET_Tool_V3/ChIA-PET.jar \
    --mode 1 \
    --fastq1 $fq1 \
    --fastq2 $fq2 \
    --minimum_linker_alignment_score 14 \
    --GENOME_INDEX $index \
    --genomefile $genomefile \
    --GENOME_LENGTH $genomesize \
    --CHROM_SIZE_INFO $genomefaifile \
    --output ./ \
    --restrictionsiteFile ${prefix}/${prefix}.res.bed \
    --prefix ${prefix} --thread 12 \
    --hichip Y --MAPPING_CUTOFF 20 --fastp fastp --skipmap Y --macs2 macs2 --bamout Y
done
