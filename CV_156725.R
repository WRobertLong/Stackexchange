# https://stats.stackexchange.com/questions/156725/statsmodels-what-can-cause-linalg-error
#

setwd("/home/long/google-drive/Documents/CV_SO_Answer_Stuff")

library(lme4)

# Function to simulate data and fit the model
simulate_and_fit <- function(seed) {
  set.seed(seed)
  
  # Simulate data
  n <- 100  # number of observations
  groups <- 10  # number of groups
  group <- factor(rep(1:groups, each = n / groups))
  x <- rnorm(n)  # fixed effect covariate
  beta <- 1.5  # fixed effect coefficient
  intercepts <- rep(0, groups)  # zero variance for random intercepts
  
  # Response variable
  y <- beta * x + intercepts[group] + rnorm(n, sd = 1)
  
  # Fit the linear mixed model
  model <- try(lmer(y ~ x + (1 | group), REML = FALSE), silent = TRUE)
  
  return(model)
}

# Loop until a singular fit is found
seed <- 1
repeat {
  model <- simulate_and_fit(seed)
  
  if (inherits(model, "merMod")) {
    # Check for singularity
    if (isSingular(model)) {
      cat("Singular fit encountered with seed:", seed, "\n")
      break
    }
  }
  
  seed <- seed + 1
}

# Save the data that caused singularity
set.seed(seed)
n <- 100
groups <- 10
group <- factor(rep(1:groups, each = n / groups))
x <- rnorm(n)
beta <- 1.5
intercepts <- rep(0, groups)
y <- beta * x + intercepts[group] + rnorm(n, sd = 1)
data <- data.frame(y, x, group)

# Save to a CSV
write.csv(data, file = "singular_data.csv", row.names = FALSE)

