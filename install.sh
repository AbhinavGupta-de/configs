#!/bin/bash
# Dotfiles installer - symlinks configs to their correct locations
# Usage: ./install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from: $DOTFILES_DIR"
echo ""

# Helper function to create symlink with backup
link_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "  Backing up existing $dest -> ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "  Linked $src -> $dest"
}

echo "=== Shell configs ==="
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"

echo ""
echo "=== Vim configs ==="
link_file "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"
link_file "$DOTFILES_DIR/.ideavimrc" "$HOME/.ideavimrc"

echo ""
echo "=== Git configs ==="
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/.config/git/ignore" "$HOME/.config/git/ignore"
echo "  NOTE: Edit ~/.gitconfig to set your name and email!"

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
echo "=== VS Code ==="
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_DIR" ]; then
    link_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
else
    echo "  VS Code not found, skipping..."
fi

echo ""
echo "=== Done! ==="
echo ""
echo "Post-install steps:"
echo "  1. Edit ~/.gitconfig and set your name/email"
echo "  2. Install Oh My Zsh: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
echo "  3. Install zsh plugins:"
echo "     git clone https://github.com/zsh-users/zsh-autosuggestions \$ZSH_CUSTOM/plugins/zsh-autosuggestions"
echo "     git clone https://github.com/zsh-users/zsh-syntax-highlighting \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
echo "     git clone https://github.com/zsh-users/zsh-completions \$ZSH_CUSTOM/plugins/zsh-completions"
echo "  4. Install CLI tools: brew install starship fzf fd eza bat ripgrep zoxide zellij"
echo "  5. Install vim-plug: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
echo "  6. Open vim and run :PlugInstall"
echo "  7. Install AeroSpace: brew install --cask nikitabobko/tap/aerospace"
echo "  8. Install fonts: brew install --cask font-jetbrains-mono font-meslo-lg-nerd-font"
