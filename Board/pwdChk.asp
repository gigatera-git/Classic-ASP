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
Dim idx, pwd
idx = req(Request.QueryString("idx"))
pwd = req(Request.QueryString("pwd"))

Res = ""
if Res="" and idx="" then
	Res = "글번호가 없습니다"
elseif Res="" and pwd="" then
	Res = "비밀번호가 없습니다"
elseif Res="" Then
	
	GetDBConn
	GetRs
	
	Set oCmd = Server.CreateObject("ADODB.Command")
	With oCmd
		.ActiveConnection = oConn
		.CommandType = adCmdStoredProc
		.CommandText = "dbo.sp_board_pwd_chk"

		.Parameters.Append .CreateParameter("@idx",adInteger,adParamInput,0,idx)
		.Parameters.Append .CreateParameter("@pwd",adVarWChar,adParamInput,20,pwd)

		Set oRs = .Execute 
	End With
	SetFreeObj(oCmd)

	'oqry = ""
	'oqry = "select count(*) from tbl_board where idx="&idx&" and pwd=HASHBYTES('SHA2_512','"&pwd&"');"
	'Response.write oqry
	'oRs.Open oqry,oconn,3,1

	SetFreeObj(oRs)
	SetFreeObj(oConn)

	if oRs(0)<1 then
		Res = "비밀번호가 일치하지 않습니다"
	else
		Res = "ok"
	end if

end if

Response.Write Res
%>