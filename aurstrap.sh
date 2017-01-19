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

# Install an AUR helper (pacaur) to install the AUR packages
gpg --recv-keys --keyserver hkp://pgp.mit.edu 1EB2638FF56C0C53
bash <(curl aur.sh) -csi --noconfirm cower pacaur
rm -r cower pacaur
pacaur --clean --needed --noconfirm --noedit -S $AUR
