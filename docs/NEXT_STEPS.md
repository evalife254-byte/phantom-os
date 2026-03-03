# Phantom OS — Next Execution Steps

This file tracks concrete execution after the v1 DE scaffold.

## Immediate (now)

- [x] Arch base bootstrap script
- [x] Phantom DE overlay script
- [x] Phantom DE baseline configs (Hyprland, Waybar, Rofi, Mako)
- [x] End-to-end build wrapper script (`scripts/build-phantom-iso.sh`)
- [x] Overlay validation script (`scripts/validate-phantom-overlay.sh`)

## Next 1–2 sprints

1. **SDDM branding theme**
   - Create `build/phantom-overlay/airootfs/usr/share/sddm/themes/phantom/`
   - Ship split layout + Ghost Protocol colors

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
