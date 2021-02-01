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
Dim idx,Page,SearchOpt,SearchVal
idx = req(Request.QueryString("idx"))
Page = req(Request.QueryString("Page"))
SearchOpt = req(Request.QueryString("SearchOpt"))
SearchVal = req(Request.QueryString("SearchVal"))

if idx="" then Response.Write "<li>글번호가 없습니다</li>" : Response.end
if Page="" then Response.Write "<li>페이지 번호가 없습니다</li>" : Response.end

Dim count_done 
count_done = trim(Request.Cookies("count_done")(idx))
'Response.Write "aa : " & count_done

GetDbConn
GetRs

Set oCmd = Server.CreateObject("ADODB.Command")
With oCmd
	.ActiveConnection = oConn
	.CommandType = adCmdStoredProc
	.CommandText = "dbo.sp_board_view"

	.Parameters.Append .CreateParameter("@idx",adVarChar,adParamInput,10,idx)
	.Parameters.Append .CreateParameter("@count_done",adChar,adParamInput,1,count_done)

	Set oRs = .Execute
End With
SetFreeObj(oCmd)
%>

<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <title>상세보기</title>
  <script language="javascript" type="text/javascript" src="./config/js/jquery-3.1.0.js"></script>
  <script language="javascript" type="text/javascript" src="./config/js/jquery.bpopup.min.js"></script>
  <script language="javascript" type="text/javascript" src="./config/js/extend.js?v=2020-07-23-001"></script>
  <script language="javascript" type="text/javascript">
  $(document).ready(function(){
		
		var $idx = $("#idx").val();
		var $Page = $("#Page").val();
		var $SearchOpt = $("#SearchOpt").val();
		var $SearchVal = $("#SearchVal").val();
		var $ref = $("#ref").val();
		var $re_step = $("#re_step").val();
		var $re_lvl = $("#re_lvl").val();

		$("#btnList").on("click",function(){
			location.href = "list.asp?Page="+$Page+"&SearchOpt="+$SearchOpt+"&SearchVal="+$SearchVal;
		});

		$("#btnReply").on("click",function(){
			location.href = "reply.asp?idx="+$idx+"&Page="+$Page+"&SearchOpt="+$SearchOpt+"&SearchVal="+$SearchVal+"&ref="+$ref+"&re_step="+$re_step+"&re_lvl="+$re_lvl;
		});

		$("#btnDel").on("click",function(){
			$('#popPwd').bPopup(
				{modalClose: true},
				function(){ $("#pwdChk").val('').focus(); }
			);
		});

		$("#btnMod").on("click",function(){
			location.href = "mod.asp?idx="+$idx+"&Page="+$Page+"&SearchOpt="+$SearchOpt+"&SearchVal="+$SearchVal;
		});

		$("#btnPwdChkOk").on("click",function(e){
			var $res = "";
			var $pwd = $("#pwdChk");
			if (!$pwd.getRightPwd()) {
				alert("비밀번호가 올바르지 않습니다\n\n- 영문,숫자,특수문자 조합으로 8~16자이어야합니다");
				$pwd.focus();
				return false;
			}
			//alert("idx="+$idx+"&pwd="+escape($pwd.val()));
			$.ajax({
				type: "GET",
				async: false,
				url: "pwdChk.asp",
				data: "idx="+$idx+"&pwd="+escape($pwd.val())
			}).fail(function(request,status,error) {  //error
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}).done(function(msg) {
				$res = msg;
			});
			if ($res!='ok') {
				alert($res);
			} else {
				alert("비밀번호가 확인되었습니다")
				$("#pwd").val($("#pwdChk").val());
				$("#frmBoard").attr({'action':'del_ok.asp','method':'post'}).submit();
			}
		});

   });
  </script>
  <style type="text/css">
  #popPwd {
	width:500px;
	height:160px;
	border:1px solid gray;
	display:none;
	background-color:white;
	position:relative;
  }
  #popPwd #bClose {
	position:absolute;
	right:-10px;
	top:-30px;
	font:arial-black;
	font-size:36px;
	font-weight:bold;
	color:black;
	background-color:yellow;
	width:40px;
	height:40px;
	line-height:40px;
	text-align:center;
	cursor:pointer;
  }

  #popPwd #pwdcheckbody {
	margin-left:20px;
	margin-top:20px;
  }
  </style>
 </head>
 <body>

	<form name="frmBoard" id="frmBoard">
		<input type="hidden" name="idx" id="idx" value="<%=idx%>">
		<input type="hidden" name="Page" id="Page" value="<%=Page%>">
		<input type="hidden" name="SearchOpt" id="SearchOpt" value="<%=SearchOpt%>">
		<input type="hidden" name="SearchVal" id="SearchVal" value="<%=SearchVal%>">
		<input type="hidden" name="ref" id="ref" value="<%=trim(oRs("ref"))%>">
		<input type="hidden" name="re_step" id="re_step" value="<%=trim(oRs("re_step"))%>">
		<input type="hidden" name="re_lvl" id="re_lvl" value="<%=trim(oRs("re_lvl"))%>">
		<input type="hidden" name="pwd" id="pwd" value="">

		<table border="1">
		<tr>
		<td align="center"><b>작성자</b></td><td><%=trim(oRs("uname"))%></td>
		</tr>
		<tr>
		<td align="center"><b>제목</b></td><td><%=ChContent(trim(oRs("title")), 0)%></td>
		</tr>
		<tr>
		<td align="center"><b>내용</b></td><td><%=ChContent(trim(oRs("contents")), 1)%></td>
		</tr>
		<tr>
		<td align="center"><b>클릭수</b></td><td><%=trim(oRs("count"))%></td>
		</tr>
		<tr>
		<td align="center"><b>아이피</b></td><td><%=trim(oRs("reg_ip"))%></td>
		</tr>
		<tr>
		<td align="center"><b>등록일</b></td><td><%=trim(oRs("reg_date"))%></td>
		</tr>
		<tr>
		<td align="center"><b>수정일</b></td><td><%=trim(oRs("mod_date"))%></td>
		</tr>
		</table>
		<div>
			<input type="button" value="리스트" id="btnList" />
			<input type="button" value="답글" id="btnReply" />
			<input type="button" value="수정" id="btnMod" alt="수정" />
			<input type="button" value="삭제" id="btnDel" alt="삭제" />
		</div>

		<div id="popPwd" class="b-close">
			<div id="bClose" class="b-close">
				X
			</div>
			<div id="pwdcheckbody">
				<b>● 비밀번호 확인</b> <br><br>
				해당글 삭제를 위해 글 비밀번호를 입력하세요<br><br>

				<input type="password" name="pwdChk" id="pwdChk" value="" placeholder="비밀번호" minlength="8" maxlength="16">
				<input type="button" value="확인" id="btnPwdChkOk">
			</div>
		</div>

	</form>
  
 </body>
</html>


<%
Response.Cookies("count_done")(idx) = 1

SetFreeObj(oRs)
SetFreeObj(oConn)
%>

