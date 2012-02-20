<%
'Option Explicit
Const adOpenForwardOnly = 0
Const adLockReadOnly = 1

Dim dcnDB	'As ADODB.Connection
Dim azSET	'As ADODB.Recordset
Dim minscore,i

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\a2z\azscore.mdb")
dcnDB.Open

Set azSET=Server.CreateObject("ADODB.Recordset")
azSET.Open "select * from azscore order by score",dcnDB,adOpenForwardOnly,adLockReadOnly

i=0
do while (not azSET.EOF) and i<29
azSET.movenext
i=i+1
loop

if azSET.EOF then
minscore=""
else
minscore=azSET(1)
end if

Response.Write "minscore="&minscore

azSET.close
dcnDB.close
%>