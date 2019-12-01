# 인코딩 종류, 문제점 ref : https://studyforus.tistory.com/167 

library(dpylr)
library(urltools)


# string -> percent encoding ----------------------------------------------

# Windows라면 CP949 방식
string <- '펭수하이'

# 웹 서버가 인식할 수 있도록 문자열을 퍼센트 인코딩
string %>% url_encode() # "%c6%eb%bc%f6%c7%cf%c0%cc"

# 대문자로 출력하고 싶으면 toupper() 함수를 추가
string %>% url_encode() %>% toupper() # "%C6%EB%BC%F6%C7%CF%C0%CC"


# euc-kr : Percent encoding -> string ----------------------------------------------
ex1 <- '%c6%eb%bc%f6%c7%cf%c0%cc'

# 문자열로 디코딩
ex1 %>% url_decode()

string %>% iconv(from = 'EUC-KR', to = 'UTF-8') %>% url_encode() %>% toupper()


# utf-8 : Percent encoding -> string --------------------------------------
ex2 <- '%ED%81%AC%EB%A1%A4%EB%A7%81'

# 문자열로 디코딩
ex2 %>% url_decode()

ex2 %>% url_decode %>% iconv(from = 'UTF-8', to = 'EUC-KR')
