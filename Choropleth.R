# Download the shape file from the web and unzip it:
# download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="world_shape_file.zip")
# system("unzip world_shape_file.zip")

# Use the cartography library to do the choropleth map
library(cartography)
library(rgdal)
library(readr)
library(dplyr)
library(broom)

setwd("C:/Users/micha/Google Drive/GitHub/Group7OrientationHackathon")


# Get the data from 
data <- read_csv("data/owid-covid-data.csv", col_names = T)
data$date_date <- as.Date(data$date)
last_load_date <- as.Date('2020-07-10')
current_data_df  <- data %>% filter(date_date == '2020-07-10') 

# Load it as a geospatial object in R
my_spdf <- readOGR( dsn= "./data/spatial" , layer="TM_WORLD_BORDERS_SIMPL-0.3", verbose=FALSE) 
cartography::choroLayer(spdf = my_spdf, spdfid="ISO3" , dfid="iso_code", df=current_data_df, var = "total_cases_per_million")
title("Some title")