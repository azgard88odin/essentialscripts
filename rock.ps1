$integratedServicesPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"
$acl = Get-Acl -Path $integratedServicesPath
takeown /f $integratedServicesPath /a
icacls $integratedServicesPath /grant Administrators:F

$jsonContent = Get-Content $integratedServicesPath | ConvertFrom-Json

foreach ($policy in $jsonContent.policies) {
    if( $policy.'$comment' -like "*Edge*" -and $policy.'$comment' -like "*uninstall*") {
        $policy.defaultState = 'enabled'
        $allCountryCodes = @("AT", "BE", "BG", "CH", "CY", "CZ", "DE", "DK", "EE", "ES", "FI", "FR", "GF", "GP", "GR", "HR", "HU", "IE", "IS", "IT", "LI", "LT", "LU", "LV", "MT", "MQ", "NL", "NO", "PL", "PT", "RE", "RO", "SE", "SI", "SK", "YT", "AD", "AE", "AF", "AG", "AI", "AL", "AM", "AO", "AQ", "AR", "AS", "AU", "AW", "AX", "AZ", "BA", "BB", "BD", "BF", "BH", "BI", "BJ", "BL", "BM", "BN", "BO", "BQ", "BR", "BS", "BT", "BV", "BW", "BY", "BZ", "CA", "CC", "CD", "CF", "CG", "CI", "CK", "CL", "CM", "CN", "CO", "CR", "CU", "CV", "CW", "CX", "DJ", "DM", "DO", "DZ", "EC", "EG", "EH", "ER", "ET", "FK", "FM", "FO", "GA", "GB", "GD", "GE", "GG", "GH", "GI", "GL", "GM", "GN", "GQ", "GS", "GT", "GU", "GW", "GY", "HK", "HM", "HN", "HT", "ID", "IL", "IM", "IN", "IO", "IQ", "IR", "JE", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KP", "KR", "KW", "KY", "KZ", "LA", "LB", "LC", "LK", "LR", "LS", "LY", "MA", "MC", "MD", "ME", "MF", "MG", "MH", "MK", "ML", "MM", "MN", "MO", "MP", "MR", "MS", "MU", "MV", "MW", "MX", "MY", "MZ", "NA", "NC", "NE", "NF", "NG", "NI", "NP", "NR", "NU", "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PM", "PN", "PR", "PS", "PW", "PY", "QA", "RE", "RS", "RU", "RW", "SA", "SB", "SC", "SD", "SG", "SH", "SJ", "SL", "SM", "SN", "SO", "SR", "SS", "ST", "SV", "SX", "SY", "SZ", "TC", "TD", "TF", "TG", "TH", "TJ", "TK", "TL", "TM", "TN", "TO", "TT", "TV", "TW", "TZ", "UA", "UG", "UM", "US", "UY", "UZ", "VA", "VC", "VE", "VG", "VI", "VN", "VU", "WF", "WS", "YE", "YT", "ZA", "ZM", "ZW")
        $policy.conditions.region.enabled = $allCountryCodes
        
    }
}

$jsonContent | ConvertTo-Json -Depth 100 | Set-Content -Path "C:\BK_IntegratedServicesRegionPolicySet.json"

Copy-Item "C:\BK_IntegratedServicesRegionPolicySet.json" "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"

Set-Acl -Path $integratedServicesPath -AclObject $acl

Stop-Process -Name "MsEdge" -Force | Out-Null

winget uninstall "Microsoft.Edge" --accept-source-agreements --silent | Out-Null
winget uninstall --name "Microsoft Edge" --accept-source-agreements --silent | Out-Null

Start-Process -Name "MsEdge"
Start-Sleep -Seconds 3

if (Get-Process -Name "MsEdge") {
    Write-Host "Edge still lives!"
    Start-Sleep -Seconds 5
} else {
    Write-Host "Microsoft lost its Edge!"
    Start-Sleep -Seconds 5
}