:: This is to help restore network connection on WSL
:: This script when run will refresh the network tables and flush the dns records
:: Finally it will reboot the system so be ready before you run the script
@echo off

netsh winsock reset
netsh int ip reset all
netsh winhttp reset proxy
ipconfig /flushdns
shutdown /r /f /t 0