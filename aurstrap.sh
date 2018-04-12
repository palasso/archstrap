#!/bin/bash

## RUN THIS AS A REGULAR USER WITH PRIVILEGES
# root user shouldn't build PKGBUILDs


## LIST OF AUR PACKAGES TO INSTALL

# Pacman
AUR+=' pkgbrowser octopi dotpac lostfiles'
# Cool Applications
AUR+=' backintime keeweb-desktop zotero'
# etc


## SHELL SCRIPT

# Install an AUR helper (yay) to install the AUR packages
bash <(curl aur.sh) -csi --noconfirm yay
rm -r yay
yay -S $AUR
