
rm(list = ls())
set.seed(5432)
 
J <- 15
N <- 30
 
test.df <- data.frame( unit = sort(rep(c(1:N),J)), 
                          J = rep(c(1:J),N) , x = rnorm(n = J*N) )
Next, we’ll generate data from our above model, where ßi ~ N(3, .22), ai = 1 for all i, and eij ~ N(0, .752). 

beta <- 3 + .2*rnorm(N)

test.df$beta <- beta[test.df$unit]
test.df$y <- 1 + test.df$x * test.df$beta + .75*rnorm(n = J*N)
head(test.df, 18)

beta.hat <- list()
for(i in 1:N){
  unit.lm <- lm(y ~ x, data = subset(test.df, unit == i) )
  beta.hat[i] <- coef(unit.lm)[2]
}
beta.hat <- as.numeric(beta.hat)

par(mfrow = c(2, 1))
hist(beta, main = "Histogram of Actual Slopes", col = "blue",
     xlab = expression(beta[i]), cex.axis = 1.5, cex.lab = 1.5,
     breaks = seq(from = 2.4, to = 3.6, by = .1) )
hist(as.numeric(beta.hat), main = "Histogram of Estimated Slopes",
     xlab = expression(hat(beta)[i]), col = "blue", cex.axis = 1.5,
     cex.lab = 1.5, breaks = seq(from = 2.4, to = 3.6, by = .1) )


