require(lme4)
data("VerbAgg")
head(VerbAgg)

reshape(VerbAgg)

head(sleepstudy)

hdp <- read.csv("http://www.ats.ucla.edu/stat/data/hdp.csv")

head(hdp)
str(hdp)

m0 <- glmer(FamilyHx ~ Sex + (1|School), data = hdp, family = binomial)
summary(m0)

m1 <- glmer(remission ~ IL6 + CRP + CancerStage + LengthofStay + Experience +
    (1 | DID), data = hdp, family = binomial, control = glmerControl(optimizer = "bobyqa"),
    nAGQ = 10)

m2 <- glmer(remission ~ FamilyHx +
    (1 | DID), data = hdp, family = binomial)
summary(m2)

dt <- hdp[,c(8,12,22)]

m3 <- glmer(remission ~ FamilyHx +
    (1 | DID), data = dt, family = binomial)
summary(m3)

head(dt)

dt_w <- reshape(dt, 
  timevar = "remission",
  idvar = "DID",
  direction = "wide")

require(reshape2)
dcast()

