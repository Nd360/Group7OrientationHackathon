library(tidyverse)
setwd("/Users/tylermanderfield/Desktop/Group7OrientationHackathon")
data <- read_csv("./data/total_cases_per_million.csv", col_names=T)

data_test <- data %>% gather(key = "Country", value = "Cases Per Million",colnames(data[,2:ncol(data)]))
data_test

Subset_Data <- data_test %>% filter(Country %in% c("United States", "China","United Kingdom","World","South Korea"))

Subset_Data <- Subset_Data %>% filter(date >= "2020-01-22")
Subset_Data %>% filter(Country == "United Kingdom")
Subset_Data[(Subset_Data[,'Country'] == "United Kingdom") & (Subset_Data['Cases Per Million'] == 0) , "Cases Per Million"] <-  NA
library(ggplot2)
library(gganimate)
# install.packages("gganimate")
# install.packages("gifski")
library(gifski)
library(ggthemes)
# install.packages("directlabels")
library(directlabels)
last_day <- Subset_Data %>% filter(date == "2020-07-10")

a <- ggplot(data=Subset_Data) + geom_line(aes(x=date,y=`Cases Per Million`, color=Country)) + geom_text(data =  last_day, aes(label = Country, x = as.Date("2020-07-05"), y = `Cases Per Million`, color = Country), hjust=0.5, vjust=-0.5) + guides(color = FALSE) + scale_y_log10() + labs(title = "Total Confirmed COVID-19 Cases per Million People", x="Date") + transition_reveal(date)
animate( a,  end_pause = 45, height = 400, width =600)
anim_save("COVID-Cases.gif")



