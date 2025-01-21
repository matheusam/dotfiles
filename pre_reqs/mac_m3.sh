#!/bin/sh

rm -rf "/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core"
brew tap homebrew/core

git -C $(brew --repo homebrew/core) checkout master

brew install zsh zsh-syntax-highlighting ctags tmux \
             reattach-to-user-namespace the_silver_searcher fzf macvim \
             mysql shared-mime-info gpg imagemagick watchman jq \
             ngrok/ngrok/ngrok #poppler
$(brew --prefix)/opt/fzf/install

brew tap homebrew/cask-fonts
brew install --cask font-fira-code

brew tap heroku/brew && brew install heroku
heroku autocomplete

sudo chown -R "$USER" /private/tmp/
