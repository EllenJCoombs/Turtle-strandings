
#Packages 
install.packages("dplyr")
library(dplyr)

#Extracting mean sea surface temperature data for UK and Ireland 
#Downloading csv from Ellen's dropbox here - will write actual code for Github 

#Read in data 
#Working directory set 
UK_mean_SST <- read.csv("UK_mean_SST.csv")

#Renaming uk_mean_SST columns 
UK_mean_SST <- UK_mean_SST %>%
  dplyr::rename(Date = time)


#Filter out the columns we want - this is 1960:2015 
#Filtered this way instead of by year (for example) because the dates were messy 
UK_mean_SST <- UK_mean_SST %>% 
  filter(row_number() %in% 1081:1752)

#Change date format of new dataset
sapply(UK_mean_SST, class)
UK_mean_SST <- mutate(UK_mean_SST, Date = dmy(Date))