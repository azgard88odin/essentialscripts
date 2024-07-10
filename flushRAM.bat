@echo off

C:\Users\USERNAME\SysinternalsSuite\RAMMap64.exe -Ew
C:\Users\USERNAME\SysinternalsSuite\RAMMap64.exe -Et
%WINDIR%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks