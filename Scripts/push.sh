cp -f ~/.zshrc ~/Downloads/dotfiles/
cp -f ~/.Xresources ~/Downloads/dotfiles/
cp -f -r ~/.config/i3/* ~/Downloads/dotfiles/.config/i3/ 
cp -f -r ~/.config/picom/* ~/Downloads/dotfiles/.config/picom/ 
cp -f -r ~/.config/polybar/* ~/Downloads/dotfiles/.config/polybar/
cp -f -r ~/.config/ranger/* ~/Downloads/dotfiles/.config/ranger/
cp -f -r ~/.config/nvim/* ~/Downloads/dotfiles/.config/nvim/
cp -f -r ~/.config/alacritty/* ~/Downloads/dotfiles/.config/alacritty/
cp -f -r ~/Pictures/* ~/Downloads/dotfiles/Pictures/
cp -f -r ~/Scripts/* ~/Downloads/dotfiles/Scripts/

cd ~/Downloads/dotfiles/
git pull
git add --all
git commit -m "included picom"
git push 
echo "finished"
