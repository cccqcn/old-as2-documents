<%
'Option Explicit

Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim stuSET	'As ADODB.Recordset
Dim xuehao,password

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\studb.mdb")
dcnDB.Open

xuehao=Request.Form("xuehao")
password=Request.Form("password")

Set stuSET=Server.CreateObject("ADODB.Recordset")
stuSET.Open "select * from students where xuehao='"&xuehao&"'",dcnDB,adOpenKeyset,adLockOptimistic

if (password="111111") then
if (stuSET.EOF) then
Response.Write "error=1"
else
Response.Write "error=0"
delstu xuehao
end if
end if

Sub delstu(xuehao)
dcnDB.Execute "delete from students where xuehao='"&xuehao&"'"
dcnDB.Execute "delete from stuexp where xuehao='"&xuehao&"'"
End Sub

stuSET.close
dcnDB.close
%>