# Phantom Files - User Guide

Phantom Files is the custom file manager for Phantom OS, featuring a dual-pane layout and Ghost Protocol theme.

## Features

### Dual-Pane Layout
- Side-by-side file browsing
- Independent navigation in each pane
- Easy file operations between panes
- Active pane highlighting

### File Operations
- **Copy** - Copy files/folders
- **Cut** - Move files/folders
- **Paste** - Paste clipboard items
- **Delete** - Remove files/folders (with confirmation)
- **New Folder** - Create directories

### Navigation
- **Back/Forward** - Navigate history (coming soon)
- **Up** - Go to parent directory
- **Home** - Go to home directory
- **Path Bar** - Type path directly

### Integration
- **Terminal** - Open terminal in current directory
- **Default Apps** - Open files with system default applications
- **Refresh** - Reload directory contents

## Keyboard Shortcuts

### Navigation
- `Ctrl+L` - Focus path bar
- `Backspace` - Go up one directory
- `Alt+Home` - Go to home directory

### File Operations
- `Ctrl+C` - Copy selected items
- `Ctrl+X` - Cut selected items
- `Ctrl+V` - Paste clipboard items
- `Delete` - Delete selected items
- `Ctrl+N` - New folder
- `F5` - Refresh

### Pane Control
- `Tab` - Switch active pane
- `Ctrl+T` - Open terminal

## Usage

### Launching
```bash
# From terminal
phantom-files

# From application menu
Search for "Phantom Files"
```

### Basic Operations

#### Navigate to Directory
1. Click on folder to open
2. Or type path in path bar and press Enter
3. Use toolbar buttons (Up, Home, etc.)

#### Copy Files
1. Select files in one pane
2. Click Copy button (📋)
3. Navigate to destination in other pane
4. Click Paste button (📄)

#### Move Files
1. Select files in one pane
2. Click Cut button (✂️)
3. Navigate to destination in other pane
4. Click Paste button (📄)

#### Delete Files
1. Select files
2. Click Delete button (🗑️)
3. Confirm deletion

#### Create Folder
1. Click New Folder button (📁+)
2. Enter folder name
3. Click Create

#### Open Terminal
1. Navigate to desired directory
2. Click Terminal button (⌨️)
3. Kitty opens in that directory

### Multi-Selection
- Click items to select
- Hold Ctrl and click for multiple selection
- Hold Shift and click for range selection

### Dual-Pane Workflow

**Example: Organizing Photos**
1. Left pane: Navigate to Downloads
2. Right pane: Navigate to Pictures
3. Select photos in left pane
4. Copy or cut
5. Paste in right pane

**Example: Backup Files**
1. Left pane: Source directory
2. Right pane: Backup location
3. Select all files
4. Copy to backup

## Ghost Protocol Theme

Phantom Files uses the Ghost Protocol color scheme:
- **Background:** Deep black (#0A0A0F)
- **Panels:** Dark surface (#141420)
- **Borders:** Neon cyan (#00F0FF)
- **Text:** Light gray (#E0E0E8)
- **Hover:** Cyan glow

### Active Pane
The active pane has a cyan border. Click on a pane to make it active.

## File Icons

- 📁 - Directory
- 📄 - File
- .. - Parent directory

## Status Bar

Bottom status bar shows:
- Current path
- Number of folders
- Number of files

## Tips & Tricks

### Quick Navigation
- Type path directly in path bar
- Use .. to go up
- Bookmark frequently used directories (coming soon)

### Efficient File Management
- Use dual panes to avoid switching windows
- Keep source in one pane, destination in other
- Use keyboard shortcuts for speed

### Terminal Integration
- Open terminal in any directory instantly
- Run commands on selected files
- Quick access to command line

## Troubleshooting

### Permission Denied
If you can't access a directory:
```bash
# Check permissions
ls -la /path/to/directory

# Use sudo if needed (be careful!)
sudo phantom-files
```

### Files Not Showing
- Click Refresh button (🔄)
- Check if hidden files are enabled (coming soon)
- Verify you're in the correct directory

### Can't Delete Files
- Check file permissions
- Close any programs using the files
- Use terminal if needed: `rm filename`

### Application Won't Open Files
- Check default applications: `xdg-mime query default type`
- Set default: `xdg-mime default app.desktop type`

## Planned Features

### Coming Soon
- [ ] Hidden files toggle
- [ ] File search
- [ ] Bookmarks/favorites
- [ ] File tags
- [ ] Preview pane
- [ ] Hex editor
- [ ] Archive support (zip, tar, etc.)
- [ ] Network locations (SMB, FTP)
- [ ] Thumbnail view
- [ ] Column view
- [ ] Split view options
- [ ] Keyboard navigation mode
- [ ] Custom actions
- [ ] Batch rename
- [ ] File properties dialog

### Future Enhancements
- Integrated terminal pane
- File comparison
- Duplicate finder
- Disk usage analyzer
- Cloud storage integration
- Git integration
- Image preview
- Video preview
- Audio preview
- Document preview

## Configuration

### Settings Location
```
~/.config/phantom-files/
```

### Theme Customization
Phantom Files inherits colors from the system theme. Change theme with:
```bash
phantom-theme apply <theme-name>
```

## Command Line Options

```bash
# Open in specific directory
phantom-files /path/to/directory

# Open two directories in dual panes
phantom-files /path/left /path/right

# Show version
phantom-files --version

# Show help
phantom-files --help
```

## Integration with Phantom OS

### Default File Manager
Phantom Files is the default file manager for Phantom OS.

### Dock Integration
Pin to dock for quick access:
1. Open Phantom Files
2. Right-click dock icon
3. Select "Pin to Dock"

### Keyboard Shortcut
Set global shortcut in Hyprland config:
```
bind = $mod, E, exec, phantom-files
```

## Comparison with Other File Managers

### vs Thunar
- ✅ Dual-pane layout
- ✅ Ghost Protocol theme
- ✅ Integrated terminal
- ⚠️ Fewer plugins (for now)

### vs Nautilus
- ✅ Lighter weight
- ✅ Dual-pane by default
- ✅ Better keyboard navigation
- ⚠️ Fewer features (for now)

### vs Dolphin
- ✅ Simpler interface
- ✅ Faster startup
- ✅ Phantom OS integration
- ⚠️ Fewer advanced features

## Contributing

Phantom Files is open source! Contribute at:
- Report bugs on GitHub Issues
- Request features
- Submit pull requests
- Improve documentation

## Support

- **Documentation:** This file
- **GitHub Issues:** Bug reports
- **Community:** GitHub Discussions

## Credits

Built with:
- **GTK4** - UI toolkit
- **libadwaita** - Modern widgets
- **Python** - Programming language

## License

Phantom Files is part of Phantom OS and follows the same licensing as the distribution.

---

**Version:** 0.1.0  
**Last Updated:** 2024  
**Part of:** Phantom OS
