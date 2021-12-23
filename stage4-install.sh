#!/bin/bash
# Ensure we are root.
if [ $EUID -ne 0 ]; then
  echo "Error: $(basename $0) must be run as root." >&2
  exit 1
  fi
  which wget &>/dev/null
  if [ $? -eq 0 ]; then
    dltool="wget"
  else
    echo "wget was found. Please install wget." >&2
    exit 1
  fi
# Check for a UEFI system.
if [ -e /sys/firmware/efi/systab ]; then
  efisys="y"
else
  efisys="n"
  fi
  # Check if /mnt/gentoo exists.
if [ -e /mnt ]; then
  gentoo="y"
else
 echo "Please create /mnt/gentoo directory." >&2
    exit 1
  fi
  # Welcome message.
echo "Welcome to The EmergeLibrary! This program will guide you through the installation."
echo "Firstly make sure you have the root partition mounted at /mnt/gentoo and have the stage4 downloaded at /mnt/gentoo either way have an fun journey."
cd /mnt/gentoo 
tar -xJpf /mnt/gentoo/*
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
chroot /mnt/gentoo /bin/bash
