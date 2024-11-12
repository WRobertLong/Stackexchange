# https://datascience.stackexchange.com/questions/13099/interpreting-multiple-linear-regression

# Simulate some data with same N = 43, with 7 covariates (model 2 in the question)

library(MASS) # needed for the mvrnorm function

N <- 43

# Define the variance-covariance matrix (7x7 example)
sigma <- matrix(c(1, 0.2, 0.3, 0.1, 0.4, 0.2, 0.3,
                  0.2, 1, 0.5, 0.2, 0.3, 0.1, 0.2,
                  0.3, 0.5, 1, 0.3, 0.4, 0.2, 0.1,
                  0.1, 0.2, 0.3, 1, 0.3, 0.5, 0.2,
                  0.4, 0.3, 0.4, 0.3, 1, 0.2, 0.1,
                  0.2, 0.1, 0.2, 0.5, 0.2, 1, 0.4,
                  0.3, 0.2, 0.1, 0.2, 0.1, 0.4, 1),
                nrow = 7, ncol = 7)

# Define the means for each variable (mean vector of length 7)
mu <- rep(0, 7)

# Generate the dataset with 43 observations
set.seed(15)
data <- as.data.frame(mvrnorm(n = N, mu = mu, Sigma = sigma))

data$Y =10 +             # intercept
  data$V1  +       # beta = 1
  rnorm(N, 0, 1)

lm(Y ~ ., data = data) |> summary()
