# Arch Linux Installation 2.0
With LVM and Encryption...

## Load the Keymap
```
loadkeys us
```

## Change Font Size
```
setfont ter-122n
```

## Create the partitions

### Check the partitions
```
lsblk
```

In this case we are going to partition the `/dev/sda`

### Create the Partition Table

```
fdisk /dev/sda

Command sequence

Command (m for help): g
Created a new GPT disklabel (GUID: 44831037-9FE3-8F44-B4CC-9650AE08BE20).

Command (m for help): n
Partition number (1-128, default 1): 
First sector (2048-67108830, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-67108830, default 67108830): +128M

Created a new partition 1 of type 'Linux filesystem' and of size 128 MiB.

Command (m for help): n
Partition number (2-128, default 2): 
First sector (264192-67108830, default 264192): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (264192-67108830, default 67108830): +256M

Created a new partition 2 of type 'Linux filesystem' and of size 256 MiB.

Command (m for help): n
Partition number (3-128, default 3): 
First sector (788480-67108830, default 788480): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (788480-67108830, default 67108830): 

Created a new partition 3 of type 'Linux filesystem' and of size 31.6 GiB.

Command (m for help): t
Partition number (1-3, default 3): 1
Partition type or alias (type L to list all): 1

Changed type of partition 'Linux filesystem' to 'EFI System'.

Command (m for help): t
Partition number (1-3, default 3): 3
Partition type or alias (type L to list all): 30

Changed type of partition 'Linux filesystem' to 'Linux LVM'.

Command (m for help): x

Expert command (m for help): n
Partition number (1-3, default 3): 1

New name: EFI

Partition name changed from '' to 'EFI'.

Expert command (m for help): n
Partition number (1-3, default 3): 2

New name: BOOT

Partition name changed from '' to 'BOOT'.

Expert command (m for help): n
Partition number (1-3, default 3): 3

New name: SYSTEM

Partition name changed from '' to 'SYSTEM'.

Expert command (m for help): r

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```

## Encrypt our LVM volume
```
cryptsetup luksFormat -v -s 512 -h sha512 /dev/sda3
```

## Open the Encrypted LVM volume
```
cryptsetup open /dev/sda3 the_volumes
```


  18  cryptsetup luksFormat -v -s 512 -h sha512 /dev/sda3
   19  cryptsetup open /dev/sda3 the_volumes
   21  pvcreate /dev/mapper/the_volumes
   22  vgcreate arch /dev/mapper/the_volumes
   24  lvcreate -n root -L 31.6G arch
   25  mkfs.fat -F32 -n EFI /dev/sda1
   26  mkfs.ext4 -L BOOT /dev/sda2
   27  mkfs.ext4 -L ROOT /dev/arch/root
   28  mount /dev/arch/root /mnt
   29  mkdir /mnt/boot
   30  mount /dev/sda2 /mnt/boot
   31  mkdir /mnt/boot/efi
   32  mount /dev/sda1 /mnt/boot/efi
   33  lsblk
   34  pacstrap -i /mnt base base-devel linux linux-headers linux-firmware grub efibootmgr networkmanager network-manager-applet zsh bash-completion
   35  pacstrap -i /mnt base base-devel linux linux-headers linux-firmware grub efibootmgr networkmanager network-manager-applet zsh bash-completion vim dialog


## Appendix

### Installing Arch Linux using ssh
At the beginning of the installation when we get to the root prompt we should:

1) Get the ip address with `ip addr`
2) Set a root password with `passwd root`
3) Start ssh

```
systemctl list-unit-files -t service | grep ssh
systemctl start sshd
```
4) Connect to the box with `ssh root@ip`