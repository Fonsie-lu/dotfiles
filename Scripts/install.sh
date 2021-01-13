#!/bin/sh

#Packages
sudo pacman -S ranger zip unzip rofi feh bluez bluez-utils git code wget qt5ct yay ctags
sudo pacman -S pavucontrol lxrandr vlc i3-gaps zsh nemo python-pynvim nodejs yarn npm xsel gtk-engines w3m openssh
sudo pacman -S pulsemixer blueberry alacritty python-pynvim python-requests neovim xorg-xrdb
sudo pacman -S python-pip kvantum-qt5 ttf-ubuntu-font-family ksnip pacman-contrib archlinux-contrib pacman-contrib archlinux-contrib
yay -S polybar neovim-plug zsh-syntax-highlighting zsh-theme-powerlevel10k-git pfetch-git oh-my-zsh-git 
yay -S vim-devicons google-chrome youtube-dl perl ntfs-3g-fuse blkmenu kvantum-theme-nordic-git checkupdates-aur
yay -S nordic-theme-git papirus-folders-nordic latex-mk nerd-fonts-jetbrains-mono picom-jonaburg-git

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

mkdir ~/.conig/gtk-3.0
mkdir ~/.config/Kvantum
mkdir ~/.config/qt5ct

mkdir ~/Scripts
mkdir ~/Pictures

#Copy themes
sudo cp -r /usr/share/zsh-theme-powerlevel10k/* /usr/share/oh-my-zsh/themes

#Distribute configs
sh ~/Downloads/dotfiles/Scripts/pull.sh

#Run configs
p10k configure
sudo sensors-detect
