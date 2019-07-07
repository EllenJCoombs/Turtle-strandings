

#Plots of variables for the supplementary 
#Plots of predictors 

library(ggplot2)

#NAO_index
p <- ggplot(data=Model1, aes(x=year, y=NAO_index, group=1)) +
  geom_line(colour = "gray44") +
  theme_light() + 
  labs(y = "North Atlantic Oscillation index")

#Population plot 
q <- ggplot(data=Model1, aes(x=year, y=human_population, group=1)) +
  geom_line(colour = "gray44") +
  theme_light() + 
  labs(y = "Human population (millions)", x = "Year")

#SST
r <- ggplot(data=Model1, aes(x=year, y=mean_sst, group=1)) +
  geom_line(colour = "gray44") +
  theme_light() + 
  labs(y = "Mean sea surface temperature (°C)", x = "Year")+
  theme_light()

#Storms 
s <- ggplot(data=Model1, aes(x=year, y=storm_count, group=1)) +
  geom_line(colour = "gray44") +
  theme_light() + 
  labs(y = "Storm count", x = "Year") +
  theme_light()


#Putting together for the paper
require(gridExtra)
plot1 <- 
  plot2 <- qplot(1)
grid.arrange(p, q, r, s, ncol=2)
