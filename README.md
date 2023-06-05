# A Comprehensive Epigenomic Database of Arabidopsis Thaliana
![image](https://github.com/versarchey/AraENCODE-pipeline/blob/main/main.png)
## AraENCODE
[AraENCODE website](http://glab.hzau.edu.cn/AraENCODE/) <br>
[AraENCODE tutorial](http://glab.hzau.edu.cn/AraENCODE/pages/tutorial.html) <br>
[Contact with us](http://glab.hzau.edu.cn/AraENCODE/pages/contact.html)

## What is AraENCODE?
 Here we combine the published Arabidopsis epigenomic datasets (e.g. ChIP-seq, ATAC-seq, MNase-seq, BS-seq), 3D genome datasets (e.g. Hi-C, HiChIP, ChIA-PET), and transcriptome datasets (e.g. RNA-seq and ncRNA-seq) to construct a comprehensive Arabidopsis thaliana Encyclopedia of DNA Elements Database (AraENCODE). This database contains 4511 datasets. The Arabidopsis TAIR10 is uniformly selected as the reference genome. So, it's convenient for the display and comparison of data. AraENCODE database mainly includes seven search functions, including Histone Modification, Transcriptome, Open Chromatin Region, DNA methylation, 3D Genome, Chromatin State and Wildtype vs Mutant, and they help database users to quickly search for targeted epigenetics. This also shows the epigenetic landscape of Arabidopsis in AraENCODE database from five aspects: histone modification, transcriptional expression, open chromatin state, DNA methylation degree and mutant difference. AraENCODE database has also equipped with WashU Epigenome Browser, it can show the standardized Arabidopsis datasets more intuitively.<br>
# AraENCODE-pipeline
### The AraENCODE pipeline have following dependencies :
* [Python (3.8.8) and Anaconda](https://www.anaconda.com/) for creating a needed environment.
* [samtools (>1.9)](http://www.htslib.org/download/) for processing alignment results 
* [ChIA-PET tools (V3 Mar 21, 2023)](https://github.com/GuoliangLi-HZAU/ChIA-PET_Tool_V3/commits/master) for processing HiChIP datasets
* [pairtools (v1.0.2)](https://github.com/open2c/pairtools) for processing sequencing data from a Hi-C experiment
* [3DMax (v1.0)](https://github.com/BDM-Lab/3DMax) for 3D structure reconstructing
* [juicer tools (v1.22.01)](https://github.com/aidenlab/juicer/wiki/Feature-Annotation) for matrix aggregation, loops detection and compartment analysis
* [cooler (v0.9.1)](https://github.com/open2c/cooler) for matrix aggregation and performing operation on .mcool file
* [BWA (v0.7.17)](https://github.com/lh3/bwa) for aligning sequencing data from different experiments to genome
* [MACS2 (v2.1.1)](https://hbctraining.github.io/Intro-to-ChIPseq/lessons/05_peak_calling_macs.html) for peak calling used to identify areas in the genome that have been enriched with aligned reads as a consequence of performing a ChIP-sequencing or a OCR-sequencing(e.g. ATAC-Seq) experiment
* [deepTools (v2.5.3)](https://github.com/deeptools/deepTools) for creating normalized coverage files in standard bedGraph and bigWig file formats
* [fastp (v0.20.0)](https://github.com/OpenGene/fastp) providing fast all-in-one preprocessing (QC/adapters/trimming/filtering/splitting/merging...) for FastQ files.
* [TopHat (v2.1.0)](http://ccb.jhu.edu/software/tophat/index.shtml) for alignment for RNA-sequence (RNA-seq) experiments
* [Cufflinks (v2.2.1)](https://github.com/cole-trapnell-lab/cufflinks) for estimating abundances of transcripts, and testing for differential expression and regulation in RNA-Seq samples
* [BatMeth2 (v2.01)](https://github.com/GuoliangLi-HZAU/BatMeth2) for Bisulfite DNA Methylation Data Analysis with Indel-sensitive Mapping
* [HiGlass Browser (v1.11)](https://docs.higlass.io/)
* [WashU epigenome browser (v54.0.2)](http://epigenomegateway.wustl.edu/)

<br></br>



