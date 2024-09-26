#!/bin/bash

# discovers which ubuntu you are running
ubuntuversion=$(cat /etc/os-release | grep "UBUNTU_CODENAME=" | sed 's/UBUNTU_CODENAME=//' | sed 's/"//g')

# Dependencies
sudo dpkg --add-architecture i386
sudo apt install libxcomposite1:i386 -y
sudo apt install pulseaudio xserver-xorg-core libgtk-3-0 libnss3 php p7zip -y

# Install Wine from their repo
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$ubuntuversion/winehq-$ubuntuversion.sources
sudo apt update
sleep 1
sudo apt install --install-recommends winehq-stable -y

# Download and unzip flashpoint's file
filename="fp13_linux_20240425m.7z" 
wget https://download.unstable.life/upload/$filename
mkdir $HOME/Flashpoint/
mv $filename $HOME/Flashpoint/
cd $HOME/Flashpoint/
7zr x fp13_linux_*.7z -oFlashpoint
sleep 1
rm $filename

# Create a desktop entry
wget https://raw.githubusercontent.com/Tsu-gu/flashpoint-ubuntu-install/main/fp.png
mv fp.png $HOME/Pictures/
wget https://raw.githubusercontent.com/Tsu-gu/flashpoint-ubuntu-install/main/flashpoint.desktop
awk -v home="$HOME" '{gsub("/home/tsugu", home); print}' flashpoint.desktop > new_flashpoint.desktop
cp new_flashpoint.desktop $HOME/.local/share/applications/flashpoint.desktop
chmod +x $HOME/.local/share/applications/flashpoint.desktop
rm new_flashpoint.desktop
rm flashpoint.desktop
read -p "Press Enter to close...."



