#!/bin/sh

install_docker() {
  sudo apt-get remove docker docker-engine docker.io containerd runc
  sudo apt-get update
  sudo apt-get install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88

  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $USER
  sudo docker run hello-world
}

install_docker_compose() {
  sudo apt-get remove docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  which docker-compose
  docker-compose -v
}

install_k8s() {
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubelet kubeadm kubectl

  # gcloud container clusters list
  # gcloud container clusters get-credentials CLUSTER --region=REGION
}

install_spotify() {
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client
}

install_brave() {
  sudo apt install apt-transport-https curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install brave-browser
}

install_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

install_tmux() {
  TMUX_VERSION="3.1b"
  TMUX_SOURCE_FILE="tmux-${TMUX_VERSION}.tar.gz"
  TMUX_SOURCE_FOLDER="tmux-${TMUX_VERSION}"

  echo "Installing tmux ${TMUX_VERSION}"
  wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX_SOURCE_FILE}
  tar -xf ${TMUX_SOURCE_FILE}
  pushd $TMUX_SOURCE_FOLDER
  ./configure
  make
  sudo make install
  popd
  rm -rf $TMUX_SOURCE_FOLDER
  rm $TMUX_SOURCE_FILE
}

install_gnome_terminal_colors() {
  GIT_REPO="https://github.com/Anthony25/gnome-terminal-colors-solarized.git"
  COLORS_PATH="$HOME/.gnome-terminal-colors-solarized"

  [ -d $COLORS_PATH ] && return

  git clone $GIT_REPO $COLORS_PATH
  $COLORS_PATH/install.sh
}

install_atom() {
  curl -fsSLo ~/Downloads/atom.deb https://atom.io/download/deb
  sudo dpkg -i ~/Downloads/atom.deb
  sudo apt install -f
  sudo dpkg -i ~/Downloads/atom.deb
  rm -f ~/Downloads/atom.deb
}

install_heroku() {
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
  heroku login -i
}

install_aws() {
  curl -fsSLo ~/awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
  unzip ~/awscliv2.zip
  cd ~ && sudo ./aws/install && cd -
  rm -f ~/awscliv2.zip

  curl -fsSLo session-manager-plugin.deb "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb"
  sudo dpkg -i session-manager-plugin.deb
  sudo apt install -f
  sudo dpkg -i session-manager-plugin.deb
  rm -f session-manager-plugin.deb
}

install_gcp() {
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  sudo apt-get install apt-transport-https ca-certificates gnupg
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  sudo apt-get update && sudo apt-get install google-cloud-sdk
  sudo chown -R $USER:$USER ~/.config/gcloud
  gcloud init

  wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O ~/cloud_sql_proxy
  chmod +x ~/cloud_sql_proxy
}

install_dbeaver() {
  curl -fsSLo ~/Downloads/dbeaver.deb "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb"
  sudo dpkg -i ~/Downloads/dbeaver.deb
  sudo apt install -f
  sudo dpkg -i ~/Downloads/dbeaver.deb
  rm -f ~/Downloads/dbeaver.deb
}

remove_manual_ruby_install() {
  sudo apt-get remove -y ruby
  sudo apt-get autoremove -y
}

setup_wallpaper() {
  gsettings set org.gnome.desktop.background picture-uri file:///$HOME/.dotfiles/wallpaper.jpg
}

install_fira_code_font() {
  sudo add-apt-repository universe
  sudo apt-get update
  sudo apt install fonts-firacode
}

install_erlang_and_elixir() {
  apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
  asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
}

echo 'Starting ubuntu install'

sudo apt-get upgrade && apt-get update

install_docker
install_docker_compose
install_k8s

install_spotify
install_brave
install_fzf
install_tmux > /dev/null 2>&1
install_gnome_terminal_colors

install_atom

install_heroku
install_aws
install_gcp

install_dbeaver

remove_manual_ruby_install

setup_wallpaper
install_fira_code_font

install_erlang_and_elixir

echo 'Minimal requests installed! =]'
