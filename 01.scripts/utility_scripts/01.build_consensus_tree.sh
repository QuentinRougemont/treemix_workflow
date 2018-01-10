#bin/bash

#this relies on sumtrees.py
#see: http://pythonhosted.org/DendroPy/programs/sumtrees.html
#or: pip install --user -U dendropy

mig=$1   #number of migration event for which we build a consensus tree
boot_folder=$2 #the path to the folder containing the bootstraped trees
ml_tree=$3 #the maximum likelihood tree
root="False" #$4

if [[ -z "$mig" ]]
then
        echo "prepparing tree without migration"
        zcat $boot_folder/*.treeout.gz >  sumtrees.no_mig.tree
	zcat out_stem_no.mig.treeout.gz > out.nomig.treeout 
	#to do : treat case where rooted versus undrooted
	if [ $root = "False" ]
	then
		sumtrees.py  -t out.nomig.treeout -o bootree.no.mig.txt sumtree.no_mig.tree
	else 
		sumtrees.py --rooted -t out.nomig.treeout -o bootree.no.mig.txt sumtree.no_mig.tree
	fi
else 
    echo "preparing tree with migration"
    for j in $(ls $boot_folder/*treeout.gz |sed "s/$boot_folder\///g" ) ; 
	do 
       	zcat $boot_folder/*.treeout.gz |sed -n '1p' >> sumtrees."$mig".tree
    	zcat $boot_folder/*.treeout.gz |sed  '1d' |cut -d " " -f 5- |for j in $(seq $mig) ;do sed -n '1p'  >> sumtrees."$mig".migration_edge."$j".tree ; done 
    	#note : I am not sure this is correct to build a consensus of migration edge..
	#I don"t use this anyway.
	#for i in $(seq $mig) ; 
	#do 
	#zcat "$boot_folder"/*.treeout.gz |sed '1d' |cut -d " " -f 5- |awk '{print $1}' | awk -v i=$i 'NR==i'|sed 's/$/;/g' >> migration_edge.mig"$mig"."$i".left 
	#zcat "$boot_folder"/*.treeout.gz |sed '1d' |cut -d " " -f 5- |awk '{print $2}' | awk -v i=$i 'NR==i'|sed 's/$/;/g' >> migration_edge.mig"$mig"."$i".right
	#; done   
    	
    done 
    	#récuperer l'arbre ML ici:
	zcat "$ml_tree" | sed -n '1p' >  out_stem_mig."$mig".treeout
	zcat "$ml_tree" | sed '1d' |cut -d " " -f 5- >  out_stem_migration_edges."$mig".treeout
	
	if [ $root = "False" ]
	then
		echo "building unrooted consensus tree "
		sumtrees.py -t out_stem_mig."$mig".treeout -o bootree."$mig".txt sumtrees."$mig".tree
		#sumtrees.py -t out_stem_mig."$mig".treeout -o bootree."$mig".txt sumtrees."$mig".tree #consensus pour les arbres de migrations
	else 
		echo "building rooted consensus tree"
		sumtrees.py --rooted -t out."$mig".treeout -o bootree."$mig".txt sumtrees."$mig".tree
	fi
fi
