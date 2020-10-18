Dotfiles

## TODO

 * Firacode Fonts

## Source of inspiration

This project is a fork from

[CC Dotfiles](https://github.com/the-harry/dotfiles)

## Pre-Reqs

#### Ubuntu / Debian

* curl: `sudo apt-get install -y curl`

#### Mac

* Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`

## Install

Run follow command:

```
sh -c "`curl -fSs https://raw.githubusercontent.com/the-harry/dotfiles/master/install.sh`"
```

Type your password to change your default shell to `zsh`

## Docs

[Vim Key Mapping](Vim.md)

[Tmux Key Mapping](Tmux.md)

#### It's easy to make your customizations

Place your customizations in the following files:

* .aliases.local
* .secrets
* .zshrc.local
* .vimrc.local
* .zshenv.local
* .plugin.vim.local
* .tmux.conf.local
* .gitconfig.local
