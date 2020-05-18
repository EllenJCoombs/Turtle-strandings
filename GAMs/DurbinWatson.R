

#Durbin Watson test for autocorrelation 
library(lmtest)

#The Durbin Watson test reports a test statistic, with a value from 0 to 4, where:
  
#2 is no autocorrelation.
#0 to <2 is positive autocorrelation (common in time series data).
#>2 to 4 is negative autocorrelation (less common in time series data).
#A rule of thumb is that test statistic values in the range of 1.5 to 2.5 are relatively normal. 
#Values outside of this range could be cause for concern. Field(2009) suggests that values under 1 or more than 3 are a definite cause for concern.

#An example looking at two residuals 
#e.g. dwtest(torm_index_JRA_GB ~ mean_sst data = Model2)

dwtest(mean_sst ~ NAO_index, data = Model1)


## generate two AR(1) error terms with parameter
## rho = 0 (white noise) and rho = 0.9 respectively
err1 <- rnorm(100)

## generate regressor and dependent variable
x <- rep(c(-1,1), 50)
y1 <- 1 + x + err1

## perform Durbin-Watson test
dwtest(y1 ~ x)

err2 <- filter(err1, 0.9, method="recursive")
y2 <- 1 + x + err2
dwtest(y2 ~ x)
