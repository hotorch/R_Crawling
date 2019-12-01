
# hanguel R functions for Windows -----------------------------------------

# 현재 컴퓨터에 설정된 로케일에 따른 한글 인코딩 방식 확인합니다. 
localeToCharset()
## [1] "CP949"

text <- '펭-하'

# iconv() : 문자열의 인코딩 방식을 변경

# CP949 -> EUC-KR로 변경
iconv(x = text, from = 'CP949', to = 'EUC-KR')

# CP949 -> UTF-8로 변경
iconv(x = text, from = 'CP949', to = 'UTF-8')


# 관심 있는 URL에 사용된 문자 인코딩 방식을 확인 ----------------------------------------
# confidence 높은 것으로 선택됨
# detach(package:rvest)
library(readr)

guess_encoding(file = 'https://www.naver.com/')
##   encoding     confidence
##   <chr>             <dbl>
## 1 UTF-8              1   
## 2 windows-1252       0.31

guess_encoding(file = 'https://www.daum.net/')
##   encoding     confidence
##   <chr>             <dbl>
## 1 UTF-8              1   
## 2 windows-1252       0.35

guess_encoding(file = 'http://www.isuperpage.co.kr/')
##   encoding   confidence
##   <chr>           <dbl>
## 1 EUC-KR           1   
## 2 GB18030          0.71
## 3 ISO-8859-1       0.32

