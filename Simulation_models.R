#Simualtion models 

#================================================================================================
#GS transport data 

######## THIS IS TO 2009 (others are currently to 2014)

GS_transport <- read.csv("GS_transport.csv")
#Cut down to turtle dates 
GS_transport <- GS_transport %>% 
  filter(row_number() %in% 12:61)


#================================================================================================
#NAC transport data 

######## THIS IS TO 2009 (others are currently to 2014)
NAC_transport <- read.csv("NAC_transport.csv")
#Cut down to turtle dates 
NAC_transport <- NAC_transport %>% 
  filter(row_number() %in% 12:61)


#================================================================================================
#Mortality data 

#The extent of these data is 2007 
Mortality <- read.csv('mortality.csv')
Mortality <- Mortality %>%
  filter(row_number() %in% 13:60)

#=================================================================================================
#Turtle stranding 2009 

Turtle_strandings_2009 <- Turtle_strandings %>%
  filter(row_number() %in% 1:50)

#=================================================================================================
#Population 2009 

Population_2009 <- Population %>%
  filter(row_number() %in% 1:50)

#=================================================================================================
#Bind all the data together for modelling 
#install.packages("tidyr") - run this when running the code for the first time 
install.packages("tidyr")
library(tidyr)

#Ensure all correlates are read in using the above script 
simulation_model <- bind_cols(Turtle_strandings_2009, Population_2009, GS_transport, NAC_transport)

#Remove uneeded columns 
simulation_model$Year1<- NULL
simulation_model$Year2 <- NULL 
simulation_model$Year <- NULL

#Change the name of the SST variable, year and strandings count
simulation_model <- simulation_model %>%
  rename("Year" = YEAR) %>%
  rename("Total_strandings" = "Count")