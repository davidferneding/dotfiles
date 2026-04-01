#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add to PATH for the remainder of this script
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Dependencies
echo "Installing dependencies..."

## CLI tools
brew install tmux
brew install neovim
brew install lf
brew install java
brew install borkdude/brew/babashka
brew install gum

## Apps
brew install --cask wezterm
brew install --cask nikitabobko/tap/aerospace

brew tap FelixKratz/formulae
brew install sketchybar
brew install borders

## Fonts
echo "Installing fonts..."

### monaspace
MONASPACE_API=$(curl -fsSL "https://api.github.com/repos/githubnext/monaspace/releases/latest")
MONASPACE_TMP=$(mktemp -d)

for variant in static variable nerdfonts; do
  URL=$(echo "$MONASPACE_API" | grep "browser_download_url" | grep "$variant" | grep -v "webfont" | sed 's/.*"browser_download_url": "\(.*\)".*/\1/')
  curl -fsSL "$URL" -o "$MONASPACE_TMP/$variant.zip"
  unzip -q "$MONASPACE_TMP/$variant.zip" -d "$MONASPACE_TMP/$variant"
done

find "$MONASPACE_TMP" \( -name "*.otf" -o -name "*.ttf" \) -exec cp {} "$HOME/Library/Fonts/" \;
rm -rf "$MONASPACE_TMP"

### sketchybar app font
brew install --cask font-sketchybar-app-font

# Shell
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Symlinks
echo "Creating links..."
ln -f "$DOTFILES/.zshrc"     "$HOME/.zshrc"
ln -f "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
ln -f "$DOTFILES/.ideavimrc" "$HOME/.ideavimrc"

gum style \
  'Setup complete!' \
  'Close this terminal and open WezTerm now.' \
  --border rounded \
  --align center \
  --margin "1 1" \
  --padding "0 2" \
  --foreground "#c6d0f5" \
  --border-foreground "#eebebe"
