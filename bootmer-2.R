rm(list=ls())

require(lme4)
require(merTools)
set.seed(123)
m1 <- lmer(Reaction ~ Days + (Days|Subject), data=sleepstudy)

newdt <- sleepstudy[20,]
#newdt$Days <- 1
predictInterval(
			m1, 
			newdata = newdt, 
			level = 0.95, 
			n.sims = 1000,
                  stat = "median", 
			type="linear.prediction",
                  include.resid.var = TRUE
)

bm <- bootMer(
		m1, 
		FUN=function(x)predict(x, newdt, re.form=NA),
		nsim=1000,
		use.u=FALSE, 
		type="parametric"
)
quantile(bm$t, probs=c(0.5, .025,0.975), na.rm=TRUE)