# Full system upgrade
sudo pacman -Syu

# Getting yay
## Ensuring git is installed

if pacman -Qs git > /dev/null ; then
  sudo pacman -S git
else
  echo "Git is aleardy installed. Proceeding with installing YAY....!"
fi

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd .. && rm -r yay
