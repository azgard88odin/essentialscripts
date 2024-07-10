@echo off & SETLOCAL ENABLEDELAYEDEXPANSION

set me=%~n0

set hexmap=0123456789ABCDEF

if "%1"=="" echo Usage: %me% DECIMALVALUE& goto :EOF

set /A decimal=%1

echo:%decimal%|findstr /i "^[%hexmap:~0,10%]*$" >nul 2>&1
set /A number=%decimal%
set "ret="

:loop
:: number becomes the quotient
set /A "remainder=number %% 16"
set /A "number /= 16"
set ret=!hexmap:~%remainder%,1!%ret%
if "%number%" NEQ "0" goto :loop
if "%number%" EQU "0" echo %ret% & goto :EOF