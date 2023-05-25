# AraENCODE-pipeline
## What is AraENCODE:
<br>  Here we combine the published Arabidopsis epigenomic datasets (ChIP-seq, ATAC-seq, MNase-seq, BS-seq, RNA-seq and ncRNA-seq) and 3D genome data to construct a comprehensive Arabidopsis thaliana Encyclopedia of DNA Elements Database (AraENCODE). This database contains ~1800 datasets. The Arabidopsis TAIR10 is uniformly selected as the reference genome. So, it's convenient for the display and comparison of data. AraENCODE database mainly includes seven search functions, including "Histone Modification Search", "Transcriptome Search","Open Chromatin Region Search", "DNA methylation Search", "3D Genome", "Chromatin State" and "Wildtype vs Mutant Search", and they help database users to quickly search for targeted epigenetics. This also shows the epigenetic landscape of Arabidopsis in AraENCODE database from five aspects: histone modification, transcriptional expression, open chromatin state, DNA methylation degree and mutant difference. AraENCODE database has also equipped with WashU Epigenome Browser, it can show the standardized Arabidopsis datasets more intuitively.</br>
### The AraENCODE pipeline have following dependencies :
* Python (2.7)
* samtools (>1.9)
* [ChIA-PET tools (V3 Mar 21, 2023)])(https://github.com/GuoliangLi-HZAU/ChIA-PET_Tool_V3/commits/master)
* BWA(0.7.17)
* MACS2(2.1.1)
* deepTools(2.5.3)
* fastp(0.20.0)
* cutadapt(1.9.1)
* bowtie(1.1.1)
* TopHat(v2.1.0)
* Cufflinks(2.2.1)
* HiC-Pro(2.11.4)
* BatMeth2(2.01)
<br></br>
### AraENCODE website:
[AraENCODE http://glab.hzau.edu.cn/AraENCODE/](http://glab.hzau.edu.cn/AraENCODE/)
