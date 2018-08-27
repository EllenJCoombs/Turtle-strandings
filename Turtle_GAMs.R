
#Running turtle generlised additive models (GAMs)

library(dplyr)
#install.packages("mgcv") run this when running the code for the first time 
library(mgcv)

#This is to check how high to make the k value (k-1)
#k (almost always k-1)
unique(Turtle_model$UK_mean_SST) #multiple groups 
unique(Turtle_model$Storms) #7 groups 
unique(Turtle_model$NAO_index) #multiple groups
uni

#GAM for the above with Species as the factor smooth 
Turtles_a <- gam(Total_strandings ~ offset(log(Population)) +s(Year, bs = "ts") +
                     s(Storms, k=7, bs="ts") +
                     s(UK_mean_SST, bs="ts") +
                     s(NAO_index, bs="ts"), 
                   data= Turtle_model, 
                   method = "REML",
                   family=tw(a=1.2))

#GAM summary and GAM plots 
summary(Turtles_a)
par(mfrow = c(2,2))
plot(Turtles_a)

#AIC if required 
#AIC(All_strandc)

#Gam.check
par(mfrow=c(2,2))
gam.check(Turtles_a)
