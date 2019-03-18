library("ggplot2")
library("tidyverse")
library("dplyr")
library("cowplot")

data<- read.csv ("landing_app/data/data.csv", header=T)

data_apalach <- data %>% 
  filter (area== "Apalach Landings" | area=="Apalach Trips" | area=="Apalach Per Trips")

#ggplot(data= data_apalach, aes( x= Year, y=measurement)) +
 # geom_line () +
  ##ylab("Measurement") +
  #theme_bw() +
  #facet_wrap(~area, ncol=1, scales = "free")


pertrip_plot<- data_apalach  %>% 
  filter (area=="Apalach Per Trips") %>% 
ggplot( aes( x= Year, y=measurement)) +
  geom_line () +
  ylab("Catch/Trip") +
  theme_bw() 

trip_plot <- data_apalach %>% 
  filter (area=="Apalach Trips") %>% 
ggplot(aes( x= Year, y=measurement)) +
  geom_line () +
  ylab("Effort (Trips)") +
  theme_bw() 


land_plots <- data_apalach %>% 
  filter (area== "Apalach Landings") %>% 
ggplot(aes( x= Year, y=measurement)) +
  geom_line () +
  ylab("Landings (lbs)") +
  theme_bw() 
  
plot_grid(land_plots, trip_plot, pertrip_plot, ncol=1 )
  