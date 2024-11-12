require(MASS)
N <- 300
mu <- c(1,1)

Sigma <- matrix(c(1,0.0,0.0,1),2,2)
Sigma

nsim <- 1000
cors <- numeric(nsim)

for (i in 1:nsim) {
	set.seed(i)
	dt <- data.frame(mvrnorm(n = N, mu, Sigma, empirical=TRUE))
 	names(dt) <- c("X","Y")

	dt$XY <-dt$X*dt$Y
	cors[i] <- cor(dt$X,dt$XY)
	if (abs(cors[i]) < 0.001) {
		print(i)  
#		break
	}
	 
}

hist(cors)
summary(cors)
cov(dt)