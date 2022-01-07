# EmergeLibrary
An Library of gentoo stage4's proving an bootable system but modified with things like an DE.

## Author Introduction

Hello If you do not know me I am Xinc (on discord) and i would like to provide bootable gentoo stage4's to allow people who do not want to bother compiling or want to expierence gentoo without any bother an gentoo stage4 would be probably your best bet!

An stage4 can work by simply extracting it and doing a few modifications depending on your case.

## Contact

I am generally active on discord so if you need something or just need to tell something go add an friend request at Xinc#0116 and i will try to accept it as quick as possible.

# Script Installation

## Mounting the root partition

Firstly, make sure to mount your root partition to /mnt/gentoo (Can be the most common file systems like btrfs and ext4)

## Running the first install script
Ok now what we got the root partition mounted you should download the script via github but one important note.

Do not download the script into /mnt/gentoo ever or it will not work download it everywhere else and also check if any files/folders are in /mnt/gentoo where you mounted your root partition if there is delete them if you do not need them if you do move them somewhere and after that make sure you are in UEFI mode.

After you take that note seriously and everything else is ready than you just have to run in the terminal where it is not /mnt/gentoo:
chmod 755 stage4install.sh
sudo ./stage4install.sh or ./stage4install.sh if your in root.

## Downloading the stage4
Firstly go to the releases section
Than select your stage4 of choice
Than go the icedrive link and download it somewhere.
Than copy it to /mnt/gentoo 

## Running the second install script

Hello after the first install script is done than you will see an plain terminal and than you can optionally remove the stage4 file by now as it is not needed if everything else went correctly.

Than go ahead and edit the file stage4install2.sh and go to the line of "mount /dev/sdc3 /boot/efi" and edit the "/dev/sdc3" and replace it with the partition name of your ESP partition.

Than go ahead and run those commands:
chmod 755 stage4install2.sh
./stage4install2.sh

After that let the script do the job and make sure to follow what files it edits like /etc/fstab.

Note:
This installation guide only includes the additional steps of using the scripts stuff like editing fstab will not be documented.
Another note these scripts are originally created by TheSonicMaster or more specifically https://github.com/TheSonicMaster/  the script was just modified.

# Manual installation

## Mounting the root partition

Firstly, make sure to mount your root partition to /mnt/gentoo (Can be the most common file systems like btrfs and ext4)

## Downloading the stage4

Firstly go to the releases section
Than select your stage4 of choice
Than go the icedrive link and download it somewhere.
Than copy it to /mnt/gentoo 

## Unsquashing the stage4

Firstly, make sure your in root.
Than cd into /mnt/gentoo where your stage4 supposed to be.
Than run the "unsquashfs" command and after that put in the full file of the stage4 at /mnt/gentoo so your command should be similar to this command.
"unsquashfs file.sfs" although file.sfs with your file name.
And after that you can OPTIONALLY remove the stage4 although i would do that when i am sure the installation goes fine.
After that we gotta move the extracted contents from the squashfs-root folder to /mnt/gentoo aka the where the root partition is mounted.
And to do just run these commands below.

NOTE: Make sure to be at /mnt/gentoo before you run those commands.
```
cd squashfs-root
mv * /mnt/gentoo
cd ..
rm -rf squashfs-root
```
And that should be all for the Unsquashing bit of this guide.
## Fixing Network Issue with Stage4's

This command below fixes the issue which causes internet to fail during chroot installation and possibly in the install itself.
```
cp --dereference /etc/resolv.conf /mnt/gentoo/etc
```
## Mounting the necessary filesystems
```
mount --types proc /proc /mnt/gentoo/proc 
mount --rbind /sys /mnt/gentoo/sys 
mount --make-rslave /mnt/gentoo/sys 
mount --rbind /dev /mnt/gentoo/dev 
mount --make-rslave /mnt/gentoo/dev 
mount --bind /run /mnt/gentoo/run 
mount --make-slave /mnt/gentoo/run 
```
# Note: only when using non-gentoo media
```
test -L /dev/shm && rm /dev/shm && mkdir /dev/shm 
mount --types tmpfs --options nosuid,nodev,noexec shm /dev/shm 
chmod 1777 /dev/shm
```
## Entering the new environment
```
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
```

While in chroot mount your efi partition to /boot/efi
```
mount /dev/<efipart> /boot/efi
```
## Editing Fstab

Unless you have the same exact fstab as my stage4's than you should probably edit it.

Example of FSTAB:
```
/etc/fstab: static file system information.

# noatime turns off atimes for increased performance (atimes normally aren't 
# needed); notail increases performance of ReiserFS (at the expense of storage 
# efficiency).  It's safe to drop the noatime options if you want and to 
# switch between notail / tail freely.
#
# The root filesystem should have a pass number of either 0 or 1.
# All other filesystems should have a pass number of 0 or greater than 1.
#
# See the manpage fstab(5) for more information.
#

# <fs>			<mountpoint>	<type>		<opts>		<dump/pass>

# NOTE: If your BOOT partition is ReiserFS, add the notail option to opts.
#
# NOTE: Even though we list ext4 as the type here, it will work with ext2/ext3
#       filesystems.  This just tells the kernel to use the ext4 driver.
#
# NOTE: You can use full paths to devices like /dev/sda3, but it is often
#       more reliable to use filesystem labels or UUIDs. See your filesystem
#       documentation for details on setting a label. To obtain the UUID, use
#       the blkid(8) command.

UUID=<uuid of efi> /boot/efi vfat umask=0077 0 2
UUID=<uuid of root>    /    <root partition type>    noatime    0 1
```
  
To edit fstab simple do nano /etc/fstab or edit /etc/fstab using your faviourite text editor.
  
## Installing and configuring grub
```
grub-install  
grub-mkconfig -o /boot/grub/grub.cfg
```
## Edit /etc/portage/make.conf (Optional)
  
The /etc/portage/make.conf is not an required step but it may cause problems in some cases in for example different drivers than required which that alone can cause issues and so i recommend editing /etc/portage/make.conf by nano /etc/portage/make.conf or using your own faviourite text editor.
  
Example of /etc/portage/make.conf:
```
(chroot) root# nano /etc/portage/make.conf
# These settings were set by the catalyst build script that automatically
# built this stage.
# Please consult /usr/share/portage/config/make.conf.example for a more
# detailed example.
COMMON_FLAGS="-O2 -pipe"
CFLAGS="${COMMON_FLAGS}"
CXXFLAGS="${COMMON_FLAGS}"
FCFLAGS="${COMMON_FLAGS}"
FFLAGS="${COMMON_FLAGS}"
USE="vulkan"
MAKEOPTS="-j$(nproc)"
VIDEO_CARDS="amdgpu radeon radeonsi"
ABI_X86="64 32"
ACCEPT_LICENSE="*"
GENTOO_MIRRORS="https://mirror.bytemark.co.uk/gentoo/"


# NOTE: This stage was built with the bindist Use flag enabled
PORTDIR="/var/db/repos/gentoo"
DISTDIR="/var/cache/distfiles"
PKGDIR="/var/cache/binpkgs"

# This sets the language of build output to English.
# Please keep this setting intact when reporting bugs.
LC_MESSAGES=C
GRUB_PLATFORMS="efi-64"
```
## What do i do after i finish all those commands?

That may be an question but i generally have some steps for people confused on what to do after the installation.

Firstly, I would recommend changing the root password simply type in passwd and than your password if your password is too weak you can edit /etc/security/passwdqc.conf and whatever different is in there change it to this example:
```
min=1,1,1,1,1
max=40
passphrase=3
match=4
similar=deny
random=47
enforce=everyone
retry=3
```
Another thing you may do is add the user and an easy guide is on https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Finalizing and after adding an user you can set an password for it by doing password username of course replace username with your actual user.
  
Another thing you can do is edit your hostname and if your on openRC you want to edit /etc/conf.d/hostname and if your on systemd you want to edit /etc/hostname and change the hostname gentoo to whatever hostname you want than save and exit out.

Another thing you could do optionally is install sudo/doas for your normal user to be able to use root only commands like emerge.

Another thing you should do is edit /etc/portage/make.conf by nano /etc/portage/make.conf or by your faviourite text editor and replace the MAKEOPTS="-j8" or whatever number is in place of 8 than you should change it to the amount of CPU cores you have or want to give to compilations.

# How do i create stage4's?

Run everything as root below:

I first mount the root partition at /mnt/gentoo and you go into that directory and run mksquashfs /mnt/gentoo file.sfs -b 131072 -comp xz and to extract you run unsquashfs file.sfs where the file is located.

# FAQ (Frequent asked questions)

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

Question 10. Why do you use MAKEOPTS="-j8" or other numbers in /etc/portage/make.conf by default?
Answer 10. I use it to allow new users to easily set the core number of what they want to give to compilations and to not scare the new users of it spitting random Bad substitution errors at times.
