library(tidyverse)
setwd("/Users/tylermanderfield/Desktop/Group7OrientationHackathon")
data <- read_csv("./data/total_cases_per_million.csv", col_names=T)

data_test <- data %>% gather(key = "Country", value = "Cases Per Million",colnames(data[,2:ncol(data)]))
data_test

Subset_Data <- data_test %>% filter(Country %in% c("United States", "China","United Kingdom","World","South Korea"))

library(ggplot2)
ggplot(data=Subset_Data) + geom_line(aes(x=date,y=`Cases Per Million`, color=Country)) + scale_y_log10()



