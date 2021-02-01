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
Dim uname,title,pwd,pwd2,contents,reg_ip


''upload'''''''''''''''''''''''''''''''''''''''''''''''''
Dim saveDir
Dim theForm,upObjs,upObj,maxUploadSize
Dim fileRealName,fileExt,fileSaveName,fileSize, bExist, countFileName
Dim fileRealNames(),fileSaveNames(),fileSizes(),bidx 'for save db

maxUploadSize = 1024*1024*1  '1M 업로드 가능
Set fso = CreateObject("Scripting.FileSystemObject")
saveDir = Server.MapPath("./") & "\upload\"&Date&"\"
If Not(fso.FolderExists(saveDir)) Then
	fso.CreateFolder(saveDir)
End if

'이미지 썸네일 요청시 Nanumi.ImagePlus를 이용한다
'iis AppPool에 32bit 응용프로그램사용 true 설정해야함
Set theForm = Server.CreateObject("ABCUpload4.XForm")
theForm.MaxUploadSize = maxUploadSize
theForm.Overwrite = False
theForm.AbsolutePath = True
theForm.CodePage = 65001

Set upObjs = theForm("files")
Redim fileRealNames(upObjs.Count)
Redim fileSaveNames(upObjs.Count)
Redim fileSizes(upObjs.Count)
For i=1 to upObjs.Count step 1
	Set upObj = theForm("files")(i)
	fileSize = upObj.Length

	if fileSize<1 then
		Response.Write "<li> ("&i&")번째 첨부파일이 없습니다 </li>"
	'elseIf fileSize > maxUploadSize then
	'	Response.Write "<li> ("&i&")번째 첨부파일이 용량초과로 업로드 되지 않습니다 </li>"
	else
		fileRealName = upObj.RawFileName 
		fileExt = Mid(fileRealName, InstrRev(fileRealName, ".") + 1)
		If InStr("exe,bat,com,dll,asp,aspx,cs,java,py,rb,sys,c,cpp,pl,js,html,htm",fileExt)>0 Then
			Response.Write "<li> ("&i&")번째 첨부파일이 업로드금지파일로 업로드 되지 않습니다 </li>"
		End if
		
		fileSaveName = getGUID() & "." & fileExt
		countFileName = 0
		bExist = True
		Do While bExist
			If (fso.FileExists(saveDir & fileSaveName)) Then
				countFileName = countFileName + 1
				fileSaveName = getGUID() & "_" & countFileName & "." & fileExt
			Else
				bExist = False
			End If
		Loop
		'fileSaveName = getGUID() & "_" & i & "." & fileExt

		err.Clear
		On error resume next
			upObj.Save saveDir & fileSaveName
		if err.number <> 0 then
			Response.Write "<li> ("&i&")번째 첨부파일이 업로드 되지 못했습니다. 이유는 다음과 같습니다. "&err.Description&" </li>"
		else
			Response.Write "<li> ("&i&")번째 첨부파일이 업로드 되었습니다 </li>"
			fileRealNames(i-1) = fileRealName 
			fileSaveNames(i-1) = fileSaveName
			fileSizes(i-1) = fileSize
		end if
	End If	

	SetFreeObj(upObj)
Next
SetFreeObj(upObjs)


''글 저장하기
referer = Request.ServerVariables("HTTP_REFERER")
uname = req(theForm("uname")(1))
title = req(theForm("title")(1))
pwd = req(theForm("pwd")(1))
pwd2 = req(theForm("pwd2")(1))
contents = req(theForm("contents")(1))
reg_ip = Request.ServerVariables("REMOTE_ADDR")

if referer<>"http://localhost/write_upload.asp" then 
	Response.Write "<li>("&reg_ip&")에서 비정상 접근이 감지되었습니다</li>"
	Response.End
end if

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
	.Parameters.Append .CreateParameter("@reg_ip",adVarChar,adParamInput,20,reg_ip)

	.Parameters.Append .CreateParameter("@res",adSmallInt,adParamOutput,0,0)
	.Parameters.Append .CreateParameter("@bidx",adInteger,adParamOutput,0,0)

	.Execute , , adExecuteNoRecords

	res = .Parameters("@res") '0:성공 1:sql error 2:1분이내 재등록 경고
	bidx = .Parameters("@bidx")
End With
SetFreeObj(oCmd)
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
			location.href = "list_upload.asp";
		},5000);
	});
  </script>
 </head>
	<body>
		<%
		'Response.Write "<br><hr/>"
		'Response.Write "<b>[글내용 저장결과]</b><br>"
		if trim(res)="" then res=-1
		select case res
		case 0
			Response.Write "<li>글내용이 정상적으로 등록되었습니다</li>"
		case 1
			Response.Write "<li>글내용 등록처리중 에러가 발생하였습니다. 관리자에게 문의하세요</li>"
		case 2
			Response.Write "<li>글내용은 1분 이내 재등록할수 없습니다</li>"  '같은 아이피에서 
		end select
		'Response.Write "<li>잠시후 리스트로 이동합니다</li>"
		%>

		<%
		if res=0 then
			Response.Write "<br><hr/>"
			'Response.Write "<b>[파일업로드 결과저장]</b><br>"
			for i=0 to Ubound(fileRealNames) step 1
				res = ""
				if trim(fileRealNames(i))<>"" then
					'Response.Write "bidx : " & bidx & "<br>"
					'Response.Write "fileRealNames : " & fileRealNames(i) & "<br>"
					'Response.Write "fileSaveNames : " & fileSaveNames(i) & "<br>"
					'Response.Write "fileSizes : " & fileSizes(i) & "<br>"

					err.Clear
					On error Resume next
						Set oCmd = Server.CreateObject("ADODB.Command")
						With oCmd
							.ActiveConnection = oConn
							.CommandType = adCmdStoredProc
							.CommandText = "dbo.sp_board_insert_upload"
							
							.Parameters.Append .CreateParameter("@bidx",adInteger,adParamInput,0,bidx)
							.Parameters.Append .CreateParameter("@fileRealName",adVarWChar,adParamInput,50,fileRealNames(i))
							.Parameters.Append .CreateParameter("@fileSaveName",adVarWChar,adParamInput,50,fileSaveNames(i))
							.Parameters.Append .CreateParameter("@fileSize",adVarChar,adParamInput,10,fileSizes(i))
							.Parameters.Append .CreateParameter("@reg_ip",adVarChar,adParamInput,20,reg_ip)

							.Parameters.Append .CreateParameter("@res",adSmallInt,adParamOutput,0,0)

							.Execute , , adExecuteNoRecords
							'Response.Write "res : " & .Parameters("@res") & "<br>"
							res = .Parameters("@res") '0:성공 1:sql error 2:1분이내 재등록 경고
							'Response.Write "res : " & res & "<br>"
						End With
						SetFreeObj(oCmd)
					if err.number<>0 then
						Response.Write err.description & "<br>"
					else	
						'response.Write "err.number=0" & "<br>"
					end if

					'if trim(res)="" then res=-1
					select case res
					case 0
						Response.Write "<li>("&i+1&")번째 파일정보가 정상적으로 등록되었습니다</li>"
					case 1
						Response.Write "<li>("&i+1&")번째 파일정보 등록처리중 에러가 발생하였습니다. 관리자에게 문의하세요</li>"
					case 2
						Response.Write "<li>("&i+1&")번째 파일정보를 1분 이내 재등록할수 없습니다</li>"  '같은 아이피에서 
					end select
				end if
			next
		end if

		Response.Write "<br><br><li>잠시후 리스트로 이동합니다</li>"
		%>

	</body>
</html>

<%
'SetFreeObj(oCmd)
SetFreeObj(oConn)
%>