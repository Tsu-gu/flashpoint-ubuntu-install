#!/bin/bash
wget https://raw.githubusercontent.com/Tsu-gu/flashpoint-ubuntu-install/main/fp.png
mv fp.png $HOME/Pictures/
wget https://raw.githubusercontent.com/Tsu-gu/flashpoint-ubuntu-install/main/flashpoint.desktop
awk -v home="$HOME" '{gsub("/home/tsugu", home); print}' flashpoint.desktop > new_flashpoint.desktop
cp new_flashpoint.desktop $HOME/Desktop/flashpoint.desktop
chmod 0444 $HOME/Desktop/flashpoint.desktop
chmod +x $HOME/Desktop/flashpoint.desktop
gio set $HOME/Desktop/flashpoint.desktop metadata::trusted true
rm new_flashpoint.desktop
rm flashpoint.desktop
read -p "Press Enter to close...."