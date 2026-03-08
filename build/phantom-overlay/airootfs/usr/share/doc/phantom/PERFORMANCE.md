# Phantom OS Performance Guide

This document describes the performance optimizations in Phantom OS.

## Overview

Phantom OS is optimized for desktop responsiveness with a target boot time of 3-5 seconds and minimal latency during interactive use.

## Performance Features

### 1. zram Swap

Compressed swap in RAM provides better performance than disk swap:
- Size: 50% of RAM
- Compression: zstd algorithm
- Priority: 100 (higher than disk swap)

Configuration: `/etc/systemd/zram-generator.conf`

### 2. I/O Scheduler Optimization

Automatic scheduler selection based on device type:
- **NVMe**: `none` (hardware queue is optimal)
- **SSD**: `mq-deadline` (better latency)
- **HDD**: `bfq` (better throughput)

Configuration: `/etc/udev/rules.d/60-ioschedulers.rules`

### 3. GPU Auto-Detection

Automatic GPU detection and driver configuration:
- **NVIDIA**: Wayland support, DRM mode setting
- **AMD**: RADV driver with ACO compiler
- **Intel**: Iris driver optimization

Run manually: `sudo phantom-gpu-setup`

Service: `phantom-gpu-setup.service`

### 4. Power Profiles

Three power profiles for different use cases:

#### Performance
- CPU governor: `performance`
- Turbo boost: enabled
- Power saving: disabled
- Use case: Gaming, rendering, compilation

```bash
sudo phantom-power set performance
```

#### Balanced (default)
- CPU governor: `schedutil`
- Turbo boost: enabled
- Power saving: selective
- Use case: General desktop use

```bash
sudo phantom-power set balanced
```

#### Powersave
- CPU governor: `powersave`
- Turbo boost: disabled
- Power saving: aggressive
- Use case: Battery life priority

```bash
sudo phantom-power set powersave
```

#### Auto Profile
Automatically selects profile based on power source:
- AC power → performance
- Battery → balanced

```bash
sudo phantom-power auto
```

Service: `phantom-power-auto.service` (runs at boot)

### 5. Kernel Tuning

Optimized sysctl parameters for desktop responsiveness:

**Virtual Memory:**
- `vm.swappiness = 10` - Prefer RAM over swap
- `vm.vfs_cache_pressure = 50` - Keep directory cache
- `vm.dirty_ratio = 10` - Write dirty pages sooner
- `vm.dirty_background_ratio = 5` - Background writeback

**Network:**
- Increased buffer sizes for better throughput
- TCP Fast Open enabled
- MTU probing enabled

**File System:**
- `fs.inotify.max_user_watches = 524288` - More file watches
- `fs.file-max = 2097152` - More open files

Configuration: `/etc/sysctl.d/99-phantom-performance.conf`

### 6. Kernel Module Optimization

**NVMe:**
- Poll queues enabled for lower latency

**Intel GPU:**
- GuC/HuC firmware enabled
- Frame buffer compression enabled

**AMD GPU:**
- All power features enabled

Configuration: `/etc/modprobe.d/phantom-performance.conf`

### 7. Boot Optimization

**systemd:**
- Reduced timeouts (15s instead of 90s)
- Parallel service startup
- Faster shutdown

**Journal:**
- Limited size (100M system, 50M runtime)
- Reduced sync frequency
- No syslog forwarding

Configuration:
- `/etc/systemd/system.conf.d/phantom-boot.conf`
- `/etc/systemd/journald.conf.d/phantom-journal.conf`

### 8. Transparent Huge Pages

Set to `madvise` mode for better memory efficiency without overhead.

Configuration: `/etc/tmpfiles.d/phantom-performance.conf`

## Monitoring Performance

### Check Current Power Profile
```bash
phantom-power current
```

### Check GPU Setup
```bash
cat /var/log/phantom-gpu-setup.log
```

### Check Boot Time
```bash
systemd-analyze
systemd-analyze blame
```

### Check I/O Scheduler
```bash
cat /sys/block/*/queue/scheduler
```

### Check zram Status
```bash
zramctl
swapon --show
```

### Monitor System Resources
```bash
htop
iotop
powertop
```

## Benchmarking

### Boot Time Target
- Cold boot: 3-5 seconds to login screen
- Login to desktop: < 2 seconds

### Responsiveness
- Application launch: < 1 second for most apps
- Window switching: < 16ms (60 FPS)
- File operations: Near-instant for cached files

## Troubleshooting

### Slow Boot
```bash
# Analyze boot time
systemd-analyze critical-chain

# Check for slow services
systemd-analyze blame
```

### High CPU Usage
```bash
# Check current governor
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Set to powersave if needed
sudo phantom-power set powersave
```

### GPU Issues
```bash
# Re-run GPU setup
sudo phantom-gpu-setup

# Check logs
journalctl -u phantom-gpu-setup.service
```

### Memory Pressure
```bash
# Check zram
zramctl

# Check swap usage
free -h
```

## Advanced Tuning

### Custom Power Profile
Edit `/etc/phantom/power-profile` and run:
```bash
sudo phantom-power set <your-profile>
```

### Custom Kernel Parameters
Add to `/etc/sysctl.d/99-phantom-custom.conf`

### Disable Performance Features
```bash
# Disable zram
sudo systemctl disable systemd-zram-setup@zram0.service

# Disable auto power profile
sudo systemctl disable phantom-power-auto.service
```

## References

- [Arch Linux Performance Guide](https://wiki.archlinux.org/title/Improving_performance)
- [systemd Boot Optimization](https://wiki.archlinux.org/title/Improving_performance/Boot_process)
- [I/O Schedulers](https://wiki.archlinux.org/title/Improving_performance#Storage_devices)
