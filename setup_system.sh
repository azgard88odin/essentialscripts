#!/bin/bash

echo "alias sysup='sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean'" >>~/.bash_aliases
echo 'alias dropcaches="sudo sh -c \"echo 3 > "/proc/sys/vm/drop_caches" && swapoff -a && swapon -a && printf "%s\n" "Ram-cache and Swap Cleared"\""' >>~/.bash_aliases

sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update && sudo apt upgrade
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-{mysql,cli,mbstring,zip,gd,opcache,curl} -y
sudo apt install python3-{dev,pip,venv} -y

#neovim defaults
sudo apt install neovim python3-neovim -y
sudo apt install make gcc ripgrep unzip git xclip npm
wget https://raw.githubusercontent.com/nvim-lua/kickstart.nvim/master/init.lua -O ~/.config/nvim/init.lua
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
echo "\nexport WINDOWS='/mnt/c/Users/dexte/Documents/'" >>~/.bashrc
source ~/.bashrc
nvm install node
#npm i -g bash-language-server
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
