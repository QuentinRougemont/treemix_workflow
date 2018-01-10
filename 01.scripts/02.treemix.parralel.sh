#!/bin/bash
#SBATCH -J "BS_treemix"
#SBATCH -o log_%j
#SBATCH -c 1
#SBATCH -A ibismax
#SBATCH -p ibismax
##SBATCH -p low-suspend
##SBATCH --mail-type=FAIL
##SBATCH --mail-user=asdf
#SBATCH --time=10-00:00
#SBATCH --mem=2G

# Load the software with module if applicable:
module load treemix
# Type your command line here

cd $SLURM_SUBMIT_DIR

#arguments 
#NUM_CPUS=10
mig=$1
bootrep=500
if [[ -z "$mig" ]]
then
	echo "error must provide migration events"
	exit
fi

#set env
mkdir 02.results.with_boot
cd 02.results.with_boot

mkdir treemix_boot_mig."$mig" 
cd treemix_boot_mig."$mig"		
cp ../../00.data/treemix.frq.gz .

#run bootstrap :
seq $bootrep |parallel -j "$NUM_CPUS" ../../01.scripts/treemix_iterations.sh {} "$mig"

#run ML tree:
i="-i ../00.data/treemix.frq.gz" #name of input file
m="-m" #migration
o="-o out_stem_mig"
#b="-bootstrap"
k="-k 100"
#se="-se"
treemix "$i" "$m" "$mig" "$se" "$k" -o out_stem_mig"$mig"    
