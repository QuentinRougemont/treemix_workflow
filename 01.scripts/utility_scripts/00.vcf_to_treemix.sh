#!/bin/bash

input=$1
cluster=$2

if [  -z "$input" ]
then
	echo "error please provide vcffile"
	exit
fi 

if [  -z "$cluster" ]
then
	echo "error please provide strat file"
    echo "strate file 3 colomns of the form:"
    echo "FID\tIIDs\tCLUSTER"
	exit
fi 

plink --vcf "$input" --allow-extra-chr --recode

awk '{print $1, $1"_"$2 }' plink.ped > pop_ind.tmp
cut -d " " -f 3- plink.ped > geno.tmp
cp plink.ped > plink.ped.back
paste pop_ind.tmp geno.tmp  > plink.ped
rm *.tmp

plink --file plink \
	--allow-extra-chr \
	--freq --missing --within "$cluster" \
	--out plink

gzip plink.frq.strat
./01.scripts/utility_scripts/plink2treemix.py plink.frq.strat.gz treemix.frq.gz
