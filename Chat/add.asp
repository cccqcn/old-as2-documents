<!--#include file="conn.asp"-->
<%
dim conn
set conn=server.createobject("adodb.connection")
conn.open str
dim vara,varb,varc
vara=request("y")
varb=request("headpic")
time1=now
If not conn.Execute("Select * From �����û��� where user='"&vara&"'" ).eof Then
'ע��ʧ��ԭ���û�����
response.write("erro=0")
  else
strSql="Insert Into �����û���(user,time2,head) Values('"&vara&"' ,'"&time1&"' ,'"&varb&"')"
conn.Execute(strSql)
'ע��ɹ�
set rootRs=server.createobject("adodb.recordset")
rootRs.open"SELECT * FROM �����û��� order by id desc",conn
dim uid
uid=(rootRs.fields.item("id").value)
strSql="Insert Into �����û���(id,��½ʱ��,RefreshTime) Values('"&uid&"' ,'"&time1&"' ,'"&time1&"')"
conn.Execute(strSql)
response.write("erro="&uid)
end if%>

<%
rootRs.Close()
Set rootRs = Nothing
conn.close
Set conn=nothing
%>