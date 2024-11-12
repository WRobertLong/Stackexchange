n_Plot <- 12
n_Site <- 6
n_Reg <- 2

set.seed(101)

dt <- expand.grid(
	Plot=factor(LETTERS[1:n_Plot]),
	Site=factor(LETTERS[1:n_Site]),
	Reg=factor(LETTERS[1:n_Reg])
)

res_Reg <- rnorm(n_Reg,0,7)
res_Site <- rnorm(n_Site,0,5)
res_Plot<- rnorm(n_Plot,0,3)

dt <- cbind(dt,expand.grid(res_Plot, res_Site, res_Reg))

Habitat <- c(rep("A",nrow(dt)),rep("B",nrow(dt)), rep("C",nrow(dt)))

dt <- rbind(dt,dt,dt)
dt <- cbind(dt,Habitat)

dt$res_e <- rnorm(nrow(dt),0,1)

dt$y <- as.numeric(dt$Habitat) + dt$Var1 + dt$Var2 + dt$Var3 + dt$res_e

m0 <- lmer(y~Habitat + (1|Reg/Site/Plot), data=dt)
summary(m0)


m1 <- lmer(y~Habitat + (Habitat|Reg/Site/Plot), data=dt)



