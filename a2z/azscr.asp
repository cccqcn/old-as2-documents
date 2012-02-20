<%
'Option Explicit
Const adOpenForwardOnly = 0
Const adLockReadOnly = 1

Dim dcnDB	'As ADODB.Connection
Dim azSET	'As ADODB.Recordset
Dim i,j

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\a2z\azscore.mdb")
dcnDB.Open

Set azSET=Server.CreateObject("ADODB.Recordset")
azSET.Open "select * from azscore order by score desc",dcnDB,adOpenForwardOnly,adLockReadOnly

j=1
Response.Write "<table border=1><tr><td>名次</td><td>姓名</td><td>成绩</td><td>IP地址</td><td>测试时间</td></tr>"
do while not azSET.EOF
Response.Write "<tr><td>"&j&"</td><td>"
for i=0 to 2
Response.Write azSET(i)&"</td><td>"
next
timestr=Mid(azSET(3),1,2)&":"&Mid(azSET(3),3,2)&":"&Mid(azSET(3),5,2)&" "&Mid(azSET(3),7,2)&"-"&Mid(azSET(3),9,2)&"-"&Mid(azSET(3),11)
Response.Write timestr&"</td><td>"
azSET.MoveNext
j=j+1
Response.Write "</td></tr>"
Loop
Response.Write "</table>"

azSET.close
dcnDB.close
%>