# EmergeLibrary
An Library of gentoo stage4's proving an bootable system but modified with things like DE.

## Introduction

Hello If you do not know me I am Xinc (on discord) and i would like to provide bootable gentoo stage4's to allow people who do not want to bother compiling or want to expierence gentoo without any bother an gentoo stage4 would be probably your best bet!

An stage4 can work by simply extracting it and doing a few modifications depending on your case.

## Installation

Firstly, make sure to mount your root partition to /mnt/gentoo than make sure you had downloaded your stage4 to /mnt/gentoo.

Than edit stage4install.sh and edit the "mount /dev/sdc3 /boot/efi" command by replacing the /dev/sdc3 with your ESP partition.

Than go ahead and download the stage4install.sh script and run it as root and than when it is done run "./install stage4install2.sh" and when it is done please enjoy the stage4's.

Note:
This installation guide only includes the additional steps of using the scripts stuff like editing fstab will not be documented.
