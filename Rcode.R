#Import OTU tables after removing leading pound sign

raw_OTU_table <- read.table("./OTU_table.txt", sep="\t", row.names=1, header=TRUE)
clean_OTU_table <- read.table("./Clean_OTU_table.txt", sep="\t", row.names=1, header=TRUE)


#check for singleton OTUs

sums <-rowSums(raw_OTU_table)
sorted <- sort(sums)
sorted
sums <- rowSums(clean_OTU_table)
sorted <- sort(sums)



#Calculate number of reads per sample in the 'raw' OTU table
raw_reads_per_sample <- as.data.frame(colSums(raw_OTU_table))

#Calculate number of reads per sample in the 'clean' OTU table
clean_reads_per_sample <-as.data.frame(colSums(clean_OTU_table))

PNAClampResults <- cbind(raw_reads_per_sample,clean_reads_per_sample)

#rename columns
colnames(PNAClampResults) <- c("RawReads","MicrobialReads")

#find the percentage of raw reads that are NOT plant-derived.
PNAClampResults$PercentMicrobialReads <- PNAClampResults$MicrobialReads/PNAClampResults$RawReads*100


write.table(PNAClampResults,"PNAClampResults.csv",sep=',')

library(vegan)
clean_OTU_table.mat<-as.matrix(t(clean_OTU_table))

rarecurve(clean_OTU_table.mat, step = 100,label = FALSE)


