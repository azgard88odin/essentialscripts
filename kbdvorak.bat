@echo off

rem Embed the PowerShell script within the batch file
powershell.exe -Command "& {$1 = Get-WinUserLanguageList; $1[0].InputMethodTips[0]='0409:00010409'; Set-WinUserLanguageList -LanguageList $1 -Force; Write-Host 'Setting to DVORAK';}"

