#!/bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
LOG_DIR="10-log_files"

if [[ ! -d "$LOG_DIR" ]]
then
    echo "creating log folder" 
    mkdir 10-log_files
fi

if [[ ! -d 02.results ]]
then
    echo "creating 02.results" 
    mkdir 02.results
fi

# Treemix options
# Comment options that you don't want
mig=$1 #number of migration event to test 
rout=$2 #name of root
#root="-root $rout"
i="-i 00.data/treemix.frq.gz" #name of input file
m="-m" #migration
o="-o out_stem_mig"
#b="-bootstrap"
k="-k 100"
se="-se"

# Report if migration is not used
if [ -z "$mig" ]
then
    echo "-----------------------------------"
    echo " running treemix without migration "
    echo "-----------------------------------"
    sleep 1s
fi

# Report if outgroup is not used
if [ -z "$rout" ]
then
    echo "----------------------------------"
    echo " running treemix without outgroup "
    echo "----------------------------------"
    sleep 1s
fi

# Run treemix
treemix $i $rout $m "$mig" $se $b $k -o 02.results/out_stem_mig"$mig" | tee 10-log_files/"$TIMESTAMP"_treemix.log  
