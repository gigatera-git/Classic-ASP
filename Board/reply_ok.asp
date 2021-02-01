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
Dim Page,SearchOpt,SearchVal,ref,re_step,re_lvl
Page = req(Request.Form("Page"))
SearchOpt = req(Request.Form("SearchOpt"))
SearchVal = req(Request.Form("SearchVal"))
ref = req(Request.Form("ref"))
re_step = req(Request.Form("re_step"))
re_lvl = req(Request.Form("re_lvl"))

if Page="" then Response.Write "<li>페이지 번호가 없습니다</li>" : Response.end
if ref="" then Response.Write "<li>ref 번호가 없습니다</li>" : Response.end
if re_step="" then Response.Write "<li>re_step 번호가 없습니다</li>" : Response.end
if re_lvl="" then Response.Write "<li>re_lvl 번호가 없습니다</li>" : Response.end

Dim referer
Dim uname,title,pwd,pwd2,contents,reg_ip

referer = Request.ServerVariables("HTTP_REFERER")
uname = req(Request.Form("uname"))
title = req(Request.Form("title"))
pwd = req(Request.Form("pwd"))
pwd2 = req(Request.Form("pwd2"))
contents = req(Request.Form("contents"))
reg_ip = Request.ServerVariables("REMOTE_ADDR")
'response.write referer
if Split(referer,"?")(0)<>"http://localhost/reply.asp" then 
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
	.CommandText = "dbo.sp_board_reply"

	.Parameters.Append .CreateParameter("@uname",adVarWChar,adParamInput,10,uname)
	.Parameters.Append .CreateParameter("@title",adVarWChar,adParamInput,30,title)
	.Parameters.Append .CreateParameter("@pwd",adVarWChar,adParamInput,20,pwd)
	.Parameters.Append .CreateParameter("@contents",adLongVarWChar,adParamInput,LenB(contents),contents)
	.Parameters.Append .CreateParameter("@ref",adSmallInt,adParamInput,0,ref)
	.Parameters.Append .CreateParameter("@re_step",adSmallInt,adParamInput,0,re_step)
	.Parameters.Append .CreateParameter("@re_lvl",adSmallInt,adParamInput,0,re_lvl)
	.Parameters.Append .CreateParameter("@reg_ip",adVarChar,adParamInput,20,reg_ip)

	.Parameters.Append .CreateParameter("@res",adSmallInt,adParamOutput,0,0)

	.Execute , , adExecuteNoRecords

	res = .Parameters("@res") '0:성공 1:sql error 2:1분이내 재등록 경고
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
		var $Page = $("#Page").val();
		var $SearchOpt = $("#SearchOpt").val();
		var $SearchVal = $("#SearchVal").val();

		setTimeout(function(){
			location.href = "list.asp?Page="+$Page+"&SearchOpt="+$SearchOpt+"&SearchVal="+$SearchVal;
		},5000);
	});
  </script>
 </head>
	<body>
		<input type="hidden" name="Page" id="Page" value="<%=Page%>">
		<input type="hidden" name="SearchOpt" id="SearchOpt" value="<%=SearchOpt%>">
		<input type="hidden" name="SearchVal" id="SearchVal" value="<%=SearchVal%>">
		<%
		select case res
		case 0
			Response.Write "<li>정상적으로 답변이 등록되었습니다</li>"
		case 1
			Response.Write "<li>답변처리중 에러가 발생하였습니다. 관리자에게 문의하세요</li>"
		case 2
			Response.Write "<li>1분 이내 재답변할수 없습니다</li>"  '같은 아이피에서 
		end select
		Response.Write "<li>잠시후 리스트로 이동합니다</li>"
		%>
	</body>
</html>