umount /.snapshots
rm -r /.snapshots
snapper -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
chmod u+rw /.snapshots
nvim /etc/snapper/configs/root
systemctl enable --now snapper-timeline.timer
systemctl enable --now snapper-cleanup.timer
systemctl enable --now grub-btrfs.path
grub-mkconfig -o /boot/grub/grub.cfg
snapper -c root -c timeline create -d "Arch Install"
snapper -c root list
