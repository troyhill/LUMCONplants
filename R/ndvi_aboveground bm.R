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

##making text larger for figure
exp_vs_coefs <- ggplot(aes(y = exp.live, x = coef.live, colour = seas), data = models) + geom_point(size=3) + theme_classic() + labs(y = "exponent", x = "coefficient") +
  theme(text = element_text(size=14))
# spring = low coefficients, high exponents
##salt figure
napp.salt.lum <- ggplot(napp.nuts[napp.nuts$region %in% "LUMCON", ], aes(x = salinity..psu., y = napp.smalley, colour = site)) + geom_point(size=3) + theme_classic() +  
  labs(y = expression("Smalley NAPP (g "%.%m^-2%.%yr^-1~")"), x = "Creek salinity (psu)") + theme(text = element_text(size=14))  # weak!


##no3 figure
napp.no3.lum <- ggplot(napp.nuts[napp.nuts$region %in% "LUMCON", ], aes(x = dissolved.no3...no2..mm., y = napp.smalley, colour = site)) + geom_point(size=3) + theme_classic() + 
  labs(y = expression("Smalley NAPP (g "%.%m^-2%.%yr^-1~")"), x = "Creekwater NO3 (uM)") + theme(text = element_text(size=14)) # weak


#stem density figure
live.stem<- summarySE(data=LUM, measurevar = "stems", groupvars=c("site", "yr", "mo"))
dead.stem<- summarySE(data=LUM, measurevar = "stems.dead", groupvars=c("site", "yr", "mo"))

ggplot(live.stem, 
       aes(y = stems, x = as.numeric(time))) + #, col = region)) + 
  geom_point(size = 1.2) + geom_errorbar(aes(ymin = (stmDens - stmDens.se), ymax = (stmDens + stmDens.se)), width = 0) +
  geom_line(lwd = 0.7) +
  theme_classic() + theme(legend.title = element_blank()) + 
  ylab(expression("Live stem density (m"^-2~")")) + xlab("") + 
  facet_wrap("group", nrow = 2) + 
  theme_bw() %+replace% theme(strip.background  = element_blank(), legend.title = element_blank())