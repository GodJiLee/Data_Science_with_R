#과제 1=================================
fibonacci <- function(n){
  if (n == 0) {
    return(0)
  } else if (n == 1) {
    return(1)
  } else {
    f0 = 0
    f1 = 1
    for(i in 2:n){
      res = f0 + f1
      f0 = f1
      f1 = res
    }
    return(f1)
  }
}


#과제 2=================================
set.seed(1)
n = nrow(iris)
ind = sample(1:n, size = floor(0.7 * n))
X <- as.matrix(iris[ind, 1:4])
y <- iris[ind, 5]
X_new <- as.matrix(iris[-ind, 1:4])

x <- matrix(0, nrow = 105)
y_species <- matrix(0, nrow = 45)
min_ind = rep(0, nrow(X_new))

knn <- function(X, y, X_new) {
  for (j in 1:nrow(X_new)) {
    euc_vec = rep(0, nrow(X))
    for (i in 1:nrow(X)) {
      euc_vec[i] = sum((X[i, ] - X_new[j, ])^2)^{1/2}
    }
    min_ind[j] <- which.min(euc_vec)
  }
  for (k in 1:45) {
    y_new <- as.matrix(y)
    y_species[k, 1] <- y_new[min_ind[k]]
  }
  return(y_species)
}

knn(X, y, X_new)