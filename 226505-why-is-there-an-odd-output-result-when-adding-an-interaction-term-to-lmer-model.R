time <- c(6,7,8)
treat <- c(1,2,3)

dt <- expand.grid(treat=treat,time=time)

dt$amp.sqrt <- c(
	130.587,
	130.587 - 3.766,
	130.587 - 14.929,
	130.587 - 7.697,
	130.587 - 7.697 - 3.766 + 9.697,
	130.587 - 7.697 - 14.929 + 53.206,
	130.587 - 2.628,
	130.587 - 2.628 - 3.766 + 8.554,
	130.587 - 2.628 - 14.929 + 62.411
)
dt$treat <- as.factor(dt$treat)
dt$time <- as.factor(dt$time)

require(ggplot2)	
ggplot(dt,aes(x=time,y=amp.sqrt,group=treat, colour=treat)) + geom_point() + geom_line()

ggplot(dd) + geom_line(aes(x=fecha, y=value, colour=variable)) +
  scale_colour_manual(values=c("red","green","blue"))


# model without interaction

dt$amp.sqrt.no_int <- c(
	115.184,
	115.184 + 2.644,
	115.184 + 23.365,
	115.184 + 13.958,
	115.184 + 13.958 + 2.644,
	115.184 + 13.958 + 23.365,
	115.184 + 21.799,
	115.184 + 21.799 + 2.644,
	115.184 + 21.799 + 23.365
)

require(ggplot2)	
ggplot(dt,aes(x=time,y=amp.sqrt,group=treat, colour=treat)) + geom_point() + geom_line()




# simulate data for a 2 factor, 3 level model with interactions (as above)

nper <- 1:10
dtA <- expand.grid(treat=treat,time=time, foo=nper)
B0 <- 130

TREAT2 <- -6
TREAT3 <- -15

TIME2 <- -15
TIME3 <- -16

TREAT2TIME2 <- 10
TREAT2TIME3 <- 30

TREAT3TIME2 <- 15
TREAT3TIME3 <- 50 




