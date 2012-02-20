<%
'Option Explicit

Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim stuSET	'As ADODB.Recordset
Dim expSET	'As ADODB.Recordset
Dim xuehao,xingming,mima,email,qq

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\studb.mdb")
dcnDB.Open

xuehao=Request.Form("xuehao")
xingming=Request.Form("xingming")
mima=Request.Form("mima")
email=Request.Form("email")
qq=Request.Form("qq")

Set stuSET=Server.CreateObject("ADODB.Recordset")
stuSET.Open "select * from students where xuehao='"&xuehao&"'",dcnDB,adOpenKeyset,adLockOptimistic
Set expSET=Server.CreateObject("ADODB.Recordset")
expSET.Open "select * from stuexp where xuehao='"&xuehao&"'",dcnDB,adOpenKeyset,adLockOptimistic

if (not stuSET.EOF) then
Response.Write "error=10"
else
Response.Write "error=0"
insertstu xuehao,xingming,mima,email,qq
insertexp xuehao
end if

Sub insertstu(xuehao,xingming,mima,email,qq)
stuSET.AddNew
stuSET("xuehao")=xuehao
stuSET("xingming")=xingming
stuSET("mima")=mima
if (email<>"") then
stuSET("email")=email
end if
if (qq<>"") then
stuSET("qq")=qq
end if
stuSET("counter")=1
stuSET.Update
End Sub

Sub insertexp(xuehao)
Dim curdate,curtime,day0,month0,time0
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
expSET.AddNew
expSET("xuehao")=xuehao
expSET("logintime")=time0(0)&time0(1)&time0(2)&month0&day0&Year(curdate)
expSET("counter")=1
expSET.Update
End Sub

stuSET.close
expSET.close
dcnDB.close
%>