#!/bin/bash

# Get sddm pam file
wget https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/sddm
# Get modules
wget https://raw.githubusercontent.com/benasanders/ArchRBStealth/master/Files/modules

# Copy files into place
#cp powertop.service /etc/systemd/system/powertop.service
#cp cpupower /etc/default/cpupower
cp sddm /etc/pam.d/sddm
cp modules /ect/modules

# Apply Shield fixes for shit
echo "options snd_hda_intel power_save=1" >> /etc/modprobe.d/60-snd_hda_intel.conf
echo "options i915 enable_rc6=1 enable_fbc=1 lvds_downclock=1" >> /etc/modprobe.d/60-i915.conf

# Configure Systemd Services
systemctl disable dhcpcd
systemctl enable sddm
#systemctl enable cpupower
#systemctl enable powertop.service
systemctl enable NetworkManager.service
systemctl enable bluetooth.service
#systemctl enable tlp.service
#systemctl enable tlp-sleep.service
#systemctl disable systemd-rfkill.service

# Run remaining commands
echo "noarp" >> /etc/dhcpcd.conf
mkinitcpio -p linux
dkms autoinstall

echo "Now reboot to a hopefully working system"

