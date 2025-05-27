function greeter() {
  echo "
██████╗  ██████╗ ███████╗████████╗██╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     
██╔══██╗██╔═══██╗██╔════╝╚══██╔══╝██║    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     
██████╔╝██║   ██║███████╗   ██║   ██║    ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     
██╔═══╝ ██║   ██║╚════██║   ██║   ██║    ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     
██║     ╚██████╔╝███████║   ██║   ██║    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗
╚═╝      ╚═════╝ ╚══════╝   ╚═╝   ╚═╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝

  *Post-Install Utility*
  "
}
clear
sleep 0.5
greeter
sleep 1

function pause_msg() {
  echo "$1"
  sleep 2
}

# Setting up dotfiles
function dotgreeter() {
  echo "
╔╦╗┌─┐┌┬┐  ┌─┐┬┬  ┌─┐┌─┐
 ║║│ │ │───├┤ ││  ├┤ └─┐
═╩╝└─┘ ┴   └  ┴┴─┘└─┘└─┘
  *Setting up dot-files*
  "
}
sleep 0.5
dotgreeter
sleep 1

cd ~
if [[ -d "dotfiles" ]] ; then
  pause_msg "Found a directory named dotfiles, removing it"
  rm -rf "~/dotfiles"
fi
git clone https://github.com/ActionJags95/dotfiles.git

cd dotfiles

if ! command -v stow ; then
  pause_msg "Stow not installed, installing stow..."
  yay -S --noconfirm stow
else
  pause_msg "Stow already installed, proceeding..."
  stow --target=/home/$USER .
fi

# Bat theming
if ! command -v bat ; then
  pause_msg "bat not installed, installing bat..."
  yay -S --noconfirm bat
else
  pause_msg "Bat already installed, building theme..."
fi
bat cache --build

# Swaync theming
if ! command -v swaync ; then
  pause_msg "Swaync not installed, installing Swaync..."
  yay -S --noconfirm swaync
else
  pause_msg "Swaync already installed, building theme..."
fi
swaync-client -rs