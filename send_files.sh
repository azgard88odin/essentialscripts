#!/bin/bash -e

function send_files () {
  # this independant script will send only the .id file and the ICMSolar.db file
  # the ssh.pub key was already sent and installed on the windows system during the initial install
  client_name=$(cat /home/pi/identity/client-name)
  client="${client_name// /}" 
  int=$(echo $RANDOM) 
  archive="$client($int).zip"

  zip -qj /home/pi/identity/$archive /home/pi/identity/$client.id /home/pi/ICM/ICMSolar.db
  sshpass -f /root/notes scp -P 27472 /home/pi/identity/$archive connect-icmsolar:I:/OneDrive/Connect-ICMSolar/LoadingBay

  rm -f /home/pi/identity/$archive
  echo "Files Sent."

  return 0

}

if send_files; then
  directory="/home/pi/identity"

  find $directory -type f -name "*.zip" -delete
