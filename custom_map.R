# library(rMaps)
# setwd("C:/users/konsta/desktop/tryermap")

maps = Datamaps$new()

maps$set(
geographyConfig = list(
dataUrl="http://raw.github.com/Koalha/tryermap/master/kunnat2.topojson"
),

   scope = "Kunnatwgs",
setProjection = '#! function( element, options ) {
   var projection, path;
   projection = d3.geo.transverseMercator()
    .rotate([-27,-65,0])
    .scale(2000)
    .translate([element.offsetWidth / 2, element.offsetHeight / 2]);

   path = d3.geo.path().projection( projection );
   return {path: path, projection: projection};
  } !#'
)


maps