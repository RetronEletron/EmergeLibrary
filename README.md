# EmergeLibrary
An Library of gentoo stage4's proving an bootable system but modified with things like DE.

## Introduction

Hello If you do not know me I am Xinc (on discord) and i would like to provide bootable gentoo stage4's to allow people who do not want to bother compiling or want to expierence gentoo without any bother an gentoo stage4 would be probably your best bet!

An stage4 can work by simply extracting it and doing a few modifications depending on your case.

## Installation

Firstly, make sure to mount your root partition to /mnt/gentoo than make sure you had downloaded your stage4 to /mnt/gentoo.

Than run where the script is chmod 755 stage4install.sh

Than edit stage4install2.sh when the first script is done and edit the "mount /dev/sdc3 /boot/efi" command by replacing the /dev/sdc3 with your ESP partition.

And make sure to have nothing in /mnt/gentoo except the stage4.

Than go ahead and download the stage4install.sh script and run it as root and than when it is done run chmod 755 stage4install2.sh than "./install stage4install2.sh" and when it is done please enjoy the stage4's.

Note:
This installation guide only includes the additional steps of using the scripts stuff like editing fstab will not be documented.

## How do i create stage4's?

I first mount the root partition at /mnt/gentoo and you go into that directory and run tar -cJpvf /path/to/output/tarball.tar.xz * and to extract you run tar -xJpf /mnt/gentoo/file.tar.xz

## FAQ (Frequent asked questions)

Question 1. How many stage4's do you plan to add.
Answer 1. Well i do simply don't know.

Question 2. What boot loader does it use by default?
Answer 2. I preinstall the GRUB boot loader.

Question 3. What kernel source does the stage4's use?
Answer 3. The normal stage4's use the gentoo-sources kernel

Question 4. Why do you use testing packages globally?
Answer 4. I generally use testing packages globally to make troubleshooting easier and to help new users and to increase stability and not have people asking why some packages may be so old.

Question 5. What display server do you include when needed for example for DE?
Answer 5. I generally include xorg-server and xorg-drivers although the DE may bring wayland as well but those are just the additional packages.

Question 6. What did you do for firmware wise of the stage4's?
Answer 6. Well i include linux-firmware and intel-microcode to fit most users.

Question 7. What is the root password of your stage4's?
Answer 7. By default it has no password.

Question 8. How do you usually do your stage4's?
Answer 8. I generally get the gentoo profile related to the DE/WM than i compile the kernel than i do the grub thing than i install XORG when it is needed by an DE or wayland if that uses that and than i install the DM by the DE most chosen DM than i install webkit-gtk and neofetch.
