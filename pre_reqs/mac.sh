#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher
brew install macvim --custom-icons --override-system-vim --with-lua --with-luajit

brew cask install atom
brew cask install firefox
brew cask install brave-browser
brew cask install spotify

brew tap homebrew/cask-fonts
brew cask install font-fira-code

brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

brew tap heroku/brew && brew install heroku
heroku login -i
