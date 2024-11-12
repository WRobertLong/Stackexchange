datafilename="http://personality-project.org/r/datasets/R.appendix3.data"
data.ex3=read.table(datafilename,header=T)   #read the data into a table
data.ex3                                      #show the data
aov.ex3 = aov(Recall~Valence+Error(Subject/Valence),data.ex3)
summary(aov.ex3)
print(model.tables(aov.ex3,"means"),digits=3)       
	#report the means and the number of subjects/cell
boxplot(Recall~Valence,data=data.ex3)        

require(lme4)
mm1 <- lmer(Recall ~ Valence + (1|Subject) , data = data.ex3) 
summary(mm1)

xtabs(~Valence+Subject,data=data.ex3)

mm2 <- lmer(Recall ~ Valence + (1|Valence) + (1|Subject) , data = data.ex3) 
summary(mm2)

summary(aov.ex3)


###### from http://stats.stackexchange.com/questions/14088

tau.base <- structure(list(id = structure(c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 
9L, 10L, 11L, 12L, 13L, 14L, 15L, 16L, 17L, 18L, 19L, 20L, 21L, 
22L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L, 13L, 
14L, 15L, 16L, 17L, 18L, 19L, 20L, 21L, 22L, 1L, 2L, 3L, 4L, 
5L, 6L, 7L, 8L, 9L, 10L, 11L, 12L, 13L, 14L, 15L, 16L, 17L, 18L, 
19L, 20L, 21L, 22L, 1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 
11L, 12L, 13L, 14L, 15L, 16L, 17L, 18L, 19L, 20L, 21L, 22L), .Label = c("A18K", 
"D21C", "F25E", "G25D", "H05M", "H07A", "H08H", "H25C", "H28E", 
"H30D", "J10G", "J22J", "K20U", "M09M", "P20E", "P26G", "P28G", 
"R03C", "U21S", "W08A", "W15V", "W18R"), class = "factor"), factor = structure(c(1L, 
1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 1L, 
1L, 1L, 1L, 1L, 1L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 
2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 3L, 3L, 3L, 3L, 3L, 
3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 
3L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 4L, 
4L, 4L, 4L, 4L, 4L, 4L, 4L), .Label = c("MP", "MT", "AC", "DA"
), class = "factor"), value = c(0.9648092876, 0.2128662077, 1, 
0.0607615485, 0.9912814024, 3.22e-08, 0.8073856412, 0.1465590332, 
0.9981672618, 1, 1, 1, 0.9794401938, 0.6102546108, 0.428651501, 
1, 0.1710644881, 1, 0.7639763913, 1, 0.5298989196, 1, 1, 0.7162733447, 
0.7871177434, 1, 1, 1, 0.8560509327, 0.3096989662, 1, 8.51e-08, 
0.3278862311, 0.0953598576, 1, 1.38e-08, 1.07e-08, 0.545290432, 
0.1305621416, 2.61e-08, 1, 0.9834051136, 0.8044114935, 0.7938839461, 
0.9910112678, 2.58e-08, 0.5762677121, 0.4750002288, 1e-08, 0.8584252623, 
1, 1, 0.6020385797, 8.51e-08, 0.7964935271, 0.2238374288, 0.263377904, 
1, 1.07e-08, 0.3160751898, 5.8e-08, 0.3460325565, 0.6842217296, 
1.01e-08, 0.9438301877, 0.5578367224, 2.18e-08, 1, 0.9161424562, 
0.2924856039, 1e-08, 0.8672987992, 0.9266688748, 0.8356425464, 
0.9988463913, 0.2960361777, 0.0285680426, 0.0969063841, 0.6947998266, 
0.0138254805, 1, 0.3494775301, 1, 2.61e-08, 1.52e-08, 0.5393467752, 
1, 0.9069223275)), .Names = c("id", "factor", "value"), class = "data.frame", row.names = c(1L, 
6L, 10L, 13L, 16L, 17L, 18L, 22L, 23L, 24L, 27L, 29L, 31L, 33L, 
42L, 43L, 44L, 45L, 54L, 56L, 58L, 61L, 64L, 69L, 73L, 76L, 79L, 
80L, 81L, 85L, 86L, 87L, 90L, 92L, 94L, 96L, 105L, 106L, 107L, 
108L, 117L, 119L, 121L, 124L, 127L, 132L, 136L, 139L, 142L, 143L, 
144L, 148L, 149L, 150L, 153L, 155L, 157L, 159L, 168L, 169L, 170L, 
171L, 180L, 182L, 184L, 187L, 190L, 195L, 199L, 202L, 205L, 206L, 
207L, 211L, 212L, 213L, 216L, 218L, 220L, 222L, 231L, 232L, 233L, 
234L, 243L, 245L, 247L, 250L))

require(nlme)
aov1 <- aov(value ~ factor+Error(id/factor), data = tau.base)
summary(aov1)
print(model.tables(aov1,"means"),digits=3)    

aov2 <- aov(value ~ factor+Error(id), data = tau.base)
summary(aov2)
print(model.tables(aov2,"means"),digits=3)    



nlme1 <- lme(value ~ factor, data = tau.base, random = ~1|id)
summary(nlme1)
anova(nlme1)

lmer1 <- lmer(value ~ factor + (1|id), data = tau.base)

summary(lmer1)
anova(lmer1)

# from http://stats.stackexchange.com/questions/13784

set.seed(1)
d <- data.frame(
    Y = rnorm(48),
    subject = factor(rep(1:12, 4)),
    A = factor(rep(1:2, each=24)),
    B = factor(rep(rep(1:2, each=12), 2)))

lm_aov1 <- aov(Y ~ A*B + Error(subject/(A*B)), data=d) # Standard repeated measures ANOVA
summary(lm_aov1)
print(model.tables(lm_aov1,"means"))

lmm1 <- lmer(Y ~ A*B + (1|subject) + (1|A:subject) + (1|B:subject), data=d)  
summary(lmm1)
anova(lmm1)

lmm2 <- lmer(Y ~ A*B + (1|subject), data=d)
summary(lmm2)
anova(lmm2)

lmm3 <- lmer(Y ~ A*B + (1|subject)+(1|A:subject), data=d)
summary(lmm3)
anova(lmm3)

lmm4 <- lmer(Y ~ A*B + (1|A:subject), data=d)
summary(lmm4)
anova(lmm4)



require(lme4)
str(cake)
head(cake)

xtabs(~recipe+replicate,data=cake)

xtabs(~temp+replicate,data=cake)

xtabs(~temperature+replicate,data=cake)

lmm1 <-  lmer(angle ~ recipe * temperature + (1|replicate), cake, REML= FALSE)
summary(lmm1)
anova(lmm1)

lmm2 <-  lmer(angle ~ recipe * temperature + (1|replicate) + (1|recipe), cake, REML= FALSE)
summary(lmm2)
anova(lmm2)

lmm3 <-  lmer(angle ~ recipe * temperature + (1|replicate:recipe) , cake, REML= FALSE)
summary(lmm3)
anova(lmm3)

lmm4 <-  lmer(angle ~ recipe * temperature + (1|replicate:recipe) + (1|replicate:temperature)  , cake, REML= FALSE)
summary(lmm4)
anova(lmm4)

lmm5 <-  lmer(angle ~ recipe * temperature + (1|replicate) + (1|replicate:recipe) + (1|replicate:temperature)  , cake, REML= FALSE)
summary(lmm5)
anova(lmm5)

lmm6 <-  lmer(angle ~ recipe * temperature + (1|replicate) + (1|recipe) , cake, REML= FALSE)
summary(lmm6)
anova(lmm6)

lmm7 <- lmer(angle ~ recipe * temperature + (1|replicate/recipe), cake, REML= FALSE)
summary(lmm7)
anova(lmm7)

lmm8 <- lmer(angle ~ recipe * temperature + (1|replicate) + (1|replicate:recipe), cake, REML= FALSE)
summary(lmm8)
anova(lmm8)
anova(lmm7,lmm8)



anova(fm1,fm2)

aov1 <- aov(angle ~ recipe * temperature + Error(replicate/(recipe*temperature)),data=cake)
summary(aov1)
print(model.tables(aov1,"means"))




require(lme4)
rm(list=ls())
set.seed(1234)
P     <- 2               # Xb1
Q     <- 2               # Xb2
R     <- 3               # Xw1
S     <- 3               # Time
Njklm <- 20              # obs per cell
Njk   <- Njklm*P*Q       # number of subjects
N     <- Njklm*P*Q*R*S   # number of observations
id    <- gl(Njk,         R*S, N, labels=c(paste("s", 1:Njk, sep="")))
Xb1   <- gl(P,   Njklm*Q*R*S, N, labels=c("CG", "T"))
Xb2   <- gl(Q,   Njklm  *R*S, N, labels=c("f", "m"))
Xw1   <- gl(R,             S, N, labels=c("A", "B", "C"))
Time   <- gl(S,   1,           N, labels=c("1", "2", "3"))


mu      <- 100
eB1     <- c(-5, 5)
#eB2     <- c(-5, 5)
eB2     <- c(-1, 1)
eW1     <- c(-5, 0, 5)
#eW2     <- c(-5, 0, 5)
eW2     <- c(-10, 0, 10)
eB1B2   <- c(-5, 5, 5, -5)
eB1W1   <- c(-5, 5, 2, -2, 3, -3)
eB1W2   <- c(-5, 5, 2, -2, 3, -3)
eB2W1   <- c(-5, 5, 2, -2, 3, -3)
#eB2W2   <- c(-5, 5, 2, -2, 3, -3)
eB2W2   <- c(-10, 5, 0, -5, 3, -8)
#eW1W2   <- c(-5, 2, 3, 2, 3, -5, 2, -5, 3)
eW1W2   <- rep(0,9)

eB1B2W1 <- c(-5, 5, 5, -5, 2, -2, -2, 2, 3, -3, -3, 3)
eB1B2W2 <- c(-5, 5, 5, -5, 2, -2, -2, 2, 3, -3, -3, 3)
#eB1W1W2 <- c(-5, 5, 2, -2, 3, -3, 3, -3, -5, 5, 2, -2, 2, -2, 3, -3, -5, 5)
eB1W1W2 <- c(-5, 5, 2, -2, 3, -3, 3, -3, -5, 5, 2, -2, 2, -2, 3, -3, -5, 5)
eB1W1W2 <- rep(0,18)
eB2W1W2 <- c(-5, 5, 2, -2, 3, -3, 3, -3, -5, 5, 2, -2, 2, -2, 3, -3, -5, 5)
# no 3rd-order interaction B1xB2xW1xW2

names(eB1)     <- levels(Xb1)
names(eB2)     <- levels(Xb2)
names(eW1)     <- levels(Xw1)
names(eW2)     <- levels(Time)
names(eB1B2)   <- levels(interaction(Xb1, Xb2))
names(eB1W1)   <- levels(interaction(Xb1, Xw1))
names(eB1W2)   <- levels(interaction(Xb1, Time))
names(eB2W1)   <- levels(interaction(Xb2, Xw1))
names(eB2W2)   <- levels(interaction(Xb2, Time))
names(eW1W2)   <- levels(interaction(Xw1, Time))
names(eB1B2W1) <- levels(interaction(Xb1, Xb2, Xw1))
names(eB1B2W2) <- levels(interaction(Xb1, Xb2, Time))
names(eB1W1W2) <- levels(interaction(Xb1, Xw1, Time))
names(eB2W1W2) <- levels(interaction(Xb2, Xw1, Time))


muJKLM <- mu +
          eB1[Xb1] + eB2[Xb2] + eW1[Xw1] + eW2[Time] +
          eB1B2[interaction(Xb1, Xb2)] +
          eB1W1[interaction(Xb1, Xw1)] +
          eB1W2[interaction(Xb1, Time)] +
          eB2W1[interaction(Xb2, Xw1)] +
          eB2W2[interaction(Xb2, Time)] +
          eW1W2[interaction(Xw1, Time)] +
          eB1B2W1[interaction(Xb1, Xb2, Xw1)] +
          eB1B2W2[interaction(Xb1, Xb2, Time)] +
          eB1W1W2[interaction(Xb1, Xw1, Time)] +
          eB2W1W2[interaction(Xb2, Xw1, Time)]
muId  <- rep(rnorm(Njk, 0, 5), each=R*S)
mus   <- muJKLM + muId
sigma <- 50

Y  <- round(rnorm(N, mus, sigma), 1)
d2 <- data.frame(id, Xb1, Xb2, Xw1, Time, Y)

# Two-way repeated measures ANOVA (RBF-pqpq design)
#Conventional analysis using aov()
aov1 <- aov(Y ~ Xw1*Time + Error(id/(Xw1*Time)), data=d2)
summary(aov1)

source("D:\\Documents\\Stackexchange\\aov\\aovRob.R")
setBreakpoint("aovRob.R#84")
aov2 <- aovRob(Y ~ Xw1*Time + Error(id/(Xw1*Time)), data=d2)
summary(aov2)

lmm1 <- lmer(Y ~ Xw1*Time + (1|id) + (1|Xw1:id) + (1|Time:id), data=d2)
anova(lmm1)

summary(lmm1)

with(d2, interaction.plot(Time, Xw1 , Y,
  ylim = c(80, 130), lty = c(1, 2, 4), lwd = 2,
  ylab = "mean of Y", xlab = "...."))


demo1 <- read.csv("http://www.ats.ucla.edu/stat/data/demo1.csv")
## Convert variables to factor
demo1 <- within(demo1, {
  group <- factor(group)
  time <- factor(time)
  id <- factor(id)
})

demo1.aov <- aov(pulse ~ group * time + Error(id), data = demo1)
summary(demo1.aov)

demo2.aov <- aov(pulse ~ group * time + Error(id/(group * time)), data = demo1)
summary(demo1.aov)

foo <- demo1
foo$pulse <- foo$pulse+1

bar <- rbind(demo1,foo)

demo3.aov <- aov(pulse ~ group * time + Error(id), data = bar)
summary(demo3.aov)

demo4.aov <- aov(pulse ~ group * time + Error(id/(group*time)), data = bar)



politeness <- read.csv("http://www.bodowinter.com/tutorial/politeness_data.csv")


politeness.m0 = lmer(frequency ~ gender*attitude + 
(1+attitude|subject) + (1+attitude|scenario), data=politeness, REML=FALSE)

require(foreign)
dt <- read.dta("D:\\Documents\\Stackexchange\\repeated_measures.dta")


m0 <- lmer(y~time*trt+(1|id),data=dt)
summary(m0)

aov0 <- aov(y~time*trt+Error(id),data=dt)
summary(aov0)

aov1 <- aov(y~time*trt+Error(id/(time*trt)),data=dt)
summary(aov1)

dt$trt <- as.factor(dt$trt)

m1 <- lmer(y~id/(time*trt)+(1|id),data=dt)
summary(m1)


Subject/A
Subject + Subject:A



data1<-c(
49,47,46,47,48,47,41,46,43,47,46,45,
48,46,47,45,49,44,44,45,42,45,45,40,
49,46,47,45,49,45,41,43,44,46,45,40,
45,43,44,45,48,46,40,45,40,45,47,40) # across subjects then conditions

Hays.df <- data.frame(rt = data1, 
subj = factor(rep(paste("subj", 1:12, sep=""), 4)),
shape = factor(rep(rep(c("shape1", "shape2"), c(12, 12)), 2)),
color = factor(rep(c("color1", "color2"), c(24, 24))))








