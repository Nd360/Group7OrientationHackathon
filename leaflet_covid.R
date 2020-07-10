library(leaflet)
library(tidyverse)
library(tigris)
library( geojsonio )
library(rgdal)
library(broom)


setwd("C:/Users/micha/Google Drive/GitHub/Group7OrientationHackathon")

shp <- readOGR(dsn="data/spatial", layer="country_polygons", stringsAsFactors = FALSE)
shp.df <- tidy(shp, region = "iso_a3")

data <- read_csv("data/owid-covid-data.csv")

# Filter on current date
last_load_date <- Sys.Date()
current_data  <- data %>% filter(date == last_load_date) 


# Join the spatial data with the table data
# mynewspdf <- left_join(shp.df, current_data, by = c("id"="iso_code"))

mynewspdf <- tigris::geo_join(shp, current_data, "iso_a3", "iso_code")


# Attribute we are examining
# total_cases_per_million



# Leaflet stuff below here

# figure out new bins....
bins <- c(0, 5, 10, 50, 100, 500, 1000, 2000, Inf)
pal <- colorBin("PuRd", domain = mynewspdf$total_cases_per_million, bins = bins)

colors <- c("papayawhip", "pink", "pink1", "hotpink","maroon1", "maroon2", "maroon3", "maroon4")


# labels <- sprintf(
#   mynewspdf$iso_a3, mynewspdf$total_cases_per_million
# ) %>% lapply(htmltools::HTML)


labels <- sprintf(
  "<strong>%s</strong><br/>%g per million people",
  mynewspdf$iso_a3, mynewspdf$total_cases_per_million
) %>% lapply(htmltools::HTML)


leaflet(mynewspdf) %>%
  setView(-96, 37.8, 4) %>%
  addProviderTiles("MapBox", options = providerTileOptions(
    id = "mapbox.light",
    accessToken = Sys.getenv('MAPBOX_ACCESS_TOKEN'))) %>%
  addPolygons(
    fillColor = ~pal(total_cases_per_million),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = labels,
    labelOptions = labelOptions(
      style = list("font-weight" = "normal", padding = "3px 8px"),
      textsize = "15px",
      direction = "auto")) %>%
  addLegend(pal = pal, values = ~total_cases_per_million, opacity = 0.7, title = NULL,
            position = "bottomright")