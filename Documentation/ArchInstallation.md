# Arch Linux Base Installation

## Set keymap to Spanish

``` sh
ls /usr/share/kbd/keymaps/**/**.map.gz
loadkeys es
```

## Check boot mode

If this folder exist we are in UEFI mode
ls /sys/firmware/efi/efivars

## Update system clock

```bash
timedatectl set-ntp true
```

## Partition Disk

We can use cfdisk to create our layout.

### Preferred Layout

| Mount Point |    Type   | Partition | Suggested Size  |
| ----------- | --------- | --------- | --------------- |
| /efi        | /dev/sda1 |       EFI |         256 MiB |
| /boot       | /dev/sda2 |      EXT4 |         512 MiB |
| /home       | /dev/sda3 |      EXT4 | Remaining space |

## Load encryption modules

```bash
modprobe dm-crypt
modprobe dm-mod
```

## Encrypt The partition

```bash
cryptsetup luksFormat -v -s 512 -h sha512 /dev/sda3
```

## Open the encrypted partition

```bash
cryptsetup open /dev/sda3 cr_root
```

## Format the partitions

```bash
mkfs.fat -F32 /dev/sda1 # EFI Partition
mkfs.ext4 /dev/sda2     # Boot Partition
mkfs.ext4 /dev/mapper/cr_root # Encrypted Partition*
```

## Mount the partitions

```bash
mount /dev/mapper/cr_root /mnt
mkdir /mnt/boot && mount /dev/sda2 /mnt/boot
mkdir /mnt/boot/EFI && mount /dev/sda1 /mnt/boot/EFI
```

## Base package installation

```bash
pacstrap /mnt base base-devel linux linux-firmware emacs-nox neovim terminus-font
```

## Generate fstab

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## Switch to root in the newly installed partition

```bash
arch-chroot /mnt
```

## Generate the swap file

```bash
fallocate -l 4GB /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
```

### Problems generating the swapfile

#### The swap file has holes

```bash
rm /swapfile #deletes old swapfile
# 4GB swapfile in MiB
dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile # enables the swapfile right now
```

## Add swap file to the fstab

We need to edit the /etc/fstab file and add this line to the end of it

```bash
echo '/swapfile none swap defaults 0 0' | tee --append /etc/fstab
```

## Update our local time with our timezone

```bash
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc
```

## Configure our locale

We need to edit the file /etc/locale.gen and uncomment our locale

In my case I'm going to uncomment `en_US.UTF-8 UTF-8` and `es_CO.UTF-8 UTF-8`

And then generate the locale with `locale-gen`

The edit the actual locale configuration file (`/etc/locale.conf`) to add this line `LANG=en_US.UTF-8`

## Configure the hostname and hosts files (Networking)

We need to edit/create the file /etc/hostname and put a name on it, i.e, sandbox

Also We need to edit the file /etc/hosts to be able to resolve localhost and our hostname

```txt
127.0.0.1   localhost
::1         localhost
127.0.1.1   sandbox.localdomain sandbox
```

## Secure the Root account with a password

It's as easy as using the `passwd` command

## Install additional (Boot and network)

```bash
pacman -S grub efibootmgr networkmanager network-manager-applet wireless_tools wpa_supplicant dialog os-prober mtools dosfstools linux-headers
```

## Configure grub to use the encrypted partition

For this we need to edit the file `/etc/default/grub` and add this to the grub options

```txt
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:cr_root"
```

Edit `/etc/mkinitcpio.conf` and add to the **HOOKS** options so they look like:

```txt
HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck)
```

Regenerate the configuration with `mkinitcpio -p linux` command

## Install bootloader

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
```

Create the configuration file for grub

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

## Create admin user account

```bash
useradd -m -G wheel geektimus
passwd geektimus
```

We need to update the sudoers file to allow this new user to run sudo operations. For that we just need to run:

```bash
EDITOR=emacs visudo
```

And uncomment the line that says `%wheel ALL=(ALL) ALL`

## Update the console font on startup

Create the file `/etc/vconsole.conf` and add the following line to it

```bash
FONT=ter-v12n
```

Update the mkinitcpio configuration file (**/etc/mkinitcpio.conf**), update the **HOOKS**  and add the console font hook to the list. Please have in mind that we have the partition encrypted so the new hook should go before the encrypt hook.

```bash
HOOKS=(base udev autodetect modconf block consolefont encrypt filesystems keyboard fsck)
```

And regenerate the configuration running `mkinitcpio -p linux` command

## Update mirrors by speed

- Backup the current mirrorlist file `/etc/pacman.d/mirrorlist`

```bash
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
```

- Edit `mirrorlist.backup` and uncomment the servers to be tested
- Rank the mirrors

```bash
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
```

Note: In case the `rankmirror` command was not found you can install it using:

```bash
pacman -S pacman-contrib
```

Optional: Update mirrors using reflector

```bash
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

## Restart the System

At this point the base clean install of arch is ready and can be used to customize additional features

## Post Install Steps

### Activate Network

```bash
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager
```

### Install SSH (Optional)

```bash
sudo pacman -S openssh
```

Edit the configurations in `/etc/ssh/sshd_config`

### Install optional programs

- Git

```bash
sudo pacman -S git git-crypt git-lfs
```

## Install WM

Prerequisite: X environment installation

```bash
pacman -S mcpp xorg xorg-server xorg-xinit
```

### Install BSPWM

- Configure `xinit` for the first usage:

```bash
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

## Install YADM (new way to automate box initialization)

```bash
mkdir -p $HOME/.local/bin
curl -fLo $HOME/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x $HOME/.local/bin/yadm
chmod +x $HOME/.local/bin/yadm
export PATH=$PATH:$HOME/.local/bin
yadm clone https://github.com/geektimus/dotfiles
yadm bootstrap
```

### Import GPG keys for Spotify Installation

```bash
gpg --keyserver pool.sks-keyservers.net --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
gpg --keyserver pool.sks-keyservers.net --recv-keys 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45
```

## Install Display Manager

```bash
pacman -S lightdm accountsservice lightdm-gtk-greeter
```

Install the base package `bspwm`

```bash
pacman -S bspwm sxhkd
```

Create the configuration folders and copy the sample files

```bash
mkdir -p ~/.config/{bspwm,sxhkdrc}
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkdrc
```
