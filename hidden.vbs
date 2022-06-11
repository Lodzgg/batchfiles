Set objShell = CreateObject("WScript.Shell")
strCommand = "C:\yourfile.bat"
objShell.Run strCommand, vbHide, TRUE
