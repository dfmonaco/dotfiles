HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000

# Set editor
export VISUAL=nvim
export EDITOR="$VISUAL"
export BROWSER="/usr/bin/brave"

# Emacs mode
bindkey -e

# Decrypt and export environment variables
if decrypted_env=$(sops --decrypt ~/dotfiles/sec.env 2>/dev/null); then
    export $(echo "$decrypted_env" | xargs)
else
    echo "Failed to decrypt the environment variables"
fi

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
alias v='nvim'

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

# yazi
alias e='yazi'

# docker
alias ld='lazydocker'

# Eza
alias tr="eza --tree --long --git-ignore"
alias tra="eza --tree --long --all --git-ignore"
alias ls="eza --icons --group-directories-first --long --no-user --no-permissions --no-time --grid --sort=extension"
alias lsa="eza --icons --group-directories-first --long --no-user --no-permissions --no-time --all --grid --sort=extension"

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

# To call nvm use automatically whenever you enter a directory that contains an .nvmrc file with a string telling nvm which node to use:

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

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
eval "$(atuin init zsh --disable-up-arrow)"

# uv
export PATH="/home/diego/.local/bin:$PATH"
