<%
Option Explicit

'//작성자 : gigatera
'//설  명 : 공통변수 모음

Dim fileAttachMax
fileAttachMax = 2

Dim objDom, xmlDoc, xmlAtr ,xmlNode, xmlChild, xmlAtr2, xmlPI
Dim ConnStr '디비연결 문자열을 저장할 문자열 변수		
Dim oMail '메일링을 할때 smtp객체를 얻어오는 객체 변수
Dim oConn '디비연결값을 리턴받는 디비연결 객체 변수
Dim oRs '레코드셋을 얻어오는 레코드셋 객체 변수
Dim oRs2
Dim oCmd '케멘드 객체를 얻어오는 커맨드 객체 변수
Dim oQry '쿼리문을 저장하는 쿼리 스트링 변수
Dim exQry '커맨드 객체를 사용하지 않고, stored procedure를 사용할 때 쓰는 쿼리 스트링 변수
Dim Cnt '카운트 정수형 변수

Dim Res 'on error resume 문 등에서 사용하는 에러 체크 boolean 변수
Dim Chk '값이 존재하는지의 여부를 따질 때 사용하는 정수형 변수
Dim i 'for 문에서 사용하는 정수형 변수
Dim j 'for 문에서 사용하는 정수형 변수
Dim k 'for 문에서 사용하는 정수형 변수
Dim l'for 문에서 사용하는 정수형 변수
Dim view '보이기/숨기기 같은 곳에서 사용하는 boolean 변수

Dim fso   '파일 시스템 객체(file system object)
Dim fp    '파일 포인터 객체(file pointer)
Dim lpstr '텍스트 파일을 읽어드릴 스트링 변수(long pointer string)
dim automsg
Dim path

Dim Image

' asp 업로드 컴포넌트 
'Dim theForm, theField, bExist , countFileName, saveFileName, FileName
'Dim uploadPath

Dim GetPreUrl

Dim cur_ip : cur_ip = trim(Request.ServerVariables("REMOTE_ADDR"))
%>