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



