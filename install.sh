#!/bin/sh

# List of the dotfiles to put in ~
DOTFILES='.vimrc .tmux.conf'


# install Vundle if necessary
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
	echo "Cloning Vundle..."
	mkdir -p ~/.vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi



# Make the olddotfile folder if necessary
mkdir -p ~/.olddotfiles

# Copy each current dotfile to .olddotfiles and each new dotfile to the appropriate location
for DOTFILE in $DOTFILES; do
	echo "Backing up and updating: $DOTFILE"
	cp ~/$DOTFILE ~/.olddotfiles
	cp $DOTFILE ~/$DOTFILE
done


# Install all the plugins
echo "Installing all vim plugins..."
vim +PluginInstall +qall
