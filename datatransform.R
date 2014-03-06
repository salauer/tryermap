data = read.csv("C:/users/konsta/desktop/vaestokoe/kuntainvaki.csv", header = TRUE, stringsAsFactors = FALSE, sep=",")

library(foreign)

alat = read.dbf("C:/users/konsta/desktop/vaestokoe/Kunnat2013eimerta.dbf")
str(alat)
alat$text = as.character(alat$text)
alat$text = substring(sapply(strsplit(alat$text,","),"[",1),4)
alat = alat[order(alat$text),]


colnames(data) = c("kunta", seq(1980,2012,1))

data$kunta = substring(sapply(strsplit(data$kunta,","),"[",1),4)

library(stringr)

data$kunta = str_replace_all(data$kunta, "Ã¤", "ä")
data$kunta = str_replace_all(data$kunta, "Ã„", "Ä")
data$kunta = str_replace_all(data$kunta, "Ã¶", "ö")
data$kunta = str_replace_all(data$kunta, "Ã¥", "å")

tiheydet =data[,-1]/alat$ala
str(tiheydet)

data[,-1] = tiheydet

str(data)
library(reshape2)

rdat = melt(data, id.vars="kunta", variable.name="vuosi", value.name="tiheys")
rdat$vuosi = as.numeric(as.character(rdat$vuosi))
str(rdat)


