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

TAG="0.1.2"

# --- UI ---
info() { echo -e "${BLUE}[BOOTSTRAP]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

TOTAL_STEPS=7
CURRENT_STEP=1
step_info() { echo -e "\n${BLUE}[BOOTSTRAP]${NC} [Step ${CURRENT_STEP}/${TOTAL_STEPS}] $1"; ((CURRENT_STEP++)); }

# --- Argument Parsing ---
AUTO_YES=false
MINIMAL=false

for arg in "$@"; do
    case $arg in
        --yes|-y)
            AUTO_YES=true
            ;;
        --minimal|-m)
            MINIMAL=true
            ;;
    esac
done

ask_yes_no() {
    local prompt="$1"
    local var_name="$2"
    if [[ "$AUTO_YES" == true ]]; then
        info "$prompt y (auto)"
        eval "$var_name='y'"
    else
        sleep 1
        read -rp "$prompt " input
        eval "$var_name=\"\${input,,}\""
    fi
}

# --- Directory Setup ---
CONFIG_DIR="$HOME/.config/ghostty"
REPO_DIR="$HOME/.cache/myghostty"
REPO_URL="https://github.com/devSagarSardar/MyGhostty.git"
BIN_DIR="$HOME/.local/bin"

# --- Script Initialization ---
info "Starting Ghostty Installation..."

# --- Distro Detection & Ghostty Installation ---

step_info "Ghostty Installation & Dependencies"
if command -v ghostty >/dev/null 2>&1; then
    success "Ghostty already installed"
else
    warn "Ghostty not found"

    ask_yes_no "Install Ghostty? (y/n):" install

    if [[ $install == "y" ]]; then
        if command -v pacman &> /dev/null; then
            DISTRO="arch"
            info "$DISTRO detected. Installing base dependencies..."
            sudo pacman -S --needed --noconfirm git ghostty
            success "Ghostty installation complete"
            info "Installing JetBrainsMono Nerd Font..."
            sudo pacman -S --needed --noconfirm ttf-jetbrains-mono-nerd
            success "JetBrainsMono Nerd Font installed"
        elif command -v dnf &> /dev/null; then
            DISTRO="fedora"
            info "$DISTRO detected. Installing base dependencies..."
            sudo dnf install -y git ghostty
            success "Ghostty installation complete"
            info "Installing JetBrainsMono Nerd Font..."
            sudo dnf install -y jetbrains-mono-fonts
            success "JetBrainsMono Nerd Font installed"
        elif command -v zypper &> /dev/null; then
            DISTRO="opensuse"
            info "$DISTRO detected. Installing base dependencies..."
            sudo zypper install -y git ghostty
            success "Ghostty installation complete"
            info "Installing JetBrainsMono Nerd Font..."
            sudo zypper install -y jetbrains-mono-fonts
            success "JetBrainsMono Nerd Font installed"
        elif command -v apt &> /dev/null; then
            DISTRO="debian"
            info "$DISTRO detected. Installing base dependencies..."
            sudo apt update && sudo apt install -y git ghostty
            success "Ghostty installation complete"
            info "Installing JetBrainsMono Nerd Font..."
            FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
            mkdir -p "$FONT_DIR"
            curl -fLo "/tmp/JetBrainsMono.zip" \
                "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
            unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR"
            fc-cache -fv
            rm /tmp/JetBrainsMono.zip
            success "JetBrainsMono Nerd Font installed"
        else
            error "Unsupported distribution. Please install git, ghostty & JetBrainsMono Nerd Font manually."
        fi
    else
        error "Ghostty required. Exiting."
    fi
fi

# --- Config Installation ---

step_info "Ghostty Configuration"
ask_yes_no "Install Ghostty config? (y/n):" config_choice

if [[ $config_choice == "y" ]]; then

    if [[ ! -d "$REPO_DIR" ]]; then 
        info "Downloading Ghostty configuration repository..." 
        git clone --depth 1 --branch "$TAG" "$REPO_URL" "$REPO_DIR" 
    fi

    if [[ -d "$CONFIG_DIR/config.d" ]]; then
        mv "$CONFIG_DIR/config.d" "$CONFIG_DIR/config.d.bak"
        warn "Existing config.d detected. Creating backup: $CONFIG_DIR/config.d.bak"
        success "Backup saved to: $CONFIG_DIR/config.d.bak"
    fi

    if [[ -f "$CONFIG_DIR/config" ]]; then
        mv "$CONFIG_DIR/config" "$CONFIG_DIR/config.bak"
        warn "Existing config detected. Creating backup: $CONFIG_DIR/config.bak"
        success "Backup saved to: $CONFIG_DIR/config.bak"
    else 
        mkdir -p "$CONFIG_DIR"
        success "Config directory created: $CONFIG_DIR"
    fi

    cp "$REPO_DIR/config" "$CONFIG_DIR/config"
    cp -r "$REPO_DIR/config.d" "$CONFIG_DIR/config.d"

    success "Config installed to:"
    info "$CONFIG_DIR/config"

fi

# --- Theme Installation ---

step_info "Theme Installation"
if [[ $config_choice == "y" ]]; then
    if [[ "$MINIMAL" == true ]]; then
        info "Install Matugen theme? (y/n): n (minimal mode)"
        theme_choice="n"
    else
        ask_yes_no "Install Matugen theme? (y/n):" theme_choice
    fi

    if [[ $theme_choice == "y" ]]; then

    mkdir -p "$CONFIG_DIR/themes"

    cp -r "$REPO_DIR/themes/ml4w-matugen" "$CONFIG_DIR/themes/"

    success "Theme installed"

    else

    warn "Skipping theme..."
    sed -i '/^theme *=/d' "$CONFIG_DIR/config.d/theme.conf"

    fi
else
    if [[ "$MINIMAL" == true ]]; then
        info "Install Matugen theme? (y/n): n (minimal mode)"
        theme_choice="n"
    else
        ask_yes_no "Install Matugen theme? (y/n):" theme_choice
    fi

    if [[ $theme_choice == "y" ]]; then
        if [[ ! -d "$CONFIG_DIR/themes" ]]; then
            mkdir -p "$CONFIG_DIR/themes"
            success "Theme directory created: $CONFIG_DIR/themes"
            sed -i '/^theme *=/d' "$CONFIG_DIR/config.d/theme.conf"
            success " Existing theme configuration removed"
        else
            mv "$CONFIG_DIR/themes" "$CONFIG_DIR/themes.bak"
            warn "Existing themes detected. Creating backup: $CONFIG_DIR/themes.bak"
            success "Backup saved to: $CONFIG_DIR/themes.bak"
            mkdir -p "$CONFIG_DIR/themes"
            success "Theme directory created: $CONFIG_DIR/themes"
            sed -i '/^theme *=/d' "$CONFIG_DIR/config.d/theme.conf"
            success " Existing theme configuration removed"
        fi
        cp -r "$REPO_DIR/themes/ml4w-matugen" "$CONFIG_DIR/themes/"
        success "Theme installed"
        # Add theme to config
        echo "theme = \"ml4w-matugen\"" >> "$CONFIG_DIR/config.d/theme.conf"
        success "Theme added to config"
    else
        warn "Skipping theme..."
    fi
fi

# --- Install myghostty-update command ---

step_info "Installing Update Script"
if [[ ! -d "$BIN_DIR" ]]; then
    mkdir -p "$BIN_DIR"
    success "Created $BIN_DIR"
fi
cp "$REPO_DIR/update.sh" "$BIN_DIR/myghostty-update"
chmod +x "$BIN_DIR/myghostty-update"
success "myghostty-update installed to $BIN_DIR/myghostty-update"

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    warn "~/.local/bin is not in your PATH."
    warn "Add this to your shell config (e.g. ~/.bashrc or ~/.zshrc):"
    echo -e "  ${BLUE}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
fi

# --- Shell Detection & Shell Integration ---

step_info "Shell Integration"
shell_name=$(basename "$SHELL")

info "Detected shell: $shell_name"

sed -i "s/^shell-integration = .*/shell-integration = $shell_name/" "$CONFIG_DIR/config.d/core.conf"

success "Shell integration set to $shell_name"

# --- Set Default Terminal ---

step_info "Default Terminal Setup"
ask_yes_no "Set Ghostty as default terminal? (y/n):" default_choice

if [[ $default_choice == "y" ]]; then

    if command -v update-alternatives >/dev/null 2>&1; then
        sudo update-alternatives --set x-terminal-emulator $(which ghostty)
    fi

    success "Ghostty set as default terminal"
else
    warn "Skipping default terminal setup..."
fi

# --- Cleanup ---

step_info "Cleanup"
ask_yes_no "Remove installation folder? (y/n):" cleanup

if [[ $cleanup == "y" ]]; then

    cd ..
    rm -rf "$REPO_DIR"

    success "Installer folder removed."

else
    warn "Installer folder kept."
fi

echo ""
success "Ghostty setup complete!"