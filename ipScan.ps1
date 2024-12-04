$subnet = "192.168.1"
$report = @()

# Loop through all IP addresses from 1 to 254 in the range
for ($i = 1; $i -le 254; $i++) {
    $ip = "$subnet.$i"
    Write-Host "Testing $ip"

    $pingResult = Test-Connection -ComputerName $ip -Count 1 -Quiet
    if ($pingResult) {
        $report += "$ip is UP"
    }
}

# Print the report
if ($report.Count -gt 0) {
    $hostCount = $report.Count
    Write-Host ""
    Write-Host "REPORT:"
    Write-Host "-----------------------------------"
    Write-Host "$hostCount Hosts are UP"
    Write-Host "-----------------------------------"
    $report | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "No devices are responding."
}