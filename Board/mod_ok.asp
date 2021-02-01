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
Dim idx,Page,SearchOpt,SearchVal
Dim uname,title,pwd,contents,mod_ip

idx = req(Request.Form("idx"))
Page = req(Request.Form("Page"))
SearchOpt = req(Request.Form("SearchOpt"))
SearchVal = req(Request.Form("SearchVal"))

referer = Request.ServerVariables("HTTP_REFERER")
uname = req(Request.Form("uname"))
title = req(Request.Form("title"))
pwd = req(Request.Form("pwd"))
contents = req(Request.Form("contents"))
mod_ip = Request.ServerVariables("REMOTE_ADDR")
'Response.Write mod_ip : Response.End
if Split(referer,"?")(0)<>"http://localhost/mod.asp" then 
	Response.Write "<li>("&mod_ip&")에서 비정상 접근이 감지되었습니다</li>"
	Response.End
end if

if idx="" then Response.Write "<li>글번호가 없습니다</li>" : Response.end
if Page="" then Response.Write "<li>페이지 번호가 없습니다</li>" : Response.end

if uname="" then Response.Write "<li>작성자가 없습니다</li>" : Response.end
if title="" then Response.Write "<li>제목이 없습니다</li>" : Response.end
if pwd="" then Response.Write "<li>비밀번호가 없습니다</li>" : Response.end
if contents="" then Response.Write "<li>내용이 없습니다</li>" : Response.end


GetDbConn

Set oCmd = Server.CreateObject("ADODB.Command")
With oCmd
	.ActiveConnection = oConn
	.CommandType = adCmdStoredProc
	.CommandText = "dbo.sp_board_mod_ok"
	
	.Parameters.Append .CreateParameter("@idx",adInteger,adParamInput,0,idx)
	.Parameters.Append .CreateParameter("@uname",adVarWChar,adParamInput,10,uname)
	.Parameters.Append .CreateParameter("@title",adVarWChar,adParamInput,30,title)
	.Parameters.Append .CreateParameter("@pwd",adVarWChar,adParamInput,20,pwd)
	.Parameters.Append .CreateParameter("@contents",adLongVarWChar,adParamInput,LenB(contents),contents)
	.Parameters.Append .CreateParameter("@mod_ip",adVarChar,adParamInput,20,mod_ip)

	.Parameters.Append .CreateParameter("@res",adSmallInt,adParamOutput,0,0)

	.Execute , , adExecuteNoRecords

	res = .Parameters("@res") '0:성공 1:sql error 2:비밀번호다름
End With
SetFreeObj(oCmd)

SetFreeObj(oConn)
%>

<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <title>글수정</title>
  <script language="javascript" type="text/javascript" src="./config/js/jquery-3.1.0.js"></script>
  <script language="javascript" type="text/javascript" src="./config/js/extend.js"></script>
  <script language="javascript" type="text/javascript">
	$(document).ready(function(){
		var $idx = $("#idx").val();
		var $Page = $("#Page").val();
		var $SearchOpt = $("#SearchOpt").val();
		var $SearchVal = $("#SearchVal").val();

		setTimeout(function(){
			location.href = "view.asp?idx="+$idx+"&Page="+$Page+"&SearchOpt="+$SearchOpt+"&SearchVal="+$SearchVal;
		},5000);
	});
  </script>
 </head>
	<body>
		<input type="hidden" name="idx" id="idx" value="<%=idx%>">
		<input type="hidden" name="Page" id="Page" value="<%=Page%>">
		<input type="hidden" name="SearchOpt" id="SearchOpt" value="<%=SearchOpt%>">
		<input type="hidden" name="SearchVal" id="SearchVal" value="<%=SearchVal%>">
		<%
		select case res
		case 0
			Response.Write "<li>정상적으로 수정되었습니다</li>"
		case 1
			Response.Write "<li>수정처리중 에러가 발생하였습니다. 관리자에게 문의하세요</li>"
		case 2
			Response.Write "<li>글 비밀번호가 일치하지 않습니다</li>"
		end select
		Response.Write "<li>잠시후 상세페이지로 이동합니다</li>"
		%>
	</body>
</html>