require(pracma)

f <- function(x) x^(3/2) #
trapz(f, 0, 1) #=> 0.4 with 11 iterations

f <- function(x) x^(3/2) #
trapzfun(f, 0, 1) #=> 0.4 with 11 iterations





X <- matrix(c(1,2,2,4),nrow=2)
Y <- c(4.1,5.8) 

beta <- X %*% t(X)

solve(beta)








#######################################################


Take any vector of observations, `x1`, for example:

    > x1 <- c(1,2,3,4)

create `x2`, a multiple of `x1`

    > x2 <- x1*2

create y, a linear combination of `x1`, `x2` and some randomness

    > y <- x1 + x2 + rnorm(4,0,1)

observe that 

    > summary(m0 <- lm(y~x1+x2))
    
fails to estimate a value for the `x2` coefficient:



    Call:
    lm(formula = y ~ x1 + x2)

    Residuals:
          1       2       3       4 
     0.3986 -0.4431 -0.3097  0.3542 

    Coefficients: (1 not defined because of singularities)
                Estimate Std. Error t value Pr(>|t|)   
    (Intercept)   1.0153     0.6576   1.544  0.26257   
    x1            2.8936     0.2401  12.051  0.00682 **
    x2                NA         NA      NA       NA   
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

    Residual standard error: 0.5369 on 2 degrees of freedom
    Multiple R-squared:  0.9864,    Adjusted R-squared:  0.9796 
    F-statistic: 145.2 on 1 and 2 DF,  p-value: 0.006816


The model matrix $X$ is:


    > (X <- model.matrix(m0))

      (Intercept) x1 x2
    1           1  1  2
    2           1  2  4
    3           1  3  6
    4           1  4  8

So $XX'$ is


    > (XXdash <- X %*% t(X))
       1  2  3  4
    1  6 11 16 21
    2 11 21 31 41
    3 16 31 46 61
    4 21 41 61 81


which is not invertible, as shown by


    > solve(XXdash)
    Error in solve.default(XXdash) : 
      system is computationally singular: reciprocal condition number = 1.15333e-19

We can also see the singularity of $XX'$ by calculating its determinant:

    > det(XXdash)
[1] -5.916457e-30

which is essentially zero. 



###### 3 ####

set.seed(1)



    > x1 <- c(1,2,3)

create `x2`, a multiple of `x1`

    > x2 <- x1*2

create y, a linear combination of `x1`, `x2` and some randomness

    > y <- x1 + x2 + rnorm(3,0,1)

observe that 

    > summary(m0 <- lm(y~x1+x2))
    
fails to estimate a value for the `x2` coefficient:


   Coefficients: (1 not defined because of singularities)
                Estimate Std. Error t value Pr(>|t|)
    (Intercept)   3.9512     1.6457   2.401    0.251
    x1            1.0095     0.7618   1.325    0.412
    x2                NA         NA      NA       NA

    Residual standard error: 0.02583 on 1 degrees of freedom
    Multiple R-squared:      1,     Adjusted R-squared:  0.9999 
    F-statistic: 2.981e+04 on 1 and 1 DF,  p-value: 0.003687


The model matrix $X$ is:

    > (X <- model.matrix(m0))

  (Intercept) x1 x2
1           1  1  2
2           1  2  4
3           1  3  6

So $XX'$ is

    > (XXdash <- X %*% t(X))
       1  2  3
    1  6 11 16
    2 11 21 31
    3 16 31 46

which is not invertible, as shown by


    > solve(XXdash)
Error in solve.default(XXdash) : 
  Lapack routine dgesv: system is exactly singular: U[3,3] = 0

We can also see the singularity of $XX'$ by calculating its determinant:

    > det(XXdash)
[1] 0


Here is an example with 3 variables, $y$, $x1$ and $x2$ related by the equation

$$ y = x1 + x2 + \epsilon $$

where $\epsilon \sim N(0,1)$

The particular data are

             y x1 x2
    1 4.520866  1  2
    2 6.849811  2  4
    3 6.539804  3  6

We can write the model as 

$$ Y = X \beta + \epsilon$$

where:

$$ Y = \begin{bmatrix}4.52 \\6.85 \\6.54\end{bmatrix}$$

$$ X = \begin{bmatrix}1 & 1 & 2\\1 & 2 & 4 \\1 & 3 & 6\end{bmatrix}$$

So we have

$$ XX' = \begin{bmatrix}1 & 1 & 2\\1 & 2 & 4 \\1 & 3 & 6\end{bmatrix}
\begin{bmatrix}1 & 1 & 1\\1 & 2 & 3 \\2 & 4 & 6\end{bmatrix}
= \begin{bmatrix}6 & 11 & 16\\11 & 21 & 31 \\16 & 31 & 46\end{bmatrix}
$$

Now we calculate the determinant of $XX'$ :

$$ \det XX' = 6\begin{vmatrix}21 & 31 \\31 & 46\end{vmatrix} - 11 \begin{vmatrix}11 & 31 \\16 & 46\end{vmatrix} + 16\begin{vmatrix}11 & 16 \\21 & 31\end{vmatrix}= 0$$

In R we can show this as follows:


    > x1 <- c(1,2,3)

create `x2`, a multiple of `x1`

    > x2 <- x1*2

create y, a linear combination of `x1`, `x2` and some randomness

    > y <- x1 + x2 + rnorm(3,0,1)

observe that 

    > summary(m0 <- lm(y~x1+x2))
    
fails to estimate a value for the `x2` coefficient:


    Coefficients: (1 not defined because of singularities)
                Estimate Std. Error t value Pr(>|t|)
    (Intercept)   3.9512     1.6457   2.401    0.251
    x1            1.0095     0.7618   1.325    0.412
    x2                NA         NA      NA       NA

    Residual standard error: 0.02583 on 1 degrees of freedom
    Multiple R-squared:      1,     Adjusted R-squared:  0.9999 
    F-statistic: 2.981e+04 on 1 and 1 DF,  p-value: 0.003687


The model matrix $X$ is:

    > (X <- model.matrix(m0))

    (Intercept) x1 x2
    1           1  1  2
    2           1  2  4
    3           1  3  6

So $XX'$ is

    > (XXdash <- X %*% t(X))
       1  2  3
    1  6 11 16
    2 11 21 31
    3 16 31 46

which is not invertible, as shown by


    > solve(XXdash)
    Error in solve.default(XXdash) : 
      Lapack routine dgesv: system is exactly singular: U[3,3] = 0

Or:

    > det(XXdash)
[1] 0
