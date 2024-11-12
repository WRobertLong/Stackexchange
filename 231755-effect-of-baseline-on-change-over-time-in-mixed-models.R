require(lme4)  # load packages
require(ggplot2)

rm(list=ls())


### logistic model
##= y = a / (1 + b*exp(-k*x)) , k>0
# asymptote y=a to right (100)
# intercept at a/(1+b) ( 50)
# so a=100
# therefore intercept at 25 when b=3, at 50 when b=1 and at 75 when b=0.333


#simulate some data k <- 1

#k <- 1

#Y <- a / (1 + (b*exp(-k*X)))
#plot(X,Y)
#pi <- Y/a
#curve(1/(1+exp(-(-1 + 1*x))), from=0, to=5)


#logitpi <- log(pi/(1-pi))
#plot(X,logitpi) # intercept 0 (b=1) -1.1 (b=3)  for b=1.33, 
#summary(lm(logitpi~X))

Nperson <- 10
obsperperson <-6

X <- c(0,1,2,3,4,5)

Y <- ID <- occasion <- numeric(Nperson*obsperperson)

# simulation on logitpi scale
# only need to vary intercepts between -1 and 1
intercepts <- c(-0.85,-.55, -0.25, -0.11, 0.05, 0.12, 0.18, 0.32, 0.64, 1.1) 

a=100

set.seed(2)

for (i in 1:Nperson) {

  Y[(1+((i-1)*obsperperson)):(i*obsperperson)] <- rep(intercepts[i],obsperperson) + 1.1*X + rnorm(obsperperson,0,0.25)
  occasion[(1+((i-1)*obsperperson)):(i*obsperperson)] <- X
  ID[(1+((i-1)*obsperperson)):(i*obsperperson)] <- rep(i,obsperperson)

}

dt <- data.frame(Y,occasion,ID)

dt$ID <- as.factor(dt$ID)

m0 <- lmer(Y~occasion+(1|ID),data=dt)
summary(m0)

ggplot(dt,aes(x=occasion,y=Y, color=ID)) + geom_line()

# backtransform
dt$Y_pi <- exp(Y)/(1+exp(Y))
dt$score <- dt$Y_pi*a

ggplot(dt,aes(x=occasion,y=score, color=ID)) + geom_line() + geom_point()

require(nlme)

m99 <- lme(Y~occasion, random=~1|ID, data=dt, corr = corAR1(,form= ~ 1 | ID))
summary(m99)

m88 <- lmer(score~occasion+(1|ID),data=dt)
summary(m88)

m87 <- lmer(score~occasion + I(occasion^2) + (1|ID),data=dt)
summary(m87)

m86 <- lmer(score~occasion + I(occasion^2) + I(occasion^3) + (1|ID),data=dt)
summary(m86)

(p2 <- ggplot(dt,aes(x=occasion,y=score, color=ID)) + geom_line()) + geom_point()

(p2 <- p2 + stat_function(fun=function(x)64.6+8.5*x, geom="line", size=1, colour="black", linetype="dashed"))

(p2 <- p2 + stat_function(fun=function(x)56+21.5*x-2.6*x^2, geom="line", size=1, colour="black", linetype="dashed"))

(p2 <- p2 + stat_function(fun=function(x)55.1+25.5*x-4.8*x^2+0.3*x^3, geom="line", size=1, colour="dodgerblue3", linetype="dashed"))

(p2 <- p2 + stat_function(fun=function(x) 100*exp(0.3 + 1.1*x)/(1+exp(0.3 + 1.1*x)), geom="line", size=1, colour="dodgerblue3", linetype="dashed"))


# toy example
# 5 data points
#6 groups

dt1 <- dt[as.numeric(dt$ID) > 4,]
dt1 <- dt1[dt1$occasion<5,]
dt1$ID <- droplevels(dt1$ID)

dt1$score <- round(dt1$score,0)-0.5




m88.1 <- lmer(score~occasion+(1|ID),data=dt1)
summary(m88.1)

m87.1 <- lmer(score~occasion + I(occasion^2) + (1|ID),data=dt1)
summary(m87.1)

m86.1 <- lmer(score~occasion + I(occasion^2) + I(occasion^3) + (1|ID),data=dt1)
summary(m86.1)


(p2 <- ggplot(dt1,aes(x=occasion,y=score, color=ID)) + geom_line()) + geom_point()

(p2 <- p2 + stat_function(fun=function(x)57.1+10.2*x, geom="line", size=1, colour="black", linetype="dashed"))

(p2 <- p2 + stat_function(fun=function(x)47.7+24.7*x-2.9*x^2, geom="line", size=1, colour="black", linetype="dashed"))

(p2 <- p2 + stat_function(fun=function(x)47.3+25.8*x-3.5*x^2+0.0*x^3, geom="line", size=1, colour="dodgerblue3", linetype="dashed"))

#re-transform

pi <- dt1$score/100

dt1$logitpi <- log(pi/(1-pi))

m0 <- lmer(logitpi~occasion+(1|ID),data=dt1)
summary(m0)

(p2 <- p2 + stat_function(fun=function(x) 100*exp(-0.1 + 1.1*x)/(1+exp(-0.1 + 1.1*x)), geom="line", size=1, colour="green", linetype="dashed"))

#centre occasion
dt2 <- dt1
dt2 <- dt2[,c("occasion","score","ID")]

### this is the final toy dataset

m1 <- lmer(score~occasion+(1|ID),data=dt2)
summary(m1)

(p2 <- ggplot(dt2,aes(x=occasion,y=score, color=ID)) + geom_line()) + geom_point()

(p2 <- p2 + stat_function(fun=function(x)fixef(m1)[1] + fixef(m1)[2]*x, geom="line", size=1, colour="black", linetype="dashed"))


# centre occasion
dt2$occasion <- dt2$occasion - mean(dt2$occasion)


m1.1 <- lmer(score~occasion+(1|ID),data=dt2)
summary(m1.1)
fun1 <- function(x) fixef(m1.1)[1] + fixef(m1.1)[2]*x

m2 <- lmer(score~occasion + I(occasion^2) + (1|ID),data=dt2)
summary(m2)
fun2 <- function(x) fixef(m2)[1] + fixef(m2)[2]*x + fixef(m2)[3]*(x^2)

m3 <- lmer(score~occasion + I(occasion^2) + I(occasion^3) + (1|ID),data=dt2)
summary(m3) 
fun3 <- function(x) fixef(m2)[1] + fixef(m3)[2]*x + fixef(m3)[3]*(x^2) + fixef(m3)[4]*(x^3)


(p2 <- ggplot(dt2,aes(x=occasion,y=score, color=ID)) + geom_line(size=0.8)) + geom_point()

(p2 <- p2 + stat_function(fun=fun1, geom="line", size=1, colour="grey", linetype="dashed") + geom_point() )

(p2 <- p2 + stat_function(fun=fun2, geom="line", size=1, colour="black", linetype="dashed")+ geom_point())

(p2 <- p2 + stat_function(fun=fun3, geom="line", size=1, colour="blue", linetype="dashed")+ geom_point())

#re-transform back

pi <- dt2$score/100

dt2$logitpi <- log(pi/(1-pi))

m0 <- lmer(logitpi~occasion+(1|ID),data=dt2)
summary(m0)
funlogis <- function(x) 100*exp(fixef(m0)[1] + fixef(m0)[2]*x)/(1+exp(fixef(m0)[1] + fixef(m0)[2]*x))

(p2 <- p2 + stat_function(fun=funlogis, geom="line", size=1, colour="green", linetype="dashed"))

# just cubic and logis
ggplot(dt2,aes(x=occasion,y=score, color=ID)) + geom_line(size=0.8) + geom_point() +
  stat_function(fun=fun2, geom="line", size=1, colour="black", linetype="dashed")  +
  stat_function(fun=fun3, geom="line", size=1, colour="blue", linetype="dashed")


dt2$res1 <- dt2$score - fun1(dt2$occasion)
sum(dt2$res1^2)

dt2$res2 <- dt2$score - fun2(dt2$occasion)
sum(dt2$res2^2)

dt2$res3 <- dt2$score - fun3(dt2$occasion)
sum(dt2$res3^2)

dt2$reslogis <- dt2$score - funlogis(dt2$occasion)
sum(dt2$reslogis^2)


