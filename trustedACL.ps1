$integratedServicesPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
$acl = Get-Acl -Path $integratedServicesPath

$owner = New-Object System.Security.Principal.NTAccount("NT SERVICE\TrustedInstaller")
$acl.SetOwner($owner)

$acl.SetAccessRuleProtection($true, $false)

$identity = "NT AUTHORITY\SYSTEM"
$fileSystemRights = [System.Security.AccessControl.FileSystemRights]"ReadAndExecute, Synchronize"
$type = [System.Security.AccessControl.AccessControlType]::Allow
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($identity, $fileSystemRights, $type)
$acl.AddAccessRule($rule)

Set-Acl $integratedServicesPath $acl

Get-Acl $integratedServicesPath