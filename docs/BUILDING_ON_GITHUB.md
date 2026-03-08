# Building Phantom OS on GitHub Actions

This guide shows how to build Phantom OS ISO entirely on GitHub Actions, perfect for Windows users or systems with limited resources.

## Why Build on GitHub?

- **No local resources needed** - GitHub provides the build environment
- **Works on any OS** - Windows, Mac, Linux - just push to GitHub
- **Free for public repos** - GitHub Actions is free for open source
- **Powerful runners** - 7 GB RAM, 14 GB SSD, 2-core CPU
- **Automated builds** - Trigger builds with a button click or git tag

## Prerequisites

1. GitHub account (free)
2. Git installed on Windows
3. This repository pushed to GitHub

## Setup Steps

### 1. Push Repository to GitHub

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial Phantom OS commit"

# Add GitHub remote (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/phantom-os.git

# Push to GitHub
git push -u origin main
```

### 2. Enable GitHub Actions

GitHub Actions is enabled by default for public repositories. The workflows are already configured in `.github/workflows/`.

### 3. Trigger a Build

You have three options:

#### Option A: Manual Workflow Dispatch (Easiest)

1. Go to your GitHub repository
2. Click **Actions** tab
3. Click **Build Phantom OS ISO** workflow
4. Click **Run workflow** button
5. Click the green **Run workflow** button
6. Wait 30-60 minutes for build to complete

#### Option B: Create a Release

1. Go to your GitHub repository
2. Click **Releases** → **Create a new release**
3. Create a new tag (e.g., `v0.1.0`)
4. Fill in release title and description
5. Click **Publish release**
6. ISO will be automatically built and attached to the release

#### Option C: Push a Tag

```bash
# Create and push a tag
git tag v0.1.0
git push origin v0.1.0
```

## Monitoring the Build

1. Go to **Actions** tab in your GitHub repository
2. Click on the running workflow
3. Watch the build progress in real-time
4. Each step shows detailed logs

### Build Steps

The workflow performs these steps:
1. **Checkout code** - Downloads your repository
2. **Update system** - Updates Arch Linux container
3. **Install dependencies** - Installs archiso and build tools
4. **Run bootstrap** - Clones upstream archiso
5. **Apply overlay** - Applies Phantom customizations
6. **Validate overlay** - Checks all files are correct
7. **Build ISO** - Runs mkarchiso (takes 20-40 minutes)
8. **Generate checksums** - Creates SHA256 and MD5 sums
9. **Upload artifacts** - Makes ISO downloadable

## Downloading the ISO

### From Workflow Run

1. Go to **Actions** tab
2. Click on the completed workflow run
3. Scroll to **Artifacts** section at the bottom
4. Download **phantom-os-iso** (contains ISO + checksums)
5. Extract the ZIP file

### From Release

1. Go to **Releases** tab
2. Click on your release
3. Download the ISO file from **Assets** section
4. Download SHA256SUMS to verify integrity

## Verifying the ISO

### On Windows (PowerShell)

```powershell
# Calculate SHA256
Get-FileHash phantom-os-*.iso -Algorithm SHA256

# Compare with SHA256SUMS file
Get-Content SHA256SUMS
```

### On Linux/Mac

```bash
# Verify checksum
sha256sum -c SHA256SUMS
```

## Testing the ISO

### Option 1: VirtualBox (Windows)

1. Download and install [VirtualBox](https://www.virtualbox.org/)
2. Create new VM:
   - Type: Linux
   - Version: Arch Linux (64-bit)
   - Memory: 4096 MB (4 GB)
   - Disk: 20 GB VDI
3. Settings → Storage → Add optical drive → Select ISO
4. Settings → Display → Video Memory: 128 MB
5. Start the VM

### Option 2: Rufus (Windows - USB Boot)

1. Download [Rufus](https://rufus.ie/)
2. Insert USB drive (8 GB+)
3. Select Phantom OS ISO
4. Partition scheme: GPT
5. Target system: UEFI
6. Click **Start**
7. Boot from USB on target machine

### Option 3: QEMU (Any OS)

```bash
# Windows (install QEMU first)
qemu-system-x86_64 -cdrom phantom-os-*.iso -m 4096 -enable-kvm

# Linux
qemu-system-x86_64 -cdrom phantom-os-*.iso -m 4096 -enable-kvm
```

## Build Time and Resources

### GitHub Actions Limits (Free Tier)

- **Public repos**: Unlimited minutes
- **Private repos**: 2,000 minutes/month
- **Storage**: 500 MB artifacts (30-day retention)
- **Concurrent jobs**: 20

### Expected Build Time

- **Bootstrap**: 2-5 minutes
- **ISO build**: 20-40 minutes
- **Total**: 25-50 minutes

### ISO Size

- **Download**: ~800 MB - 1.2 GB (compressed)
- **Extracted**: ~1.5 - 2 GB

## Troubleshooting

### Build Fails at Bootstrap

**Error**: Can't clone archiso repository

**Solution**: Check internet connectivity in Actions, retry workflow

### Build Fails at mkarchiso

**Error**: Package not found

**Solution**: 
1. Check `build/phantom-overlay/packages.extra.x86_64`
2. Verify package names are correct
3. Update package list if needed

### Artifact Upload Fails

**Error**: Artifact too large

**Solution**: GitHub has 500 MB limit per artifact. ISO should be under this.

### Can't Download Artifact

**Error**: Artifact expired

**Solution**: Artifacts are kept for 30 days. Rebuild if expired.

## Advanced: Automated Nightly Builds

The repository includes a nightly validation workflow that runs at 2 AM UTC daily.

To enable nightly ISO builds:

1. Edit `.github/workflows/nightly.yml`
2. Add ISO build step at the end
3. Commit and push

## Cost Considerations

### Free Tier (Public Repos)

- ✅ Unlimited build minutes
- ✅ Free artifact storage (30 days)
- ✅ No credit card required

### Private Repos

- 2,000 minutes/month free
- Each build uses ~30-50 minutes
- ~40-60 builds per month on free tier
- Additional minutes: $0.008/minute

## Local Development (Optional)

If you want to test changes before pushing:

### Using WSL2 on Windows

1. Install WSL2: `wsl --install`
2. Install Arch Linux from Microsoft Store
3. Inside WSL:
   ```bash
   sudo pacman -S archiso git base-devel
   ./scripts/build-phantom-iso.sh
   ```

### Using Docker on Windows

```bash
# Pull Arch Linux image
docker pull archlinux:latest

# Run build in container
docker run -v ${PWD}:/workspace -w /workspace archlinux:latest bash -c "
  pacman -Syu --noconfirm
  pacman -S --noconfirm archiso git base-devel
  ./scripts/build-phantom-iso.sh
"
```

## GitHub Actions Workflow Files

The repository includes three workflows:

### 1. validate.yml
- Runs on every push and PR
- Lints shell scripts
- Validates JSON files
- Checks overlay structure
- Fast (~2-5 minutes)

### 2. build-iso.yml
- Runs on releases or manual trigger
- Full ISO build
- Uploads artifacts
- Attaches to releases
- Slow (~30-50 minutes)

### 3. nightly.yml
- Runs daily at 2 AM UTC
- Validates repository health
- Creates issue if validation fails
- Fast (~5-10 minutes)

## Tips for Windows Users

### Git Bash Commands

Use Git Bash (comes with Git for Windows) for Unix-like commands:

```bash
# Navigate to repository
cd /c/Users/YourName/phantom-os

# Check status
git status

# Push changes
git add .
git commit -m "Update configuration"
git push
```

### PowerShell Alternative

```powershell
# Navigate to repository
cd C:\Users\YourName\phantom-os

# Check status
git status

# Push changes
git add .
git commit -m "Update configuration"
git push
```

### Editing Files on Windows

Use any text editor:
- **VS Code** (recommended)
- Notepad++
- Sublime Text
- Even Notepad works

Just make sure to use **LF line endings** (not CRLF) for shell scripts.

## Next Steps

1. ✅ Push repository to GitHub
2. ✅ Trigger a build via Actions
3. ✅ Download the ISO
4. ✅ Test in VirtualBox
5. ✅ Report any issues on GitHub

## Support

- **Build fails?** Check Actions logs for details
- **ISO issues?** Test in VM and report on GitHub Issues
- **Questions?** Open a GitHub Discussion

## Summary

Building on GitHub Actions is the **easiest way** to build Phantom OS, especially on Windows:

- No local setup required
- No resource constraints
- Automated and reproducible
- Free for open source projects

Just push your code and let GitHub do the heavy lifting!
