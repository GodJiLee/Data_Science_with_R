#positive integer indexing
x <- c(5, 6, 7, 8, 9, 10)
x[c(2, 4, 6)] #?�?�諝? 鴔?�?鴗?

#negativei integer indexing
x[c(-2, -4, -6)]
x[-c(1, 3, 5)]

x[c(F, F, F, T, T, F)]

x[x > 7]

y <- c(170, 173, 175, 180)
names(y) <- c("Kim", "Lee", "Park", "Choi")
z <- y[c("Choi", "Lee")]
z

A = matrix(c(1, 2, 3, 4, 5, 6), ncol = 2)
#?�?� ???
A[1, 1] #1?� 1??� ???�?� ?�?� 黺
A[1, 2]

#?�?� ???
A[-1, -2] #1?� ?�麮渥? 2? ?�麮渠?? ?�??�窸? 黺

#?謔? ???
A[c(TRUE, FALSE, TRUE), c(TRUE, FALSE)]

#? ?�麮渠?? 踳� ??� ?�?�
A[c(1, 2, 3), 1]
A[, 1]

#?� ?�麮渠?? 踳� ??� ?�
A[3, ]

A[A[, 1] > 1, ]

#?�?�?諢? 貒∮諢? 貐?�??� ?�?
class(A[, 1]) 

matrix(c(4, 5, 6))

#?�? ?�?� 篞賈?諢? ?�鴔鴔
class(A[, 1, drop = F])

#?�?�諤? ?謔 賱?�?� 窶趣
rownames(A) = c("r1", "r2", "r3")
A

A["r1", 2] #??? ??�諢? ????� ??? 穈?

df <- data.frame(name = c("Park", "Kim", "Jung", "Lee"),
                 weight =c(100, 56, 44, 68))

#$諢? ??? 穈?
df[, 1]

df$name
df$weight

df[, "name"]
df[, "name", drop = T]
df[["name"]]
#諈刺� 穈? 窶國頃

df[, "name", drop = F] #dataframe 窱科※諝? ?�鴔?�? 
df["name"] #dropfalse?? 穈? 窶國頃


x <- list(a = c(1, 2, 3),
          b = data.frame(V1 = c(2, 3, 4), 
                         V2 = c(3, 4, 5)))
x

x[1] #謔科? ??� ?�賳收??諝? 黺?
x[[1]] #貒∮諢? 黺 

class(x[1])
class(x[[1]])

x["a"]
x["b"]

x$a
x$b #穈諢? 黺 

x[[2]]$V2
x[[2]][, "V2"] #dataframe ???? 穈?? 
x[2]$V2 #dataframe indexing ? 賱?? 

x <- c(1, 2, 3, 6)
x[4] <- 4
x

x[x == 6] <- 4 #?謔禹�?� ?�? 貐窶?
x

x <- matrix(c(1, 2, 3, 4, 5, 6), ncol = 2)
x[c(1, 2), 2] <- c(10, 11)
x

#change elements in the data frame
dat <- data.frame(name = c("Park", "Kim", "Lee", "Park"),
                  gender = c("M", "F", "M", "M"))

dat

dat[1,2] #1?� 2??� ?�?�諝? 踳�\
dat[dat$name == "Park"] #1?�諤? 黺
dat[dat$name == "Park", "gender"] <- "F"
dat

#?�諢 column ?�??�?� 貒?
dat[, "age"] <- c(24, 45, 11, 23)
dat$age <- c(24, 45, 11, 23)

dat

x <- list(a = c(1, 2, 3), b = matrix(c(1, 2, 3, 4), 2))
x

x[[1]][2] <- 30 #麮? 貒孛 謔科??� 2貒孛 ???穈� 30?諢? ?�?�?�
x

x[[2]][, 2] <- c(5, 6)
x

x$c <- data.frame(V1 = c(10, 20, 30), V2 = c("a", "b", "c"))
x

x[["d"]] <- list(c(1, 2, 3))
x

dat1 <- data.frame(a = c(1, 2), b = c(3, 4))
dat2 <- data.frame(c = c(5, 6), d = c(7, 8))

dat1 %*% dat2

X1 <- as.matrix(dat1)
X2 <- as.matrix(dat2)

class(X1)
class(X2)

X1 %*% X2

?as.integer

#3輿離 婁薯
dat <- data.frame(sepal_length = c(5.1, 4.9, 4.7, 4.6, 4.4, 5.5),
                  sepal_width = c(3.5, 3.0, 2.9, 3.4, 3.8, 4.0),
                  species = c("setosa", "setosa", "versicolor",
                              "versicolor", "virginica", "virginica"))
dat

dat[dat$sepal_length > 5 & dat$sepal_width >= 3.5, "species"] <- "virginica"

dat
head(dat, 3)

#頂辨 檜橫憮
x <- c(1, 2, 3) #漱攪煎 啗骯
sum(x)

sum(1, 2, 3) #蝶蠔塭煎紫 啗骯 陛棟

sum(x, na.rm = FALSE)

z <- c(1, 2, 3, NA)
sum(z)
sum(z, na.rm = TRUE)

x <- c(1, 1, 2, 2, 3)
mean(x)

mean(x, trim = 0.2) #5 * 0.2虜躑 曄 部縑憮 薯剪
mean(x, trim = 0.4)

max(x)
min(x)

max("錳綴", "彰營")
max("20100301", "20100302", "20100303")

x <- c(3, 6, 1, 2, 10, 4)
x = rnorm(10000)
x

which.max(x)
which.min(x)

A <- data.frame(name = c("Park", "Kim", "Choi", "Jung"),
                age = c(40, 30, 10, 20))

max(A$age)
A[which.max(A$age), ]

x <- c(1, 6, 2, 3, 10, 8)
sort(x, decreasing = TRUE)

order(x)

x[order(x)]
x[order(x, decreasing = TRUE)]

A
A[order(A$age), ]

length(x)WS

x <- list(c(1, 2), c(2, 3))
x

length(x)S

X <- matrix(c(1, 2, 3, 4, 5, 6), 2)
ncol(X)
nrow(X)

data(iris)
head(iris, n = 1)
tail(iris, n = 10)
