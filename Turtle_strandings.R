
#Reading in turtle strandings data 
#1960-2014

Turtle_strandings <- read.csv("Turtle_strandings.csv")

#Double check that it's 1960 - 2014 

#=============================================================================================
#Storm data 
#Read from "Modelling" folder 
library(dplyr)
storms <- read.csv("Storm_data.csv")

#This code adds 0s where no storms were counted for that year 
#Select data 
storms <- storms %>% 
  select(Year, Count)

#Cut data down: 1960 - 2014
storms <- storms %>% 
  filter(row_number() %in% 60:166)

#Counting up the storms per year 
storms <- storms %>% 
  dplyr::group_by(Year) %>% 
  dplyr::summarise(count = sum(Count))


storms[is.na(storms)] <- 0

#Renaming count to storms 
#New data frame called "Storms" for the model 
Storms <- storms %>%
  rename(Storms = count)

#Save cleaned storms data 
#write.csv(Storms, file = "Storm_data.csv")

#=================================================================================================
#Human population data 
#Read in UK population data 

#Population data UK
#Also in the "modelling' folder 
#This is a data file that is combined with yearly strandings 

Population <- read.csv("Population_UK.csv")
Population <- Population %>%
  rename(Year = YEAR) %>%
  rename(Population = POPULATION)

#Filter out turtle dates 

Population <- Population %>% 
  filter(row_number() %in% 48:102)

#Save data for pulling into final correlates dataset 
#write.csv(Population, file = Population)

#===============================================================================================
#NAO data 

NAO_data <- read.csv("NAO_data.csv")
NAO_data$X <- NULL

#Rename the columns if required 
#NAO_data <- NAO_data %>%
#dplyr::rename(NAO_index = n)

#Cut down to turtle dates 
Population <- Population %>% 
  filter(row_number() %in% 48:102)


