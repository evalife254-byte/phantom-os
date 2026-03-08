#!/bin/bash
# Low-RAM Build Script for Phantom OS
# Optimized for systems with 8GB or less RAM

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${SCRIPT_DIR}/build"
WORK_DIR="${BUILD_DIR}/work"
PACMAN_CACHE="${BUILD_DIR}/pacman-cache"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check available RAM
check_ram() {
    local available_ram=$(free -m | awk '/^Mem:/{print $7}')
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    
    log_info "Total RAM: ${total_ram}MB"
    log_info "Available RAM: ${available_ram}MB"
    
    if [ "$total_ram" -lt 4096 ]; then
        log_error "Minimum 4GB RAM required. You have ${total_ram}MB"
        log_error "Consider using a swap file or building on a more powerful machine"
        exit 1
    fi
    
    if [ "$total_ram" -lt 8192 ]; then
        log_warn "Low RAM detected (${total_ram}MB). Enabling memory optimizations..."
        return 1
    fi
    
    return 0
}

# Create swap file if needed
setup_swap() {
    local swap_size_gb=$1
    local swap_file="${BUILD_DIR}/swapfile"
    
    if [ -f "$swap_file" ]; then
        log_info "Using existing swap file"
        sudo swapon "$swap_file" 2>/dev/null || true
        return 0
    fi
    
    log_info "Creating ${swap_size_gb}GB swap file..."
    mkdir -p "$BUILD_DIR"
    
    # Create swap file with dd (fallocate may not work on all filesystems)
    sudo dd if=/dev/zero of="$swap_file" bs=1M count=$((swap_size_gb * 1024)) status=progress
    sudo chmod 600 "$swap_file"
    sudo mkswap "$swap_file"
    sudo swapon "$swap_file"
    
    log_info "Swap file activated: ${swap_size_gb}GB"
}

# Cleanup swap
cleanup_swap() {
    local swap_file="${BUILD_DIR}/swapfile"
    
    if [ -f "$swap_file" ]; then
        log_info "Deactivating swap file..."
        sudo swapoff "$swap_file" 2>/dev/null || true
        # Keep the file for future builds, just deactivate it
    fi
}

# Set up low-memory pacman configuration
setup_lowmem_pacman() {
    log_info "Configuring pacman for low-memory environment..."
    
    mkdir -p "$PACMAN_CACHE"
    
    cat > "${BUILD_DIR}/pacman-lowmem.conf" <<EOF
[options]
CacheDir = ${PACMAN_CACHE}
Architecture = auto
ParallelDownloads = 2
DisableSandbox

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
    
    export PACMAN_CONF="${BUILD_DIR}/pacman-lowmem.conf"
}

# Build with memory limits
build_lowmem() {
    log_info "Starting low-memory build process..."
    
    # Clean up any previous failed builds
    if [ -d "$WORK_DIR" ]; then
        log_warn "Cleaning up previous work directory..."
        sudo rm -rf "$WORK_DIR"
    fi
    
    # Set memory limits for compression
    export XZ_OPT="-T1 -9 --memlimit-compress=512MiB"
    export ZSTD_CLEVEL=19
    export ZSTD_NBTHREADS=1
    
    # Reduce mkarchiso parallelism
    export MAKEFLAGS="-j1"
    
    # Run build with timeout and memory monitoring
    log_info "Running mkarchiso (this may take 30-60 minutes on low-RAM systems)..."
    
    # Monitor memory usage in background
    (
        while true; do
            sleep 30
            local avail=$(free -m | awk '/^Mem:/{print $7}')
            if [ "$avail" -lt 500 ]; then
                log_warn "Low memory warning: ${avail}MB available"
                log_warn "Build may slow down or fail"
            fi
        done
    ) &
    local monitor_pid=$!
    
    # Run the actual build
    if sudo mkarchiso -v -w "$WORK_DIR" "${SCRIPT_DIR}/build/phantom-overlay" 2>&1 | tee "${BUILD_DIR}/build.log"; then
        log_info "Build completed successfully!"
        kill $monitor_pid 2>/dev/null || true
        return 0
    else
        log_error "Build failed!"
        kill $monitor_pid 2>/dev/null || true
        return 1
    fi
}

# Alternative: Build in chunks (for very low RAM)
build_chunked() {
    log_warn "Using chunked build method for very low RAM..."
    
    # Step 1: Prepare base only
    log_info "Step 1/3: Preparing base system..."
    sudo mkarchiso -v -w "$WORK_DIR" -p "base base-devel" "${SCRIPT_DIR}/build/phantom-overlay" || return 1
    
    # Step 2: Add X11/Wayland
    log_info "Step 2/3: Adding display server..."
    sudo mkarchiso -v -w "$WORK_DIR" -p "xorg wayland" "${SCRIPT_DIR}/build/phantom-overlay" || return 1
    
    # Step 3: Add DE and apps
    log_info "Step 3/3: Adding desktop environment..."
    sudo mkarchiso -v -w "$WORK_DIR" "${SCRIPT_DIR}/build/phantom-overlay" || return 1
}

# Cleanup function
cleanup() {
    log_info "Cleaning up..."
    cleanup_swap
    
    # Clean work directory but keep the ISO
    if [ -d "$WORK_DIR" ]; then
        log_info "Removing work directory..."
        sudo rm -rf "$WORK_DIR"
    fi
    
    log_info "Cleanup complete"
}

# Main menu
show_menu() {
    echo ""
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║     Phantom OS - Low RAM Build Helper                    ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo ""
    echo "Your system has: $(free -h | awk '/^Mem:/{print $2}') RAM"
    echo ""
    echo "Options:"
    echo "  1) Build with 3GB swap (FAT32 compatible, for 8GB systems)"
    echo "  2) Build with 4GB swap (recommended for 8GB systems)"
    echo "  3) Build with 8GB swap (for 4-6GB systems)"
    echo "  4) Build with 12GB swap (for <4GB systems)"
    echo "  5) Chunked build (slowest, most reliable for low RAM)"
    echo "  6) Clean up build files"
    echo "  7) Exit"
    echo ""
}

# Main
main() {
    # Trap cleanup on exit
    trap cleanup EXIT
    
    # Check if running as root (shouldn't be)
    if [ "$EUID" -eq 0 ]; then
        log_error "Do not run this script as root"
        exit 1
    fi
    
    while true; do
        show_menu
        read -p "Select option [1-7]: " choice
        
        case $choice in
            1)
                check_ram || setup_swap 3
                setup_lowmem_pacman
                build_lowmem
                ;;
            2)
                check_ram || setup_swap 4
                setup_lowmem_pacman
                build_lowmem
                ;;
            3)
                check_ram || setup_swap 8
                setup_lowmem_pacman
                build_lowmem
                ;;
            4)
                check_ram || setup_swap 12
                setup_lowmem_pacman
                build_lowmem
                ;;
            5)
                check_ram || setup_swap 8
                setup_lowmem_pacman
                build_chunked
                ;;
            6)
                cleanup
                ;;
            7)
                exit 0
                ;;
            *)
                log_error "Invalid option"
                ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
    done
}

main "$@"
