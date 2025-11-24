# Installing Arch Linux

The following steps document the process that I used to install Arch Linux with full disc encryption on my PC.

Thank you Wai Hon for [this amazing guide](https://whhone.com/posts/arch-linux-full-disk-encryption/) that I used for the initial install.

# Scripted Steps

I've scripted a large portion of the install process. The steps in this section can be used to speed up the process.

## Prerequisites

It is assumed that: 
- The device uses a UEFI BIOS
- You have already downloaded the Arch Linux ISO. If not, see [https://archlinux.org/download/](https://archlinux.org/download/)
- You've booted into the live environment
- You've connected to the internet
- You've installed git in the live environment
- You've cloned this repository in the live environment

## Install

#### 1. Install the system 

Run the following script and follow the prompts. 

``` bash
./install/main.sh
```

Reboot the computer.

``` bash
reboot
```

#### 2. Install packages and configure the GUI 

Log in as the regular (non root) user.

Install all packages. 

``` bash
~/Dev/arch-dotfiles/install/run-install-scripts.sh
```

Configure the GUI. 

``` bash
~/Dev/arch-dotfiles/install/configure-gui.sh
```

Reboot the computer.

``` bash
reboot
```

The computer should boot into the SDDM login window.

# Manual Steps

The following steps can be used to install Arch Manually.

## Prerequisites

It is assumed that: 
- The device uses a UEFI BIOS
- You have already downloaded the Arch Linux ISO. If not, see [https://archlinux.org/download/](https://archlinux.org/download/)
- You've booted into the live environment

## Install

#### 1. Connect to the internet

[Reference](https://wiki.archlinux.org/title/Installation_guide#Connect_to_the_internet)

Ensure the network interface is listed and enabled:

``` bash
ip link
```

If using WLAN, ensure the NIC is not blocked with [rfkill](https://wiki.archlinux.org/title/Network_configuration/Wireless#Rfkill_caveat)

Connect to the network:
- Ethernet - plug in the cable
- Wi-Fi - authenticate to the wireless network using [iwctl](https://wiki.archlinux.org/title/Iwd#iwctl)

Test the connection:

``` bash
ping ping.archlinux.org
```

#### 2. Update the system clock

[Reference](https://wiki.archlinux.org/title/Installation_guide#Update_the_system_clock)

Enable automatic time synchronization for `timedatectl` with:

``` bash
timedatectl set-ntp true
```

#### 3. Partition the disks

[Reference](https://wiki.archlinux.org/title/Installation_guide#Partition_the_disks)

The disk layout I use is:

| Partition            | Size         | Id  | Type             |
| -------------------- | ------------ | --- | ---------------- |
| Boot (/dev/nvme0np1) | 1 G          | ef  | EFI              |
| Root (/dev/nvme0np2) | Rest of disk | 83  | Linux Filesystem |

Start fdisk

``` bash
fdisk /dev/the_disk_to_be_partitioned
```

Delete any existing partitions

 Use `d` and enter the partition number to delete any existing partitions.

Create the boot partition

- Use `n` to create a new partition.

- Select `p` for primary.

- Select a partition number.

- Press enter for the first sector.

- Type `+1G` to make a 1 gigabyte partition.

- Use `t` to change the partition type.

- Enter `ef` to set the type to EFI.

Create the root partition

- Use `n` to create a new partition.

- Select `p` for primary.

- Select a partition number.

- Press enter for the first sector.

- Use the rest of the available storage.

- Use `t` to change the partition type.

- Enter `83` to set the type to Linux Filesystem.

#### 4. Prepare the encrypted root partition

[Reference](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LUKS_on_a_partition)

Run the following to create and mount the encrypted root patition. You will need to choose the passphrase for the encryption.

``` bash
cryptsetup luksFormat /dev/nvme0n1
cryptsetup open /dev/nvme0n1 cryptroot
mkfs.ext4 /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
```

#### 5. Prepare the boot partition

[Reference](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Preparing_the_boot_partition)

Run the following to create and mount the non-encrypted boot partition.

``` bash
mkfs.fat -F32 /dev/nvme0n1
mkdir /mnt/boot
mount /dev/nvme0n1 /mnt/boot
```

#### 6. Generate an fstab file

[Reference](https://wiki.archlinux.org/index.php/installation_guide#Fstab)

Run the following:

``` bash
genfstab -U /mnt >> /mnt/etc/fstab
```

#### 7. Install essential packages

[Reference](https://wiki.archlinux.org/title/Installation_guide#Install_essential_packages)

Everything after linux-firmware is 'optional'. Replace `amd-ucode` with `intel-ucode` if you have an Intel CPU.


``` bash
pacstrap /mnt amd-ucode base dhcpd linux linux-firmware \
    git neovim 
```

#### 8. Change root

[Reference](https://wiki.archlinux.org/title/Installation_guide#Chroot)

This allows you to directly interact with the new system's environment, tools, and configuration as if you were booted into it.

``` bash
arch-chroot /mnt
```

#### 9. Set time zone

[Reference](https://wiki.archlinux.org/title/Installation_guide#Time_zone)

Run `timedatectl list-timezones | grep 'city'` to find your timezone.

Run the followig to set the desired timezone:

``` bash
ln -sf /usr/share/zoneinfo/America/Detroit /etc/localtime
hwclock --systohc
```

#### 10. Set the locale

[Reference](https://wiki.archlinux.org/title/Installation_guide#Localization)

Edit ```/etc/locale.gen``` and uncomment ```en_US.UTF-8 UTF-8``` and other needed locales. Generate the locales by running:

``` bash
locale-gen
localectl set-locale LANG=en_US.UTF-8
```

#### 11. Network configuration

[Reference](https://wiki.archlinux.org/title/Installation_guide#Fstab)

Add the following to `/etc/hosts`:

``` /etc/hosts
127.0.0.1  localhost
::1        localhost
```

To set a hostname, write the desired system name to `/etc/hostname`.

#### 12. Configure mkinitcpio

[Reference](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#Configuring_mkinitcpio)


Edit /etc/mkinitcpio.conf, - add the encrypt hooks - move the keyboard hooks before encrypt ( so that you can type the passphrase )

For example, after this step, `HOOKS` should look like:

``` /etc/mkinitcpio.conf
HOOKS=(base udev autodetect modconf block keyboard encrypt filesystems fsck)
```

#### 13. Generate the initramfs

[Reference](https://wiki.archlinux.org/title/Installation_guide#Initramfs)

Since we've changed `/etc/mkinitcpio.conf`, manually, we have to re-generates the boot images (e.g., /boot/initramfs-linux.img). To do so, run the following:

``` bash
mkinitcpio -P
```

#### 14. Set the root password

[Reference](https://wiki.archlinux.org/title/Installation_guide#Root_password)

``` bash
passwd
```

#### 15. Configure the Boot Loader with `systemd-boot`

[Reference](https://wiki.archlinux.org/title/Installation_guide#Boot_loader)

Install the EFI boot manager

``` bash
bootctl install
```

Create `/boot/loader/entries/arch.conf`

- Replace `amd-ucode.img` with `intel-ucode.img` if you have an Intel CPU.
- Replace the `UUID` (not `PARTUUID`) to the one mapping to `/dev/nvme0n1` (Run blkid to find out)

``` /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options cryptdevice=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX:cryptroot root=/dev/mapper/cryptroot rw
```

Replace `/boot/loader/loader.conf` to:

``` /boot/loader/loader.conf
default      arch.conf
timeout      5
console-mode max
editor       no
```

Review the configuration with `bootctl list`

#### 16. Reboot

Exit the chroot environment by typing `exit` or `Ctrl+D`. Then run `reboot` .

Once the reboot has happened, you will probably have to enable dhcp with `sudo systemctl enable --now dhcp`.

