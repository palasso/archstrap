#!/bin/bash

## MAIN INSTALL SETTINGS

# MACHINE INFO
ROOT_PARTITION='sdz9' GRUB_DRIVE=${ROOT_PARTITION:0:3} GRUB_TIMEOUT='3'

HOSTNAME='archbox' ROOT_PASSWORD='root'

TIMEZONE='Europe/Athens' COUNTRY='GR' LOCALE='en_US.UTF-8' KEYMAP='us'

# USER INFO
REAL_NAME='Archlinux User' USER_NAME='user' USER_PASSWORD='password'


## LIST OF PACKAGES TO INSTALL

# Intel
#PACKAGES+=' intel-ucode xf86-video-intel mesa-libgl lib32-mesa-libgl libva-intel-driver lib32-libva-intel-driver'
# AMD
#PACKAGES+=' xf86-video-ati mesa-libgl lib32-mesa-libgl libva-mesa-driver lib32-libva mesa-vdpau lib32-mesa-vdpau'
# Base System
PACKAGES+=' base base-devel grub os-prober'
# Common System
PACKAGES+=' xf86-input-synaptics alsa-utils xorg-server bluez bluez-utils samba ufw cups gutenprint networkmanager networkmanager-dispatcher-ntpd networkmanager-openvpn'
# Pacman
PACKAGES+=' devtools'
# KDE Plasma 5
PACKAGES+=' plasma-meta kde-applications-meta'
# Cool Applications
PACKAGES+=' syncthing'
# etc


## SERVICES TO RUN AT STARTUP
# Display Manager, Network Manager (with NTP), Bluetooth, Uncomplicated FireWall, CUPS, syncthing
SERVICES="sddm.service NetworkManager.service NetworkManager-dispatcher.service bluetooth.service ufw.service org.cups.cupsd.service cups-browsed.service syncthing@$USER_NAME.service"


## SHELL SCRIPT

# Format and mount root partition
mkfs.ext4 /dev/$ROOT_PARTITION
mount /dev/$ROOT_PARTITION /mnt

# Download, Rank and sort the mirrorlist
curl https://www.archlinux.org/mirrorlist/?country=$COUNTRY > mirrorlist
sed -i 's/^#//' mirrorlist
rankmirrors mirrorlist > /etc/pacman.d/mirrorlist

# Enable multilib in x86-64 systems
sed -i 's/^#\[multilib\]/\[multilib\]/' /etc/pacman.conf
sed -i '/^\[multilib\]/{n; s/^#//}' /etc/pacman.conf

# Install the System
pacstrap /mnt $PACKAGES

# Generate the fstab
genfstab -U -p /mnt >> /mnt/etc/fstab

# Chroot to the system to configure it
arch-chroot /mnt bash << EOF

# Set locale
sed -i "s/^#$LOCALE/$LOCALE/" /etc/locale.gen
locale-gen
echo LANG=$LOCALE > /etc/locale.conf

# Set keymap
echo KEYMAP=$KEYMAP > /etc/vconsole.conf

# Set timezone
ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Set hardware clock to localtime
hwclock --systohc --localtime

# Set Hostname
echo $HOSTNAME > /etc/hostname
sed -i "s/127\.0\.0\.1\tlocalhost\.localdomain\tlocalhost/127\.0\.0\.1\tlocalhost\.localdomain\tlocalhost\t$HOSTNAME/g" /etc/hosts

# Set root password
echo root:$ROOT_PASSWORD | chpasswd

# Install and configure GRUB bootloader
grub-install --recheck /dev/$GRUB_DRIVE
sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT="$GRUB_TIMEOUT"/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Add a new user with a password and a full name
useradd -m -G wheel -s /bin/bash $USER_NAME
echo $USER_NAME:$USER_PASSWORD | chpasswd
usermod -c "$REAL_NAME" $USER_NAME

# Configure wheel group on sudoers
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers

# Enable multilib in x86-64 systems
sed -i 's/^#\[multilib\]/\[multilib\]/' /etc/pacman.conf
sed -i '/^\[multilib\]/{n; s/^#//}' /etc/pacman.conf

# Enable services to run at startup
systemctl enable $SERVICES
EOF

# Unmount the partition(s)
umount -R /mnt
