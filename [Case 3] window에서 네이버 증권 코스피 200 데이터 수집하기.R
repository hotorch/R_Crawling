
# 네이버 증권 : 코스피200 데이터 수집하기(window 사용자)  -----------------------------------------------

# Load Packages
library(dplyr)
library(httr)
library(rvest)


# 네이버 증권 > 국내증시 > 코스피로 이동
# 그 상태에서의 웹 브라우저 주소창의 URL을 이용
res <- GET(url = 'https://finance.naver.com/sise/sise_index.nhn',
           query = list(code = 'KPI200')) # charset = EUC-KR 임


## charset이 'EUC-KR'이므로 read_html() 함수의 encoding 인자에 인코딩 방식을 지정
# 잠시 변경해주기 
Sys.setlocale(category = 'LC_ALL', locale = 'C')

# 긁을 부분 긁기
res %>% 
  read_html(encoding = 'EUC-KR') %>% 
  html_node(css = 'div.subtop_sise_detail > table') %>% 
  html_table() -> temp_table

# 로케일 원상복귀 시키기 
Sys.setlocale(category = 'LC_ALL', locale = 'korean')

temp_table # 홀수행만 남기고, 열 이름 변경은 따로 전처리를 해주어야함 

