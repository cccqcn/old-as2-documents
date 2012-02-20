<% 
'Option Explicit
Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim cntSET	'As ADODB.Recordset
Dim ipSET

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\counter\counter.mdb")
dcnDB.Open

Set cntSET=Server.CreateObject("ADODB.Recordset")
cntSET.Open "select counter from counters",dcnDB,adOpenKeyset,adLockOptimistic
Set ipSET=Server.CreateObject("ADODB.Recordset")
ipSET.Open "select * from ips",dcnDB,adOpenKeyset,adLockOptimistic

Response.Write "document.write("""&(cntSET(0)+1)&""");"
cntSET("counter")=cntSET(0)+1
cntSET.Update

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
ipSET.AddNew
ipSET("ip")=userip
ipSET("curtime")=time0(0)&time0(1)&time0(2)&month0&day0&Year(curdate)
ipSET.Update

cntSET.close
dcnDB.close
%> 