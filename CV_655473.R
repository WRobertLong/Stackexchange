##############################################################################
#SIMULATE SURVIVAL DATA WITH TIME_VARYING CONTINUOUS EXPOSURE
##############################################################################

set.seed(1234)


#Load packages
library(MASS)
library(nlme)
library(survival)
library(PermAlgo)
library(data.table)
library(fastDummies)

### set number of individuals
n <- 10000

### average intercept and slope
beta0 <- 10.0
beta1 <- -2.0

### true autocorrelation
ar.val <- -.8

### true error SD, intercept SD, slope SD, and intercept-slope cor
sigma <- 1.5
tau0  <- 2.5
tau1  <- 2.0
tau01 <- 0.3

### maximum number of possible observations (e.g. number of years)
m <- 10

### simulate number of observations for each individual
p <- round(runif(n,4,m))
p <- rep(m,n)

### simulate observation moments (assume everybody has 10 obs)
obs<-rep(1:m, n)

### set up data frame with id and binary time-fixed covariate X1
dat <- data.frame(id=rep(1:n, times=p), obs=obs,
                  x1=rep(rbinom(n, 1, 0.3), each=m))

### simulate confounder as a group variable with 4 levels and corresponding values (grpnum)
grp<-c(rep(1,n*0.2),
       rep(2,n*0.3),
       rep(3,n*0.4),
       rep(4,n*0.1))
dat$grp<-as.factor(grp)

grpnum<-c(rnorm(n = n*0.2,mean = 0,sd = 3),
          rnorm(n = n*0.3,mean=3,sd = 1),
          rnorm(n = n*0.4,mean=-1,sd = 1),
          rnorm(n = n*0.1,mean=-2,sd = 4))
dat$grpnum<-grpnum

### simulate (correlated) random effects for intercepts and slopes
mu  <- c(0,0)
S   <- matrix(c(1, tau01, tau01, 1), nrow=2)
tau <- c(tau0, tau1)
S   <- diag(tau) %*% S %*% diag(tau)
U   <- mvrnorm(n, mu=mu, Sigma=S)

### simulate AR(1) errors and then the actual outcomes
dat$eij <- c(sapply(p, function(x) arima.sim(model=list(ar=ar.val), n=x) * sqrt(1-ar.val^2) * sigma))
dat$yij <- round((beta0 + rep(U[,1], times=p)) +
                   (beta1 + rep(U[,2], times=p))  * log(obs) * dat$grpnum  + dat$eij ,2)

### note: use arima.sim(model=list(ar=ar.val), n=x) * sqrt(1-ar.val^2) * sigma
### construction, so that the true error SD is equal to sigma

#Define longitudinal data
dat<-as.matrix(dat[c("x1","grp","yij")])

#Define dummy variables from "grp" column, becaues Permalgo does not accept factors
dat <- dummy_cols(dat,select_columns = "grp",remove_selected_columns = T)
dat <- as.matrix(sapply(dat, as.numeric)) 



#===================
# generate vectors of event and censoring times prior to calling the
# function for the algorithm
eventRandom <- round(runif(n, 1,10),0)
censorRandom <- round(runif(n, 1,10),0)

# Generate the survival data conditional on the three covariates
data <- permalgorithm(n, m, dat[,1:5], 
                      XmatNames=c("sex", "exposure","grp1","grp2","grp3"), 
                      eventRandom=eventRandom,
                      censorRandom=censorRandom,
                      betas=c(log(1.5), log(1.3), 
                              log(0.8), log(0.8),
                              log(1.5)))


#Run model

#Including grp
coxph(Surv(Start, Stop, Event) ~ sex + exposure + grp1 + grp2 + grp3 , data=data)

#Excluding grp
coxph(Surv(Start, Stop, Event) ~ sex + exposure , data=data)

#The exposure coefficient does not change!

### Troubleshooting 
aggregate(exposure ~ grp1 + grp2 + grp3, data = data, mean)

