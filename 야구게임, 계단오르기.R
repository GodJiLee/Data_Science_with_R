#while문과 repeat문에서 if문을 사용하는 법 
#구구단 매서드 
number = 1:9
mat = matrix(0, nrow = length(number), ncol = length(number))
i <- j <- 1
cond1 <- cond2 <- TRUE
while(cond1) {
  while(cond2) {
    mat[i, j] <- number[i] * number[j]
    j <- j + 1 #구구단 1단 구성 
    if (j >length(number)) { 
      cond2 <- FALSE
    }
  }
  i <- i + 1; j <- 1
  cond2 <-  TRUE
  if(i > length(number)) { 
    cond1 <- FALSE
  }
}

mat[i, j]
mat

number = 1:9
mat = matrix(0, nrow = length(number), ncol = length(number))
i <- j <- 1
while(TRUE){
  while(TRUE) {
    mat[i, j] <- number[i] * number[j]
    j <- j + 1
    if (j > length(number)) {
      break #cond2 <- FALSE대신 사용
    }
  }
  i = i + 1; j <- 1 #구구단 2단부터 9단까지 작업
  if (i > length(number)) {
    break
  }
}
mat

number = 1:9
mat = matrix(0, nrow = length(number), ncol = length(number))
i <- j <- 1
repeat{ #while문에 항상 TRUE값을 넣어준 결과
  repeat{
    mat[i, j] <- number[i] * number[j]
    j <- j + 1
    if(j > length(number)) {
      break
    }
  }
  i <- i + 1; j <- 1
  if(i > length(number)) {
    break
  }
}
mat

#ifelse() function
score <- c(70, 55, 88, 30)
achv <- ifelse(score >= 70, "A", "B") 
achv

#ifelse() function을 if, for statement를 사용하여 나타내기 
score <- c(70, 55, 88, 30)
achv <- c()
for (i in 1:length(score)) {
  if (score[i] >= 70) {
    achv[i] <- "A"
  } else {
    achv[i] <- "B"
  }
}
achv

#ifelse() function을 2번 이상 사용하는 경우
score <- c(70, 55, 88, 30)
achv <- ifelse(score >= 70, "A", 
               ifelse(score >= 50, "B", "C"))
achv

#swhich() function
name <- "Sion"
switch(name, 
       Beomjin = "good",
       Sangjun = "Nice",
       Sion = "stupid")

name <- "Beomjin"
switch(name, 
       Beomjin = "good",
       Sangjun = "Nice",
       Sion = "stupid")

#야구게임
correct <- c(3, 5, 2)
ask <- c(9, 3, 1)
strike = 0
ball = 0
for (i in 1:length(correct)) {
  for (j in 1:length(correct)) {
    if ((correct[i] == ask[j]) & (i == j)) {
      strike <- strike + 1 #값도 같고 위치도 같은 경우 
    }
    if ((correct[i] == ask[j]) & (i != j)) { #값은 같은데 위치가 다른 경우 
      ball <- ball + 1
    }
  }
}

if ((strike + ball) == 0) {
  answer = "out"
} else {
  answer = paste(strike, "strike", ball, "ball") #문자열 취합
}

answer

cororect <-c (3, 5, 2)
ask <- c(3, 2, 1)
strike = sum(correct == ask) #elementwise로 비교 #T = 1, F = 0으로 계산
ball = sum(correct %in% ask) - strike #correct의 값이 ask에 있는 지 
if ((strike + ball) == 0) {
  answer = "out"
} else {
  answer = paste(strike, "strike", ball, "ball")
}

answer

#입력값에 대해 바로 반환해주는 코드 
cond = TRUE
while(cond) {
  input = readline("Input your number : ")
  ask = na.omit(as.integer(strsplit(input, "") [[1]]))
  correct = c(3, 5, 2)
  strike = sum(correct == ask)
  ball = sum(correct %in% ask) - strike
  if ((strike + ball) == 0) {
    answer = "Out"
  } else{
    answer = paste(strike, "strike", ball, "ball")
  } 
  print(answer)
  if (strike == 3) {
    cond = FALSE
  }
}

?strsplit

#계단오르기 #과제 
x = c("가위", "바위", "보")
mat = matrix(0, nrow = length(x), ncol = length(x), 
             dimnames = list(x, x)) #빈 행렬 생성
#영희가 이기면 1, 철수가 이기면 -1, 비기면 0
mat[, 1] = c(0, -1, 1)
mat[, 2] = c(1, 0, -1)
mat[, 3] = c(-1, 1, 0)
mat
iter  = 100
result_mat = matrix(nrow = iter, ncol = 3)
result_mat

for (j in 1:iter) {
  winner = rep(0, 20) #20번의 가위바위보 
  for (i in 1:20) {
    chul = sample(x, size = 1, prob = c(0.1, 0.7, 0.2))
    young = sample(x, size = 1, prob = c(0.2, 0.3, 0.5))
    winner[i] = switch(as.character(mat[chul, young]),
                       "-1" = "chul",
                       "1" ="young",
                       "0" = "none")
  }
  #factor 메서드를 사용해 빈 열이 없도록 만들어줌 
  result_mat[j, ] = table(factor(winner, 
                                 level = c("young", "none", "chul")))
}

colMeans(result_mat) #열별 평균 
result_mat

#이긴 횟수 * 2 - 진 횟수 
young_new <- result_mat[, 1] * 2 - result_mat[, 3]
chul_new <- result_mat[, 3] * 2 - result_mat[, 1]
none_new <- result_mat[, 2]

new_result_mat = cbind(young_new, none_new, chul_new)
colMeans(new_result_mat)


