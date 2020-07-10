# Download the shape file from the web and unzip it:
# download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="world_shape_file.zip")
# system("unzip world_shape_file.zip")

# Use the cartography library to do the choropleth map
library(cartography)
library(rgdal)
library(readr)
library(dplyr)
library(broom)
library(tidyverse)

setwd("/Users/ben_cosgo/bootcamp/Group7OrientationHackathon")

# Get the data from 
data <- read_csv("data/owid-covid-data.csv", col_names = T)
current_data_df  <- data %>% filter(date == '2020-07-10') 
# Load it as a geospatial object in R
my_spdf <- readOGR( dsn= "./data/spatial" , layer="TM_WORLD_BORDERS_SIMPL-0.3", verbose=FALSE) 

colors <- c("papayawhip", "pink", "pink1", "hotpink","maroon1", "maroon2", "maroon3", "maroon4")

cartography::choroLayer(spdf = my_spdf
                        , spdfid="ISO3" 
                        , dfid="iso_code"
                        , df=current_data_df
                        , var = "total_cases_per_million"
                        , legend.pos = "bottom"
                        , breaks=c(0, 5, 10, 50, 100, 500, 1000, 2000, Inf) 
                        , legend.horiz = TRUE
                        , col = colors
                        , legend.title.txt = "Cases per Million"
                        , colNA = "white"
                        , legend.nodata = "No Data"
                        , legend.title.cex = 1.3
                        , legend.values.cex = 1.2
                        , lwd = 0.3
                        )
title("Total confirmed COVID-19 cases per million people, June 10, 2020")
