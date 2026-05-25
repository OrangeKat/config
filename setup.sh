#!/bin/bash

# setup.sh - Dotfiles installation script using GNU Stow
# Supports macOS and Linux

set -e

# --- Configuration ---
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(
    stow
    neovim
    zsh
    eza
    vivid
    fzf
    git
    curl
    tmux
)

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# --- OS Detection ---
OS="$(uname)"
if [[ "$OS" == "Darwin" ]]; then
    IS_MACOS=true
    IS_LINUX=false
elif [[ "$OS" == "Linux" ]]; then
    IS_MACOS=false
    IS_LINUX=true
else
    error "Unsupported OS: $OS"
    exit 1
fi

# --- Package Manager ---
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Setup brew environment for the current session
        if [[ "$OS" == "Darwin" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
            test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
    fi
}

install_linux_prerequisites() {
    if $IS_LINUX; then
        info "Installing prerequisites for Homebrew..."
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y build-essential curl file git
        elif command -v pacman &> /dev/null; then
            sudo pacman -Syu --needed base-devel curl file git
        elif command -v dnf &> /dev/null; then
            sudo dnf groupinstall "Development Tools"
            sudo dnf install curl file git
        fi
    fi
}

install_packages() {
    install_linux_prerequisites
    install_homebrew

    info "Installing packages via Homebrew..."
    brew install "${PACKAGES[@]}"
    brew install jesseduffield/lazygit/lazygit

    if $IS_MACOS; then
        brew install --cask font-symbols-only-nerd-font
    else
        info "Note: For Linux, please install a Nerd Font manually (e.g., JetBrainsMono Nerd Font)."
    fi
}

install_oh_my_posh() {
    if ! command -v oh-my-posh &> /dev/null; then
        info "Installing Oh My Posh via Homebrew..."
        brew install jandedobbeleer/oh-my-posh/oh-my-posh
    fi
}

install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Plugins
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    fi
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    fi
}

install_tpm() {
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        info "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
}

setup_stow() {
    info "Setting up dotfiles with GNU Stow..."
    cd "$DOTFILES_DIR"

    # Create .config if it doesn't exist
    mkdir -p "$HOME/.config"

    # Remove existing files that might conflict (optional, but safer for stow)
    # Stow will refuse to link if a file already exists.
    # We can use --adopt to take over existing files, but that modifies the repo.
    # Or we can just backup existing ones.

    files=(
        ".zshrc"
        "ohmyposh-theme.omp.json"
    )

    for file in "${files[@]}"; do
        if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
            info "Backing up existing $file to $file.bak"
            mv "$HOME/$file" "$HOME/$file.bak"
        fi
    done

    # Handle .config directories separately to avoid clobbering the whole .config folder
    configs=("ghostty" "nvim" "zsh" "tmux")
    for cfg in "${configs[@]}"; do
        if [ -d "$HOME/.config/$cfg" ] && [ ! -L "$HOME/.config/$cfg" ]; then
            info "Backing up existing .config/$cfg to .config/$cfg.bak"
            mv "$HOME/.config/$cfg" "$HOME/.config/$cfg.bak"
        fi
    done

    # Finally, STOW!
    # -v: verbose, -R: restow (unlinks then links), -t: target
    stow -v -R -t "$HOME" .
}

# --- Execution ---
main() {
    install_packages
    install_oh_my_posh
    install_oh_my_zsh
    install_tpm
    setup_stow
    success "Setup complete! Please restart your terminal or run 'source ~/.zshrc'"
}

main
