#!/usr/bin/env bash
#   ____ _   _  ___  ____ _____ _______   __
#  / ___| | | |/ _ \/ ___|_   _|_   _\ \ / /
# | |  _| |_| | | | \___ \ | |   | |  \ V /
# | |_| |  _  | |_| |___) || |   | |   | |
#  \____|_| |_|\___/|____/ |_|   |_|   |_|
#
# -----------------------------------------------------
# Ghostty Installation Script
# -----------------------------------------------------
sleep 1

set -e

# --- Colors ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

TAG="0.1.0"

# --- UI ---
info() { echo -e "${BLUE}[BOOTSTRAP]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# --- Directory Setup ---
CONFIG_DIR="$HOME/.config/ghostty"
REPO_DIR="$HOME/.cache/myghostty"
REPO_URL="https://github.com/devSagarSardar/MyGhostty.git"

# --- Script Initialization ---
info "Starting Ghostty Installation..."

# --- Distro Detection & Ghostty Installation ---

if command -v ghostty >/dev/null 2>&1; then
    success "Ghostty already installed"
else
    warn "Ghostty not found"

    read -rp "Install Ghostty? (y/n): " install
    install=${install,,}

    if [[ $install == "y" ]]; then
        if command -v pacman &> /dev/null; then
            DISTRO="arch"
            info "$DISTRO detected. Installing base dependencies..."
            sudo pacman -S --needed --noconfirm git ghostty
            success "Ghostty installation complete"
         elif command -v dnf &> /dev/null; then
            DISTRO="fedora"
            info "$DISTRO detected. Installing base dependencies..."
            sudo dnf install -y git ghostty
            success "Ghostty installation complete"
        elif command -v zypper &> /dev/null; then
            DISTRO="opensuse"
            info "$DISTRO detected. Installing base dependencies..."
            sudo zypper install -y git ghostty
            success "Ghostty installation complete"
        elif command -v apt &> /dev/null; then
            DISTRO="debian"
            info "$DISTRO detected. Installing base dependencies..."
            sudo apt update && sudo apt install -y git ghostty
            success "Ghostty installation complete"
        else
            error "Unsupported distribution. Please install git & ghostty manually."
        fi
    else
        error "Ghostty required. Exiting."
    fi
fi

# --- Config Installation ---

read -rp "Install Ghostty config? (y/n): " config_choice
config_choice=${config_choice,,}

if [[ $config_choice == "y" ]]; then

    if [[ ! -d "$REPO_DIR" ]]; then 
        info "Downloading Ghostty configuration repository..." 
        git clone --depth 1 --branch "$TAG" "$REPO_URL" "$REPO_DIR" 
    fi

    mkdir -p "$CONFIG_DIR"

    if [[ -f "$CONFIG_DIR/config" ]]; then
        BACKUP="$CONFIG_DIR/config.bak.$(date +%Y%m%d_%H%M%S)"
        warn "Existing config detected. Creating backup: $BACKUP"
        cp "$CONFIG_DIR/config" "$BACKUP"
        success "Backup saved to: $BACKUP"
    fi

    cp "$REPO_DIR/config" "$CONFIG_DIR/config"

    success "Config installed to:"
    info "$CONFIG_DIR/config"

fi

# --- Theme Installation ---

read -rp "Install Matugen theme? (y/n): " theme_choice
theme_choice=${theme_choice,,}

if [[ $theme_choice == "y" ]]; then

    mkdir -p "$CONFIG_DIR/themes"

    cp -r "$REPO_DIR/themes/ml4w-matugen" "$CONFIG_DIR/themes/"

    success "Theme installed"

else

    warn "Skipping theme..."
    sed -i '/^theme *=/d' "$CONFIG_DIR/config"

fi

# --- Shell Detection & Shell Integration ---

shell_name=$(basename "$SHELL")

info "Detected shell: $shell_name"

sed -i "s/^shell-integration = .*/shell-integration = $shell_name/" "$CONFIG_DIR/config"

success "Shell integration set to $shell_name"

# --- Set Default Terminal ---

read -rp "Set Ghostty as default terminal? (y/n): " default_choice
default_choice=${default_choice,,}

if [[ $default_choice == "y" ]]; then

    if command -v update-alternatives >/dev/null 2>&1; then
        sudo update-alternatives --set x-terminal-emulator $(which ghostty)
    fi

    success "Ghostty set as default terminal"
else
    warn "Skipping default terminal setup..."
fi

echo ""
success "Ghosty setup complete!"


# --- Cleanup ---

read -rp "Remove installation folder? (y/n): " cleanup
cleanup=${cleanup,,}

if [[ $cleanup == "y" ]]; then

    cd ..
    rm -rf "$REPO_DIR"

    success "Installer folder removed."

else
    warn "Installer folder kept."
fi