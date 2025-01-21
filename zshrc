setopt promptsubst

if [ "$TMUX" = "" ]; then tmux; fi

# load our own completion functions
fpath=(~/.zsh/completion /usr/local/share/zsh/site-functions $fpath)

# completion
autoload -U compinit
compinit -u

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

set -o nobeep # no annoying beeps

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Zsh syntax highlight
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
TERM=screen-256color

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Peepcode theme to make your terminal simple and beautiful
source ~/.zsh/themes/peepcode.theme

# Your secrets env var
[[ -f ~/.secrets ]] && source ~/.secrets

setopt interactivecomments

export PATH=$PATH:/usr/local/go/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(fzf --zsh)"

# . $HOME/.asdf/asdf.sh
. /opt/homebrew/opt/asdf/libexec/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# export REQUESTS_CA_BUNDLE='/Library/Application Support/Netskope/STAgent/download/nscacert.pem'
# export NODE_EXTRA_CA_CERTS='/Library/Application Support/Netskope/STAgent/data/nscacert.pem'
# export SSL_CERT_FILE='/Library/Application Support/Netskope/STAgent/data/nscacert.pem'

export BUNDLE_RUBYGEMS__PKG__GITHUB__COM='GITHUB'
export BUNDLE_GITHUB__COM='GITHUB'

export GITHUB_API_TOKEN='GITHUB'
export BUNDLE_ENTERPRISE__CONTRIBSYS__COM="ONE_PASS"

export AWS_REGION='REGION'
export AWS_USER='USER'
export MFA_ARN='ARN'
export AWS_CA_BUNDLE='/etc/ssl/cert.pem'

# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# export LDFLAGS='L/usr/local/opt/openssl/lib'
# export CPPFLAGS='-I/usr/local/opt/openssl/include'
# export PKG_CONFIG_PATH='/usr/local/opt/openssl/lib/pkgconfig'

# export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# export HTTP_PROXY="NET CONFIG PROXY(FULL ADDRESS)"

# RPROMPT='%{$fg[yellow]%}[%D{%T}] '$RPROMPT

# zle_prefix='time '
# zle-line-init() if [[ $CONTEXT = start ]] LBUFFER=$zle_prefix$LBUFFER
# zle -N zle-line-init


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export REQUESTS_CA_BUNDLE='/Library/Application Support/Netskope/STAgent/download/nscacert.pem'
export NODE_EXTRA_CA_CERTS='/Library/Application Support/Netskope/STAgent/data/nscacert.pem'
# export SSL_CERT_FILE='/Library/Application Support/Netskope/STAgent/data/nscacert.pem'

export BUNDLE_RUBYGEMS__PKG__GITHUB__COM='GITHUB'
export BUNDLE_GITHUB__COM='GITHUB'

export GITHUB_API_TOKEN='GITHUB'
export BUNDLE_ENTERPRISE__CONTRIBSYS__COM="ONE_PASS"

export AWS_REGION='REGION'
export AWS_USER='USER'
export MFA_ARN='ARN'
export AWS_CA_BUNDLE='/etc/ssl/cert.pem'

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

export LDFLAGS='L/usr/local/opt/openssl/lib'
export CPPFLAGS='-I/usr/local/opt/openssl/include'
export PKG_CONFIG_PATH='/usr/local/opt/openssl/lib/pkgconfig'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export HTTP_PROXY="NET CONFIG PROXY(FULL ADDRESS)"

# RPROMPT='%{$fg[yellow]%}[%D{%T}] '$RPROMPT

# zle_prefix='time '
# zle-line-init() if [[ $CONTEXT = start ]] LBUFFER=$zle_prefix$LBUFFER
# zle -N zle-line-init


function nb() {
    if [ -z "$1" ]; then
        echo "Usage: nb <issue title>"
        return 1
    fi

    branch_name=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    branch_name=$(echo "$branch_name" | tr ' ' '-')
    branch_name=$(echo "$branch_name" | sed 's/[^a-z0-9-]//g')
    branch_name=$(echo "$branch_name" | sed 's/^-*//;s/-*$//')

    git checkout -b "mirage/ma/${branch_name}"
}
