@echo off

set file=%1

powershell.exe -Command "& Start-Process -FilePath %file% -Verb RunAs"