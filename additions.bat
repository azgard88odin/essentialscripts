@echo off

SET "key=W269N-WFGWX-YVC9B-4J6C9-T83GX"

slmgr /ipk %key%
slmgr /skms kms8.msguides.com
slmgr /ato

dism /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart
dism /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism /online /enable-feature /featurename:Micrsoft-Windows-Subsystem-Linux /all /norestart

dism /online /add-capability /capabilityname:OpenSSH.Client~~~~0.0.1.0
shutdown /r /t 0