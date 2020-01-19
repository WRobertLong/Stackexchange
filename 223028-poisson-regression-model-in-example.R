

Helmet <- as.factor(c(1,1,1,0,0,0))
Speed <- as.factor(c(1,2,3,1,2,3))
NotSevere <- c(10,10,22,15,18,6)
Severe <- c(6,12,13,4,9,15)

dt <- data.frame(Helmet,Speed,NotSevere,Severe)

m0 <- glm(glm(cbind(NotSevere, Severe) ~ 1, data=dt, family = binomial))

str(dt)