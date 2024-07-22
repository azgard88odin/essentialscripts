@echo off

:: Now running with admin rights
SET option=%1

if "%option%"=="" (
	:: Show the network interface currently used
	netsh interface show interface

	:: Disable the network interface
	netsh interface set interface name="Wi-Fi" admin=disabled

	:: Confirm that the interface is disabled
	netsh interface show interface
) else if "%option%"=="/e" (
	:: Show network interface
	netsh interface show interface

	:: Enable the network interface
	netsh interface set interface name="Wi-Fi" admin=enabled

	:: Confirm that the interface is back up
	netsh interface show interface
) else (
	echo Usage: netkill 	-	No arguments with disable Wi-Fi Interface
	echo Usage: netkill /e 	-	To re-enable Wi-Fi Interface
)
