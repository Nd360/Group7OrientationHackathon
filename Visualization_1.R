library(tidyverse)
setwd("/Users/tylermanderfield/Desktop/Group7OrientationHackathon")
data <- read_csv("./data/total_cases_per_million.csv", col_names=T)
head(data)

colnames(data)
data_test <- data %>% gather(key = "Country", value = "Cases Per Million",colnames(data[,2:ncol(data)]))
data_test


