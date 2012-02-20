<%
'Option Explicit
Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim yqSET	'As ADODB.Recordset
Dim xuehao,name

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\yiqidb.mdb")
dcnDB.Open

xuehao=Request.Form("xuehao")
name=Request.Form("name")

Set yqSET=Server.CreateObject("ADODB.Recordset")
yqSET.Open "select * from yiqi where xuehao='"&xuehao&"' and name='"&name&"'",dcnDB,adOpenKeyset,adLockOptimistic

if (yqSET.EOF) then
Response.Write "error=71"
else
Response.Write "error=0"
delrec xuehao,name
end if

Sub delrec(xuehao,name)
dcnDB.Execute "delete from yiqi where xuehao='"&xuehao&"' and name='"&name&"'"
End Sub

yqSET.close
dcnDB.close
%>