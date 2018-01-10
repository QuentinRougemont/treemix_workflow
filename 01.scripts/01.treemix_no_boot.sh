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
# Type your command line here
cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
LOG_DIR="10-log_files"

if [[ ! -d "$LOG_DIR" ]]
then
	echo "creating log folder" 
	mkdir 10-log_files
fi

#comment option that you don"t want
mig=$1 #number of migration event to test 
rout=$2 #name of root 
#treemix options
#root="-root $rout"
i="-i 00-data/treemix.frq.gz" #name of input file
m="-m" #migration
o="-o out_stem_mig"
#b="-bootstrap"
k="-k 100"
se="-se"
treemix $i $rout $m "$mig" $se $b $k -o 02-results/out_stem_mig"$mig".replicate."$id"  | tee 10-log_files/"$TIMESTAMP"_treemix.log  