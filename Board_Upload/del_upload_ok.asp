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
Dim idx,Page,SearchOpt,SearchVal,pwd

referer = Request.ServerVariables("HTTP_REFERER")
idx = req(Request.Form("idx"))
Page = req(Request.Form("Page"))
SearchOpt = req(Request.Form("SearchOpt"))
SearchVal = req(Request.Form("SearchVal"))
pwd = req(Request.Form("pwd"))
'Response.Write referer

if Split(referer,"?")(0)<>"http://localhost/view_upload.asp" then 
	Response.Write "<li>("&reg_ip&")에서 비정상 접근이 감지되었습니다</li>"
	Response.End
end if

if idx="" then Response.Write "<li>글번호가 없습니다</li>" : Response.end
if Page="" then Response.Write "<li>페이지 번호가 없습니다</li>" : Response.end
if pwd="" then Response.Write "<li>비밀번호가 없습니다</li>" : Response.end

GetDbConn

Set oCmd = Server.CreateObject("ADODB.Command")
With oCmd
	.ActiveConnection = oConn
	.CommandType = adCmdStoredProc
	.CommandText = "dbo.sp_board_del_upload_ok"

	.Parameters.Append .CreateParameter("@idx",adInteger,adParamInput,0,idx)
	.Parameters.Append .CreateParameter("@pwd",adVarWChar,adParamInput,20,pwd)

	.Parameters.Append .CreateParameter("@res",adSmallInt,adParamOutput,0,0)

	.Execute , , adExecuteNoRecords

	res = .Parameters("@res") ' 적용갯수 출력
End With
SetFreeObj(oCmd)

'if trim(res)="" then res=-1

'res = 1
if res=1 then '글 내용 삭제시 첨부파일도 삭제한다
	Dim files,saveFile
	files = Request.Form("files")':response.write files
	
	
	if not isnull(files) and not isempty(files) and files<>"" then
		
		'files = Split(files,",")
		Set fso = CreateObject("Scripting.FileSystemObject")

		if Instr(files,",")>0 then
			files = Split(files,",")
			'Response.Write "files(0) : " & files & "<br>"
			for i=0 to Ubound(files) step 1
				err.Clear
				On error resume next
					saveFile = Server.MapPath( "./upload/" & trim(files(i)) )
					'Response.Write "saveFile : " & saveFile & "<br>"
					If fso.FileExists(saveFile) Then
						fso.DeleteFile(saveFile)
					End if
				if err.number<>0 then
					Response.Write "<li>("& i+1 &")번째 첨부파일 삭제중 에러가 발생하였습니다! 에러는 다음과 같습니다. "& err.Description &"</li>"
				else
					Response.Write "<li>("& i+1 &")번째 첨부파일이 삭제되었습니다</li>"
				end if
			next
		else
			err.Clear
			On error resume next
				If fso.FileExists(saveFile) Then
					saveFile = Server.MapPath( "./upload/" & trim(files) )
					fso.DeleteFile(saveFile)
				End if
			if err.number<>0 then
				Response.Write "<li>첨부파일 삭제중 에러가 발생하였습니다!! 에러는 다음과 같습니다. "& err.Description &"</li>"
			else
				Response.Write "<li>첨부파일이 삭제되었습니다</li>"
			end if
		end if

		SetFreeObj(fso)

	end if
	
end if

'Response.Write res
%>

<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <title>글삭제</title>
  <script language="javascript" type="text/javascript" src="./config/js/jquery-3.1.0.js"></script>
  <script language="javascript" type="text/javascript" src="./config/js/extend.js"></script>
  <script language="javascript" type="text/javascript">
	$(document).ready(function(){
		setTimeout(function(){
			location.href = "list_upload.asp?Page=<%=Page%>&SearchOpt=<%=SearchOpt%>&SearchVal=<%=SearchVal%>";
		},5000);
	});
  </script>
 </head>
	<body>
		<%
		if res=1 then
			Response.Write "<li>정상적으로 삭제되었습니다</li>"
		else
			Response.Write "<li>비밀번호가 일치하지 않거나, 이미 삭제된 글입니다</li>"
		end if

		Response.Write "<li>잠시후 리스트로 이동합니다</li>"
		%>
	</body>
</html>

<%
SetFreeObj(oConn)
%>