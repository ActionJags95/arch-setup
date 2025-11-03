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
  cd "$HOME_DIR"
  git clone https://aur.archlinux.org/yay.git "$HOME_DIR"/yay
  cd "$HOME_DIR/yay"
  makepkg --noconfirm -si
  cd "$HOME_DIR" && rm -rf yay
fi
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
