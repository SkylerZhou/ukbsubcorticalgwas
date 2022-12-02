# library packages
if(!require(data.table)) install.packages("data.table")
if(!require(qqman)) install.packages("qqman")
if(!require(tidyverse)) install.packages("tidyverse")
install.packages("devtools")
devtools::install_github("johannesbjork/LaCroixColoR")
install.packages("Redmonder")


library(qqman)
library(tidyverse)
library(data.table)
library(RColorBrewer)
library(lattice)
library(LaCroixColoR)
library(Redmonder)


# set variable
field <- 25012:25024
for(i in field) {
  filename <- paste(i, ".assoc.regenie.merged.txt", sep="")
  manname <- paste(i, "_manhattan.tiff", sep="")
  qqname <- paste(i, "_qq.tiff", sep="")
  
  # make plots
  result_log = fread(filename)
  
  select = dplyr::select
  d1 = result_log %>% select(Chr = CHROM, Pos = GENPOS, Marker = ID, p = LOG10P)
  d1 = d1 %>% drop_na(p)
  summary(d1)
  
  manhattan(d1, 
            chr="Chr",
            bp="Pos",
            p="p",
            snp="Marker",
            logp = FALSE,
            col = lacroix_palette("PassionFruit", n = 22, type = "continuous"),
            suggestiveline=7,
            genomewideline=9.687,
            main=i, 
            cex.axis=0.5,
            las=2,
            annotateTop=TRUE)
  tiff(manname, units="in",width=11,height=5,res=300)
  manhattan(d1, 
            chr="Chr",
            bp="Pos",
            p="p",
            snp="Marker",
            logp = FALSE,
            col = lacroix_palette("PassionFruit", n = 22, type = "continuous"),
            suggestiveline=7,
            genomewideline=9.687,
            main=i, 
            cex.axis=0.5,
            las=2,
            annotateTop=TRUE)
  dev.off()
}



qqmath(d1$p, distribution=function(x){-log10(qunif(1-x))},  
       pch=20, col="black", 
       xlab="Observed -log10p", 
       ylab="Expected -log10p",
       abline = c(0, 1))
tiff(qqname)

# these qqmath functions need to have at least 5 secs interval in between 
# for dev.off() to not collaspe into each other
qqmath(d1$p, distribution=function(x){-log10(qunif(1-x))},  
       pch=20, col="black", 
       xlab="Observed -log10p", 
       ylab="Expected -log10p",
       abline = c(0, 1))
print(qqname)
dev.off()
