import sys
'''
The input file format should be:
chr1	0	50000	-0.039233628364337886	chr1	0	70868
chr1	50000	100000	-0.042908661712362746	chr1	1	62182
chr1	100000	150000	-0.04370113970392691	chr1	2	73995
chr1	150000	200000	-0.042875418561700365	chr1	3	38365
chr1	200000	250000	-0.04433152760173278	chr1	4	56622
'''

if len(sys.argv) != 3 :
    print('the python script needs two parameter')
    print("python "+sys.argv[0]+"file_path"+"output_path")
    sys.exit(0)
file_path=sys.argv[1]
output_path=sys.argv[2]

# Create a dictionary to save the correction results.
d = {'positive': [], 'negative': []}

# Open file
with open(file_path, 'r') as f:
    for line in f:
        # Divide each row into lists.
        cols = line.strip().split()
        # Get the signal value of the fourth column.
        signal_value = float(cols[3])
        # Get the gene expression value of the seventh column.
        gene_expression = float(cols[6])
        # According to the signal value, the gene expression value is added to the positive and negative lists of the dictionary.
        if signal_value < 0:
            d['negative'].append(gene_expression)
        else:
            d['positive'].append(gene_expression)

# Calculate the sum of the positive and negative lists in the dictionary.
positive_sum = sum(d['positive'])
negative_sum = sum(d['negative'])

# According to the sum of the positive and negative lists, the values of the eighth column and the ninth column in the new file are determined.
if positive_sum > negative_sum:
    eighth_col_value = 'A'
    ninth_col_value = lambda x: x
    # Write a new file
    with open(output_path, 'w') as f:
        f.write('#chr\tbins_start\tbins_end\tcorrect_eigenvector\n')
        with open(file_path, 'r') as infile:
            for line in infile:
                cols = line.strip().split()
                if float(cols[3]) > 0:
                    cols.append("A")
                else:
                    cols.append("B")
                cols.append(str(ninth_col_value(float(cols[3]))))
                cols=[cols[0],cols[1],cols[2],cols[8]]
                f.write('\t'.join(cols) + '\n')
else:
    eighth_col_value = 'B'
    ninth_col_value = lambda x: -x
    # Write a new file
    with open(output_path, 'w') as f:
        f.write('#chr\tbins_start\tbins_end\tcorrect_eigenvector\n')
        with open(file_path, 'r') as infile:
            for line in infile:
                cols = line.strip().split()
                if float(cols[3]) > 0:
                    cols.append("B")
                else:
                    cols.append("A")
                cols.append(str(ninth_col_value(float(cols[3]))))
                cols=[cols[0],cols[1],cols[2],cols[8]]
                f.write('\t'.join(cols) + '\n')