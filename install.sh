#!/usr/bin/env bash

# Theme Switcher Installation Script
# Sets up symlinks, templates, and integrations

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Theme Switcher Installation        ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}"
echo ""

# Check dependencies
log_info "Checking dependencies..."
MISSING_DEPS=()

for cmd in wal hyprctl rofi; do
    if ! command -v "$cmd" &> /dev/null; then
        MISSING_DEPS+=("$cmd")
    fi
done

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
    log_warn "Missing dependencies: ${MISSING_DEPS[*]}"
    log_info "Install with: sudo pacman -S python-pywal hyprland rofi"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    log_success "All dependencies installed"
fi

# Create necessary directories
log_info "Creating directories..."
mkdir -p "$HOME/.config/wal/templates"
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/rofi"
mkdir -p "$HOME/.config/dunst"
log_success "Directories created"

# Update Hyprland config to source generated colors
log_info "Updating Hyprland configuration..."
HYPR_CONFIG="$HOME/dotfiles/.config/hypr/hyprland.conf"

if [ -f "$HYPR_CONFIG" ]; then
    # Check if already sources colors.conf
    if ! grep -q "source.*colors.conf" "$HYPR_CONFIG"; then
        log_info "Adding color source to Hyprland config..."
        # Comment out the old mocha.conf line if it exists
        sed -i 's/^source = ~\/.config\/hypr\/mocha.conf/# source = ~\/.config\/hypr\/mocha.conf  # Replaced by theme-switcher/' "$HYPR_CONFIG"
        # Add the new colors.conf source at the top
        sed -i '1i # Theme colors (managed by theme-switcher)\nsource = ~/.config/hypr/colors.conf\n' "$HYPR_CONFIG"
        log_success "Updated Hyprland config"
    else
        log_info "Hyprland config already configured"
    fi
else
    log_warn "Hyprland config not found at $HYPR_CONFIG"
fi

# Update Ghostty config to source colors
log_info "Updating Ghostty configuration..."
GHOSTTY_CONFIG="$HOME/dotfiles/.config/ghostty/config"

if [ -f "$GHOSTTY_CONFIG" ]; then
    if ! grep -q "import.*colors" "$GHOSTTY_CONFIG"; then
        log_info "Adding color import to Ghostty config..."
        echo "" >> "$GHOSTTY_CONFIG"
        echo "# Theme colors (managed by theme-switcher)" >> "$GHOSTTY_CONFIG"
        echo "import = ~/.config/ghostty/colors" >> "$GHOSTTY_CONFIG"
        log_success "Updated Ghostty config"
    else
        log_info "Ghostty config already configured"
    fi
else
    log_warn "Ghostty config not found at $GHOSTTY_CONFIG"
fi

# Update Rofi config to use theme
log_info "Updating Rofi configuration..."
ROFI_CONFIG="$HOME/dotfiles/.config/rofi/config.rasi"

if [ -f "$ROFI_CONFIG" ]; then
    if ! grep -q "import.*theme.rasi" "$ROFI_CONFIG" && ! grep -q "@theme.*theme.rasi" "$ROFI_CONFIG"; then
        log_info "Adding theme import to Rofi config..."
        echo "" >> "$ROFI_CONFIG"
        echo "// Theme colors (managed by theme-switcher)" >> "$ROFI_CONFIG"
        echo "@theme \"~/.config/rofi/theme.rasi\"" >> "$ROFI_CONFIG"
        log_success "Updated Rofi config"
    else
        log_info "Rofi config already configured"
    fi
else
    log_warn "Rofi config not found at $ROFI_CONFIG"
fi

# Update Fish config to source colors
log_info "Updating Fish configuration..."
FISH_CONFIG="$HOME/dotfiles/.config/fish/config.fish"

if [ -f "$FISH_CONFIG" ]; then
    if ! grep -q "source.*wal/fish-colors.fish" "$FISH_CONFIG"; then
        log_info "Adding color source to Fish config..."
        echo "" >> "$FISH_CONFIG"
        echo "# Theme colors (managed by theme-switcher)" >> "$FISH_CONFIG"
        echo "if test -e ~/.cache/wal/fish-colors.fish" >> "$FISH_CONFIG"
        echo "    source ~/.cache/wal/fish-colors.fish" >> "$FISH_CONFIG"
        echo "end" >> "$FISH_CONFIG"
        log_success "Updated Fish config"
    else
        log_info "Fish config already configured"
    fi
else
    log_warn "Fish config not found at $FISH_CONFIG"
fi

# Create symlink for easy access
log_info "Creating symlink for theme-switch..."
mkdir -p "$HOME/.local/bin"
ln -sf "$SCRIPT_DIR/scripts/theme-switch" "$HOME/.local/bin/theme-switch"
log_success "Created symlink: ~/.local/bin/theme-switch"

# Add to PATH if not already there
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    log_warn "~/.local/bin is not in your PATH"
    log_info "Add this to your Fish config:"
    echo "  set -U fish_user_paths \$HOME/.local/bin \$fish_user_paths"
fi

echo ""
log_success "Installation complete!"
echo ""
log_info "Usage:"
echo "  1. Run 'theme-switch' to select and apply a theme"
echo "  2. Run 'theme-switch <theme-name>' to apply a specific theme"
echo ""
log_info "Available themes:"
for theme in "$SCRIPT_DIR/themes"/*; do
    if [ -d "$theme" ]; then
        echo "  - $(basename "$theme")"
    fi
done
echo ""
log_info "After changing themes, you may need to:"
echo "  - Reload dotfiles: cd ~/dotfiles && ./link.sh"
echo "  - Restart some applications for full effect"
echo ""
