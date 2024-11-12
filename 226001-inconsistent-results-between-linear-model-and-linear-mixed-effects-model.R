n <- 20
X1 <- rnorm(n ,10,2)
Y1 <- 10-0.2*X1+rnorm(n ,0,1)
X2 <- rnorm(n ,20,2)
Y2 <- 20-0.2*X2+rnorm(n ,0,1)
X3 <- rnorm(n ,30,2)
Y3 <- 30-0.2*X3+rnorm(n ,0,1)

plot(X1,Y1,ylim=c(min(Y1,Y2,Y3),max(Y1,Y2,Y3)),xlim=c(min(X1,X2,X3),max(X1,X2,X3)), col="red",ylab="Y",xlab="X")
points(X2,Y2,col="blue")
points(X3,Y3, col="green")

summary(m1 <- lm(Y1~X1))
abline(m1,col="red")
summary(m2 <- lm(Y2~X2))
abline(m2,col="blue")
summary(m3 <- lm(Y3~X3))
abline(m3, col="green")

dt <- data.frame(Y=c(Y1,Y2,Y3),X=c(X1,X2,X3))
dt$grp <- as.factor(c(rep(1,n),rep(2,n),rep(3,n)))

summary(m0 <- lm(Y~X,data=dt))
abline(m0,col="black")

require(nlme)
summary(lm1 <- lme(Y~X, random=~1|grp, data=dt))
