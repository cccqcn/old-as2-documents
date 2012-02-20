<!--#include file="conn.asp"-->
<%
dim conn
set conn=server.createobject("adodb.connection")
conn.open str
dim vara,varb,varc
vara=request("y")
varb=request("headpic")
time1=now
If not conn.Execute("Select * From 在线用户表 where user='"&vara&"'" ).eof Then
'注册失败原因用户存在
response.write("erro=0")
  else
strSql="Insert Into 在线用户表(user,time2,head) Values('"&vara&"' ,'"&time1&"' ,'"&varb&"')"
conn.Execute(strSql)
'注册成功
set rootRs=server.createobject("adodb.recordset")
rootRs.open"SELECT * FROM 在线用户表 order by id desc",conn
dim uid
uid=(rootRs.fields.item("id").value)
strSql="Insert Into 在线用户表(id,登陆时间,RefreshTime) Values('"&uid&"' ,'"&time1&"' ,'"&time1&"')"
conn.Execute(strSql)
response.write("erro="&uid)
end if%>

<%
rootRs.Close()
Set rootRs = Nothing
conn.close
Set conn=nothing
%>