library(rvest)
library(dplyr)

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

