<center><style type="text/css">
<!--
table {
	font-size: 12px;
}
-->
</style>
<a href=http://asp5.6to23.com/cccqcn/counter/allyjcnt.asp>IP Query</a>

<%
Dim cmdQuery	'As ADODB.Command
Dim stuSET	'As ADODB.Recordset
Dim expSET	'As ADODB.Recordset

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\yjhx\studb.mdb")
dcnDB.Open

Set cmdQuery=Server.CreateObject("ADODB.Command")
Set cmdQuery.ActiveConnection=dcnDB

cmdQuery.CommandText="select * from students order by xuehao"
Set stuSET=cmdQuery.Execute

Response.Write "<table width=800 border=1><caption>ѧ��ע����Ϣ</caption><tr><td align=center><form action=http://localhost/yjhx/studel.asp method=POST>ѧ��<input name=password size=6 maxlength=6></td><td align=center>����</td><td align=center>Email</td><td align=center>QQ</td><td align=center>��¼����</td>"
do while not stuSET.EOF 
Response.Write "<tr><td align=center><input type=submit name=xuehao value="&stuSET(0)&"></td>"
Response.Write "<td>"&stuSET(1)&"</td><td>"&stuSET(3)&"</td><td>"&stuSET(4)&"</td><td>"&stuSET(5)&"</td></tr>"
stuSET.MoveNext
loop
Response.Write "</form></table> <br>"

cmdQuery.CommandText="select * from stuexp order by xuehao"
Set expSET=cmdQuery.Execute

Response.Write "<table width=800 border=1><caption>ѧ��ʵ����Ϣ</caption><tr><td align=center>ѧ��</td><td align=center>����</td><td align=center>��¼ʱ��</td><td align=center>ע��ʱ��</td><td align=center>�ɼ�</td>"
do while not expSET.EOF
Response.Write "<tr><td align=center>"&expSET(0)&"</td><td>"&expSET(1)&"</td><td>"&expSET(2)&"</td><td>"&expSET(3)&"</td><td>"&expSET(4)&"</td></tr>"
expSET.MoveNext
loop
Response.Write "</table>"

stuSET.close
expSET.close
dcnDB.close
%>
<form action=http://asp5.6to23.com/cccqcn/yjhx/expquery.asp method=POST>
<input name=xuehao value=002033130>
<input name=xingming value=cccqcn>
<input type=password name=mima value=oooooo>
<input type=submit value=Query>
</form>
</center>