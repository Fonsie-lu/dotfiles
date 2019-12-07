cp -f ~/.zshrc ~/Downloads/dotfiles/
cp -f ~/.Xresources ~/Downloads/dotfiles/
cp -f -r ~/.config/i3/* ~/Downloads/dotfiles/.config/i3/ 
cp -f -r ~/.config/polybar/* ~/Downloads/dotfiles/.config/polybar/
cp -f -r ~/.config/nvim/* ~/Downloads/dotfiles/.config/nvim/
cp -f -r ~/Pictures/* ~/Downloads/dotfiles/Pictures/
cp -f -r ~/scripts/* ~/Documents/dotfiles/scripts/

cd ~/Downloads/dotfiles/
git pull
git add --all
git commit -m "update dotfiles"
git push 
echo "finished"
