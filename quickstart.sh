#!/bin/bash

##updating pc##
echo "updating pc..."
sudo apt update
##if ur using KDE NEON, the upgrade command is different, then i will run update and upgrade command and install some specific things
sistemOp=$(head -1 "/etc/os-release")
expectedSO=NAME='"KDE neon"'
if [[ "$sistemOp" == "$expectedSO" ]];
then
	sudo pkcon update -y
	sudo apt install gnome-keyring -y
	sudo apt install gedit -y
else
	sudo apt upgrade -y
fi

##removing locks from APT command##
sudo rm /var/lib/dpkg/lock-frontend;sudo rm /var/cache/apt/archives/lock;
sudo apt-get update;

echo 'installing curl...' 
sudo apt install curl -y

##fonts##
echo 'installing fonts... (ttf core fonts and Fira Code)'
sudo apt-get install ttf-mscorefonts-installer -y
sudo apt install fonts-firacode -y

##GIThub##
echo 'installing git...' 
sudo apt install git -y
sudo apt update
git config --global user.name "caioDeodato"
git config --global user.email "caio.deodato@yahoo.com"

##vscode##
echo 'installing code...'
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y # or code-insiders

##nodejs and Yarn##
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y
sudo apt-get install yarn -y

##removing php to install later with xampp##
sudo apt-get purge 'php*' -y
sudo apt autoclean
sudo apt autoremove -y 

##docker and docker compose##
echo "installing docker"
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo apt update
sudo systemctl disable docker
chmod 777 /var/run/docker.sock
##testing if can use docker without sudo
docker run hello-world

echo 'installing docker-compose' 
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

## installing java 11##
echo "installing java..."
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-11-jdk -y

##downloading programs that i gonna install later##
echo "installing chrome..."
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

echo "installing xampp.."
wget "https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/7.4.14/xampp-linux-x64-7.4.14-0-installer.run/download" -O xampp-installer.run

echo "installing spring tool suite.."
wget "https://download.springsource.com/release/STS4/4.9.0.RELEASE/dist/e4.18/spring-tool-suite-4-4.9.0.RELEASE-e4.18.0-linux.gtk.x86_64.tar.gz"

echo "installing mysql workbench"
wget "https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.23-1ubuntu20.04_amd64.deb"

echo "installing kolourpaint"
sudo snap install kolourpaint

echo "installing bitwarden"
sudo snap install bitwarden

##installing anything with .deb extension
sudo dpkg -i *.deb

##installing zsh and ohmyzsh !!ohmyzsh must be the last installation because it will change bash and stop the script"##
echo "installing ZSH and OhMyZsh..."
sudo apt install zsh

reboot
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


