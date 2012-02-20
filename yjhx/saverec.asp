<%
'Option Explicit

Const adOpenKeyset = 1
Const adLockOptimistic = 3

Dim dcnDB	'As ADODB.Connection
Dim yqSET	'As ADODB.Recordset
Dim total,xuehao,name,yqstring

total=Request.Form("total")
xuehao=Request.Form("xuehao")
name=Request.Form("name")
yqstring=Request.Form("yqstring")

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\yiqidb.mdb")
dcnDB.Open

Set yqSET=Server.CreateObject("ADODB.Recordset")
yqSET.Open "select * from yiqi where xuehao='"&xuehao&"' and name='"&name&"'",dcnDB,adOpenKeyset,adLockOptimistic

if (not yqSET.EOF) then
Response.Write "error=51"
else
Response.Write "error=0"
insertyq total,xuehao,name,yqstring
end if

Sub insertyq(total,xuehao,name,yqstring)
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
Dim i,str
str=split(yqstring,":")
for i=total to 0 step -1
yqSET.AddNew
yqSET("xuehao")=xuehao
yqSET("name")=name
yqSET("category")=str((total-i)*6+0)
yqSET("temperature")=str((total-i)*6+1)
yqSET("x")=str((total-i)*6+2)
yqSET("y")=str((total-i)*6+3)
yqSET("rotation")=str((total-i)*6+4)
yqSET("xscale")=str((total-i)*6+5)
yqSET("i")=i
yqSET("curtime")=time0(0)&time0(1)&time0(2)&month0&day0&Year(curdate)
yqSET.Update
next
End Sub

yqSET.close
dcnDB.close
%>