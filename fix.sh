#!/bin/bash

config_file="/etc/ssh/ssh_config"
target_host="connect-icmsolar"
new_hostname="igoteggs.ddns.net"

cp "$config_file" "$config_file.bak"  # Create a backup of the original file

# Correct the hostname for the target host
awk -v host="$target_host" -v new_hostname="$new_hostname" '
BEGIN { in_block=0 }
/^Host[ \t]+/ {
  if ($2 == host) {
    in_block = 1
  } else {
    in_block = 0
  }
}
in_block && /^[ \t]*Hostname[ \t]+/ {
  $2 = new_hostname
  print "     Hostname " new_hostname
  next
}
{ print }
' "$config_file.bak" > "$config_file"

echo "Updated Hostname for '$target_host' to '$new_hostname'"

script=$(cat <<'EOF' 
#!/bin/bash -e

function send_files () {
  # this independant script will send only the .id file and the ICMSolar.db file
  # the ssh.pub key was already sent and installed on the windows system during the initial install
  client_name=$(cat /home/pi/identity/client-name)
  client="${client_name// /}" 
  int=$(echo $RANDOM) 
  archive="$client($int).zip"

  zip -q -j "/home/pi/identity/$archive" "/home/pi/identity/$client.id /home/pi/ICM/ICMSolar.db"
  scp -P 27472 "/home/pi/identity/$archive" connect-icmsolar:C:/Connect-ICMSolar/LoadingBay

  sleep 100
  rm -f /home/pi/identity/*.zip
  echo "Files Sent."

}

send_files
EOF
)

if [ -e /opt/connect-icmsolar/send_files.sh ]; then
  sudo echo "$script" > /opt/connect-icmsolar/send_files.sh
  echo "File fixed."
  exit 0
else
  echo "File not found."
  exit 1
fi
