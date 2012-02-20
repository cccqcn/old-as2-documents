<!--#include file="conn.asp"-->
<%

dim conn
set conn=server.createobject("adodb.connection")
conn.open str
Response.Buffer=true%>
<%
dim uid
uid=request("erro")
strSql="UPDATE 在线用户表 SET RefreshTime='"&now&"' WHERE id='"&uid&"'"
conn.Execute(strSql)

set rootRs=server.createobject("adodb.recordset")
rootRs.open"SELECT * FROM 聊天表 ORDER BY ID",conn
%>
<%response.write("&b=")%>
<%i=0%>
<%Do While Not rootRs.Eof and i<=10
set rootRs1=server.createobject("adodb.recordset")
rootRs1.open"SELECT * FROM 在线用户表 WHERE id="&rootRs.fields.item("用户").value,conn
%>
<%i=i+1%>
<%="用户:"&(rootRs1.fields.item("user").value)&"　"%> 
<%="头像:"&(rootRs.fields.item("头像").value)&"　"%>
<%="时间:"&(rootRs.fields.item("时间").value)%>　
<%="内容:"&(rootRs.fields.item("内容").value)%>
--------------------------------------------------
<%rootRs.MoveNext
Loop%>
<%="&"%>
<%
set rootRs2=server.createobject("adodb.recordset")
rootRs2.open"select* from 在线用户表",conn,1,3
time1=now
response.Write("ul=")
Do While Not rootRs2.Eof
if((((now-rootRs2.fields.item("RefreshTime").value)*100000))>20)then 
rootRs2.delete
rootRs2.movenext
end if
if(not rootRs2.Eof)then
set rootRs3=server.createobject("adodb.recordset")
rootRs3.open"SELECT * FROM 在线用户表 WHERE id="&rootRs2.fields.item("id").value,conn
response.Write("<img  hspace=""16"" vspace=""16"" src="""&rootRs3.fields.item("head").value&""">"&rootRs3.fields.item("user").value&chr(10)&chr(10))
rootRs3.Close()
Set rootRs3 = Nothing
end if
rootRs2.movenext
loop

rootRs.Close()
Set rootRs = Nothing
rootRs1.Close()
Set rootRs1 = Nothing
rootRs2.Close()
Set rootRs2 = Nothing
conn.close
Set conn=nothing
'<meta http-equiv="refresh" content="30,#">
%>