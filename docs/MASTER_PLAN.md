# Phantom OS — Master Plan

> Tracking all development phases from bootstrap to full distribution.

---

## Phase Overview

| Phase | Name | Status | Key Deliverables |
|-------|------|--------|------------------|
| 1 | DE Baseline & Overlay | **IN PROGRESS** | Hyprland config, Waybar, Rofi, Mako, theme.json, packages list, validation script, ISO build pipeline |
| 2 | Three-Capsule Panel & Dock | **IN PROGRESS** | Waybar three-zone layout (left/center/right capsules), floating glass dock, expanded dropdowns |
| 3 | Theme System & Settings | NOT STARTED | `phantom-theme` CLI, GUI theme editor, preset themes (Specter, Wraith, Eclipse, Daylight) |
| 4 | Lock & Login Screens | **IN PROGRESS** | SDDM branded theme (split layout), hyprlock config, boot splash (Particle Assembly / Phantom Fade) |
| 5 | Phantom Files | NOT STARTED | Custom file manager (GTK4/Qt6), dual-pane, tags, preview, integrated terminal, hex view |
| 6 | Browser, Code & Media Apps | NOT STARTED | Phantom Browser (Firefox fork), Phantom Code (VS Code fork), Phantom Music, Phantom Video |
| 7 | Phantom Office | NOT STARTED | LibreOffice fork with modernized Phantom-themed UX |
| 8 | Package Manager (.phm) | NOT STARTED | `.phm` package format, converters, `phm` CLI tool |
| 9 | Installer & ISO Polish | NOT STARTED | Calamares installer integration, final ISO build polish, QA |
| 10 | Performance Tuning | NOT STARTED | zram, I/O scheduler, GPU auto-detect, power profiles, boot time optimization |
| 11 | Pentesting Toolkit | NOT STARTED | Optional `phantom-pentest` meta-package (Nmap, Wireshark, Burp Suite, etc.) |
| 12 | CI/CD Pipeline | NOT STARTED | Shell lint + overlay validation in CI, nightly dry-run builds, automated ISO generation |

---

## Phase 1 — DE Baseline & Overlay (IN PROGRESS)

### Deliverables
- [x] Bootstrap script (`scripts/bootstrap-phantom-v1.sh`)
- [x] Overlay apply script (`scripts/apply-phantom-overlay.sh`)
- [x] Validation script (`scripts/validate-phantom-overlay.sh`)
- [x] Build orchestrator (`scripts/build-phantom-iso.sh`)
- [x] Package list (`build/phantom-overlay/packages.extra.x86_64`)
- [x] Phantom release file (`build/phantom-overlay/airootfs/etc/phantom-release`)
- [x] Ghost Protocol theme tokens (`build/phantom-overlay/airootfs/etc/skel/.config/phantom/theme.json`)
- [x] Hyprland compositor config (`build/phantom-overlay/airootfs/etc/skel/.config/hypr/hyprland.conf`)
- [x] Waybar panel config + styling (`build/phantom-overlay/airootfs/etc/skel/.config/waybar/`)
- [x] Rofi launcher theme (`build/phantom-overlay/airootfs/etc/skel/.config/rofi/config.rasi`)
- [x] Mako notification config (`build/phantom-overlay/airootfs/etc/skel/.config/mako/config`)
- [ ] First successful ISO build

### Key Files
```
build/phantom-overlay/
  airootfs/etc/phantom-release
  airootfs/etc/skel/.config/phantom/theme.json
  airootfs/etc/skel/.config/hypr/hyprland.conf
  airootfs/etc/skel/.config/waybar/config.jsonc
  airootfs/etc/skel/.config/waybar/style.css
  airootfs/etc/skel/.config/rofi/config.rasi
  airootfs/etc/skel/.config/mako/config
  packages.extra.x86_64
```

---

## Phase 2 — Three-Capsule Panel & Dock (IN PROGRESS)

### Deliverables
- [ ] Three-zone Waybar layout (left: resources/toggles, center: clock/calendar, right: notifications/media)
- [ ] Expanded dropdown shades for each capsule
- [x] Floating glass dock (centered, auto-hide)
  - `nwg-dock-hyprland` with Ghost Protocol CSS styling
  - Autostart in `hyprland.conf` with icon size 40, margin-bottom 8
  - Launcher button wired to `rofi -show drun`
  - Layer rules for blur + transparency
- [ ] Desktop widget (clock, now playing, user-placed icons)

### Key Components
- Waybar config rewrite for capsule grouping
- ~~Dock package selection (Wayland-native)~~ → `nwg-dock-hyprland`
- `swww` wallpaper daemon integration

### Key Files
```
build/phantom-overlay/
  airootfs/etc/skel/.config/nwg-dock-hyprland/style.css
  packages.extra.x86_64  (added nwg-dock-hyprland)
  airootfs/etc/skel/.config/hypr/hyprland.conf  (dock autostart + layer rules)
```

---

## Phase 3 — Theme System & Settings

### Deliverables
- `phantom-theme` CLI tool (apply/list/export)
- GUI theme editor
- Preset themes: Specter, Wraith, Eclipse, Daylight
- Runtime theme switching across all DE components

### Key Files
- `~/.config/phantom/theme.json` (master definition)
- Theme presets directory

---

## Phase 4 — Lock & Login Screens (IN PROGRESS)

### Deliverables
- [x] SDDM branded theme (split layout: branding + login form)
  - `Main.qml` — left panel (branding + clock), right panel (login form + power buttons)
  - `theme.conf` — Ghost Protocol color palette, font, clock/date format
  - `metadata.desktop` — theme metadata for SDDM
  - SDDM config (`/etc/sddm.conf.d/phantom.conf`) to select phantom theme
  - systemd symlink to enable SDDM as display manager
- [ ] `hyprlock.conf` with wallpaper hooks
- [ ] Boot splash animations (Particle Assembly / Phantom Fade)
- [ ] Lock screen: battery, notifications, now playing

### Key Files
```
build/phantom-overlay/
  airootfs/usr/share/sddm/themes/phantom/
    Main.qml
    metadata.desktop
    theme.conf
  airootfs/etc/sddm.conf.d/phantom.conf
  airootfs/etc/systemd/system/display-manager.service -> sddm.service
```

---

## Phase 5 — Phantom Files

### Deliverables
- Custom file manager (GTK4 or Qt6)
- Features: tags, dual-pane, preview, terminal, hex view

---

## Phase 6 — Browser, Code & Media Apps

### Deliverables
- Phantom Browser (Firefox fork, privacy-first)
- Phantom Code (VS Code fork or custom)
- Phantom Music (dark glass player + visualizer)
- Phantom Video (MPV wrapper with custom UI)

---

## Phase 7 — Phantom Office

### Deliverables
- LibreOffice fork with modernized Phantom-themed UX

---

## Phase 8 — Package Manager (.phm)

### Deliverables
- `.phm` package format specification
- `phm` CLI (install/remove/update/search)
- Converters from existing formats

---

## Phase 9 — Installer & ISO Polish

### Deliverables
- Calamares installer with Phantom branding
- Final ISO generation and QA
- Installation guides

---

## Phase 10 — Performance Tuning

### Deliverables
- zram configuration
- I/O scheduler optimization (mq-deadline/bfq)
- GPU auto-detection (NVIDIA/AMD/Intel)
- Power profiles (Performance/Balanced/Battery Saver)
- Boot time target: 3-5 seconds

---

## Phase 11 — Pentesting Toolkit

### Deliverables
- `phantom-pentest` optional meta-package
- Nmap, Wireshark, Burp Suite, and related utilities
- Isolated install via `phm install phantom-pentest`

---

## Phase 12 — CI/CD Pipeline

### Deliverables
- Shell lint + overlay validation in CI
- Nightly dry-run builds (without full ISO)
- Automated ISO generation on release tags
