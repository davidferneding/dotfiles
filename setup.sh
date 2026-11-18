#!/bin/bash
set -e

###
# Run after installing nix and adding an entry for the current user.
###

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Nix
echo "Applying Home Manager configuration..."
nix run home-manager/master -- switch --flake "$DOTFILES/nix"
"$HOME/.nix-profile/bin/rustup" default stable

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add to PATH for the remainder of this script
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install --cask wezterm
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install sketchybar

# Seed theme
echo "Copying default theme files..."
cp -r "$DOTFILES/catppuccin/examples/." "$DOTFILES/"

gum style \
  'Setup complete!' \
  'Close this terminal and open WezTerm now.' \
  --border rounded \
  --align center \
  --margin "1 1" \
  --padding "0 2" \
  --foreground "#c6d0f5" \
  --border-foreground "#eebebe"
