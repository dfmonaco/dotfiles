HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000

# Set editor
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER="/usr/bin/brave"

# Reevaluate the prompt string each time it's displaying a prompt
setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit

source ~/.zplug/init.zsh

# plugins
zplug "plugins/git", from:oh-my-zsh 
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/wd", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"

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
alias cl='clear'
alias c='wl-copy'
alias p='wl-paste'

# editor
alias e='nvim'
# alias vim='nvim'

# ruby
alias be='bundle exec'
alias rails='bundle exec rails'
alias t='bundle exec rspec --fail-fast'

# git
alias gs='git status'
alias ga='git add .'
alias gl='git l'
alias gc='git commit -v'
alias gi='git add -i'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'
alias lg='lazygit'

# docker
alias ld='lazydocker'

# Eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"

# yay
# Try this to fuzzy-search through all available packages, with package info shown in a preview window, and then install selected packages:
alias si="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
# List all your installed packages, and then remove selected packages
alias sr="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro yay -Rns"

# System power
alias po='systemctl poweroff'
alias re='systemctl reboot'

alias x='i3lock -c 505050'

# Fix locale
export LC_ALL=en_US.UTF-8

# rbenv
eval "$(rbenv init - zsh)"

# Set up Node Version Manager
source /usr/share/nvm/init-nvm.sh

# Starship Prompt
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
source <(fzf --zsh)
