# Wallpaper Integration Guide

## Overview

The theme-switcher now includes integrated wallpaper management using waypaper. Each theme has its own wallpaper folder, and waypaper is automatically themed to match your current theme colors.

## Quick Start

### Using the Wallpaper Selector

Press **Super+Y** to open the themed wallpaper selector.

The wallpaper selector will:
- Open in zen mode (clean, focused interface)
- Show only wallpapers from your current theme's folder
- Match your current theme colors (background, foreground, accents)
- Remember your selection

### Adding Wallpapers to Themes

Each theme has its own wallpaper directory:

```bash
~/projects/theme-switcher/themes/
├── gruvbox-dark/wallpapers/
├── catppuccin-mocha/wallpapers/
└── nord/wallpapers/
```

To add wallpapers:

```bash
# Copy wallpapers to the current theme
cp ~/Pictures/my-wallpaper.jpg ~/projects/theme-switcher/themes/gruvbox-dark/wallpapers/

# Or use your file manager to drag and drop
```

## Keybinds

- **Super+T** - Open theme selector (rofi)
- **Super+Y** - Open wallpaper selector (waypaper)

## How It Works

### Architecture

1. **Current Theme Tracking**
   - Theme name saved to `~/.config/current-theme` when you switch themes
   - Used by waypaper-themed script to find the correct folder

2. **Waypaper Integration**
   - Script: `~/projects/theme-switcher/scripts/waypaper-themed`
   - Config: `~/.config/waypaper/config.ini` (auto-updated)
   - Styling: `~/.config/waypaper/style.css` (auto-generated)

3. **Dynamic Theming**
   - CSS stylesheet generated from current pywal colors
   - Matches background, foreground, and accent colors
   - Updates automatically when you switch themes

### File Structure

```
theme-switcher/
├── scripts/
│   ├── theme-switch          # Main theme switcher
│   └── waypaper-themed        # Wallpaper launcher (themed)
└── themes/
    ├── gruvbox-dark/
    │   └── wallpapers/        # Gruvbox wallpapers
    ├── catppuccin-mocha/
    │   └── wallpapers/        # Catppuccin wallpapers
    └── nord/
        └── wallpapers/        # Nord wallpapers
```

## Waypaper Features

The themed waypaper includes:
- Zen mode for distraction-free selection
- Keyboard navigation (Vim keys supported)
- Multiple monitor support
- GIF animation support
- Video wallpaper support (with mpvpaper)
- Automatic wallpaper restoration on login

## Configuration

### Waypaper Config

Located at `~/.config/waypaper/config.ini`:

```ini
[Settings]
folder = ~/projects/theme-switcher/themes/gruvbox-dark/wallpapers
zen_mode = True
backend = hyprpaper
fill = fill
stylesheet = /home/stephen/.config/waypaper/style.css
```

**Note:** This file is automatically updated by `waypaper-themed` script.

### Customize Wallpaper Behavior

Edit the waypaper-themed script to change:
- Fill mode (fill, fit, center, tile, stretch)
- Backend (hyprpaper, swww, swaybg, etc.)
- Other waypaper options

## Troubleshooting

### Wallpaper selector shows empty folder

**Solution:** Add wallpapers to the current theme's folder

```bash
# Check current theme
cat ~/.config/current-theme

# Add wallpapers
cp ~/Pictures/*.jpg ~/projects/theme-switcher/themes/$(cat ~/.config/current-theme)/wallpapers/
```

### Wallpaper doesn't change colors

**Solution:** The wallpaper selector UI is themed, not the wallpaper itself. The wallpaper image stays as-is.

### Super+Y doesn't work

**Solution:** Reload Hyprland

```bash
hyprctl reload
```

### Waypaper shows wrong folder

**Solution:** Run theme-switch again to update the current theme

```bash
theme-switch gruvbox-dark
```

## Backend: Hyprpaper

This system uses `hyprpaper` as the wallpaper backend. Hyprpaper features:
- Fast wallpaper loading
- Multiple monitor support
- Integrated with Hyprland
- No additional dependencies

### Hyprpaper Config

Located at `~/.config/hypr/hyprpaper.conf` (auto-managed by waypaper)

## Advanced Usage

### Automatic Wallpaper Restoration

Waypaper can restore your last wallpaper on login:

Add to your Hyprland startup:
```bash
exec-once = waypaper --restore
```

### Per-Monitor Wallpapers

Waypaper supports different wallpapers per monitor:
1. Open waypaper with Super+Y
2. Select monitor from dropdown
3. Choose wallpaper for that monitor
4. Repeat for other monitors

### Random Wallpaper

Set a random wallpaper from current theme:
```bash
waypaper --random --folder ~/projects/theme-switcher/themes/$(cat ~/.config/current-theme)/wallpapers/
```

## Tips

1. **Organize by Theme** - Keep theme-matching wallpapers in their respective theme folders
2. **Use Subfolders** - Waypaper supports subfolders; organize by category (landscapes, abstract, etc.)
3. **High Resolution** - Use wallpapers matching your monitor resolution for best quality
4. **GIF Support** - Animated wallpapers work with `swww` backend (optional)
5. **Quick Switch** - Use keyboard shortcuts in waypaper: `j/k` to navigate, Enter to select

## Implementation Details

### Waypaper Themed Script

The `waypaper-themed` script does:
1. Reads current theme from `~/.config/current-theme`
2. Sources pywal colors from `~/.cache/wal/colors.sh`
3. Generates CSS theme file with current colors
4. Updates waypaper config with theme folder and zen mode
5. Launches waypaper

### CSS Theme Generation

The script generates a complete GTK theme for waypaper including:
- Window background and foreground
- Header bar styling
- Button states (normal, hover)
- Dropdown menus
- Scrollbars
- Selected item highlighting
- Entry fields

### Integration with Theme Switcher

When you run `theme-switch`:
1. Theme is applied to all apps
2. Current theme name saved to `~/.config/current-theme`
3. Pywal colors generated
4. waypaper-themed can now use these to theme the wallpaper selector

## Next Steps

- Add wallpapers to your theme folders
- Try Super+Y to open the wallpaper selector
- Organize wallpapers by theme for a cohesive look

---

**Created:** 2025-12-01
**Status:** Fully implemented and tested ✅
