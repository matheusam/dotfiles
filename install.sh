#!/bin/sh

zsh_syntax_highlighting_install() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
}

asdf_install() {
  sudo apt-get update
  sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  . "$HOME/.asdf/asdf.sh"
  . "$HOME/.asdf/completions/asdf.bash"
}

ruby_install() {
  asdf plugin add ruby
  asdf install ruby 3.3.4
  asdf global ruby 3.3.4
}

node_install() {
  asdf plugin add nodejs
  asdf install nodejs 12.16.1
  asdf global nodejs 12.16.1
  curl -o- -L https://yarnpkg.com/install.sh | bash -s
  source ~/.zshrc && yarn -v
}

aws_install() {
  echo $(printenv HOME) | xargs -I '{}' sed -i.bu 's,TO_BE_REPLACED,{},g' ~/.dotfiles/aws_choices.xml
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  rm AWSCLIV2.pkg
}

setup_git_account() {
  git config --global core.editor nvim
  read -p 'Git username: ' gituser
  git config --global user.name "$gituser"
  read -p 'Git email: ' gitmail
  git config --global user.email "$gitmail"
}

git_install() {
  sudo apt remove -y git
  sudo apt install -y make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
  cd /usr/src/
  sudo wget https://github.com/git/git/archive/v2.29.0.tar.gz -O git.tar.gz
  sudo tar -xf git.tar.gz
  cd git-*
  sudo make prefix=/usr/local all
  sudo make prefix=/usr/local install
  git --version
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
    echo "Dotfiles already installed."
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
    install_dotfiles
    ;;
  *)
    echo "Unsupported OS, aborting installation."
    exit 1
    ;;
esac
