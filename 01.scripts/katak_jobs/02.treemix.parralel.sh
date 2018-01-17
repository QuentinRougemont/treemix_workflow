#!/bin/bash
#SBATCH -J "se_treemix"
#SBATCH -o log_%j
#SBATCH -c 1
#SBATCH -A ibismax
#SBATCH -p ibismax
##SBATCH -p low-cancel
##SBATCH --mail-type=FAIL
##SBATCH --mail-user=asdf
#SBATCH --time=10-00:00
#SBATCH --mem=4G

# Load the software with module if applicable:
module load treemix



mig=$1 #number of migration event to test 
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

./01-scripts/02.treemix.parralel.sh $mig $rout
