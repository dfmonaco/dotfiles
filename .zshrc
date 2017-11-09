HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Set editor
export VISUAL=vim
export EDITOR="$VISUAL"

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen load zsh-users/zsh-syntax-highlighting

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen load denysdovhan/spaceship-zsh-theme spaceship

    # save all to init script
    zgen save
fi

# Alias
# editor
# alias vi='nvim'
# alias vim='nvim'

# git
alias gs='git status'
alias ga='git add .'
alias gl='git lg'
alias gl1='git lg1'
alias gc='git commit -v'
alias gi='git add -i'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias -g rsnet='1256@usw-s001.rsync.net'


alias po='systemctl poweroff'
alias re='systemctl reboot'

alias wxp='vboxmanage startvm "wxp"'
alias wxpoff='vboxmanage controlvm "wxp" savestate'

# Open new terminal on same directory
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# Fix locale
export LC_ALL=en_US.UTF-8

# RUBY
SPACESHIP_RUBY_SHOW=true
SPACESHIP_RUBY_SYMBOL='>'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
