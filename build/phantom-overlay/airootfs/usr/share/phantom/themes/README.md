# Phantom OS Theme System

This directory contains preset themes for Phantom OS.

## Available Themes

- **ghost-protocol** (default) - Neon cyan on deep black
- **specter** - Purple and blue mystique with ethereal glow
- **wraith** - Green matrix aesthetic with digital rain vibes
- **eclipse** - Orange and red sunset with warm dark tones
- **daylight** - Light mode variant with soft colors

## Theme Structure

Each theme is a JSON file with the following structure:

```json
{
  "name": "theme-id",
  "display_name": "Theme Display Name",
  "description": "Theme description",
  "colors": {
    "background": "#0A0A0F",
    "surface": "#141420",
    "panel": "#1A1A2E",
    "accent_primary": "#00F0FF",
    "accent_secondary": "#7B68EE",
    "text_primary": "#E0E0E8",
    "text_secondary": "#6B6B80",
    "warning": "#FFD93D",
    "critical": "#FF6B6B",
    "success": "#6BCF7F"
  }
}
```

## Color Definitions

- **background**: Main desktop background color
- **surface**: Window and surface backgrounds
- **panel**: Panel and bar backgrounds
- **accent_primary**: Primary accent color (buttons, highlights)
- **accent_secondary**: Secondary accent color (alternative highlights)
- **text_primary**: Primary text color
- **text_secondary**: Secondary/dimmed text color
- **warning**: Warning state color
- **critical**: Critical/error state color
- **success**: Success state color

## Using Themes

### CLI

```bash
# List available themes
phantom-theme list

# Apply a theme
phantom-theme apply specter

# Show current theme
phantom-theme current

# Export current theme
phantom-theme export ~/my-theme.json

# Import a theme
phantom-theme import ~/my-theme.json

# Reload theme
phantom-theme reload
```

### GUI

Launch the theme editor from the application menu or run:

```bash
phantom-theme-editor
```

## Creating Custom Themes

1. Copy an existing theme as a starting point
2. Modify the colors to your preference
3. Save to `~/.config/phantom/themes/your-theme.json`
4. Apply with `phantom-theme apply your-theme`

Or use the GUI theme editor for a visual experience.

## Theme Integration

Themes are automatically applied to:
- Waybar (panel)
- Rofi (launcher)
- Mako (notifications)
- Hyprland (compositor effects)
- eww (desktop widgets)
- wlogout (power menu)
- hyprlock (lock screen)
- SDDM (login screen)

Some components may require a logout/login to fully apply theme changes.
