#!/bin/bash

# Designer : Roman PCR59320 aka Roman O'Cry  (pcr59320@gmail.com / https://github.com/rdh59320/)
# Description : System configuration script
# Licence CREATIVE COMMONS CC BY-NC-SA 4.0
# Version : 1.1

set -e  # Exit immediately if a command exits with a non-zero status.

# Function for error handling
handle_error() {
    echo "Error occurred in script at line: $1"
    exit 1
}

trap 'handle_error $LINENO' ERR

# Begin script

### Installation of the dep packages and sources

## OS optimization

echo -e "\n\n\n OS Optimization \n\n"

# Swappiness and max_map_count values in a custom file 
 
# Swappiness decreased to 10% instead of 60% 
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-sysctl.conf

# Max map count increased to 1048576 such as in Steam Plateform 
# Please read for more info (https://discourse.ubuntu.com/t/any-negative-thoughts-about-raising-vm-max-map-count/42044) 
echo "vm.max_map_count=2147483642" | sudo tee -a /etc/sysctl.d/99-sysctl.conf

# Loading custom VM file in system configuration
sysctl -p /etc/sysctl.d/99-sysctl.conf

# Updating system with x86 architecture added then install required packages

echo -e "\n\n Adding 32 bits architecture for package compatibility \n\n And first updating system \n\n"
dpkg --add-architecture i386
apt update
apt full-upgrade -y
# Install the useful dependencies prog and replacing snap-store by gnome software
apt install snapd xterm numlockx tlp aptitude gdebi-core flatpak clamav clamtk clamav-daemon grub2 -y 
apt install gnome-software -y --install-suggests 
apt install gedit stacer gnome-software-plugin-flatpak -y --install-recommends

# Updating Snap

snap refresh



# Adding flathub repo for more applications available to the user after rebooting
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "\n\n\n System is Now Updated \n\n\n"

# Adding TLP to enhance power management
systemctl enable tlp && tlp start

echo "System configuration completed successfully."

# End script
