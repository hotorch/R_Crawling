
# R crawling --------------------------------------------------------------

# 자주 쓰이는 패키지 
# 요청 : curl, httr, rvest, Rselenium
# 정리 : regexpr, jsonlite, rvest
# 저장 : write.*()
# 반복 : for, parallel
# 예외처리 : try, if
# 최적화 : profvis, microbenchmark


# 기초적 용어 정리 ---------------------------------------------------------------

# 웹서버 : 외부에서 요청하면 규칙대로 정보를 제공하는 것 
# 브라우저 : 서버가 주는 것들을 사용자에게 보여주는 것
# 웹서버 -> 우리에게 : text(html, css, js, etc), img 브라우저가 약속된 모양으로 우리에게 전달
# html : xml양식으로 작성된 웹 브라우저들이 이해하는 표준 문서
# chrome F12 개발자 도구를 이용
# wep api : wep으로 제공되는 application programming interface 함수, 외부 서버에서 동작하여 웹 기술로 결과 전달
# 우리가 필요한 것 : text(html)중 일부만(title이나 contents)


# 방법론 ----------------------------------------------------------------------

# 많이 쓰이고 어려운 방법 : stringr & 정규표현식
# 제일 쉬운 방법 : xml의 node를 다루는 패키지 rvest
# rvest는 node, attr, text만 기억 하면 된다. 
# node : html에서 tag라고 불리는 편
# attr : attribute의 줄임말. 예시로 tag의 attr1은 ex1노드
# text : 시작 태그와 종료태그 사이에 있는 글자로, 예시로 asdf를 뜻함
# 예시 : <tag attr1 = "ex1" attr2="ex2"> asdf <시/tag>


# css selector ------------------------------------------------------------
# 원하는 글자가 있는 노드를 지정하기 위해서 css 선택자를 공부해야함
# ref url : http://www.nextree.co.kr/p8468/

## css 선택자가 동작하는 방식
# 1. tag 이름
# 2. tag의 id 속성
# 3. tag의 class 속성
# 4. tag의 custom 속성

## css 선택자로 node를 선택하기 위해
# 1. tag
# 2. #id
# 3. .class
# 4. [attr = "val"]
# 5. tag#id
# 6. tag.class
# 7. tag[attr="val"]


# rvest의 동작 순서 (text 가져오기) ------------------------------------------------

# 1. html 문서 데이터 가져오기
# 2. 필요한 노드 선택하기
# 3. 노드 내에 text 긁어오기 

library(dplyr)
library(rvest)

tar <- "https://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=102&oid=032&aid=0002957350"
read_html(tar)
read_html(tar) %>% html_nodes("h3") 

# 제목만 한번 긁어 보자 (똑같은 방식)
read_html(tar) %>% html_nodes("h3[id = 'articleTitle']")
read_html(tar) %>% html_nodes("h3#articleTitle")

# 글자들만 내놓으세요 
read_html(tar) %>% html_nodes("h3#articleTitle") %>% html_text()

# attr 정보도 들고올 수 있습니다.
read_html(tar) %>% html_nodes("h3#articleTitle") %>% html_attr("id")

# 뉴스 메인에 있는 뉴스 주소들만 긁어 보기 
tar2 <- "https://news.naver.com/main/home.nhn"
read_html(tar2) %>% html_nodes("a") # 자식노드 
read_html(tar2) %>% html_nodes("dt a") # 부모 - 자식 노드 
read_html(tar2) %>% html_nodes("dt a") %>% html_attr("href") # URL 긁기

# 위의 방법으로 반복문을 이용해서 여러 뉴스 제목이나 원문을 긁어 올 수 있을 수 있다. 
