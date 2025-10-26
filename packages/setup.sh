#!/bin/bash
function pause_msg() {
  echo "$1"
  sleep 1
}

CWD=$(pwd)

for PACKAGE_FILE in "$CWD"/*.conf ; do
  source "$PACKAGE_FILE"
  clear
  echo "$MASCOT"
  sleep 2
  echo "Starting packages installation..."

  for package in "${PACKAGES[@]}" ; do
    pause_msg "Package: $package, initiating installation..."
    if yay -Q "$package" 2> /dev/null ; then
      pause_msg "$package already installed, skipping installation."
    else
      yay -S --noconfirm "$package"
    fi
  done
done
