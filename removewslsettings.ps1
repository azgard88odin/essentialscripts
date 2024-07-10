# Remove the port forwarding rules
for ($i = 0; $i -lt $ports.length; $i++) {
  $port = $ports[$i]
  iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr"
}

# Remove the firewall rules
iex "Remove-NetFireWallRule -DisplayName 'WSL 2 Firewall Unlock'"