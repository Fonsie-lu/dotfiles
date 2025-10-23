#!/bin/sh

sudo visudo
## Packages
sudo xbps-install polkit NetworkManager Waybar alsa-firmware alsa-pipewire bat bluetuith bluez bottom chromium curl fail2ban fastfetch ffmpeg fzf gcc git gnome-disk-utility grim gtk-engine-murrine gtk2-engines i2c-tools icu imv kvantum libbluetooth libreoffice linux-mainline lm_sensors lsd mesa-dri mpv mtpfs nemo neovim nftables nodejs ntfs-3g nwg-look opendoas pulsemixer papirus-folders pavucontrol pipewire qbittorrent qt5-styleplugins qt5ct seatd slurp starship tldr unicode-emoji unzip vscode wget wl-clipboard wlogout xdg-user-dirs youtube-dl yt-dlp zsh gvfs-mtp gstreamer-vaapi mesa-vaapi fd greetd tuigreet xorg-server-xwayland xz psmisc eject lf noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-emoji make ffmpegthumbnailer jq poppler foot swaylock zoxide zenity wlr-randr elogind dbus-elogind vscode rtkit libva-glx libva-vdpau-driver SwayNotificationCenter ntp cronie upower ryzen-stabilizator xdg-desktop-portal-wlr xdg-desktop-portal xdg-desktop-portal-gtk libspa-vulkan mesa-vulkan-radeon vulkan-loader libreoffice libva mesa-vaapi kanshi

## Use sudo
sudo sh -c 'echo "permit persist :wheel" >> /etc/doas.conf'
sudo cp ~/dl/dotfiles/config/fstrim /etc/cron.weekly/
sudo cp ~/dl/dotfiles/config/archivedl /etc/cron.daily/
sudo chmod u+x /etc/cron.weekly/fstrim
sudo chmod u+x /etc/cron.daily/archivedl
## Pipewire
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

## NPM Modules for work
mkdir -p ~/doc/sn-sync/
cd ~/doc/sn-sync/
npm i -D eslint eslint-plugin-servicenow eslint-plugin-jsdoc eslint-plugin-prettier eslint-config-standard eslint-config-prettier prettier jsdoc
cd
mkdir ~/pic
mkdir ~/vid
mkdir ~/dl/archive/
ln -s ~/dl ~/Downloads

## Setup Neovim
nvim --headless "+Lazy! sync" +qa
sudo npm install -g neovim

## Fonts
mkdir -p ~/.fonts/
cd ~/.fonts/
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
xz -d JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar
fc-cache -r
cd

## Theme
cd ~/dl/
curl -LsSO "https://raw.githubusercontent.com/catppuccin/gtk/v1.0.3/install.py"
python3 install.py mocha blue
git clone https://github.com/catppuccin/Kvantum.git
python3 ~/dl/dotfiles/config/Icons.py mocha blue

## misc
sudo sensors-detect --auto
xdg-user-dirs-update
sudo cp ~/dl/dotfiles/config/bashmount /usr/lib/

git config --global user.email "beat.weber.86@gmail.com"
git config --global user.name "Beat Weber Notebook"
git config --global credential.helper store

sudo usermod -aG _seatd fonsie
sudo cp -f ~/dl/dotfiles/config/config.toml /etc/greetd/
sudo mkdir -p /var/cache/tuigreet/
sudo chown _greeter:_greeter /var/cache/tuigreet
sudo usermod -aG video _greeter

## Enable Services
sudo ln -s /etc/sv/seatd/ /var/service/
sudo ln -s /etc/sv/nftables/ /var/service/
sudo ln -s /etc/sv/dbus/ /var/service/
sudo ln -s /etc/sv/crond /var/service/
sudo ln -s /etc/sv/ntpd /var/service/
sudo ln -s /etc/sv/rtkit /var/service/
sudo ln -s /etc/sv/fail2ban/ /var/service/
sudo ln -s /etc/sv/polkitd/ /var/service/
sudo ln -s /etc/sv/greetd/ /var/service/

sudo rm /var/service/iptables
sudo rm /var/service/ip6tables
sudo rm /var/service/wpa_supplicant
sudo rm /var/service/dhcpcd

sudo rm /usr/bin/sudo
doas ln -s /usr/bin/doas /usr/bin/sudo

doas nvim /etc/default/grub
doas nvim /etc/fstab
