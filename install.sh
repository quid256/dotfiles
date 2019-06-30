#!/bin/sh

BACKUP=1

# List of the dotfiles to put in ~
DOTFILES='.vimrc .tmux.conf .bash_aliases'

case $1 in
	backup)
		echo "in BACKUP mode"
		;;
	wipe)
		echo "in WIPE mode"
		read -p "Are you sure you want to wipe the current dotfiles? " -n 1 REPLY
		echo
		if [[ ! $REPLY =~ ^[Yy]$ ]]; then
			echo "Exiting..."
			exit 1
		fi
		BACKUP=0
		;;
	*)
		echo "invalid installation method - must be one of 'wipe' or 'backup'"
		exit 1
esac


INSTALLPATH=$(dirname "$0")


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

if [ $BACKUP -gt 0 ]; then 
	# Make the olddotfile folder if necessary
	mkdir -p ~/.old-dotfiles

	# Copy each current dotfile to .olddotfiles and each new dotfile to the appropriate location
	for DOTFILE in $DOTFILES; do
		echo "Backing up and updating: $DOTFILE"
		[ -d $HOME/$DOTFILE ] && cp ~/$DOTFILE ~/.old-dotfiles
		cp $INSTALLPATH/$DOTFILE ~
	done

fi

for DOTFILES in $DOTFILES; do
	rm ~/$DOTFILE
	ln $INSTALLPATH/$DOTFILE ~/$DOTFILE
done

# Install all the plugins
echo "Installing all vim plugins..."
vim +PluginInstall +qall
