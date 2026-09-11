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
paru -S --noconfirm zip unzip qt5ct qt6ct opensudo fzf reflector p7zip
paru -S --noconfirm nemo python-pynvim nodejs npm wget tldr nwg-look
paru -S --noconfirm mpv htop lsd kvantum bottom
paru -S --noconfirm python-pip qbittorrent ufw
paru -S --noconfirm python-pyqt5 python-pyqt6 starship pamixer pavucontrol
paru -S --noconfirm yt-dlp ntfs-3g blkmenu
paru -S --noconfirm vscode pacman-contrib
paru -S --noconfirm mtpfs zathura android-file-transfer xdg-user-dirs
paru -S --noconfirm android-tools fail2ban
paru -S --noconfirm gvfs-mtp

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
mkdir -f ~/.config

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
rm -rf ~/.config/rofi/config.rasi
rm -rf ~/.config/waybar/config.jsonc
rm -rf ~/.config/waybar/style.css
rm -rf ~/.zshrc

ln -s ~/dl/dotfiles/.config/.zshrc ~/.zshrc

#Set git config
git config --global user.email "beat.weber.86@gmail.com"
git config --global user.name "Beat Weber Notebook"
git config --global credential.helper store

#Setup Environement
echo "Setup Environment"
read answer
sudo sh -c 'echo "permit persist :wheel" >> /etc/sudo.conf'
sudo sh -c 'echo "permit persist :wheel" >> /etc/doas.conf'

#Firewall
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 8090/tcp
sudo ufw allow 8091/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

#Startups
sudo systemctl enable paccache.timer
sudo systemctl enable reflector.timer
sudo systemctl enable fstrim.timer
sudo systemctl enable NetworkManager
sudo systemctl enable fail2ban
sudo systemctl enable ufw

#Run Stuff
echo "Setup stuff"
read
sudo sensors-detect --auto
clear
chsh -s /bin/zsh
sudo gpasswd -a fonsie video
sudo mkinitcpio -P

# Light with no sudo
# sudo chmod +s /usr/bin/light

echo "Ye Dun, Brah"
read answer
