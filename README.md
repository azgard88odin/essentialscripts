# Essential Scripts
Hi all,

This repo is mainly for me to access certain scripts for quick access externally.
This is a small collection of scripts I have built in order to help me with some day-to-day tasks at work and at home.

The scripts are written in Bash, Batch (CMD), Powershell. These are just some that I wished to share, because maybe, someone else needs something I have made.

Below will be an explaination of each script found within. Some of these are pretty raw and I welcome any assistance with further development of them or even creating something new.

I will be updating this periodically so please excuse if I have not yet give descriptions to them all.

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
    Usage: cat <textfile> | rot13 || derot13
    I created this to 'encrypt' and 'decrypt' rot13 text when I was busy with basic cryptography

  ### nss
    Usage: nss <-b || -p2 || -p3>
    nss (New Shell Script) was a script I originally created to make creating bash scripts quickly in the terminal.
    The user would be prompted the filename after selecting one of the options
    The script would then create the file, fill it with basic boiler plate code and the shebang line and open it up in VIM for editing
    Yes, I use VIM and I love it.

  
