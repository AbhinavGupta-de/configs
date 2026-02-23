#!/bin/bash
# Dotfiles installer - installs dependencies and symlinks configs
# Usage: ./install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==========================================="
echo "  Dotfiles Installer"
echo "  Source: $DOTFILES_DIR"
echo "==========================================="
echo ""

# ---------------------------------------------------------------------------
# Helper: create symlink with backup
# ---------------------------------------------------------------------------
link_file() {
    local src="$1"
    local dest="$2"

    if [ -L "$dest" ]; then
        local current_target
        current_target="$(readlink "$dest")"
        if [ "$current_target" = "$src" ]; then
            echo "  [skip] $dest (already linked)"
            return
        fi
        echo "  [update] $dest (repointing symlink)"
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "  [backup] $dest -> ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "  [linked] $dest -> $src"
}

# ---------------------------------------------------------------------------
# 1. Homebrew
# ---------------------------------------------------------------------------
echo "=== Homebrew ==="
if ! command -v brew &>/dev/null; then
    echo "  Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add brew to PATH for the rest of this script
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "  [skip] Homebrew already installed"
fi
echo ""

# ---------------------------------------------------------------------------
# 2. Brew packages
# ---------------------------------------------------------------------------
echo "=== CLI tools (brew) ==="
BREW_PACKAGES=(
    starship    # prompt
    fzf         # fuzzy finder
    zoxide      # better cd
    eza         # better ls
    bat         # better cat
    fd          # better find
    ripgrep     # better grep
    zellij      # terminal multiplexer
    neovim      # editor
)

for pkg in "${BREW_PACKAGES[@]}"; do
    if brew list "$pkg" &>/dev/null; then
        echo "  [skip] $pkg already installed"
    else
        echo "  Installing $pkg..."
        brew install "$pkg"
    fi
done
echo ""

# ---------------------------------------------------------------------------
# 3. Cask apps
# ---------------------------------------------------------------------------
echo "=== Cask apps ==="
BREW_CASKS=(
    nikitabobko/tap/aerospace   # tiling window manager
    font-jetbrains-mono-nerd-font
    font-meslo-lg-nerd-font
)

for cask in "${BREW_CASKS[@]}"; do
    # For tapped casks, extract the short name for checking
    short_name="${cask##*/}"
    if brew list --cask "$short_name" &>/dev/null 2>&1; then
        echo "  [skip] $short_name already installed"
    else
        echo "  Installing $short_name..."
        brew install --cask "$cask" 2>/dev/null || brew install "$cask" 2>/dev/null || echo "  [warn] Failed to install $short_name, skipping"
    fi
done
echo ""

# ---------------------------------------------------------------------------
# 4. Oh My Zsh
# ---------------------------------------------------------------------------
echo "=== Oh My Zsh ==="
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "  [skip] Oh My Zsh already installed"
else
    echo "  Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi
echo ""

# ---------------------------------------------------------------------------
# 5. Zsh plugins
# ---------------------------------------------------------------------------
echo "=== Zsh plugins ==="
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

declare -A ZSH_PLUGINS=(
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions"
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting"
    [zsh-completions]="https://github.com/zsh-users/zsh-completions"
)

for plugin in "${!ZSH_PLUGINS[@]}"; do
    plugin_dir="$ZSH_CUSTOM/plugins/$plugin"
    if [ -d "$plugin_dir" ]; then
        echo "  [skip] $plugin already installed"
    else
        echo "  Installing $plugin..."
        git clone "${ZSH_PLUGINS[$plugin]}" "$plugin_dir"
    fi
done
echo ""

# ---------------------------------------------------------------------------
# 6. Vim-plug
# ---------------------------------------------------------------------------
echo "=== Vim-plug ==="
if [ -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "  [skip] vim-plug already installed"
else
    echo "  Installing vim-plug..."
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "  NOTE: Open vim and run :PlugInstall"
fi
echo ""

# ---------------------------------------------------------------------------
# 7. Symlinks
# ---------------------------------------------------------------------------
echo "=== Shell configs ==="
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"

echo ""
echo "=== Vim configs ==="
link_file "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/.ideavimrc" "$HOME/.ideavimrc"

echo ""
echo "=== Neovim configs ==="
# Symlink the entire nvim config directory
if [ -L "$HOME/.config/nvim" ]; then
    current_target="$(readlink "$HOME/.config/nvim")"
    if [ "$current_target" = "$DOTFILES_DIR/.config/nvim" ]; then
        echo "  [skip] $HOME/.config/nvim (already linked)"
    else
        echo "  [update] $HOME/.config/nvim (repointing symlink)"
        rm "$HOME/.config/nvim"
        ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
        echo "  [linked] $HOME/.config/nvim -> $DOTFILES_DIR/.config/nvim"
    fi
elif [ -e "$HOME/.config/nvim" ]; then
    echo "  [backup] $HOME/.config/nvim -> $HOME/.config/nvim.backup"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.backup"
    ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
    echo "  [linked] $HOME/.config/nvim -> $DOTFILES_DIR/.config/nvim"
else
    mkdir -p "$HOME/.config"
    ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
    echo "  [linked] $HOME/.config/nvim -> $DOTFILES_DIR/.config/nvim"
fi

echo ""
echo "=== Git configs ==="
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.config/git/ignore" "$HOME/.config/git/ignore"

echo ""
echo "=== Starship prompt ==="
link_file "$DOTFILES_DIR/.config/starship/starship.toml" "$HOME/.config/starship.toml"

echo ""
echo "=== Zellij ==="
link_file "$DOTFILES_DIR/.config/zellij/config.kdl" "$HOME/.config/zellij/config.kdl"

echo ""
echo "=== AeroSpace (tiling WM) ==="
link_file "$DOTFILES_DIR/.config/aerospace/aerospace.toml" "$HOME/.aerospace.toml"

echo ""
echo "=== Ghostty ==="
link_file "$DOTFILES_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

echo ""
echo "=== VS Code ==="
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_DIR" ] || [ -d "/Applications/Visual Studio Code.app" ]; then
    mkdir -p "$VSCODE_DIR"
    link_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
else
    echo "  [skip] VS Code not found"
fi

echo ""
echo "==========================================="
echo "  All done!"
echo "==========================================="
echo ""
echo "Remaining manual steps:"
echo "  1. Edit ~/.gitconfig and set your name/email"
echo "  2. Open vim and run :PlugInstall (if using vim plugins)"
echo "  3. Open nvim - LazyVim will auto-install everything on first launch"
echo "  4. Run: source ~/.zshrc"
echo ""
