#!/bin/bash -e
# A Script that creates a fresh bash script by reading STDIN, writing the shebang line, creating executable permissions and opens the file with vi
# This is the new version of the nss script that facilitates python shebangs lines now
# Author: Odendaal Date: 4th of July 2023

# Argument for the option 
option=$1
# User input line

# Handle the option and respond accordingly
# This will also create the file
case "$option" in
  "-b")
    ext=".sh"
    read -p "Enter new filename: " filename
    echo "#!/bin/bash -e" >> $filename$ext
    ;;
  "-p2")
    ext=".py"
    read -p "Enter new filename: " filename
    echo "#!/usr/bin/env python" >> $filename$ext
    ;;
  "-p3")
    ext=".py"
    read -p "Enter new filename: " filename
    echo "#!/usr/bin/env python3" >> $filename$ext
    ;;
  *)
    echo "No language specified, please use the corresponding options (b,p2,p3)"
    exit 1
    ;;
esac

# Execute permissions for the creator of the file
chmod 700 $filename$ext
# Open file in vi
vim $filename$ext
