#!/bin/bash
# Install wallpapers to overlay during build

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/../../../phantom wallpapers"
DEST_DIR="${SCRIPT_DIR}/../airootfs/usr/share/phantom/wallpapers"

if [[ -d "$SOURCE_DIR" ]]; then
  echo "[wallpapers] Installing wallpapers to overlay..."
  mkdir -p "$DEST_DIR"
  
  # Copy all wallpaper images
  find "$SOURCE_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec cp {} "$DEST_DIR/" \;
  
  echo "[wallpapers] Installed $(ls -1 "$DEST_DIR" | wc -l) wallpapers"
else
  echo "[wallpapers] Warning: Source wallpaper directory not found"
fi
