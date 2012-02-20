<%
'Option Explicit

Const adOpenForwardOnly = 0
Const adLockReadOnly = 1

Dim dcnDB	'As ADODB.Connection
Dim yqSET	'As ADODB.Recordset
Dim xuehao,name,i

xuehao=Request.Form("xuehao")
name=Request.Form("name")

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\yiqidb.mdb")
dcnDB.Open

Set yqSET=Server.CreateObject("ADODB.Recordset")
if(name="")then
yqSET.Open "select xuehao,name,curtime,i from yiqi where xuehao='"&xuehao&"' order by name",dcnDB,adOpenForwardOnly,adLockReadOnly
else
yqSET.Open "select * from yiqi where xuehao='"&xuehao&"' and name='"&name&"' order by i ",dcnDB,adOpenForwardOnly,adLockReadOnly
end if

if yqSET.EOF then
Response.Write "error=61"
else
if name="" then
i=0
Response.Write "error=0&yqnamelist="
do while not yqSET.EOF
if(yqSET(3)=0) then
Response.Write yqSET(1)&":"&yqSET(2)&":"
i=i+1
end if
yqSET.MoveNext
loop
Response.Write "&yqnumber="&i
else
Response.Write "error=0&yqstring="
outputyq xuehao,name
end if
end if

Sub outputyq(xuehao,name)
do while not yqSET.EOF
for i=2 to 7
Response.Write yqSET(i)&":"
next
yqSET.MoveNext
loop
End Sub

yqSET.close
dcnDB.close
%>