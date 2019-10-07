#!/bin/sh

if [ ! -d "$HOME/.dotfiles" ]
then
  echo "Installing Dotfiles"
  echo "We'll install:"
  echo "  - tmux"
  echo "  - silver searcher"
  echo "  - zsh"
  echo "  - vim (vim-gnome)"


  sudo apt-get install -y git curl gnupg build-essential
  sudo apt-get install ruby
  
  git clone --depth=10 https://github.com/matheusam/dotfiles.git "$HOME/.dotfiles"
  cd "$HOME/.dotfiles"
  rake install
else
  echo "Fo shizzle my nizzle... You already have Dotfiles installed."
fi
