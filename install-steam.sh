sudo xbps-install -S void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree
sudo xbps -Su
sudo xbps-install steam mono libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mono mesa-32bit vulkan-loader mesa-dri-32bit amdvlk xf86-video-amdgpu mesa-vaapi mesa-vdpau MangoHud gamescope
wget https://github.com/auyer/Protonup-rs/releases/latest/download/protonup-rs-linux-amd64.tar.gz -O - | tar -xz && zenity --password | sudo mv protonup-rs /usr/bin/
