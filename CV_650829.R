# https://stats.stackexchange.com/questions/650829/r-how-to-calculate-power-to-detect-a-change-in-mean-beta-reg


library(glmmTMB)

set.seed(15)
n_sites <- 10                # Number of sites 
n_years <- 5                 # Number of years (repeated measures)
n_rep <- 5                  # Number of replicate surveys per site per year
n <- n_sites * n_years * n_rep  # Total number of observations
year <- rep(rep(1:n_years, each = n_rep), n_sites) 
site <- rep(1:n_sites, each = n_years * n_rep)     


n_sim <- 50                   # Number of simulations
vec_pvalues <- numeric(n_sim)   # Vector to store the p-values
eff_size <- 0.08


for (i in 1:n_sim) {
  
  # print(i) # useful for debugging
  print(i)
  # Simulate random intercepts for `site`
  random_effects <- rnorm(n_sites, 0, 0.5)  
  
  # Linear predictor: year effect random effect for site
  eta <- eff_size * year + random_effects[site]
  
  # Inverse logit transformation to bound the mean between 0 and 1
  mu <- plogis(eta)
  
  # Simulate beta-distributed response variable y
  phi <- 10  # Precision parameter
  y <- rbeta(n, mu * phi, (1 - mu) * phi)
  
  data <- data.frame(cover = y, year = year, site = site)
  data$site <- as.factor(data$site)
  
  # Fit beta regression model
  model <- glmmTMB(cover ~ year + (1|site), ziformula = ~1, data = data, family=beta_family(link="logit"))
  
  # Extract p-value for the effect of 'year'
  vec_pvalues[i] <- coef(summary(model))$cond[2, 4]  # p-value for year effect
}
# Calculate power
mean(na.omit(vec_pvalues) < 0.05)
