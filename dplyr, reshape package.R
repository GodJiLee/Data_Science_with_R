install.packages("dplyr")
library(dplyr)

x = c(1, -1, 2, -2, 3, -3)
mean(abs(x))

x_tmp = abs(x)
mean(x_tmp)

#Pipe Operator (Shift + Ctrl + M)
x %>% abs() %>% mean()

#Filter 함수
colnames(iris) <- tolower(colnames(iris))
iris %>% filter(sepal.length > 5.5 & petal.length < 6) %>% head()
#iris %>% filter(., sepal.length >5.5, petal.length < 6)

#Select문
#iris[, -c("sepal.length", "sepal.width")] #Error
iris[, -c(1, 3)]
iris %>% select(-c(sepal.length, sepal.width)) #column name으로 적용 가능

#Index만으로 특정 열을 제외하기 
iris[, !(colnames(iris) %in% c("sepal.length", "sepal.width"))]
iris[, -which(colnames(iris) %in% c("sepal.length", "sepal.width"))]

#Subset
subset(iris, 
       subset = sepal.length > 5.5 & sepal.width < 3, #순차적 
       select = c(sepal.length, sepal.width, species)) #실행

#Pipe operator error
#iris %>% 
  #select(petal.length, petal.width, species) %>% 
  #filter(sepal.length > 5.5 & sepal.width < 3)

#mutate 함수 
iris3 = iris %>% transform(length_sum = sum(sepal.length + petal.length)) %>% head()
iris3

iris4 = iris %>% mutate(length_sum = sum(sepal.length + petal.length)) %>% head()
iris4

iris5 = iris %>% mutate(length_mean = mean(sepal.length + petal.length)) %>% head()
iris5

iris5$length_sums = sum(iris$sepal.length + iris$petal.length)

iris %>% mutate(legnth_sum = sum(sepal.length + petal.length), 
                log_length = log(length_sum))

#summarise
iris %>% summarise(iris_mean = mean(sepal.length + petal.length))

#arrange 함수
iris %>% arrange(sepal.length)
iris %>% arrange(sepal.length, sepal.width)
iris %>% arrange(sepal.length, desc(sepal.width))

#R 내장함수 order로 정렬
iris[order(iris$sepal.length, iris$sepal.width, decreasing = c(F, F)), ]

#group_by함수
iris %>% group_by(species) %>% mutate(iris_length = mean(sepal.length + petal.length)) %>% head(100)
iris %>% group_by(species) %>% summarise(mean1 = mean(sepal.length),
                                         mean2 = mean(petal.length))

rm(iris)
colnames(iris) = tolower(colnames(iris))
iris

#reshape2 패키지 
#melt함수
install.packages("reshape2")
library(reshape2)
melt(iris, id.vars = "species", measure.vars = c("sepal.length", "sepal.width"))

#cast함수
iris_melt = melt(iris, id.vars = "species", measure.vars = c("sepal.length", "sepal.width", "petal.length", "petal.width"))
iris_melt
dcast(iris_melt, species ~ variable, fun.aggregate = mean)
iris_melt %>% group_by(species, variable) %>% summarise(mean = mean(value))

k = length(unique(iris_melt$variable))
iris_melt$id = rep(1:(nrow(iris_melt) / k ), k)
tail(iris_melt)
temp <- dcast(iris_melt, formula = id + species ~ variable, value.var = "value", fun.aggregate = )
temp %>% select(-id)

#과제 
data("airquality")
airquality_new <- airquality %>% 
  mutate(windchill = 35.74 + 0.6215 * airquality$Temp - 35.75 * (airquality$Wind)^0.16 + 
           0.4275 * airquality$Temp * (airquality $ Wind)^0.16)

sum(is.na(airquality_new))
mean(is.na(airquality_new))
mean(!complete.cases(airquality_new))

library(mice)
result <- md.pattern(airquality_new)

mice_result <- mice(airquality_new, seed = 1234, m = 5)
mice_result$imp$Ozone

complete_data <- complete(mice_result, 1)
complete_data %>% group_by(Month) %>% summarise(m_Ozone = mean(Ozone),
                                                 m_Solar.R = mean(Solar.R), 
                                                 m_Wind = mean(Wind), 
                                                 m_Temp = mean(Temp),
                                                 m_windchill = mean(windchill))
