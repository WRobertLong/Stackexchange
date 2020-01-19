rm(list=ls())

require(lme4)
require(merTools)

m1 <- lmer(y ~ service + lectage + studage + (1|d) + (1|s), data=InstEval)

newdt <- InstEval[1,]

newdt$service <- "1"

predict(m1, newdata = newdt)

predictInterval(m1, 
				  newdata = newdt, 
				  level = 0.95, 
				  n.sims = 1000,
                          stat = "median", 
			        type="linear.prediction",
                          include.resid.var = TRUE
)

bm <- bootMer(m1, FUN=function(x)predict(x, newdt, re.form=NA),nsim=20)
summary(bm)