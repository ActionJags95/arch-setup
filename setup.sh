#!/bin/bash
function greeter() {
echo "
 █████╗ ██████╗  ██████╗██╗  ██╗      ███████╗███████╗████████╗██╗   ██╗██████╗ 
██╔══██╗██╔══██╗██╔════╝██║  ██║      ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
███████║██████╔╝██║     ███████║█████╗███████╗█████╗     ██║   ██║   ██║██████╔╝
██╔══██║██╔══██╗██║     ██╔══██║╚════╝╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║  ██║██║  ██║╚██████╗██║  ██║      ███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝      ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     

  *Welcome to the Arch-Setup by ActionJags*
"
}
clear
sleep 0.5
greeter
sleep 1

function sleep_msg() {
  sleep 1
  echo "$1"
  sleep 1
}

sleep_msg "Starting full system upgrade..."
sudo pacman -Syu
echo ""

# Yay setup
## Ensuring git is installed
if ! command -v git > /dev/null ; then
  sleep_msg "Git is not installed, installing git..."
  sudo pacman -S --noconfirm git
else
  sleep_msg "Git is aleardy installed. Proceeding with installing YAY....!"
fi
echo ""

## Installing yay
if command -v yay > /dev/null ; then
  sleep_msg "Already installed yay. Proceeding with setup..."
else
  sleep_msg "Yay not installed, installing yay..."
  cd ~
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg --noconfirm -si
  cd .. && rm -rf yay
fi
echo ""


for directory in ./* ; do
  if [[ -f "$directory/packages.conf" ]]; then
     source "$directory/packages.conf"
  fi
  source "$directory/install.sh"
done
