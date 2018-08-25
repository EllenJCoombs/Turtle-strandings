
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


storms <- storms %>%
  complete(Year, fill = list(Count = 0))


#Renaming count to storms 
Storms <- storms %>%
  rename(Storms = count)

#Save cleaned storms data 
write.csv(Storms, file = "Storm_data.csv")


