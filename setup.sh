#!/bin/bash
set -e

###
# Run after installing nix.
###

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Nix
if [[ ! -f "$DOTFILES/nix/local.nix" ]]; then
  echo "Creating nix/local.nix..."
  case "$(uname -sm)" in
    "Darwin arm64") NIX_SYSTEM="aarch64-darwin" ;;
    "Darwin x86_64") NIX_SYSTEM="x86_64-darwin" ;;
    "Linux aarch64") NIX_SYSTEM="aarch64-linux" ;;
    "Linux x86_64") NIX_SYSTEM="x86_64-linux" ;;
    *) echo "Unsupported platform: $(uname -sm)" >&2; exit 1 ;;
  esac
  cat > "$DOTFILES/nix/local.nix" <<EOF
{
  username = "$USER";
  homeDirectory = "$HOME";
  system = "$NIX_SYSTEM";
}
EOF
fi
echo "Applying Home Manager configuration..."
nix run home-manager/master -- switch --flake "path:$DOTFILES/nix#default"

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add to PATH for the remainder of this script
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Dependencies
echo "Installing dependencies..."

"$HOME/.nix-profile/bin/rustup" default stable

## CLI tools
brew install tmux
brew install neovim
brew install lf
brew install borkdude/brew/babashka
brew install gum
brew install powerlevel10k
brew install thefuck
brew install fzf
brew install tree-sitter tree-sitter-cli
brew install kubectl

## Apps
brew install --cask wezterm
brew install --cask nikitabobko/tap/aerospace

brew tap FelixKratz/formulae
brew install sketchybar
brew install borders

## Fonts
### monaspace (static, variable and nerdfonts from GitHub releases)
echo "Installing Monaspace fonts..."
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
