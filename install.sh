#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#create old dotfile directory
if [ ! -d ~/.dotfiles_old ]
then
	mkdir ~/.dotfiles_old
fi
#array with files and directorys:
declare -a files=("vim" "xres" "weechat/weechat.conf" "bash_profile" "bashrc" "aliases" "vimrc" "xinitrc" "Xresources" "zlogin" "zprofile" "zshrc")

for i in "${files[@]}"
do
	#create necessary subdirectory
	if [ -f ${BASEDIR}/$i ] && [[ $i == *"/"* ]] && [ ! -f ~/.dotfiles_old/.$i ];
	then 
		mkdir -p ~/.dotfiles_old/.$i
		rmdir ~/.dotfiles_old/.$i
	fi

	#create symlinks and move old files
	if [ -f ~/.$i ] || [ -d ~/.$i ];
	then
		if [ -h ~/.$i ]
		then
			while true; do
				read -p "$i - symlink already exists overwrite? [y]es/[n]o " yn
				case $yn in
					[Yy]* ) rm ~/.$i; ln -s ${BASEDIR}/$i ~/.$i; echo "		symlink overwritten."; break;;

					[Nn]* ) break;;
					* ) echo "Please answer yes or no.";;
				esac
			done	
		else

			if [ ! -f ~/.dotfiles_old/.$i ] && [ ! -d ~/.dotfiles_old/.$i ];
			then
				mv ~/.$i ~/.dotfiles_old/.$i
				ln -s ${BASEDIR}/$i ~/.$i
				echo "$i - symlink created, old file moved to ~/.dotfiles_old"
			else
				while true; do
					read -p "$i	- ~/.dotfiles_old/.$i already exists overwrite? [y]es/[n]o " yn
					case $yn in
						[Yy]* ) rm ~/.dotfiles_old/.$i; mv ~/.$i ~/.dotfiles_old/.$i; ln -s ${BASEDIR}/$i ~/.$i; echo " 	file overwritten, syumlink created."; break;;

						[Nn]* ) echo "	file not moved, symlink not created!"; break;;
						* ) echo "Please answer yes or no.";;
					esac
				done	
			fi
		fi

	else
		ln -s ${BASEDIR}/$i ~/.$i
		echo "symlink for $i created"
	fi


done
