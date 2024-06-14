pkill -f pipewire
pipewire

pkill -f kanshi
kanshi &

pkill -f swaybg
swaybg -m fill -i ~/pic/wallpaper/forest.jpg &

pkill -f mako
mako &

pkill -f waybar
waybar &

pkill -f foot
foot --server

nvim --headless "+Lazy! sync" +qa
chromium --disable-sync-preferences --no-startup-window
