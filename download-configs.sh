#!/bin/bash

#################################
#	Written by: Ben Friend		#
#	Written: April 17, 2020		#
#	Last Updated: April 19,2020	#
#################################

echo "WARNING! Your system will restart at the conclusion of this script running!"
read -p "Press y to confirm, n to cancel: " restartok

if [ "$restartok" = "y" ] ; then
	read -sp "Enter password for sudo: " sudoPW

	package=cmatrix
	if pacman -Qs $package > /dev/null ; then
		echo -e "\n"$package "is installed"
	else
		echo -e "\n"
		echo $sudoPW | sudo -S pacman -S --noconfirm cmatrix
	fi
	package=figlet
	if pacman -Qs $package > /dev/null ; then
		echo -e "\n"$package "is installed"
	else
		echo -e "\n"
		echo $sudoPW | sudo -S pacman -S --noconfirm figlet
	fi
	package=fortune-mod
	if pacman -Qs $package > /dev/null ; then
		echo -e "\n"$package "is installed"
	else
		echo -e "\n"
		echo $sudoPW | sudo -S pacman -S --noconfirm fortune-mod
	fi
	package=neofetch
	if pacman -Qs $package > /dev/null ; then
		echo -e "\n"$package "is installed"
	else
		echo -e "\n"
		echo $sudoPW | sudo -S pacman -S --noconfirm neofetch
	fi
	package=sddm
	if pacman -Qs $package > /dev/null ; then
		echo -e "\n"$package "is installed"
	else
		echo -e "\n"
		echo $sudoPW | sudo -S pacman -S --noconfirm sddm
	fi

	cd $HOME
	git clone https://aur.archlinux.org/arch-animated-startscreen.git
	cd $HOME/arch-animated-startscreen
	echo -e "n\nn\ny" | makepkg -si
	rm -Rf $HOME/arch-animated-startscreen

	if [ ! -d $HOME"/Downloads/GitConfigs/" ]; then
		mkdir $HOME"/Downloads/GitConfigs/"
	fi

	cd $HOME"/Downloads/GitConfigs/"
	git init
	git clone https://github.com/S1naps1s/ArchMods.git
	git pull ArchMods

	count=0
	count=$[count+1]
	yes | mv -f $HOME/Downloads/GitConfigs/ArchMods/.bashrc.conf ${HOME}/.bashrc
	echo "Config "$count ":" ${HOME}"/.bashrc done"

	count=$[count+1]
	mv -f $HOME/Downloads/GitConfigs/ArchMods/neofetch.conf ${HOME}/.config/neofetch/config.conf
	echo "Config "$count ":" ${HOME}"/.config/neofetch/config.conf done"

	count=$[count+1]
	echo $sudoPW | sudo -S mv -f $HOME/Downloads/GitConfigs/ArchMods/sddm.conf /etc/sddm.conf
	echo "Config "$count ": /etc/sddm.conf done"

	echo $sudoPW | sudo -S chmod 777 $HOME"/Downloads/GitConfigs/"
	echo $sudoPW | sudo -S rm -Rf $HOME"/Downloads/GitConfigs/"

	displaymanager="$(grep '/usr/s\?bin' /etc/systemd/system/display-manager.service)"
	if [ "$displaymanager" = "ExecStart=/usr/bin/sddm" ]; then
		echo $sudoPW | sudo reboot
	elif [ "$displaymanager" = "ExecStart=/usr/bin/gdm" ]; then
		echo $sudoPW | sudo systemctl disable gdm
		echo $sudoPW | sudo systemctl enable sddm
		echo $sudoPW | sudo reboot
	elif [ "$displaymanager" = "ExecStart=/usr/bin/lightdm" ]; then
		echo $sudoPW | sudo systemctl disable lightdm
		echo $sudoPW | sudo systemctl enable sddm
		echo $sudoPW | sudo reboot
	elif [ "$displaymanager" = "ExecStart=/usr/bin/lxdm" ]; then
		echo $sudoPW | sudo systemctl disable lxdm
		echo $sudoPW | sudo systemctl enable sddm
		echo $sudoPW | sudo reboot
	elif [ "$displaymanager" = "ExecStart=/usr/bin/xdm" ]; then
		echo $sudoPW | sudo systemctl disable xdm
		echo $sudoPW | sudo systemctl enable sddm
		echo $sudoPW | sudo reboot
	fi

else
	exit
fi
