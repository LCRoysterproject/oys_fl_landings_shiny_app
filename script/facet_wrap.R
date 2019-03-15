library("ggplot2")
library("tidyverse")
library("dplyr")

data<- read.csv ("landing_app/data/data.csv", header=T)

data_apalach <- data %>% 
  filter (area== c("Apalach Landings", "Apalach Trips", "Apalach Per Trips"))

ggplot(data= data_apalach, aes( x= Year, y=measurement)) +
  geom_line () +
  ylab("Measurement") +
  theme_bw() +
  facet_wrap(~area, ncol=1, scales = "free")
