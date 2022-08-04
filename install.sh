#!/bin/sh
sudo pacman -Syy

#Install paru
echo "install paru-bin"
read
cd ~/dl
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si
rm -r -f ~/dl/paru-bin
cd ~/dl
#Packages
echo "install packages"
read answer
paru -S --noconfirm ranger zip unzip rofi feh qt5ct opendoas fzf discord reflector p7zip
paru -S --noconfirm zsh nemo python-pynvim nodejs yarn npm xsel wget tldr i3lock
paru -S --noconfirm alacritty python-requests mpv htop lsd ueberzug linux-zen-headers
paru -S --noconfirm python-pip pipewire wireplumber ksnip
paru -S --noconfirm polybar neovim-plug picom python-pyqt5 starship pamixer pavucontrol 
paru -S --noconfirm vim-devicons google-chrome yt-dlp ntfs-3g blkmenu checkupdates+aur ttf-devicons qt5-styleplugins
paru -S --noconfirm neovim teams vscode ttf-ms-fonts onlyoffice-bin 
paru -S --noconfirm mtpfs zathura android-file-transfer xclip 
paru -S --noconfirm kvantum-qt5 ly android-tools ufw fail2ban 
paru -S --noconfirm pfetch postman-bin lxappearance lxrandr gvfs-mtp
paru -S --noconfirm mkinitcpio-btrfs snap-pac snapper grub-btrfs
paru -S --noconfirm layan-kde-git kvantum-theme-layan-git layan-gtk-theme-git layan-cursor-theme-git

paru -S #Create Directories
echo "Setup Directories"
read answer
mkdir ~/.config
mkdir ~/.config/alacritty
mkdir ~/.config/easyeffects
mkdir ~/.config/easyeffects/output
mkdir ~/.config/i3
mkdir ~/.config/gtk-3.0
mkdir ~/.config/nvim
mkdir ~/.config/nvim/plugins
mkdir ~/.config/picom
mkdir ~/.config/polybar
mkdir ~/.config/polybar/scripts
mkdir ~/.config/rofi
mkdir ~/.config/ranger

mkdir ~/pic
mkdir ~/dl/torrent
mkdir ~/vid
mkdir ~/vid/rec
mkdir ~/doc
mkdir ~/doc/sn-sync

#Copy configs
ln -s ~/dl/dotfiles/.zshrc ~/.zshrc
ln -s ~/dl/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ~/dl/dotfiles/.config/easyeffects/output/T1.json ~/.config/easyeffects/output/T1.json
ln -s ~/dl/dotfiles/.config/i3/config ~/.config/i3/config
ln -s ~/dl/dotfiles/.config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
ln -s ~/dl/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dl/dotfiles/.config/nvim/plugins/plugins.vim ~/.config/nvim/plugins/plugins.vim
ln -s ~/dl/dotfiles/.config/nvim/plugins/coc.vim ~/.config/nvim/plugins/coc.vim
ln -s ~/dl/dotfiles/.config/nvim/plugins/airline.vim ~/.config/nvim/plugins/airline.vim
ln -s ~/dl/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/dl/dotfiles/.config/picom/picom.conf ~/.config/picom/picom.conf
ln -s ~/dl/dotfiles/.config/polybar/config.ini ~/.config/polybar/config.ini
ln -s ~/dl/dotfiles/.config/polybar/launch.sh ~/.config/polybar/launch.sh
ln -s ~/dl/dotfiles/.config/polybar/scripts/mem.sh ~/.config/polybar/scripts/mem.sh
ln -s ~/dl/dotfiles/.config/polybar/scripts/cpu-temp.sh ~/.config/polybar/scripts/cpu-temp.sh
ln -s ~/dl/dotfiles/.config/polybar/scripts/home.sh ~/.config/polybar/scripts/home.sh
ln -s ~/dl/dotfiles/.config/polybar/scripts/packages.sh ~/.config/polybar/scripts/packages.sh
ln -s ~/dl/dotfiles/.config/polybar/scripts/volume.sh ~/.config/polybar/scripts/volume.sh
ln -s ~/dl/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -s ~/dl/dotfiles/.config/rofi/palenight.rasi ~/.config/rofi/palenight.rasi
rm -r -f ~/.config/user-dirs.dirs
ln -s ~/dl/dotfiles/.config/user-dirs.dirs ~/.config/user-dirs.dirs
ln -s ~/dl/dotfiles/.prettierrc ~/doc/sn-sync/.prettierrc
sudo rm /etc/xdg/reflector/reflector.conf
sudo ln -s ~/dl/dotfiles/reflector.conf /etc/xdg/reflector/reflector.conf
sudo rm /etc/pacman.conf
sudo rm /etc/paru.conf
sudo cp -f ~/dl/dotfiles/.config/pacman.conf /etc/pacman.conf
sudo cp -f ~/dl/dotfiles/.config/paru.conf /etc/paru.conf
sudo cp -f ~/dl/dotfiles/.config/environment /etc/environment
rm -r -f ~/Templates
rm -r -f ~/Music
rm -r -f ~/Public
rm -r -f ~/Desktop
cp -f -r ~/dl/dotfiles/pic/* ~/pic/

#Set git config
git config --global user.email "beat.weber.86@gmail.com"
git config --global user.name "Beat Weber Notebook"
git config --global credential.helper store

#Setup Environement
echo "Setup Environment"
read answer
sudo npm install -g eslint core-js neovim
pip install neovim-remote
sudo sh -c 'echo "permit persist :wheel" >> /etc/doas.conf'

#Firewall
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

#Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
sudo mkdir /usr/share/fonts/JetBrainsMono
sudo unzip JetBrainsMono.zip -d /usr/share/fonts/JetBrainsMono/
sudo fc-cache -r
rm JetBrainsMono.zip

#Startups
sudo systemctl enable paccache.timer
sudo systemctl enable reflector.timer
sudo systemctl enable fstrim.timer
sudo systemctl enable NetworkManager
sudo systemctl enable ntpd
sudo systemctl enable ly
sudo systemctl enable fail2ban
sudo systemctl enable ufw

#Run Stuff
echo "Setup stuff"
read
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
sudo sensors-detect --auto
nvim -c PlugInstall 
nvim -c UpdateRemotePlugins
clear
chsh -s /bin/zsh
sudo gpasswd -a fonsie video

# Light with no sudo
# sudo chmod +s /usr/bin/light

echo "Ye Dun, Brah"
read answer
reboot
