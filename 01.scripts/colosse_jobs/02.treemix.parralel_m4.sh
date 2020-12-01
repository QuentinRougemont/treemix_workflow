#!/bin/bash
#PBS -A ihv-653-aa                 
#PBS -N merge__                    
#PBS -l walltime=48:00:00          
#PBS -l nodes=1:ppn=8              
#PBS -r n                          
                                   
# Move to job submission directory 
cd $PBS_O_WORKDIR                  

# Load the software with module if applicable:
source /clumeq/bin/enable_cc_cvmfs
module load nixpkgs/16.09  gcc/7.3.0
module load treemix/1.13

mig=4 #$1 #number of migration event to test 
if [ -z "$mig" ]
then
    echo "-----------------------------------"
    echo " running treemix without migration "
    echo "-----------------------------------"
    sleep 1s
fi

rout=$2 #name of root 
if [ -z "$rout" ]
then
    echo "----------------------------------"
    echo " running treemix without outgroup "
    echo "----------------------------------"
    sleep 1s
fi

./01.scripts/02.treemix.parralel.sh $mig $rout
