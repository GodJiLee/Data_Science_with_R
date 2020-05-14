#Set working directory 
setwd("C:/Users/leejiwon/Desktop/기초프로그래밍 9주차/9._read_and_write_data")
getwd()

#Read txt file
txt_data1 <- read.table("txt/text data1.txt", header = TRUE)
txt_data1

txt_data1 <- read.table("txt/text data1.txt", header = TRUE, sep = ",")

txt_data2 <- read.table("txt/text data2.txt", header = TRUE, sep = "\t") #Tab키로 구분
txt_data2

txt_data3 <- read.table("txt/text data3.txt", header = TRUE, sep = " ") #default값
txt_data3

txt_data4 <- read.table("txt/text data4.txt", header = TRUE, sep = "", skip = 1) #첫 줄 + 공백 건너띄워서 읽기
txt_data4

#Read csv file
csv_data <- read.csv("csv/csv data.csv", header = TRUE) #실제 Exel 데이터는 아님
csv_data

#Read Excel file
install.packages("readxl")
require(readxl)

xlsx_data = read_xlsx("xlsx/xlsx_data.xlsx")
xlsx_data #tibble로 읽힘 
xlsx_data1 <- as.data.frame(xlsx_data)
str(xlsx_data1)

xlsx_data2 <- read_xlsx("xlsx/xlsx_data.xlsx", sheet = 2) #두 번째 시트를 읽을 것
xlsx_data2
xlsx_data3 <- as.data.frame(xlsx_data2)
class(xlsx_data3)
class(xlsx_data2)

install.packages("haven")
require(haven)
sas_data <- read_sas("sas/sas_data.sas7bdat")
sas_data
sas_data1 <- as.data.frame(sas_data)
class(sas_data1)

#Read URL 
url = "http://www.stats.ox.ac.uk/pub/datasets/csb/ch11b.dat"
url_data <- read.table(url)
head(url_data)

url2 <- "http://sakai.unc.edu/access/content/group/3d1eb92e-7848-4f55-90c3-7c72a54e7e43/public/data/bycatch.csv"
url_data2 <- read.csv(url, header = TRUE)
head(url_data2)

#Crolling and Scraping 
install.packages(c("XML", "httr"))
require(XML)
require(httr)

url <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
r = GET(url)
r

cont <- content(r, "text") #response 객체를 R에서 다룰 수 있는 text 객체로 변환
cont

doc <- readHTMLTable(doc = cont, header = TRUE) #페이지에서 테이블만 읽어오기
head(doc[[1]])
head(doc)

#Read RData
load("Rdata/rdata.RData")
rdata_data #전역변수로 자동 저장됨

#fread()함수
install.packages("data.table")
require(data.table)

txt_data = fread("txt/text data1.txt")
txt_data

#Write Data to csv file 
csv_data$age[1] <- 28 #변경작업
write.csv(csv_data, file = "./csv/csv_data2.csv") #csv_data2로 저장
read.csv("./csv/csv_data2.csv")

#Write Data to RData
rdata_data <- csv_data
x = 1:10
y = 10:1
save(rdata_data, x, file = "./Rdata/rdata2.RData")
save.image(file = "./Rdata/rdata3.RData")
rm(list = ls()) #remove
load("./Rdata/rdata2.RData")
ls()  

#Example
file_list <- list.files("./temp")
file_list  

data_list <- vector(mode = "list", length = length(file_list))  
for (i in 1:length(file_list)) {
  data_list[[i]] = read.csv(paste("./temp", file_list[i], sep = "/"))
}  

data_list

names(data_list) = file_list  
data_list  
str(data_list)