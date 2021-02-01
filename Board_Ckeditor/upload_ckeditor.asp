<%@CodePage="65001" Language="VBScript"%>
<!--#include file="./config/common/var.asp"-->
<!--#include file="./config/common/const.asp"-->
<!--#include file="./config/common/proc.asp"-->
<!--#include file="./config/common/dbconf.asp"-->
<!--#include file="./config/common/aspJSON1.17.asp"-->

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
''upload'''''''''''''''''''''''''''''''''''''''''''''''''
Dim saveDir
Dim theForm,upObjs,upObj,maxUploadSize
Dim fileRealName,fileExt,fileSaveName,fileSize, bExist, countFileName
'Dim fileRealNames(),fileSaveNames(),fileSizes(),bidx 'for save db

Dim uploaded,fileName,url,json 'for ckeditor

maxUploadSize = 1024*1024*10  '10M 업로드 가능
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

Set upObjs = theForm("upload")
Redim fileRealNames(upObjs.Count)
Redim fileSaveNames(upObjs.Count)
Redim fileSizes(upObjs.Count)
For i=1 to upObjs.Count step 1
	Set upObj = theForm("upload")(i)
	fileSize = upObj.Length

	if fileSize<1 then
		'Response.Write "<li> ("&i&")번째 첨부파일이 없습니다 </li>"
		uploaded = 0
	'elseIf fileSize > maxUploadSize then
	'	Response.Write "<li> ("&i&")번째 첨부파일이 용량초과로 업로드 되지 않습니다 </li>"
	else
		fileRealName = upObj.RawFileName 
		fileExt = Mid(fileRealName, InstrRev(fileRealName, ".") + 1)
		If InStr("exe,bat,com,dll,asp,aspx,cs,java,py,rb,sys,c,cpp,pl,js,html,htm",fileExt)>0 Then
			'Response.Write "<li> ("&i&")번째 첨부파일이 업로드금지파일로 업로드 되지 않습니다 </li>"
			uploaded = 0
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
			'Response.Write "<li> ("&i&")번째 첨부파일이 업로드 되지 못했습니다. 이유는 다음과 같습니다. "&err.Description&" </li>"
			uploaded = 0
		else
			'Response.Write "<li> ("&i&")번째 첨부파일이 업로드 되었습니다 </li>"
			'fileRealNames(i-1) = fileRealName 
			'fileSaveNames(i-1) = fileSaveName
			'fileSizes(i-1) = fileSize
			uploaded = 1
			fileName = fileRealName
			url = "upload" &"/"& Date &"/"& fileSaveName
			
			'아래처럼 json으로 출력 (아래는 자바예제)
			'JsonObject json = new JsonObject()
			'json.addProperty("uploaded",uploaded)
			'json.addProperty("fileName",fileRealName)
			'json.addProperty("url",url)
			'printWriter.Println(json)

			Set json = New aspJSON
			json.data("uploaded") = uploaded
			json.data("fileName") = fileRealName
			json.data("url") = url
			Response.Write json.JSONoutput()

		end if
	End If	

	SetFreeObj(upObj)
Next
SetFreeObj(upObjs)
%>