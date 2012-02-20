<center><style type="text/css">
<!--
table {
	font-size: 12px;
}
body {
	background-color: #00CCFF;
}
-->
</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>a2z</title>
</head>
<body bgcolor="#ffffff">
<!-- 影片中使用的 URL-->
<!-- 影片中使用的文本-->
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="400" height="300" id="a2z" align="middle">
<param name="allowScriptAccess" value="sameDomain" />
<param name="movie" value="a2z.swf" />
<param name="quality" value="high" />
<param name="bgcolor" value="#ffffff" />
<embed src="a2z.swf" quality="high" bgcolor="#ffffff" width="400" height="300" name="a2z" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>
<%
'Option Explicit
Const adOpenForwardOnly = 0
Const adLockReadOnly = 1

Dim dcnDB	'As ADODB.Connection
Dim azSET	'As ADODB.Recordset
Dim i,j

Set dcnDB = Server.CreateObject("ADODB.Connection")
dcnDB.ConnectionString="Provider=Microsoft.Jet.OLEDB.4.0;"&"Data Source="&Server.mapPath("\cccqcn\a2z\azscore.mdb")
dcnDB.Open

Set azSET=Server.CreateObject("ADODB.Recordset")
azSET.Open "select * from azscore order by score",dcnDB,adOpenForwardOnly,adLockReadOnly

j=1
Response.Write "<br>排行榜（前30名）<br><table border=1 font-size: 12px><tr><td align=center>名次</td><td align=center>姓名</td><td align=center>成绩</td><td align=center>IP地址</td><td align=center>测试时间</td></tr>"
do while not azSET.EOF
Response.Write "<tr><td align=center>"&j&"</td><td>"
for i=0 to 2
Response.Write azSET(i)&"</td><td>"
next
timestr=Mid(azSET(3),1,2)&":"&Mid(azSET(3),3,2)&":"&Mid(azSET(3),5,2)&" "&Mid(azSET(3),7,2)&"-"&Mid(azSET(3),9,2)&"-"&Mid(azSET(3),11)
Response.Write timestr&"</td><td>"
azSET.MoveNext
j=j+1
Response.Write "</td></tr>"
Loop
Response.Write "</table>"

azSET.close
dcnDB.close
%>
</body>
</html>
