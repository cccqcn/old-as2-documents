<%
'Option Explicit
Const adOpenForwardOnly = 0
Const adLockReadOnly = 1

Dim dcnDB	'As ADODB.Connection
Dim yqSET	'As ADODB.Recordset
Dim xuehao,name

xuehao=Request.QueryString("xuehao")
name=Request.QueryString("name")

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\yiqidb.mdb")
dcnDB.Open

Set yqSET=Server.CreateObject("ADODB.Recordset")
yqSET.Open "select * from yiqi order by name",dcnDB,adOpenForwardOnly,adLockReadOnly

if (yqSET.EOF) then
Response.Write "error=61"
else
Response.Write "error=0&yqstring=<br><table border=1>"
outputyq name
end if

Sub outputyq(name)
Dim i,str
do while not yqSET.EOF
Response.Write "<tr><td>"
for i=0 to 9
Response.Write yqSET(i)&"</td><td>"
next
yqSET.MoveNext
Response.Write "</td></tr>"
Loop
Response.Write "</table>"
End Sub

yqSET.close
dcnDB.close
%>