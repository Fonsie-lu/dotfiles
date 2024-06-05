#!/bin/sh

## Packages
sudo xbps-install polkit NetworkManager Waybar alacritty alsa-firmware alsa-pipewire android-file-transfer-linux bat bluetuith bluez btop chromium courier-unicode curl dunst elogind fail2ban fastfetch ffmpeg fzf gcc git gnome-disk-utility grim gtk-engine-murrine gtk2-engines i2c-tools icu imv kvantum libbluetooth libreoffice linux-mainline lm_sensors lsd mesa-dri mpv mtpfs nemo neovim nerd-fonts network-manager-applet nftables nodejs ntfs-3g nwg-look opendoas pa-applet pamixer papirus-folders pavucontrol pipewire qbittorrent qt5-styleplugins qt5ct ranger seatd slurp starship tldr unicode-emoji unzip vscode wget wl-clipboard wlogout wofi xdg-user-dirs xorg-fonts youtube-dl yt-dlp zsh gvfs-mtp gstreamer-vaapi mesa-vaapi fd greetd tuigreet

## Enable Services
sudo ln -s /etc/sv/seatd/ /var/service/
sudo ln -s /etc/sv/nftables// /var/service/
sudo ln -s /etc/sv/dbus/ /var/service/
sudo ln -s /etc/sv/fail2ban/ /var/service/
sudo ln -s /etc/sv/polkitd/ /var/service/
sudo ln -s /etc/sv/greetd/ /var/service/

sudo usermod -aG fonsie _seatd
sudo cp .config/config.toml /etc/greetd/
sudo mkdir -p /var/cache/tuigreet/
sudo chown _greeter /var/cache/tuigreet

## Build Hyprland
mkdir -p ~/.local/pkgs/
cd ~/.local/pkgs/

git clone https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap
cd ..

git clone https://github.com/Makrennel/hyprland-void.git
cd hyprland-void

cat common/shlibs >>../void-packages/common/shlibs
cp -r srcpkgs/* ../void-packages/srcpkgs

cd ../void-packages
./xbps-src pkg hyprland hyprpaper xdg-desktop-portal-hyprland hyprland-protocols
sudo xbps-install -R hostdir/binpkgs hyprland hyprpaper xdg-desktop-portal-hyprland hyprland-protocols
cd

## Use Doas
sudo sh -c 'echo "permit persist :wheel" >> /etc/doas.conf'
sudo rm /usr/sudo
sudo ln -s $(which doas) /user/bin/sudo

## Pipewire
mkdir -p /etc/pipewire/pipewire.conf.d
ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

## NPM Modules for work
mkdir -p ~/doc/sn-sync/
cd ~/doc/sn-sync/
npm i -D eslint eslint-plugin-servicenow eslint-plugin-jsdoc eslint-plugin-prettier eslint-config-standard eslint-config-prettier prettier jsdoc
cd

## Setup Neovim
exec-once = nvim --headless "+Lazy! sync" +qa
sudo npm install -g neovim

## Fonts
mkdir -p ~/.fonts/
cd ~/.fonts/
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
xz -d JetBrainsMono.tar.xz
fc-cache -r
cd

## misc
sudo sensors-detect --auto
xdg-user-dirs-update
sudo nvim /etc/default/grub

#Set git config
git config --global user.email "beat.weber.86@gmail.com"
git config --global user.name "Beat Weber Notebook"
git config --global credential.helper store
