#!/usr/bin/Rscript

#move to 02.results before ruuning me!
#can be run from the terminal no need to open R 
source('../01.scripts/utility_scripts/plotting_funcs.R')

argv <- commandArgs(TRUE)
pop.uniq <- argv[1]
#pop.uniq <-"../00.data/pop.uniq" #a list of the uniq pop name
if(!file.exists(pop.uniq)){
        print("error please provide a list with population name...")
        print("list shoud contain one pop by line ")
       stop("program stopped because of the previous errors")
}



all.files=list.files(pattern="covse.gz")
all.files=all.files[-1]

for(i in 1:length(all.files)){
    pdf(file=paste("treemix.m.",i,".pdf",sep=""),12,8)
    plot_tree(paste("out_stem_mig",i, sep=""))
    dev.off()
}

pdf(file="treemix.no.mig.pdf",12,8)
    plot_tree("out_stem_mig")
dev.off()

get_f("out_stem_mig") ->m0

m=NULL
z=NULL

for(i in 1:length(all.files))
    {
    m[i] <- get_f(paste("out_stem_mig",i,  sep=""))
    z <- (c(m0,m))
    }

write.table(z,"variance_f.res",quote=F,col.names=F,row.names=F)

pdf(file="migration.edge.choice.pdf")
plot(seq(0,length(all.files)),z,pch="*",cex=2,col="blue", type="b",xlab="migration edge number", ylab="% explained variance")
dev.off()

pdf(file="resid1.pdf")
plot_resid("out_stem_mig",pop.uniq)
dev.off()

for(i in 1:length(all.files)){
    pdf(file=paste("treemix.residuals.m.",i,".pdf",sep=""))
    plot_resid(paste("out_stem_mig",i,sep=""),pop.uniq)
        dev.off()
}
