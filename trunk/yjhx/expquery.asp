<%
Const adOpenForwardOnly = 0
Const adLockReadOnly = 1

Dim dcnDB	'As ADODB.Connection
Dim cmdQuery	'As ADODB.Command
Dim stuSET	'As ADODB.Recordset
Dim expSET	'As ADODB.Recordset
Dim xuehao,xingming,mima

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\studb.mdb")
dcnDB.Open

xuehao=Request.Form("xuehao")
xingming=Request.Form("xingming")
mima=Request.Form("mima")

Set stuSET=Server.CreateObject("ADODB.Recordset")
stuSET.Open "select xuehao,xingming,mima,counter from students where xuehao='"&xuehao&"'",dcnDB,adOpenForwardOnly,adLockReadOnly
Set expSET=Server.CreateObject("ADODB.Recordset")
expSET.Open "select * from stuexp where xuehao='"&xuehao&"' order by counter desc",dcnDB,adOpenForwardOnly,adLockreadOnly

if (stuSET.EOF) then
Response.Write "error=52"
else if (xingming<>stuSET(1)) then
Response.Write "error=51"
else if (mima<>stuSET(2)) then
Response.Write "error=53"
else
Response.Write "error=0&query="
showexp
end if
end if
end if

Sub showexp
do while not expSET.EOF
Response.Write "p"&expSET(1)&"t"&expSET(2)&"t"&expSET(3)&"t"&expSET(4)
expSET.MoveNext
loop
Response.Write "e"
End Sub

stuSET.close
expSET.close
dcnDB.close
%>