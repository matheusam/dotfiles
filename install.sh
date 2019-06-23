#!/bin/sh

if [ ! -d "$HOME/.dotfiles" ]
then
  echo "Installing Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - vim (vim-gnome)"

  case "$(uname -s)" in
    Linux)
      sudo apt-get install -y git curl gnupg build-essential
      gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
      \curl -sSL https://get.rvm.io | bash -s stable --rails
      sudo usermod -a -G rvm `whoami`
      sudo apt-get install ruby
      ;;
    *)
      echo 'Operational system not recognized, aborting installation'
      return
      ;;
  esac
  git clone --depth=10 https://github.com/matheusam/dotfiles.git "$HOME/.dotfiles"
  cd "$HOME/.dotfiles"
  rake install
else
  echo "Fo shizzle my nizzle... You already have Dotfiles installed."
fi
