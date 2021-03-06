# Treemix workflow

quick and dirty script to perform [Treemix](http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1002967) analysis with and without bootstrap

Also contains treemix utility to perform plots with defaults treemix function

WARNING:
Read the treemix manual carefully and edit the treemix_workflow scripts
depending on the options you want to use

If you don't have your input in treeemix format, then you can use `01.scripts/utility_scripts/00.vcf_to_treemix.sh`
which is a simplified script to convert a vcf file into treemix input file

## Environment:

- Linux should work on any recent cluster
- tested frequently on Ubuntu 18.04 bionic 

## Dependencies:  

- Treemix
- [plink](https://www.cog-genomics.org/plink/2.0/)

 
## plink installation

```bash

wget http://s3.amazonaws.com/plink2-assets/plink2_linux_x86_64_20201028.zip 
unzip plink2_linux_x86_64_20201028.zip         

#then add path to bashrc or cp to bin

```

## To do:

- Fill this README
- Add scripts for plotting treemix with bootstrap support for nodes

## References:

Pickrell, J. K., and J. K. Pritchard. 2012. Inference of Population Splits and
Mixtures from Genome-Wide Allele Frequency Data. PLoS Genet. 8:e1002967.
