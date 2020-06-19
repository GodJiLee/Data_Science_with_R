# MySQL
install.packages("RMySQL")
library(RMySQL)
conn = dbConnect(dbDriver("MySQL"),
                 user = "root",
                 password = "uosstat1",
                 host = 'localhost',
                 dbname = "test") 

# 오라클
install.packages("ROracle")
library(ROracle)
conn = dbConnect(dbDriver("Oracle"), 
                 username = "uid",
                 password = "pwd",
                 dbname = "host::port/service_name")

# 쿼리 보내고 데이터 가져오고 지우는 과정 
qq = dbSendQuery(conn, 
                 "SELECT
                 table_name
                 FROM information schema.tables
                 WHERE table schema = 'test'")
dbFetch(qq, -1)
dbClearResult(qq)

#dbSendQuery, dbFetch, dbClearResult를 동시에 처리 가능
dbGetQuery(conn,
           "SELECT * FROM iris")

#SQLite
install.packages("RSQLite")
library(RSQLite)
conn = dbConnect(dbDriver("SQLite"),
                 dbname = "C:\\Users\\leejiwon\\Desktop\\test (1)\\test.sqlite")

# 원하는 데이터 추출
dbGetQuery(conn, "SELECT * from iris")
dbGetQuery(conn, "SELECT 
                  Sepal_Length,
                  Sepal_Width
                  FROM  iris")

dbGetQuery(conn, "SELECT * FROM iris")

# 조건을 만족하는 행만 추출 
dbGetQuery(conn, "SELECT * 
                  FROM iris
                  WHERE Sepal_Length > 6")
dbGetQuery(conn, "SELECT * 
                  FROM iris 
                  WHERE Sepal_Length BETWEEN 6 AND 8")
dbGetQuery(conn, "SELECT *
                  FROM iris
                  WHERE Sepal_Length > 6
                  AND Sepal_Width > 3")

# R의 head() 기능
dbGetQuery(conn, 
           "SELECT * 
           FROM facebook1
           LIMIT 10")

# 테이블 결합 
dbGetQuery(conn,
           "SELECT a.*,
                   b.*
           FROM facebook1 AS a
           INNER JOIN facebook2 AS b
           ON a.post_date = b.post_date
           AND a.post_hour = b.post_hour
           AND a.post_minute = b.post_minute")

# 결합할 행이 unique할 떄는 JOIN 대신 WHERE로 결합 가능
dbGetQuery(conn,
           "SELECT a.*,
                   b.*
           FROM facebook1 AS a,
                facebook2 AS b
           WHERE a.post_date = b.post_date")

# Left Join, Right Join
# 왼쪽 테이블의 값만 유지
dbGetQuery(conn,
           "SELECT a.*,
                   b.*
           FROM facebook1 AS a
           LEFT JOIN facebook2 AS b
           ON a.post_date = b.post_date
           AND a.post_hour = b.post_hour
           AND a.post_minute = b.post_minute")

# RIGHT JOIN은 테이블 순서만 바꿔주면 됨
dbGetQuery(conn,
           "SELECT a.comment, like, share,
                   b.*
           FROM facebook2 AS a
           LEFT JOIN facebook1 AS b
           ON a.post_date = b.post_date
           AND a.post_hour = b.post_hour
           AND a.post_minute = b.post_minute")

# FULL JOIN은 LEFT/ RIGHT JOIN을 UNION으로 묶어주면 됨
dbGetQuery(conn, 
           "SELECT a.*,
                   b.*
           FROM facebook1 AS a
           LEFT JOIN facebook2 AS b
           ON a.post_date = b.post_date
           AND a.post_hour = b.post_hour
           AND a.post_minute = b.post_minute
           UNION
           SELECT b.*,
                  a.*
           FROM facebook2 AS a
           LEFT JOIN facebook1 AS b
           ON a.post_date = b.post_date
           AND a.post_hour = b.post_hour
           AND a.post_minute = b.post_minute
           ")

# ORDER BY
dbGetQuery(conn, 
           "SELECT a.post_date, 
                   a.post_hour,
                   b.like
           FROM facebook1 AS a
           LEFT JOIN facebook2 AS b
           ON a.post_date = b.post_date
           AND a.post_hour = b.post_hour
           AND a.post_minute = b.post_minute
           ORDER BY
           b.like")

#GROUP BY
dbGetQuery(conn, 
           "SELECT a.type,
                   a.category,
                  SUM(b.like) AS sum_like,
                  COUNT(a.type) AS n_type
                  FROM facebook1 AS a
                  LEFT JOIN facebook2 AS b
                  ON a.post_date = b.post_date
                  AND a.post_hour = b.post_hour
                  AND a.post_minute = b.post_minute
                  GROUP BY
                  a.type,
                  a.category")

# INSERT INTO 
res = dbGetQuery(conn,
                 "SELECT
                 AVG(sepal_length) AS Sepal_Length,
                 AVG(sepal_width) AS Sepal_Width,
                 AVG(petal_length) AS Petal_Length,
                 AVG(petal_width) aS Petal_Width,
                 species
                 FROM iris
                 GROUP BY
                 species")

res$Species = paste("'", res$Species, "'", sep = "")


insert_fun = function(data) {
  value = apply(data, 1, function(x) {
    paste0("(", paste(x, collapse = ","), ")")
    })
  res = paste(value, collapse = ",")
  return (res)
}
res = dbGetQuery(conn,
                 "SELECT
                 AVG(sepal_length) AS Sepal_Length,
                 AVG(sepal_width) AS Sepal_Width,
                 AVG(petal_length) AS Petal_Length,
                 AVG(petal_width) aS Petal_Width,
                 species
                 FROM iris
                 GROUP BY
                 species")

res$Species = paste("'", res$Species, "'", sep = "")


insert_fun = function(data) {
  value = apply(data, 1, function(x) {
    paste0("(", paste(x, collapse = ","), ")")
    })
  res = paste(value, collapse = ",")
  return (res)
}

# ROLLBACK 정의
dbBegin(conn)
ss = dbSendQuery(conn,
                 paste("INSERT INTO iris VALUES",
                       insert_fun(res)))

dbClearResult(ss)
dbGetQuery(conn, "SELECT * FROM iris")
dbCommit(conn)
dbRollback(conn)
dbGetQuery(conn, "SELECT * FROM iris")

# dbWrite
dbBegin(conn)
dbWriteTable(conn, "iris", res, 
             append = TRUE, row.names = FALSE)
dbWriteTable(conn, "iris", res, 
             overwrite = TRUE, row.names = FALSE)

dbGetQuery(conn, "SELECT * FROM iris")
dbRollback(conn)
dbGetQuery(conn, "SELECT * FROM iris")
