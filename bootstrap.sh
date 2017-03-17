#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

cwd=$(pwd)
files=".ackrc .bash_profile .bashrc .dotrc .gemrc .gitconfig .gitignore_global .irbrc .pryrc .railsrc .rspec .tmux.conf .vimrc .zshrc"

##########

# create symlinks
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -f -s $cwd/$file ~/$file
done

rm -rf ~/.oh-my-zsh/custom
ln -s $cwd/oh-my-zsh/custom ~/.oh-my-zsh/custom
