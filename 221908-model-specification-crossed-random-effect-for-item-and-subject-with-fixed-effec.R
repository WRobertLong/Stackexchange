require(lme4)

#generate one response, two predictors and one factor (random effect)
resp<-runif(100,1, 100)
pred1<-c(resp[1:50]+rnorm(50, -10, 10),resp[1:50]+rnorm(50, 20, 5))
pred2<-resp+rnorm(100, -10, 10)
RF1<-gl(2, 50)


#lmer
mod<-lmer(resp ~ pred1 + (1|RF1))
plot(pred1, resp, type="n")
for (i in ranef(mod)[[1]][,1]) {
abline(fixef(mod)[1]+i, fixef(mod)[2])
}

m1 <- lmer(data = iris, Sepal.Width ~ Petal.Width + (1|Species))

a <- fixef(m1)
b <- ranef(m1, condVar=TRUE)

plot(iris$Sepal.Width ~ iris$Petal.Width, col = iris$Species, las = 1)
abline(a = b[[1]][1,1]+a[1], b= mean_$Petal.Width[1], col = "black")
abline(a = b[[1]][2,1]+a[1], b= mean_$Petal.Width[2], col = "red")
abline(a = b[[1]][3,1]+a[1], b= mean_$Petal.Width[3], col = "green")
abline(a, lty = 2)


m2 <- lmer(data = iris, Sepal.Width ~ Petal.Width + (1 + Petal.Width|Species))

a <- fixef(m2)
b <- ranef(m2, condVar=TRUE)

# Extract the variances of the random effects
qq <- attr(b[[1]], "postVar")

e <- (sqrt(qq)) 

e <- e[2,2,] 

#calculate CI's
liminf=(b[[1]][2]+a[2])-(e*2)
mean_=(b[[1]][2]+a[2])
limsup=(b[[1]][2]+a[2])+(e*2)
#Plot betas and its errors
dotchart(mean_$Petal.Width, labels = rownames(mean_), cex = 0.5,         xlim = c(0.4,1.4), xlab = "betas")
for (i in 1:nrow(mean_)){
     lines(x = c(liminf[i,1], limsup[i,1]), y = c(i,i)) 
}


plot(iris$Sepal.Width ~ iris$Petal.Width, col = iris$Species, las = 1)
abline(a = b[[1]][1,1]+a[1], b= mean_$Petal.Width[1], col = "black")
abline(a = b[[1]][2,1]+a[1], b= mean_$Petal.Width[2], col = "red")
abline(a = b[[1]][3,1]+a[1], b= mean_$Petal.Width[3], col = "green")
abline(a, lty = 2)

