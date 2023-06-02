##cuda9.2 + gcc7.3
##juicer_tools 1.22.01
##java8

data_dir='your_data_dir'
work_dir='your_work_dir'
hic_file='file.hic'
loops_results_dir='result_dir'

#loops detection by HiCCUPS
java -jar juicer_tools_1.22.01.jar hiccups \
-m 512 \
-r 5000,10000 \
-k KR \
-f .1,.1 \ 
-p 4,2 \
-i 7,5 \
-t 0.02,1.5,1.75,2 \
-d 20000,21000 \
--threads 16 \
$data_dir/${hic_file} $work_dir/${loops_results_dir}

