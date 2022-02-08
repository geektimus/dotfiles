# Arch Based Linux Distros (Base Installation)

Updated Jan 28th

## Set keymap to Spanish

```sh
ls /usr/share/kbd/keymaps/**/**.map.gz
```

or

```sh
localectl list-keymaps | egrep -E "^(us|es)$" 
```

and

```sh
loadkeys es
```

## Check boot mode

If this folder exist we are in UEFI mode

```sh
ls /sys/firmware/efi/efivars
```

## Update system clock

```sh
timedatectl set-ntp true
```

## Partition Disk

We can use fdisk to create our layout.

To list the devices installed we can run `lsblk` there we can see the devices and choose one.

For this doc we would assume that the partition is **sda**

### Preferred Layout

| Mount Point | Type      | Partition | Suggested Size  |
| ----------- | --------- | --------- | --------------- |
| /efi        | /dev/sda1 | EFI       | 256 MiB         |
| /boot/efi   | /dev/sda2 | FAT       | 512 MiB         |
| /           | /dev/sda3 | EXT4      | Remaining space |

## Format the partitions

```bash
mkfs.vfat -n "EFI System" /dev/sda1 # EFI Partition
mkfs.ext4 -L BOOT /dev/sda2 # BOOT Partition
mkfs.ext4 -L ROOT /dev/sda3 # Root Partition*
```

Note: The -L switch assigns labels to the partitions, which helps referring to them later through `/dev/disk/by-label` without having to remember their numbers

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
cryptsetup open /dev/sda3 arch_encrypt
```

## Format Encrypted Partition as BTRFS

```sh
mkfs.btrfs -L ROOT /dev/mapper/arch_encrypt
```

## Mount the partitions

```bash
mount -t btrfs /dev/mapper/arch_encrypt /mnt
```

## Create Btrfs mount points and mount partitions

```sh
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@ /dev/mapper/arch_encrypt /mnt
mkdir -p /mnt/{boot/efi,home,snapshots}
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@home /dev/mapper/arch_encrypt /mnt/home
mount -o noatime,compress=zstd,ssd,discard=async,space_cache=v2,subvol=@snapshots /dev/mapper/arch_encrypt /mnt/snapshots
```

## Mount Boot and EFI Volume

```sh
mount /dev/sda2 /mnt/boot
mount /dev/sda1 /mnt/boot/efi
```

## Base package installation

```bash
pacstrap /mnt base base-devel efibootmgr grub linux linux-firmware emacs-nox neovim terminus-font
```

Note: On Artix the command is `basestrap` and we need to install the `openrc` package as an extra in the previous command.

## Generate fstab

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

Note: On Artix the command is `fstabgen`

## Switch to root in the newly installed partition

```bash
arch-chroot /mnt
```

Note: On Artix the command is `artools-chroot`

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
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:arch_encrypt"
```

Edit `/etc/mkinitcpio.conf` and add to the **HOOKS** options so they look like:

```txt
HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck)
```

And add to the **MODULES** option so they look like:

```txt
MODULES=(btrfs)
```

Regenerate the configuration with `mkinitcpio -p linux` command

Note: On Artix you need to install manually the packages `cryptsetup` and `cryptsetup-openrc`

## Install bootloader

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB /dev/sda2
```

Create the configuration file for grub

```bash
grub-mkconfig -o /boot/grub/grub.cfg
grub-mkconfig -o /boot/efi/EFI/GRUB/grub.cfg
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

## Extra Steps on Artix

### Network Configuration

Install the packages for DHCP resolution

```bash
pacman -S dhcpcd
```

Install the connection manager

```bash
pacman -S connman-openrc [connman-gtk]
```

Configure Network Interface

```bash
 ip -s link                <- Get the exact name of your interface
 nano /etc/conf.d/net        <- Add config_<interface>="dhcp"
```

Now the parent script `/etc/init.d/net.lo` should be symlinked to create additional scripts for each network interface and then loaded into an openrc runlevel.

```bash
 ln -s /etc/init.d/net.lo /etc/init.d/net.<interface>
 rc-update add net.<interface> default
```

## Restart the System

At this point the base clean install of arch is ready and can be used to customize additional features

Now, you can reboot and enter into your new installation:

```bash
 exit                           <- exit chroot environment
 umount -R /mnt
 reboot
```

## Post Install Steps

### Activate Network (Only applies to pure arch, not Artix openrc)

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

## Extra configuration for spotifyd

Configure the keyring with the spotify credentials

```bash
secret-tool store --label='Spotify Daemon' application rust-keyring service spotifyd username Geektimus
```

Configure the service

```bash
emacs ~/.config/systemd/user/spotifyd.service
emacs ~/.config/spotifyd/spotifyd.conf
systemctl --user start spotifyd.service
systemctl --user enable spotifyd.service
```

Check that the configuration works

```bash
spotifyd --no-daemon
```

## Useful commands

Generate the file of the vscode extensions

```bash
code --list-extensions | xargs -I {} echo "code --install-extension {}" > .config/Code/User/extensions.sh
```

## Icons

Mkos-Big-Sur
Vimix-cursors

## Themes

Material-Ocean
