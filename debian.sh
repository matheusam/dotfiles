#!/bin/sh
sudo apt-get update
### PERSONAL
#INSTALL BASE
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common vim leafpad docker docker-compose \
    python3 python3-pip dirmngr git

#GIT
git config --global user.name "Matheus A.M."
git config --global user.email matheusthebr@gmail.com
git config --global core.editor vim

#DOCKER
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

#SETUP RVM
source /home/$USER/.rvm/scripts/rvm

## CC_DOTFILES SETUP
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install -y silversearcher-ag \
 zsh \
 tmux \
 dconf-cli \
 vim-gnome
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
~/.dotfiles/gnome-terminal-colors-solarized/install.sh
sudo apt-get purge ruby
echo 'Change your terminal window to Run command as login shell and restart'
echo 'You can find more information about this on' \
     'https://github.com/rvm/ubuntu_rvm'

sudo apt-get upgrade && apt-get update
echo 'Minimal requests installed! =]'
