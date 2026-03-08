# Phantom OS

Phantom OS is an Arch Linux–based distribution concept focused on a highly customizable, neon-dark UX built on Hyprland, with a long-term roadmap that includes a custom app suite, a `.phm` package format, and optional pentesting tooling.

## Quick Start (Windows Users)

**Building on Windows?** You don't need to build locally! Use GitHub Actions:

1. Push this repository to GitHub
2. Go to **Actions** → **Build Phantom OS ISO** → **Run workflow**
3. Wait 30-50 minutes
4. Download the ISO from artifacts

See [Building on GitHub](docs/BUILDING_ON_GITHUB.md) for detailed instructions.

## Design spec

- [`docs/phantom-os-design-spec.md`](docs/phantom-os-design-spec.md)

## Build Options

### Option 1: GitHub Actions (Recommended for Windows)

Perfect for Windows users or systems with limited resources (< 16 GB RAM).

- **No local setup required**
- **Free for public repos**
- **30-50 minute build time**

See: [`docs/BUILDING_ON_GITHUB.md`](docs/BUILDING_ON_GITHUB.md)

### Option 2: Local Build (Linux/WSL2)

For Linux users or Windows users with WSL2:

- Main guide: [`docs/BUILDING_V1.md`](docs/BUILDING_V1.md)
- One-command local build: `./scripts/build-phantom-iso.sh`
- Requirements: Arch Linux, 16+ GB RAM, archiso package

## Current implementation status

- ✅ Arch `archiso` bootstrap + overlay workflow
- ✅ Phantom DE baseline (Hyprland, Waybar, Rofi, Mako, theme system)
- ✅ Three-capsule floating panel layout
- ✅ Floating glass dock with pinned apps
- ✅ Desktop widget (clock + now playing)
- ✅ SDDM branded login screen
- ✅ hyprlock screen with battery/media info
- ✅ Theme system (5 presets + GUI editor)
- ✅ Phantom Files (custom file manager)
- ✅ Phantom Browser (Firefox with Ghost Protocol theme)
- ✅ Phantom Code (VS Code integration)
- ✅ Phantom Music (GTK4 music player)
- ✅ Phantom Video (MPV wrapper)
- ✅ Phantom Office (LibreOffice integration)
- ✅ PHM Package Manager (.phm format)
- ✅ Performance optimizations (zram, I/O schedulers, power profiles)
- ✅ Optional pentesting toolkit (50+ tools)
- ✅ CI/CD pipeline with automated builds

## Completed Phases (ALL 12 PHASES ✅)

- **Phase 1:** DE Baseline & Overlay
- **Phase 2:** Three-Capsule Panel & Dock
- **Phase 3:** Theme System & Settings
- **Phase 4:** Lock & Login Screens
- **Phase 5:** Phantom Files (File Manager)
- **Phase 6:** Browser, Code & Media Apps
- **Phase 7:** Phantom Office
- **Phase 8:** Package Manager (.phm)
- **Phase 9:** Installer & ISO Polish
- **Phase 10:** Performance Tuning
- **Phase 11:** Pentesting Toolkit
- **Phase 12:** CI/CD Pipeline

## Roadmap tracker

- [`docs/MASTER_PLAN.md`](docs/MASTER_PLAN.md)
- [`docs/NEXT_STEPS.md`](docs/NEXT_STEPS.md)

## Documentation

- [Building on GitHub Actions](docs/BUILDING_ON_GITHUB.md) - **Start here for Windows users**
- [Building Locally](docs/BUILDING_V1.md) - For Linux/WSL2 users
- [Design Specification](docs/phantom-os-design-spec.md)
- [Master Plan](docs/MASTER_PLAN.md)
- [Performance Guide](build/phantom-overlay/airootfs/usr/share/doc/phantom/PERFORMANCE.md)
- [Pentesting Toolkit](build/phantom-overlay/airootfs/usr/share/doc/phantom/PENTESTING.md)
- [CI/CD Pipeline](docs/CI_CD.md)

## Contributing

See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for development workflow and guidelines.

## System Requirements

### For Building (GitHub Actions)
- GitHub account (free)
- Git for Windows
- Internet connection

### For Building (Local)
- Arch Linux or WSL2
- 16+ GB RAM
- 20+ GB free disk space
- archiso package

### For Running
- 64-bit x86 CPU
- 4+ GB RAM (8 GB recommended)
- 20+ GB disk space
- UEFI boot support
- GPU: Intel/AMD/NVIDIA (auto-detected)
