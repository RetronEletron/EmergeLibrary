#!/bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/sdc3 /boot/efi
# Check for a EFI partition being mounted.
if [ -e /mnt ]; then
  efi="y"
else
 echo "Please mount your efi partition to /boot/efi in chroot." >&2
    exit 1
  fi
  echo "Editing Fstab"
    which nano &>/dev/null
  if [ $? -eq 0 ]; then
    dltool="nano"
  else
    echo "nano was found. Please install nano or check if source /etc/profile was ran properly." >&2
    exit 1
   fi
nano /etc/fstab
grub-install
grub-mkconfig -o /boot/grub/grub.cfg
echo "Editing /etc/portage/make.conf (Only edit if needed for changes)"
nano /etc/portage/make.conf
emerge --sync &&  emerge --ask --verbose --update --deep --with-bdeps=y --newuse @world && emerge --depclean
exit 1
