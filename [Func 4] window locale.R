
# Windows에서 locale 관련 함수들 모음 ----------------------------------------------

# 현재 설정된 로케일을 확인
Sys.getlocale()
## [1] "LC_COLLATE=Koren_Korea.949;
## LC_CTYPE=Koren_Korea.949;
## LC_MONETARY=Koren_Korea.949;
## LC_NUMERIC=Koren_Korea.949;
## LC_TIME=Koren_Korea.949;"

# 현재 설정된 로케일에 따른 문자 인코딩 방식을 확인
localeToCharset()
## [1] "CP949"


# 미국 로케일 변경 
Sys.setlocale(category = 'LC_ALL', locale = 'english')
## [1] "LC_COLLATE=English_United States.1252;
## LC_CTYPE=English_UnitedS tates.1252;
## LC_MONETARY=English_United States.1252;
## LC_NUMERIC=C;
## LC_TIME=English_United States.1252"

localeToCharset()
## [1] "ISO8859-1"


# 중국 로케일로 변경
Sys.setlocale(category = 'LC_ALL', locale = 'chinese')
## [1] "LC_COLLATE=Chinese (Simplified)_China.936;
## LC_CTYPE=Chinese (Simplified)_China.936;
## LC_MONETARY=Chinese (Simplified)_China.936;
## LC_NUMERIC=C;
## LC_TIME=Chinese (Simplified)_China.936"

localeToCharset()
## [1] "CP936"


# 일본 로케일로 변경
Sys.setlocale(category = 'LC_ALL', locale = 'japanese')
## [1] "LC_COLLATE=Japanese_Japan.932;
## LC_CTYPE=Japanese_Japan.932;
## LC_MONETARY=Japanese_Japan.932;
## LC_NUMERIC=C;
## LC_TIME=Japanese_Japan.932"

localeToCharset()
## [1] "CP932"

# Unix Default 로케일로 변경합니다. 
Sys.setlocale(category = 'LC_ALL', locale = 'C')
## [1] "C"

localeToCharset()
## [1] "ASCII"


# 한국 로케일로 변경
Sys.setlocale(category = 'LC_ALL', locale = 'korean')
## [1] "LC_COLLATE=Korean_Korea.949;
## LC_CTYPE=Korean_Korea.949;
## LC_MONETARY=Korean_Korea.949;
## LC_NUMERIC=C;
## LC_TIME=Korean_Korea.949"


# 기본 로케일로 돌아가고 싶다면
Sys.setlocale()
