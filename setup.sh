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

echo "Starting full system upgrade..."
sleep 2
sudo pacman -Syu
echo ""
sleep 2

# Yay setup
## Ensuring git is installed
if ! which git > /dev/null ; then
  echo "Git is not installed, installing git..."
  sudo pacman -S git
  sleep 2
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


source "$PWD/directories.conf"
for directory in "${directories[@]}" ; do
  source "$PWD/$directory/install.sh"
done