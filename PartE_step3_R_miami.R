# load packages
if(!require(usethis)) install.packages("usethis")
if(!require(devtools)) install.packages("devtools")
library(devtools)

if(!require(qqman)) install.packages("qqman")
if(!require(tidyverse)) install.packages("tidyverse")
if(!require(data.table)) install.packages("data.table")
if(!require(data.table)) install.packages("dplyr")
devtools::install_github("johannesbjork/LaCroixColoR")

library(qqman)
library(tidyverse)
library(dplyr)
library(data.table)
library(LaCroixColoR)

setwd("D:/R")

field <- 11:24
for(i in field) {
  
  # load my data frames
  ifilename <- paste("250", i, ".assoc.regenie.merged.txt", sep="")
  imiami <- paste("250", i, "_miami.tiff", sep="")
  iname <- paste("250", i, sep="")
  isum = fread(ifilename)

  select = dplyr::select
  idf = isum %>% select(Chr = CHROM, Pos = GENPOS, Marker = ID, p = LOG10P)
  idf = idf %>% drop_na(p)

  
  # load elliot data frames
  # step1 remove chr0X: "awk '$1 == "0X" { next } { print }' "0011.txt" > 0011_1.txt"
  # step2 remove pvalue<0.5: "awk -F" " 'FNR==1 || $8>2' 0011_1.txt > 0011_2.txt"
  efilename <- paste("00", i, "_2.txt", sep="")
  esum = fread(efilename)

  edf = esum %>% select(Chr = chr, Pos = pos, Marker = rsid, p = "pval(-log10)")
  edf = edf %>% drop_na(p)



  # split the graphical window using par()
  par(mfrow=c(2,1))
  par(mar=c(0,4.5,0.5,0.5))
  manhattan(idf, 
            chr="Chr",
            bp="Pos",
            p="p",
            snp="Marker",
            logp = FALSE,
            ylim=c(0,20),
            cex.axis=0.5,
            las=2,
            main = iname,
            col = c("#0E1647", "#7878BA"),
            suggestiveline=FALSE,
            genomewideline=9.687)
  par(mar=c(0,4.5,0.5,0.5))
  manhattan(edf, 
            chr="Chr",
            bp="Pos",
            p="p",
            snp="Marker",
            logp = FALSE,
            ylim=c(15,0),
            cex.axis=0.5,
            las=2,
            col = c("#0E1647", "#7878BA"),
            suggestiveline=FALSE,
            genomewideline=11,
            xlab="",
            xaxt="n")

  dev.copy(tiff, imiami, width = 1000, units = "px")
  dev.off()
}

# annotateTop=TRUE,
# annotatePval=9.687

# annotateTop=TRUE,
# annotatePval=8.86,