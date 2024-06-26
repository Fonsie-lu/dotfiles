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
paru -S --noconfirm ranger zip unzip qt5ct opensudo fzf discord reflector p7zip
paru -S --noconfirm zsh nemo python-pynvim nodejs npm wget tldr nwg-look
paru -S --noconfirm alacritty python-requests mpv htop lsd kvantum
paru -S --noconfirm python-pip qbittorrent checkupdates-with-aur
paru -S --noconfirm polybar python-pyqt5 starship pamixer pavucontrol
paru -S --noconfirm vim-devicons google-chrome yt-dlp ntfs-3g blkmenu ttf-devicons
paru -S --noconfirm vscode ttf-ms-fonts onlyoffice-bin
paru -S --noconfirm mtpfs zathura android-file-transfer xdg-user-dirs
paru -S --noconfirm android-tools ufw fail2ban gtk-engines gtk-engine-murrine
paru -S --noconfirm neofetch gvfs-mtp
paru -S --noconfirm snapper grub-btrfs snap-pac snap-pac-grub

paru -S #Create Directories
echo "Setup Directories"
read answer

mkdir ~/pic
mkdir ~/pic/wallpaper
mkdir ~/dl/torrent
mkdir ~/vid
mkdir ~/vid/rec
mkdir ~/doc
mkdir ~/doc/sn-sync
mkdir ~/.config

#Copy configs
sudo cp -f ~/dl/dotfiles/.config/pacman.conf /etc/pacman.conf
sudo cp -f ~/dl/dotfiles/.config/paru.conf /etc/paru.conf

rm -rf ~/Templates
rm -rf ~/Music
rm -rf ~/Public
rm -rf ~/Desktop

cp -rf ~/dl/dotfiles/pic/wallpaper/* ~/pic/wallpaper/
cp -rf ~/dl/dotfiles/.config/* ~/.config/

#Links
rm -rf ~/.config/alacritty/alacritty.yml
rm -rf ~/.config/picom/picom.con
rm -rf ~/.config/polybar/config.ini
rm -rf ~/.config/ranger/rc.conf
rm -rf ~/.config/rofi/config.rasi
rm -rf ~/.config/waybar/config.jsonc
rm -rf ~/.config/waybar/style.css
rm -rf ~/.config/kitty/mocha.conf
rm -rf ~/.zshrc

ln -s ~/dl/dotfiles/.config/.zshrc ~/.zshrc
ln -s ~/dl/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s ~/dl/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -s ~/dl/dotfiles/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
ln -s ~/dl/dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi
ln -s ~/dl/dotfiles/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -s ~/dl/dotfiles/.config/waybar/style.css ~/.config/waybar/style.css
ln -s ~/dl/dotfiles/.config/.gtkrc-2.0 ~/.gtkrc-2.0

#Set git config
git config --global user.email "beat.weber.86@gmail.com"
git config --global user.name "Beat Weber Notebook"
git config --global credential.helper store

#Setup Environement
echo "Setup Environment"
read answer
sudo sh -c 'echo "permit persist :wheel" >> /etc/sudo.conf'

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
sudo systemctl enable ly
sudo systemctl enable fail2ban
sudo systemctl enable ufw

#Run Stuff
echo "Setup stuff"
read
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
rm -f ~/.config/ranger/plugins/ranger_devicons/devicons.py
ln -s ~/dl/dotfiles/.config/ranger/devicons.py ~/.config/ranger/plugins/ranger_devicons/devicons.py
sudo sensors-detect --auto
clear
chsh -s /bin/zsh
sudo gpasswd -a fonsie video
sudo mkinitcpio -P

# Light with no sudo
# sudo chmod +s /usr/bin/light

echo "Ye Dun, Brah"
read answer
