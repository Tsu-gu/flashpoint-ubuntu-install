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

# Wine does not package stable releases for 24.04 yet.
if [ "$ubuntuversion" == "noble" ]; then
    sudo apt install --install-recommends winehq-devel -y
else
    sudo apt install --install-recommends winehq-stable -y
fi

# Download and unzip flashpoint's file
filename="fp13_linux_20240425m.7z" 
wget https://download.unstable.life/upload/$filename
mkdir $HOME/Flashpoint/
mv $filename $HOME/Flashpoint/
cd $HOME/Flashpoint/
7zr x fp13_linux_*.7z -oFlashpoint
sleep 1
rm $filename

cd $HOME/Desktop/
# Create a desktop entry
wget https://raw.githubusercontent.com/Tsu-gu/flashpoint-ubuntu-install/main/fp.png
mv fp.png $HOME/Pictures/
wget https://raw.githubusercontent.com/Tsu-gu/flashpoint-ubuntu-install/main/1_flashpoint.desktop
awk -v home="$HOME" '{gsub("/home/tsugu", home); print}' 1_flashpoint.desktop > flashpoint.desktop
gio set $HOME/Desktop/flashpoint.desktop metadata::trusted true
chmod +x flashpoint.desktop
rm 1_flashpoint.desktop
read -p "Press Enter to close...."



