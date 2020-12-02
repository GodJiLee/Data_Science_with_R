### EM algorithm

## Example 1: multinomial 
eps = 1e-5
theta = diff = 0.5
k = 0
result = c(k, theta, diff)

while(diff > eps) {
  y = 44 * 2 * theta / (theta + 1)
  th_hat = (3*y - 19) / (2*y + 19)
  diff = abs(theta - th_hat)
  theta = th_hat
  k = k + 1
  result = rbind(result, c(k, theta, diff))
}


round(result, 8)



## Example 3: normal mixture

# 난수발생
u <- runif(1000, 0, 1)
u[1000]

k = 0
j = 0

for (i in 1:1000) {
  if (u[i] <= 0.4) {
    k <- k + 1
  } else {
    j <- j + 1
  }
}

x1 <- rexp(k, 2)
x2 <- rexp(j, 3)
x1
x2


x <- c(x1, x2)

x

Log.lik = function(x, R=2, mu, sigma, prior)
{   
  lik = 0
  
  for (r in 1:R)
    lik = lik + prior[r] * dnorm(x, mean = mu[r], sd = sigma[r]) 
  return(sum(log(lik)))
}


Normal.Mixture = function(X, R=2, maxiter=100, eps=1e-5)
{
  X = as.vector(X)
  N = length(X)
  mu = sigma = prior = rep(0, R)
  gama = matrix(0, R, N)
  # find initial centroids using K-means clustering
  prior = rep(1/R, R)
  kmfit = kmeans(X, R)
  mu = kmfit$centers
  sigma = sqrt(kmfit$withinss /(kmfit$size - 1))     
  old.lik = Log.lik(X, R, mu, sigma, prior) 
  track.lik = as.vector(NULL)
  track.lik = c(old.lik)
  
  for (i in 1:maxiter)
  {
    for (r in 1:R)
      gama[r, ] = prior[r] * dnorm(X, mean = mu[r], sd = sigma[r])
    denom = apply(gama, 2, sum)
    for (r in 1:R)
    {
      gama[r, ] = gama[r, ] / denom
      mu[r] = t(gama[r, ]) %*% X / sum(gama[r, ])
      sigma[r] = sqrt(t(gama[r, ]) %*% (X - mu[r])^2 / sum(gama[r, ]))
    }
    prior = apply(gama, 1, sum) / N
    new.lik = Log.lik(X, R, mu, sigma, prior)
    if (abs(old.lik - new.lik) < eps * abs(old.lik))  break
    old.lik = new.lik
    track.lik = c(track.lik, old.lik)
  }
  
  return(list(mu = mu, sigma = sigma, prior = prior, 
              track = track.lik, resp = gama[r, ]))
}

Mixture.prob = function(x, mu, sigma, prior)
{
  R = length(mu)
  prob = 0
  for (r in 1:R)
    prob = prob + prior[r] * dnorm(x, mu[r], sigma[r]) 
  return(prob)
}

fit = Normal.Mixture(x)  

fit
