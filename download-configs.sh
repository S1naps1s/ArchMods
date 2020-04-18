#!/bin/bash
#
################################
# Written by: Ben Friend       #
# Last Updated: April 17, 2020 #
################################

if [ ! -d $HOME"/Downloads/GitConfigs/" ]; then
	mkdir $HOME"/Downloads/GitConfigs/"
fi

cd $HOME"/Downloads/GitConfigs/"
git init
git clone https://github.com/S1naps1s/ArchMods.git
cd $HOME/Downloads/GitConfigs
git pull ArchMods

count=0
count=$[count+1]
yes | mv -f $HOME/Downloads/GitConfigs/ArchMods/.bashrc.conf ${HOME}/.bashrc
echo "Config "$count ": " ${HOME}"/.bashrc done"

count=$[count+1]
mv -f $HOME/Downloads/GitConfigs/ArchMods/neofetch.conf ${HOME}/.config/neofetch/config.conf
echo "Config "$count ": " ${HOME}"/.config/neofetch/config.conf done"

count=$[count+1]
read -s -p "Enter password for sudo: " sudoPW
echo $sudoPW | sudo mv -f $HOME/Downloads/GitConfigs/ArchMods/sddm.conf /etc/sddm.conf
echo "Config "$count ": /etc/sddm.conf done"

chmod 777 $HOME"/Downloads/GitConfigs/"
rm -Rf $HOME"/Downloads/GitConfigs/"
