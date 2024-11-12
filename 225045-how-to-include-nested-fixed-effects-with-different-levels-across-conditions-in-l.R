setwd("D:\\Documents\\Stackexchange")
rm(list=ls())
dt <- read.table("225045.dat",header=TRUE)

require(lme4)

m0 <- lmer(activity ~ condition*roi + roi:subroi + (1|roi:subroi) + (1|subject), data=dt)
summary(m0)

m1 <- lmer(activity ~ condition*roi +  subroi + (1|subject), data=dt)
summary(m1)

m0 <- lmer(activity ~ condition*roi + (1|subject), data=dt)
summary(m0)

m1 <- lmer(activity ~ condition*subroi + (1|subject), data=dt)
summary(m1)

lm1 <- lm(activity ~ condition*subroi, data=dt)

dt <- rbind(dt,dt)

dt$subject <- c("s1","s1","s2","s2","s2","s2","s3","s3","s4","s4","s5","s5","s5","s5","s6","s6")

dt <- rbind(dt,dt)

dt$subject <- c(c("s1","s1","s2","s2","s2","s2","s3","s3","s4","s4","s5","s5","s5","s5","s6","s6"),
	c("s7","s7","s8","s8","s8","s8","s9","s9","s10","s10","s11","s11","s12","s12","s13","s13"))


m0.99 <- lm(activity ~ condition*roi + roi:subroi, data=dt)
summary(m0.99)

m0 <- lmer(activity ~ roi:subroi + (1|subject), data=dt)
summary(m0)

m1 <- lmer(activity ~ condition*subroi + (1|subject), data=dt)
summary(m1)

lm1 <- lm(activity ~ condition*subroi + subject, data=dt)
summary(lm1)



# from 
# https://biologyforfun.wordpress.com/2014/04/08/interpreting-interaction-coefficient-in-r-part1-lm/


# interpreting interaction coefficients from lm first case two categorical
# variables

set.seed(12)
f1 <- gl(n = 2, k = 30, labels = c("Low", "High"))
f2 <- as.factor(rep(c("A", "B", "C"), times = 20))
modmat <- model.matrix(~f1 * f2, data.frame(f1 = f1, f2 = f2))
coeff <- c(1, 3, -2, -4, 1, -1.2)
y <- rnorm(n = 60, mean = modmat %*% coeff, sd = 0.01)
dat <- data.frame(y = y, f1 = f1, f2 = f2)
summary(lm(y ~ f1 * f2,data=dat))

dat1 <- dat[dat$f1=="Low",]

summary(lm(y ~ f1*f2,data=dat1))


