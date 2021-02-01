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
Dim filePath
Dim fileName
Dim Stream

filePath = req(request.QueryString("filePath"))
fileName = req(request.QueryString("fileName"))

Set fso = CreateObject("Scripting.FileSystemObject")
response.Write Server.MapPath(filePath) & "\" & fileName

If fso.FileExists( Server.MapPath(filePath) & "\" & fileName ) Then

	Response.ContentType = "application/octet-stream"
	Response.CacheControl = "public"
	Response.AddHeader "Content-Disposition","attachment;filename=" & fileName

	Set Stream = Server.CreateObject("ADODB.Stream")
	Stream.Open
	Stream.Type=1
	Stream.LoadFromFile Server.MapPath(filePath) & "\" & fileName
	Response.BinaryWrite Stream.Read
	Stream.close
	Set Stream = nothing
    Else
        '파일이 없을 경우...
        Response.Write "해당 파일을 찾을 수 없습니다."
    End If
   
Set fso = Nothing
%>