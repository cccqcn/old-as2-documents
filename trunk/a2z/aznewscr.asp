<%
'Option Explicit
Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim azSET	'As ADODB.Recordset
Dim name,score
Dim minname,minscore,minip,mincurtime,i

name=Request.Form("xingming")
score=Request.Form("score")

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\a2z\azscore.mdb")
dcnDB.Open

Set azSET=Server.CreateObject("ADODB.Recordset")
azSET.Open "select * from azscore order by score desc",dcnDB,adOpenKeyset,adLockOptimistic

if not azSET.EOF then
minname=azSET(0)
minscore=azSET(1)
minip=azSET(2)
mincurtime=azSET(3)
end if

i=0
do while not azSET.EOF
azSET.movenext
i=i+1
loop

if i<30 then
insert name,score
else 
dcnDB.Execute "delete from azscore where ipaddress='"&minip&"' and curtime='"&mincurtime&"'"
insert name,score
end if

Sub insert(name,score)
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
azSET.AddNew
azSET("name")=name
azSET("score")=score
azSET("ipaddress")=userip
azSET("curtime")=time0(0)&time0(1)&time0(2)&month0&day0&Year(curdate)
azSET.Update
End Sub

azSET.close
dcnDB.close
%>