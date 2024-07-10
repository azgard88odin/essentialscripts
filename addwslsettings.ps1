New-NetFirewallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Outbound -LocalPort 3000 -Action Allow -Protocol TCP
New-NetFirewallRule -DisplayName 'WSL 2 Firewall Unlock' -Direction Inbound -LocalPort 3000 -Action Allow -Protocol TCP

$addr = '0.0.0.0'
$port = 3000
$remoteport = "<WSL_IPv4_ADDRESS>"

iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr"
iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport"