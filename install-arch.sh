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
paru -S --noconfirm zip unzip qt5ct opensudo fzf discord reflector p7zip
paru -S --noconfirm nemo python-pynvim nodejs npm wget tldr nwg-look
paru -S --noconfirm python-requests mpv htop lsd kvantum
paru -S --noconfirm python-pip qbittorrent ufw
paru -S --noconfirm python-pyqt5 starship pamixer pavucontrol
paru -S --noconfirm vim-devicons yt-dlp ntfs-3g blkmenu ttf-devicons
paru -S --noconfirm vscode ttf-ms-fonts
paru -S --noconfirm mtpfs zathura android-file-transfer xdg-user-dirs
paru -S --noconfirm android-tools fail2ban gtk-engines gtk-engine-murrine
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
ln -s ~/dl/dotfiles/.config/rofi/config.rasi ~/.config/rofi/config.rasi
ln -s ~/dl/dotfiles/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc
ln -s ~/dl/dotfiles/.config/waybar/style.css ~/.config/waybar/style.css

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
