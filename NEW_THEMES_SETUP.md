# New Themes Setup - Kanagawa, Everforest, Tokyo Night

## Quick Summary

I've started setting up three new themes for your theme-switcher:
1. ✅ **Kanagawa Dark** - COMPLETE (needs wallpapers)
2. ⏳ **Everforest** - IN PROGRESS (you got called away)
3. ⏳ **Tokyo Night** - PENDING

## Install Commands

### GTK Themes (Required for Thunar theming)

```bash
# Existing themes (install these first!)
yay -S colloid-gruvbox-gtk-theme-git catppuccin-gtk-theme-mocha nordic-theme

# New themes
yay -S kanagawa-gtk-theme-git colloid-everforest-gtk-theme-git tokyonight-gtk-theme-git
```

### Install All At Once
```bash
yay -S colloid-gruvbox-gtk-theme-git catppuccin-gtk-theme-mocha nordic-theme kanagawa-gtk-theme-git colloid-everforest-gtk-theme-git tokyonight-gtk-theme-git
```

## What's Been Completed

### Kanagawa Dark ✅
**Location**: `~/projects/theme-switcher/themes/kanagawa-dark/`

**Files created:**
- ✅ `config.json` - Theme configuration
- ✅ `colors.json` - Pywal colors (16 color palette)
- ✅ `kanagawa-dark.conf` - Hyprland colors
- ✅ `kanagawa-dark.rasi` - Rofi theme
- ✅ `hyprpanel.json` - HyprPanel colors (simplified)
- ✅ `wallpapers/placeholder.png` - Temporary wallpaper (replace with your own!)

**Color Palette:**
- Background: `#1f1f28`
- Foreground: `#dcd7ba`
- Blue (primary): `#7e9cd8`
- Red: `#c34043`
- Green: `#98bb6b`
- Yellow: `#c0a36e`
- Purple: `#957fb8`
- Cyan: `#7fb4ca`

**Applications:**
- Neovim: `kanagawa` colorscheme
- Ghostty: `Kanagawa` theme
- GTK: `Kanagawa-BL` (install with: `yay -S kanagawa-gtk-theme-git`)
- Yazi: `kanagawa` flavor

### Everforest ⏳
**Status:** NOT YET CREATED
**Todo:** Create all config files with Everforest colors

**Official Colors to use:**
- Background: `#2b3339`
- Foreground: `#d3c6aa`
- Green (primary): `#a7c080`
- Red: `#e67e80`
- Yellow: `#dbbc7f`
- Blue: `#7fbbb3`
- Purple: `#d699b6`
- Aqua: `#83c092`

### Tokyo Night ⏳
**Status:** NOT YET CREATED
**Todo:** Create all config files with Tokyo Night colors

**Official Colors to use:**
- Background: `#1a1b26`
- Foreground: `#c0caf5`
- Blue (primary): `#7aa2f7`
- Red: `#f7768e`
- Green: `#9ece6a`
- Yellow: `#e0af68`
- Purple: `#bb9af7`
- Cyan: `#7dcfff`

## What You Need To Do

### 1. Install GTK Themes
Run the install command above to get all GTK themes installed. This will make Thunar properly themed!

### 2. Add Wallpapers
Replace the placeholder wallpapers with your chosen backgrounds:

```bash
# Kanagawa Dark
cp /path/to/your/kanagawa-wallpapers/* ~/projects/theme-switcher/themes/kanagawa-dark/wallpapers/

# Everforest (when created)
cp /path/to/your/everforest-wallpapers/* ~/projects/theme-switcher/themes/everforest/wallpapers/

# Tokyo Night (when created)
cp /path/to/your/tokyo-night-wallpapers/* ~/projects/theme-switcher/themes/tokyo-night/wallpapers/
```

### 3. Let Me Know
When you're back, I can:
- Finish creating Everforest and Tokyo Night themes
- Help you test all themes
- Fix any issues with Thunar theming
- Create more detailed HyprPanel configs if needed

## Testing Kanagawa

Once you install `kanagawa-gtk-theme-git`, you can test the Kanagawa theme:

```bash
# Switch to Kanagawa theme
theme-switch kanagawa-dark

# Check Thunar
thunar  # Should use Kanagawa GTK theme

# Check other apps
# - Hyprland: Border colors should be blue (#7e9cd8)
# - Rofi: Should have dark bg with blue accents
# - HyprPanel: Should update colors
```

## File Structure

Each theme needs these files:

```
theme-name/
├── config.json           # Main theme config
├── colors.json           # Pywal 16-color palette
├── theme-name.conf       # Hyprland colors
├── theme-name.rasi       # Rofi theme
├── hyprpanel.json        # HyprPanel colors
└── wallpapers/
    └── *.jpg/png         # Your wallpapers
```

## Next Steps (When You Return)

1. Install all GTK themes
2. Test Kanagawa theme
3. Let me know if Thunar theming works
4. I'll complete Everforest and Tokyo Night
5. You add wallpapers
6. Test all three themes!

## GTK Theme Names Reference

When the themes are installed, use these names in the theme configs:

- **Kanagawa**: `Kanagawa-BL` or `Kanagawa-B` or just `Kanagawa`
- **Everforest**: `Colloid-Everforest-Dark` or similar (check after install)
- **Tokyo Night**: `Tokyonight-Dark` or similar (check after install)

To check installed theme names:
```bash
ls /usr/share/themes/
```

## Current Theme Switcher Status

Your theme-switcher already handles:
- ✅ Neovim colorschemes
- ✅ Ghostty themes
- ✅ Hyprland colors
- ✅ HyprPanel themes
- ✅ Rofi themes
- ✅ GTK themes (Thunar!)
- ✅ Kvantum themes (Qt apps)
- ✅ Yazi flavors
- ✅ Pywal for fallback apps

All we need is:
1. Install the GTK theme packages
2. Create the theme configs
3. Add wallpapers

That's it!
