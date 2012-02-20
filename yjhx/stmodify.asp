<%
'Option Explicit

Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim stuSET	'As ADODB.Recordset
Dim xuehao,xingming,yuanmima,mima,email,qq

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\studb.mdb")
dcnDB.Open

xuehao=Request.Form("xuehao")
xingming=Request.Form("xingming")
yuanmima=Request.Form("yuanmima")
mima=Request.Form("mima")
email=Request.Form("email")
qq=Request.Form("qq")

Set stuSET=Server.CreateObject("ADODB.Recordset")
stuSET.Open "select * from students where xuehao='"&xuehao&"'",dcnDB,adOpenKeyset,adLockOptimistic

if (stuSET.EOF) then
Response.Write "error=40"
else
if (yuanmima="")then
if (xingming<>stuSET(1)) then
Response.Write "error=42"
else
Response.Write "error=0&xingming="&stuSET(1)&"&email="&stuSET(3)&"&qq="&stuSET(4)
end if
else
if (yuanmima<>stuSET(2)) then
Response.Write "error=41"
else
Response.Write "error=0"
modifystu xingming,mima,email,qq
end if
end if
end if

Sub modifystu(xingming,mima,email,qq)
stuSET("xingming")=xingming
if (mima<>"") then
stuSET("mima")=mima
end if
stuSET("email")=email
stuSET("qq")=qq
stuSET.Update
End Sub

stuSET.close
dcnDB.close
%>