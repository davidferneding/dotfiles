# Tools/Shell/Misc
brew install tmux
brew install java
brew install borkdude/brew/babashka
brew install gum

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Apps
brew install --cask firefox@developer-edition

brew install --cask wezterm

brew install neovim

brew install --cask nikitabobko/tap/aerospace

brew tap FelixKratz/formulae
brew install sketchybar
brew install borders

brew install lf

gum style 'All dependencies have been installed' 'Close this terminal and open wezterm now' \
    --border rounded \
    --align center \
    --margin "1 1" \
    --padding "0 2" \
    --foreground "#c6d0f5" \
    --border-foreground "#eebebe"
