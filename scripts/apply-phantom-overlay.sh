#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_DIR="${1:-${ROOT_DIR}/build/archiso-profile}"
OVERLAY_DIR="${ROOT_DIR}/build/phantom-overlay"

if [[ ! -d "$PROFILE_DIR" ]]; then
  echo "[overlay] ERROR: profile directory not found: $PROFILE_DIR" >&2
  echo "[overlay] Run scripts/bootstrap-phantom-v1.sh first." >&2
  exit 1
fi

if [[ ! -f "$PROFILE_DIR/packages.x86_64" ]]; then
  echo "[overlay] ERROR: packages.x86_64 missing in $PROFILE_DIR" >&2
  exit 1
fi

echo "[overlay] Copying overlay files into $PROFILE_DIR/airootfs"
mkdir -p "$PROFILE_DIR/airootfs"
cp -a "$OVERLAY_DIR/airootfs/." "$PROFILE_DIR/airootfs/"

echo "[overlay] Merging extra packages (deduplicated)"
TMP_PACKAGES="$(mktemp)"
cat "$PROFILE_DIR/packages.x86_64" "$OVERLAY_DIR/packages.extra.x86_64" > "$TMP_PACKAGES"
awk '!seen[$0]++' "$TMP_PACKAGES" > "$PROFILE_DIR/packages.x86_64"
rm -f "$TMP_PACKAGES"

echo "[overlay] Done. Phantom DE overlay applied to $PROFILE_DIR"
