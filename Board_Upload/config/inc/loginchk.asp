<%
Dim uid 
uid = trim(Request.Cookies("uid"))

if (uid="") then
	'Your code here
	Response.End
end if
%>