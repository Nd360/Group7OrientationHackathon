# Download the shape file from the web and unzip it:
# download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="world_shape_file.zip")
# system("unzip world_shape_file.zip")

setwd("C:/Users/micha/Google Drive/GitHub/Group7OrientationHackathon")

# Load it as a geospatial object in R
library(rgdal)
my_spdf <- readOGR( dsn= "./data/spatial" , layer="TM_WORLD_BORDERS_SIMPL-0.3", verbose=FALSE) 
africa <- my_spdf[my_spdf@data$REGION==2 , ]

africa@data$POP2005 <- as.numeric(africa@data$POP2005)

# Use the cartography library to do the choropleth map
library(cartography)
choroLayer(spdf = africa, df = africa@data, var = "POP2005")
title("Number of people living in Africa in 2005")