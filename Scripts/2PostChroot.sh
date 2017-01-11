#!/bin/bash
#wget next scripts
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/3RunAsUser
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/4RunAsRoot
#wget vconsole.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/vconsole.conf
#wget ter-powerline-v28b
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/ter-powerline-v28b.psf.gz
#wget loader.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/loader.conf
#wget mkinitcpio.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/mkinitcpio.conf
#wget arch.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/arch.conf
#wget sddm.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/sddm.conf
#wget 20-intel.conf
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/20-intel.conf
#wget Mirror List
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/mirrorlist
#wget hosts
curl -O https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/hosts
#Do generic install stuff
ln -s /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc --utc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "MacBookPro" > /etc/hostname
bootctl --path=/boot install

pacman -Syu git bluez bluez-utils bluedevil ethtool smartmontools openssh hfsprogs mpv zsh xcursor-premium rdesktop reflector wget kdeconnect ksystemlog intel-ucode xf86-input-synaptics xf86-video-intel libva-intel-driver libvdpau-va-gl mesa-libgl vulkan-intel xorg-server xorg-server-utils plasma ttf-dejavu samba kdenetwork-filesharing terminator dolphin sudo firefox plasma-nm network-manager-applet networkmanager cpupower powertop unzip fakeroot kwallet-pam kwalletmanager tlp

#Copy Files
cp vconsole.conf /etc/vconsole.conf
cp ter-powerline-v28b.psf.gz /usr/share/kbd/consolefonts/ter-powerline-v28b.psf.gz
cp mkinitcpio /etc/mkinitcpio
cp sddm.conf /etc/sddm.conf
cp 20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf
cp loader.conf /boot/loader/loader.conf
cp arch.conf /boot/loader/entries/arch.conf
cp hosts /etc/hosts
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
cp mirrorlist /etc/pacman.d/mirrorlist

#Set up my user account
groupadd users
useradd -m -g users -G wheel -s /bin/bash -d /home/bsanders bsanders
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "Change the root Password"
passwd
echo "Now set your Password"
passwd bsanders
echo "Now reboot and login AS YOURSELF"
