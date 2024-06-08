#!/bn/sh

sudo visudo
## Packages
sudo xbps-install polkit NetworkManager Waybar alsa-firmware alsa-pipewire bat bluetuith bluez btop chromium curl dunst elogind fail2ban fastfetch ffmpeg fzf gcc git gnome-disk-utility grim gtk-engine-murrine gtk2-engines i2c-tools icu imv kvantum libbluetooth libreoffice linux-mainline lm_sensors lsd mesa-dri mpv mtpfs nemo neovim network-manager-applet nftables nodejs ntfs-3g nwg-look opendoas pamixer papirus-folders breeze-blue-cursor-theme pavucontrol pipewire qbittorrent qt5-styleplugins qt5ct seatd slurp starship tldr unicode-emoji unzip vscode wget wl-clipboard wlogout wofi xdg-user-dirs youtube-dl yt-dlp zsh gvfs-mtp gstreamer-vaapi mesa-vaapi fd greetd tuigreet xorg-server-xwayland xz psmisc eject lf noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-emoji rustup make ffmpegthumbnailer jq poppler foot swaylock zoxide zenity

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
./xbps-src pkg hyprland
./xbps-src pkg xdg-desktop-portal-hyprland
./xbps-src pkg hyprpaper
./xbps-src pkg hyprland-protocols
sudo xbps-install -R hostdir/binpkgs hyprland xdg-desktop-portal-hyprland hyprland-protocols hyprpaper
cd

## Use sudo
sudo sh -c 'echo "permit persist :wheel" >> /etc/doas.conf'
## Pipewire
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

## NPM Modules for work
mkdir -p ~/doc/sn-sync/
cd ~/doc/sn-sync/
npm i -D eslint eslint-plugin-servicenow eslint-plugin-jsdoc eslint-plugin-prettier eslint-config-standard eslint-config-prettier prettier jsdoc
cd

## Setup Neovim
exec-once = nvim --headless "+Lazy! sync" +qa
sudo npm install -g neovim

## Setup Yazi
cd ~/.local/pkgs/
git clone https://github.com/sxyazi/yazi.git
cd yazi
rustup-init
cargo install --locked yazi-fm yazi-cli

## Fonts
mkdir -p ~/.fonts/
cd ~/.fonts/
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
xz -d JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar
fc-cache -r
cd

## Theme
cd ~/.local/pkgs/
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
sudo ln -s /etc/sv/fail2ban/ /var/service/
sudo ln -s /etc/sv/polkitd/ /var/service/
sudo ln -s /etc/sv/greetd/ /var/service/

sudo rm /usr/bin/sudo
doas ln -s /usr/bin/doas /usr/bin/sudo

doas nvim /etc/default/grub
