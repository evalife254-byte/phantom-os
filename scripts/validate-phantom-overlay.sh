#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OVERLAY_DIR="${ROOT_DIR}/build/phantom-overlay"
PKG_FILE="${OVERLAY_DIR}/packages.extra.x86_64"

required_files=(
  "${OVERLAY_DIR}/airootfs/etc/phantom-release"
  "${OVERLAY_DIR}/airootfs/etc/skel/.config/hypr/hyprland.conf"
  "${OVERLAY_DIR}/airootfs/etc/skel/.config/waybar/config.jsonc"
  "${OVERLAY_DIR}/airootfs/etc/skel/.config/waybar/style.css"
  "${OVERLAY_DIR}/airootfs/etc/skel/.config/rofi/config.rasi"
  "${OVERLAY_DIR}/airootfs/etc/skel/.config/mako/config"
  "${OVERLAY_DIR}/airootfs/etc/skel/.config/phantom/theme.json"
  "${PKG_FILE}"
)

required_packages=(
  hyprland
  hyprlock
  waybar
  rofi-wayland
  mako
  kitty
  networkmanager
)

echo "[validate] Checking required Phantom overlay files"
for file in "${required_files[@]}"; do
  [[ -f "$file" ]] || { echo "[validate] ERROR: Missing file: $file" >&2; exit 1; }
done

echo "[validate] Validating JSON files"
python - <<'PY'
import json
from pathlib import Path

paths = [
    Path("build/phantom-overlay/airootfs/etc/skel/.config/phantom/theme.json"),
]
for p in paths:
    json.loads(p.read_text(encoding="utf-8"))
print("[validate] JSON syntax OK")
PY

echo "[validate] Checking package list entries"
for pkg in "${required_packages[@]}"; do
  if ! rg -n "^${pkg}$" "$PKG_FILE" >/dev/null; then
    echo "[validate] ERROR: Missing package in ${PKG_FILE}: ${pkg}" >&2
    exit 1
  fi
done

if [[ -d "${ROOT_DIR}/build/archiso-profile" && -f "${ROOT_DIR}/build/archiso-profile/packages.x86_64" ]]; then
  echo "[validate] Checking duplicate entries in merged packages.x86_64"
  dupes="$(sort "${ROOT_DIR}/build/archiso-profile/packages.x86_64" | uniq -d || true)"
  if [[ -n "$dupes" ]]; then
    echo "[validate] WARNING: duplicates found in build/archiso-profile/packages.x86_64"
    echo "$dupes"
  else
    echo "[validate] No duplicate package lines detected"
  fi
fi

echo "[validate] Overlay validation passed"
