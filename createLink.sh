#!/bin/sh
#
#Links


cp -rf .config/* ~/.config/ 
rm -rf ~/.config/hypr/hyprland.conf 
rm -rf ~/.config/alacritty/alacritty.yml
rm -rf ~/.config/picom/picom.con
rm -rf ~/.config/polybar/config.ini
rm -rf ~/.config/ranger/rc.conf
rm -rf ~/.config/rofi/config.rasi
rm -rf ~/.config/waybar/config.jsonc
rm -rf ~/.config/waybar/style.css
rm -rf ~/.zshrc

ln -s ~/dl/dotfiles/.zshrc ~/.zshrc
ln -s ~/dl/dotfiles/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf 
ln -s ~/dl/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ~/dl/dotfiles/.config/picom/picom.conf ~/.config/picom/picom.con
ln -s ~/dl/dotfiles/.config/polybar/config.ini ~/.config/polybar/config.ini
ln -s ~/dl/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -s ~/dl/dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi
ln -s ~/dl/dotfiles/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -s ~/dl/dotfiles/.config/waybar/style.css ~/.config/waybar/style.css
