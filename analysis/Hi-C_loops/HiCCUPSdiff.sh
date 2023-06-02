##cuda9.2 + gcc7.3
##juicer_tools 1.22.01
##java8

data_dir='your_data_dir'
work_dir='your_work_dir'
hic_file='file.hic'
loops_results_dir='result_dir'

#differential loops detection by HiCCUPSdiff
for m in `echo 5000 10000`;do
for i in `echo sample1 sample2`;do
for j in `echo sample3 sample4`;do
java -jar $data_dir/juicer_tools_1.22.01.jar hiccupsdiff \
-m $m \
$data_dir/hic/$i.hic \
$data_dir/hic/$j.hic \
processed/$i.loops/postprocessed_pixels_$m.bedpe \
processed/$j.loops/postprocessed_pixels_$m.bedpe \
wt_clf_$m_${i}vs${j};
done;done;done