# Phantom OS CI/CD Pipeline

This document describes the continuous integration and deployment pipeline for Phantom OS.

## Overview

The CI/CD pipeline ensures code quality, validates configurations, and automates ISO builds.

## Workflows

### 1. Validate (validate.yml)

**Triggers:**
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`

**Jobs:**

#### lint-scripts
Runs shellcheck on all shell scripts:
- Bootstrap script
- Overlay script
- Validation script
- Build script
- Theme management scripts
- Performance scripts
- Customization hooks

#### validate-overlay
Validates overlay file structure:
- Checks required files exist
- Validates package list
- Checks for duplicates

#### validate-json
Validates JSON syntax:
- Theme files (all presets)
- Waybar config
- Dock config
- eww config

#### check-executables
Verifies script permissions:
- Main build scripts must be executable

#### dry-run-bootstrap
Full bootstrap test (main branch only):
- Clones archiso upstream
- Applies Phantom overlay
- Validates merged profile

### 2. Nightly Build Check (nightly.yml)

**Triggers:**
- Scheduled: 2 AM UTC daily
- Manual dispatch

**Jobs:**

#### nightly-check
Complete validation suite:
- Lint all scripts
- Validate overlay
- Bootstrap and apply overlay
- Create GitHub issue on failure

### 3. Build ISO (build-iso.yml)

**Triggers:**
- Release published
- Manual dispatch

**Jobs:**

#### build-iso
Full ISO build in Arch Linux container:
- Install archiso tools
- Run bootstrap
- Apply overlay
- Validate
- Build ISO with mkarchiso
- Generate checksums (SHA256, MD5)
- Upload artifacts
- Attach to GitHub release

**Artifacts:**
- ISO file
- SHA256SUMS
- MD5SUMS
- Retention: 30 days

## Local Testing

Before pushing, run these checks locally:

### Lint Scripts
```bash
shellcheck scripts/*.sh
shellcheck build/phantom-overlay/airootfs/usr/local/bin/*
```

### Validate Overlay
```bash
./scripts/validate-phantom-overlay.sh
```

### Validate JSON
```bash
python3 -m json.tool build/phantom-overlay/airootfs/etc/skel/.config/phantom/theme.json
```

### Full Bootstrap Test
```bash
./scripts/bootstrap-phantom-v1.sh
./scripts/apply-phantom-overlay.sh
./scripts/validate-phantom-overlay.sh
```

## GitHub Templates

### Issue Templates

**Bug Report** (`.github/ISSUE_TEMPLATE/bug_report.md`)
- Description
- Steps to reproduce
- Expected vs actual behavior
- Environment details
- Logs and screenshots

**Feature Request** (`.github/ISSUE_TEMPLATE/feature_request.md`)
- Feature description
- Use case
- Proposed solution
- Alternatives considered

### Pull Request Template

**PR Template** (`.github/pull_request_template.md`)
- Description
- Type of change
- Related issues
- Changes made
- Testing checklist
- Screenshots

## Contributing Guidelines

See `.github/CONTRIBUTING.md` for:
- Development workflow
- Code standards
- Testing requirements
- Commit message format
- Areas for contribution

## CI Status Badges

Add to README.md:

```markdown
![Validate](https://github.com/YOUR_USERNAME/phantom-os/workflows/Validate%20Phantom%20OS/badge.svg)
![Nightly](https://github.com/YOUR_USERNAME/phantom-os/workflows/Nightly%20Build%20Check/badge.svg)
```

## Secrets Configuration

No secrets required for current workflows. Future additions may need:

- `GITHUB_TOKEN` - Automatically provided
- Custom secrets for external services (if added)

## Workflow Permissions

Required permissions:
- `contents: read` - Read repository
- `contents: write` - Create releases (build-iso)
- `issues: write` - Create issues (nightly)

## Troubleshooting

### Shellcheck Failures

Fix common issues:
```bash
# Quote variables
echo "$variable"  # Good
echo $variable    # Bad

# Use [[ ]] for tests
if [[ -f "$file" ]]; then  # Good
if [ -f $file ]; then      # Bad
```

### JSON Validation Failures

Use a JSON validator:
```bash
python3 -m json.tool file.json
jq . file.json
```

### Bootstrap Failures

Check logs:
```bash
# View workflow logs in GitHub Actions
# Or run locally with verbose output
bash -x ./scripts/bootstrap-phantom-v1.sh
```

### ISO Build Failures

Common issues:
- Missing packages in `packages.extra.x86_64`
- Invalid overlay file paths
- Insufficient disk space
- archiso version mismatch

## Future Enhancements

Planned improvements:
- Automated testing in QEMU
- Performance benchmarking
- Security scanning
- Dependency updates (Dependabot)
- Release automation
- Documentation generation
- Code coverage reports
