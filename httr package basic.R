library(httr)
library(dplyr)


# normal status case ------------------------------------------------------

res <- GET(url = 'https://www.naver.com')

status_code(x = res) # 2xx : normal status

# so dirty
content(x = res, as = 'text', encoding = 'UTF-8')

# tree structure
res %>% content(as = 'text', encoding = 'UTF-8') %>% cat()


# abnormal status case ----------------------------------------------------

res <- GET(url = 'https://land.naver.com/article/divisionInfo.nhn', 
           query = list(cortarNo = '1168000000', 
                        rletTypeCd = 'A01',
                        hscpTypeCd = 'A01%3AA03%3AA04'))

status_code(x = res) # 4ㅌㅌ : forbidden case
