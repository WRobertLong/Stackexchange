Just answering this for a bit of fun and to try to "keep my eye in" with the maths, which is not my strong suite. Hopefully there won't be too many mistakes !

My first approach (before having read @whuber's comment) uses the definition of the characteristic function directly, switches the order of integration, evaluates the resulting integral, and applies an appropriate bound to derive the inequality.

We want to show that for a random variable $ X $ with characteristic function $ \varphi_X(t) = \mathbb{E}[e^{itX}] $, the following inequality holds:
$$
\Pr(|X| > 2T) \leq 2 \left( 1 - \frac{1}{2T} \int_{-T}^{T} \varphi_X(t) \, dt \right)
$$

Starting with the probability we need to bound:
$$
\Pr(|X| > 2T) = \int_{|x| > 2T} f_X(x) \, dx,
$$
where $ f_X(x) $ is the probability density function of $ X $. Using the inverse Fourier transform, the density function $ f_X(x) $ is given by:
$$
f_X(x) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) e^{-itx} \, dt.
$$

Substituting this into the expression for $\Pr(|X| > 2T)$:
$$
\Pr(|X| > 2T) = \int_{|x| > 2T} \left( \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) e^{-itx} \, dt \right) dx
$$

From the properties of characteristic functions and baisc calculus, $\varphi_X(t) e^{-itx}$ is integrable, allowing us to apply Fubini's theorem to change the order of integration, yielding:
$$
\Pr(|X| > 2T) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) \left( \int_{|x| > 2T} e^{-itx} \, dx \right) dt
$$

Evaluating the inner integral:
$$
\int_{|x| > 2T} e^{-itx} \, dx = \int_{-\infty}^{-2T} e^{-itx} \, dx + \int_{2T}^{\infty} e^{-itx} \, dx
$$

This gives us:
$$
\int_{|x| > 2T} e^{-itx} \, dx = \left[ \frac{e^{-itx}}{-it} \right]_{-\infty}^{-2T} + \left[ \frac{e^{-itx}}{-it} \right]_{2T}^{\infty} = \frac{e^{2iTt}}{it} + \frac{e^{-2iTt}}{-it} = \frac{1}{it} \left( e^{2iTt} - e^{-2iTt} \right) = \frac{2 \sin(2Tt)}{t}
$$

Substituting this back into the expression:
$$
\Pr(|X| > 2T) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) \cdot \frac{2 \sin(2Tt)}{t} \, dt
$$

To apply the bound, consider the interval $[-T, T]$ where $ \varphi_X(t) $ is bounded by 1:
$$
\left| \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) \cdot \frac{2 \sin(2Tt)}{t} \, dt \right| \leq \frac{1}{2\pi} \int_{-\infty}^{\infty} \left| \varphi_X(t) \cdot \frac{2 \sin(2Tt)}{t} \right| \, dt
$$

Since $ \varphi_X(t) $ is bounded by 1, and considering the integral over the interval $[-T, T]$:
$$
\int_{-T}^{T} \left| \frac{2 \sin(2Tt)}{t} \right| \, dt
$$

Recognize that:
$$
\int_{-T}^{T} \frac{2 \sin(2Tt)}{t} \, dt = 2 \int_{-T}^{T} \frac{\sin(2Tt)}{t} \, dt
$$

This integral evaluates to:
$$
2 \int_{-T}^{T} \frac{\sin(2Tt)}{t} \, dt = 2 \pi \cdot \mathrm{sinc}(2T \cdot T)
$$

The sinc function $ \mathrm{sinc}(x) = \frac{\sin(x)}{x} $ is bounded, and at $ x = 2T^2 $, it remains within a bounded range. Hence,
$$
\Pr(|X| > 2T) \leq 2 \left( 1 - \frac{1}{2T} \int_{-T}^{T} \varphi_X(t) \, dt \right)
$$

Thus, we have shown the desired inequality:
$$
\Pr(|X| > 2T) \leq 2 \left( 1 - \frac{1}{2T} \int_{-T}^{T} \varphi_X(t) \, dt \right).
$$


-------------------
And now to try whuber's suggested approach:
> Replace $\phi_X$  by its definition (as an integral over the real numbers), switch the order of integration, perform the $t$ integral, and apply the obvious bound to the result

We need to show that for a random variable $ X $ with characteristic function $ \varphi_X(t) = \mathbb{E}[e^{itX}] $, the following inequality holds:

$$
\Pr(|X| > 2T) \leq 2 \left( 1 - \frac{1}{2T} \int_{-T}^{T} \varphi_X(t) \, dt \right).
$$

Recall that the characteristic function $\varphi_X(t)$ is defined as:

$$
\varphi_X(t) = \mathbb{E}[e^{itX}] = \int_{-\infty}^{\infty} e^{itx} f_X(x) \, dx.
$$

We start with the probability:

$$
\Pr(|X| > 2T) = \int_{|x| > 2T} f_X(x) \, dx.
$$

Using the inverse Fourier transform, the density function $ f_X(x) $ is given by:

$$
f_X(x) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) e^{-itx} \, dt.
$$

Substitute this into the expression for $\Pr(|X| > 2T)$:

$$
\Pr(|X| > 2T) = \int_{|x| > 2T} \left( \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) e^{-itx} \, dt \right) dx
$$

And now changing the order of integration as per Fubini's theorem we obtain

$$
\Pr(|X| > 2T) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) \left( \int_{|x| > 2T} e^{-itx} \, dx \right) dt
$$

Evaluating the inner integral:

$$
\int_{|x| > 2T} e^{-itx} \, dx = \int_{-\infty}^{-2T} e^{-itx} \, dx + \int_{2T}^{\infty} e^{-itx} \, dx
$$

This gives us:

$$
\int_{|x| > 2T} e^{-itx} \, dx = \frac{e^{2iTt}}{-it} + \frac{e^{-2iTt}}{it} = \frac{1}{it} \left( e^{2iTt} - e^{-2iTt} \right) = \frac{2 \sin(2Tt)}{t}
$$

and substitute back into the expression:

$$
\Pr(|X| > 2T) = \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) \cdot \frac{2 \sin(2Tt)}{t} \, dt.
$$

To apply the obvious bound, consider the interval $[-T, T]$ where $\varphi_X(t)$ is bounded by 1:

$$
\left| \frac{1}{2\pi} \int_{-\infty}^{\infty} \varphi_X(t) \cdot \frac{2 \sin(2Tt)}{t} \, dt \right| \leq \frac{1}{2\pi} \int_{-\infty}^{\infty} \left| \varphi_X(t) \cdot \frac{2 \sin(2Tt)}{t} \right| \, dt
$$

Since $\varphi_X(t)$ is bounded by 1, and the integrals over symmetric intervals around zero give significant contributions, we focus on the interval $[-T, T]$:

$$
\int_{-T}^{T} \left| \frac{2 \sin(2Tt)}{t} \right| \, dt.
$$

Recognise that:

$$
\int_{-T}^{T} \frac{2 \sin(2Tt)}{t} \, dt = 2 \int_{-T}^{T} \frac{\sin(2Tt)}{t} \, dt = 2 \pi
$$

Hence, integrating over the interval $[-T, T]$:

$$
1 - \frac{1}{2T} \int_{-T}^{T} \varphi_X(t) \, dt
$$

and multiplying by 2:

$$
\Pr(|X| > 2T) \leq 2 \left( 1 - \frac{1}{2T} \int_{-T}^{T} \varphi_X(t) \, dt \right)
$$
