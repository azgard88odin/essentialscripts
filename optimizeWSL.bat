@echo off
set VHDX_FILE="C:\Users\USERNAME\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_<RESTOFPATH>\LocalState\ext4.vhdx"

:: Shutdown WSL if not already
wsl --shutdown

:: Create a temporary diskpart script
echo select vdisk file=%VHDX_FILE% > opt_wsl_script.txt
echo attach vdisk readonly >> opt_wsl_script.txt
echo compact vdisk >> opt_wsl_script.txt
echo detach vdisk >> opt_wsl_script.txt
echo exit >> opt_wsl_script.txt

:: Run diskpart with the script
diskpart /s opt_wsl_script.txt

:: Remove the script file
del /q opt_wsl_script.txt