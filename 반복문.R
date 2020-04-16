x <- c("H", "E", "L", "L", "O")
for (i in x) {
  print(i)
}
print(i)

x <- 1:1e+6 # x<- seq(1, 1000000, by = 1) 
y <- 0
system.time(
  for (i in x){
    y <- y + i
  }
)

system.time(print(sum(x))) #?‹œê°„ì„ ì¤„ì¼ ?ˆ˜ ?žˆ?Œ

1:3
1:1e+6

?seq
seq(1, 1000000, by =1) #1ë¶€?„° 1000000ê¹Œì?€ 1ë§Œí¼ ì¦ê?€?•˜ë©´ì„œ ë²¡í„°?™”

seq(1, 15, length.out = 100) #1ë¶€?„° 15ê¹Œì?€ë¥? 100ê°œë¡œ ?‚˜?ˆ ?„œ ë²¡í„°?™” 

X <- matrix(1:6, ncol  = 2)
for (i in X) {
  print(i)
}

dat <- data.frame(x1 = 1:5, x2 = 5:1)
dat
for (i in dat) {
  print(i)
}

x <- list(a = c(1, 2, 3), b = 2:4)
x
for (i in x) {
  print(i)
}

number <- 1:9
mat <- matrix(0, nrow = length(number), ncol = length(number))
mat

for (i in number){
  for (j in number) {
    mat[i, j] = i * j
  }
}

mat

ddeok <- 0:24
soondae <- 0:10

grid <- expand.grid(ddeok = ddeok, soondae = soondae)
grid #ê°? ?ˆ«?žë³? ì¡°í•©?„ ë§Œë“¤?–´ì¤? 

candidate <- grid[(grid$soondae <= 6) &
                    (rowSums(grid) <= 15) &
                    (grid$ddeok > (2 * grid$soondae)), ]

x <- c()
for (i in 1:nrow(candidate)) {
  x[i] = sum(c(4, 5) * candidate[i, ])
}

candidate[which.max(x), ]

i <- 0
while (TRUE) {
  i <- i + 1
  print(i)
} #ë¬´í•œë£¨í”„ #<esc>ë¡? ? •ì§€ 


number = 1:9
mat <- matrix(0, nrow = length(number), ncol = length(number))
i <- j <- 1
while(i <= length(number)){
  while(j <= length(number)){
    mat[i, j] <- number[i] * number[j]
    j <- j + 1
  }
  i <- i + 1
  j <- 1
}

mat

number = 1:9
mat = matrix(0, nrow = length(number), ncol = length(number))
i <- j <- 0
while ((i <- i + 1) <= length(number)) {
  while((j <- j + 1) <= length(number)) {
    mat[i, j] <- number[i] * number[j]
  }
  j <- 0
}

mat

X <- matrix(1:6, ncol = 2)
apply(X, 1, mean)

apply(X, 2, mean)

X[1, 1] <- NA
apply(X, 1, mean, na.rm = TRUE)

apply(X, 2, mean, na.rm = TRUE)

rowMeans(X, na.rm = TRUE)
colMeans(X, na.rm = TRUE)

x <- 1:5
lapply(x, "^", 2)

x <- list(a = c(1, 2, 3), b = c(2, 3, 4), c = c(3, 4, 5))
lapply(x, mean)

x <- 1:5
saaply()

x <- list(a =c(1, 2, 3), b = c(2, 3, 4), c = c(3, 4, 5))
vapply(x,  "*", c(first = 0, second = 0, third = 0), 2)

sapply(x, "^", 2)




#°úÁ¦ 
set.seed(1)
n = nrow(iris)
ind = sample(1:n, size = floor(0.7 * n))
X <- as.matrix(iris[ind, 1:4])
y <- iris[ind, 5]
X_new <- as.matrix(iris[-ind, 1:4])

euclidean_distance <- function(p,q){
  sqrt(sum((p - q)^2))
}

x <- matrix(0, nrow = 105)
y <- matrix(0, nrow = 45)

for (j in 1:nrow(X_new)) {
  for (i in 1:nrow(X)) {
    x[i,1] <- euclidean_distance(X_new[j, ], X[i, ])
  }
  y[j,1] <-which.min(x)
}

y


system.time({
  min_ind = rep(0, nrow(X_new))
  for (j in 1:nrow(X_new)) {
    euc_vec = rep(0, nrow(X))
    for (i in 1:nrow(X)) {
      euc_vec[i] = sqrt((X[i, ] - X_new[j, ])^2)
    }
    min_ind[j] = which.min(euc_vec)
  }
})

system.time({
  min_ind2 = rep(0, nrow(X_new))
  for (j in 1:nrow(X_new)) {
    min_ind2[j] - which.min(rowSums((X - matrix(X_new[j, ],
                                               nrow = nrow(X),
                                               ncol = ncol(X),
                                               byrow = TRUE))^2)^{1/2})
  }
})













