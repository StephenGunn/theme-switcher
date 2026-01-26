# Adding New Themes - Complete Guide

This document provides **exact, step-by-step instructions** for adding new themes to the theme switcher.

---

## Table of Contents

1. [Quick Checklist](#quick-checklist)
2. [Detailed Step-by-Step Guide](#detailed-step-by-step-guide)
3. [File Templates](#file-templates)
4. [Example: Adding Tokyo Night](#example-adding-tokyo-night)
5. [Testing Checklist](#testing-checklist)
6. [Troubleshooting](#troubleshooting)

---

## Quick Checklist

For each new theme, you need to create:

- [ ] Theme directory: `themes/<theme-name>/`
- [ ] `config.json` - Theme configuration mapping
- [ ] `<theme-name>.conf` - Hyprland colors
- [ ] `<theme-name>.rasi` - Rofi theme
- [ ] `hyprpanel.json` - Hyprpanel theme (or use existing)
- [ ] `colors.json` - Pywal colors for Starship/Dunst
- [ ] Neovim plugin (if not already installed)
- [ ] Test with `./scripts/theme-switch <theme-name>`

---

## Detailed Step-by-Step Guide

### Step 1: Research the Theme

Before starting, gather information about your theme:

**Questions to answer:**
1. What is the theme's official name?
2. Does it have an official neovim plugin?
3. Does Ghostty have it built-in? (Check: `ghostty +list-themes | grep <name>`)
4. Does Hyprpanel have it? (Check: `ls /usr/share/hyprpanel/themes/`)
5. What are the exact color codes (16 colors + special)?

**Resources:**
- Theme's official GitHub repository
- [terminal.sexy](https://terminal.sexy/) - Color scheme generator
- [Catppuccin ports](https://github.com/catppuccin/catppuccin#-ports-and-more) - For inspiration
- Existing theme repositories

---

### Step 2: Create Theme Directory

```bash
cd ~/projects/theme-switcher
mkdir -p themes/<theme-name>
```

**Naming convention:**
- Use lowercase
- Use hyphens for spaces
- Examples: `tokyo-night`, `dracula`, `one-dark`, `solarized-dark`

---

### Step 3: Create config.json

This is the **most important file**. It maps the theme to native implementations.

**File:** `themes/<theme-name>/config.json`

```json
{
  "name": "Theme Display Name",
  "description": "Brief description of the theme",
  "apps": {
    "neovim": {
      "colorscheme": "neovim-colorscheme-name",
      "background": "dark"
    },
    "lualine": {
      "theme": "lualine-theme-name"
    },
    "ghostty": {
      "theme": "Ghostty Theme Name"
    },
    "hyprland": {
      "colors_file": "theme-name.conf"
    },
    "hyprpanel": {
      "theme_file": "hyprpanel.json"
    },
    "rofi": {
      "theme_file": "theme-name.rasi"
    }
  },
  "pywal": {
    "colors_file": "colors.json",
    "apps": ["starship", "dunst"]
  }
}
```

**Field Details:**

| Field | Value | How to Find |
|-------|-------|-------------|
| `neovim.colorscheme` | Plugin command name | Check plugin docs (e.g., `:colorscheme tokyonight`) |
| `neovim.background` | `"dark"` or `"light"` | Theme variant |
| `neovim.flavor` | Variant name (optional) | For themes with flavors like Catppuccin |
| `lualine.theme` | Lualine theme name | Usually same as colorscheme, check lualine docs |
| `ghostty.theme` | Exact Ghostty theme name | Run: `ghostty +list-themes \| grep <name>` |
| `hyprland.colors_file` | `<theme-name>.conf` | File you'll create in step 4 |
| `rofi.theme_file` | `<theme-name>.rasi` | File you'll create in step 5 |
| `hyprpanel.theme_file` | `hyprpanel.json` | File you'll create in step 6 |

**Notes:**
- If Ghostty doesn't have the theme built-in, you'll need to create a custom Ghostty theme file
- If lualine doesn't have a matching theme, you can use `"auto"` or a similar theme

---

### Step 4: Create Hyprland Colors

**File:** `themes/<theme-name>/<theme-name>.conf`

**Requirements:**
- Define all 16 terminal colors (color0-color15)
- Define `$background` and `$foreground`
- **MUST define `$teal` and `$surface2`** (required by hyprland.conf)
- Optionally define theme-specific accent colors

**Template:**

```conf
# <Theme Name> theme for Hyprland
# <Official theme URL>

$background = rgb(XXXXXX)  # Main background color
$foreground = rgb(XXXXXX)  # Main foreground/text color

# Normal colors (color0-color7)
$color0 = rgb(XXXXXX)  # black
$color1 = rgb(XXXXXX)  # red
$color2 = rgb(XXXXXX)  # green
$color3 = rgb(XXXXXX)  # yellow
$color4 = rgb(XXXXXX)  # blue
$color5 = rgb(XXXXXX)  # magenta
$color6 = rgb(XXXXXX)  # cyan
$color7 = rgb(XXXXXX)  # white

# Bright colors (color8-color15)
$color8 = rgb(XXXXXX)   # bright black (gray)
$color9 = rgb(XXXXXX)   # bright red
$color10 = rgb(XXXXXX)  # bright green
$color11 = rgb(XXXXXX)  # bright yellow
$color12 = rgb(XXXXXX)  # bright blue
$color13 = rgb(XXXXXX)  # bright magenta
$color14 = rgb(XXXXXX)  # bright cyan
$color15 = rgb(XXXXXX)  # bright white

# Optional: Theme-specific accent colors
$accent1 = rgb(XXXXXX)
$accent2 = rgb(XXXXXX)

# REQUIRED: Variables expected by hyprland.conf
$teal = rgb(XXXXXX)      # Use cyan/teal color from theme
$surface2 = rgb(XXXXXX)  # Use a darker surface/background variant
```

**How to get colors:**
1. Check theme's official repository (usually has a colors.yml or palette file)
2. Look at existing terminal emulator configs (Alacritty, Kitty, etc.)
3. Use a tool to extract colors from screenshots

**Important:**
- Remove the `#` from hex colors (use `XXXXXX` not `#XXXXXX`)
- Use `rgb(XXXXXX)` format for Hyprland
- `$teal` is used for active window borders - pick a nice accent color
- `$surface2` is used for inactive borders - pick a subtle background shade

---

### Step 5: Create Rofi Theme

**File:** `themes/<theme-name>/<theme-name>.rasi`

**Template:**

```rasi
/**
 * <Theme Name> theme for Rofi
 */

* {
    bg: #XXXXXX;        /* Background */
    bg-alt: #XXXXXX;    /* Alternate background (slightly different) */
    fg: #XXXXXX;        /* Foreground text */
    fg-alt: #XXXXXX;    /* Dimmed foreground */

    /* Theme accent colors */
    red: #XXXXXX;
    green: #XXXXXX;
    yellow: #XXXXXX;
    blue: #XXXXXX;
    purple: #XXXXXX;
    cyan: #XXXXXX;

    background-color: transparent;
    text-color: @fg;
}

window {
    background-color: @bg;
    border: 2px;
    border-color: @blue;  /* Use main accent color */
    padding: 10px;
}

mainbox {
    background-color: transparent;
    children: [inputbar, listview];
}

inputbar {
    background-color: @bg-alt;
    padding: 10px;
    children: [prompt, entry];
}

prompt {
    background-color: transparent;
    text-color: @blue;  /* Match window border */
    padding: 0 10px 0 0;
}

entry {
    background-color: transparent;
    text-color: @fg;
}

listview {
    background-color: transparent;
    padding: 10px 0 0 0;
    lines: 10;
}

element {
    background-color: transparent;
    text-color: @fg-alt;
    padding: 5px;
}

element selected {
    background-color: @bg-alt;
    text-color: @blue;  /* Match accent color */
}
```

**Customization tips:**
- Use `bg` for main background
- Use `bg-alt` for input bar and selected items (should be slightly lighter/darker)
- Pick an accent color for borders, prompt, and selection (usually blue, cyan, or purple)
- Keep it simple - Rofi theming can get complex

---

### Step 6: Create or Copy Hyprpanel Theme

**Option A: Use Existing Hyprpanel Theme**

Check if Hyprpanel already has your theme:

```bash
ls /usr/share/hyprpanel/themes/
```

If it exists (e.g., `tokyo_night.json`):

```bash
cp /usr/share/hyprpanel/themes/tokyo_night.json themes/<theme-name>/hyprpanel.json
```

**Option B: Create Custom Hyprpanel Theme**

**File:** `themes/<theme-name>/hyprpanel.json`

This is complex. **Best approach:** Copy an existing theme and modify colors:

```bash
cp themes/catppuccin-mocha/hyprpanel.json themes/<theme-name>/hyprpanel.json
```

Then edit the JSON to replace colors. Key fields:
- `theme.bar.background`
- `theme.bar.buttons.*`
- Look for hex colors and replace them with your theme's colors

**Note:** Hyprpanel themes are large JSON files. It's easiest to copy and modify rather than create from scratch.

---

### Step 7: Create Pywal Colors (for Starship/Dunst)

**File:** `themes/<theme-name>/colors.json`

This file is used **only** for Starship prompt and Dunst notifications (apps without native themes).

**Template:**

```json
{
    "special": {
        "background": "#XXXXXX",
        "foreground": "#XXXXXX",
        "cursor": "#XXXXXX"
    },
    "colors": {
        "color0": "#XXXXXX",
        "color1": "#XXXXXX",
        "color2": "#XXXXXX",
        "color3": "#XXXXXX",
        "color4": "#XXXXXX",
        "color5": "#XXXXXX",
        "color6": "#XXXXXX",
        "color7": "#XXXXXX",
        "color8": "#XXXXXX",
        "color9": "#XXXXXX",
        "color10": "#XXXXXX",
        "color11": "#XXXXXX",
        "color12": "#XXXXXX",
        "color13": "#XXXXXX",
        "color14": "#XXXXXX",
        "color15": "#XXXXXX"
    }
}
```

**Important:**
- **Keep the `#` in hex colors** for pywal (unlike Hyprland)
- Use the same 16 colors as your Hyprland config
- Cursor color is usually same as foreground

**Quick method:**
Copy from an existing theme and replace colors:

```bash
cp themes/gruvbox-dark/colors.json themes/<theme-name>/colors.json
# Then edit the colors
```

---

### Step 8: Install Neovim Plugin (if needed)

If the theme doesn't have a neovim plugin already installed, create the plugin file.

**File:** `~/dotfiles/.config/nvim/lua/plugins/<theme-name>.lua`

**Template:**

```lua
return {
    "<author>/<plugin-name>",
    priority = 1000,
    enabled = true,
    config = function()
        -- Theme-specific setup if needed
        require("<plugin-name>").setup({
            -- Options here
        })
    end,
}
```

**Examples:**

```lua
-- Tokyo Night
return {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = true,
}

-- Dracula
return {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    enabled = true,
}

-- One Dark
return {
    "navarasu/onedark.nvim",
    priority = 1000,
    enabled = true,
    config = function()
        require('onedark').setup({
            style = 'darker'
        })
    end,
}
```

**How to find the plugin:**
1. Search GitHub: "neovim <theme-name> colorscheme"
2. Check [awesome-neovim colorschemes](https://github.com/rockerBOO/awesome-neovim#colorscheme)
3. Look at the plugin's README for configuration options

---

### Step 9: Test the Theme

```bash
./scripts/theme-switch <theme-name>
```

**Expected output:**

```
[INFO] Theme Switcher v2.0 (Native Themes)
[INFO] Applying theme: <theme-name>
[SUCCESS] Neovim colorscheme configured: <colorscheme>
[SUCCESS] Ghostty theme applied
[SUCCESS] Hyprland colors applied
[SUCCESS] Hyprpanel theme applied
[SUCCESS] Rofi theme applied
[SUCCESS] Updated Starship colors
[SUCCESS] Linked Dunst config
[SUCCESS] Pywal colors applied
[SUCCESS] Reloaded Hyprland
[SUCCESS] Theme '<theme-name>' applied successfully!
```

**If you see errors, check:**
- [ ] `config.json` is valid JSON (use `jq . < config.json`)
- [ ] All file paths in config.json match actual files
- [ ] Ghostty theme name is exact (case-sensitive)
- [ ] Neovim plugin is installed
- [ ] Hyprland config has `$teal` and `$surface2` defined

---

## File Templates

### Minimal Theme Structure

```
themes/<theme-name>/
├── config.json           # REQUIRED: Theme mapping
├── <theme-name>.conf     # REQUIRED: Hyprland colors
├── <theme-name>.rasi     # REQUIRED: Rofi theme
├── hyprpanel.json        # REQUIRED: Hyprpanel theme
└── colors.json           # REQUIRED: Pywal colors
```

### Quick Copy Command

To start a new theme based on an existing one:

```bash
# Copy entire theme directory
cp -r themes/gruvbox-dark themes/<new-theme-name>

# Rename files
cd themes/<new-theme-name>
mv gruvbox-dark.conf <new-theme-name>.conf
mv gruvbox-dark.rasi <new-theme-name>.rasi

# Edit config.json and replace colors in all files
```

---

## Example: Adding Tokyo Night

Let's walk through adding the Tokyo Night theme completely.

### Step 1: Create Directory

```bash
cd ~/projects/theme-switcher
mkdir -p themes/tokyo-night
```

### Step 2: Check Ghostty Theme

```bash
ghostty +list-themes | grep -i tokyo
# Output: Tokyo Night
# ✅ Ghostty has it built-in!
```

### Step 3: Check Hyprpanel

```bash
ls /usr/share/hyprpanel/themes/ | grep -i tokyo
# Output: tokyo_night.json
# ✅ Hyprpanel has it!
```

### Step 4: Check Neovim Plugin

Search GitHub: "neovim tokyo night"
Found: `folke/tokyonight.nvim`

### Step 5: Create config.json

```bash
cat > themes/tokyo-night/config.json <<'EOF'
{
  "name": "Tokyo Night",
  "description": "A dark and modern theme with vibrant colors",
  "apps": {
    "neovim": {
      "colorscheme": "tokyonight",
      "background": "dark"
    },
    "lualine": {
      "theme": "tokyonight"
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
EOF
```

### Step 6: Create Hyprland Colors

Tokyo Night colors (from official repo):

```bash
cat > themes/tokyo-night/tokyo-night.conf <<'EOF'
# Tokyo Night theme for Hyprland
# https://github.com/folke/tokyonight.nvim

$background = rgb(1a1b26)
$foreground = rgb(c0caf5)

# Normal colors
$color0 = rgb(15161e)  # black
$color1 = rgb(f7768e)  # red
$color2 = rgb(9ece6a)  # green
$color3 = rgb(e0af68)  # yellow
$color4 = rgb(7aa2f7)  # blue
$color5 = rgb(bb9af7)  # magenta
$color6 = rgb(7dcfff)  # cyan
$color7 = rgb(a9b1d6)  # white

# Bright colors
$color8 = rgb(414868)  # bright black
$color9 = rgb(f7768e)  # bright red
$color10 = rgb(9ece6a) # bright green
$color11 = rgb(e0af68) # bright yellow
$color12 = rgb(7aa2f7) # bright blue
$color13 = rgb(bb9af7) # bright magenta
$color14 = rgb(7dcfff) # bright cyan
$color15 = rgb(c0caf5) # bright white

# Tokyo Night accent colors
$blue = rgb(7aa2f7)
$cyan = rgb(7dcfff)
$purple = rgb(bb9af7)
$red = rgb(f7768e)

# REQUIRED: Variables for hyprland.conf
$teal = rgb(7dcfff)     # Use cyan for teal
$surface2 = rgb(1f2335) # Darker background variant
EOF
```

### Step 7: Create Rofi Theme

```bash
cat > themes/tokyo-night/tokyo-night.rasi <<'EOF'
/**
 * Tokyo Night theme for Rofi
 */

* {
    bg: #1a1b26;
    bg-alt: #24283b;
    fg: #c0caf5;
    fg-alt: #a9b1d6;

    red: #f7768e;
    green: #9ece6a;
    yellow: #e0af68;
    blue: #7aa2f7;
    purple: #bb9af7;
    cyan: #7dcfff;

    background-color: transparent;
    text-color: @fg;
}

window {
    background-color: @bg;
    border: 2px;
    border-color: @blue;
    padding: 10px;
}

mainbox {
    background-color: transparent;
    children: [inputbar, listview];
}

inputbar {
    background-color: @bg-alt;
    padding: 10px;
    children: [prompt, entry];
}

prompt {
    background-color: transparent;
    text-color: @blue;
    padding: 0 10px 0 0;
}

entry {
    background-color: transparent;
    text-color: @fg;
}

listview {
    background-color: transparent;
    padding: 10px 0 0 0;
    lines: 10;
}

element {
    background-color: transparent;
    text-color: @fg-alt;
    padding: 5px;
}

element selected {
    background-color: @bg-alt;
    text-color: @blue;
}
EOF
```

### Step 8: Copy Hyprpanel Theme

```bash
cp /usr/share/hyprpanel/themes/tokyo_night.json themes/tokyo-night/hyprpanel.json
```

### Step 9: Create Pywal Colors

```bash
cat > themes/tokyo-night/colors.json <<'EOF'
{
    "special": {
        "background": "#1a1b26",
        "foreground": "#c0caf5",
        "cursor": "#c0caf5"
    },
    "colors": {
        "color0": "#15161e",
        "color1": "#f7768e",
        "color2": "#9ece6a",
        "color3": "#e0af68",
        "color4": "#7aa2f7",
        "color5": "#bb9af7",
        "color6": "#7dcfff",
        "color7": "#a9b1d6",
        "color8": "#414868",
        "color9": "#f7768e",
        "color10": "#9ece6a",
        "color11": "#e0af68",
        "color12": "#7aa2f7",
        "color13": "#bb9af7",
        "color14": "#7dcfff",
        "color15": "#c0caf5"
    }
}
EOF
```

### Step 10: Install Neovim Plugin

```bash
cat > ~/dotfiles/.config/nvim/lua/plugins/tokyonight.lua <<'EOF'
return {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = true,
    config = function()
        require("tokyonight").setup({
            style = "night",
            transparent = true,
        })
    end,
}
EOF
```

### Step 11: Test

```bash
cd ~/projects/theme-switcher
./scripts/theme-switch tokyo-night
```

**Expected:**
- ✅ All SUCCESS messages
- ✅ No errors
- ✅ Hyprland borders change color
- ✅ Terminal shows Tokyo Night colors

### Step 12: Verify in Applications

1. **Reload Ghostty:** `Ctrl+Shift+,`
   - Terminal colors should be Tokyo Night blues/purples

2. **Restart Neovim:** `nvim test.txt`
   - Syntax highlighting should be Tokyo Night
   - Check: `:echo g:colors_name` → should show `tokyonight`

3. **Launch Rofi:** `rofi -show drun`
   - Should show Tokyo Night blue theme

4. **Check Hyprland:** Window borders should be cyan/blue

---

## Testing Checklist

After creating a new theme, test each component:

### Basic Functionality
- [ ] Theme appears in rofi menu: `./scripts/theme-switch`
- [ ] No errors when applying: `./scripts/theme-switch <theme-name>`
- [ ] All SUCCESS messages appear

### Neovim
- [ ] Restart neovim
- [ ] Check colorscheme loaded: `:echo g:colors_name`
- [ ] Syntax highlighting looks correct
- [ ] Lualine matches theme colors

### Ghostty
- [ ] Reload config: `Ctrl+Shift+,`
- [ ] Terminal colors match theme
- [ ] Fish prompt inherits correct colors

### Hyprland
- [ ] Window borders show active color
- [ ] No parsing errors: `hyprctl reload`
- [ ] Colors look correct

### Rofi
- [ ] Launch rofi: `rofi -show drun`
- [ ] Theme colors applied
- [ ] Selected item highlights correctly

### Hyprpanel
- [ ] Panel colors match theme
- [ ] No visual glitches

### Starship
- [ ] Open new terminal
- [ ] Prompt uses theme colors
- [ ] Arrows and symbols visible

---

## Troubleshooting

### Error: "Config file not found"

**Cause:** `config.json` missing or in wrong location

**Fix:**
```bash
# Check file exists
ls themes/<theme-name>/config.json

# Validate JSON
jq . < themes/<theme-name>/config.json
```

### Error: "Hyprland colors file not found"

**Cause:** Filename in config.json doesn't match actual file

**Fix:**
```bash
# Check config.json
jq -r '.apps.hyprland.colors_file' themes/<theme-name>/config.json

# Check actual file
ls themes/<theme-name>/*.conf

# Make sure names match exactly
```

### Neovim: "E185: Cannot find colorscheme"

**Cause:** Plugin not installed or colorscheme name wrong

**Fix:**
```bash
# Check plugin installed
ls ~/.local/share/nvim/lazy/ | grep <plugin>

# Check colorscheme name in plugin docs
# Update config.json with correct name
```

### Ghostty: Theme not applying

**Cause:** Theme name doesn't match exactly (case-sensitive)

**Fix:**
```bash
# List all themes
ghostty +list-themes

# Find exact name (case-sensitive!)
ghostty +list-themes | grep -i <theme>

# Update config.json with exact name
```

### Hyprland: "Parsing error at line X"

**Cause:** Missing `$teal` or `$surface2`, or syntax error

**Fix:**
```bash
# Check variables defined
grep -E '(\$teal|\$surface2)' themes/<theme-name>/<theme-name>.conf

# Must have both lines:
# $teal = rgb(XXXXXX)
# $surface2 = rgb(XXXXXX)
```

### Rofi: Theme looks broken

**Cause:** Color variables not defined or syntax error

**Fix:**
```bash
# Test rofi config
rofi -theme ~/.config/rofi/theme.rasi -show drun

# Check for errors in output
# Verify all color variables are defined at top of .rasi file
```

---

## Quick Reference: Color Sources

### Where to find theme colors:

1. **Official GitHub repo** - Check README, colors.yml, or palette files
2. **Alacritty configs** - Search "alacritty <theme-name>"
3. **Kitty configs** - Search "kitty <theme-name>"
4. **Terminal.sexy** - Import from other formats
5. **Base16 themes** - https://github.com/chriskempson/base16
6. **Gogh** - https://gogh-co.github.io/Gogh/ (terminal color schemes)

### Color format conversion:

```bash
# Hex to rgb(XXXXXX) for Hyprland:
#1a1b26 → rgb(1a1b26)  # Remove the #

# Keep # for pywal colors.json:
"color0": "#1a1b26"  # Keep the #
```

---

## Summary

**For each new theme:**

1. ✅ Create theme directory
2. ✅ Write `config.json` with all mappings
3. ✅ Create Hyprland `.conf` with 16 colors + $teal + $surface2
4. ✅ Create Rofi `.rasi` theme
5. ✅ Copy/create Hyprpanel `hyprpanel.json`
6. ✅ Create pywal `colors.json`
7. ✅ Add neovim plugin if needed
8. ✅ Test with `./scripts/theme-switch <theme-name>`
9. ✅ Verify in each application

**That's it!** The theme system handles the rest automatically.

---

**Questions or issues?** Check the troubleshooting section or review existing themes as examples.
