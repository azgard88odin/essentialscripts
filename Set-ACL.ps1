$FilePath = Read-Host
$Owner = "USERNAME"

# Get the current ACL of the file
$Acl = Get-Acl -Path $FilePath

# Set the new owner
$OwnerIdentityReference = New-Object System.Security.Principal.NTAccount($Owner)
$Acl.SetOwner($OwnerIdentityReference)

# Add an access rule for the new owner with full control
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(
    $OwnerIdentityReference,
    "FullControl",
    "Allow"
)
$Acl.SetAccessRule($AccessRule)

# Apply the modified ACL to the file
Set-Acl -Path $FilePath -AclObject $Acl