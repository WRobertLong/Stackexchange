rm(list=ls())
set.seed(1)
X1 <- 1:1601
X2 <- 1:6
X3 <- 1:52
X4 <- 1:15
dtA <- expand.grid(X1,X2,X3,X4)
dtA <- dtA[sample(1:nrow(dtA),45000,replace=TRUE),]

conts <- matrix(rnorm(13*nrow(dtA),0,1),ncol=13)
dtA <- cbind(dtA,conts)

dtA$Y <- dtA$Var1 + dtA$Var2 + dtA$Var3 + dtA$Var4 + rnorm(nrow(dtA),0,5)

dtA$Var1 <- as.factor(dtA$Var1)
dtA$Var2 <- as.factor(dtA$Var2)
dtA$Var3 <- as.factor(dtA$Var3)
dtA$Var4 <- as.factor(dtA$Var4)

str(dtA)

dtA$Var3[sample(1:nrow(dtA),nrow(dtA)/10,replace=TRUE)]  <- NA

sum(is.na(dtA$Var3))

require(hot.deck)

hot <- hot.deck(dtA)



require(mice)
imp <- mice(dtA)   # won't run because of too many factor levels

dtA$Var1 <- as.numeric(dtA$Var1)
dtA$Var2 <- as.numeric(dtA$Var2)
dtA$Var3 <- as.numeric(dtA$Var3)
dtA$Var4 <- as.numeric(dtA$Var4)

imp <- mice(dtA,m=2,niter=2)   # Now runs fine (though it's slow)

levels(dtA$Var2)

dtimp <- complete(imp, action='long', include=TRUE)
dtimp$Var3 <- as.factor(dtimp$Var3)
imp <- as.mids(dtimp)

summary(complete(imp,0))

dt1 <- complete(imp,1)

str(dt1)
dt1$Var3 <- as.factor(dt1$Var3)


as.factor(complete(imp,1)$Var3)

(complete(imp,1)$Var3) <- as.factor(complete(imp,1)$Var3)


str(imp$pad[2])



