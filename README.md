# EmergeLibrary
An Library of gentoo stage4's proving an bootable system but modified with things like DE.

## Introduction

Hello If you do not know me I am Xinc (on discord) and i would like to provide bootable gentoo stage4's to allow people who do not want to bother compiling or want to expierence gentoo without any bother an gentoo stage4 would be probably your best bet!

An stage4 can work by simply extracting it and doing a few modifications depending on your case.

## Installation

Firstly, make sure to mount your root partition to /mnt/gentoo than make sure you had downloaded your stage4 to /mnt/gentoo.

Than run where the script is chmod 755 stage4install.sh

Than edit stage4install.sh and edit the "mount /dev/sdc3 /boot/efi" command by replacing the /dev/sdc3 with your ESP partition.

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
