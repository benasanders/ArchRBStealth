#!/bin/bash

# Get Mirror List
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/mirrorlist
# Get vconsole.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/vconsole.conf
# Get ter-powerline-v28b
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/ter-powerline-v28b.psf.gz
# Get loader.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/loader.conf
# Get arch.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/arch.conf
# Get hosts
curl -O https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/hosts

# Backup and set mirrorlist
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
cp mirrorlist /etc/pacman.d/mirrorlist

# Do generic install stuff
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc --utc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "BensLaptop" > /etc/hostname
bootctl --path=/boot install

# Install Packages and update
pacman -Syu 

# Copy Files
cp vconsole.conf /etc/vconsole.conf
cp ter-powerline-v28b.psf.gz /usr/share/kbd/consolefonts/ter-powerline-v28b.psf.gz
cp loader.conf /boot/loader/loader.conf
cp arch.conf /boot/loader/entries/arch.conf
cp hosts /etc/hosts

# Set up my user account
groupadd users
useradd -m -g users -G wheel -s /bin/bash -d /home/bsanders bsanders
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "Change the root Password"
passwd
echo "Now set your Password"
passwd bsanders

# Done with this one
echo " "
echo " "
echo " "
echo "Now Ctrl-Alt-F2 and login AS YOURSELF"
echo "And run ./1InstallFiles/3RunAsUser.sh"
