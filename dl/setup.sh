#!/bin/sh

get_config_repo() {
	echo "Downloading and installing dotfiles..."
	git clone https://github.com/Lachkater/config.git
	mv -i config/.htop ~
	mv -i config/.zshrc ~
	mv -i config/.vimrc ~
}

# Debian based OS
if [ -f /usr/bin/apt-get ]; then
	echo "Debian based OS detected, installing core progs..."
	sudo apt-get -y update
	sudo apt-get -y install git htop vim zsh
fi

# Arch based OS
if [ -f /usr/bin/pacman ]; then
	echo "Arch based OS detected, installing core progs..."
	sudo pacman -Sy --noconfirm curl git htop vim zsh
	# to make packer install packer work...
	sudo pacman -S --asdeps --noconfirm jshon expac
	curl -O https://raw.githubusercontent.com/keenerd/packer/master/packer
	chmod a+x packer
	./packer -S --noconfirm packer
	rm packer
fi

# Redhat based OS
if [ -f /usr/bin/dnf ]; then
	echo "Redhat based OS detected, installing core progs..."
	sudo dnf install git htop vim zsh
fi

get_config_repo

echo "All done, have a nice day!"

