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
Dim SearchOpt, SearchVal, argv
SearchOpt = req(Request("SearchOpt"))
SearchVal = req(Request("SearchVal"))
argv="SearchOpt="&SearchOpt&"&SearchVal="&SearchVal


Dim Page, intTotalCount, intTotalPage, intBlockPage, intPageSize
Dim intTemp, intLoop
Page = trim(Request("Page")) : If (Page="") Then 	Page = 1

intPageSize = 10
intBlockPage = 10

GetDbConn
GetRs

Set oCmd = Server.CreateObject("ADODB.Command")
With oCmd
	.ActiveConnection = oConn
	.CommandType = adCmdStoredProc
	.CommandText = "dbo.sp_board_list"

	.Parameters.Append .CreateParameter("@Page",adVarChar,adParamInput,10,Page)
	.Parameters.Append .CreateParameter("@intPageSize",adVarChar,adParamInput,5,intPageSize)
	.Parameters.Append .CreateParameter("@SearchOpt",adVarChar,adParamInput,10,SearchOpt)
	.Parameters.Append .CreateParameter("@SearchVal",adVarChar,adParamInput,20,SearchVal)
	.Parameters.Append .CreateParameter("@intTotalCount",adInteger,adParamOutput,0,0)
	.Parameters.Append .CreateParameter("@intTotalPage",adInteger,adParamOutput,0,0)

	Set oRs = .Execute

	intTotalCount = .Parameters("@intTotalCount") 
	intTotalPage = .Parameters("@intTotalPage") 
	'Response.Write "intTotalCount : " & intTotalCount & "<br>"
	'Response.Write "intTotalPage : " & intTotalPage & "<br>"
End With
SetFreeObj(oCmd)
%>

<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <title>리스트</title>
  <script language="javascript" type="text/javascript" src="./config/js/jquery-3.1.0.js"></script>
  <script language="javascript" type="text/javascript" src="./config/js/extend.js"></script>
  <script language="javascript" type="text/javascript">
  $(document).ready(function(){

   });
  </script>
 </head>
 <body>

	<form name="frmBoard" id="frmBoard">
	
	<div id="write">
		[<a href="write_upload.asp">글등록</a>] ... 업로드
	</div>
	<table border="1">
	<tr>
	<td align="center"><b>번호</b></td>
	<td align="center"><b>제목</b></td>
	<td align="center"><b>작성자</b></td>
	<td align="center"><b>클릭수</b></td>
	<td align="center"><b>작성일</b></td>
	</tr>
	
	<%
	Cnt = 0
	while not ors.eof and not ors.bof
		%>
		<tr>
		<td align="center"><%=(intTotalCount-((Page - 1) * intPageSize))-Cnt%></td>
		<td align="left"><img src="./images/common/level.gif" border="0" align="absmiddle" width="<%=oRs("re_lvl")*7%>"><a href="view_upload.asp?idx=<%=oRs("idx")%>&Page=<%=Page%>&<%=argv%>"><%=oRs("title")%></a></td>
		<td align="center"><%=oRs("uname")%></td>
		<td align="center"><%=oRs("count")%></td>
		<td align="center"><%=oRs("reg_date")%></td>
		</tr>
		<%
		ors.movenext
		Cnt = Cnt + 1
	wend
	%>

	</table>


	<div id="paging">
	<%
	If Cint(Page)>1 Then
		Response.Write "<a href='list_upload.asp?Page=1&"&argv&"'>[처음]</a>"
	Else
		Response.Write "[처음]"
	End If
	response.write "&nbsp;"

	intTemp = Int((Page - 1) / intBlockPage) * intBlockPage + 1

	If intTemp = 1 Then
		Response.Write "[이전]"
	Else 
		Response.Write"<a href='list_upload.asp?Page=" & intTemp - intBlockPage & "&"&argv&"'>[이전]</a>"
	End If
	response.write "&nbsp;"
	%>

	<%
	intLoop = 1
	Do Until intLoop > intBlockPage Or intTemp > intTotalPage
		If intTemp = CInt(Page) Then
			Response.Write "<b>"&intTemp&"</b>"
		Else
			Response.Write"<span><a href='list_upload.asp?Page=" & intTemp & "&"&argv&"'>"&intTemp&"</a></span>"
		End If
		response.write "&nbsp;"
		
		intTemp = intTemp + 1
		intLoop = intLoop + 1
	Loop
	response.write "&nbsp;"
	%>

	<%
	If intTemp > intTotalPage Then
		Response.Write "[다음]"
	Else
		Response.Write"<a href='list_upload.asp?Page=" & intTemp & "&"&argv&"'>[다음]</a>"
	End If
	response.write "&nbsp;"
	
	If Cint(Page) < Cint(intTotalPage) Then
		Response.Write "<a href='list_upload.asp?Page=" & intTotalPage & "&"&argv&"'>[마지막]</a> "
	Else
		Response.Write "[마지막]"
	End If
	%>
	</div>


	</form>
  
 </body>
</html>


<%
SetFreeObj(oRs)
SetFreeObj(oConn)
%>