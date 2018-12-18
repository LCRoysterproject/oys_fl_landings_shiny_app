# Landings data processing script

library("dplyr")

landings <- read.csv("landing_app/data/landings.csv", header= T)

#State Data modification
state_land <- subset(landings, select= c(Year,State_landings))
state_land$area <- (state_land$area= "State Landings")
state_land$measurement<- paste(landings$State_landings)

statel<- state_land %>% select(Year, area, measurement)

state_trips <- subset(landings, select= c(Year,State_trips))
state_trips$area <- (state_trips$area= "State Trips")
state_trips$measurement<- paste(landings$State_trips)

statet<- state_trips %>% select(Year, area, measurement)


state_ptrips <- subset(landings, select= c(Year,State_per_trip))
state_ptrips$area <- (state_ptrips$area= "State Per Trips")
state_ptrips$measurement<- paste(landings$State_per_trip)

statept<- state_ptrips %>% select(Year, area, measurement)


apalach_land <- subset(landings, select= c(Year,Apalach_landings))
apalach_land$area <- (apalach_land$area= "Apalach Landings")
apalach_land$measurement<- paste(landings$Apalach_landings)

apalachl<- apalach_land %>% select(Year, area, measurement)


apalach_trips <- subset(landings, select= c(Year,Apalach_trips))
apalach_trips$area <- (apalach_trips$area= "Apalach Trips")
apalach_trips$measurement<- paste(landings$Apalach_trips)

apalacht<- apalach_trips %>% select(Year, area, measurement)


apalach_ptrips <- subset(landings, select= c(Year,Apalach_per_trip))
apalach_ptrips$area <- (apalach_ptrips$area= "Apalach Per Trips")
apalach_ptrips$measurement<- paste(landings$Apalach_per_trip)

apalachpt<- apalach_ptrips %>% select(Year, area, measurement)

suw_land <- subset(landings, select= c(Year,Suw_landings))
suw_land$area <- (suw_land$area= "Suwannee Landings")
suw_land$measurement<- paste(landings$Suw_landings)

suwl<- suw_land %>% select(Year, area, measurement)

suw_trips <- subset(landings, select= c(Year,Suw_trips))
suw_trips$area <- (suw_trips$area= "Suwannee Trips")
suw_trips$measurement<- paste(landings$Suw_trips)

suwt<- suw_trips %>% select(Year, area, measurement)


suw_ptrips <- subset(landings, select= c(Year,Suw_per_trip))
suw_ptrips$area <- (suw_ptrips$area= "Suwannee per Trips")
suw_ptrips$measurement<- paste(landings$Suw_per_trip)

suwpt<- suw_ptrips %>% select(Year, area, measurement)


#state<- left_join(state_land, state_trips, by= c("Year", "area", "measurement"))
#apalach<- full_join(apalach_land, apalach_trips, by= c("Year", "area", "measurement"))
#suw<- full_join(suw_land, suw_trips, by= c("Year", "area", "measurement"))
#ptrip_sa<- full_join (apalach_ptrips, suw_ptrips,by= c("Year", "area", "measurement"))
#<- full_join(state, apalach, by= c("Year", "area", "measurement"))
#data<- full_join(data, state_ptrips,  by= c("Year", "area", "measurement"))
#data<- data %>% select(Year, area, measurement)

data<- rbind (statel,statet, statept,apalachl,apalacht,apalachpt,suwl, suwt, suwpt)

state_data<- rbind(statel,statet, statept)
apalach_data<-rbind(apalachl,apalacht,apalachpt)
suw_data<-rbind(suwl, suwt, suwpt)

write.csv(state_data, file = "landing_app/data/state.csv")
write.csv(apalach_data, file = "landing_app/data/apalach.csv")
write.csv(suw_data, file = "landing_app/data/suw.csv")
write.csv(data, file = "landing_app/data/data.csv")
