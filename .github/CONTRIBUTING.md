# Contributing to Phantom OS

Thank you for your interest in contributing to Phantom OS!

## Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run validation: `./scripts/validate-phantom-overlay.sh`
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Code Standards

### Shell Scripts

- Use `#!/usr/bin/env bash` shebang
- Enable strict mode: `set -euo pipefail`
- Pass shellcheck linting
- Include usage/help functions
- Add comments for complex logic

### Configuration Files

- Use consistent indentation (2 spaces for JSON/YAML, 4 for Python)
- Validate JSON files before committing
- Follow existing naming conventions
- Document non-obvious settings

### Commit Messages

- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit first line to 72 characters
- Reference issues and PRs when applicable

## Testing

Before submitting a PR:

1. Run shellcheck on modified scripts
2. Run `./scripts/validate-phantom-overlay.sh`
3. Test bootstrap process if you modified build scripts
4. Verify JSON syntax for config changes

## CI/CD Pipeline

All PRs trigger automated checks:

- Shell script linting (shellcheck)
- Overlay validation
- JSON validation
- Executable permissions check
- Dry-run bootstrap (on main branch)

## Areas for Contribution

### High Priority

- Custom app development (Phantom Files, Browser, etc.)
- Plymouth boot splash animations
- Additional theme presets
- Performance optimizations
- Bug fixes and testing

### Medium Priority

- Documentation improvements
- Package manager (.phm format)
- Installer integration (Calamares)
- Pentesting toolkit curation

### Low Priority

- Additional desktop widgets
- Alternative panel layouts
- Icon theme development
- Wallpaper collection

## Questions?

- Open an issue for bugs or feature requests
- Start a discussion for general questions
- Check existing issues before creating new ones

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.
