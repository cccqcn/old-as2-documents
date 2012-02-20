<%
'Option Explicit

Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim score

score=Request.QueryString("score")

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\a2z\azscore.mdb")
dcnDB.Open

if score="-123456" then
dcnDB.Execute "delete from azscore"
Response.Write "Ready!"
end if

dcnDB.close
%>