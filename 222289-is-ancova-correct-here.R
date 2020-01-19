rm(list=ls())
require(MASS)

N <- 250

Sigma <- matrix(c(100,60,60,100),nrow=2)

mu1 <- c(40,30)
data1 <- data.frame(mvrnorm(n = N, mu1, Sigma))
names(data1) <- c("x","y")
summary(data1)
sd(data1$x)
cor(data1)


mu2 <- c(80,60)
data2 <- data.frame(mvrnorm(n = N, mu2, Sigma))
names(data2) <- c("x","y")
summary(data2)
sd(data1$x)
cor(data2)

x.range=c(0,max(data1$x,data2$x))
y.range=c(0,max(data1$y,data2$y))

plot(data1$x,data1$y, col=4, xlim=x.range, ylim=y.range)
points(data2$x,data2$y, col=2, xlim=x.range, ylim=y.range)

mod1 <- lm(y~x,data=data1)
abline(mod1,col=4,lwd=2)

mod2 <- lm(y~x,data=data2)
abline(mod2,col=2,lwd=2)
abline(a = 0, b = 0.75, col = 1, lwd=2)

data3 <- rbind(data1,data2)
data3$sex <- c(rep("Male", N), rep("Female", N))
mod3 <- lm(y~x+sex,data=data3)

summary(mod3)

#######################################################

# mixed model approach

ids <- 1:Nrow

dt.mm <- data.frame(Y=data1$x,t=2, sex="Male")
dt.mm <- rbind(dt.mm,data.frame(Y=data1$y,t=1, sex="Male"))
dt.mm <- rbind(dt.mm,data.frame(Y=data2$x,t=2, sex="Female"))
dt.mm <- rbind(dt.mm,data.frame(Y=data2$y,t=1, sex="Female"))
dt.mm <- cbind(dt.mm,ids)



ids <- NULL

for (i in 1:(N*2)) {

  ids <- c(ids,c(i,i))

}

dt.mm <- cbind(dt.mm,ids)

lm1 <- lmer(Y ~ t + sex + (1|ids), data=dt.mm)
summary(lm1)

require(ggplot2)

ggplot(data=dt.mm,
                aes(x=ids, y=Y, colour=sex, group=sex)) +
            geom_line()

range=c(0,max(dt.mm$Y))


plot(dt.mm$Y[dt.mm$t == "1" & dt.mm$sex=="Female"], dt.mm$Y[dt.mm$t == "2" & dt.mm$sex=="Female"], xlim=range, ylim=range)
points(dt.mm$Y[dt.mm$t == "1" & dt.mm$sex=="Male"], dt.mm$Y[dt.mm$t == "2" & dt.mm$sex=="Male"])
plot(lm1)




Sigma3 <- matrix(c(100,60,60,100),nrow=2)

mu3 <- c(40,30)
data3 <- data.frame(mvrnorm(n = N, mu3, Sigma3))
names(data3) <- c("x","y")
summary(data3)
data3$y <- data3$y+10
sd(data3$x)
cor(data3)

Sigma4 <- matrix(c(100,60,60,100),nrow=2)

mu4 <- c(40,30)
data4 <- data.frame(mvrnorm(n = N, mu4, Sigma4))
names(data4) <- c("x","y")
summary(data4)
data4$y <- data4$y+20
sd(data4$x)
cor(data4)

x.range=c(0,max(data3$x,data4$x))
y.range=c(0,max(data3$y,data4$y))

plot(data3$x,data3$y, col=4, xlim=x.range, ylim=y.range)
points(data4$x,data4$y, col=2, xlim=x.range, ylim=y.range)

mod4 <- lm(y~x,data=data3)
summary(mod4)
abline(mod4,col=4,lwd=2)

mod5 <- lm(y~x,data=data4)
summary(mod5)
abline(mod5,col=2,lwd=2)

data6 <- rbind(data3,data4)
data6$sex <- c(rep("Male", N), rep("Female", N))
mod6 <- lm(y~x+sex,data=data6)

summary(mod6)







