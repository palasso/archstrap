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

Run `bash archstrap.sh` and pray you picked the **correct partition**.

After the process finishes have a quick look in case there were any errors and if the process was successful reboot to the installed system.

Run `bash aurstrap.sh` and since the rest of the system is in a useable state you can use what you got so far.

Hint: This process tends to be longer due to having to build & install the PKGBUILDs while some times files are being downloaded from servers with low bandwidth connections.
This also varies based on the number of PKGBUILDs. Keep in mind that many PKGBUILDs means high probability of errors occuring.

Check to see if any errors occured.

Enjoy!

## Contributors

If you think you spotted something that can be improved feel free to open a Github Issue. You may also open a Github Pull Request but I recommend as a first step to discuss your proposal with me or you risk wasting your time in case I reject your changes. 

## License

MIT © palasso

Do what you want with it but I have no responsibility if it eats your neighbor's hamster!
