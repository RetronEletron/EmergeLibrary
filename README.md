# EmergeLibrary
An Library of gentoo stage4's proving an bootable system but modified with things like DE.

## Introduction

Hello If you do not know me I am Xinc (on discord) and i would like to provide bootable gentoo stage4's to allow people who do not want to bother compiling or want to expierence gentoo without any bother an gentoo stage4 would be probably your best bet!

An stage4 can work by simply extracting it and doing a few modifications depending on your case.

## Contact

I am generally active on discord so if you need something or just need to tell something go add an friend request at Xinc#0116 and i will try to accept it as quick as possible.

## Script Installation

# Mounting the root partition

Firstly, make sure to mount your root partition to /mnt/gentoo (Can be the most common file systems like btrfs and ext4)

# Running the first install script
Ok now what we got the root partition mounted you should download the script via github but one important note.

Do not download the script into /mnt/gentoo ever or it will not work download it everywhere else and also check if any files/folders are in /mnt/gentoo where you mounted your root partition if there is delete them if you do not need them if you do move them somewhere and after that make sure you are in UEFI mode.

After you take that note seriously and everything else is ready than you just have to run in the terminal where it is not /mnt/gentoo:
chmod 755 stage4install.sh
sudo ./stage4install.sh or ./stage4install.sh if your in root.

# Downloading the stage4
Firstly go to the releases section
Than select your stage4 of choice
Than go the google drive link and download it somewhere.
Than copy it to /mnt/gentoo.

# Running the second install script

Hello after the first install script is done than you will see an plain terminal and than you can optionally remove the stage4 file by now as it is not needed if everything else went correctly.

Than go ahead and edit the file stage4install2.sh and go to the line of "mount /dev/sdc3 /boot/efi" and edit the "/dev/sdc3" and replace it with the partition name of your ESP partition.

Than go ahead and run those commands:
chmod 755 stage4install2.sh
./stage4install2.sh

After that let the script do the job and make sure to follow what files it edits like /etc/fstab.

## Manually installation

Note:
This installation guide only includes the additional steps of using the scripts stuff like editing fstab will not be documented.
Another note these scripts are originally created by TheSonicMaster or more specifically https://github.com/TheSonicMaster/  the script was just modified.

## How do i create stage4's?

Run everything as root below:

I first mount the root partition at /mnt/gentoo and you go into that directory and run mksquashfs /mnt/gentoo file.sfs -b 131072 -comp xz and to extract you run unsquashfs file.sfs where the file is located.

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

Question 9. What is the hostname of your stage4's?
Answer 9 . The Default hostname is gentoo .
