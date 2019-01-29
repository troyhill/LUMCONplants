LUM<-subset(bioDat, region=="LUMCON")
LUM1718<-subset(LUM, yr > 2016)
library(Rmisc)
library(tidyverse)
library(lattice)
library(nlme)
library(lubridate)
library(svglite)

mean.mass<-summarySE(data=LUM1718, measurevar="mass", groupvars= c("site", "yr", "mo"))

ndvi<-read_csv("ndvi_lum.csv")

mydata<-merge(ndvi, mean.mass, by=c("site","yr","mo"))

plot(avg.ndvi~mass, data=mydata)

rsqr.ndvi<- round(summary(lm(mass ~ avg.ndvi, data = mydata))$r.squared, 2)

mass.ndvi <- ggplot(mydata, aes(x = mass, y = avg.ndvi)) + geom_point(aes(colour = site)) + theme_classic() + 
  geom_smooth(method = "lm") + labs(y = ("NDVI"), x = expression("Aboveground biomass (g "%.%m^-2*")")) # all data - looks nice
mass.ndvi
#rsq is 0.33   

