<%
'Option Explicit

Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim expSET	'As ADODB.Recordset
Dim xuehao,counter,score

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\studb.mdb")
dcnDB.Open

xuehao=Request.Form("xuehao")
counter=Request.Form("counter")
score=Request.Form("score")

Set expSET=Server.CreateObject("ADODB.Recordset")
expSET.Open "select * from stuexp where xuehao='"&xuehao&"' and counter="&counter,dcnDB,adOpenKeyset,adLockOptimistic

if (expSET.EOF) then
Response.Write "error=30"
else
Response.Write "error=0"
modifyexp score
end if

Sub modifyexp(score)
Dim curdate,curtime,day0,month0,time0
curdate=Date()
curtime=Time()
day0=Day(curdate)
month0=Month(curdate)
time0=split(curtime,":")
if(day0<10)then
day0="0"&day0
end if
if(month0<10)then
month0="0"&month0
end if
expSET("logouttime")=time0(0)&time0(1)&time0(2)&month0&day0&Year(curdate)
expSET("score")=score
expSET.Update
End Sub

expSET.close
dcnDB.close
%>