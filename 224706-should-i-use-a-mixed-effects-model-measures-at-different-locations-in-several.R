rm(list=ls())
require(lme4)
set.seed(987)
# number of pieces / times
N <- 10

# Random variation between pieces
# (that is, a random intercept for pieces)

ran_int <- rnorm(N,0,3)  

# measurements per piece
n_per_piece <- 5

# True mean at each measurement occasion for each position
# data generating process:
# measurement = 300 - time*10 - position*20
dtg <- function (t,p) return(300 - t*10 - p*20)

dt <- data.frame()

for (i in 1:N) {

  # loop over pieces ()

  # mean measurements for piece i
  mu_vec = dtg(i,c(1:n_per_piece))

  measures <- rnorm(n_per_piece, mu_vec+ran_int[i], 7) 



  piece <- rep(i,n_per_piece)
  position <- 1:n_per_piece

  dt <- rbind(dt,cbind.data.frame(piece,position,measures))
}

dt$time <- dt$piece
dt$piece <- as.factor(dt$piece)

m0 <- lmer(measures~position+time+(1|piece),data=dt)
summary(m0)

