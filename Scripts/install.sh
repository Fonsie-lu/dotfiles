#!/bin/sh

#Install yay
sudo pacman -S base-devel git go
cd ~/Downloads
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
rm -r -f ~/Downloads/paru
cd ~/Downloads

#Packages
sudo pacman -S ranger zip unzip rofi feh bluez bluez-utils git wget qt5ct ctags opendoas
sudo pacman -S pavucontrol lxrandr vlc i3-gaps zsh nemo python-pynvim nodejs yarn npm xsel gtk-engines w3m openssh
sudo pacman -S pulsemixer blueberry alacritty python-pynvim python-requests xorg-xrdb
sudo pacman -S python-pip kvantum-qt5 ttf-ubuntu-font-family ksnip pacman-contrib archlinux-contrib 
paru -S polybar neovim-plug zsh-syntax-highlighting zsh-theme-powerlevel10k-git oh-my-zsh-git 
paru -S vim-devicons google-chrome youtube-dl perl ntfs-3g blkmenu checkupdates-aur
paru -S nerd-fonts-jetbrains-mono neovim-nightly-git castnow teams vscodium-git vscodium-bin-marketplace 
paru -S mtpfs jmtpfs gvfs-mtp firewalld ipset ebtables palenight-gtk-theme mps-youtube-git pulseaudio-equalizer-ladspa-git

#Setup Environement
sudo cp backlight.rules /etc/udev/rules.d/
sudo npm install -g eslint core-js neovim
pip install neovim-remote

#Create Directories
mkdir ~/.config
mkdir ~/Pictures

#Copy configs
cp -f -r ~/Downloads/dotflies/.p10k.zsh ~/
cp -f -r ~/Downloads/dotfiles/.zshrc ~/
cp -f -r ~/Downloads/dotfiles/.xinitrc ~/
cp -f -r ~/Downloads/dotfiles/.Xresources ~/
cp -f -r ~/Downloads/dotfiles/.gtkrc-2.0 ~/

cp -f -r ~/Downloads/dotfiles/.config/* ~/.config/
cp -f -r ~/Downloads/dotfiles/Pictures/* ~/Pictures/

sudo cp -r /usr/share/zsh-theme-powerlevel10k/* /usr/share/oh-my-zsh/themes/
sudo mkdir /etc/systemd/system/getty@tty1.service.d/
sudo cp -r ~/Downloads/dotfiles/Scripts/override.conf /etc/systemd/system/getty@tty1.service.d/

#Set git config
git config --global user.email "beat.weber.86@gmail.com"
git config --global user.name "Beat Weber WS"

#Autologin
sudo systemctl enable getty@tty1
sudo systemctl enable firewalld

sudo echo "permint persist :wheel" > /etc/doas.conf
mpsyt set api_key AIzaSyDxah4CCB3PF08E1TzH0NgAer0rraNodn8

#Run Stuff
sudo sensors-detect
nvim -c PlugInstall 
nvim -c UpdateRemotePlugins
clear

echo "Ye Dun, Brah"
