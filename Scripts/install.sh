#!/bin/sh

#Install yay
sudo pacman -S base-devel git go
cd ~/Downloads
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -r -f ~/Downloads/yay
cd ~/Downloads

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
sudo cp -r ~/Downloads/dotfiles/Scripts/override.conf /etc/systemd/system/getty@tty1.service.d/

#Autologin
sudo systemctl enable getty@tty1

#Run Stuff
sudo sensors-detect
nvim -c PlugInstall 
nvim -c UpdateRemotePlugins
clear

echo "Ye Dun, Brah"
