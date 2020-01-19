#Simulate nvar variables with random covariance structure
require(MASS)
# variance structure

rm(list=ls())

nvar <- 6
N <- 1000

st.dev <- 0.5 #this and k are aspects I would like to vary

y1<-matrix(rnorm(nvar^2,mean=0,sd=st.dev),nvar)
y1<-t(y1)%*%y1

Sigma <- y1

mu <- rnorm(nvar,3,3)

nsim <- 100

vec.eff <- numeric(nsim)

for (i in 1:nsim) {

	dt <- data.frame(mvrnorm(1000,mu,Sigma))

	dt$sex <- rbinom(N,1,0.5) + 3

	betas <- rnorm(nvar,3,3)

	y <- betas[1]*dt$X1 + betas[2]*dt$X1[2] + betas[3]*dt$X3 +
	     betas[4]*dt$X4 + betas[5]*dt$X1[5] + betas[6]*dt$X6

	e <- rnorm(N,0,sd(y)/2)

	dt$Y <- y + 1*dt$sex  + e

	dt$sex <- as.factor(dt$sex)
	levels(dt$sex) <- c("male","female")

	vec.eff[i] <- coef(lm(Y~X1+X2+X3+X4+X5+X6+sex, data=dt))["sexfemale"]
}

hist(vec.eff)


require(MCMCglmm)

data(Traffic)

prior <- list(R = list(V = 1, nu = 0.002), G = list(G1 = list(V = 1e+08, fix = 1)))
 m2a.6 <- MCMCglmm(y ~ limit + day, random = ~year,
 family = "poisson", data = Traffic, prior = prior,
 verbose = FALSE, pr = TRUE)
summary(m2a.6)
plot(m2a.6$Sol)









