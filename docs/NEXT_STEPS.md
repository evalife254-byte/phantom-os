# Phantom OS — Next Execution Steps

This file tracks concrete execution after the v1 DE scaffold.

> For the full 12-phase roadmap, see [MASTER_PLAN.md](./MASTER_PLAN.md).

## Immediate (now)

- [x] Arch base bootstrap script
- [x] Phantom DE overlay script
- [x] Phantom DE baseline configs — **real overlay files created** in `build/phantom-overlay/`:
  - Hyprland (`hyprland.conf`) — monitor, keybinds, gaps, blur, opacity, animations, window/layer rules
  - Waybar (`config.jsonc` + `style.css`) — single bar Phase 1 layout with Ghost Protocol colors
  - Rofi (`config.rasi`) — centered launcher with accent theming and search input
  - Mako (`config`) — notification daemon with panel colors, border-radius, timeout
  - Theme tokens (`phantom/theme.json`) — Ghost Protocol color palette
  - Release metadata (`phantom-release`) — version 0.1.0, codename ghost-protocol
  - Package list (`packages.extra.x86_64`) — 24 packages including Hyprland stack, pipewire, fonts, SDDM
- [x] End-to-end build wrapper script (`scripts/build-phantom-iso.sh`)
- [x] Overlay validation script (`scripts/validate-phantom-overlay.sh`)

## Next 1–2 sprints

1. **SDDM branding theme** — **DONE**
   - Created `build/phantom-overlay/airootfs/usr/share/sddm/themes/phantom/` (Main.qml, metadata.desktop, theme.conf)
   - Split layout: left panel (branding + clock), right panel (login form + power buttons)
   - Ghost Protocol colors, SDDM config + systemd service enablement

2. **Dock implementation**
   - Add baseline dock package and config (Wayland-native)
   - Match floating glass style with toggles

3. **Lock-screen polish**
   - Add `hyprlock.conf` + wallpaper hooks
   - Integrate battery + now-playing indicators

4. **Theme CLI seed**
   - Add `phantom-theme` helper script (apply/list/export)
   - Wire to `~/.config/phantom/theme.json`

5. **CI checks**
   - Run shell lint + overlay validation in CI
   - Optional nightly dry-run for bootstrap (without full ISO build)
