# Essential Scripts
Hi all,

This repo is mainly for me to access certain scripts for quick access externally.
This is a small collection of scripts I have built in order to help me with some day-to-day tasks at work and at home.

The scripts are written in Bash, Batch (CMD), Powershell. These are just some that I wished to share, because maybe, someone else needs something I have made.

Below will be an explaination of each script found within. Some of these are pretty raw and I welcome any assistance with further development of them or even creating something new.

I will be updating this periodically so please excuse if I have not yet give descriptions to them all.

## DISCLAIMER:
These scripts are for educational purposes and to assist people with day-to-day tasks.
I take no responsibility for any malicious use of these scripts.

## Bash Scripts:

  ### asm32:
    Usage: asm32 <filename>
    This is a shortcut script to compile 32bit assembly into an ELF32 binary

  ### b2h.sh
    Usage: b2h.sh <amount_of_bytes> <-m || -g>
    b2h (Bytes to human) is a script to help quickly convert an amount of bytes into human readable format
    -m will give you the output in megabytes
    -g will give you the output in gigabytes

  ### rot13 & derot13
    Usage: cat <textfile> | <rot13|derot13>
    I created this to 'encrypt' and 'decrypt' rot13 text when I was busy with basic cryptography

  ### nss
    Usage: nss <-b|-p2|-p3>
    nss (New Shell Script) was a script I originally created to make creating bash scripts quickly in the terminal.
    The user would be prompted the filename after selecting one of the options
    The script would then create the file, fill it with basic boiler plate code and the shebang line and open it up in VIM for editing
    Yes, I use VIM and I love it.

  ### setup_system.sh
    Usage: setup_system.sh
    This is a recent script I made to quickly setup my WSL Ubuntu system.
    Check it out and run if you want to use it.

  ### wi-man & wi-mon
    Usage: <wi-man|wi-mon>
    These are scripts I made to quickly get my Parrot system's wifi interface in managed or monitor mode.
    This was done when pentesting WPA2

## Batch Scripts (Windows CMD Prompt):

  ### Foreword
  So everytime I make a batch script that I wish to run from the terminal in windows, I add it to a common directory that is always in the %PATH% variable.
  %USERPROFILE%\AppData\Local\Microsoft\WindowsApps\ OR C:\Users\YOUR_USERNAME\AppData\Local\Microsoft\WindowsApps\
  Once the files are there you can run them by typing in the filename even without the extension.

  ### cmprivacy.cmd & cmEnable.cmd & cmDisable.cmd
    Usage: cmprivacy.cmd [/e|/d]
    A new addition to my batch scripts. I did this is batch just because it is easier to execute than a powershell script.
    This basically turns on and off the privacy settings for both the webcam and the microphone of my computer.
    My registry keys were found in "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\"
    But yours may be in another location. See the link below for more information. 
    https://www.elevenforum.com/t/enable-or-disable-apps-access-to-microphone-in-windows-11.17117/#Nine
    P.S. if someone has a better way of writing this, please let me know.

  ### dec2hex.cmd
    Usage: dec2hex.cmd <decimal_number>
    This is a very basic script that just helps to quickly convert a base10 number to a base16 number (decimal to hexidecimal)
    This is not all my code, I unfortunately cannot remember the original writer of the main logic and loop behind the process.
    But, this taught me a lot more about Batch scripting and is handy to have

  ### enableFeatures.bat
    Usage: enableFeatures.bat
    This is just a script I used in combination with a few others to quickly get my windows system setup for basic work.
    This helps me setup my system to install WSL and use SSH for remote servers. The only thing to do after this is configure your services.

  ### flushRAM.bat
    Usage: flushRAM.bat
    This script calls RAMMap (Sysinnternals) and flushes both the 'Working Set' and the 'Standby Set' of memory.
    I use this mainly to help take back control of my memory as Windows like to run up a lot of crap in the background without showing you what it is running.
    When I need extra memory to run containers or VM's for development testing, I generally use this command.
    The Sysinternals Suite really has a lot of great programs to help manage windows.

  ### flushtemp.bat
    Usage: flushtemp.bat
    This is mainly because I want to make it easier to manually flush the %TEMP% folder.

  ### kbmapinstall.bat & kbdvorak.bat & kbqwerty.bat
    Usage: kbmapinstall.bat || kbdvorak.bat || kbqwerty.bat
    Ok so this is my favorite little trick script. See I use a dvorak keyboard because I do not enjoy QWERTY as I enjoy the logical layout a lot more.
    So I don't want to everytime I get on a computer or server that I must help to manually configure or work on for a shortwhile, have to use the GUI to add a keyboard.
    kbmapinstall.bat just copies both of these files to the folder in the path variable described in the Foreword
    kbdvorak changes the value of the current keyboard to the DVORAK layout
    kbqwerty changes the value of the current keyboard back to the QWERTY layout
    This way you don't have the user accidently select dvorak while typing incase you didn't remove language via the GUI
    And every time I need to work on the system, I just open CMD and call the command. 

  ### networkRefresh.bat
    Usage: networkRefresh.bat
    This script will reset the following:
    Windows Sockets
    TCP/IP Stack
    WinHTTP library
    Flush DNS settings
    After all of this, it will automatically restart your machine so make sure you are ready for it.
    This was created to assist my WSL when it no longer connects to the internet as I sometimes host a server from my WSL for testing purposes (see addwslsettings.ps1)

  ### optimizeWSL.bat
    Usage: optimizeWSL.bat
    So I ran into a few issues with WSL, the biggest problem was that the virtual hard disk would not autocompact again after removing some items.
    I had, unbeknowst to me, a log file run amok and slowly eat away at my hard drive. I found it and removed it but still had very little space on the host system.
    I have Windows 11 Home on my system and could not use the Powershell command to correct this problem.
    This script is for Windows 11 Home WSL Virtual Hard Disk Compacting so that you can reclaim space on the host system.
    The script will shutdown WSL, create a diskpart script and resize your WSL. Give it at least 5 minutes before running WSL again.
    Please fill in the correct details in the path before running the script. Happy coding!

  ### runscript.bat
    Usage: runscript.bat <script_you_want_to_run.bat>
    Ok, so this one is a bit of a security bypass in most Windows configurations. See, by default you are not supposed to be able to run powershell scripts and not with admin rights either.
    So if you were to write a powershell script and then convert it to a batch file powershell execution, you can then execute that file with admin rights with this script.
    When it runs, it will do what Windows always does, it gives you a UAC popup and you have to press 'Yes'
    This just helps me to quickly get people's systems up and running without needing to change the execution policy on their system.

## Powershell Scripts:

  ### Set-ACL.ps1
    Usage: Set-ACL.ps1
    Change the $Owner to your username or just add % to either side of 'USERNAME'
    Run the script, type in the path in the prompt and press enter. I should honestly improve this script but I only dealt with the following issue once or twice.
    I was dealing with a really annoying Windows file that didn't want to be deleted. I used this script to change the ownership to my user and then remove the bugger.

  ### UpdateDAG.ps1
    Usage: UpdateDAG.ps1
    Update the path and package names, plug in your android device and enable USB debugging. Run the script
    This script was to simplify the updating of a custom android application using adb (Android Debugging Bridge)
    You can either push the file into the downloads folder or you can just make it reinstall it straight away. Be aware that if app signature is different than the current version you must uninstall the application and then run the script.
    You will see a 'Success' message on the terminal if all went well.

  ### addwslsettings.ps1 & removewslsettings.ps1
    Usage: addwslsettings || removewslsettings.ps1
    Sometimes I need to host a webserver from my WSL and need to make my WSL accessible to my local network. 
    Modify the Port on which you wish to access your webserver - see the firewall rules, the port variable (obviously you can reposition it to the top of the script and replace the '3000' with $port
    Get your WSL IPv4 address (ifconfig || ip a || hostname -I) and enter it in the $remoteport variable and run the addwslsettings.ps1 script
    For security reasons I usually run removewslsettings.ps1 after I no longer need to host the server.
  
