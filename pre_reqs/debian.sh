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

  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88

  sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable"

  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker $USER
  sudo docker run hello-world
}

install_docker_compose() {
  sudo apt-get remove docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

install_spotify() {
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client
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

remove_manual_ruby_install() {
  sudo apt-get remove -y ruby
  sudo apt-get autoremove -y
}

setup_wallpaper() {
  gsettings set org.gnome.desktop.background picture-uri file:///$HOME/.dotfiles/wallpaper.jpg
}

install_fira_code_font() {
  fonts_dir="${HOME}/.dotfiles/fonts"

  if [ ! -d "${fonts_dir}" ]; then
      echo "mkdir -p $fonts_dir"
      mkdir -p "${fonts_dir}"
  else
      echo "Found fonts dir $fonts_dir"
  fi

  for type in Bold Light Medium Regular Retina; do
      file_path="${HOME}/.dotfiles/fonts/FiraCode-${type}.ttf"
      file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
      if [ ! -e "${file_path}" ]; then
          echo "wget -O $file_path $file_url"
          wget -O "${file_path}" "${file_url}"
      else
  	echo "Found existing file $file_path"
      fi;
  done

  echo "fc-cache -f"
  fc-cache -f
}

echo 'Starting debian install'

sudo apt-get upgrade && apt-get update

install_docker
install_docker_compose
install_spotify
install_tmux > /dev/null 2>&1
install_gnome_terminal_colors

remove_manual_ruby_install

setup_wallpaper
install_fira_code_font

echo 'Minimal requests installed! =]'
