#!/bin/sh

#Base
cp -f ~/.zshrc ~/Downloads/dotfiles/
cp -f ~/.Xresources ~/Downloads/dotfiles/
cp -f ~/.gtkrc-2.0 ~/Downloads/dotfiles/
cp -f ~/.p10k.zsh ~/Downloads/dotfiles/

#Specific
cp -f -r ~/.config/i3/* ~/Downloads/dotfiles/.config/i3/ 
cp -f -r ~/.config/picom/* ~/Downloads/dotfiles/.config/picom/ 
cp -f -r ~/.config/polybar/* ~/Downloads/dotfiles/.config/polybar/
cp -f -r ~/.config/ranger/* ~/Downloads/dotfiles/.config/ranger/
cp -f -r ~/.config/nvim/* ~/Downloads/dotfiles/.config/nvim/
cp -f -r ~/.config/zsh/* ~/Downloads/dotfiles/.config/zsh/
cp -f -r ~/.config/alacritty/* ~/Downloads/dotfiles/.config/alacritty/

#GTK & QT
cp -f -r ~/.config/gtk-3.0/* ~/Downloads/dotfiles/.config/gtk-3.0/
cp -f -r ~/.config/Kvantum/* ~/Downloads/dotfiles/.config/Kvantum/
cp -f -r ~/.config/qt5ct/* ~/Downloads/dotfiles/.config/qt5ct/

#Content
cp -f -r ~/Pictures/* ~/Downloads/dotfiles/Pictures/
cp -f -r ~/Scripts/* ~/Downloads/dotfiles/Scripts/

#Git
cd ~/Downloads/dotfiles/
git pull
git add --all
git commit -m "ws update"
git push 
echo "finished"
