#!/bin/sh
sudo apt-get update
### PERSONAL
#INSTALL BASE
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common vim leafpad docker \
    python3 python3-pip dirmngr git

#GIT
git config --global user.name "Matheus A.M."
git config --global user.email matheusthebr@gmail.com
git config --global core.editor vim

# RBENV
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
type rbenv
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
rbenv install 2.6.3
rbenv global 2.6.3

# DOCKER - DEBIAN
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
# curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
# sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/debian \
#    $(lsb_release -cs) \
#    stable"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

#DOCKER-COMPOSE
sudo apt-get remove docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# SPOTIFY
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

## CC_DOTFILES SETUP
sudo add-apt-repository -y ppa:pi-rho/dev
sudo apt-get update
sudo apt-get install -y silversearcher-ag \
 zsh \
 tmux \
 dconf-cli

git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
~/.dotfiles/gnome-terminal-colors-solarized/install.sh
sudo apt-get purge ruby
echo 'Change your terminal window to Run command as login shell and restart'
echo 'You can find more information about this on' \
     'https://github.com/rvm/ubuntu_rvm'

sudo apt-get upgrade && apt-get update
echo 'Minimal requests installed! =]'
