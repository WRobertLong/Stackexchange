# Elisa Filevich neuroscience simulations

rm(list=ls())

set.seed(1)

#100
word <- factor(1:100)

u_word <- rnorm(length(word),0,2)
dt_word <- data.frame(word,u_word)

#99
subject <- factor(1:99)
u_subject <- rnorm(length(subject),0,2)
dt_subject <- data.frame(subject,u_subject)

dt <- expand.grid(word=word, subject=subject)

dt$cond <- sample(LETTERS[1:2],nrow(dt), replace=T,prob=rep(0.5,2))
cond <- c("A","B")
cond_effect <- c(1,2)
dt_cond <- data.frame(cond,cond_effect)

head(dt)

foo <- merge(dt, dt_subject)
foo <- merge(foo, dt_word)
foo <- merge(foo, dt_cond)

dt <- foo

dt$e <- rnorm(nrow(dt),0,1)

dt$Y <- 10 + dt$u_subject + dt$u_word + dt$cond_effect + dt$e

require(lme4)
m0 <- lmer(Y~cond + (1|subject) + (1|word), data=dt)
summary(m0)

m1 <- lmer(Y~cond + (1|subject) + (1|cond:word), data=dt)
summary(m1)
#same

#remove ~50% of condition="B"

dt$foo <- runif(nrow(dt),0,1)

# binary outcome variable
dt$Y_bin <- (dt$Y > mean(dt$Y) & dt$foo > 0.5)

dtA <- dt[dt$cond=="A",]
dtB <- dt[dt$cond=="B" & !dt$foo > 0.5,]

dt1 <- rbind(dtA,dtB)

m2 <- lmer(Y~cond + (1|subject) + (1|word), data=dt1)
summary(m2)

m3 <- lmer(Y~cond + (1|subject) + (1|cond:word), data=dt1)
summary(m3)

dt1$Y_bin <- (dt1$Y > mean(dt1$Y) & dt1$foo > 0.5)

m2_glmm <- glmer(Y_bin~cond + (1|subject) + (1|word), data=dt1, family=binomial(link=logit))
summary(m2_glmm)
summary(m2)

m3_glmm <- glmer(Y_bin~cond + (1|subject) + (1|cond:word), data=dt1, family=binomial(link=logit))
summary(m3_glmm)
summary(m3)


