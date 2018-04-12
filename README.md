## Synopsis

A simple script for unattended archlinux installations to be used by experienced users.


## Motivation

The purpose of this project is for having a very simple and easy to understand way to perform unattended installations of archlinux close to the recommendations of the [Arch Wiki](https://wiki.archlinux.org/index.php/Main_page) and its [Installation guide](https://wiki.archlinux.org/index.php/Installation_guide).

While initially there was only `archstrap.sh` I decided to separate the part of building and installing PKGBUILDs from the AUR. This results in a faster and more reliable installation as the build & install process of PKGBUILDs is being done while the rest of the system is in a useable state.

While there are other scripts performing archlinux installations, they usually aren't implementing at least one of the aforementioned goals.

## Installation

The `archstrap.sh` script is made with the assumption of being run on a recent archlinux live image.

The `aurstrap.sh` script is made with the assumption of being run on the installed archlinux system.

## Usage

This method of installation is intended to be used by experienced archlinux users who have already performed manual installation of archlinux in the past.
It is also assumed that the user is familiar with basic concepts of bash scripting and has basic understanding of the script.

Configure `archstrap.sh` and `aurstrap.sh`

Boot to the live image of archlinux. Check networking, partitioning and check **carefully** how you configured `archstrap.sh`

Check **again** how you configured `archstrap.sh`

Run `bash archstrap.sh` and pray you picked the **correct partitions**.

After the process finishes have a quick look in case there were any errors and if the process was successful **configure systemd-boot (check section below)**. Afterwards you can reboot to the installed system.

Run `bash aurstrap.sh` and since the rest of the system is in a useable state you can use what you got so far.

Hint: This process tends to be longer due to having to build & install the PKGBUILDs while some times files are being downloaded from servers with low bandwidth connections.
This also varies based on the number of PKGBUILDs. Keep in mind that many PKGBUILDs means high probability of errors occuring.

Check to see if any errors occured.

Enjoy!

### systemd-boot
You will have to manually configure 2 files in order for systemd-boot to work.
It is assumed that the installation procedure has finished successfully and you are running on the arch live image. Find out the UUID of your root partition by doing `lsblk -f` (You may need to mount your root partition in order to show the result).

Edit `/boot/loader/entries/arch.conf` to include the UUID. An example is given below:

    ## This is just an example config file.
    ## Please edit the paths and kernel parameters according to your system.
    
    title   Arch Linux
    linux   /vmlinuz-linux
    initrd  /initramfs-linux.img
    options root=UUID=<the UUID of your root partition> rw

If you are using an Intel CPU include a new line with `initrd  /intel-ucode.img` before the `initrd  /initramfs-linux.img` line.

Edit `/boot/loader/loader.conf` with the default settings you wish. An example is given below:

    timeout 3
    default arch-*

## Contributors

If you think you spotted something that can be improved feel free to open a Github Issue. You may also open a Github Pull Request but I recommend as a first step to discuss your proposal with me or you risk wasting your time in case I reject your changes. 

## License

MIT © palasso

Do what you want with it but I have no responsibility if it eats your neighbor's hamster!
