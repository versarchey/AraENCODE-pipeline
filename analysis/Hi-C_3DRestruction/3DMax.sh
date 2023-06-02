##3DMax
##g3dtools

work_dir="your_workDir"
prefix="your_filename"

#cool2matrix (50kb resolution)
cooler dump $work_dir/all_mcool/$prefix.mcool::/resolutions/50000 -o $work_dir/mt_results/$prefix.mt

#run 3DMax using parameters 
java -jar $work_dir/3DMax.jar $work_dir/param_file/${prefix}_param.txt

#pdb2g3d for visulisation in washu 
cat $work_dir/bin_50k.txt|awk 'ARGIND==1{a[NR-1]=$0}ARGIND==2{b[$2]=a[$1]}ARGIND==3{print b[$2]"\t"$6"\t"$7"\t"$8}' - $work_dir/3dmax_results/${prefix}_coordinate_mapping.txt $work_dir/3dmax_results/${prefix}_*.pdb|awk -F '\t' -v OFS='\t' 'NF==6{print $1,$2,$4,$5,$6,"m";}' |awk 'NF==6'> $work_dir/3dmax_results/${prefix}.g3d.txt
python $work_dir/g3d-master/g3dtools/g3dtools load $work_dir/3dmax_results/${prefix}.g3d.txt -o $work_dir/g3d_results/${prefix}