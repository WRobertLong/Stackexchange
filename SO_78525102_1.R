

# SO_78525102_1.R

setwd("/home/long/google-drive/Documents/CV_SO_Answer_Stuff/")

set.seed(15)

CI_t <-  function (x, ci = 0.95)
{
  `%>%` <- magrittr::`%>%`
  Margin_Error <- qt(ci + (1 - ci)/2, df = length(x) - 1) * sd(x)/sqrt(length(x))
  df_out <- data.frame(  sample_size=length(x), Mean=mean(x), sd=sd(x),
                         Margin_Error=Margin_Error,
                         'CI lower limit'=(mean(x) - Margin_Error),
                         'CI Upper limit'=(mean(x) + Margin_Error)) %>%
    tidyr::pivot_longer(names_to = "Measurements", values_to ="values", 1:6 )
  
  return(df_out)
}

# Number of subjects and items
num_subjects <- 30
num_items <- 20

# Generate subject and item IDs
subject <- factor(rep(1:num_subjects, each=num_items))
item <- factor(rep(1:num_items, num_subjects))

# Generate fixed effect predictor
x <- rnorm(num_subjects * num_items, mean=0, sd=1)

nsim <-100

df_res <- data.frame(run = numeric(), subject = numeric(), item = numeric(), residual = numeric())

for (i in 1:nsim){
  
  # Generate random intercepts for subjects and items
  subject_intercepts <- rnorm(num_subjects, mean=0, sd=2)
  item_intercepts <- rnorm(num_items, mean=0, sd=1)
  
  # Generate random intercepts for subjects and items
  subject_intercepts <- rnorm(num_subjects, mean=0, sd=2)
  item_intercepts <- rnorm(num_items, mean=0, sd=1)
  
  # Create a data frame to hold the data
  dt <- data.frame(subject, item, x)
  
  # Add random intercepts to the data frame
  dt$subject_intercept <- subject_intercepts[dt$subject]
  dt$item_intercept <- item_intercepts[dt$item]
  
  # Generate residual error
  residual_error <- rnorm(num_subjects * num_items, mean=0, sd=1)
  
  # Generate response variable y
  dt$y <- 5 + 3 * dt$x + dt$subject_intercept + dt$item_intercept + residual_error
  
  # Fit the linear mixed-effects model
  m0 <- lmer(y ~ x + (1|subject) + (1|item), data=dt)
  
  vc <- as.data.frame(VarCorr(m0))
  
  row_to_insert <- list(run = i, subject = vc$sdcor[1], item = vc$sdcor[2], residual = vc$sdcor[3])
  df_res <- rbind(df_res, row_to_insert)
  
  
  fn <- sprintf("crossed_re_%02d.csv", i)
  write.csv(dt, fn)
}

mean(df_res$subject)
mean(df_res$item)
mean(df_res$residual)

sd(df_res$subject)
sd(df_res$item)
sd(df_res$residual)

CI_t(df_res$subject)
CI_t(df_res$item)
CI_t(df_res$residual)


