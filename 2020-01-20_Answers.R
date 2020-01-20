#
#
#  Robert Long 20 Jan 2020
#
# https://stats.stackexchange.com/questions/445578/how-do-dags-help-to-reduce-bias-in-causal-inference
#
# confounder bias

set.seed(15)
N <- 100
Smoking <- rnorm(N, 10, 2)
Cancer <- Smoking + rnorm(N)
Lighter <- Smoking + rnorm(N)

summary(lm(Cancer ~ Lighter)) 

summary(lm(Cancer ~ Lighter + Smoking))  

# Mediator bias
# never condition on a mediator
# simple example where the total effect of X on Y is mediated by M
set.seed(15)
N <- 100
Grades <- rnorm(N, 10, 2)
SelfEsteem <- Grades + rnorm(N)
Happiness <- Grades + SelfEsteem + rnorm(N)


summary(m0 <- lm(Happiness ~ Grades)) # happy times
summary(m0 <- lm(Happiness ~ Grades + SelfEsteem)) # crying

# now where there is also a direct effect
Y <- X + M + rnorm(N)
summary(m0 <- lm(Y ~ X)) # happy times
summary(m0 <- lm(Y ~ X + M)) # crying
# note that here we only estimate the direct effect because
# conditioning on the mediator blocks the path via the mediator




#
#
#collider bias
# X and Y are independent, but both cause C, which is therefore a collider

set.seed(16)
N <- 100
X <- rnorm(N, 10, 2)
Y <- rnorm(N, 15, 3)
C <- X + Y + rnorm(N)

summary(m0 <- lm(Y ~ X))
#no effect of X

# now condition on C

summary(m1 <- lm(Y ~ X + C))
# Whoops !!!!!!!

# More complex example from Hernan and Robbins - M Bias
#
set.seed(16)
N <- 100
Lesion <- rnorm(N, 10, 2)
Hypochondria <- rnorm(N, 10, 2)
Test <- Lesion + Hypochondria + rnorm(N)
Activity <- Hypochondria + rnorm(N)
Cancer <- Lesion + 0.25 * Activity + rnorm(N)

summary(lm(Cancer ~ Activity))

summary(lm(Cancer ~ Activity + Test))

cor(Test, Activity); cor(Test, Cancer)

# Now stratified:
# positive results are below the 3rd quartile arround22

dtPos <- data.frame(Lesion, Hypochondria, Test, Activity, Cancer)
dtNeg <- dtPos[dtPos$Test < 22, ]
dtPos <- dtPos[dtPos$Test >= 22, ]
summary(lm(Cancer ~ Activity, data = dtPos))

summary(lm(Cancer ~ Activity, data = dtNeg))
