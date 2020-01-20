#  Various R code chunks that I wrote for answering questions on
#  Cross Validated https://stats.stackexchange.com/
#  
#  Robert Long
#  19 Jan 2020

# Simple simulation of mathematical coupling when dealing with densities
#
# https://stats.stackexchange.com/questions/445346/what-statistical-model-can-incorporate-my-categorical-variable-2-levels-and-2/445349#445349

set.seed(15)

N <- 100    # number of sites samples

x <- rpois(N, 5) # number of plants

y <- round(5 - 0.2*x + rnorm(N, 0, 2))   # number of elephants

m0 <- lm(y~x)
summary(m0)

area <- runif(N,2,5)   # areas sampled, uniform distibution

cor(x/area,y/area)

m1 <- lm( I(y/area ~ I(x/area)))
summary(m1)

# Whoops !

##############################################################
#
# DAGs and backdoor paths
#
# https://stats.stackexchange.com/questions/445388/controlling-variables-in-casual-diagrams/445464#445464

set.seed(15)
N <- 100
A <- rnorm(N, 10, 2)
C <- rnorm(N, 5, 1)
B <- A + C + rnorm(N)
X <- A + B + rnorm(N)
Y <- X + C + rnorm(N)

m0 <- lm(Y ~ X)
summary(m0)

m1 <- lm(Y ~ X + B)
summary(m1)
confint(m0) ; confint(m1)
cor(X, B)

######################################################
# ANCOVA analysis
#
# https://stats.stackexchange.com/questions/445465/the-lines-on-my-scatterplot-for-ancova-results-doesnt-look-right-personal-erro/445487#445487


set.seed(15)
N <- 50
plants <- rnorm(N, 10, 2)
treat <- c(rep(0,N/2), rep(1,N/2))

eledens <- 8.3 + 0.74*plants + -0.71 *treat - 0.68*plants*treat + rnorm(N, 0, 2)
treat <- as.factor(treat)
levels(treat) <- c("Control", "Mice added")


elemice <- data.frame(eledens, treat, plants)

fit.mice <- lm(formula = eledens ~ treat * plants, data = elemice)


plot(eledens~plants, data=elemice, type = "n", xlab="Plant Density", ylab="Elephant Density")
points(elemice$plants[elemice$treat=="Control"], elemice$eledens[elemice$treat=="Control"], col="skyblue3", pch=16)
points(elemice$plants[elemice$treat=="Mice added"], elemice$eledens[elemice$treat=="Mice added"], col="salmon", pch=16)
abline(fit.mice$coefficients[1], fit.mice$coefficients[3] , col="skyblue3")
abline(fit.mice$coefficients[1]+fit.mice$coefficients[2],fit.mice$coefficients[3]+fit.mice$coefficients[4], col="salmon")
new.x <- rep(seq(min(elemice$plants), max(elemice$plants), len=100),2)
new.s <- rep(c("Control","Mice added"), each=100)
pred <- predict(fit.mice, new=data.frame(plants=new.x, treat=new.s), interval="conf")
pred <- data.frame(pred, treat=new.s, plants=new.x)
head(pred)
lines(new.x[1:100],pred[1:100,"lwr"],lty=2, col="skyblue3")
lines(new.x[1:100],pred[1:100,"upr"],lty=2, col="skyblue3")
lines(new.x[101:200],pred[101:200,"lwr"],lty=2, col="salmon")
lines(new.x[101:200],pred[101:200,"upr"],lty=2, col="salmon")
legend("topleft", pch=16, col=c("skyblue3","salmon"), legend=c("Control","Mice added"))


