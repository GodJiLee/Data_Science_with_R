library(dplyr)
setwd("C:\\Users\\leejiwon\\Desktop\\11._data (1)\\wine quality")
redquality <- read.table("winequality-red.csv", header = TRUE, sep = ";")
whitequality <- read.table("winequality-white.csv", header = TRUE, sep = ";")

#redwine과 whitewine 데이터를 결합
wholequality <- rbind(redquality, whitequality)
head(wholequality)
tail(wholequality$group)

#와인 종류를 group변수에 명시
for (i in 1: nrow(wholequality)) {
  wholequality$group[i] <- ifelse(as.integer(rownames(wholequality[i, ])) > nrow(redquality), "white", "red")
}

#연속형 변수에 대해 적당한 범주로 나눔
wholequality$acid = cut(wholequality$fixed.acidity , c(0, 5, 10, Inf), 
                        right = F, 
                        labels = c("약산성", "중간산성", "강산성"))

wholequality$proof = cut(wholequality$alcohol, c(0, 10, 13, Inf),
                         right = F,
                         labels = c("낮은도수", "보통도수", "높은도수"))

wholequality$dense = cut(wholequality$density, c(0, 0.99, 0.995, Inf), 
                         right = F,
                         labels = c("낮은밀도", "보통밀도", "높은밀도"))

table(wholequality$dense)
head(wholequality)



#산성, 도수, 밀도별 와인의 퀄리티 계산
grouped_mean = function(data, ...){
  res = data %>% 
    group_by(...) %>% 
    summarise(mean_qulity = mean(quality))
  return(res)
}

grouped_mean(wholequality, group)
grouped_mean(wholequality, proof)
grouped_mean(wholequality, dense)
grouped_mean(wholequality, acid)

#두 기준에 따른 와인의 퀄리티 계산
proof_vs_dense_mean = wholequality %>% reshape2::dcast(., group ~ dense, 
                                             value.var = "quality", 
                                             fun.aggregate = mean, 
                                             na.rm = TRUE)

#각 범주에 포함된 데이터의 수
table(wholequality$acid)
table(wholequality$proof)
table(wholequality$group)
table(wholequality$dense)