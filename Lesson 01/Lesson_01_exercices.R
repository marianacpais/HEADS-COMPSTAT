# Exercise
# Note: we did not use the stream package, which would only be used to generate the data anyway (rnorm was used)

# 1. Using the stream package in R, keep the current sample mean of a 1-dimensional data stream.

# 2. Using the stream package in R, keep the current sample mean of a 1-dimensional data stream over a sliding window.

itera <- 2000
set.seed(523)
sum <- n <- 0
mu1 <- 0
mu2 <- 10

window <- NULL
w <- 500


plot(
  NULL,
  xlim=c(0,2000),
  ylim=c(-4,14)
  )

for (i in 1:itera){
  xi <- ifelse(
    i <=1000,
    rnorm(1, mu1, 1),
    rnorm(2, mu2, 2)
    )

  sum <- sum + xi
  n <- n + 1

  window <- c(window, xi)

  if (length(window) > w){
    sum  <- sum - window[1]
    n <- n - 1
    window <- window[-1]
    window <- c(window, xi)
  }

  points(x=i, y=xi, col="black", pch=".")
  points(x=i, y=sum/n, col="red", pch=".")
}

# 3. Using the streampackage in R, keep the current sample mean of a 1-dimensional data stream over a alpha-weighed sliding window.

itera <- 2000
set.seed(523)
sum <- n <- 0
mu1 <- 0
mu2 <- 10

window <- NULL
w <- 500
alpha <-  0.99


plot(
  NULL,
  xlim=c(0,2000),
  ylim=c(-4,14)
  )

for (i in 1:itera){
  xi <- ifelse(
    i <=1000,
    rnorm(1, mu1, 1),
    rnorm(2, mu2, 2)
    )

  sum <- sum * alpha + xi
  n <- n * alpha + 1

  window <- c(window, xi)

  if (length(window) > w){
    sum  <- sum - window[1] * alpha^(w-1)
    n <- n - 1 * alpha^(w-1)
    window <- window[-1]
    window <- c(window, xi)
  }

  points(x=i, y=xi, col="black", pch=".")
  points(x=i, y=sum/n, col="red", pch=".")
}
