#!bin/sh

cd ~/Downloads/dotfiles/
##git pull

#Base
cp -f ~/Downloads/dotfiles/.zshrc ~/.zshrc 
cp -f ~/Downloads/dotfiles/.Xresources ~/.Xresources 
cp -f ~/Downloads/dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0 
cp -f ~/Downloads/dotfiles/.p10k.zsh ~/.p10k.zsh

#Specific
cp -f -r ~/Downloads/dotfiles/.config/i3/* ~/.config/i3/  
cp -f -r ~/Downloads/dotfiles/.config/picom/* ~/.config/picom/  
cp -f -r ~/Downloads/dotfiles/.config/polybar/* ~/.config/polybar/  
cp -f -r ~/Downloads/dotfiles/.config/ranger/* ~/.config/ranger/  
cp -f -r ~/Downloads/dotfiles/.config/nvim/* ~/.config/nvim/
cp -f -r ~/Downloads/dotfiles/.config/alacritty/* ~/.config/alacritty/
cp -f -r ~/Downloads/dotfiles/.config/zsh/* ~/.config/zsh/

#GTK & QT
cp -f -r ~/Downloads/dotfiles/.config/gtk-3.0/* ~/.config/gtk-3.0/
cp -f -r ~/Downloads/dotfiles/.config/Kvantum/* ~/.config/Kvantum/
cp -f -r ~/Downloads/dotfiles/.config/qt5ct/* ~/.config/qt5ct/

#Content
cp -f -r ~/Downloads/dotfiles/Pictures/* ~/Pictures/
cp -f -r ~/Downloads/dotfiles/Scripts/* ~/Scripts/
