# GTK Theming Guide

## Overview

GTK theming is now integrated into the theme-switcher! When you switch themes, GTK apps (file managers, settings, etc.) will automatically match your theme.

## Installation

### Required GTK Themes

Install the GTK themes for the themes you want to use:

```bash
# Catppuccin Mocha (already installed)
yay -S catppuccin-gtk-theme-mocha

# Gruvbox Dark
yay -S colloid-gruvbox-gtk-theme-git

# Nord
yay -S nordic-theme
```

## How It Works

### What Gets Themed

- **GTK2 Apps** - Older GTK applications
- **GTK3 Apps** - Most modern Linux apps (file managers, settings)
- **GTK4 Apps** - Latest GTK apps (GNOME apps)

### Theme Mapping

Each theme in the system specifies its GTK theme:

**Gruvbox Dark** → `Gruvbox-Dark-BL`
**Catppuccin Mocha** → `Catppuccin-Mocha-Standard-Rosewater-Dark`
**Nord** → `Nordic`

### Configuration Files Updated

When you switch themes, these files are automatically updated:

- `~/.config/gtk-3.0/settings.ini` - GTK3 settings
- `~/.config/gtk-4.0/settings.ini` - GTK4 settings
- `~/.gtkrc-2.0` - GTK2 settings

### Settings Applied

For each GTK version, the script sets:
- **Theme Name** - Main GTK theme
- **Icon Theme** - Icon set (breeze-dark)
- **Cursor Theme** - Mouse cursor (Bibata-Modern-Ice)
- **Font** - System font
- **Animations** - Enabled
- **Dark Mode** - Enabled (GTK3)

## Usage

Just switch themes as normal:

```bash
theme-switch gruvbox-dark
# GTK apps now use Gruvbox theme

theme-switch catppuccin-mocha
# GTK apps now use Catppuccin theme
```

### Testing GTK Theming

Open a GTK app to see the theme:

```bash
# File manager
nautilus &

# System settings
gnome-control-center &

# Text editor
gedit &
```

## Adding GTK Support to New Themes

When creating a new theme, add the `gtk` section to `config.json`:

```json
{
  "apps": {
    ...
    "gtk": {
      "theme_name": "YourGTKThemeName",
      "icon_theme": "breeze-dark",
      "cursor_theme": "Bibata-Modern-Ice",
      "note": "Install: yay -S your-gtk-theme-package"
    }
  }
}
```

## Troubleshooting

### Theme doesn't change

**Check if GTK theme is installed:**
```bash
ls /usr/share/themes/ | grep -i gruvbox
ls /usr/share/themes/ | grep -i catppuccin
ls /usr/share/themes/ | grep -i nordic
```

**Install missing themes:**
```bash
yay -S colloid-gruvbox-gtk-theme-git
yay -S catppuccin-gtk-theme-mocha
yay -S nordic-theme
```

### Apps still show old theme

**Restart the application:**
- Close and reopen the GTK app
- Some apps need a full restart to pick up new themes

**Check settings file:**
```bash
cat ~/.config/gtk-3.0/settings.ini
```

Should show the correct theme name.

### Want a different icon theme

Edit your theme's `config.json`:
```json
"gtk": {
  "theme_name": "Gruvbox-Dark-BL",
  "icon_theme": "Papirus-Dark",  # Change this
  "cursor_theme": "Bibata-Modern-Ice"
}
```

Then run `theme-switch` again.

## Available GTK Themes

### Catppuccin Variants

```bash
# All 4 Catppuccin flavors available
yay -S catppuccin-gtk-theme-mocha      # Dark, warm
yay -S catppuccin-gtk-theme-macchiato  # Dark, cool
yay -S catppuccin-gtk-theme-frappe     # Medium dark
yay -S catppuccin-gtk-theme-latte      # Light
```

### Gruvbox Variants

```bash
# Colloid theme with Gruvbox colors
yay -S colloid-gruvbox-gtk-theme-git

# Better Gruvbox (alternative)
yay -S bettergruvbox-gtk-theme

# Earthy (Nordic + Gruvbox mix)
yay -S earthy-gtk-theme-git
```

### Nord Variants

```bash
# Official Nordic theme
yay -S nordic-theme

# Nordic with different variants
# Includes Nordic, Nordic-darker, Nordic-bluish
```

## Technical Details

### GTK Settings Applied

**GTK-3.0 and GTK-4.0:**
- Theme name
- Icon theme
- Cursor theme and size (28px)
- Font (Noto Sans, 10pt)
- Dark mode preference (GTK-3 only)
- Animations enabled
- Button/menu image settings
- XFT DPI (122880 = 1.25x scaling)

**GTK-2.0:**
- Theme name
- Icon theme
- Cursor theme and size
- Toolbar style
- Menu and button images

### Configuration Priority

GTK apps read settings in this order:
1. `~/.config/gtk-4.0/settings.ini` (GTK4 apps)
2. `~/.config/gtk-3.0/settings.ini` (GTK3 apps)
3. `~/.gtkrc-2.0` (GTK2 apps)

The theme-switch script updates all three to ensure consistency.

## Integration with Other Components

### Works With

- **Neovim** - Editor uses its own native themes
- **Ghostty** - Terminal uses its own themes
- **Hyprland** - Window manager has separate color config
- **Rofi** - Launcher has separate theme files
- **Waypaper** - Uses GTK, will match theme automatically

### Waypaper Integration

Since waypaper is a GTK app, it will automatically use the GTK theme!

However, we also generate custom CSS for waypaper to ensure perfect color matching with pywal colors.

## Examples

### Switching to Gruvbox

```bash
theme-switch gruvbox-dark
```

Result:
- GTK apps use `Gruvbox-Dark-BL` theme
- Warm, earthy brown colors
- Orange/yellow accents
- Dark background

### Switching to Catppuccin

```bash
theme-switch catppuccin-mocha
```

Result:
- GTK apps use `Catppuccin-Mocha-Standard-Rosewater-Dark` theme
- Soft pastel colors
- Pink/lavender accents
- Dark background

### Switching to Nord

```bash
theme-switch nord
```

Result:
- GTK apps use `Nordic` theme
- Cool blue/arctic colors
- Blue/teal accents
- Dark background

---

**Status:** Fully integrated ✅
**Created:** 2025-12-01
**Works with:** GTK2, GTK3, GTK4 applications
