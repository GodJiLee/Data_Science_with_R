#Exercise 1 리뷰-----------------------
fibonacci = function(n) {
  if (n == 0) {
    result = 0
  } else if (n == 1) {
    result = 1
  } else if (n == 2) {
    result = 1
  } else {
    val = c(1, 1)
    for (i in 3:n)
      val[i] = val[i - 2] + val[i - 1]
    result = val[length(val)]
  }
  return(result)
}

fibonacci(10)
rm(fibonacci)

#Exercise 2 리뷰-------------------

# 이 상태에서 뺄셈은 element-wise로 #브로드캐스팅과 같은 개념
# X[2, ] - X_new[1, ]
# X]3. ] - X_new[1, ]
# X[4, ] - X_new[1, ]... 을 대체

X - X_new[1, ] #R에서는 차원을 통일시켜주지 않으면 기본적으로 4개씩 계산

set.seed(1)
ind = sample(1:nrow(iris), size = 0.7 * nrow(iris))
X = as.matrix(iris[ind, 1:4])
y = iris[ind, 5]
X_new = as.matrix(iris[-ind, 1:4])
y_true = iris[-ind, 5]



knn = function(X, y, X_new, k) {
  X = as.matrix(X) #각각이 행렬로 들어올 수도 있으므로
  X_new = as.matrix(X_new) #일반적인 함수로 만들어줌
  type = class(y)
  pred_y = c()
  for (i in 1:nrow(X_new)) {
    euc_dist = sqrt(rowSums((X - matrix(X_new[i, ],
                                        nrow = nrow(X),
                                        ncol = ncol(X),
                                        byrow = TRUE))^2))
    pred_tmp = table(y[order(euc_dist)[1:k]])
    pred_y[i] = names(pred_tmp)[which.max(pred_tmp)]
  }
  return(pred_y)
}

knn(X, y, X_new, 3)
knn(X, y, X_new, 4)

#알고리즘 성능 평가 
pred_y = knn(X, y, X_new, 1)
table(y_true, pred_y) #나머지 -ind를 토대로 평가

pred_Y = knn(X, y, X_new, 3)
table(y_true, pred_y)

euclid_mat = function(x, y) {
  return(sqrt(colSums((x-y)^2)))
}

#K- means algorithms
X = as.matrix(iris[, -5])

my_kmeans = function(X, centers, maxiter) {
  cluster = sample(1:centers, nrow(X), replace = TRUE)
  cluster
  
  colMeans(X[cluster == 1, ])
  colMeans(X[cluster == 2, ])
  colMeans(X[cluster == 3, ])
  
  center_mat = matrix(0, nrow = centers, ncol = ncol(X))
  
  #for 문으로 대체 
  for (i in 1:centers) {
    center_mat[i, ] = colMeans(X[cluster == i, ])
  }
  
  #다시 중심과 데이터간의 유클리디안 거리 계산
  
  euclid_mat = function(x, y) {
    #x, y자리에는 각각 행렬과 벡터가 들어갈 것임
    return(sqrt(colSums((x - y)^2))) #반환값은 행렬이 됨
  }
  
  
  for(j in 1:maxiter) { #그룹화 반복
    dist = matrix(0, nrow = nrow(X), ncol = centers) #저장하기 위한 변수
    
    for (i in 1:centers) {
      dist[, i] = euclid_mat(t(X), center_mat[i, ]) #t()는 열과 행을 transpose
    } 
    
    #중심에 따라 새로 배정해준 cluster
    cluster = apply(dist, 1, which.min) #1은 행별 계산
    #유클리디안 거리가 가장 작은 그룹으로 배정해주는 것
    
    for (i in 1:centers) {
      center_mat[i, ] = colMeans(X[cluster == i, ])
    }
  }
  return(cluster)
}

#중심이 변하지 않으면 멈추는 조건 추가할 수 있음

#10번 그룹화 했을 때 배정된 그룹
my_kmeans(X, center = 3, maxiter = 10)

group = my_kmeans(X, centers = 3, maxiter =10)

cbind(X, group) #열끼리 묶어줌
rbind(X, c(1, 2, 3, 4)) #행끼리 묶어줌
