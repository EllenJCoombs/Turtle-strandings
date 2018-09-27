#Extra models with 2007 data 
#1961 - 2007 
#mortality and simulated arrivals 

Mortality_2007 <- Mortality %>%
    filter(row_number() %in% 2:48)

#Simulations
simulated_arrivals_2007 <- simulated_arrivals %>%
  filter(row_number() %in% 1:47)

#population 2007 
population_2007 <- Population %>%
  filter(row_number() %in% 2:48)

#strandings 2007 
strandings_2007 <- Turtle_strandings %>%
  filter(row_number() %in% 2:48)

#==================================================================================================

#Bind all the data together for modelling 
#install.packages("tidyr") - run this when running the code for the first time 
#install.packages("tidyr")
library(tidyr)

#Ensure all correlates are read in using the above script 
mortality_model <- bind_cols(strandings_2007, population_2007, simulated_arrivals_2007,
                             Mortality_2007)

#Remove uneeded columns 
mortality_model$Year <- NULL
mortality_model$Year1 <- NULL 
mortality_model$year <- NULL

#Change the name of the SST variable, year and strandings count
mortality_model <- mortality_model %>%
  rename("Year" = YEAR) %>%
  rename("Total_strandings" = "Count")


#=================================================================================================
#Running turtle generlised additive models (GAMs)

library(dplyr)
#install.packages("mgcv") run this when running the code for the first time 
library(mgcv)

#This is to check how high to make the k value (k-1)
#k (almost always k-1)
unique(mortality_model$Simulated_arrivals) #multiple groups 
unique(mortality_model$mortality) #multiple levels 

Turtles_c <- gam(Total_strandings ~ offset(log(Population)) +s(Year, bs = "ts") +
                   s(Simulated_arrivals, bs="ts") +
                   s(mortality, bs="ts"),
                 data= mortality_model, 
                 method = "REML",
                 family=(nb))

#GAM summary and GAM plots 
summary(Turtles_c)
par(mfrow = c(2,2))
plot(Turtles_c)

#AIC if required 
#AIC(All_strandc)

#Gam.check
par(mfrow=c(2,2))
gam.check(Turtles_c)







