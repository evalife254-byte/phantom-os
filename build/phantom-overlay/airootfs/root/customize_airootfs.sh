#!/usr/bin/env bash
# Phantom OS airootfs customization hook
# This script runs during ISO build to customize the live environment

set -e -u

# Make theme scripts executable
chmod +x /usr/local/bin/phantom-theme
chmod +x /usr/local/bin/phantom-theme-editor

# Make performance scripts executable
chmod +x /usr/local/bin/phantom-gpu-setup
chmod +x /usr/local/bin/phantom-power

# Make pentesting script executable
chmod +x /usr/local/bin/phantom-pentest

# Make Phantom Files executable
chmod +x /usr/local/bin/phantom-files

# Make Phantom Browser executable
chmod +x /usr/local/bin/phantom-browser

# Make Phase 6 applications executable
chmod +x /usr/local/bin/phantom-music
chmod +x /usr/local/bin/phantom-video
chmod +x /usr/local/bin/phantom-code

# Make Phase 7 applications executable
chmod +x /usr/local/bin/phantom-office

# Make Phase 8 applications executable
chmod +x /usr/local/bin/phm

# Make Settings application executable
chmod +x /usr/local/bin/phantom-settings

# Make Quick Settings application executable
chmod +x /usr/local/bin/phantom-quick-settings

# Make Welcome application executable
chmod +x /usr/local/bin/phantom-welcome

# Make wallpaper manager executable
chmod +x /usr/local/bin/phantom-wallpaper

# Make wallpaper manager executable
chmod +x /usr/local/bin/phantom-wallpaper

# Install wallpapers to system location
mkdir -p /usr/share/backgrounds/phantom
cp /usr/share/phantom/wallpapers/*.jpg /usr/share/backgrounds/phantom/ 2>/dev/null || true

# Set default wallpaper symlink
ln -sf /usr/share/backgrounds/phantom/kimi-1771849888077.jpg /usr/share/backgrounds/phantom/default.jpg 2>/dev/null || true

# Update icon cache for Phantom icon theme
cd /usr/share/icons && gtk-update-icon-cache -f . 2>/dev/null || true

# Enable services
systemctl enable sddm.service
systemctl enable NetworkManager.service
systemctl enable phantom-gpu-setup.service
systemctl enable phantom-power-auto.service

# Set default power profile
mkdir -p /etc/phantom
echo "balanced" > /etc/phantom/power-profile

echo "Phantom OS customization complete"
