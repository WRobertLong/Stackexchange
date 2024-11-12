setwd("D:\\Documents\\Stackexchange")
dt <- read.csv("221959residuals-analysis-interpretation-of-a-scatter-plot.csv")

m0 <- lm(C~years+Y+W+SSW+G+T+TR+D,data=dt)

dt$logC <- log(dt$C)
m1 <- lm(logC~years+Y+W+SSW+G+T+TR+D,data=dt)
cor(dt)
plot(m1)

plot(dt$C,dt$Y)
plot(dt$C,dt$W)
plot(dt$C,dt$SSW)
plot(dt$C,dt$G)