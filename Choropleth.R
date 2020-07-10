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

setwd("C:/Users/micha/Google Drive/GitHub/Group7OrientationHackathon")

# Get the data from 
data <- read_csv("data/owid-covid-data.csv", col_names = T)
current_data_df  <- data %>% filter(date == '2020-05-08') 
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
                        , legend.title.txt = ""
                        , colNA = "white"
                        , legend.nodata = "No Data"
                        )
title("Total confirmed COVID-19 cases per million people, June 10, 2020")