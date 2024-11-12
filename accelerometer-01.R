require(MASS)

setwd("c:\\temp")
dt <- read.csv("Accelerometer-data.csv")
summary(dt)
var(dt)

plot(dt$rawx,dt$rawy)
plot(dt$rawx,dt$rawz)
plot(dt$rawy,dt$rawz)

qqnorm(dt$rawx)
qqnorm(dt$rawy)
qqnorm(dt$rawz)

hist(dt$rawx, breaks=8)
hist(dt$rawy, breaks=8)
hist(dt$rawz, breaks=8)

dt.M <- data.matrix(dt, rownames.force = NA)
dim(dt.M)

require(mvShapiroTest)
mvShapiro.Test(dt.M)

dt2 <- read.csv("Accelerometer-data2.csv")
summary(dt2)
var(dt2)

plot(dt2$rawx,dt2$rawy)
plot(dt2$rawx,dt2$rawz)
plot(dt2$rawy,dt2$rawz)

qqnorm(dt2$rawx)
qqnorm(dt2$rawy)
qqnorm(dt2$rawz)

hist(dt2$rawx, breaks=8)
hist(dt2$rawy, breaks=8)
hist(dt2$rawz, breaks=8)

dt2.M <- data.matrix(dt2, rownames.force = NA)
dim(dt2.M)

require(mvShapiroTest)
mvShapiro.Test(dt2.M)

###############  

dt3 <- read.csv("Accelerometer-data3.csv")
summary(dt3)
var(dt3)

plot(dt3$rawx,dt3$rawy)
plot(dt3$rawx,dt3$rawz)
plot(dt3$rawy,dt3$rawz)

qqnorm(dt3$rawx)
qqnorm(dt3$rawy)
qqnorm(dt3$rawz)

hist(dt3$rawx, breaks=10)
hist(dt3$rawy, breaks=10)
hist(dt3$rawz, breaks=10)

dt3.M <- data.matrix(dt3, rownames.force = NA)
dim(dt3.M)

require(mvShapiroTest)
mvShapiro.Test(dt3.M)

###############  

dt4 <- read.csv("Accelerometer-data4.csv")
summary(dt4)
nrow(dt4)
var(dt4)

plot(dt4$rawx,dt4$rawy)
plot(dt4$rawx,dt4$rawz)
plot(dt4$rawy,dt4$rawz)

qqnorm(dt4$rawx)
qqnorm(dt4$rawy)
qqnorm(dt4$rawz)

hist(dt4$rawx, breaks=10)
hist(dt4$rawy, breaks=10)
hist(dt4$rawz, breaks=10)

dt4.M <- data.matrix(dt4, rownames.force = NA)
dim(dt4.M)

require(mvShapiroTest)
mvShapiro.Test(dt4.M)

library(moments)

skewness(dt$rawx); skewness(dt$rawy); skewness(dt$rawz); 
kurtosis(dt$rawx); kurtosis(dt$rawy); kurtosis(dt$rawz); 

skewness(dt2$rawx); skewness(dt2$rawy); skewness(dt2$rawz); 
kurtosis(dt2$rawx); kurtosis(dt2$rawy); kurtosis(dt2$rawz); 

skewness(dt3$rawx); skewness(dt3$rawy); skewness(dt3$rawz); 
kurtosis(dt3$rawx); kurtosis(dt3$rawy); kurtosis(dt3$rawz); 

skewness(dt4$rawx); skewness(dt4$rawy); skewness(dt4$rawz); 
kurtosis(dt4$rawx); kurtosis(dt4$rawy); kurtosis(dt4$rawz); 




