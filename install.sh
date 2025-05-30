#!/bin/bash -e

# Author:   Odin Meyer
# Date:     29-07-2023
# This is to serve as the install script on the linux servers. This will be run once on each server required
# The Windows system will then use their information to download the solar database log file for each system/client
# This script will install other scripts that will run in the background when a certain condition is met

# Retrieve identifiers and store them in files
function get_identifiers() {
  while true; do
    read -p "Enter client's full name: " client_name
    if [ ${#client_name} -gt 0 ]; then
      read -p "Is $client_name correct? (y/n): " answer
      case "$answer" in
      y | Y)
        echo "Client name confirmed! Continuing installation..."
        break
        ;;
      n | N)
        echo "Please correct client's name"
        ;;
      *)
        echo "Invalid Response. Please try again. (y/n)"
        ;;
      esac
    else
      echo "Empty string. Please try again"
    fi
  done
  if [ ! -d /home/pi/identity ]; then
    mkdir /home/pi/identity
  fi
  if [ ! -d /home/pi/.ssh ]; then
    mkdir /home/pi/.ssh
  fi
  echo "$client_name" >/home/pi/identity/client-name
  sudo cat /etc/machine-id >/home/pi/identity/machine-id
  sudo cat /sys/class/net/eth0/address >/home/pi/identity/mac-addresses
  sudo cat /sys/class/net/wlan0/address >>/home/pi/identity/mac-addresses

  name_to_format=$(cat /home/pi/identity/client-name)
  client="${name_to_format// /}"

  machine_id=$(cat /home/pi/identity/machine-id)
  mac_addresses=$(cat /home/pi/identity/mac-addresses)
  sudo echo "St24421#" >/root/notes
  echo "Client: $client_name" >/home/pi/identity/$client.id
  echo "ID: $machine_id" >>/home/pi/identity/$client.id
  echo -e "MAC:\n$mac_addresses" >>/home/pi/identity/$client.id
  # At this point we will have the following files
  # client-name, machine-id, mac-addresses, $client.id
  # These are contained within the identity directory

  echo "Identifiers Complete."

}

# Create ssh key files, chmod 600 on the keys, Restart systemctl ssh
function create_keys() {

  sudo sed -i 's/^#PubkeyAuthentication yes$/PubkeyAuthentication yes/' /etc/ssh/sshd_config # enable PubkeyAuthentication

  client_name=$(cat /home/pi/identity/client-name)
  client="${client_name// /}"

  sudo systemctl restart ssh
  echo "Restarting SSH Services. Please Wait."
  sleep 5s
  # generate key pair
  ssh-keygen -t rsa -b 4096 -N "" -f /home/pi/.ssh/$client <<<y >/dev/null 2>&1
  sudo chmod 600 /home/pi/.ssh/$client*
  # add the key on the linux system
  ssh-add /home/pi/.ssh/$client
  # copy the key to the identity folder for packaging
  cp /home/pi/.ssh/$client.pub /home/pi/identity/$client.pub
  # restart the ssh service to make sure it works
  sudo systemctl restart ssh
  echo "Restarting SSH Services. Please Wait."
  sleep 10s

  echo "Secure Shell Keys Created."

}

function add_ssh_hostname() {
  # This function simply adds the host to the ssh_config file
  # In case the system ever restarts, the host is added and will automatically know where to send the files

  client_name=$(cat /home/pi/identity/client-name)
  client="${client_name// /}"

  echo -e "Host connect-icmsolar" >>/etc/ssh/ssh_config                    # Alias for system
  echo -e "\tHostname igoteggs.ddns.net" >>/etc/ssh/ssh_config             # WindowsDDNS
  echo -e "\tUser info" >>/etc/ssh/ssh_config                              # WindowsUsername
  echo -e "\tPort 27472" >>/etc/ssh/ssh_config                             # WindowsPort
  echo -e "\tIdentityFile /home/pi/.ssh/$client" >>/etc/ssh/ssh_config     # KeyFile

  sudo apt install sshpass -y 2>/dev/null

}

### Do I need to create an offset for each install?
### Update the scripts for crontab
# Set crontab
function set_crontab() {

  # Every Monday and Thursday @ 08:00 and 12:00
  (
    crontab -l 2>/dev/null
    echo "0 8 * * 1,4 /opt/connect-icmsolar/send_files.sh"
  ) | crontab -
  (
    crontab -l 2>/dev/null
    echo "0 12 * * 1,4 /opt/connect-icmsolar/send_files.sh"
  ) | crontab -

  echo "Cron Table Set."
}

function send_files() {
  # files that need to be sent for the initial install, will serve as one of the independant scripts
  # this will be the only time that the SSH.pub key will be sent
  # the independant will send only the .id file and the ICMSolar.db file
  client_name=$(cat /home/pi/identity/client-name)
  client="${client_name// /}"
  int=$(echo $RANDOM)
  archive="$client($int).zip"

  sudo apt install zip -y

  sudo zip /home/pi/identity/$archive -j /home/pi/identity/$client.id /home/pi/identity/$client.pub /home/pi/ICM/ICMSolar.db
  sshpass -f /root/notes scp -P 27472 /home/pi/identity/$archive connect-icmsolar:I:/OneDrive/Connect-ICMSolar/NewData

  rm -f /home/pi/identity/$archive
  echo "Initial Files Sent."

}

# Copy scripts to the correct directory
function install_files() {

  if [ ! -d /opt/connect-icmsolar ]; then
    mkdir /opt/connect-icmsolar
  fi

  cp /home/pi/Downloads/server_install/send_files.sh /opt/connect-icmsolar/
  chmod 700 /opt/connect-icmsolar/send_files.sh

  echo "Script Installed."
}

################################
######### Running Code #########
################################

# Get identifiers and compile the identity file
get_identifiers
# Modify settings, create SSH keys, install on server and prepare Public Key for packaging
create_keys
# Append host to ssh_config file
add_ssh_hostname
# Install script for SCP transfers
install_files
# Set Crontab for automation
set_crontab
# Package and send client files to Windows
send_files

# Show Completion of tasks
echo "Installation is Complete. Please confirm the Database entry."

# Remove the installation files
rm -rf /home/pi/Downloads/run_install.sh
rm -rf /home/pi/Downloads/server_install.tar.gz
rm -rf /home/pi/Downloads/server_install
echo "Cleanup Complete."

################################
########  End of Code   ########
################################
