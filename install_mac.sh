# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tools/Shell/Misc
brew install tmux
brew install borkdude/brew/babashka

# Apps
brew install --cask firefox@developer-edition

brew install --cask wezterm

brew install neovim

brew install --cask nikitabobko/tap/aerospace
cp ~/aerospace/aerospace.toml.default ~/aerospace/aerospace.toml

brew tap FelixKratz/formulae
brew install sketchybar
brew install borders

brew install lf
