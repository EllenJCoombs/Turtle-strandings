
#Packages 
library(dplyr)
library(lubridate)

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
sapply(UK_mean_SST, class) #what class are the variables 
UK_mean_SST <- mutate(UK_mean_SST, Date = dmy(Date))


#Splitting SST into day, month, year 
#This code is for breaking down into day, month, year 
df <- data.frame(date = UK_mean_SST$Date,
                 year = as.numeric(format(UK_mean_SST$Date, format = "%Y")),
                 month = as.numeric(format(UK_mean_SST$Date, format = "%m")),
                 day = as.numeric(format(UK_mean_SST$Date, format = "%d")))


#Binding SST and dates/months/years and removing the extra 'date' 
SST_day_month_year <- bind_cols(df, UK_mean_SST) 
SST_day_month_year$Date <- NULL

#Average SST for each of the months from 1960 - 2014
aggregate(SST_day_month_year$UK_mean, by = list(SST_day_month_year$year), mean)
SST_yearly_mean <- aggregate(UK_mean ~ year, data = SST_day_month_year, mean)

#Save this as sea turtle data (1960-2015)
