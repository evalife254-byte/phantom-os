# Phantom OS — Complete Design Specification

> **Base:** Arch Linux  
> **Package Format:** `.phm`  
> **Compositor:** Hyprland (Wayland)  
> **Audience:** Everyone, including pentesters  
> **Philosophy:** User controls everything

---

## 1) Identity & Branding

- **Name:** Phantom OS
- **Logo direction:** Stylized P-Tiger with concentric water-wave ripples, cyan on black.
- **Boot splash options:**
  - Particle Assembly
  - Phantom Fade

---

## 2) Default Theme: "Ghost Protocol"

```text
Background:     #0A0A0F        Accent Primary:  #00F0FF
Surface:        #141420        Accent Secondary: #7B68EE
Panel/Glass:    #1A1A2E        Text Primary:     #E0E0E8
                               Text Secondary:   #6B6B80
```

### Theme controls
- Full user customization via:
  - `~/.config/phantom/theme.json`
  - GUI theme editor
- Presets:
  1. Phantom (default)
  2. Specter
  3. Wraith
  4. Eclipse
  5. Daylight
- CLI:
  - `phantom-theme apply <name>`

---

## 3) Desktop Layout

### Top panel: three floating capsules

| Capsule | Compact view | Expanded view |
|---|---|---|
| **Left** | ⏻ 👤 🔋 📶 CPU RAM 💾 | Android-style shade with resources, toggles, power menu, user profile |
| **Center** | Time & Date | Calendar with events + timezone/date settings |
| **Right** | 🔔 🎵 🌙 📸 ⚙️ | Notifications, media controls, and quick toggles |

### Desktop widget
- Large clock + date
- Now playing media
- User-placed icons

### Bottom dock
- Floating glass capsule dock
- Layout modes:
  - centered
  - left-aligned
  - bottom behavior presets
  - auto-hide
  - disabled

---

## 4) Compositor & Effects (Hyprland)

| Setting | Default/Options |
|---|---|
| Window open/close | Glitch/flicker + Phantom dissolve (toggleable) |
| Workspace switch | Fade-through + Cube (toggleable) |
| Blur level | Medium frosted glass |
| Effects policy | Fully user-customizable |

---

## 5) App Launcher

- Full-screen grid overlay
- Triggered by `Super`
- Search bar at top
- Categorized icons
- Smooth fade-in animation

---

## 6) Lock & Login

### Login (SDDM)
- Split layout:
  - Left: branding + clock
  - Right: login form

### Lock screen
- Ambient style
- Large clock
- Swipe to unlock
- Wallpaper can differ from desktop wallpaper

### Lock screen feature set
- Dynamic wallpaper (user prefs)
- Battery state
- Notifications
- Now playing

---

## 7) Notification System

All styles available; user selects preferred mode:
1. Toast popups
2. Capsule glow
3. Edge flash

Notification history lives in the right-capsule dropdown.

---

## 8) Custom App Suite Strategy

> Apps are expected to be **forks/wrappers of existing tools** with deep UI customization, then progressively enhanced.

| App | Based on | Goal |
|---|---|---|
| **Phantom Browser** | Firefox fork | Faster, cleaner, privacy-first, Phantom theme |
| **Phantom Code** | VS Code fork or custom | Phantom-themed code editor with built-in terminal |
| **Phantom Files** | Custom (GTK4/Qt6) | Tags, dual-pane, preview, integrated terminal, hex view |
| **Phantom Music** | Custom/fork | Dark glass music player + library + visualizer |
| **Phantom Video** | MPV wrapper/fork | Custom UI shell on MPV engine |
| **Phantom Photos** | Custom/fork | Gallery + viewer + quick edit tools |
| **Phantom Office** | LibreOffice fork | Modernized Phantom-themed office suite UX |
| **Phantom Settings** | Custom | Full system settings hub |
| **Phantom Terminal** | Kitty/Alacritty themed | GPU-accelerated Phantom terminal |

---

## 9) Performance & System Tuning

| Area | Target |
|---|---|
| Filesystem | ext4 |
| Swap | zram |
| Boot | Minimal services, ~3–5s target |
| I/O scheduler | `mq-deadline` / `bfq` |
| GPU | Auto-detect NVIDIA/AMD/Intel |
| Power profiles | Performance / Balanced / Battery Saver |
| Kernel | Desktop-responsiveness-oriented flags |

---

## 10) Pentesting Tooling

- Optional pack install:

```bash
phm install phantom-pentest
```

- Intended contents include: Nmap, Wireshark, Burp Suite, and related utilities.

---

## 11) Build Roadmap

| Phase | Work | Estimated timeline |
|---|---|---|
| 1 | WSL2 dev environment + archiso base | Week 1–2 |
| 2 | Hyprland DE config, three-capsule panel, dock | Week 3–6 |
| 3 | Phantom Settings + Theme System | Week 7–8 |
| 4 | Lock/Login screens, boot splash | Week 9–10 |
| 5 | Phantom Files (custom file manager) | Week 11–13 |
| 6 | Browser, Code, Media apps (forks) | Week 14–18 |
| 7 | Phantom Office (LibreOffice fork) | Week 19–22 |
| 8 | `.phm` package manager + converters | Week 23–26 |
| 9 | Installer (Calamares), ISO build, polish | Week 27–30 |

---

## 12) Asset Notes

Visual references (wallpapers/logo concepts) were provided in chat context and should be curated into versioned repo assets in a later pass, e.g.:

- `assets/branding/logo/`
- `assets/wallpapers/ghost-protocol/`
- `assets/splash/`

