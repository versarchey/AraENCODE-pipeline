###########
#Hi-C paired-end reads were aligned to genomes using the HiC-Pro (v2.11.4) (Servant et al., 2015) pipeline. Default settings were used to remove duplicate reads. We finally got the visualization of the .hic file as an interaction matrix.
##############
module load HiC-Pro/2.11.4
HiC-Pro -c config.txt -i data -o hicpro_out
:<<!
config.txt
#######################################################################
## SYSTEM AND SCHEDULER - Start Editing Here !!
#######################################################################
N_CPU = 2
SORT_RAM = 768M
LOGFILE = hicpro.log

JOB_NAME = 
JOB_MEM = 
JOB_WALLTIME = 
JOB_QUEUE = 
JOB_MAIL = 

#########################################################################
## Data
#########################################################################

PAIR1_EXT = _1
PAIR2_EXT = _2

#######################################################################
## Alignment options
#######################################################################

MIN_MAPQ = 10

BOWTIE2_IDX_PATH =/public/home/lxie/tools/CSATK2/genome/
BOWTIE2_GLOBAL_OPTIONS = --very-sensitive -L 30 --score-min L,-0.6,-0.2 --end-to-end --reorder
BOWTIE2_LOCAL_OPTIONS =  --very-sensitive -L 20 --score-min L,-0.6,-0.2 --end-to-end --reorder

#######################################################################
## Annotation files
#######################################################################

REFERENCE_GENOME = Oryza
GENOME_SIZE = /public/home/lxie/Rice-Hi-C/Oryza.chrom.size
#######################################################################
## Allele specific analysis
#######################################################################

ALLELE_SPECIFIC_SNP = 

#######################################################################
## Capture Hi-C analysis
#######################################################################

CAPTURE_TARGET =
REPORT_CAPTURE_REPORTER = 1

GENOME_FRAGMENT = /public/home/lxie/Rice-Hi-C/Nipponbare.bed

LIGATION_SITE = GATCGATC
MIN_FRAG_SIZE = 
MAX_FRAG_SIZE =
MIN_INSERT_SIZE =
MAX_INSERT_SIZE =

#######################################################################
## Hi-C processing
#######################################################################

MIN_CIS_DIST =
GET_ALL_INTERACTION_CLASSES = 1
GET_PROCESS_SAM = 0
RM_SINGLETON = 1
RM_MULTI = 1
RM_DUP = 1

#######################################################################
## Contact Maps
#######################################################################

BIN_SIZE = 20000 40000 150000 500000 1000000
MATRIX_FORMAT = upper

#######################################################################
## Normalization
#######################################################################
MAX_ITER = 100
FILTER_LOW_COUNT_PERC = 0.02
FILTER_HIGH_COUNT_PERC = 0
EPS = 0.1
!
