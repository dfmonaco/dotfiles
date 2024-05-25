HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000

# Set editor
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER="/usr/bin/google-chrome-stable"

source ~/.zplug/init.zsh

# plugins
zplug "plugins/git", from:oh-my-zsh 
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/wd", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh

# completions
zplug "zsh-users/zsh-syntax-highlighting"

# theme
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Alias
alias cat='bat'
alias q='exit'

# editor
alias e='nvim'
# alias vim='nvim'

# ruby
alias be='bundle exec'
alias rails='bundle exec rails'

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
alias lg='lazygit'


alias po='systemctl poweroff'
alias re='systemctl reboot'

alias wxp='vboxmanage startvm "wxp"'
alias wxpoff='vboxmanage controlvm "wxp" savestate'

alias l='i3lock -c 505050'

# tmate
alias tcopy='tmate -S /tmp/tmate.sock display -p "#{tmate_ssh}" | xclip -selection clipboard'

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
# SPACESHIP_VI_MODE_SHOW=false

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="$PATH:`yarn global bin`"

# Suppress ruby 2.7 warnings
# export RUBYOPT='-W:no-deprecated -W:no-experimental'

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

eval "$(rbenv init - zsh)"

# Load pyenv automatically by appending
# the following to
# ~/.zprofile (for login shells)
# and ~/.zshrc (for interactive shells) :

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Starship Prompt
eval "$(starship init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/diego/google-cloud-sdk/path.zsh.inc' ]; then . '/home/diego/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/diego/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/diego/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(atuin init zsh)"
