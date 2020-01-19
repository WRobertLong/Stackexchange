rm(list=ls())

dt <- read.csv("http://www.bodowinter.com/tutorial/politeness_data.csv")

lm0 <- lm(frequency ~ attitude*gender, data=dt)
lm1 <- lm(frequency ~ attitude*gender - gender, data=dt)



summary(lm0)
summary(lm1)

lm3 <- lm(frequency ~ attitude, data=dt)

anova(lm3,lm1)
anova(lm3,lm1, test="LRT")

L1 <- logLik(lm1)
L3 <- logLik(lm3)

pchisq(2*(L3-L1),df=10)



dt1 <- read.dta("http://www.ats.ucla.edu/stat/data/hsbanova.dta")

lm01 <- lm(write~female*grp, data=dt1)
summary(lm01)

lm02 <- lm(write~grp + female:grp, data=dt1)
summary(lm02)



#########################

rm(list=ls())

dt <- read.csv("http://dl.dropbox.com/u/10246536/Web/RTutorialSeries/dataset_anova_twoWay_interactions.csv")

setwd("C://Users/Rob/Downloads")
dt <- read.csv("dataset_anova_twoWay_interactions.csv")


head(dt)

m0 <- lm(StressReduction~Treatment*Gender,data=dt)
summary(m0)

summary(dt$StressReduction)

summary(dt$StressReduction[dt$Gender=="F"])


tapply(dt$StressReduction,list(dt$Gender,dt$Treatment),mean)



dt.1 <- dt[21:60,]

m1 <- lm(StressReduction~Treatment*Gender,data=dt.1)
summary(m1)

tapply(dt.1$StressReduction,list(dt.1$Gender,dt.1$Treatment),mean)

dt.2 <- dt.1
dt.2$Gender <- as.numeric(dt.2$Gender)
dt.2$Gender <- dt.2$Gender-1
