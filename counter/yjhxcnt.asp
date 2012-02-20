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

Response.Write "counter="&(yjSET(0)+1)
yjSET("yjhxcnt")=yjSET(0)+1
yjSET.Update

Dim curdate,curtime,day0,month0,time0
Dim userip
curdate=Date()
curtime=Time()
day0=Day(curdate)
month0=Month(curdate)
time0=split(curtime,":")
if(time0(0)<10)then
time0(0)="0"&time0(0)
end if
if(day0<10)then
day0="0"&day0
end if
if(month0<10)then
month0="0"&month0
end if
userip = Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
if userip = "" then 
userip = Request.ServerVariables("REMOTE_ADDR")
end if
yjipSET.AddNew
yjipSET("yjhxip")=userip
yjipSET("curtime")=time0(0)&time0(1)&time0(2)&month0&day0&Year(curdate)
yjipSET.Update

yjSET.close
dcnDB.close
%> 