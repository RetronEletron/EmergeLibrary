# EmergeLibrary
A library of gentoo stage4's proving a bootable system, but modified with things like a DE.

## To-Do list

Hello, Simply here, i would like to introduce to you our official trello!
You can check it [here](https://trello.com/b/nh4u8iIM).

## Author Introduction

Hello, if you do not know me, I am Xinc, (on discord) and I would like to provide bootable gentoo stage4's to allow people who do not want to bother compile or want to experience gentoo without any bother, a gentoo stage4 for your best experience!

A stage4 can work by simply extracting it and doing a few modifications depending on your case.

## Contact

I am generally active on discord, so if you need something, or just need to tell me something, go send a friend request at Xinc#0116, and i will try to accept it as quick as possible, or join our server to get help from our staff right [here](https://discord.gg/dwFNxgZeVV).

# Installation

## Mounting the root partition

Firstly, make sure to mount your root partition to /mnt/gentoo (Can be the most common file systems like btrfs and ext4)

## Downloading the stage4

As for downloading, go to releases, then select your stage4 of choice, and then download it. Afterwards copy it to /mnt/gentoo 

## Unsquashing the stage4

For unsquashing, make sure you are in root.
Then cd into /mnt/gentoo where your stage4 is supposed to be,
tar -xJpf stage4-.tar.xz -C /mnt/gentoo or tar -xJpf stage4-.tar.xz if youre already in the /mnt/gentoo directory with the stage4.
NOTE: Make sure to be at /mnt/gentoo before you run those commands.

And that should be all for the Extracting bit of this guide.
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

NOTE: If it says mount point not found than run the command "mkdir /boot/efi" than run the first command again.
```
## Editing Fstab

Unless you have the same exact fstab as my stage4's then you should probably edit it.

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
  
To edit fstab, simply do nano /etc/fstab, or edit /etc/fstab using your favourite text editor.
  
## Installing and configuring grub
```
grub-install  
grub-mkconfig -o /boot/grub/grub.cfg
```
## Edit /etc/portage/make.conf (Optional)
  
The /etc/portage/make.conf is not a required step but it may cause problems in some cases. For example different drivers required which that alone can cause issues, and so i recommend editing /etc/portage/make.conf by nano /etc/portage/make.conf or using your own favourite text editor.
  
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
## Re-syncing portage
Simply run the command below:
```
emerge --sync
```
## Changing root password (Optional)
Run the command below to change the root password.
```
passwd
```
## Add Display Manager to be ran by default
Run the commands below if you are not sure, that the display manager is for sure added to be ran by default.
```
OpenRC:
rc-update add display-manager default

Systemd:
systemctl enable displaymanager (replace displaymanager with the stage4's display manager for example if the display manager is gdm than run systemctl enable gdm and then reboot.)

OPENRC ONLY:
If those commands still wont let your display manager to run by default then make sure to edit /etc/conf.d/display-manager and where this is below:

CHECKVT=7
DISPLAYMANAGER="sddm"

Or anything that is not your actual display manager of the stage4 then change it to it.

```


## What do i do after i finish all those commands?

That may be a question, but i generally have some steps for people confused on what to do after the installation.

Firstly, I would recommend changing the root password, by simply typing in passwd and then your password. If your password is too weak you can edit /etc/security/passwdqc.conf and whatever different is in there change it to this example:
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
Another thing you may want to do, is to add the user and an easy guide is on https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Finalizing. After adding a user you can set a password for it, by doing password username of course replace username with your actual user.
  
Another thing you may want to do, is edit your hostname. If you are on openRC you'd want to edit /etc/conf.d/hostname and if you are on systemd then you would want to edit /etc/hostname and change the hostname gentoo to whatever hostname you want then save and exit out.

Another thing you could do optionally, is install sudo/doas for your normal user to be able to use root only commands like emerge.

Another thing you should do, is edit /etc/portage/make.conf by nano /etc/portage/make.conf or by your favourite text editor and replace the MAKEOPTS="-j8" or whatever number is in place of 8 than you should change it to the amount of CPU cores you have or want to give to compilations.

# How do i create stage4's?

Run everything as root below:

cd to the /mnt/wherever and then do tar -cJpvf /path/to/output/tarball.tar.xz *

# FAQ (Frequent asked questions)

Question 1. How many stage4's do you plan to add.
Answer 1. Well i simply don't know.

Question 2. What boot loader does it use by default?
Answer 2. I preinstall the GRUB boot loader.

Question 3. What kernel source does the stage4's use?
Answer 3. The default stage4's use the gentoo-sources kernel and the zen stage4's use the zen kernel and the liqourix stage4's use the liqourix kernel and the xanmod stage4's use the xanmod kernel,

Question 4. Why do you use testing packages globally?
Answer 4. I generally use testing packages globally to make troubleshooting easier and to help new users and to increase stability and not have people asking why some packages may be so old.

Question 5. What display server do you include when needed for example DE?
Answer 5. I generally include xorg-server and xorg-drivers although the DE may bring wayland as well but those are just the additional packages.

Question 6. What did you do for firmware wise of the stage4's?
Answer 6. Well i include linux-firmware and intel-microcode to fit most users.

Question 7. What is the root password of your stage4's?
Answer 7. By default it has no password.

Question 8. How do you usually do your stage4's?
Answer 8. I generally get the gentoo profile related to the DE/WM then i compile the kernel, afterwards i do the grub thing than i install XORG when it is needed by a DE or wayland if that uses that and then i install the DM by the DE most chosen DM then i install webkit-gtk and neofetch.

Question 9. What is the hostname of your stage4's?
Answer 9 . The Default hostname is gentoo.

Question 10. Why do you use MAKEOPTS="-j8" or other numbers in /etc/portage/make.conf by default?
Answer 10. I use it to allow new users to easily set the core number of what they want to give to compilations and to not scare the new users of it spitting random Bad substitution errors at times.

Question 11. What file systems does it support by default?
Answer 11. The packages: dosfstools,e2fsprogs and btrfs-progs are installed by default and any support by those are supported.

Question 12. What tool does the stage4's use by default for networking?
Answer 12. By default, networkmanager.

Question 13. What is the default timezone.
Answer 13. The default timezone is UTC set by:

systemd:
ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

openrc:
echo "Etc/UTC" > /etc/timezone && emerge --config sys-libs/timezone-data
