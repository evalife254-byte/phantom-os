#!/bin/bash
# Docker-based build script for Phantom OS
# Works on any system with Docker installed

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    log_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

log_info "Building Phantom OS using Docker..."
log_info "This will take 30-60 minutes depending on your system"

# Run the build in an Arch Linux container
docker run --rm \
    --privileged \
    --network host \
    -v "${SCRIPT_DIR}:/workspace" \
    -w /workspace \
    archlinux:latest \
    bash -c '
set -euo pipefail

echo "[Docker] Updating system and installing dependencies..."
yes | pacman -Syu
yes | pacman -S archiso git base-devel

echo "[Docker] Starting build process..."
./scripts/build-phantom-iso.sh

echo "[Docker] Build complete!"
ls -lh out/*.iso 2>/dev/null || echo "ISO files should be in out/ directory"
'

if [ $? -eq 0 ]; then
    log_info "Build completed successfully!"
    log_info "ISO file location:"
    ls -lh out/*.iso 2>/dev/null || log_warn "No ISO found in out/ directory"
else
    log_error "Build failed!"
    exit 1
fi
