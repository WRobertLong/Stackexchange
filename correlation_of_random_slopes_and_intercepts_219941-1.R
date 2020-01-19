require(ggplot2)
require(MASS)

simulate some data



nlines <- 20

# intercepts and slopes not covarying

set.seed(15)
Sigma <- Sigma <- matrix(c(0.2,0,0,0.1),2,2)
means <- c(0.5,0.5)
Sigma

dt <- mvrnorm(n = nlines , means, Sigma, empirical = TRUE)

intercepts <- dt[,1]
slopes <- dt[,2]


df <- data.frame()
p + geom_abline(intercept = intercepts[1], slope = slopes[1], color = 20, size=1) +
geom_abline(intercept = intercepts[2], slope = slopes[2], color = 1, size=1) +
geom_abline(intercept = intercepts[3], slope = slopes[3], color = 2) +
geom_abline(intercept = intercepts[4], slope = slopes[4], color = 3) +
geom_abline(intercept = intercepts[5], slope = slopes[5], color = 4) +
geom_abline(intercept = intercepts[6], slope = slopes[6], color = 5) +
geom_abline(intercept = intercepts[7], slope = slopes[7], color = 6) +
geom_abline(intercept = intercepts[8], slope = slopes[8], color = 7) +
geom_abline(intercept = intercepts[9], slope = slopes[9], color = 8) +
geom_abline(intercept = intercepts[10], slope = slopes[10], color = 9) +
geom_abline(intercept = intercepts[11], slope = slopes[11], color = 10) +
geom_abline(intercept = intercepts[12], slope = slopes[12], color = 11) +
geom_abline(intercept = intercepts[13], slope = slopes[13], color = 12) +
geom_abline(intercept = intercepts[14], slope = slopes[14], color = 13) +
geom_abline(intercept = intercepts[15], slope = slopes[15], color = 14) +
geom_abline(intercept = intercepts[16], slope = slopes[16], color = 15) +
geom_abline(intercept = intercepts[17], slope = slopes[17], color = 16) +
geom_abline(intercept = intercepts[18], slope = slopes[18], color = 17) +
geom_abline(intercept = intercepts[19], slope = slopes[19], color = 18) +
geom_abline(intercept = intercepts[20], slope = slopes[20], color = 19)

cor(slopes,intercepts)

# intercepts and slopes covarying negatively
set.seed(15)
Sigma <- Sigma <- matrix(c(0.2,-0.1,-0.1,0.1),2,2)
means <- c(0.5,0.5)
Sigma

dt <- mvrnorm(n = nlines , means, Sigma, empirical = TRUE)

intercepts <- dt[,1]
slopes <- dt[,2]


df <- data.frame()
p <- ggplot(df) + geom_point() + xlim(0,1) + ylim(min(intercepts)-2, max(intercepts)+2)
p
p + geom_abline(intercept = intercepts[1], slope = slopes[1], color = 20) +
geom_abline(intercept = intercepts[2], slope = slopes[2], color = 1) +
geom_abline(intercept = intercepts[3], slope = slopes[3], color = 2) +
geom_abline(intercept = intercepts[4], slope = slopes[4], color = 3) +
geom_abline(intercept = intercepts[5], slope = slopes[5], color = 4) +
geom_abline(intercept = intercepts[6], slope = slopes[6], color = 5) +
geom_abline(intercept = intercepts[7], slope = slopes[7], color = 6) +
geom_abline(intercept = intercepts[8], slope = slopes[8], color = 7) +
geom_abline(intercept = intercepts[9], slope = slopes[9], color = 8) +
geom_abline(intercept = intercepts[10], slope = slopes[10], color = 9) +
geom_abline(intercept = intercepts[11], slope = slopes[11], color = 10) +
geom_abline(intercept = intercepts[12], slope = slopes[12], color = 11) +
geom_abline(intercept = intercepts[13], slope = slopes[13], color = 12) +
geom_abline(intercept = intercepts[14], slope = slopes[14], color = 13) +
geom_abline(intercept = intercepts[15], slope = slopes[15], color = 14) +
geom_abline(intercept = intercepts[16], slope = slopes[16], color = 15) +
geom_abline(intercept = intercepts[17], slope = slopes[17], color = 16) +
geom_abline(intercept = intercepts[18], slope = slopes[18], color = 17) +
geom_abline(intercept = intercepts[19], slope = slopes[19], color = 18) +
geom_abline(intercept = intercepts[20], slope = slopes[20], color = 19)

cor(slopes,intercepts)

# intercepts and slopes covarying positively
set.seed(15)
Sigma <- Sigma <- matrix(c(0.2,0.1,0.1,0.1),2,2)
means <- c(0.5,0.5)
Sigma

dt <- mvrnorm(n = nlines , means, Sigma, empirical = TRUE)

intercepts <- dt[,1]
slopes <- dt[,2]


df <- data.frame()
p <- ggplot(df) + geom_point() + xlim(0,1) + ylim(min(intercepts)-2, max(intercepts)+2)
p
p + geom_abline(intercept = intercepts[1], slope = slopes[1], color = 20) +
geom_abline(intercept = intercepts[2], slope = slopes[2], color = 1) +
geom_abline(intercept = intercepts[3], slope = slopes[3], color = 2) +
geom_abline(intercept = intercepts[4], slope = slopes[4], color = 3) +
geom_abline(intercept = intercepts[5], slope = slopes[5], color = 4) +
geom_abline(intercept = intercepts[6], slope = slopes[6], color = 5) +
geom_abline(intercept = intercepts[7], slope = slopes[7], color = 6) +
geom_abline(intercept = intercepts[8], slope = slopes[8], color = 7) +
geom_abline(intercept = intercepts[9], slope = slopes[9], color = 8) +
geom_abline(intercept = intercepts[10], slope = slopes[10], color = 9) +
geom_abline(intercept = intercepts[11], slope = slopes[11], color = 10) +
geom_abline(intercept = intercepts[12], slope = slopes[12], color = 11) +
geom_abline(intercept = intercepts[13], slope = slopes[13], color = 12) +
geom_abline(intercept = intercepts[14], slope = slopes[14], color = 13) +
geom_abline(intercept = intercepts[15], slope = slopes[15], color = 14) +
geom_abline(intercept = intercepts[16], slope = slopes[16], color = 15) +
geom_abline(intercept = intercepts[17], slope = slopes[17], color = 16) +
geom_abline(intercept = intercepts[18], slope = slopes[18], color = 17) +
geom_abline(intercept = intercepts[19], slope = slopes[19], color = 18) +
geom_abline(intercept = intercepts[20], slope = slopes[20], color = 19)

cor(slopes,intercepts)






