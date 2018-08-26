
#Running turtle generlised additive models (GAMs)

library(dplyr)
#install.packages("mgcv") run this when running the code for the first time 
library(mgcv)

#This is to check how high to make the k value (k-1)
#k (almost always k-1)
unique(Turtle_model$UK_mean_SST) #multiple groups 
unique(Turtle_model$Storms) #7 groups 
unique(Turtle_model$NAO_index) #multiple groups


#GAM for the above with Species as the factor smooth 
All_strandc <- gam(Total_strandings ~ offset(log(Population)) +s(Year, Species, bs="fs") +
                     s(Storms, k=5, bs="ts") +
                     s(Max_K_index, k=4, bs="ts") +
                     s(Max_SST, bs="ts") +
                     s(NAO_index, bs="ts"), 
                   data= all_strandings, 
                   method = "REML",
                   family=nb())

#GAM summary and GAM plots 
summary(All_strandc)
par(mfrow = c(2,2))
plot(All_strandc)

#AIC if required 
#AIC(All_strandc)

#Gam.check
par(mfrow=c(2,2))
gam.check(All_strandc)
