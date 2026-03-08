# Building Phantom OS v1

This guide is for building Phantom OS locally on Linux or WSL2.

**Windows users:** See [Building on GitHub Actions](BUILDING_ON_GITHUB.md) for an easier method that doesn't require local resources.

## Prerequisites

- Arch Linux (or WSL2 with Arch)
- 16+ GB RAM
- 20+ GB free disk space
- `archiso` package installed

## Quick start (Linux/WSL2)

```bash
./scripts/build-phantom-iso.sh
```

This runs the full pipeline:
1. Bootstrap `archiso` base profile
2. Apply Phantom overlay
3. Validate overlay files and package list
4. Build ISO via `mkarchiso`

## Manual step-by-step

### 1) Bootstrap Arch base profile

```bash
./scripts/bootstrap-phantom-v1.sh
```

### 2) Apply Phantom overlay

```bash
./scripts/apply-phantom-overlay.sh
```

### 3) Validate overlay

```bash
./scripts/validate-phantom-overlay.sh
```

### 4) Build the ISO

> Requires `archiso` tools installed on your build machine.

```bash
mkarchiso -v -w ./work -o ./out ./build/archiso-profile
```

## Windows Users

### Option 1: GitHub Actions (Recommended)

Build entirely on GitHub without local resources. See [BUILDING_ON_GITHUB.md](BUILDING_ON_GITHUB.md).

### Option 2: WSL2

1. Install WSL2: `wsl --install`
2. Install Arch Linux from Microsoft Store
3. Inside WSL:
   ```bash
   sudo pacman -S archiso git base-devel
   ./scripts/build-phantom-iso.sh
   ```

### Option 3: Docker

```bash
docker run -v ${PWD}:/workspace -w /workspace archlinux:latest bash -c "
  pacman -Syu --noconfirm
  pacman -S --noconfirm archiso git base-devel
  ./scripts/build-phantom-iso.sh
"
```

## Phantom DE components included

- **Hyprland session** with keybinds, workspace controls, launcher, lock, and screenshot actions
- **Three-zone floating capsule panel** using Waybar (left: resources, center: clock, right: media/notifications)
- **Floating glass dock** with pinned apps and launcher
- **Desktop widget** with clock and now playing info
- **Rofi launcher** matching Ghost Protocol colors
- **Mako notifications** with panel glass + accent glow
- **SDDM login screen** with split layout branding
- **hyprlock screen** with battery, media, and wallpaper blur
- **Theme system** with 5 presets and GUI editor
- **Performance optimizations** (zram, I/O schedulers, power profiles)
- **Optional pentesting toolkit** (50+ tools)

## Included repo structure

- `scripts/bootstrap-phantom-v1.sh`: fetch upstream Arch base profile
- `scripts/apply-phantom-overlay.sh`: apply Phantom DE overlay layer
- `scripts/validate-phantom-overlay.sh`: validate overlay integrity
- `scripts/build-phantom-iso.sh`: run end-to-end local build
- `build/phantom-overlay/`: files and package additions for v1 defaults

## Build Time

- **Bootstrap**: 2-5 minutes
- **ISO build**: 20-40 minutes
- **Total**: 25-50 minutes

## System Requirements

- **CPU**: 64-bit x86 processor
- **RAM**: 16+ GB (for building)
- **Disk**: 20+ GB free space
- **OS**: Arch Linux or compatible

## Notes

- This is a **v1 bootstrap**, not a finished distro.
- For Windows users with limited resources, use GitHub Actions instead.
- Next milestones: Boot splash, installer integration, custom apps.

## Troubleshooting

### Out of Memory

If you have less than 16 GB RAM, use GitHub Actions instead. See [BUILDING_ON_GITHUB.md](BUILDING_ON_GITHUB.md).

### Package Not Found

Update your system first:
```bash
sudo pacman -Syu
```

### Permission Denied

Make scripts executable:
```bash
chmod +x scripts/*.sh
```
