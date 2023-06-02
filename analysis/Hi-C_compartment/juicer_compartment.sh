work_dir="your_work_directory"
pre="your_filename"
cd $work_dir
#Generate hic file from pair file
java -Xmx16g -jar ./juicer_tools_1.22.01.jar pre -j 5 -r 5000,10000,25000,50000,100000 ./all_pairs/${pre}.select.pairsam.gz ./all_hic/${pre}.hic ./tair10.chromsizes

#Calculate the compartment eigenvector
cooler makebins ./tair10.chromsizes 50000 -o 50k_bins.txt
for chr in {1..5};
do
	java -jar /public/home/fmlai/software/juicer/juicer_tools_1.22.01.jar eigenvector VC ./all_hic/${pre}.hic chr${chr} BP 50000 ./results_50k/${pre}_chr${chr}.txt -p
	#Annotate 1
	paste 50k_bins.txt ./results_50k/${pre}_chr${chr}.txt > ./results_50k/${pre}_chr${chr}.wig
	#Annotate 2
	paste ./results_50k/${pre}_chr${chr}.wig ./expr/chr${chr}.txt > ./results_50k/${pre}_chr${chr}_raw.bed
	#Manual correction of eigenvectors calculated by juicer
	python ./correct_eigenvector.py ./results_50k/${pre}_chr${chr}_raw.bed ./all_bed_correct/${pre}_chr${chr}_corrected.bed
	#Merge chr1-chr5 and convert wig file into bw file
	cat $work_dir/all_bed_correct/${i}_chr1_corrected.bed ./all_bed_correct/${i}_chr2_corrected.bed ./all_bed_correct/${i}_chr3_corrected.bed ./all_bed_correct/${i}_chr4_corrected.bed $work_dir/all_bed_correct/${i}_chr5_corrected.bed> ./all_wig/${i}.wig
	wigToBigWig ./all_wig/${i}.wig ./tair10.chromsizes ./all_bw/${i}.bw
done

1、Annotate 1
#Each wig file thus obtained represents the eigenvector value of juicer under each Bin.
#head GSM5227622_Hi-C_Col-0_35SpH2B.8-eGFP_-10-days_Seedling_chr1.wig -n 5
#		chr1	0	50000	-0.039233628364337886
#		chr1	50000	100000	-0.042908661712362746
#		chr1	100000	150000	-0.04370113970392691
#		chr1	150000	200000	-0.042875418561700365
#		chr1	200000	250000	-0.04433152760173278


2、Annotate 2
#"chr1-5" is a gene expression profile.
#head chr1.txt -n 5 
#	chr1	0	70868
#	chr1	1	62182
#	chr1	2	73995
#	chr1	3	38365
#	chr1	4	56622