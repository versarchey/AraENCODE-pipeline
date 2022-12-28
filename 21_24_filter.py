import sys
sam=open(sys.argv[1],"r")
out_24nt=open(sys.argv[2],"w")
out_21nt=open(sys.argv[3],"w")
for i in sam:
	lines=i.strip().split("\t")
	if len(lines)>6:
		ll="\t".join(lines)
		if lines[5].split("M")[0]=="24":
			out_24nt.write(ll+"\n")
		if lines[5].split("M")[0]=="21":
			out_21nt.write(ll+"\n")
	else:
		ll="\t".join(lines)
		out1.write(ll+"\n")
		out.write(ll+"\n")
sam.close()
out.close()
out1.close()
