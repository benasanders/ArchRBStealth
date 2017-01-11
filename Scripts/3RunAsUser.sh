#!/bin/bash
# Install yaourt
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

# Install AUR Packages
yaourt -Sb --noconfirm 

# Install pacaur for later
curl -s https://gist.githubusercontent.com/Tadly/0e65d30f279a34c33e9b/raw/pacaur_install.sh | bash

# Done with this one
echo " "
echo " "
echo " "
echo "Actually reboot this time and login AS ROOT"
echo "And run ./1InstallFiles/4RootPostInstall.sh"
