# Building Phantom OS v1 (Arch base bootstrap)

This repository includes a practical starting point for building Phantom OS v1 by pulling the official Arch `archiso` releng profile and layering Phantom DE defaults on top.

## Quick start (recommended)

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

## Phantom DE components included right now

- **Hyprland session baseline** with keybinds, workspace controls, launcher, lock, and screenshot actions
- **Three-zone top bar concept** using Waybar (left resources, center date/time, right controls)
- **Rofi launcher theme** matching Ghost Protocol colors
- **Mako notification style** matching the panel glass + accent glow
- **Theme token seed** in `~/.config/phantom/theme.json`

## Included repo structure

- `scripts/bootstrap-phantom-v1.sh`: fetch upstream Arch base profile
- `scripts/apply-phantom-overlay.sh`: apply Phantom DE overlay layer
- `scripts/validate-phantom-overlay.sh`: validate overlay integrity
- `scripts/build-phantom-iso.sh`: run end-to-end local build
- `build/phantom-overlay/`: files and package additions for v1 defaults

## Notes

- This is a **v1 bootstrap**, not a finished distro.
- Next milestones: SDDM branding theme, lock screen visuals, dock implementation, and `.phm` tooling.
