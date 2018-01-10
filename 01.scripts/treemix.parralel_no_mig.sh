#!/bin/bash
#SBATCH -J "BS_treemix"
#SBATCH -o log_%j
#SBATCH -c 10
#SBATCH -A ibismax
#SBATCH -p ibismax
##SBATCH -p low-suspend
##SBATCH --mail-type=FAIL
##SBATCH --mail-user=asdf
#SBATCH --time=10-00:00
#SBATCH --mem=20G

# Load the software with module if applicable:
module load treemix
# Type your command line here

cd $SLURM_SUBMIT_DIR

#arguments 
NUM_CPUS=10
#mig=$1
bootrep=500
#if [[ -z "$mig" ]]
#then
#	echo "error must provide migration events"
#	exit
#fi

#set env
mkdir treemix_mig_v2."$mig" 
cd treemix_mig_v2."$mig"		
cp ../treemix.frq.gz .

#run bootstrap :
seq $bootrep |parallel -j "$NUM_CPUS" ../treemix_iterations.sh {} "$mig"

#run ML tree:
i="-i treemix.frq.gz" #name of input file
#m="-m" #migration
o="-o out_stem_mig"
#b="-bootstrap"
k="-k 100"
#se="-se"
treemix "$i" "$m" "$mig" "$se" "$k" -o out_stem_mig"$mig".replicate."$id" 2>&1   
