# Phantom OS v0.1.0 - Ghost Protocol

**Release Date:** TBD  
**Codename:** ghost-protocol

## Overview

Phantom OS v0.1.0 is the first public release of this Arch Linux-based distribution featuring a neon-dark aesthetic built on Hyprland. This release includes a complete desktop environment, performance optimizations, optional pentesting toolkit, and a graphical installer.

## Highlights

### 🎨 Ghost Protocol Theme
- Neon cyan (#00F0FF) accents on deep black (#0A0A0F)
- Three-capsule floating panel layout
- Floating glass dock with blur effects
- Desktop widget with clock and now playing info
- 5 preset themes: Ghost Protocol, Specter, Wraith, Eclipse, Daylight

### 🚀 Performance Optimized
- zram compressed swap (50% RAM, zstd)
- Optimized I/O schedulers (auto-detect NVMe/SSD/HDD)
- GPU auto-detection (NVIDIA/AMD/Intel)
- Power profiles (Performance/Balanced/Powersave)
- 3-5 second boot time target
- Kernel tuning for desktop responsiveness

### 🛠️ System Tools
- `phantom-theme` - Theme management CLI + GUI editor
- `phantom-power` - Power profile management
- `phantom-gpu-setup` - GPU auto-configuration
- `phantom-pentest` - Optional pentesting toolkit manager

### 🔒 Optional Pentesting Toolkit
- 50+ security tools available via `phantom-pentest install`
- Includes: nmap, wireshark, burpsuite, metasploit, john, hashcat, aircrack-ng, and more
- Not installed by default (keeps base system lightweight)

### 📦 Easy Installation
- Calamares graphical installer with Phantom branding
- Plymouth boot splash with particle animation
- Comprehensive installation guide
- Dual-boot support (Windows/Linux)

## What's Included

### Desktop Environment
- **Compositor:** Hyprland (Wayland)
- **Panel:** Waybar (three-capsule floating layout)
- **Dock:** nwg-dock-hyprland (floating glass)
- **Launcher:** Rofi (Wayland)
- **Notifications:** Mako
- **Terminal:** Kitty
- **Widgets:** eww (desktop clock + media)

### System
- **Login:** SDDM (branded theme)
- **Lock Screen:** hyprlock (with battery/media info)
- **Boot Splash:** Plymouth (particle animation)
- **Installer:** Calamares (graphical)
- **Audio:** PipeWire + WirePlumber
- **Network:** NetworkManager

### Performance
- zram swap (systemd-zram-generator)
- I/O scheduler optimization (udev rules)
- GPU auto-detection and configuration
- Power profile management
- Kernel tuning (sysctl)
- Boot optimization (systemd)

### Development
- Full CI/CD pipeline (GitHub Actions)
- Automated ISO builds
- Validation and testing
- Shell script linting
- JSON validation

## System Requirements

### Minimum
- 64-bit x86 CPU
- 4 GB RAM
- 20 GB disk space
- UEFI boot support

### Recommended
- Modern multi-core CPU
- 8+ GB RAM
- 40+ GB SSD
- Dedicated GPU (NVIDIA/AMD/Intel)

## Installation

### Download
- ISO: Available from GitHub Releases
- Size: ~1-1.5 GB
- Checksums: SHA256 and MD5 provided

### Create Bootable USB
**Windows:** Use Rufus (GPT, UEFI)  
**Linux:** `sudo dd if=phantom-os-*.iso of=/dev/sdX bs=4M`  
**Mac:** `sudo dd if=phantom-os-*.iso of=/dev/diskX bs=4m`

### Install
1. Boot from USB
2. Launch "Install Phantom OS" from desktop
3. Follow Calamares installer wizard
4. Reboot and enjoy!

See [Installation Guide](../build/phantom-overlay/airootfs/usr/share/doc/phantom/INSTALLATION.md) for detailed instructions.

## Building from Source

### GitHub Actions (Recommended for Windows)
1. Fork repository on GitHub
2. Go to Actions → Build Phantom OS ISO
3. Click "Run workflow"
4. Download ISO from artifacts (30-50 minutes)

See [Building on GitHub](BUILDING_ON_GITHUB.md)

### Local Build (Linux/WSL2)
```bash
./scripts/build-phantom-iso.sh
```

Requirements: Arch Linux, 16+ GB RAM, archiso package

See [Building Locally](BUILDING_V1.md)

## Post-Installation

### First Steps
```bash
# Update system
sudo pacman -Syu

# Set power profile
sudo phantom-power set balanced

# Change theme
phantom-theme apply specter

# Install pentesting tools (optional)
sudo phantom-pentest install
```

### Customization
- Theme editor: `phantom-theme edit`
- Hyprland config: `~/.config/hypr/hyprland.conf`
- Waybar config: `~/.config/waybar/config.jsonc`
- Keybindings: Edit Hyprland config

## Known Issues

### General
- Plymouth boot splash requires manual configuration on some systems
- Some NVIDIA GPUs may need additional driver setup
- Calamares may not detect all partition layouts

### Workarounds
- Boot issues: Add `nomodeset` to kernel parameters
- NVIDIA: Install proprietary drivers after installation
- Partitioning: Use manual partitioning if automatic fails

## Documentation

- [Installation Guide](../build/phantom-overlay/airootfs/usr/share/doc/phantom/INSTALLATION.md)
- [Performance Guide](../build/phantom-overlay/airootfs/usr/share/doc/phantom/PERFORMANCE.md)
- [Pentesting Toolkit](../build/phantom-overlay/airootfs/usr/share/doc/phantom/PENTESTING.md)
- [Building on GitHub](BUILDING_ON_GITHUB.md)
- [Building Locally](BUILDING_V1.md)
- [CI/CD Pipeline](CI_CD.md)
- [Design Specification](phantom-os-design-spec.md)

## Completed Phases

This release includes 7 of 12 planned phases:

✅ Phase 1: DE Baseline & Overlay  
✅ Phase 2: Three-Capsule Panel & Dock  
✅ Phase 3: Theme System & Settings  
✅ Phase 4: Lock & Login Screens  
✅ Phase 9: Installer & ISO Polish  
✅ Phase 10: Performance Tuning  
✅ Phase 11: Pentesting Toolkit  
✅ Phase 12: CI/CD Pipeline

## Future Roadmap

Planned for future releases:

- **Phase 5:** Phantom Files (custom file manager)
- **Phase 6:** Browser, Code & Media Apps (custom application suite)
- **Phase 7:** Phantom Office (LibreOffice fork)
- **Phase 8:** Package Manager (.phm format)

See [Master Plan](MASTER_PLAN.md) for details.

## Contributing

Phantom OS is open source and welcomes contributions!

- Report bugs and request features on GitHub Issues
- Submit pull requests for improvements
- Share your themes and customizations
- Help improve documentation
- Test and provide feedback

See [Contributing Guidelines](../.github/CONTRIBUTING.md)

## Credits

### Built With
- **Arch Linux** - Base distribution
- **Hyprland** - Wayland compositor
- **Waybar** - Status bar
- **Calamares** - System installer
- **Plymouth** - Boot splash
- And many other open source projects

### Special Thanks
- Arch Linux community
- Hyprland developers
- All open source contributors

## License

Phantom OS is distributed under the same licenses as its components. See individual package licenses for details.

## Support

- **GitHub Issues:** Bug reports and feature requests
- **GitHub Discussions:** Questions and community support
- **Documentation:** Comprehensive guides in `/usr/share/doc/phantom/`

## Changelog

### v0.1.0 (Initial Release)

**Added:**
- Complete Hyprland desktop environment
- Ghost Protocol theme with 4 alternatives
- Three-capsule floating panel layout
- Floating glass dock
- Desktop widget (clock + now playing)
- SDDM branded login screen
- hyprlock with battery/media info
- Plymouth boot splash (particle animation)
- Calamares graphical installer
- Theme management system (CLI + GUI)
- Power profile management
- GPU auto-detection
- Performance optimizations (zram, I/O schedulers)
- Optional pentesting toolkit (50+ tools)
- Full CI/CD pipeline
- Comprehensive documentation

**Known Issues:**
- Plymouth may need manual setup on some systems
- NVIDIA proprietary drivers not included by default
- Some partition layouts not auto-detected by Calamares

---

**Download:** [GitHub Releases](https://github.com/YOUR_USERNAME/phantom-os/releases)  
**Documentation:** [docs/](.)  
**Source Code:** [GitHub Repository](https://github.com/YOUR_USERNAME/phantom-os)

Thank you for trying Phantom OS! 👻
