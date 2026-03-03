#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="${1:-${ROOT_DIR}/.cache/archiso-upstream}"
ARCHISO_REPO="https://gitlab.archlinux.org/archlinux/archiso.git"
PROFILE_SRC="configs/releng"
PROFILE_DST="${ROOT_DIR}/build/archiso-profile"

usage() {
  cat <<USAGE
Usage: $(basename "$0") [work_dir]

Bootstraps Phantom OS v1 build files by cloning the upstream archiso repo,
then syncing the releng profile as a base into build/archiso-profile.

Arguments:
  work_dir   Optional clone location for archiso upstream repo.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

mkdir -p "$(dirname "$WORK_DIR")"

if [[ -d "$WORK_DIR/.git" ]]; then
  echo "[bootstrap] Updating existing archiso clone: $WORK_DIR"
  git -C "$WORK_DIR" fetch --depth=1 origin
  DEFAULT_REF="$(git -C "$WORK_DIR" symbolic-ref refs/remotes/origin/HEAD | sed 's#^refs/remotes/origin/##')"
  git -C "$WORK_DIR" checkout "$DEFAULT_REF"
  git -C "$WORK_DIR" reset --hard "origin/$DEFAULT_REF"
else
  echo "[bootstrap] Cloning archiso upstream: $ARCHISO_REPO"
  rm -rf "$WORK_DIR"
  git clone --depth=1 "$ARCHISO_REPO" "$WORK_DIR"
fi

if [[ ! -d "$WORK_DIR/$PROFILE_SRC" ]]; then
  echo "[bootstrap] ERROR: profile '$PROFILE_SRC' not found in $WORK_DIR" >&2
  exit 1
fi

echo "[bootstrap] Syncing profile into repo: $PROFILE_DST"
rm -rf "$PROFILE_DST"
mkdir -p "$PROFILE_DST"
cp -a "$WORK_DIR/$PROFILE_SRC/." "$PROFILE_DST/"

cat <<MSG
[bootstrap] Done.

Next steps:
  1) Apply Phantom DE overlay with: ./scripts/apply-phantom-overlay.sh
  2) Build ISO with:
       mkarchiso -v -w ./work -o ./out ./build/archiso-profile
MSG
