# Phantom OS

Phantom OS is an Arch Linux–based distribution concept focused on a highly customizable, neon-dark UX built on Hyprland, with a long-term roadmap that includes a custom app suite, a `.phm` package format, and optional pentesting tooling.

## Design spec

- [`docs/phantom-os-design-spec.md`](docs/phantom-os-design-spec.md)

## Build start (v1)

- Main guide: [`docs/BUILDING_V1.md`](docs/BUILDING_V1.md)
- One-command local build: `./scripts/build-phantom-iso.sh`

## Current implementation status

- Arch `archiso` bootstrap + overlay workflow is in place.
- Phantom DE baseline is scaffolded (Hyprland config, Waybar three-zone panel concept, Rofi theme, Mako notifications, theme tokens).
- Overlay validation and end-to-end build wrapper scripts are included.

## Roadmap tracker

- [`docs/NEXT_STEPS.md`](docs/NEXT_STEPS.md)
