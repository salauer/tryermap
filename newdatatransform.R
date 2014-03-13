setwd("C:/users/konsta/desktop/tryermap")
options(stringsAsFactors=FALSE)

data = read.csv("kuntainvaki.csv", header = TRUE, stringsAsFactors = FALSE, sep=",")
colnames(data) = c("name", seq(1980,2012,1))
str(data)

###

library(foreign)

alat = read.dbf("Kunnatwgs.dbf")
alat$nimet_Kunt = as.character(alat$nimet_Kunt)
alat = alat[order(alat$text),]

###
data.frame(data$name,alat$nimet_Kunt)
data$name = alat$nimet_Kunt

###
#pinta = read.csv("K:/git/tryermap/050_vaerak_tau_104.csv",sep="\t",skip=3);pinta
#str(pinta)
#str(pinta[-1,-1])
#pinta = pinta[-1,-1]
#pinta = pinta[1:320,]
#colnames(pinta) = c("name",seq(1980,2012,1))
#
###

alat = read.csv("alat13.txt",sep="\t")
str(alat)
alat = alat[1:320,c(2,4)]
colnames(alat) = c("name","ala")
str(alat)
###

data.frame(alat$name,data$name)
tiheydet = data[,-1]/alat$ala
data2 = data
data2[,-1] = tiheydet
str(data2)

###

library(reshape2)

rdat = melt(data2, id.vars="name", variable.name="vuosi", value.name="tiheys")
rdat$vuosi = as.numeric(as.character(rdat$vuosi))
str(rdat)

###

library(rMaps)

options(RCHART_WIDTH = 900, RCHART_HEIGHT = 700)

maps = ichoropleth(tiheys~name, data = rdat, ncuts = 9, animate ='vuosi', map='Kunnatwgs')
maps$set(
geographyConfig = list(
dataUrl="https://dl.dropboxusercontent.com/u/36138080/suomnimikunnat.topojson"
),

   scope = "Kunnatwgs",
setProjection = '#! function( element, options ) {
   var projection, path;
   projection = d3.geo.transverseMercator()
    .rotate([-27,-65,0])
    .scale(4000)
    .translate([element.offsetWidth / 2, element.offsetHeight / 2]);

   path = d3.geo.path().projection( projection );
   return {path: path, projection: projection};
  } !#'
)


maps