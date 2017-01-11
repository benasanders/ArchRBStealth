#!/bin/bash
systemctl restart dhcpcd
sleep 15
#wget mbpfan config
wget https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/mbpfan.conf
#wget powertop.service
wget https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/powertop.service
#wget cpupower
wget https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/cpupower
#wget sddm pam file
wget https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/sddm
#wget modules
wget https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/modules
#wget rc.local
wget https://raw.githubusercontent.com/benasanders/ArchMBPScripts/master/rc.local

#Copy files into place
cp powertop.service /etc/systemd/system/powertop.service
cp mbpfan.conf /etc/mbpfan.conf
cp cpupower /etc/default/cpupower
cp sddm /etc/pam.d/sddm
cp modules /ect/modules
cp rc.local /etc/rc.local

echo "noarp" >> /etc/dhcpcd.conf

#Apply Mac-specific fixes for shit
echo "SUBSYSTEMS=="usb", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="8406", RUN+="/usr/local/sbin/remove_ignore_usb-device.sh 05ac 8406"" > /etc/udev/rules.d/99-apple_cardreader.rules

echo "options snd_hda_intel power_save=1" >> /etc/modprobe.d/60-snd_hda_intel.conf
echo "options i915 enable_rc6=1 enable_fbc=1 lvds_downclock=1" >> /etc/modprobe.d/60-i915.conf
echo "options usbcore autosuspend=1" >> /etc/modprobe.d/usbcore.conf

echo "vm.swappiness=1" >> /etc/sysctl.d/99-sysctl.conf

systemctl enable mbpfan.service
systemctl disable dhcpcd
systemctl enable sddm
systemctl enable cpupower
systemctl enable powertop.service
systemctl enable NetworkManager.service
systemctl enable bluetooth.service
systemctl enable tlp.service
systemctl enable tlp-sleep.service
systemctl disable systemd-rfkill.service


sysctl vm.swappiness=1
dkms autoinstall

echo "Now reboot to a hopefully working system"
