# sample pdf 파일은 ALBERT: A LITE BERT FOR SELF-SUPERVISED LEARNING OF LANGUAGE REPRESENTATIONS 논문이다. 

library(pdftools)

# path와 file 이름 지정
fileName <- '../../albert.pdf'

# pdf 파일 읽기
pdf_text(pdf = fileName)

# 정보 파악
pdf_info(pdf = fileName)

# pdf 파일 하나하나 png파일로 저장하는 방법
pdf_convert(pdf = fileName, format = 'png')


# pdf 파일에서 테이블을 따오는 방법. 전처리가 많이 필요함
library(dplyr)
library(tabulizer)

extract_tables(file = fileName) %>% 
  `[[`(1) %>% 
  as.data.frame() -> table
