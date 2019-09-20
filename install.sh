#!/bin/sh

# The mode of the install script
#   BACKUP=1   =>  backup the existing files
#   BACKUP=0   =>  wipe them

BACKUP=1

# List of the dotfiles to put in $HOME
DOTFILES='.vimrc .tmux.conf .bash_aliases'

# Parse the command
case $1 in
	backup)
		echo "in BACKUP mode"
		;;
	wipe)
		echo "in WIPE mode"
		
		# Confirm that wipe is the desired course of action
		read -p "Are you sure you want to wipe the current dotfiles? " -r REPLY
		echo
		
		# TODO Refactor this
		if echo $REPLY | grep -Eq '^[Yy]([Ee][Ss])?$'; then
			BACKUP=0
		else
			echo "Exiting..."
			exit 1
		fi
		;;
	*)
		echo "Invalid installation method - must be one of 'wipe' or 'backup'"
		exit 1
esac


# The path where these files are
INSTALLPATH=$(cd $(dirname "$0") && pwd)

# install Vundle if necessary
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
	echo "Cloning Vundle..."
	mkdir -p $HOME/.vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi

# install tmux themepack if necessary
if [ ! -d "$HOME/.tmux-themepack" ]; then
	echo "Cloning tmux-themepack..."
	mkdir -p $HOME/.tmux-themepack
	git clone https://github.com/jimeh/tmux-themepack.git $HOME/.tmux-themepack
fi

if [ $BACKUP -gt 0 ]; then 
	# Make the .old-dotfiles folder if necessary
	mkdir -p $HOME/.dotfiles/old/

	# Copy each current dotfile to .old-dotfiles and each new dotfile to the appropriate location
	for DOTFILE in $DOTFILES; do
		echo "Backing up: $DOTFILE"
		[ -e "$HOME/$DOTFILE" ] && cp "$HOME/$DOTFILE" $HOME/.dotfiles/old/
	done

fi

for DOTFILE in $DOTFILES; do
	# Remove the old dotfile if it exists
	if [ -e "$HOME/$DOTFILE" ]; then
		rm "$HOME/$DOTFILE"
	else
		echo "No need to wipe, dotfile not present: $HOME/$DOTFILE"
	fi

	# Create a symlink from the install path's dotfile to the home dotfile
	ln -s "$INSTALLPATH/$DOTFILE" "$HOME/$DOTFILE"
done

# Install all the plugins
echo "Installing all vim plugins..."
vim +PluginInstall +qall


echo "Done!"
