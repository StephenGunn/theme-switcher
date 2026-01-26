# Kvantum Qt Theming Guide

## Overview

Kvantum integration allows Qt applications (like Dolphin, Kate, Qt Creator) to match your theme automatically.

## Installation

### 1. Install Kvantum

```bash
# Install Kvantum for Qt5 and Qt6
yay -S kvantum
```

### 2. Install Theme Packages

```bash
# Catppuccin
yay -S kvantum-theme-catppuccin-git

# Gruvbox
yay -S kvantum-theme-gruvbox-git

# Nord uses built-in Kvantum themes
```

### 3. Set Qt to Use Kvantum

Add these environment variables to your shell config:

**For Fish (`~/.config/fish/config.fish`):**
```fish
# Qt theming with Kvantum
set -x QT_STYLE_OVERRIDE kvantum
```

**For Bash/Zsh (`~/.bashrc` or `~/.zshrc`):**
```bash
export QT_STYLE_OVERRIDE=kvantum
```

**For Hyprland (`~/dotfiles/.config/hypr/hyprland.conf`):**
```conf
env = QT_STYLE_OVERRIDE,kvantum
```

### 4. Reload Your Shell

```bash
# For Fish
exec fish

# For Bash
source ~/.bashrc
```

## How It Works

### Theme Mapping

When you switch themes, Kvantum is automatically configured:

- **Gruvbox Dark** → `Gruvbox-Dark`
- **Catppuccin Mocha** → `Catppuccin-Mocha`
- **Nord** → `KvArcDark` (built-in dark theme)

### Configuration File

theme-switch automatically updates `~/.config/Kvantum/kvantum.kvconfig`

## Usage

Just switch themes normally:

```bash
theme-switch gruvbox-dark
# Qt apps (Dolphin, etc.) now use Gruvbox theme

theme-switch catppuccin-mocha
# Qt apps now use Catppuccin theme
```

### Testing

Open a Qt application to see the theme:

```bash
# File manager
dolphin &

# Text editor
kate &

# Qt Creator (if installed)
qtcreator &
```

## Troubleshooting

### Dolphin/Qt apps don't change theme

**1. Check if Kvantum is installed:**
```bash
pacman -Qi kvantum
```

**2. Check if theme is installed:**
```bash
ls /usr/share/Kvantum/ | grep -i gruvbox
ls /usr/share/Kvantum/ | grep -i catppuccin
```

**3. Verify environment variable:**
```bash
echo $QT_STYLE_OVERRIDE
# Should output: kvantum
```

**4. Set environment variable:**

Add to `~/.config/hypr/hyprland.conf`:
```conf
env = QT_STYLE_OVERRIDE,kvantum
```

Then reload Hyprland: `hyprctl reload`

**5. Restart the Qt application:**
- Close Dolphin/Qt app completely
- Open it again
- Theme should now be applied

### Check current Kvantum theme

```bash
cat ~/.config/Kvantum/kvantum.kvconfig
```

Should show:
```ini
[General]
theme=Gruvbox-Dark
```

### Manually change Kvantum theme (testing)

```bash
# Launch Kvantum Manager
kvantummanager
```

Select theme → Apply → Close

## Available Kvantum Themes

### Installed with Kvantum

Built-in themes (always available):
- KvArc
- KvArcDark
- Kv Adaptable
- And more...

### Catppuccin Variants

```bash
yay -S kvantum-theme-catppuccin-git
```

Provides:
- Catppuccin-Mocha
- Catppuccin-Macchiato
- Catppuccin-Frappe
- Catppuccin-Latte

### Gruvbox Variants

```bash
yay -S kvantum-theme-gruvbox-git
```

Provides:
- Gruvbox-Dark
- Gruvbox-Light

## Technical Details

### Kvantum Configuration

File: `~/.config/Kvantum/kvantum.kvconfig`

```ini
[General]
theme=ThemeName
```

### Qt Environment Variables

- `QT_STYLE_OVERRIDE=kvantum` - Forces Qt to use Kvantum style
- `QT_QPA_PLATFORMTHEME=qt5ct` - Optional, for additional Qt5 settings

### Theme Locations

Kvantum themes are installed in:
- `/usr/share/Kvantum/` - System themes
- `~/.local/share/Kvantum/` - User themes

## Integration with theme-switcher

### What Happens When You Switch Themes

1. theme-switch reads `config.json`
2. Extracts Kvantum theme name
3. Updates `~/.config/Kvantum/kvantum.kvconfig`
4. Sets environment variables (for new apps)
5. Existing Qt apps need restart to see changes

### Adding Kvantum Support to New Themes

When creating a new theme, add the `kvantum` section:

```json
{
  "apps": {
    ...
    "kvantum": {
      "theme_name": "YourKvantumTheme",
      "note": "Install: yay -S kvantum your-kvantum-theme-package"
    }
  }
}
```

## Examples

### Gruvbox Setup

```bash
# Install theme
yay -S kvantum-theme-gruvbox-git

# Switch theme
theme-switch gruvbox-dark

# Restart Dolphin
killall dolphin && dolphin &
```

Result: Dolphin has warm, earthy Gruvbox colors

### Catppuccin Setup

```bash
# Install theme
yay -S kvantum-theme-catppuccin-git

# Switch theme
theme-switch catppuccin-mocha

# Restart Dolphin
killall dolphin && dolphin &
```

Result: Dolphin has soft, pastel Catppuccin colors

### Nord Setup

```bash
# No additional install needed (uses built-in theme)

# Switch theme
theme-switch nord

# Restart Dolphin
killall dolphin && dolphin &
```

Result: Dolphin has cool, arctic Nord colors

## Complete System Theming

With Kvantum + GTK theming, you now have:

✅ **GTK Apps** - File managers, settings, GNOME apps
✅ **Qt Apps** - Dolphin, Kate, Qt Creator, KDE apps
✅ **Neovim** - Editor
✅ **Ghostty** - Terminal
✅ **Hyprland** - Window manager
✅ **Rofi** - Launcher
✅ **All UI elements** match your theme!

---

**Status:** Fully integrated ✅
**Created:** 2025-12-01
**Works with:** Qt5 and Qt6 applications
**Requires:** `QT_STYLE_OVERRIDE=kvantum` environment variable
