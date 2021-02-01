<%@CodePage="65001" Language="VBScript"%>
<!--#include file="./config/common/var.asp"-->
<!--#include file="./config/common/const.asp"-->
<!--#include file="./config/common/proc.asp"-->
<!--#include file="./config/common/dbconf.asp"-->

<%
Session.CodePage = "65001"    
Response.CharSet="utf-8"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"

'error message for euc-kr
'Response.CharSet="euc-kr"  
'Response.codepage="949"    
'Response.ContentType="text/html;charset=euc-kr"
%>

<%   
Response.Expires = 0   
Response.AddHeader "Pragma","no-cache"   
Response.AddHeader "Cache-Control","no-cache,must-revalidate"   
%>   

<%
Dim referer
Dim bidx,uname,title,pwd,pwd2,contents,reg_ip

referer = Request.ServerVariables("HTTP_REFERER")
uname = req(Request.Form("uname"))
title = req(Request.Form("title"))
pwd = req(Request.Form("pwd"))
pwd2 = req(Request.Form("pwd2"))
contents = req(Request.Form("contents"))
reg_ip = Request.ServerVariables("REMOTE_ADDR")

if referer<>"http://localhost/write_ckeditor.asp" then 
	Response.Write "<li>("&reg_ip&")에서 비정상 접근이 감지되었습니다</li>"
	Response.End
end if

if uname="" then Response.Write "<li>작성자가 없습니다</li>" : Response.end
if title="" then Response.Write "<li>제목이 없습니다</li>" : Response.end
if pwd="" then Response.Write "<li>비밀번호가 없습니다</li>" : Response.end
if pwd2="" then Response.Write "<li>비밀번호 확인이 없습니다</li>" : Response.end
if pwd<>pwd2 then Response.Write "<li>비밀번호와 비밀번호 확인이 다릅니다</li>" : Response.end
if contents="" then Response.Write "<li>내용이 없습니다</li>" : Response.end


'oQry = ""
'oQry = "insert into tbl_board(uname,title,pwd,contents,ref,re_step,re_lvl) "
'oQry = oQry & "values('"&uname&"','"&title&"',HASHBYTES('SHA2_512','"&pwd&"'),'"&contents&"',1,1,1);"

GetDbConn

Set oCmd = Server.CreateObject("ADODB.Command")
With oCmd
	.ActiveConnection = oConn
	.CommandType = adCmdStoredProc
	.CommandText = "dbo.sp_board_insert"

	.Parameters.Append .CreateParameter("@uname",adVarWChar,adParamInput,10,uname)
	.Parameters.Append .CreateParameter("@title",adVarWChar,adParamInput,30,title)
	.Parameters.Append .CreateParameter("@pwd",adVarWChar,adParamInput,20,pwd)
	.Parameters.Append .CreateParameter("@contents",adLongVarWChar,adParamInput,LenB(contents),contents)
	'.Parameters.Append .CreateParameter("@ref",adSmallInt,adParamInput,0,1)
	'.Parameters.Append .CreateParameter("@re_step",adSmallInt,adParamInput,0,1)
	'.Parameters.Append .CreateParameter("@re_lvl",adSmallInt,adParamInput,0,1)
	.Parameters.Append .CreateParameter("@reg_ip",adVarChar,adParamInput,20,reg_ip)

	.Parameters.Append .CreateParameter("@res",adSmallInt,adParamOutput,0,0)
	.Parameters.Append .CreateParameter("@bidx",adInteger,adParamOutput,0,0)

	.Execute , , adExecuteNoRecords

	res = .Parameters("@res") '0:성공 1:sql error 2:1분이내 재등록 경고
	bidx = .Parameters("@bidx")
End With
SetFreeObj(oCmd)

SetFreeObj(oConn)
%>

<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <title>글쓰기</title>
  <script language="javascript" type="text/javascript" src="./config/js/jquery-3.1.0.js"></script>
  <script language="javascript" type="text/javascript" src="./config/js/extend.js"></script>
  <script language="javascript" type="text/javascript">
	$(document).ready(function(){
		setTimeout(function(){
			location.href = "list.asp";
		},5000);
	});
  </script>
 </head>
	<body>
		<%
		select case res
		case 0
			Response.Write "<li>정상적으로 등록되었습니다</li>"
		case 1
			Response.Write "<li>등록처리중 에러가 발생하였습니다. 관리자에게 문의하세요</li>"
		case 2
			Response.Write "<li>1분 이내 재등록할수 없습니다</li>"  '같은 아이피에서 
		end select
		Response.Write "<li>잠시후 리스트로 이동합니다</li>"
		%>
	</body>
</html>