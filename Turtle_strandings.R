
#Reading in turtle strandings data 
#1960-2014

Turtle_strandings <- read.csv("Turtle_strandings.csv")

#Double check that it's 1960 - 2014 

#=============================================================================================
#Storm data 
#Read from "Modelling" folder 
#install.packages("dplyr") - run this when you're running the code for the first time 
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
NAO_data <- NAO_data %>% 
  filter(row_number() %in% 48:102)


#===============================================================================================
#Bind all the data together for modelling 
#install.packages("tidyr") - run this when running the code for the first time 
library(tidyr)

#Ensure all correlates are read in using the above script 
Turtle_model <- bind_cols(Population, Storms, SST_yearly_mean, NAO_data)


#Remove uneeded columns 
Turtle_model$Year1<- NULL
Turtle_model$year <- NULL 
Turtle_model$X <- NULL 
Turtle_model$Year2 <- NULL 

#Change the name of the SST variable
Turtle_model <- Turtle_model %>%
  rename("UK_mean_SST" = UK_mean)



#join the two datasets
all_strandings <- full_join(all_strandings, Model_data, by = "Year")
all_strandings$X <- NULL

#Dataset should now have all above correlates + Species + turtle strandings 


#




