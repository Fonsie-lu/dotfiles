#!/bin/sh

echo "install graphics"
sudo pacman -S nvidia-dkms xorg xorg-xinit i3-gaps xterm nvidia-settings
#Install paru
echo "install paru"
read
sudo pacman -S base-devel git rust
cd ~/Downloads
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
rm -r -f ~/Downloads/paru
cd ~/Downloads

#Packages
echo "install packages"
read answer
sudo pacman -S ranger zip unzip rofi feh bluez bluez-utils git wget qt5ct ctags opendoas neofetch fzf
echo "install packages"
read answer
sudo pacman -S pavucontrol lxrandr vlc i3-gaps zsh nemo python-pynvim nodejs yarn npm xsel gtk-engines w3m openssh
echo "install packages"
read answer
sudo pacman -S pulsemixer blueberry alacritty python-pynvim python-requests xorg-xrdb qbittorrent
echo "install packages"
read answer
sudo pacman -S python-pip ttf-ubuntu-font-family pacman-contrib archlinux-contrib alsa-utils arch-install-scripts kdenlive
echo "install packages"
read answer
paru -S polybar neovim-plug zsh-syntax-highlighting zsh-theme-powerlevel10k-git oh-my-zsh-git picom-ibhagwan-git 
echo "install packages"
read answer
paru -S vim-devicons google-chrome youtube-dl perl ntfs-3g blkmenu checkupdates-aur ksnip
echo "install packages"
read answer
paru -S nerd-fonts-jetbrains-mono neovim castnow-git teams vscodium-git ttf-ms-fonts onlyoffice-bin
echo "install packages"
read answer
paru -S mtpfs jmtpfs gvfs-mtp firewalld ipset ebtables palenight-gtk-theme mps-youtube-git pulseaudio-equalizer-ladspa-git

#Setup Environement
echo "Setup Environment"
read answer
sudo cp backlight.rules /etc/udev/rules.d/
sudo npm install -g eslint core-js neovim
pip install neovim-remote
sudo sh -c 'echo "permit persist :wheel" >> /etc/doas.conf'

#Create Directories
echo "Setup Directories"
read answer
mkdir ~/.config
mkdir ~/Pictures

#Copy configs
cp -f -r ~/Downloads/dotflies/.p10k.zsh ~/
cp -f -r ~/Downloads/dotfiles/.zshrc ~/
cp -f -r ~/Downloads/dotfiles/.xinitrc ~/
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

mpsyt set api_key AIzaSyDxah4CCB3PF08E1TzH0NgAer0rraNodn8

#Run Stuff
echo "Setup stuff"
read
sudo sensors-detect
nvim -c PlugInstall 
nvim -c UpdateRemotePlugins
clear

echo "Ye Dun, Brah"
