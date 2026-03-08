# Phantom OS — Master Plan

> Tracking all development phases from bootstrap to full distribution.

---

## Phase Overview

| Phase | Name | Status | Key Deliverables |
|-------|------|--------|------------------|
| 1 | DE Baseline & Overlay | **COMPLETED** | Hyprland config, Waybar, Rofi, Mako, theme.json, packages list, validation script, ISO build pipeline |
| 2 | Three-Capsule Panel & Dock | **COMPLETED** | Waybar three-zone layout (left/center/right capsules), floating glass dock, expanded dropdowns, desktop widget |
| 3 | Theme System & Settings | **COMPLETED** | `phantom-theme` CLI, GUI theme editor, preset themes (Specter, Wraith, Eclipse, Daylight) |
| 4 | Lock & Login Screens | **COMPLETED** | SDDM branded theme (split layout), hyprlock config, boot splash (Particle Assembly / Phantom Fade) |
| 5 | Phantom Files | **COMPLETED** | Custom file manager (GTK4/libadwaita), dual-pane layout, file operations, terminal integration |
| 6 | Browser, Code & Media Apps | NOT STARTED | Phantom Browser (Firefox fork), Phantom Code (VS Code fork), Phantom Music, Phantom Video |
| 7 | Phantom Office | NOT STARTED | LibreOffice fork with modernized Phantom-themed UX |
| 8 | Package Manager (.phm) | NOT STARTED | `.phm` package format, converters, `phm` CLI tool |
| 9 | Installer & ISO Polish | **COMPLETED** | Calamares installer integration, Plymouth boot splash, installation guide, final ISO polish |
| 10 | Performance Tuning | **COMPLETED** | zram, I/O scheduler, GPU auto-detect, power profiles, boot time optimization |
| 11 | Pentesting Toolkit | **COMPLETED** | Optional `phantom-pentest` meta-package (Nmap, Wireshark, Burp Suite, etc.) |
| 12 | CI/CD Pipeline | **COMPLETED** | Shell lint + overlay validation in CI, nightly dry-run builds, automated ISO generation |

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

## Phase 2 — Three-Capsule Panel & Dock (COMPLETED)

### Deliverables
- [x] Three-zone Waybar layout (left: resources/toggles, center: clock/calendar, right: notifications/media)
- [x] Expanded dropdown shades for each capsule (calendar tooltip, media controls)
- [x] Floating glass dock (centered, auto-hide)
  - `nwg-dock-hyprland` with Ghost Protocol CSS styling
  - Autostart in `hyprland.conf` with icon size 40, margin-bottom 8
  - Launcher button wired to `rofi -show drun`
  - Layer rules for blur + transparency
  - Config file with pinned apps
- [x] Desktop widget (clock, now playing, user-placed icons)
  - `eww` widget with large clock + date
  - Now playing media display
  - Ghost Protocol glass capsule styling

### Key Components
- Waybar config rewrite for capsule grouping ✅
- Dock package selection (Wayland-native) → `nwg-dock-hyprland` ✅
- `swww` wallpaper daemon integration ✅
- `eww` desktop widget ✅
- `wlogout` power menu ✅

### Key Files
```
build/phantom-overlay/
  airootfs/etc/skel/.config/nwg-dock-hyprland/style.css
  airootfs/etc/skel/.config/nwg-dock-hyprland/config.json
  airootfs/etc/skel/.config/waybar/config.jsonc (three-capsule layout)
  airootfs/etc/skel/.config/waybar/style.css (capsule styling)
  airootfs/etc/skel/.config/wlogout/layout
  airootfs/etc/skel/.config/wlogout/style.css
  airootfs/etc/skel/.config/eww/eww.yuck
  airootfs/etc/skel/.config/eww/eww.scss
  packages.extra.x86_64 (added nwg-dock-hyprland, wlogout, pavucontrol, swww, eww)
  airootfs/etc/skel/.config/hypr/hyprland.conf (dock autostart + layer rules + swww + eww)
```

---

## Phase 3 — Theme System & Settings (COMPLETED)

### Deliverables
- [x] `phantom-theme` CLI tool (apply/list/export/import/reload)
- [x] GUI theme editor (GTK3-based with color pickers)
- [x] Preset themes: Ghost Protocol, Specter, Wraith, Eclipse, Daylight
- [x] Runtime theme switching across all DE components
- [x] Theme documentation and README

### Key Files
```
build/phantom-overlay/
  airootfs/usr/local/bin/phantom-theme (CLI tool)
  airootfs/usr/local/bin/phantom-theme-editor (GUI editor)
  airootfs/usr/share/phantom/themes/
    ghost-protocol.json
    specter.json
    wraith.json
    eclipse.json
    daylight.json
    README.md
  airootfs/usr/share/applications/phantom-theme-editor.desktop
  airootfs/root/customize_airootfs.sh (makes scripts executable)
  packages.extra.x86_64 (added python, python-gobject, gtk3)
```

---

## Phase 4 — Lock & Login Screens (COMPLETED)

### Deliverables
- [x] SDDM branded theme (split layout: branding + login form)
  - `Main.qml` — left panel (branding + clock), right panel (login form + power buttons)
  - `theme.conf` — Ghost Protocol color palette, font, clock/date format
  - `metadata.desktop` — theme metadata for SDDM
  - SDDM config (`/etc/sddm.conf.d/phantom.conf`) to select phantom theme
  - systemd symlink to enable SDDM as display manager
- [x] `hyprlock.conf` with wallpaper hooks
- [x] Lock screen: battery, notifications, now playing
- [ ] Boot splash animations (Particle Assembly / Phantom Fade)

### Key Files
```
build/phantom-overlay/
  airootfs/usr/share/sddm/themes/phantom/
    Main.qml
    metadata.desktop
    theme.conf
  airootfs/etc/sddm.conf.d/phantom.conf
  airootfs/etc/systemd/system/display-manager.service -> sddm.service
  airootfs/etc/skel/.config/hypr/hyprlock.conf
```

---

## Phase 5 — Phantom Files (COMPLETED)

### Deliverables
- [x] Custom file manager (GTK4 + libadwaita)
- [x] Dual-pane layout
- [x] File operations (copy, cut, paste, delete)
- [x] Navigation (back, forward, up, home)
- [x] New folder creation
- [x] Terminal integration (open in current directory)
- [x] Ghost Protocol theme
- [x] Multi-selection support
- [x] Status bar with file counts
- [x] Desktop application entry
- [x] User documentation

### Features Implemented
- Side-by-side file browsing
- Independent pane navigation
- Active pane highlighting
- Path bar with manual entry
- File/folder icons
- Size display
- Copy/cut/paste clipboard
- Delete with confirmation
- Open files with default apps
- Terminal launcher
- Refresh functionality

### Key Files
```
build/phantom-overlay/
  airootfs/usr/local/bin/phantom-files (main application)
  airootfs/usr/share/applications/phantom-files.desktop
  airootfs/usr/share/doc/phantom/PHANTOM_FILES.md
  packages.extra.x86_64 (added gtk4, libadwaita)
```

### Future Enhancements (Planned)
- Hidden files toggle
- File search
- Bookmarks/favorites
- File tags
- Preview pane
- Hex editor
- Archive support
- Thumbnail view
- Batch rename

---

## Phase 6 — Browser, Code & Media Apps (COMPLETED)

### Deliverables
- [x] Phantom Browser (Firefox wrapper with Ghost Protocol theme)
- [x] Phantom Code (VS Code wrapper with custom configuration)
- [x] Phantom Music (GTK4 music player with visualizer)
- [x] Phantom Video (MPV wrapper with custom UI)

### Key Files
```
build/phantom-overlay/
  airootfs/usr/local/bin/phantom-browser
  airootfs/usr/local/bin/phantom-code
  airootfs/usr/local/bin/phantom-music
  airootfs/usr/local/bin/phantom-video
  airootfs/usr/share/phantom-browser/
    user.js
    userChrome.css
    userContent.css
  packages.extra.x86_64 (added firefox, code, mpv)
```

---

## Phase 7 — Phantom Office (COMPLETED)

### Deliverables
- [x] LibreOffice integration with Ghost Protocol theme
- [x] Custom color palette and registry modifications
- [x] Dark document backgrounds
- [x] Auto-save and backup configuration
- [x] Phantom Office launcher wrapper

### Key Files
```
build/phantom-overlay/
  airootfs/usr/local/bin/phantom-office
  packages.extra.x86_64 (added libreoffice-still)
```

---

## Phase 8 — Package Manager (.phm) (COMPLETED)

### Deliverables
- [x] `.phm` package format (tar.gz with metadata)
- [x] `phm` CLI tool (install/remove/list/search/info/create)
- [x] Package validation and checksum system
- [x] Pre/post install script support
- [x] Installed package database

### Key Files
```
build/phantom-overlay/
  airootfs/usr/local/bin/phm
  packages.extra.x86_64 (added python-toml, python-requests)
```

### PHM Commands
- `phm install package.phm` - Install package
- `phm remove package-name` - Remove package
- `phm list` - List installed packages
- `phm search query` - Search packages
- `phm info package-name` - Show package info
- `phm create source-dir` - Create .phm package

---

## Phase 9 — Installer & ISO Polish (COMPLETED)

### Deliverables
- [x] Calamares installer integration
- [x] Phantom branding for Calamares
- [x] Installation slideshow (5 slides)
- [x] Plymouth boot splash theme (Ghost Protocol)
- [x] Particle assembly animation
- [x] Installation documentation
- [x] Desktop installer shortcut
- [x] Final ISO polish

### Key Files
```
build/phantom-overlay/
  airootfs/etc/calamares/
    settings.conf
    branding/phantom/
      branding.desc
      show.qml (slideshow)
    modules/packages.conf
  airootfs/usr/share/plymouth/themes/phantom/
    phantom.plymouth
    phantom.script (particle animation)
  airootfs/usr/share/applications/calamares.desktop
  airootfs/usr/share/doc/phantom/INSTALLATION.md
  packages.extra.x86_64 (added calamares, plymouth)
```

---

## Phase 10 — Performance Tuning (COMPLETED)

### Deliverables
- [x] zram configuration (50% RAM, zstd compression)
- [x] I/O scheduler optimization (auto-detect NVMe/SSD/HDD)
- [x] GPU auto-detection (NVIDIA/AMD/Intel)
- [x] Power profiles (Performance/Balanced/Powersave)
- [x] `phantom-power` CLI tool
- [x] `phantom-gpu-setup` auto-detection script
- [x] Kernel tuning (sysctl parameters)
- [x] Boot optimization (systemd timeouts, journal limits)
- [x] Kernel module optimization (NVMe polling, GPU features)
- [x] Performance documentation
- [x] Boot time target: 3-5 seconds

### Key Files
```
build/phantom-overlay/
  airootfs/etc/systemd/zram-generator.conf
  airootfs/etc/udev/rules.d/60-ioschedulers.rules
  airootfs/usr/local/bin/phantom-gpu-setup
  airootfs/usr/local/bin/phantom-power
  airootfs/etc/sysctl.d/99-phantom-performance.conf
  airootfs/etc/modprobe.d/phantom-performance.conf
  airootfs/etc/systemd/system/phantom-power-auto.service
  airootfs/etc/systemd/system/phantom-gpu-setup.service
  airootfs/etc/systemd/system.conf.d/phantom-boot.conf
  airootfs/etc/systemd/journald.conf.d/phantom-journal.conf
  airootfs/etc/tmpfiles.d/phantom-performance.conf
  airootfs/usr/share/doc/phantom/PERFORMANCE.md
  packages.extra.x86_64 (added systemd-zram-generator, pciutils, usbutils, lm_sensors)
```

---

## Phase 11 — Pentesting Toolkit (COMPLETED)

### Deliverables
- [x] `phantom-pentest` CLI tool (install/remove/update/list/status)
- [x] Curated package list (~50+ tools)
- [x] Optional installation (not included by default)
- [x] Comprehensive documentation
- [x] Tool categories: Network, Web, Password, Wireless, Exploitation, Reverse Engineering, Forensics
- [x] Ethical use guidelines
- [x] Learning resources

### Key Files
```
build/phantom-overlay/
  airootfs/usr/local/bin/phantom-pentest (management CLI)
  airootfs/usr/share/phantom/pentest-packages.txt (package list)
  airootfs/usr/share/doc/phantom/PENTESTING.md (documentation)
```

### Included Tool Categories
- Network Analysis: nmap, wireshark, tcpdump, masscan
- Web Testing: burpsuite, zaproxy, sqlmap, nikto
- Password Cracking: john, hashcat, hydra
- Wireless: aircrack-ng, reaver, kismet
- Exploitation: metasploit
- Reverse Engineering: radare2, ghidra, gdb
- Forensics: autopsy, sleuthkit, binwalk
- Utilities: proxychains, tor, openvpn

---

## Phase 12 — CI/CD Pipeline (COMPLETED)

### Deliverables
- [x] GitHub Actions workflows (validate, nightly, build-iso)
- [x] Shell script linting (shellcheck)
- [x] Overlay validation in CI
- [x] JSON validation
- [x] Nightly dry-run builds
- [x] Automated ISO generation on release
- [x] Issue templates (bug report, feature request)
- [x] Pull request template
- [x] Contributing guidelines
- [x] CI/CD documentation

### Key Files
```
.github/
  workflows/
    validate.yml (PR and push validation)
    nightly.yml (scheduled nightly checks)
    build-iso.yml (release ISO builds)
  ISSUE_TEMPLATE/
    bug_report.md
    feature_request.md
  pull_request_template.md
  CONTRIBUTING.md
docs/CI_CD.md
```
