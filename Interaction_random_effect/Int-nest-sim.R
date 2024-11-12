### Interaction as random effect when insufficient levels for proper nesting
# Robert Long 23 Aug 2016

rm(list=ls())   # care needed

require(MASS)
require(ggplot2)
require(lme4)

Nstudent <- 20

# time points measured
T <- 3
# global intercept
beta0 <- 10

#random intercept sd
u0 <- 10

#global slope 
beta1 <- 0

#random slope sd
u1 <- 3

# correlation between random slopes and random intecepts
rho <- 0.99

# correlation-standard deviation matrix
s <- matrix(c(u0,rho,rho,u1),2,2)


Sigma <- sdcor2cov(s)

nsim <- 100
model_u0 <- model_u1 <- numeric(nsim)

for (k in 1:nsim) {

  dt_ranef <- data.frame((mvrnorm(n = Nstudent, c(0, 0), Sigma, empirical=TRUE)))
  names(dt_ranef) <- c("u0","u1")
  cor(dt_ranef)
  sd(dt_ranef$u0)
  sd(dt_ranef$u1)

  e <- rnorm(Nstudent*T,0,2)

  Y <- pupil <- rep(NA,Nstudent*T)

  #X <- 1:(Nstudent*T)
  X <- sample(1:Nstudent*T,Nstudent*T, replace=TRUE)

  #new_ranef <- dt_ranef[order(dt_ranef$u1),]
  new_ranef <- dt_ranef

  for (i in 1:Nstudent) {

    # loop over ranef 
    for (j in 1:T) {
      pupil[((i-1)*T)+j] <- i
      Y[((i-1)*T)+j] <- beta0 + new_ranef[Nstudent-i+1,1] + X[((i-1)*T)+j]*(beta1+new_ranef[Nstudent-i+1,2]) + e[((i-1)*T)+j]
    }
  }

  dt <- data.frame(Y,X,pupil)


op <- options(warn=2)
tt <- try(m0 <- lmer(Y~X+(X|pupil),data=dt))
ifelse(is(tt,"try-error"),"There was a warning or an error","OK")
options(op)


#  m0 <- lmer(Y~X+(X|pupil),data=dt)
  #summary(m0)

  model_u0[k] <- data.frame(VarCorr(m0))[1,5]
  model_u1[k] <- data.frame(VarCorr(m0))[2,5]

}

par(mfrow=c(2,1))
hist(model_u0)
hist(model_u1)

summary(model_u0)
summary(model_u1)

dtGG <- dt
dtGG$pupil <- as.factor(dtGG$pupil)

ggplot(dtGG, aes(x=X, y=Y)) + 
    geom_line(aes(colour=pupil, group=pupil)) + 
    geom_point(aes(colour=pupil),              
               size=3)   

summary(lm(Y~X,data=dt))
summary(m0)



################################################
#  model for pupils in schools
################################################

rm(list=ls())

Nschool <- 20

# school effect
Uschool <- rnorm(Nschool,0,5)

Nstudent <- 20

# time points measured
T <- 3

Y <- e <- X <- pupil <- school <- numeric(Nschool*Nstudent*T)



for (k in 0:(Nschool-1)) {

  # simulate pupils within school k

  # global intercept
  beta0 <- 10

  #random intercept sd
  u0 <- 10

  #global slope 
  beta1 <- 0

  #random slope sd
  u1 <- 3

  # correlation between random slopes and random intecepts
  rho <- 0.99

  # correlation-standard deviation matrix
  s <- matrix(c(u0,rho,rho,u1),2,2)

  Sigma <- sdcor2cov(s)

  dt_ranef <- data.frame((mvrnorm(n = Nstudent, c(0, 0), Sigma, empirical=TRUE)))
  names(dt_ranef) <- c("u0","u1")
  cor(dt_ranef)
  sd(dt_ranef$u0)
  sd(dt_ranef$u1)


  thisSchool <- ((k*Nstudent*T)+1):((k+1)*Nstudent*T)

  e[thisSchool] <- rnorm(Nstudent*T,0,2)

  Y[thisSchool] <- pupil[thisSchool] <- rep(NA,Nstudent*T)





  #X <- 1:(Nstudent*T)
  X[thisSchool] <- sample(1:Nstudent*T,Nstudent*T, replace=TRUE)

  #new_ranef <- dt_ranef[order(dt_ranef$u1),]
  new_ranef <- dt_ranef

  for (i in 1:Nstudent) {

    # loop over ranef 
    for (j in 1:T) {
      pupil[k*Nstudent*T + ((i-1)*T)+j] <- i
      Y[k*Nstudent*T + ((i-1)*T)+j] <- beta0 + Uschool[k+1] + new_ranef[Nstudent-i+1,1] + X[k*Nstudent*T + ((i-1)*T)+j]*(beta1+new_ranef[Nstudent-i+1,2]) + e[k*Nstudent*T +((i-1)*T)+j]
    }
  }

  school[thisSchool] <- rep(k+1,Nstudent*T)
}

  dt <- data.frame(Y,X,pupil,school)

m0 <- lmer(Y ~ X + (X|school/pupil), data=dt)
summary(m0)

m1 <- lmer(Y ~ X + (X|school:pupil), data=dt)
summary(m1)


xtabs(~school+pupil)



fm1 <- lmer(Reaction ~ 1 + Days + (1 + Days|Subject), sleepstudy)
confint(fm1)
summary(fm1)









