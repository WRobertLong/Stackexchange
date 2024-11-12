library(dplyr)
library(broom)

# Example data frame
df1 <- data.frame(
  compound = rep(c("A", "B"), each = 10),
  day = rep(1:10, 2),
  fraction1 = c(3.3, 1.4, 2.8, 0.6, 0.9, 21, 22, 1.1, 2.3, 0.4, 1.2, 1.4, 2.8, 0.6, 0.9, 21, 22, 1.1, 2.3, 14.3),
  fraction2 = c(16.5, 11.2, 15.3, 42.4, 20, 43.8, 56.5, 9.6, 6.5, 7.1, 15.4, 11.4, 15.3, 42.4, 20, 43.8, 56.5, 9.6, 6.5, 18.7)
)

# Perform paired t-test separately for each compound
result <- df1 %>%
  group_by(compound) %>%
  do(tidy(t.test(.$fraction1, 
                 .$fraction2, 
                 mu = 0, 
                 alt = "two.sided", 
                 paired = TRUE, 
                 conf.level = 0.95)))

# Function to add significance level
add_significance <- function(p.value) {
  if(p.value < 0.001) {
    return("***")
  } else if(p.value < 0.01) {
    return("**")
  } else if(p.value < 0.05) {
    return("*")
  } else {
    return("ns")
  }
}

# Add significance level to the result
result <- result %>%
  mutate(significance = sapply(p.value, add_significance))

print(result)
