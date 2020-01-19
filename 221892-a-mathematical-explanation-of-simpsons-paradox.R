    rm(list=ls())
    Xa <- c(1,2,3)
    Ya <- c(10,9,8)
    m0 <- lm(Ya~Xa)
    plot(Xa,Ya, xlim=c(0,20), ylim=c(5,20), col="red",xlab="X", ylab="Y")
    abline(m0, col="red")

    Xb <- c(10,11,12)
    Yb <- c(15,14,13)
    m1 <- lm(Yb~Xb)
    points(Xb,Yb, col="blue")
    abline(m1, col="blue")

    X <- c(Xa,Xb)
    Y <- c(Ya,Yb)
    m2 <- lm(Y~X)
    abline(m2, col="black")

