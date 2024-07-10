@echo off

rem Change to the current directory

cd /d "%~dp0"

rem Copy all the kbmapping batch scripts to the folder within the Path envvar
xcopy /s /i "kb*.bat" "%USERPROFILE%\AppData\Local\Microsoft\WindowsApps"

echo Files Copied Successfully.
