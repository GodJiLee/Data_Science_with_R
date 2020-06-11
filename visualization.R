install.packages("ggplot2")
require(ggplot2)

#ggplot2 패키지로 시각화
data(iris)
ggplot(data = iris, 
       mapping = aes(x = Sepal.Length,
                     y = Sepal.Width)) +
  geom_point() +
  geom_point(data = iris, 
             mapping = aes(x = Petal.Length,
                           y = Petal.Width))

# R 내장 함수 plot, point 로 시각화
with(iris, plot(Sepal.Length, Sepal.Width))
with(iris, points(Petal.Length, Petal.Width))

# 점 색 지정
ggplot(data = iris, 
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = "red")) +
  geom_point()

ggplot(data = iris,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species)) + 
  geom_point()

# 점 모양 지정
ggplot(iris, aes(x = Petal.Length, y = Petal.Width,
                 color = Species)) + 
  geom_point(size = 5, alpha = 0.5, shape = "triangle")

ggplot(iris, aes(x = Petal.Length, y = Petal.Width, 
                 color = Species)) + 
  geom_point(size = 5, alpha = 0.5, shape = 11)

# 그룹별 시각화
require(dplyr)
iris_s = iris %>% 
  group_by(Species) %>% 
  summarise_all(.funs = mean)

ggplot(data = iris_s, 
       aes(Sepal.Length, Sepal.Width,
           color = Species, 
           size = Sepal.Width)) +
  geom_point()

# ggplot2의 facet_grid로 분할
ggplot(data = iris_s, 
       aes(Sepal.Length, Sepal.Width,
           color = Species)) + 
  geom_point(size = iris_s$Sepal.Width)

ggplot(iris, aes(x = Petal.Length,
                 y = Petal.Width,
                 color = Species)) + 
  geom_point(size = 5, alpha = 0.5, 
             shape = "triangle") +
  facet_grid(~ Species)

#mfrow로 분할 
with(iris,
     plot(Petal.Length, Petal.Width, col = Species))

with(iris, 
     plot(Petal.Length, Petal.Width,
          col = Species, pch = 11))

iris_group = by(iris, INDICES = iris$Species,
                function(x) x)
par(mfrow = c(1, 3))

for (i in 1:length(iris_group)) {
  with(iris_group[[i]],
       plot(Petal.Length, Petal.Width,
            col = i, 
            xlim = c(0, 8), ylim = c(0, 10)))
}

# 축 이름, 그래프 이름 지정
ggplot(iris, 
       aes(x = Petal.Length, y = Petal.Width,
           color = Species)) +
  geom_point(size = 5, alpha = 0.5) +
  xlab("Length") + ylab("Width") +
  ggtitle("IRIS")

# 이산형 변수의 범례 수정
ggplot(iris,
       aes(x = Petal.Length, y = Petal.Width,
           color = Species)) +
  geom_point(size = 5, alpha = 0.5) +
  scale_color_discrete(name = "A",
                       labels = c("a", "b", "c"))

ggplot(iris,
       aes(x = Petal.Length, y = Petal.Width,
           color = Species)) +
  geom_point(size = 5, alpha = 0.5) +
  scale_color_manual(name = "A",
                     values = c("green", "blue", "red"), #색 변경도 가능
                     labels = c("a", "b", "c")) #범례 수정

# 연속형 변수의 범례 수정
ggplot(iris,
       aes(x = Petal.Length, y = Petal.Width,
           color = Sepal.Width)) + 
  geom_point(size = 5, alpha = 0.5) +
  scale_color_continuous(name = "A")

ggplot(iris,
       aes(x = Petal.Length, y = Petal.Width,
           color = Sepal.Width)) +
  geom_point(size = 5, alpha = 0.5) +
  scale_color_gradient(low = "blue", high = "red",
                        breaks = c(3, 4))


# 색상표
ggplot(iris,
       aes(x = Petal.Length, y = Petal.Width,
           color = Species)) +
  geom_point(size = 5, alpha = 0.5) +
  scale_color_manual(name = "A",
                     values = c("#FF6C90", "#00C0B8", "#00ABFD"),
                     labels = c("a", "b", "c"))

# 선 그래프 시각화
data(economics)
ggplot(economics, aes(date, unemploy)) +
  geom_line(size = 2, color = "red", alpha = 0.5)

# 그룹별 선그래프 시각화
require(reshape2)

economics_l = melt(economics, id.vars = "date", 
                   measure.vars = 2:6)

ggplot(economics_l,# 데이터는 하나만 필요로 함
       aes(date, value, 
           color = variable)) +
  geom_line(size = 2) + 
  scale_color_discrete(name = "Type")

# plot함수로 선그래프 그리기 
par(mfrow = c(1, 1)) # 형상 초기화

plot(economics$date, economics$pce,
     type = "l", ylim = c(0, 3e+5))

lines(economics$date, economics$unemploy, 
      col = "red")
lines(economics$date, economics$pop, 
      col = "blue")

# 막대함수 시각화
data(diamonds)
diamonds

ggplot(diamonds, aes(x = cut)) + 
  geom_bar()

ggplot(diamonds, aes(x = cut, 
                     fill = cut, 
                     color = "red")) + 
  geom_bar() + 
  scale_color_discrete(guide = FALSE) # 범례 숨기기


# 막대가 나타내는 값
iris_m = iris_s %>% melt(., id.vars = "Species",
                         measure.var = 2:5)
ggplot(iris_m, aes(x = variable, y = value, 
                   fill = variable)) + 
  geom_bar(stat = "identity")

ggplot(iris_m, aes(x = Species, y = value, 
                   fill = variable)) +
  geom_bar(stat = "identity", position = "dodge") # 옆으로 쌓는 막대

# 히스토그램 시각화
ggplot(iris, aes(Sepal.Width, 
                 fill = Species)) +
  geom_histogram(position = "dodge", alpha = 0.5)


ggplot(iris, aes(Sepal.Width, fill = Species)) +
  geom_histogram(position = "identity", alpha = 0.5)

# 상자 그래프 시각화
ggplot(iris, aes(x = Sepal.Width, fill = Species)) +
  geom_boxplot()

ggplot(iris, aes(y = Sepal.Width, fill = Species)) +
  geom_boxplot()