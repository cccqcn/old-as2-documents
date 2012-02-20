<% 
CountFile=Server.MapPath("yjhxcnt.txt") 
Set FileObject=Server.CreateObject("Scripting.FileSystemObject") 
Set Out=FileObject.OpenTextFile(CountFile,1,FALSE,FALSE) 
counter=Out.ReadLine
Out.Close 
SET FileObject=Server.CreateObject("Scripting.FileSystemObject") 
Set Out=FileObject.CreateTextFile(CountFile,TRUE,FALSE) 
Application.lock 
counter= counter + 1 
Out.WriteLine(counter) 
Application.unlock 
Response.Write("counter=")
Response.Write(counter)
Out.Close 
%> 