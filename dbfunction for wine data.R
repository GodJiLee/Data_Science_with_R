#과제 ===============================================================================
red_wine_avg = dbGetQuery(conn,
                          "SELECT 
                           r.quality,
                           AVG(fixed_acidity) AS mean_fixed_acidity,
                           AVG(density) AS mean_density
                           FROM red_wine AS r
                           GROUP BY
                           quality")

white_wine_avg = dbGetQuery(conn, 
                            "SELECT
                            w.quality,
                            AVG(fixed_acidity) AS mean_fixed_acidity,
                            AVG(density) AS mean_density
                            FROM white_wine AS w
                            GROUP BY
                            quality")

dbBegin(conn)
dbWriteTable(conn, "white_wine_avg", white_wine_avg,
             append = TRUE, row.names = FALSE)

dbWriteTable(conn, "red_wine_avg", red_wine_avg, 
             append = TRUE, row.names = FALSE)

white_wine_avg_plus = dbGetQuery(conn,
                                 "SELECT *,
                                 'white' AS class
                                 FROM white_wine_avg")

red_wine_avg_plus = dbGetQuery(conn,
                               "SELECT *,
                               'red' AS class
                               FROM red_wine_avg")


dbWriteTable(conn, "이지원", white_wine_avg_plus, 
             append = TRUE, row.names = FALSE)

dbWriteTable(conn, "이지원", red_wine_avg_plus,
             append = TRUE, row.names = FALSE)

dbGetQuery(conn, "SELECT * FROM 이지원")

dbRollback(conn)
dbGetQuery(conn, "SELECT * FROM 이지원")

dbCommit(conn)
