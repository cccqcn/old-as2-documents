<%
'Option Explicit
Const adOpenForwardOnly = 0
Const adLockReadOnly = 1

Dim dcnDB	'As ADODB.Connection
Dim yjSET	'As ADODB.Recordset
Dim i,j,timestr

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\counter\counter.mdb")
dcnDB.Open

Set yjSET=Server.CreateObject("ADODB.Recordset")
yjSET.Open "select * from yjhxips",dcnDB,adOpenForwardOnly,adLockReadOnly

j=1
Response.Write "<table border=1><tr><td></td><td>IP</td><td>TIME</td></tr>"
do while not yjSET.EOF
Response.Write "<tr><td>"&j&"</td><td>"
Response.Write yjSET(1)&"</td><td>"
timestr=Mid(yjSET(2),1,2)&":"&Mid(yjSET(2),3,2)&":"&Mid(yjSET(2),5,2)&" "&Mid(yjSET(2),7,2)&"-"&Mid(yjSET(2),9,2)&"-"&Mid(yjSET(2),11)
Response.Write timestr&"</td><td>"
yjSET.MoveNext
j=j+1
Response.Write "</td></tr>"
Loop
Response.Write "</table>"

yjSET.close
dcnDB.close
%>