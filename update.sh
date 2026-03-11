#!/usr/bin/env bash
#   ____ _   _  ___  ____ _____ _______   __
#  / ___| | | |/ _ \/ ___|_   _|_   _\ \ / /
# | |  _| |_| | | | \___ \ | |   | |  \ V /
# | |_| |  _  | |_| |___) || |   | |   | |
#  \____|_| |_|\___/|____/ |_|   |_|   |_|
#
# -----------------------------------------------------
# MyGhostty Update Script
# -----------------------------------------------------

set -e

# --- Colors ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# --- UI ---
info()    { echo -e "${BLUE}[UPDATE]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

TOTAL_STEPS=4
CURRENT_STEP=1
step_info() { echo -e "\n${BLUE}[UPDATE]${NC} [Step ${CURRENT_STEP}/${TOTAL_STEPS}] $1"; ((CURRENT_STEP++)); }

# --- Paths ---
CONFIG_DIR="$HOME/.config/ghostty"
REPO_DIR="$HOME/.cache/myghostty"
REPO_URL="https://github.com/devSagarSardar/MyGhostty.git"

info "Starting MyGhostty update..."

# --- Pull latest repo ---

step_info "Pulling latest repository"
if [[ -d "$REPO_DIR/.git" ]]; then
    info "Pulling latest changes..."
    git -C "$REPO_DIR" fetch --all
    git -C "$REPO_DIR" reset --hard origin/HEAD
    success "Repository updated"
else
    warn "Cached repo not found. Re-cloning..."
    rm -rf "$REPO_DIR"
    git clone --depth 1 "$REPO_URL" "$REPO_DIR"
    success "Repository cloned"
fi

# --- Update config ---

step_info "Updating Config & config.d"
if [[ -d "$CONFIG_DIR" ]]; then
    if [[ -d "$CONFIG_DIR/config.d" ]]; then
        BACKUP_D="$CONFIG_DIR/config.d.bak.$(date +%Y%m%d_%H%M%S)"
        warn "Backing up existing config.d → $BACKUP_D"
        mv "$CONFIG_DIR/config.d" "$BACKUP_D"
    fi

    if [[ -f "$CONFIG_DIR/config" ]]; then
        BACKUP="$CONFIG_DIR/config.bak.$(date +%Y%m%d_%H%M%S)"
        warn "Backing up existing config → $BACKUP"
        cp "$CONFIG_DIR/config" "$BACKUP"
    fi

    cp "$REPO_DIR/config" "$CONFIG_DIR/config"
    cp -r "$REPO_DIR/config.d" "$CONFIG_DIR/config.d"
    success "Config updated"
else
    warn "Ghostty config directory not found. Skipping config update."
fi

# --- Update themes ---

step_info "Updating Themes"
if [[ -d "$CONFIG_DIR/themes/ml4w-matugen" ]]; then
    info "Updating ml4w-matugen theme..."
    cp -r "$REPO_DIR/themes/ml4w-matugen" "$CONFIG_DIR/themes/"
    success "Theme updated"
else
    warn "ml4w-matugen theme not installed. Skipping theme update."
fi

# --- Re-apply shell integration ---

step_info "Re-applying Shell Integration"
if [[ -f "$CONFIG_DIR/config.d/core.conf" ]]; then
    shell_name=$(basename "$SHELL")
    sed -i "s/^shell-integration = .*/shell-integration = $shell_name/" "$CONFIG_DIR/config.d/core.conf"
    success "Shell integration set to $shell_name"
fi

echo ""
success "MyGhostty update complete!"
