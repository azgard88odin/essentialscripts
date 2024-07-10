@echo off

powershell.exe -Command "& {Get-WindowsCapability -Online | Where-Object Name -like ‘OpenSSH.Client*' | Add-WindowsCapability -Online; Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux; Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform; Enable-WindowsOptionalFeature -FeatureName HypervisorPlatform -All;}"
powershell.exe -Command "& {Set-ExecutionPolicy -Scope CurrentUser Unrestricted; Restart-Computer;}"