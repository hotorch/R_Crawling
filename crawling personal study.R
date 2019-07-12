library(rvest)
library(dplyr)

# R crawling --------------------------------------------------------------

### rvest는 node, html, attr 3가지만 기억하면 된다. 
# node는 html에서 tag라고 생각하면 편하다.
# html은 xml양식으로 작성된 웹 브라우저들이 이해하는 표준문서
# attr은 attribute 줄임으로 아래 예시로 tag의 attr1은 example1이다.
# example) <tag attr1="example1" attr2="example2"> 안녕하세요 </tag>

# 원하는 글자가 있는 노드를 지정하기 위해서 css 선택자를 공부해야한다.
# http://www.nextree.co.kr/p8468/ 참고하자

### rvest의 동작 순서(text 가져오기)
# 1. html 문서 데이터 가져오기
# 2. 필요한 노드 선택하기
# 3. 노드내에 text를 가져오기
# read_html(url) %>% html_nodes("tag.class") %>% html_text()

#### rvest는 html 문서로 되어 있는 웹에서의 텍스트 데이터를 가져와서 처리하는 패키지 
### rvest의 동작순서(attr 가져오기)
# 1. html 문서 데이터 가져오기
# 2. 필요한 노드 선택하기
# 3. 노드내에 attr중에 "attr1" 값을 가져오기
# read_html(url) %>% html_nodes("tag.class") %>% html_attr("attr1")

### 실습 네이버 뉴스
## 제목, 내용 텍스트로 추출하기
url <- "https://news.naver.com/main/ranking/read.nhn?mid=etc&sid1=111&rankingType=popular_day&oid=001&aid=0010942559&date=20190710&type=1&rankingSeq=1&rankingSectionId=104"

read_html(url)
read_html(url) %>% html_nodes("h3") # h3 붙어있는게 무엇이 있는지 확인해 봅니다
read_html(url) %>% html_nodes("h3[id = 'articleTitle']")
read_html(url) %>% html_nodes("h3#articleTitle") # css 선택자 노드를 선택하기 위한 것 중에 #id는 아주 많이 쓰이는 편
read_html(url) %>% html_nodes("h3#articleTitle") %>% html_text()

read_html(url) %>% html_nodes("div") 
read_html(url) %>% html_nodes("div[id = 'articleBodyContents']")
read_html(url) %>% html_nodes("div#articleBodyContents")
read_html(url) %>% html_nodes("div#articleBodyContents") %>% html_text() # 내용 뽑기


## attr 추출해보기
tar <- "https://news.naver.com/main/main.nhn?mode=LSD&mid=shm&sid1=100"
read_html(tar) %>% html_nodes("a[href^='https']") # 속성 선택자를 보면서 공부를 해야함니다
read_html(tar) %>% html_nodes("a[href^='https']") %>% html_attr("href") # href 속성들 다 뽑아 옵니다.
# 반복문을 통해서 제목이나 내용을 뽑을 수 있을 것이다. 


# httr package ------------------------------------------------------------
# install.packages("httr")
library(httr)
## GET, POST
# read_html함수는 get함수와 비슷
# httr패키지는 http 표준 요청을 수행해 준다. curl보다 조금 더 직관적임
# curl 패키지는 C로 작성된 조금 더 low한 패키지.
# get 요청: 서버 응답 전체까지 끌고 온다고 한다
# 더 불편한데 왜 써요? -> header, cookie 등 다양한 옵션을 사용할 수 있다(예를 들면 크롤러가 아니라고 속이거나)
url <- "https://sports.news.naver.com/esports/news/read.nhn?oid=236&aid=0000192047"
GET(url)
GET(url) %>% content # read_html과 결과가 같다.

## POST
# body에 사용자가 필요한 값을 추가해서 요청을 할 수 있는 방법
POST()

# Extraction small size image ---------------------------------------------

keyword ="bee teemo"

url <- "https://www.google.co.kr/search?q=bee%20teemo&hl=ko&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjXipyZ8JzeAhWJabwKHXBKCi8Q_AUIDygC&biw=1229&bih=540"

read_html(url) %>% html_nodes("img") # 하이퍼링크 전부 a태그를 달고 있음
read_html(url) %>% html_nodes("a img") %>% html_attr("src")
# 부모 - 자식 노드 관점으로 a태그보다 상위 태그 먼저 작성이 가능 dt
# "dt a"
read_html(url) %>% html_nodes("div div div div a") %>% length()
read_html(url) %>% html_nodes("div div div div a img") %>% length()

# page <- read_html(url, encoding ="CP949")
# page

links <- read_html(url) %>% html_nodes("a img") %>% html_attr("src")
links

html_nodes(page, "img")
html_nodes(page, "img") %>% html_attr("src")

k=0
for (lk in links) {
  k=k+1
  download.file(lk, destfile =paste0("./", k, ".png"), mode = 'wb')
}

# single Test
download.file("https://i.ytimg.com/vi/cheFXtAyntY/maxresdefault.jpg", destfile =paste0("./", k, ".png"), mode = 'wb')

