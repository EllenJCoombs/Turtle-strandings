


#Ellen's new models 
library(dplyr) #To clean up any dataframe issues 
#install.packages("mgcv") run this when running the code for the first time 
library(mgcv)
library(gratia)

##########################
#                        #
#        Model 1         #
#                        #
##########################

#Read in new data frame (Model1)
#Model 1 runs using turtle count, storm count (Ellen's data), NAO index (Ellen's data) 
#Mean sea surface temperature (UK) (Ellen's data), human population (Ellen's data) 
#The model is constrained to from 1969 to 2014 because of turtle strandings which only run to 2014. 

Model3 <- read.csv('Model3_2014.csv') #With both sets of storm data 
#Model1[4] <- lapply(Model1[4], as.numeric) if there are problems with the dataframe having intergers rather than numeric


#Replace SST with storm_index data - keep human population data and Year as advised by Ellen 

#This is to check how high to make the k value (k-1)
#k (almost always k-1)
unique(Model1$storm_index) #multiple groups 
unique(Model1$storm_count) #7 groups 
unique(Model1$NAO_index) #multiple groups

#GAM for the above with no factor smooth 
#Environmental model: 1960 - 2014 (constrained by yearly turtle strandings) 

library(cars) 
durbinWatsonTest(lm(storm_count ~ mean_sst, data=Model1))


GAM3 <- gam(turtle_count ~ offset(log(human_population)) + s(year, bs="ts") +
              s(storm_count, k=7, bs="ts") +
              s(storm_index_JRA_GB, bs="ts") +
              s(NAO_index, bs="ts") +
              s(mean_sst, bs="ts"),
            data= Model3, 
            method = "REML",
            family=poisson())



#GAM summary and GAM plots 
summary(GAM3)
par(mfrow = c(2,2))
plot(GAM3)
gam.check(GAM3)


#With gratia (nicer plots for publication)

draw(GAM3)
appraise(GAM3)
