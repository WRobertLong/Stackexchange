require(lme4)
m0 <- lmer(Reaction ~ 1 + Days + (1|Subject), sleepstudy)
ranef(m0)

dt <- sleepstudy[sleepstudy$Subject!='372',]

m1 <- lmer(Reaction ~ 1 + Days + (1|Subject), dt)
ranef(m1)

levels(dt$Subject)
table(dt$Subject)


ranef(m1)



