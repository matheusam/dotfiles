#!/bin/sh

asdf_install() {
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
}

ruby_install() {
  asdf plugin add ruby
  asdf install ruby 2.7.1
  asdf global ruby 2.7.1
}

git_install() {
  sudo apt remove git
  sudo apt install make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
  cd /usr/src/
  sudo wget https://github.com/git/git/archive/v2.29.0.tar.gz -O git.tar.gz
  sudo tar -xf git.tar.gz
  cd git-*
  sudo make prefix=/usr/local all
  sudo make prefix=/usr/local install
  git --version
}

setup_git_account() {
  git config --global core.editor vim

  read -p 'Git username: ' gituser
  git config --global user.name $gituser

  read -p 'Git e-email: ' gitmail
  git config --global user.email $gitmail
}

if [ ! -d "$HOME/.dotfiles" ]
then
  echo "Installing Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - nodejs"

  case "$(uname -s)" in
    Linux)
      echo "  - asdf"
      echo "  - vim (vim-gnome)"
      NODE_VERSION=12

      sudo apt-get update
      sudo apt-get install -y apt-transport-https ca-certificates curl \
          gnupg2 software-properties-common vim leafpad docker python3 \
          python3-pip dirmngr

      git_install

      asdf_install
      ruby_install

      curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

      sudo apt-get install -y silversearcher-ag \
        git \
        xclip \
        build-essential \
        zsh \
        dconf-cli \
        vim-gtk3 \
        nodejs \
        yarn \
        ruby \
        libevent-dev \
        ncurses-dev \
        bison \
        pkg-config
      ;;
    Darwin )
      echo "  - vim (macvim)"
      echo "  - atom (mac)"

      asdf_install
      ruby_install
      ;;
    CYGWIN* | MSYS*)
      echo 'You are using a Windows machine which is not recommended to use with our' \
           ' dotfiles.'
      echo 'You can clone our repository and try install it manually.'
      return
      ;;
    *)
      echo 'Operational system not recognized, aborting installation'
      return
      ;;
  esac
  git clone --depth=10 https://github.com/the-harry/dotfiles.git "$HOME/.dotfiles"
  cd "$HOME/.dotfiles"

  setup_git_account

  rake install
else
  echo "MAOE... You already have Dotfiles installed."
fi
