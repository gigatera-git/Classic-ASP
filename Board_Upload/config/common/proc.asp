<%
'//작성자 : gigatera(gigatera@empal.com)
'//설  명 : 공통함수 모음

Public Function GetDate(ByVal dateOPT)
'날짜를 전체/년/월/일의 각각의 형식으로 리턴받을 수 있는 함수
	Res = ""
	Select Case Trim(dateOPT)
		Case 0 '날짜를 2003-01-27일의 형식으로 리턴
			Res = Date()
		Case 1 '2003형식의 년만 리턴
			Res = Split(CStr(Date()),"-")(CInt(dateOPT)-1)
		Case 2 '01형식의 월만 리턴
			Res = Split(CStr(Date()),"-")(CInt(dateOPT)-1)
		Case 3 '27형식의 일만 리턴
			Res = Split(CStr(Date()),"-")(CInt(dateOPT)-1)
		Case Else
			Res = ""
	End Select
	GetDate = Res
End Function

Public Function GetWeekDay(myDate) '요일 구하기
'요일을 구해주는 함수
	Res = ""
	Select Case WeekDay(myDate)
		Case 1
			Res = "일요일"
		Case 2
			Res = "월요일"
		Case 3
			Res = "화요일"
		Case 4
			Res = "수요일"
		Case 5
			Res = "목요일"
		Case 6
			Res = "금요일"
		Case 7
			Res = "토요일"
		Case Else
			Res = "일요일"
	End Select
	GetWeekDay = Res
End Function

function getLastDayInMonth(i_year, i_month)

	'한달의 총날짜 계산함수
	Dim now_first_date            : now_first_date = i_year &"-"& RIGHT("0"& i_month,2) &"-01"
	Dim next_first_date            : next_first_date = DateAdd("m",1,now_first_date)
	Dim now_last_date            : now_last_date = DateAdd("d",-1,next_first_date)
	Dim now_month_days        : now_month_days = Day(now_last_date)

	getLastDayInMonth = now_month_days

end function

Public Function IsValue(ByVal Val)
'변수에 값이 존재하는지의 여부를 판단해주는 함수
	Res = True
	If ( Trim(CStr(Val))="" Or IsNull(Trim(CStr(Val))) Or IsEmpty(Trim(CStr(Val))) ) Then
		Res = False
	End If
	IsValue = Res
End Function 


Function IsSet(ByVal Val)
	'변수에 값이 존재하는지의 여부를 판단해주는 함수
	Res = True
	If ( Trim(CStr(Val))="" Or IsNull(Trim(CStr(Val))) Or IsEmpty(Trim(CStr(Val))) ) Then
		Res = False
	End If

	IsSet = Res
End Function 


Public Function GetStrReplace(ByVal strVal,ByVal strLength)
'strVal 스트링 변수를 strLength만큼 잘라 리턴해주는 함수
'strLength 가 0이면 strVal 자르지 않고 리턴
	Dim strRet

	If (CInt(strLength>0)) Then '0이면 스트링 자르지 않음
		If (Len(strVal)>CInt(strLength)) Then
			strRet = Mid(strVal,1,strLength) & "..."
		Else
			strRet = strVal
		End If
	Else 
		strRet = strVal
	End If

	strRet = Replace(strRet,"'","''")

	GetStrReplace = strRet

End Function 

Function MailSender(Sender,Reciever,Cust_Name,Title,Body,Attach) '메일 센더..
'CDO2000객체를 이용한 메일 보내기 함수
	Dim iMsg, iConf, Flds
	Set iMsg  = CreateObject("CDO.Message")
	Set iConf = CreateObject("CDO.Configuration")
	Set Flds  = iConf.Fields 

	With Flds
		.Item(cdoSendUsing)				= cdoSendUsingPort
		.Item(cdoSMTPServer)			= "11.1.1.1" '요기는 해당 smtp아이피로 변경
		.Item(cdoSMTPConnectionTimeout)	= 10
		.Item(cdoSMTPAuthenticate)		= cdoBasic
		.Item(cdoSendUserName)			= "gigatera"
		.Item(cdoSendPassword)			= "1234" 
		.Item(cdoURLGetLatestVersion)   = True
		.Update
	End With

	Set iMsg.Configuration = iConf   

	With iMsg        
		'.From			= Cust_Name & "<" & Sender & ">"
		'.To				= "웹마스터" & "<" & Reciever & ">" 
		.From			= Sender
		.To				= Reciever
		.Subject		= Title    
		.HTMLBody       = Body   
		If (Attach<>"") Then
			.AddAttachment  Attach
		End If
		.Send     
	End With
	
	Set iConf = Nothing
	Set iMsg = Nothing
End Function

Function ChContent(CheckValue, tag)
'게시판에서 글쓰기 할때 html적용 여부에 따른 변환값을 리턴해주는 함수
	Dim Content
	If Cint(tag)=0 Then
		Content = Server.HTMLEncode(CheckValue)
		'Content = Replace(CheckValue,chr(13),"<br>")
	Else
		Content = Replace(CheckValue,chr(13),"<br>")
	End If
	
	ChContent = Content
End Function

Function GetFileSystemObject()
 '파일시스템 오브젝트를 얻어온다
 '반환은 SetFreeObj(fso)로 한다
	Err.Clear 
	On Error Resume Next
		Set fso = CreateObject("Scripting.FileSystemObject")	
	If err.number <> 0 Then
		GetFileSystemObject = False
	Else
		GetFileSystemObject = True
	End If
End Function

Function GetTextFile(ByVal FilePath,ByVal IOMode,ByVal CreateMode)
'FilePath로 주어진 텍스트 파일을 읽어온다
'IOMode >> ForReading = 1, ForWriting = 2, ForAppending = 8 
'CreateMode >> True, False
	Dim Path
	
	Err.Clear 
	On Error Resume Next
		Path = Server.MapPath(FilePath)
		Set fp = fso.OpenTextFile(Path,IOMode,CreateMode) 
		lpstr = fp.ReadAll()
	If err.number <> 0 Then
		'Response.Write err.Description
		GetTextFile = False
	Else
		GetTextFile = lpstr
	End If
End Function


Sub ArraryInit(ByRef arr)
	For i=0 To Ubound(arr) Step 1
		arr(i) = ""
	Next
End Sub


function CheckWord(cw)
' 문자 변환
	cw = replace(cw,"&","&amp;")
	cw = replace(cw,"<","&lt;")
	cw = replace(cw,">","&gt;")
	cw = replace(cw,chr(34),"&quot;")
	cw = replace(cw,"'","''")	
	cw = trim(cw)
	CheckWord = cw

end function

function decreaseTitle(title,size)
	Dim tmpStr : tmpStr = ""
	if (len(title)>size) then
		tmpStr = Left(title,size) & "..."
	else
		tmpStr = title
	end if

	decreaseTitle = tmpStr
end function


Function getGUID() '유일한 guid 값 얻기
  Dim tmpTemp
  tmpTemp = Right(String(4,48) & Year(Now()),4)
  tmpTemp = tmpTemp & Right(String(4,48) & Month(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Day(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Hour(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Minute(Now()),2)
  tmpTemp = tmpTemp & Right(String(4,48) & Second(Now()),2)
  getGUID = tmpTemp
End Function


Function GetFileExt(filename)
	'파일 확장자 구하기
	Dim Res : Res = ""

	if (filename<>"") then
		Res = Split(filename,".")(1)
	end if

	GetFileExt = Res

End Function


Function IsImage(ext) 
	'이미지인지
	Dim Res  : Res = false
	Dim ImgExts : ImgExts = Array("jpe","jpeg","jpg","gif","bmp","png")
	
	for i=0 to Ubound(ImgExts) step 1
		if trim(LCase(ext))=trim(ImgExts(i)) then
			Res = True
		end if
	Next
	IsImage = Res
End Function


function setThumbnail(w,h,path,filename)
	
	if GetFileExt(filename)<>"" then

		if IsImage(GetFileExt(filename)) then

			Set Image = Server.CreateObject("Nanumi.ImagePlus")
			'Response.Write "Here : " & Server.MapPath(path)
			Image.OpenImageFile Server.MapPath(path) & "\" & filename
			Image.ChangeSize w, h
			Image.SaveFile Server.MapPath(path) & "\thumb\" & filename
			Image.Dispose
			Set Image = Nothing

		end if

	end if

end function


Function IsMov(ext) 
	Dim Res  : Res = false
	Dim MovExts : MovExts = Array("mov","wmv","asf","mpg","mpe","mpeg","avi")
	
	for i=0 to Ubound(MovExts) step 1
		if trim(LCase(ext))=trim(MovExts(i)) then
			Res = True
		end if
	Next
	IsMov = Res
End Function


Function IsFlash(ext) 
	Dim Res  : Res = false
	Dim FlashExts : FlashExts = Array("swf")
	
	for i=0 to Ubound(FlashExts) step 1
		if trim(LCase(ext))=trim(FlashExts(i)) then
			Res = True
		end if
	Next
	IsFlash = Res
End Function


Function GetAspUploadObject(mus)
 '파일시스템 오브젝트를 얻어온다
 '반환은 SetFreeObj(fso)로 한다
	Err.Clear 
	On Error Resume Next
		Set theForm = Server.CreateObject("ABCUpload4.XForm")

		theForm.MaxUploadSize = mus * 1024 * 1024
		theForm.AbsolutePath = true     ' 업로드시 서버에 절대 경로를 사용한다.
		theForm.CodePage = 949			' 업로드시 한글을 지원한다.
		theForm.Overwrite = false

	If err.number <> 0 Then
		GetAspUploadObject = False
	Else
		GetAspUploadObject = True
	End If
End Function


Function SetAspUploadPath(path)
	
	uploadPath = path
	'Response.Write "path : " & path & "<br>"

	if not fso.folderexists(server.mappath(Path)) then 	
		fso.createfolder(server.mappath(Path)) '해당 게시판 파일 업로드용 디렉토리 생성
	end if
End Function


function SetAspUploadOk(ByRef theField, ByVal upPath)
	
	FileName = ""
	if Len(theField.SafeFileName) > 0 then
		bExist = true
		countFileName = 0
		While bExist
			FileName = getGUID & "_" & countFileName & "." & theField.FileType
			saveFileName = Server.MapPath(upPath) & "/" & getGUID & "_" & countFileName & "." & theField.FileType
			If (not Fso.FileExists(saveFileName)) Then
				bExist = False
			else
				countFileName = countFileName  + 1
			End If
		Wend

		theField.Save saveFileName
	End if
	
	SetAspUploadOk = FileName

End function

Function htmlToEncode(str)
  str = Replace(Trim(str),"'","&acute;")
  str = Replace(str,"""","&quot;")
  str = Replace(str,"<","&lt;")
  str = Replace(str,">","&gt;")  
  htmlToEncode = str
End Function

Function htmlToDecode(str)  
  str = Replace(Trim(str),"&acute;","'")  
  str = Replace(Trim(str),"&quot;","""")
  str = Replace(str,"&lt;","<")
  str = Replace(str,"&gt;",">")
  htmlToDecode = str
End Function

function req(ByVal str) 'deny sql injection 
	lpstr = str
	lpstr = Replace(lpstr,"'","''")
	lpstr = Replace(lpstr,";",";;")
	lpstr = Replace(lpstr,"sp_","")
	lpstr = Replace(lpstr,"xp_","")
	lpstr = Replace(lpstr,"insert","")
	lpstr = Replace(lpstr,"update","")
	lpstr = Replace(lpstr,"delete","")
	lpstr = Replace(lpstr,"union","")
	lpstr = Replace(lpstr,"exec","")
	lpstr = Replace(lpstr,"--","")

	req = lpstr
end function


function blockReflesh5(Byval url, ByVal qs)
	
	Dim realUrl
	realUrl = url
	if (trim(qs)<>"") then
		realUrl = realUrl & "?" & qs
	end if

	if trim(Request.Cookies("START_TIME"))="" then
		Response.Cookies("START_TIME")=getGUID()
	else
		if Cint(Abs(Request.Cookies("START_TIME")-getGUID())) <=5 then
			%>
			<script language="javascript">
				//alert("※ 경 고 ※\n\n\n- 5초이내에 재실행 하실수 없습니다\n\n- 원래 페이지로 이동합니다");
				alert("※ 경 고 ※\n\n\n- 5초이내에 재실행 하실수 없습니다");

				//function gohistorybacktoorignalpage() {
				//	location.replace("<%'=realUrl%>");
				//}
				//setTimeout("gohistorybacktoorignalpage()",500);
			</script>
			<%
		else 
			Response.Cookies("START_TIME") = ""
		end if
	end if

end Function


Function getUUID() 
	
	Dim uuid_obj,uuid
	set uuid_obj = Server.CreateObject("Scriptlet.Typelib")
	uuid = CStr(escape(uuid_obj.guid))
	uuid = Replace(uuid,"{","")
	uuid = Replace(uuid,"}","")
	set uuid_obj = Nothing 
	getUUID = uuid

End Function

%>