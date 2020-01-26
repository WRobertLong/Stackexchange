#####
#
#  Robert Long
#
# CV answers 21-26 Jan 2020
#
#
#
# https://stats.stackexchange.com/questions/445286/how-to-add-indivivual-specific-variables-for-unlabelled-alternative-using-inter
#
# This is really about how to interpret main effects in the presence of an interaction.
# 
# simulation comes to the rescue as usual :)

N <- 100
X1 <- rnorm(N, 10, 2)
X2 <- rnorm(N, 5, 1)
Y <- X1 + X2 + rnorm(N)
summary(lm(Y ~ X1 + X2))

# now, let's have an interaction
Y <- X1 + X2 - X1*X2 + rnorm(N)
summary(lm(Y ~ X1 * X2))


N <- 100
X1 <- rnorm(N, 10, 2)
X2 <- rbinom(N,1,0.5)

Y <- X1 + X2 - X1*X2 + rnorm(N)
X2 <- as.factor(X2)
summary(lm(Y ~ X1 * X2))


# https://stats.stackexchange.com/questions/445899/p-values-change-after-mean-centering-with-interaction-terms-how-to-test-for-sig

# mean centering with interactions

set.seed(22)
N <- 75
X1 <- rnorm(N, 2, 3)
X2 <- rnorm(N, 3, 2)
Y <- X1 + X2 + rnorm(N)

# now mean-centre X1 and X2
X1c <- X1 - mean(X1)
X2c <- X2 - mean(X2)

summary(lm(Y ~ X1 + X2))
summary(lm(Y ~ X1c + X2c))

# now, let's have an interaction

Y <- X1 + X2 - X1*X2 + rnorm(N)

summary(lm(Y ~ X1 * X2))
summary(lm(Y ~ X1c * X2c))

#
#
#  https://stats.stackexchange.com/questions/446399/what-is-the-main-different-between-multipla-r-squared-and-correlation-coefficien

set.seed(15)
N <- 100

Y <- rnorm(N,10,2)
X <- runif(N,5,10)

m0 <- lm(Y ~ X)

summary(m0)$r.squared

cor(X, Y)^2

all.equal(summary(m0)$r.squared, cor(X, Y)^2)

(coef(m0)[[2]] * sd(X) / sd(Y))^2
