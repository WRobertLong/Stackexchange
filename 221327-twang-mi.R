require(twang)
require(mice)

rm(list=ls())

data(lalonde)
head(lalonde)

ps.lalonde <- ps(treat ~ age + educ + black + hispan + nodegree +
 married + re74 + re75,
 data = lalonde,
 n.trees=5000,
 interaction.depth=2,
 shrinkage=0.01,
 perm.test.iters=0,
 stop.method=c("es.mean","ks.max"),
 estimand = "ATT",
 verbose=FALSE)

plot(ps.lalonde)
lalonde$w <- get.weights(ps.lalonde, stop.method="es.mean")
design.ps <- svydesign(ids=~1, weights=~w, data=lalonde)
glm1 <- svyglm(re78 ~ treat, design=design.ps)
summary(glm1)

glm0 <- glm(re78 ~ treat + age + educ + black + hispan + nodegree + married + re74 + re75, data=lalonde)
summary(glm0)

#create 20% MCAR missingness in re78 and treat

nrow(lalonde)
dt <- lalonde

dt$re78[sample(1:nrow(lalonde),0.2*nrow(lalonde), replace=TRUE)] <- NA
dt$treat[sample(1:nrow(lalonde),0.2*nrow(lalonde), replace=TRUE)] <- NA



head(dt)

n_imps <- 10

imp <- mice(dt,m=n_imps)

ps <- list(n_imps)
treat_coef <- treat_se <- numeric(n_imps)


for (m in 1:n_imps) {

	dt <- complete(imp,m)

	ps[[m]] <- ps(treat ~ age + educ + black + hispan + nodegree +
 	married + re74 + re75,
 	data = dt,
 	n.trees=5000,
 	interaction.depth=2,
 	shrinkage=0.01,
 	perm.test.iters=0,
 	stop.method=c("es.mean","ks.max"),
 	estimand = "ATT",
 	verbose=FALSE)

	dt$w <- get.weights(ps[[m]], stop.method="es.mean")
	design.ps <- svydesign(ids=~1, weights=~w, data=dt)
	glmA <- svyglm(re78 ~ treat, design=design.ps)

	treat_coef[m] <- glmA$coef[2]
	treat_se <- summary(glmA)$coefficients[, 2][2]

}

pooled.est <- mean(treat_coef)
pooled.se <- sqrt(mean(treat_se) + (1+(1/n_imps))*var(treat_coef))

pooled.ci <- pooled.est + (c(-1.96,1.96)*pooled.se)

pooled.est
pooled.ci

