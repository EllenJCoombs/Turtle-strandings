#Simulation GAMs 

#Here: 
#Strandings, population, GS_transport, NAC_transport- all 1960 -  2009 
#Need to look at simulated arrivals, mortality etc 


#Running turtle generlised additive models (GAMs)

library(dplyr)
#install.packages("mgcv") run this when running the code for the first time 
library(mgcv)

#This is to check how high to make the k value (k-1)
#k (almost always k-1) i.e., does k need to be manually set to 7 or 5 (if it around this number)
unique(simulation_model$GS_transport) #multiple groups 
unique(simulation_model$NAC_transport) #multiple groups

#GAM for the above with Species as the factor smooth 
Turtles_b <- gam(Total_strandings ~ offset(log(Population)) +s(Year, bs = "ts") +
                   s(GS_transport, bs="ts") +
                   s(NAC_transport, bs="ts"),
                 data= simulation_model, 
                 method = "REML",
                 family=poisson())


#GAM summary and GAM plots 
summary(Turtles_b)
par(mfrow = c(2,2))
plot(Turtles_b)

#AIC if required 
#AIC(All_strandc)

#Gam.check
par(mfrow=c(2,2))
gam.check(Turtles_b)






