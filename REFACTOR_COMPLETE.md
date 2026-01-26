# Theme Switcher v2.0 - Native Themes Refactor

## ✅ Refactor Complete!

The theme switcher has been completely refactored to use **native, official themes** wherever possible, with pywal as a fallback only for apps without native theme support.

---

## What Changed

### Old Architecture (v1.0)
```
Pywal generates everything from colors.json
   ↓
Templates create configs for all apps
   ↓
Everything uses pywal-generated colors (inconsistent quality)
```

**Problems:**
- Lost the polish of official themes
- wal.vim only worked with terminal colors (not GUI colors)
- Neovim bufferline had hardcoded Catppuccin colors
- Everything felt "generated" rather than intentional

### New Architecture (v2.0)
```
Each theme has config.json mapping to native implementations
   ↓
Native themes used for: Neovim, Ghostty, Hyprland, Hyprpanel, Rofi
   ↓
Pywal only used for: Starship, Dunst (no native support)
```

**Benefits:**
- ✅ Real colorscheme plugins in Neovim (gruvbox.nvim, catppuccin/nvim, nord.nvim)
- ✅ Lualine auto-detects theme from colorscheme
- ✅ Ghostty built-in themes (Fish inherits terminal colors)
- ✅ Native Hyprland color configs
- ✅ Polished Rofi themes
- ✅ Official Hyprpanel themes
- ✅ Pywal only where needed (Starship, Dunst)

---

## Files Created

### Theme Configs
```
themes/
├── gruvbox-dark/
│   ├── config.json                 # Theme mapping
│   ├── gruvbox-dark.conf           # Native Hyprland colors
│   ├── gruvbox-dark.rasi           # Native Rofi theme
│   ├── colors.json                 # Pywal fallback
│   └── hyprpanel.json              # Hyprpanel theme
├── catppuccin-mocha/
│   ├── config.json
│   ├── catppuccin-mocha.conf
│   ├── catppuccin-mocha.rasi
│   ├── colors.json
│   └── hyprpanel.json
└── nord/
    ├── config.json
    ├── nord.conf
    ├── nord.rasi
    ├── colors.json
    └── hyprpanel.json
```

### Neovim Plugins
```
~/.config/nvim/lua/plugins/
├── gruvbox.lua          # ellisonleao/gruvbox.nvim (NEW)
├── nord.lua             # shaunsingh/nord.nvim (NEW)
├── catppuccin.lua       # Re-enabled
├── wal.lua              # Disabled
├── lua-line.lua         # Updated to theme = "auto"
└── bufferline.lua       # Removed hardcoded colors
```

### Auto-generated Files
```
~/.config/nvim/lua/current-theme.lua    # Auto-set by theme-switch
~/.config/hypr/colors.conf              # Native theme colors
~/.config/rofi/theme.rasi               # Native Rofi theme
~/.config/ghostty/config                # theme = <native>
```

---

## How It Works

### 1. Theme Config Structure

Each theme has a `config.json`:

```json
{
  "name": "Gruvbox Dark",
  "apps": {
    "neovim": {
      "colorscheme": "gruvbox",
      "background": "dark"
    },
    "ghostty": {
      "theme": "Gruvbox Dark"
    },
    "hyprland": {
      "colors_file": "gruvbox-dark.conf"
    },
    // ... etc
  },
  "pywal": {
    "colors_file": "colors.json",
    "apps": ["starship", "dunst"]  // Only these use pywal
  }
}
```

### 2. Theme Switching Flow

```bash
./scripts/theme-switch gruvbox-dark
```

1. **Read config.json** for the theme
2. **Apply native themes:**
   - Neovim: Generate `~/.config/nvim/lua/current-theme.lua` with colorscheme command
   - Ghostty: Update `theme =` line in config
   - Hyprland: Copy native `.conf` file to `colors.conf`
   - Hyprpanel: Use built-in theme JSON
   - Rofi: Copy native `.rasi` file
3. **Apply pywal fallback:**
   - Only for apps listed in `pywal.apps` (Starship, Dunst)
   - Generate templates, copy to dotfiles
4. **Reload apps:**
   - Hyprland: `hyprctl reload`
   - Dunst: Restart daemon
   - Others: User restarts (Neovim, Ghostty)

### 3. Neovim Auto-Loading

On neovim startup (`init.lua:84-93`):
```lua
-- Load current theme (set by theme-switcher)
local theme_file = vim.fn.stdpath("config") .. "/lua/current-theme.lua"
if vim.fn.filereadable(theme_file) == 1 then
    require("current-theme")
end
```

The `current-theme.lua` file is auto-generated:
```lua
vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox")
```

This means **neovim always loads the correct colorscheme automatically**.

---

## Testing Results

### ✅ Gruvbox Dark
```bash
./scripts/theme-switch gruvbox-dark
```

**Results:**
- ✅ Neovim: Official gruvbox.nvim colorscheme
- ✅ Lualine: Gruvbox theme (auto-detected)
- ✅ Ghostty: Gruvbox Dark built-in theme
- ✅ Fish: Inherits Ghostty terminal colors
- ✅ Hyprland: Native Gruvbox color scheme
- ✅ Hyprpanel: Gruvbox theme
- ✅ Rofi: Native Gruvbox theme
- ✅ Starship: Pywal-generated (warm earth tones)
- ✅ Dunst: Pywal-generated

### ✅ Catppuccin Mocha
```bash
./scripts/theme-switch catppuccin-mocha
```

**Results:**
- ✅ Neovim: Official catppuccin/nvim (mocha flavor)
- ✅ Lualine: Catppuccin theme
- ✅ Ghostty: Catppuccin Mocha built-in
- ✅ Fish: Inherits pastel terminal colors
- ✅ Hyprland: Native Catppuccin config
- ✅ All other apps: Working perfectly

### ✅ Nord
```bash
./scripts/theme-switch nord
```

**Results:**
- ✅ Neovim: Official nord.nvim colorscheme
- ✅ Lualine: Nord theme
- ✅ Ghostty: Nord built-in theme
- ✅ All apps themed correctly

---

## App-by-App Breakdown

| App | Method | Source | Quality |
|-----|--------|--------|---------|
| **Neovim** | Native colorscheme | gruvbox.nvim, catppuccin/nvim, nord.nvim | ⭐⭐⭐⭐⭐ Official |
| **Lualine** | Auto-detect | From neovim colorscheme | ⭐⭐⭐⭐⭐ Auto |
| **Bufferline** | Auto-detect | From neovim colorscheme | ⭐⭐⭐⭐⭐ Auto |
| **Ghostty** | Built-in theme | Ghostty themes | ⭐⭐⭐⭐⭐ Official |
| **Fish** | Terminal colors | Inherits from Ghostty | ⭐⭐⭐⭐⭐ Auto |
| **Hyprland** | Native config | Hand-crafted .conf | ⭐⭐⭐⭐⭐ Native |
| **Hyprpanel** | Built-in theme | Official JSON | ⭐⭐⭐⭐⭐ Official |
| **Rofi** | Native theme | Hand-crafted .rasi | ⭐⭐⭐⭐⭐ Native |
| **Starship** | Pywal template | Generated | ⭐⭐⭐⭐ Good |
| **Dunst** | Pywal template | Generated | ⭐⭐⭐⭐ Good |

**Result:** 80% native themes, 20% pywal fallback

---

## Dependencies

### Required
- `jq` - JSON parsing for config files
- `wal` (pywal) - For Starship/Dunst generation
- `hyprctl` - Hyprland control
- `rofi` - Launcher (for theme selection menu)

### Installation
```bash
sudo pacman -S jq python-pywal hyprland rofi
```

---

## Usage

### Switch Themes
```bash
# Interactive menu
./scripts/theme-switch

# Direct theme name
./scripts/theme-switch gruvbox-dark
./scripts/theme-switch catppuccin-mocha
./scripts/theme-switch nord
```

### After Switching
1. **Ghostty**: Ctrl+Shift+, to reload config
2. **Neovim**: Restart nvim (theme auto-loads)
3. **Fish**: Already themed via Ghostty
4. **Hyprland**: Auto-reloaded
5. **Rofi**: Next launch uses new theme
6. **Hyprpanel**: Already reloaded

---

## Adding New Themes

### 1. Create Theme Directory
```bash
mkdir -p themes/tokyo-night
```

### 2. Create config.json
```json
{
  "name": "Tokyo Night",
  "apps": {
    "neovim": {
      "colorscheme": "tokyonight",
      "background": "dark"
    },
    "ghostty": {
      "theme": "Tokyo Night"
    },
    "hyprland": {
      "colors_file": "tokyo-night.conf"
    },
    "hyprpanel": {
      "theme_file": "hyprpanel.json"
    },
    "rofi": {
      "theme_file": "tokyo-night.rasi"
    }
  },
  "pywal": {
    "colors_file": "colors.json",
    "apps": ["starship", "dunst"]
  }
}
```

### 3. Create Native Theme Files
- `tokyo-night.conf` - Hyprland colors
- `tokyo-night.rasi` - Rofi theme
- `hyprpanel.json` - Hyprpanel theme (or use built-in)
- `colors.json` - Pywal colors for Starship/Dunst

### 4. Add Neovim Plugin (if needed)
```lua
-- ~/.config/nvim/lua/plugins/tokyonight.lua
return {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = true,
}
```

### 5. Test
```bash
./scripts/theme-switch tokyo-night
```

---

## Troubleshooting

### Neovim: Theme not loading
**Check:**
```bash
cat ~/.config/nvim/lua/current-theme.lua
```

Should show:
```lua
vim.cmd.colorscheme("gruvbox")  # or whatever theme
```

**Fix:** Re-run theme-switch

### Hyprland: Colors not applying
**Check:**
```bash
ls -la ~/.config/hypr/colors.conf
```

Should be a **regular file**, not a symlink to pywal.

**Fix:**
```bash
rm ~/.config/hypr/colors.conf
./scripts/theme-switch gruvbox-dark
```

### Fish: Colors not changing
**This is normal!** Fish inherits colors from Ghostty terminal.

**Check Ghostty:**
```bash
grep "^theme" ~/.config/ghostty/config
```

Should show the correct theme.

---

## Comparison: Before vs After

### Before (v1.0 with wal.vim)
- ❌ Neovim showed default colors (termguicolors conflict)
- ❌ Bufferline always pink/purple (hardcoded Catppuccin)
- ❌ Everything felt "generated"
- ❌ Lost polish of official themes
- ⚠️ Fish colors required manual reload

### After (v2.0 with native themes)
- ✅ Neovim uses official colorscheme plugins
- ✅ Bufferline automatically matches theme
- ✅ Everything looks intentional and polished
- ✅ Official themes look exactly as designed
- ✅ Fish inherits from terminal (no reload needed)

---

## Next Steps (Optional Enhancements)

### 1. More Themes
- [ ] Tokyo Night
- [ ] Dracula
- [ ] Solarized Dark
- [ ] One Dark
- [ ] Ayu Dark

### 2. Wallpaper Integration
Add to config.json:
```json
{
  "wallpaper": {
    "main": "wallpapers/gruvbox-mountain.png",
    "vertical": "wallpapers/gruvbox-forest.png"
  }
}
```

Update theme-switch to set wallpapers via `swww` or `hyprpaper`.

### 3. Hyprland Keybind
Add to `hyprland.conf`:
```conf
bind = $mainMod, T, exec, theme-switch
```

### 4. Theme Preview
Generate screenshots of each theme for the selection menu.

---

## Conclusion

**The refactor is complete and working perfectly!**

✅ Native themes for all major apps
✅ Fish inherits from terminal (no special handling)
✅ Lualine auto-detects (no hardcoding)
✅ Pywal only used where necessary
✅ Clean, maintainable architecture
✅ Easy to add new themes

**Result:** A polished, cohesive theming system that respects the original design of each theme while maintaining consistency across all applications.

---

**Date:** 2025-11-30
**Version:** 2.0
**Status:** Production Ready ✅
