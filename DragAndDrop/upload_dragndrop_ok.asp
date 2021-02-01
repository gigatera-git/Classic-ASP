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
res = 0


''upload'''''''''''''''''''''''''''''''''''''''''''''''''
Dim saveDir
Dim theForm,upObjs,upObj,maxUploadSize
Dim fileRealName,fileExt,fileSaveName,fileSize, bExist, countFileName
Dim fileRealNames(),fileSaveNames(),fileSizes(),bidx 'for save db

maxUploadSize = 1024*1024*100  '100M 업로드 가능
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
'response.write upObjs.Count
For i=1 to upObjs.Count step 1
	Set upObj = theForm("files")(i)
	fileSize = upObj.Length
	
	'Response.Write fileSize & "<br>"
	if fileSize<1 then
		res = 1
	else
		fileRealName = upObj.RawFileName 
		fileExt = Mid(fileRealName, InstrRev(fileRealName, ".") + 1)
		If InStr("exe,bat,com,dll,asp,aspx,cs,java,py,rb,sys,c,cpp,pl,js,html,htm",fileExt)>0 Then
			res = 2
		End if
		'Response.Write fileRealName & "<br>"
		
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
		'Response.Write saveDir & fileSaveName & "<br>"

		err.Clear
		On error resume next
			upObj.Save saveDir & fileSaveName
		if err.number <> 0 then
			res = 3
		else
			res = 0
		end if
	End If	

	SetFreeObj(upObj)
Next
SetFreeObj(upObjs)

Response.Write res
%>
