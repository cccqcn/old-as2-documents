<!--#include file="conn.asp"-->
<%
dim conn
set conn=server.createobject("adodb.connection")
conn.open str
dim varb,uid
varb=request.form("root")
uid=request.form("erro")
time1=now
set rootRs1=server.createobject("adodb.recordset")
rootRs1.open"select* from 在线用户表",conn
dim flag
flag=0
Do While Not rootRs1.Eof
if(rootRs1.fields.item("id").value=uid)then flag=1
rootRs1.movenext
loop
if(flag=1)then
set rootRs=server.createobject("adodb.recordset")
rootRs.open"select* from 聊天表",conn
strSql="Insert Into 聊天表(用户,时间,内容) Values('"&uid&"' ,'"&time1&"' ,'"&varb&"')"
conn.Execute(strSql)
end if

rootRs.Close()
Set rootRs = Nothing
rootRs1.Close()
Set rootRs1 = Nothing
conn.close
Set conn=nothing
%>