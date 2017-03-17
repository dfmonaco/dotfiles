#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

cwd=$(pwd)
files=".ackrc .bash_profile .bashrc .gemrc .gitconfig .gitignore_global .irbrc .pryrc .railsrc .tmux.conf .vimrc .zshrc"

##########

# create symlinks
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -f -s $cwd/$file ~/$file
done
