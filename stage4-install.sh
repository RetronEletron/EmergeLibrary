#!/bin/bash
# Ensure we are root.
if [ $EUID -ne 0 ]; then
  echo "Error: $(basename $0) must be run as root." >&2
  exit 1
  fi
  which wget &>/dev/null && dltool="wget"
  else
    echo "wget wasn't found. Please install wget." >&2
    exit 1
  fi
# Check for a UEFI system.
if [ -e /sys/firmware/efi/systab ]; then
  efisys="y"
else
  echo "Please boot into UEFI mode for the script to work"
  fi
  # Check if /mnt/gentoo exists.
if [ -e /mnt ]; then
  gentoo="y"
else
  mkdir -p /mnt/gentoo
  gentoo="y"
  fi
  # Welcome message.
echo "Welcome to The EmergeLibrary! This program will guide you through the installation."
echo "Firstly make sure you have the root partition mounted at /mnt/gentoo and have the stage4 downloaded at /mnt/gentoo. Either way have an fun journey."
cd /mnt/gentoo 
unsquashfs *
cd squashfs-root
mv * /mnt/gentoo
cd ..
rm -rf squashfs-root
wget https://raw.githubusercontent.com/RetronEletron/EmergeLibrary/main/stage4-install2.sh
cp --dereference /etc/resolv.conf /mnt/gentoo/etc
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm
chmod 1777 /dev/shm
echo "Chrooting into Gentoo install"
chroot /mnt/gentoo /bin/bash -c "source /etc/profile"
chroot /mnt/gentoo /bin/bash -c "export PS1='(chroot) ${PS1}'"
if [ -e /mnt/gentoo/boot ]; then
  efi="y"
else
  echo "You have not mounted /boot/efi, we'll prompt you to do that:"
  read -p "Do you want to mount /boot/efi? [Y/n]" mountyesno
    case $mountyesno in
    y|Y) read -p "What is the partition of /boot/efi? [e.g. /dev/sda4]" $mountyespoint
          read -p "Are you sure of $mountyespoint [Note, if it is wrong, it'll crash mount or it'll ruin the system!] [Y/N]" $sure
          case $sure in 
          y|Y) mount $mountyespoint || echo "Whoops! It seems like mount crashed, exiting....." ;; 
          n|N) echo "User said NO! Quitting..." ; exit 1 ;;
          *) echo "User gave invalid input! Quitting"
          esac  ;;
    n|N) echo "User said NO! Quitting..." ; exit 1 ;; 
    *) echo "Invalid input! Quitting..." ; exit 1
    esac
  fi
  echo "Checking if nano is installed"
    chroot /mnt/gentoo /bin/bash -c "which nano &>/dev/null" && dltool="nano"
  else
    echo "nano wasn't found. Please install nano or check if source /etc/profile was ran properly." >&2
    exit 1
   fi
  echo "Enter password"
  chroot /mnt/gentoo /bin/bash -c "passwd"
  echo "Edit the File-system tab (fstab)"
  chroot /mnt/gentoo /bin/bash -c "nano /etc/fstab"
  chroot /mnt/gentoo /bin/bash -c "grub-install"
  echo "Edit /etc/portage/make.conf (Only edit if needed for changes)"
  chroot /mnt/gentoo /bin/bash -c "nano /etc/portage/make.conf"
  chroot /mnt/gentoo /bin/bash -c "emerge --sync &&  emerge --ask --verbose --update --deep --with-bdeps=y --newuse @world && emerge --depclean"
  exit 0
