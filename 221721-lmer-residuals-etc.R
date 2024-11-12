y      <- rnorm(100, 0, 5)
x      <- rnorm(100, 0, 2)
res    <- lm(y ~ x)$residuals
fitted <- lm(y ~ x)$fitted.values
plot(y, res)
plot(x, res)
plot(fitted, res)



require(lme4)

m0 <- lmer(Reaction ~ 1 + Days + (1+Days|Subject), sleepstudy)
res <- resid(m0)
plot(sleepstudy$Reaction, res)

fits<- fitted(m0)
res <- resid(m0)
x11()
plot(fits, res)
qqnorm(res)
summary(lm(res~fits))

sleepstudy$reaction_log10 <- log10(sleepstudy$Reaction)
sleepstudy$reaction_loge <- log(sleepstudy$Reaction)
m1 <- lmer(reaction_log10 ~ 1 + Days + (1+Days|Subject), sleepstudy)
m2 <- lmer(reaction_loge ~ 1 + Days + (1+Days|Subject), sleepstudy)

res_log10 <- resid(m1)
res_loge <- resid(m2)
fits_log10 <- fitted(m1)
fits_loge <- fitted(m2)
plot(fits_log10,res_log10)
summary(lm(res_log10~fits_log10))
summary(lm(res_loge~fits_log10))

plot(m2)

n <- 1000
x <- rnorm(n,0,1)
z <- rnorm(n,2,2)
y <- x + z + x*z + rnorm(n,0,1)

m0 <- lm(y~x*z)
plot(m0)

m1 <- lm(y~x)
summary(m1)
plot(m1)




