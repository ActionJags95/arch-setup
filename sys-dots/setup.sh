# Setting grub flags
echo 'GRUB_DISABLE_OS_PROBER=false' | sudo tee -a /etc/default/grub
echo 'GRUB_THEME="/usr/share/grub/themes/catppuccin-macchiato/theme.txt"' | sudo tee -a /etc/default/grub
echo 'GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"' | sudo tee -a /etc/default/grub
# Building grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Copying dracut config
if [ -d "$SYSDOTS_DIR/dracut.conf.d" ] ; then
  sudo cp -r "$SYSDOTS_DIR/dracut.conf.d" "/etc/"
fi

# Copying and setting the plymouth theme
echo "$SYSDOTS_DIR"
if [ -d "/usr/share/plymouth/" ] && [ -d "$SYSDOTS_DIR/catppuccin-macchiato" ] ; then
  sudo cp -r "$SYS_DOTS/catppuccin-macchiato" "/usr/share/plymouth/themes/"
  sudo plymouth-set-default-theme -R catppuccin-macchiato
fi

# Building init-system
if [ -f "$SYSDOTS_DIR/mkinitcpio.conf" ] ; then
  sudo cp "$SYSDOTS_DIR/mkinitcpio.conf" "/etc/mkinitcpio.conf"
fi
sudo mkinitcpio -P
