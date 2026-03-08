#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_DIR="${ROOT_DIR}/build/archiso-profile"
WORK_DIR="${ROOT_DIR}/work"
OUT_DIR="${ROOT_DIR}/out"
SKIP_BOOTSTRAP="false"

usage() {
  cat <<USAGE
Usage: $(basename "$0") [--skip-bootstrap]

Runs the complete Phantom OS v1 local build pipeline:
  1) bootstrap archiso base profile
  2) apply Phantom overlay
  3) validate overlay
  4) build ISO via mkarchiso

Options:
  --skip-bootstrap   Skip upstream archiso sync and reuse existing build/archiso-profile
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --skip-bootstrap)
      SKIP_BOOTSTRAP="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if ! command -v mkarchiso >/dev/null 2>&1; then
  echo "[build] ERROR: mkarchiso not found. Install archiso first." >&2
  exit 1
fi

if [[ "$SKIP_BOOTSTRAP" != "true" ]]; then
  "${ROOT_DIR}/scripts/bootstrap-phantom-v1.sh"
fi

"${ROOT_DIR}/scripts/apply-phantom-overlay.sh" "$PROFILE_DIR"
"${ROOT_DIR}/scripts/validate-phantom-overlay.sh"

echo "[build] Starting mkarchiso"
mkarchiso -v -w "$WORK_DIR" -o "$OUT_DIR" "$PROFILE_DIR"

echo "[build] Done. Output ISOs are in: $OUT_DIR"
