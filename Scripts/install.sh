#!/bin/sh

#Packages
sudo pacman -S ranger zip unzip rofi tlp feh picom bluez bluez-utils pulseaudio-bluetooth git code wget qt5ct yay ctags
sudo pacman -S pavucontrol lxrandr vlc i3-gaps zsh nemo python-pynvim nodejs yarn npm xsel gtk-engines w3m openssh
sudo pacman -S pulsemixer blueberry w3m alacritty nerd-fonts-meslo python-pynvim python-requests neovim extra/xorg-xrdb
sudo pacman -S python-pip
yay -S polybar neovim-plug zsh-syntax-highlighting zsh-theme-powerlevel10k-git pfetch-git oh-my-zsh-git
yay -S vim-devicons google-chrome youtube-dl tp_smapi pango-perl ntfs-3g-fuse blkmenu nerd-fonts-meslo
yay -S aur/nordic-theme-git aur/papirus-folders-nordic chili-sddm-theme sddm-config-editor-git latex-mk

#Setup Environement
sudo cp backlight.rules /etc/udev/rules.d/
sudo npm install -g eslint vue @vue/cli create-react-app nodemon core-js neovim
pip3 install neovim-remote

#Create Directories
mkdir ~/.config
mkdir ~/.config/nvim
mkdir ~/.config/ranger
mkdir ~/.config/alacritty
mkdir ~/.config/picom
mkdir ~/.config/zsh
mkdir ~/.config/i3
mkdir ~/.config/polybar
mkdir ~/Scripts
mkdir ~/Pictures

sudo cp -r /usr/share/zsh-theme-powerlevel10k/* /usr/share/oh-my-zsh/themes
