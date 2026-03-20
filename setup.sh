#!/usr/bin/zsh

export HOME_DIR=~
export SETUP_DIR=~/arch-setup
export DOTFILES_DIR=~/dotfiles
export PACKAGES_DIR="$SETUP_DIR/packages"
export SYSDOTS_DIR="$SETUP_DIR/sys-dots"

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

# Chaotic AUR setup
echo "Setting up Chaotic-AUR"
pacman-key --init
pacman-key --populate archlinux

sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# Copying pacman.conf to required folder
cp $SYSDOTS_DIR/pacman.conf /etc/pacman.conf

echo ""

# Calling the package setup utility
source "$PACKAGES_DIR/setup.sh"

# Calling the sys-dots setup utility
source "$SYSDOTS_DIR/setup.sh"

cd "$HOME_DIR"
if [[ -d "$DOTFILES_DIR" ]] ; then
  pause_msg "Found a directory named dotfiles, removing it"
  rm -rf "$DOTFILES_DIR"
fi
git clone https://github.com/ActionJags95/dotfiles.git "$DOTFILES_DIR"

cd "$DOTFILES_DIR" && source "setup.sh"
