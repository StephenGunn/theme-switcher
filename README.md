# Theme Switcher

Personal theme switcher for my Hyprland setup. Built because I wasn't a fan of pywal generating themes from wallpapers - my syntax highlighting looked bad. This uses actual color palettes (Gruvbox, Catppuccin, etc.) and applies them system-wide.



https://github.com/user-attachments/assets/93551a51-c37f-4a58-ad23-ff6dba13f8d9



## Why

- Wanted proper color palettes, not generated ones
- Match wallpapers to themes instead of themes to wallpapers
- Keep my Neovim syntax highlighting looking good
- Switch everything at once (Hyprland, terminal, rofi, notifications, etc.)

## Themes

- Gruvbox Dark
- Catppuccin Mocha
- Nord
- Tokyo Night
- Everforest
- Kanagawa Dark

Each theme has its own wallpaper folder.

## Setup

Built specifically for my setup, so it's pretty opinionated. You'll need:

```bash
sudo pacman -S jq python-pywal hyprland rofi waypaper swww
```

Add the script to your PATH or make an alias:

```bash
alias theme-switch='~/projects/theme-switcher/scripts/theme-switch'
```

Your Hyprland config needs to source the colors file:

```conf
source = ~/.config/hypr/colors.conf
```

Neovim needs to auto-load themes (add to init.lua):

```lua
local theme_file = vim.fn.stdpath("config") .. "/lua/current-theme.lua"
if vim.fn.filereadable(theme_file) == 1 then
    require("current-theme")
end
```

## Usage

```bash
# Interactive picker
theme-switch

# Or directly
theme-switch gruvbox-dark
```

Most apps reload automatically. Ghostty needs `Ctrl+Shift+,` to reload, Neovim needs a restart.

**Keybinds:**
- `Super+T` - Theme picker
- `Super+Y` - Wallpaper picker (waypaper)

## How It Works

Uses native themes where possible (Neovim colorscheme plugins, Ghostty built-ins, hand-crafted Hyprland configs), pywal for the rest (Starship, Dunst).

Each theme directory has:
```
themes/gruvbox-dark/
├── config.json           # Theme mappings
├── gruvbox-dark.conf     # Hyprland colors
├── gruvbox-dark.rasi     # Rofi theme
├── hyprpanel.json        # HyprPanel theme
├── colors.json           # Pywal colors (fallback apps)
└── wallpapers/           # Theme-matched wallpapers
```

Everything reloads automatically when you switch themes - Hyprland, HyprPanel, Dunst all pick up changes immediately. Ghostty and Neovim need manual restarts.

## Adding Themes

See [ADDING_THEMES.md](ADDING_THEMES.md) if you want to add your own. It's pretty straightforward - just create the directory structure and config files.

## Notes

Built for my specific setup, so it might be janky if you try to use it as-is. But the approach works well - native themes where possible, pywal as fallback. Feel free to fork and adapt it for your own workflow.
