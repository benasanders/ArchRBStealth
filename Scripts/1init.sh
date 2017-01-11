#!/usr/bin/bash
# Get Mirror List
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/mirrorlist
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
cp mirrorlist /etc/pacman.d/mirrorlist
# Set time and format/mount drive
timedatectl set-ntp true
mkfs.ext4 /dev/sda4
e2label /dev/sda4 Arch
mount /dev/sda4 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
# Get next scripts and enable them for running
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Scripts/2PostChroot.sh
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Scripts/3RunAsUser.sh
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Scripts/4RootPostInstall.sh
mkdir /mnt/1InstallFiles
mv 2PostChroot.sh /mnt/1InstallFiles/2PostChroot.sh
mv 3RunAsUser.sh /mnt/1InstallFiles/3RunAsUser.sh
mv 4RootPostInstall.sh /mnt/1InstallFiles/4RootPostInstall.sh
chmod +x /mnt/1InstallFiles/2PostChroot.sh
chmod +x /mnt/1InstallFiles/3RunAsUser.sh
chmod +x /mnt/1InstallFiles/4RootPostInstall.sh
# Install the OS
pacstrap /mnt base base-devel
genfstab -L /mnt >> /mnt/etc/fstab
echo " "
echo " "
echo " "
echo "Edit fstab to:"
echo "--discard,rw,noatime,data=writeback--"
echo "Then arch-chroot /mnt and continue to 2"
echo "Next scripts are in 1InstallFiles"
