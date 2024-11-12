set.seed(1)
N <- 10

X <- c(1,2,3,4,5,6,7,8,9,10)
X2 <- X^2
Y <- X + rnorm(N,0,0.5)

m0 <- lm(Y~X)
summary(m0)

m1 <- lm(Y~as.factor(X))
summary(m1)

N <- 100
Z <- rnorm(N,0,1)
X <- rep(1:10,10)
Y <- Z+X+rnorm(N,0,1)

m0 <- lm(Y~Z+X)
summary(m0)

m1 <- lm(Y~Z+as.factor(X))
summary(m1)

X2 <- X^2
Y <- Z- 10*X + X2+rnorm(N,0,1)


m3 <- lm(Y~Z+X+X2)
summary(m3)

m1 <- lm(Y~Z+as.factor(X))
summary(m1)
