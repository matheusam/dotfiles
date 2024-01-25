#!/bin/sh

asdf_install() {
   sudo apt-get update
   sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
   sudo apt-get install libssl-dev

    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
    . "$HOME/.asdf/asdf.sh"
    . "$HOME/.asdf/completions/asdf.bash"
}

ruby_install() {
  asdf plugin add ruby
  asdf install ruby 3.2.3
  asdf global ruby 3.2.3
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
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarn-archive-keyring.gpg >/dev/null
      echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

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
