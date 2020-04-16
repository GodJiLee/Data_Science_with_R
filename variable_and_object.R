x <- 1 + 2
y <- 10 + 2

system.time(x <- 1)
system.time(x = 1) #에러가 나는 경우
system.time((x = 1)) #에러 방지할 수 있는 방법

1 + 3 -> z
z

`*` <- 1
`*` #특수문자를 변수로 할당하는 방법

`1` <- 2 #숫자를 변수로 할당하는 방법
`1`

#숫자의 종류를 파악
x <- 1.1
typeof(x)
is.double(x)
is.double((1 + 3i))

as.double(1 + 3i)

y <- 1L
typeof(y)
typeof(1)

is.integer(y)

is.numeric(y)

is.double(y)

z <- as.integer(x)#강제로 정수형으로 바꿔줌 
as.integer(y)
is.integer(z)

typeof(1.1L)#소수점에 L을 붙인다고 정수형이 되지 않음

x <- 1.1
y <- 3L

is.numeric(x)
is.numeric(y)
#정수와 소수를 포함하는 실수의 개념 

x <- "이지원"
y <- '이지원'

x
y

z <- "1"

z

as.character(1)
is.character(x)
is.character(y)
is.character(z)

is.character(1)

x <- '강사님이 "다음 주까지 과제 내세요" 라고 말씀하셨어요'

2 < 3
2 > 3

2 <= 3
2 >= 3

2 == 2
2 == 3

1 != 3
3 != 3

"범진" == "원빈"
"범진" <= "원빈"

"a" < "b"
"1" < "2"
"2" < "10"

"20200312" < "20200313"
"02" < "10"


TRUE == 1
T == 1
FALSE == 0
F == 0


T & T
T & F
F & F

T | F
F | F
T | T

!T
!F
 

x <- 1
y <- 2
z <- 3

x <- c(1, 2, 3)
y <- c("a", "b", "c")
z <- c(TRUE, T, F)

x
y
z

w <- c(1, TRUE, "Lee")
w

x <- c(1, 2, c(3, 4, 5))
x

heights <- c(Kim = 172, Lee = 156, Park = 180)
heights

names(heights)

heights2 <- c(172, 156, 180, 170)
names(heights2) <- c("Kim", "Lee", "Park")

heights2

x <- c(1, 2, 3, 4, 5, 6)
X1 <- matrix(x, nrow = 2, ncol = 3)
X2 <- matrix(x, nrow = 3, ncol = 2, byrow = TRUE)
#데이터와 행 개수, 열 개수를 지정해줌 
X1
X2

matrix(x)

X3 <- matrix(x, nrow = 2) #행만 지정해줘도 열은 자동 지정됨됨
X4 <- matrix(x, nrow = 3)

X3
X4  
  
rownames(X2) <- c("A", "B", "C")
colnames(X2) <- c("Park", "Choi")
X2

x <- c(1, 2, 3, 4, 5, 6, 7, 8)
x
X1 <- array(x)
X1

X2 <- array(x, dim = c(4, 2))
X2

X3 <- array(x, dim = c(2, 2, 2))
X3

df <- data.frame(name = c("Won", "Lee", "Choi", "Su"), 
                 gender = c("M", "F", "M", "F"),
                 weight = c(62, 50, 100, 48))
df

x <- list(x1 = c(1, 2, 3), x2 = matrix(c(1, 2, 3, 4), 2), 
     x3 = data.frame(x = c(1, 2, 3), y = c(2, 3, 4)), x4 = list()) 

#행렬, 배열, 벡터, 리스트를 포함한 리스트 생성
x

str(x)


id <- 2017280063
id

x1 <- c(2, 4, 6, 8)
x1

x2 <- matrix(x1, nrow = 2, ncol = 2)
x2

df <- data.frame(name = c("Won", "Lee", "Choi", "Su"),
                 gender = c("M", "F", "M", "F"),
                 heights = c(178, 170, 210, 165), 
                 weight = c(62, 50, 100, 48),
                 stringsAsFactors = FALSE)
str(df)

x3 <- list(x1, x2, df)
x3


