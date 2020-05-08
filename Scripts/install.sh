#!/bin/sh

#Packages
sudo pacman -S ranger zip unzip rofi tlp feh picom bluez bluez-utils pulseaudio-bluetooth git code wget qt5ct yay
sudo pacman -S pavucontrol lxrandr vlc i3-gaps zsh nemo python-pynvim nodejs yarn npm xsel gtk-engines 
sudo pacman -S pulsemixer blueberry w3m alacritty nerd-fonts-meslo python-pynvim python-requests neovim
yay -S polybar neovim-plug zsh-syntax-highlighting zsh-theme-powerlevel10k-git pfetch-git oh-my-zsh-git
yay -S ttf-meslo ttf-dejavu vim-devicons google-chrome youtube-dl tp_smapi pango-perl ntfs-3g-fuse blkmenu 

#Setup Environement
sudo copy backlight.rules /etc/udev/rules.d/
sudo npm install -g eslint vue @vue/cli create-react-app nodemon core-js

#Create Directories
mkdir ~/.config
mkdir ~/.config/nvim
mkdir ~/.config/ranger
mkdir ~/.config/alacritty
mkdir ~/.config/zsh
mkdir ~/.config/i3
mkdir ~/.config/polybar
mkdir ~/Scripts
mkdir ~/Pictures
