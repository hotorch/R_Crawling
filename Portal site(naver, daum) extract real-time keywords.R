
# 실시간 검색어 뽑아보기 ------------------------------------------------------------


# Load Library ------------------------------------------------------------
library(rvest)
library(httr)
library(dplyr)


# naver 실시간 검색어 추출하기 ------------------------------------------------------


# HTTP 요청
res <- GET(url = 'https://www.naver.com')

# HTTP 응답 상태코드를 확인, 2xx 잘 붙은 것으로 확인.
status_code(res) 

# res 객체에 포함된 HTML을 텍스트로 출력하기위해 content() 적용
# 계층 구조로 출력하기 위해 cat() 함수 적용
res %>% content(as = 'text', encoding = 'UTF-8') %>% cat() 

# HTTP 응답 객체에서 HTML을 읽기
html <- read_html(x = res)

# HTML에서 CSS Selector로 필요한 HTML 요소만 선택
span <- html_nodes(x = html,
                   css = 'div.ah_roll_area > ul > li > a > span.ah_k') # 끝에서 부터 역순으로 가져 오면 됩니다.
# css selector를 조금 공부하는 것이 좋습니다. (.은 class, #은 id , > 는 부모/자식 관계 )

html_nodes(x = html,
           css = 'span.ah_k') %>% html_text() # 2번 출력됨을 알 수 있음. 중복되는 결과가 나오게 되어있는 구조 

html_nodes(x = html,
           css = 'div.ah_roll_area > ul > li > a > span.ah_k') %>% html_text() 
# div.ah_roll_area 까지 올라가니까 1번 까지 나타남.

# 실시간 검색어만 추출합니다.
issues <- html_text(x = span, trim = TRUE)

# 최종 결과를 출력하여 확인합니다. 
print(issues)


# 한번에 짜는 코드
res %>% 
  read_html() %>% 
  html_nodes(css = 'div.ah_roll_area > ul > li > a > span.ah_k') %>% 
  html_text(trim = TRUE)

# Daum 실시간 검색어 추출 ---------------------------------------------------------

res1 <- GET(url = "www.daum.net")
print(res1) # 잘 호출 되었음을 알 수 있음

res1 %>% 
  read_html() %>% 
  html_nodes(css = 'div.realtime_part > ol.list_hotissue > li > div.roll_txt > div:nth-child(1) > span.txt_issue > a') %>% 
  html_text(trim = TRUE) # 중복되지 않을 때 까지 계속 상위 단계까지 올라가기
# div:nth-child(?) : div class = 'roll_txt' 자식 노드에서 div태그 여러개 있는데 그 중 ?번째 태그를 이용하겠다는 뜻.
