<%
'//작성자 : gigatera
'//설  명 : 데이타베이스 관련 함수 모음

Public Function GetDbConn() 
	ConnStr = "provider=MSOLEDBSQL;server=localhost;uid=sa;pwd=password;database=gigatera" 'for MSOLEDBSQL 2019
	'ConnStr = "provider=sqloledb;server=localhost;uid=sa;pwd=password;database=gigatera" 'for oledb
	'ConnStr = "Provider=SQLNCLI;Server=localhost\SQLExpress;Database=gigatera;UID=gigatera;PWD=password;" 'for express
	'Err.Clear
	'On Error Resume Next
		Set oConn = Server.CreateObject("Adodb.Connection")  
		oConn.CursorLocation = 3 'AdUseClient
		oConn.Open(ConnStr)
	'If err.number <> 0 Then
	'	GetDbConn = False
	'Else
		GetDbConn = True
	'End If
End Function


Public Function GetRs()
'레코드셋을 얻어온다
	Err.Clear
	On Error Resume Next
		Set oRs = Server.CreateObject("Adodb.RecordSet")
	If err.number  <> 0 Then
		GetRs = False
	Else
		GetRs = True
	End If
End Function


Public Sub SetFreeObj(ByRef obj)  
'객체 디스트럭터
'객체를 메모리에서 없애주는 함수
	If Not obj Is Nothing Then
		Set obj = Nothing
	End If
End Sub
%>