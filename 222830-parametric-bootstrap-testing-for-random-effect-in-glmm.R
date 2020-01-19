m0 <- lmer(Reaction ~ Days + (1 | Subject) + (0 + Days | Subject), sleepstudy)
summary(m0)

str(sleepstudy)
head(sleepstudy)
summary(sleepstudy)


sleepstudy$days_fac <- sleepstudy$Days
sleepstudy$days_fac[sleepstudy$Days == 0] <- "A"
sleepstudy$days_fac[sleepstudy$Days == 1] <- "A"
sleepstudy$days_fac[sleepstudy$Days == 2] <- "A"
sleepstudy$days_fac[sleepstudy$Days == 3] <- "A"
sleepstudy$days_fac[sleepstudy$Days == 4] <- "B"
sleepstudy$days_fac[sleepstudy$Days == 5] <- "B"
sleepstudy$days_fac[sleepstudy$Days == 6] <- "B"
sleepstudy$days_fac[sleepstudy$Days == 7] <- "C"
sleepstudy$days_fac[sleepstudy$Days == 8] <- "C"
sleepstudy$days_fac[sleepstudy$Days == 9] <- "C"
str(sleepstudy)



m0.1 <- lmer(Reaction ~ Days + (1 | Subject) + (0 + days_fac | Subject), sleepstudy)
summary(m0.1)


## alternatively:
mySumm2 <- function(.) {
   c(beta=fixef(.),sigma=sigma(.), sig01=sqrt(unlist(VarCorr(.))))
}

set.seed(123)
boo01 <- bootMer(m0, mySumm2, nsim = 100, type="parametric")

(bCI.1 <- boot.ci(boo01, index=3, type=c("norm", "basic", "perc")))
(bCI.2 <- boot.ci(boo01, index=4, type=c("norm", "basic", "perc")))
(bCI.3 <- boot.ci(boo01, index=5, type=c("norm", "basic", "perc")))

dt <- sleepstudy

head(dt)
dt$Y <- dt$Reaction - mean(dt$Reaction)
dt$Y <- dt$Y / sd(dt$Y)
summary(dt$Y)
sd(dt$Y)
foo <- dt$Y > rnorm(nrow(dt),0,1)
cbind(foo,dt)
plot(dt$Reaction,foo)
dt$Y <- foo

#m1 <- glmer(Y ~ Days + (1 | Subject) + (0 + Days | Subject), data=dt, family=binomial(link=logit))
m1 <- glmer(Y ~ Days + (1 | Subject), data=dt, family=binomial(link=logit))


set.seed(123)
#boo02 <- bootMer(m1, mySumm2, nsim = 100, type="parametric")
boo03 <- bootMer(m1, mySumm2, nsim = 100, use.u=TRUE, type="parametric")
#boo04 <- bootMer(m1, mySumm2, nsim = 100, use.u=TRUE, type="semiparametric")


boo03

(bCI.1 <- boot.ci(boo02, index=3, type=c("norm", "basic", "perc")))
(bCI.2 <- boot.ci(boo02, index=4, type=c("norm", "basic", "perc")))
(bCI.3 <- boot.ci(boo02, index=5, type=c("norm", "basic", "perc")))


x<-runif(100,0,10)
f1<-gl(n = 10,k = 10)
f2<-as.factor(rep(1:10,10))
data<-data.frame(x=x,f1=f1,f2=f2)
modmat<-model.matrix(~x,data)

fixed<-c(-0.12,0.35)
rnd1<-rnorm(10,0,0.7)
rnd2<-rnorm(10,0,0.2)
 
mus<-modmat%*%fixed+rnd1[f1]+rnd2[f2]
data$y<-rpois(100,exp(mus))
 
m<-glmer(y~x+(1|f1)+(1|f2),data,family="poisson")

boo05 <- bootMer(m, mySumm2, nsim = 100, use.u=TRUE, type="parametric")

(bCI.1 <- boot.ci(boo05, index=3, type=c("norm", "basic", "perc")))
(bCI.2 <- boot.ci(boo05, index=4, type=c("norm", "basic", "perc")))
(bCI.3 <- boot.ci(boo05, index=5, type=c("norm", "basic", "perc")))



rm(list=ls())
require(lme4)
require(boot)

mySumm <- function(.) { s <- sigma(.)
    c(beta =getME(., "beta"), sigma = s, sig01 = unname(s * getME(., "theta"))) }

Penicillin$binY <- Penicillin$diameter > mean(Penicillin$diameter)

m0 <- glmer(binY ~ 1 + (1|plate) + (1|sample), Penicillin, family=binomial(link=logit))

boot <- bootMer(m0, mySumm, nsim = 100, use.u=TRUE, type="parametric")

summary(m0)

(bCI.1 <- boot.ci(boot, index=1, type=c("norm", "basic", "perc")))
(bCI.1 <- boot.ci(boot, index=2, type=c("norm", "basic", "perc")))
(bCI.2 <- boot.ci(boot, index=3, type=c("norm", "basic", "perc")))
(bCI.3 <- boot.ci(boot, index=4, type=c("norm", "basic", "perc")))


(bCI.1 <- boot.ci(boot, conf=0.05, index=3, type="norm"))


