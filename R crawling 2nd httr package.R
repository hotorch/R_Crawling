
# GET --------------------------------------------------------------------

# read_html은 제일 쉬운 방법
# GET, POST를 알아야함(모두 대문자인거 유의)
# httr 패키지는 http 표준 요청을 수행해 준다.
# wiki에서 HTTP 요약표 부분 참고. 함수대로 제공을 해준다.
library(dplyr)
library(rvest)
library(httr)

tar <- "https://news.naver.com/main/home.nhn"
read_html(tar)

GET(tar) # 요청한 이력들이 나타난다. 일부만 보여준다.

GET(tar) %>% content() # read_html(tar)와 매우 유사하다.
# identical(read_html(tar), GET(tar) %>% content()) # 코드들이 완전히 똑같지는 않은 듯? 

GET("http://httpbin.org")
GET("http://httpbin.org") %>% content()

# `User-Agent` 한번 바꿔보자 
# 서버 사이트에서 agent 정보를 바탕으로 
# 어떤 브라우저로 왔는지 판단을 하게 되는데 
# 나의 브라우저 정보를 서버에 응답하는 행위
# 이러한 일을 반복하게 되면 한 곳에서 데이터를 긁는 행위를 흐리게 한다고 한다 
GET("http://httpbin.org/get") %>% content()
ah <- httr::add_headers("User-Agent" = "heuingttiAng's test")
GET("http://httpbin.org/get", ah) %>% content() # user agent가 변경됨을 알 수 있다. 

# 정리하면 header, cookie 등 다양한 옵션을 GET함수를 이용해 활용 할 수 있고 
# 크롤러가 아니라고 속일 수 있는 효과도 있다 

GET("http://httpbin.org/get", ah) %>% headers 


# POST --------------------------------------------------------------------
# body에 사용자가 필요한 값을 추가해서 요청을 할 수 있는 방법

# body --------------------------------------------------------------------
# list() 자료형으로 되어 있고 이름이 있는 데이터로 만든 요청에 추가할 수 있는 값

# content -----------------------------------------------------------------
# httr 패키지의 요청들은 read_html() 함수와 달리 
# header 나 cookie 등의 모든 정보를 다 확인할 수 있음. 
# 그래서 응답으로 서버가 데이터로써 준 내용을 
# 확인하기 위해서 content() 함수를 제공함.

# 네이버 뉴스 최신순 댓글 추출 -----------------------------------------------------------
# 개발자 도구 network탭의 headers 정보를 보면
# response(우리에게 돌려준 것), request(우리가 보낸것) headers를 볼 수 있다. 
# head축은 메타 정보, body는 정말로 실제로 보기 위한 정보 
# 네트워크 탭에서 최신순 버튼 실시간 정보를 볼 수 있다. 

tar1 <- "https://apis.naver.com/commentBox/cbox/web_naver_list_jsonp.json?ticket=news&templateId=view_it&pool=cbox5&_callback=jQuery1124010266161325440293_1565855949664&lang=ko&country=KR&objectId=news018%2C0004445831&categoryId=&pageSize=10&indexSize=10&groupId=&listType=OBJECT&pageType=more&page=1&refresh=true&sort=new&includeAllStatus=true&_=1565855949667"
GET(tar1)
GET(tar1) %>% content
temp <- GET(tar1) %>% content %>% rawToChar() # 한글 깨짐 
Encoding(temp)
Encoding(temp) <- 'UTF-8'
temp # 잘못된 접근이라고 한다 ㅠㅠ 

# request의 referer를 참조하자. 
ah<- add_headers("referer" = "https://news.naver.com/main/ranking/read.nhn?mid=etc&sid1=111&rankingType=popular_day&oid=018&aid=0004445831&date=20190815&type=1&rankingSeq=2&rankingSectionId=105")

GET(tar1, ah)
GET(tar1, ah) %>% content()
GET(tar1, ah) %>% content() %>% rawToChar()
temp2 <- GET(tar1, ah) %>% content() %>% rawToChar()
Encoding(temp2) <- 'UTF-8'
temp2 # json 형태라서 긁으려면 조금 더 살펴 봐야 할 것 같다. 

