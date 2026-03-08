# Phantom OS Installation Guide

This guide covers installing Phantom OS from the live ISO.

## Pre-Installation

### System Requirements

**Minimum:**
- 64-bit x86 CPU
- 4 GB RAM
- 20 GB disk space
- UEFI boot support

**Recommended:**
- Modern multi-core CPU
- 8+ GB RAM
- 40+ GB SSD
- Dedicated GPU (NVIDIA/AMD/Intel)

### Download ISO

1. Download from GitHub Releases
2. Verify checksum:
   ```bash
   sha256sum -c SHA256SUMS
   ```

### Create Bootable USB

**On Linux:**
```bash
sudo dd if=phantom-os-*.iso of=/dev/sdX bs=4M status=progress
sync
```

**On Windows:**
- Use [Rufus](https://rufus.ie/)
- Select ISO
- Partition scheme: GPT
- Target system: UEFI
- Click Start

**On Mac:**
```bash
sudo dd if=phantom-os-*.iso of=/dev/diskX bs=4m
```

## Installation Methods

### Method 1: Calamares Installer (Recommended)

The graphical installer provides an easy installation experience.

1. **Boot from USB**
   - Enter BIOS/UEFI (usually F2, F12, Del)
   - Disable Secure Boot
   - Set boot order to USB first
   - Save and reboot

2. **Launch Installer**
   - Boot into live environment
   - Click "Install Phantom OS" on desktop
   - Or run: `sudo calamares`

3. **Welcome Screen**
   - Select language
   - Click Next

4. **Location**
   - Select timezone
   - Click Next

5. **Keyboard**
   - Select keyboard layout
   - Test in text box
   - Click Next

6. **Partitions**
   
   **Option A: Erase Disk (Easiest)**
   - Select "Erase disk"
   - Choose disk
   - Select filesystem (ext4 recommended)
   - Click Next
   
   **Option B: Manual Partitioning**
   - Create partitions:
     - EFI: 512 MB, FAT32, mount at /boot/efi
     - Root: 20+ GB, ext4, mount at /
     - Swap: 2-8 GB (optional with zram)
     - Home: Remaining space, ext4, mount at /home (optional)
   - Click Next

7. **Users**
   - Enter your name
   - Enter username (lowercase, no spaces)
   - Enter password (strong recommended)
   - Choose hostname
   - Select "Log in automatically" (optional)
   - Click Next

8. **Summary**
   - Review settings
   - Click Install

9. **Installation**
   - Wait 10-20 minutes
   - Watch slideshow for Phantom OS features

10. **Complete**
    - Click Restart Now
    - Remove USB when prompted
    - Boot into Phantom OS

### Method 2: Manual Installation (Advanced)

For experienced users who want full control.

#### 1. Boot Live Environment

Boot from USB and open terminal.

#### 2. Partition Disk

```bash
# List disks
lsblk

# Partition with fdisk or gdisk
sudo fdisk /dev/sdX

# Create partitions:
# - EFI: 512 MB, type EF00
# - Root: 20+ GB, type 8300
# - Swap: 2-8 GB, type 8200 (optional)
# - Home: Remaining, type 8300 (optional)
```

#### 3. Format Partitions

```bash
# EFI partition
sudo mkfs.fat -F32 /dev/sdX1

# Root partition
sudo mkfs.ext4 /dev/sdX2

# Swap (optional)
sudo mkswap /dev/sdX3
sudo swapon /dev/sdX3

# Home (optional)
sudo mkfs.ext4 /dev/sdX4
```

#### 4. Mount Partitions

```bash
# Mount root
sudo mount /dev/sdX2 /mnt

# Create mount points
sudo mkdir -p /mnt/boot/efi
sudo mkdir -p /mnt/home

# Mount EFI
sudo mount /dev/sdX1 /mnt/boot/efi

# Mount home (optional)
sudo mount /dev/sdX4 /mnt/home
```

#### 5. Install Base System

```bash
# Install base packages
sudo pacstrap /mnt base linux linux-firmware

# Generate fstab
sudo genfstab -U /mnt >> /mnt/etc/fstab
```

#### 6. Chroot

```bash
sudo arch-chroot /mnt
```

#### 7. Configure System

```bash
# Set timezone
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

# Set locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Set hostname
echo "phantom" > /etc/hostname

# Set hosts
cat >> /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   phantom.localdomain phantom
EOF

# Set root password
passwd
```

#### 8. Install Bootloader

```bash
# Install GRUB
pacman -S grub efibootmgr

# Install GRUB to EFI
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=PHANTOM

# Generate config
grub-mkconfig -o /boot/grub/grub.cfg
```

#### 9. Install Phantom DE

```bash
# Install all Phantom packages
pacman -S hyprland hyprlock waybar rofi-wayland mako kitty \
  networkmanager xdg-desktop-portal-hyprland xdg-utils \
  polkit-gnome pipewire pipewire-pulse wireplumber \
  noto-fonts noto-fonts-cjk noto-fonts-emoji \
  grim slurp wl-clipboard brightnessctl playerctl \
  sddm qt5-quickcontrols2 qt5-graphicaleffects \
  nwg-dock-hyprland wlogout pavucontrol swww eww \
  python python-gobject gtk3 systemd-zram-generator \
  pciutils usbutils lm_sensors

# Enable services
systemctl enable sddm
systemctl enable NetworkManager
```

#### 10. Create User

```bash
# Add user
useradd -m -G wheel,audio,video,storage -s /bin/bash username

# Set password
passwd username

# Enable sudo
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
```

#### 11. Copy Phantom Configs

```bash
# Copy skeleton configs to user home
cp -r /etc/skel/.config /home/username/
chown -R username:username /home/username/.config
```

#### 12. Exit and Reboot

```bash
exit
sudo umount -R /mnt
sudo reboot
```

## Post-Installation

### First Boot

1. **Login**
   - SDDM login screen appears
   - Enter username and password
   - Hyprland desktop loads

2. **Initial Setup**
   - Desktop widget shows clock
   - Three-capsule panel at top
   - Floating dock at bottom

3. **Connect to Network**
   - Click network icon in panel
   - Select WiFi network
   - Enter password

### Essential Commands

```bash
# Update system
sudo pacman -Syu

# Set power profile
sudo phantom-power set balanced

# Change theme
phantom-theme list
phantom-theme apply specter

# Install pentesting tools (optional)
sudo phantom-pentest install

# Check GPU setup
cat /var/log/phantom-gpu-setup.log
```

### Configure System

#### Set Power Profile

```bash
# Performance (AC power, gaming)
sudo phantom-power set performance

# Balanced (default)
sudo phantom-power set balanced

# Powersave (battery life)
sudo phantom-power set powersave

# Auto (based on power source)
sudo phantom-power auto
```

#### Change Theme

```bash
# List themes
phantom-theme list

# Apply theme
phantom-theme apply wraith

# Edit theme (GUI)
phantom-theme edit
```

#### Install Additional Software

```bash
# Web browser
sudo pacman -S firefox chromium

# Office suite
sudo pacman -S libreoffice-fresh

# Media players
sudo pacman -S vlc mpv

# Development tools
sudo pacman -S git vim code

# Graphics
sudo pacman -S gimp inkscape blender
```

## Troubleshooting

### Boot Issues

**Black screen after GRUB:**
- Add `nomodeset` to kernel parameters
- Edit GRUB: press 'e' at boot menu
- Add to linux line: `nomodeset`
- Press Ctrl+X to boot

**Stuck at boot:**
- Check systemd logs: `journalctl -xb`
- Disable problematic services

### Display Issues

**No display after login:**
```bash
# Check Hyprland logs
cat ~/.hyprland.log

# Restart display manager
sudo systemctl restart sddm
```

**Wrong resolution:**
```bash
# Edit Hyprland config
nano ~/.config/hypr/hyprland.conf

# Set monitor resolution
monitor=,1920x1080@60,auto,1
```

### Network Issues

**WiFi not working:**
```bash
# Enable NetworkManager
sudo systemctl enable --now NetworkManager

# Check status
nmcli device status

# Connect to WiFi
nmcli device wifi connect SSID password PASSWORD
```

### Audio Issues

**No sound:**
```bash
# Check PipeWire status
systemctl --user status pipewire pipewire-pulse

# Restart audio
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check volume
pavucontrol
```

### Performance Issues

**Slow boot:**
```bash
# Analyze boot time
systemd-analyze
systemd-analyze blame

# Disable slow services
sudo systemctl disable service-name
```

**High CPU usage:**
```bash
# Check processes
htop

# Set powersave mode
sudo phantom-power set powersave
```

## Dual Boot

### With Windows

1. **Install Windows first** (if not already installed)

2. **Shrink Windows partition**
   - Windows: Disk Management → Shrink Volume
   - Leave 40+ GB for Phantom OS

3. **Install Phantom OS**
   - Use Calamares installer
   - Select "Install alongside"
   - Or manually partition free space

4. **GRUB will detect Windows**
   - If not, run: `sudo grub-mkconfig -o /boot/grub/grub.cfg`
   - Install os-prober: `sudo pacman -S os-prober`

### With Other Linux

1. **Install other Linux first**

2. **Install Phantom OS**
   - Use manual partitioning
   - Don't format existing partitions
   - Install GRUB to same EFI partition

3. **Update GRUB**
   ```bash
   sudo grub-mkconfig -o /boot/grub/grub.cfg
   ```

## Backup and Recovery

### Create Backup

```bash
# Backup home directory
tar -czf phantom-backup.tar.gz /home/username

# Backup configs
tar -czf phantom-configs.tar.gz ~/.config
```

### System Snapshot

```bash
# Install timeshift
sudo pacman -S timeshift

# Create snapshot
sudo timeshift --create --comments "Before update"

# Restore snapshot
sudo timeshift --restore
```

## Getting Help

- **Documentation**: `/usr/share/doc/phantom/`
- **GitHub Issues**: Report bugs and request features
- **Arch Wiki**: Comprehensive Linux documentation
- **Forums**: Ask questions in community forums

## Next Steps

- Explore theme presets: `phantom-theme list`
- Customize keybindings: `~/.config/hypr/hyprland.conf`
- Install pentesting tools: `sudo phantom-pentest install`
- Read performance guide: `/usr/share/doc/phantom/PERFORMANCE.md`
- Join the community and contribute!
