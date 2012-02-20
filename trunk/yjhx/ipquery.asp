<center>
<%
'Option Explicit
Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim yjSET	'As ADODB.Recordset
Dim yjipSET

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\counter\counter.mdb")
dcnDB.Open

Set yjSET=Server.CreateObject("ADODB.Recordset")
yjSET.Open "select yjhxcnt from counters",dcnDB,adOpenKeyset,adLockOptimistic
Set yjipSET=Server.CreateObject("ADODB.Recordset")
yjipSET.Open "select * from yjhxips",dcnDB,adOpenKeyset,adLockOptimistic

Response.Write "<table width=800 border=1><caption>´ò¿ª¼ÇÂ¼</caption><tr><td align=center>1</td><td align=center>2</td></tr>"
do while not yjipSET.EOF
Response.Write "<tr><td align=center>"&yjipSET(0)&"</td><td>"&yjipSET(1)&"</tr>"
yjipSET.MoveNext
loop
Response.Write "</table>"

Response.Write "counter="&(yjSET(0)+1)
%>
</center>