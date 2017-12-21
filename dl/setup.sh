#!/bin/sh

get_config_repo() {
	echo "Downloading and installing dotfiles..."
	git clone https://github.com/Lachkater/config.git
	mv -i config/.htop ~/.config/htop/htoprc
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
	sudo pacman -Sy --noconfirm binutils curl git htop vim zsh
	# to make packer install packer work...
	sudo pacman -S --asdeps --noconfirm jshon expac fakeroot
	# to build C programs
	sudo pacman -S --noconfirm gcc make
	curl -O https://raw.githubusercontent.com/rmarquis/pacaur/master/pacaur	
	chmod a+x pacaur
	./pacaur -S --noconfirm pacaur
	rm pacaur
fi

# Redhat based OS
if [ -f /usr/bin/dnf ]; then
	echo "Redhat based OS detected, installing core progs..."
	sudo dnf install git htop vim zsh
fi

get_config_repo

echo "All done, have a nice day!"

