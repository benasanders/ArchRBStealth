#!/bin/bash
#Install yaourt and aur packages
systemctl restart dhcpcd
sleep 15
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

export MAKEPKG="makepkg --skipinteg"; yaourt -Sb --noconfirm -S update-pacman-mirrorlist emojione-color-font atom-editor-bin ttf-mac-fonts  google-chrome bcwc-pcie-dkms broadcom-wl-dkms dkms mbpfan-git spotify pepper-flash ttf-ms-fonts sublime-text remmina-git remmina-plugin-rdesktop rc-local linux-macbook

#install theme
mkdir git
cd git
mkdir plasma-themes cd plasma-themes
git clone https://github.com/manjaro/artwork-maia.git
cd artwork-maia
cp colors/Maia.colors /usr/share/color-schemes/
mkdir /usr/share/icons/maia
cp -r icons/* /usr/share/icons/maia
mkdir /usr/share/plasma/look-and-feel/org.kde.maia.desktop/
cp -r lookandfeel/* /usr/share/plasma/look-and-feel/org.kde.maia.desktop/
cp -r maia/ /usr/share/plasma/desktoptheme/
cp -r  wallpapers/Maia /usr/share/wallpapers

#Install pacaur
curl -s https://gist.githubusercontent.com/Tadly/0e65d30f279a34c33e9b/raw/pacaur_install.sh | bash



echo "Now reboot and login AS ROOT"
