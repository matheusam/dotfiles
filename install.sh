#!/bin/sh

zsh_syntax_highlighting_install() {
  if [ -d "$HOME/.zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlighting already installed. Skipping..."
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
  fi
}

asdf_install() {
  if [ -d "$HOME/.asdf" ]; then
    echo "asdf already installed. Skipping..."
  else
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
  fi

  if [ -f "$HOME/.asdf/asdf.sh" ]; then
    . "$HOME/.asdf/asdf.sh"
  fi
}

ruby_install() {
  if asdf list ruby | grep -q "3.3.4"; then
    echo "Ruby 3.3.4 already installed. Skipping..."
  else
    asdf plugin add ruby || true
    asdf install ruby 3.3.4
    asdf global ruby 3.3.4
  fi
}

node_install() {
  if asdf list nodejs | grep -q "18.19.1"; then
    echo "Node.js 18.19.1 already installed. Skipping..."
  else
    asdf plugin add nodejs || true
    asdf install nodejs 18.19.1
    asdf global nodejs 18.19.1
  fi

  if command -v yarn >/dev/null 2>&1; then
    echo "Yarn already installed. Skipping..."
  else
    curl -o- -L https://yarnpkg.com/install.sh | bash -s
    source ~/.zshrc && yarn -v
  fi
}

aws_install() {
  if command -v aws >/dev/null 2>&1; then
    echo "AWS CLI already installed. Skipping..."
  else
    echo "$(printenv HOME)" | xargs -I '{}' sed -i.bu 's,TO_BE_REPLACED,{},g' ~/.dotfiles/aws_choices.xml
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target /
    rm AWSCLIV2.pkg
  fi
}

setup_git_account() {
  git config --global core.editor nvim

  if [ -z "$(git config --global user.name)" ]; then
    read -p 'Git username: ' gituser
    git config --global user.name "$gituser"
  fi

  if [ -z "$(git config --global user.email)" ]; then
    read -p 'Git email: ' gitmail
    git config --global user.email "$gitmail"
  fi
}

git_install() {
  if command -v git >/dev/null 2>&1; then
    echo "Git already installed. Skipping..."
  else
    sudo apt remove -y git
    sudo apt install -y make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
    cd /usr/src/
    sudo wget https://github.com/git/git/archive/v2.29.0.tar.gz -O git.tar.gz
    sudo tar -xf git.tar.gz
    cd git-*
    sudo make prefix=/usr/local all
    sudo make prefix=/usr/local install
    git --version
  fi
}

install_packages_linux() {
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common vim docker python3 python3-pip dirmngr silversearcher-ag git xclip build-essential zsh dconf-cli vim-gtk3 libevent-dev ncurses-dev bison pkg-config
}

install_dotfiles() {
  if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing Dotfiles"
    git clone --depth=10 https://github.com/the-harry/dotfiles.git "$HOME/.dotfiles"
    cd "$HOME/.dotfiles"
    setup_git_account
    rake install
  else
    echo "Dotfiles already installed. Skipping..."
  fi
}

case "$(uname -s)" in
  Darwin)
    echo "Installing on macOS"
    zsh_syntax_highlighting_install
    asdf_install
    ruby_install
    node_install
    aws_install
    install_dotfiles
    ;;
  Linux)
    echo "Installing on Linux"
    install_packages_linux
    git_install
    asdf_install
    ruby_install
    node_install
    aws_install
    install_dotfiles
    ;;
  *)
    echo "Unsupported OS, aborting installation."
    exit 1
    ;;
esac
