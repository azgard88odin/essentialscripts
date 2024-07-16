@echo off

SET option=%1

if "%option%"=="/e" (
	powershell.exe -Command "& Start-Process -FilePath .\cmEnable.cmd -Verb RunAs"
) else if "%option%"=="/d" (
	powershell.exe -Command "& Start-Process -FilePath .\cmDisable.cmd -Verb RunAs"
) else (
	echo Usage: %0 [/e "enable"^|/d "disable"]
)