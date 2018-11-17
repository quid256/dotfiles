#!/bin/sh


INSTALLPATH=$(dirname "$0")

# List of the dotfiles to put in ~
DOTFILES='.vimrc .tmux.conf .bash_aliases'

# install Vundle if necessary
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
	echo "Cloning Vundle..."
	mkdir -p ~/.vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# install tmux themepack if necessary
if [ ! -d "$HOME/.tmux-themepack" ]; then
	echo "Cloning tmux-themepack..."
	mkdir -p ~/.tmux-themepack
	git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
fi


# Make the olddotfile folder if necessary
mkdir -p ~/.dotfiles/old/

# Copy each current dotfile to .olddotfiles and each new dotfile to the appropriate location
for DOTFILE in $DOTFILES; do
	echo "Backing up and updating: $DOTFILE"
	[ -d $HOME/$DOTFILE ] && cp ~/$DOTFILE ~/.dotfiles/old
	cp $INSTALLPATH/$DOTFILE ~
done


# Install all the plugins
echo "Installing all vim plugins..."
vim +PluginInstall +qall
