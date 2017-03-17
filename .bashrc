# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

###---CUSTOM---###

# PROMPT

# standard

PS1="\[\033[0;41m\]\w \$\[\033[0m\] "

# show branch and dirty status, http://henrik.nyh.se/2008/12/git-dirty-prompt, http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "⚡"
}

function parse_git_branch {
    local branch=$(__git_ps1 "%s")
    [[ $branch ]] && echo "[$branch$(parse_git_dirty)]"
}

export PS1='\[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

# PATH
PATH=$PATH:~/.scripts

# ALIASES
# rspec
alias t='rspec --drb'

# navigation
alias go='cd /home/diego/stuff/code/oel'

# bundler
alias be='bundle exec'
alias bi='bundle install --binstubs'

# docs
alias docs='yard server --gems'

# rails
alias r='rails'
alias rs='rails server thin'
alias rg='rails generate'
alias rc='rails console'
alias rd='rails dbconsole'
alias krs='kill $(lsof -i :3000 -t)'

alias oel='rails server thin -e production --port=3001'
alias oel_c='rails console production'

alias routes="rake routes | sed -e "1d" -e "s,^[^/]*,,g" | awk '{print $1}' | sort | uniq"

# reflexive
alias ref='rails s thin --environment=reflexive --port=3002'

# rake
alias rk='bundle exec rake'

# git
alias gs='git status'
alias ga='git add .'
alias gl='git lg'
alias gl1='git lg1'
alias gc='git commit -m'
alias gi='git add -i'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout'

# rake tasks
# alias dbr='rake db:migrate:reset && rake db:seed && annotate && rake db:test:prepare'
# alias dbr='rake db:migrate:reset && rake db:seed && rake db:test:prepare'
alias dbr='rake db:migrate:reset && rake db:import && rake db:test:prepare'
alias pop='rake populate:all --trace'
alias cov='rake spec:rcov'
alias migrate_prod='rake db:migrate RAILS_ENV=production'

# postgres
alias dump='pg_dump obrasenlinea_production > production.sql'
alias prod2dev='dump && rake db:drop && rake db:create && psql obrasenlinea_development < production.sql'

# Heroku
alias hkpush='heroku db:push postgres://diego:diego@127.0.0.1/obrasenlinea_production?encoding=utf8'
alias hkpull='heroku db:pull postgres://diego:diego@127.0.0.1/obrasenlinea_production?encoding=utf8'
alias hkpull_dev='heroku db:pull postgres://diego:diego@127.0.0.1/obrasenlinea_development?encoding=utf8'
alias hkbackup='heroku pgbackups:capture --expire --app obrasenlinea'
alias hkdl='curl -o oel.dump `heroku pgbackups:url --app obrasenlinea`'
alias hk2dev='pg_restore -v -c -x -O  -d obrasenlinea_development oel.dump'

# MISC

# shut up Postgres
export PGOPTIONS='-c client_min_messages=PANIC'

# default editor

export EDITOR='vim'
export ALTERNATE_EDITOR='vim'

# BACKUP
alias bkp='rsync -va --del --progress --log-file=/home/diego/.backup.log --exclude-from=/home/diego/.rsync/exclude /home/diego /media/backup/'

alias bkp2='rsync -va --del --modify-window=1 --progress --log-file=/home/diego/.backup.log --exclude-from=/home/diego/.rsync/exclude /home/diego /media/diego/toshiba_bkp/'

# Alert
alias alert_helper='history|tail -n1|sed -e "s/^\s*[0-9]\+\s*//" -e "s/;\s*alert$//"'
alias alert='notify-send -i /usr/share/icons/gnome/32×32/apps/gnome-terminal.png "[$?] $(alert_helper)"'

# tmux 256 colors
[ -z "$TMUX" ] && export TERM=xterm-256color

# make .ackrc local for ack-grep
export ACKRC=".ackrc"

# Start vi Mode for command line editing
# set -o vi

# RVM

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
