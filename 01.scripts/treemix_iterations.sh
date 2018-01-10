#!/bin/bash
# Load the software with module if applicable:
module load treemix

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
LOG_DIR="10-log_files"

if [[ ! -d "$LOG_DIR" ]]
then
	echo "creating log folder" 
	mkdir 10-log_files
fi

id=$1
mig=$2
#rout="BRO"
#treemix options
i="-i treemix.frq.gz" #name of input file
#m="-m" #migration
o="-o out_stem_mig"
b="-bootstrap"
k="-k 100"
root="-root "$rout" "
#se="-se"
treemix $i $m "$mig" $se $b $k -o out_stem_mig"$mig".replicate."$id" 2>&1 | tee 10-log_files/"$TIMESTAMP"_treemix.log  
