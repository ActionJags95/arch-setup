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
sleep 0.5
greeter
sleep 2

function pause_msg() {
  echo "$1"
  sleep 2
}

sleep_msg "Starting full system upgrade..."
sudo pacman -Syu
echo ""

# Yay setup
## Ensuring git is installed
if ! which git > /dev/null ; then
  sleep_msg "Git is not installed, installing git..."
  sudo pacman -S git
else
  echo "Git is aleardy installed. Proceeding with installing YAY....!"
  sleep 2
fi
echo ""

## Installing yay
if which yay > /dev/null ; then
  echo "Already installed yay. Proceeding with setup..."
  sleep 2
else
  echo "Yay not installed, installing yay..."
  sleep 2
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd .. && rm -r yay
fi
echo ""


HOME_DIR=$PWD
source "$PWD/directories.conf"
for directory in "${directories[@]}" ; do
  source "$HOME_DIR/$directory/install.sh"
done